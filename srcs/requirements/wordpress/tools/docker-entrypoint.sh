#!/bin/sh
set -e

echo '[Entrypoint] checking /var/www/html'

# /var/www/html이 비어 있으면 이미지에 보관된 파일 복사
if [ ! -f /var/www/html/index.php ]; then
  if [ ! -f /tmp/wordpress.tar.gz ]; then
    echo '[Entrypoint] /tmp/wordpress.tar.gz file is missing. Downloading file...'
    wget -q -O /tmp/wordpress.tar.gz "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz"
  fi
  echo '[Entrypoint] /var/www/html is empty, unzip wordpress files...'
  tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 \
    && rm /tmp/wordpress.tar.gz \
    && chown -R www-data:www-data /var/www/html
  cp /tmp/wp-config/wp-config.php /var/www/html
  chown -R www-data:www-data /var/www/html || true
fi

echo '[Entrypoint] ended'

# 반드시 exec로 CMD 실행
exec "$@"
