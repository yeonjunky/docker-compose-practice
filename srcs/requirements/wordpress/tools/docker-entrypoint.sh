#!/bin/sh
set -e

echo '[Entrypoint] checking /var/www/html'

if ! ls /var/www/html/wp-config.php >/dev/null; then
  echo '[Entrypoint] wp-config.php file is missing. copy the file'
  cp /tmp/wp-config.php /var/www/html/wp-config.php
fi

if ! wp core is-installed --allow-root 2>/dev/null; then
  echo '[Entrypoint] Wordpress files are missing. installing...'
  wp core download --force --version=6.8 --allow-root
  wp core install --url='http://yeonjuki.42.fr' --title=yeonjuki-inception --admin_user=yeonjunky --admin_password=password \
    --admin_email=yeonjunky@42.fr --skip-email --allow-root
  wp user create yeonjuki yeonjuki@42.fr --role=author --user_pass=password --allow-root
  chown -R www-data:www-data /var/www/html
fi

echo '[Entrypoint] ended'

exec "$@"
