FROM debian:bookworm

ARG MYSQL_DATABASE MYSQL_USER

# Update package lists and install MariaDB server
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Expose the default MariaDB port
EXPOSE 3306

COPY ./conf/my.cnf /etc/mysql/my.cnf
# COPY ./tools/setupDb.sh ./
# RUN chmod +x ./setupDb.sh

COPY ./tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
