FROM debian:bookworm

RUN apt-get update && apt-get install curl php-cli php-mysql -y

COPY ./tools/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 8080

WORKDIR /var/www/html

ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
