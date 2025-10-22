FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive
ENV MYSQL_ROOT_PASSWORD=rootpass
ENV MYSQL_DATABASE=mydb
ENV MYSQL_USER=myuser
ENV MYSQL_PASSWORD=mypass

RUN apt-get update && apt-get install -y mariadb-server

RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld

RUN service mariadb start && \
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'rootpass';" && \
    mysql -u root -prootpass -e "FLUSH PRIVILEGES;" && \
    service mariadb stop

RUN service mariadb start && \
    mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" && \
    mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" && \
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;" && \
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" && \
    mysql -e "FLUSH PRIVILEGES;" && \
    service mariadb stop

EXPOSE 3306

CMD ["mysqld_safe"]
