This file must explain, in clear and simple terms, how an end user or adminstrator can:
- Understand what services are provided by the stack
- Start and stop the project
- Access the website and the administration panel
- Locate and manage credentials
- Check that the services are running correctly

# Understand what services are provided by the stack

## Services
- Nginx
    It provides a reverse proxy for the WordPress server.
- Wordpress
    The blog service.
- mariadb
    Database for Wordpress blog data.

## Bonus Services
- Adminer
    Database administration service.
- Redis cache
    In-memory cache database for the Wordpress.
- FTP server(vsftpd)
    File transfer service.
- IRC server(ngircd)
    Text based chat system for instant messaging.
- Static web server(Python http.server module)
    The server that serves the files without any changes.

## How to start / stop the server
Please read the README installation section before following the guide below.
1. Enter `make` in your terminal.

2. To stop the server, enter `make stop` in your terminal.

## Access the website and the administration panel
To access the website, enter https://yeonjuki.42.fr in your browser.

And, to access the admin panel, go to https://yeonjuki.42.fr/admin

## Locate and manage credentials
All environment variables(and credentials) located in {project_root_directory}/.env file.
And its template
```
# .env template
MYSQL_PW=
MYSQL_ROOT_PW=
MYSQL_DATABASE=
MYSQL_USER=
MYSQL_HOST=

WP_VERSION=
WP_TABLE_PREFIX=

DB_VOLUME=
WP_VOLUME=

FTP_USER=
FTP_GRUOP=
FTP_PASS=

ADMINER_VERSION=
ADMINER_USER=
ADMINER_PASSWORD=

REDIS_PASSWORD=
```

## Check that the services are running correctly
1. Enter `make ps` in your terminal and see the STATUS column.
2. If the container has a problem, it keeps restarting the container.
3. And there's a problem apart from the container internal issue; it hasn't started.
4. Otherwise, all containers must be running.
