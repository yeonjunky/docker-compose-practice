FROM debian:bookworm

RUN apt-get update && apt-get install redis-server -y

COPY ./conf/redis.conf /etc/redis/redis.conf
RUN chmod +r /etc/redis/redis.conf

COPY ./tools/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 6379

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "redis-server", "/etc/redis/redis.conf" ]
