#!/bin/sh

set -e

echo "[Entrypoint] checking /var/www/html/adminer-${ADMINER_VERSION}.php"

if ! ls /var/www/html/adminer-${ADMINER_VERSION}.php; then
    mkdir -p /var/www/html
    curl -sSL -o /var/www/html/adminer-${ADMINER_VERSION}.php \
        https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php
    rm -f index.php
    cp /var/www/html/adminer-${ADMINER_VERSION}.php /var/www/html/index.php
fi

exec "$@"
