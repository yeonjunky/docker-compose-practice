#!/bin/bash
set -e

# MariaDB 데이터 디렉터리 초기화
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "[Entrypoint] Initializing MariaDB data directory..."
    mariadb-install-db --user=root --datadir=/var/lib/mysql
fi

# MariaDB 서버 백그라운드로 시작
echo "[Entrypoint] Starting MariaDB (networking enabled)..."
mysqld_safe &
pid="$!"

# 서버가 완전히 시작될 때까지 대기
for i in {300..0}; do
    if mariadb -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "SHOW DATABASES" &>/dev/null; then
        break
    fi
    echo "[Entrypoint] Waiting for MariaDB to start..."
    sleep 1
done

if [ "$i" = 0 ]; then
    echo >&2 "[Entrypoint] MariaDB failed to start."
    exit 1
fi

mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" && \
mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" && \
mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;" && \
mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" && \
mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;" 

echo "[Entrypoint] Initialization complete. Restarting MariaDB in foreground."
echo "[Entrypoint] Stopping temporary MariaDB (started with --skip-networking)..."
# Try a graceful shutdown first, fall back to killing the background process if needed
if ! mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown >/dev/null 2>&1; then
    echo "[Entrypoint] mysqladmin shutdown failed; killing pid $pid"
    kill "$pid" 2>/dev/null || true
fi
wait "$pid" 2>/dev/null || true
echo "[Entrypoint] Starting MariaDB in foreground (networking enabled)."
exec mysqld
