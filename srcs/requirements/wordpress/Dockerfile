FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    ca-certificates wget unzip mariadb-client \
    php8.2-cli php8.2-fpm php8.2-mysql php8.2-gd php8.2-xml php8.2-mbstring \
    php8.2-zip php8.2-curl php8.2-intl php8.2-opcache curl

EXPOSE 9000

RUN mkdir -p /var/www/html \
    && chown -R www-data:www-data /var/www/html

RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf \
    && sed -i 's/^listen.allowed_clients/# &/' /etc/php/8.2/fpm/pool.d/www.conf || true

COPY ./tools/docker-entrypoint.sh /usr/local/bin/

COPY ./conf/wp-config.php /var/www/html/wp-config.php
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ARG WORDPRESS_VERSION
RUN wget -q -O wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

RUN wp core download --allow-root
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD ["php-fpm8.2", "-F"]
