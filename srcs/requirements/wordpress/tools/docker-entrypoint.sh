#!/bin/sh
set -e

echo '[Entrypoint] checking /var/www/html'

if ! wp core is-installed 2>/dev/null; then
  wp core install --url=yeonjuki.42.fr --title=yeonjuki-inception --admin_user=yeonjunky --admin_password=password \
    --admin_email=yeonjunky@42.fr --skip-email --allow-root
  wp user create yeonjuki yeonjuki@42.fr --role=author --user_pass=password --allow-root
  chown -R www-data:www-data /var/www/html
fi

echo '[Entrypoint] ended'

exec "$@"
