This file must describe how a developer can:
- Set up the environment from scrach (prerequisites, configuration files, secrets)
- Build and launch the project using the Makefile and Docker compose
- Use relevant commands to manage the containers and volumes
- Identify where the project data is stores and how it persists

# Set up the environment from scrach (prerequisites, configuration files, secrets)
## Prerequisites
- Git
- Make
- Docker, Docker compose
- `yeonjuki.42.fr` must registered in `/etc/hosts`

## configuretion files and secrets
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

# Build and launch the project using the Makefile and Docker compose

## Build the project
- Makefile
    `make build` It builds container images and automatically runs the containers.
    `make up` builds the image when the image doesn't exist, and runs the containers.
- Docker compose
    Set the working directory where docker-compose.yml is located.
    `docker compose up --build` It builds container images and automatically runs the containers.
    `docker compose up` builds the image when the image doesn't exist, and runs the containers.

## Launch the project
- Makefile
    `make start` to launch the project.

- Docker compose
    `docker compose start` to launch the project.

# Use relevant commands to manage the containers and volumes

## containers
`docker compose ps` List running containers.

`docker compose restart [SERVICE...]` Restart the contianer.

`docker compose logs [SERVICE...]` Print the container logs.

`docker compose down` Stop and remove containers, networks

## volumes
`docker compose volumes` List volumes

`docker volume inspect` Display detailed information on one or more volumes

`docker volume ls` List volumes

`docker volume prune` Remove unused local volumes

`docker volume rm` Remove one or more volumes

# Identify where the project data is stores and how it persists
```
[
    {
        "CreatedAt": "2025-12-05T03:22:07-05:00",
        "Driver": "local",
        "Labels": {
            "com.docker.compose.config-hash": "b19df5c7f5ab6672051e1b1cc937c40d5018a52d17aac197c8d5aa2adfde2464",
            "com.docker.compose.project": "srcs",
            "com.docker.compose.version": "2.40.1",
            "com.docker.compose.volume": "db-volume"
        },
        "Mountpoint": "/var/lib/docker/volumes/srcs_db-volume/_data",
        "Name": "srcs_db-volume",
        "Options": {
            "device": "/home/yeonjuki/data/db-data", <- Wordpress-related database files are stores here.
            "o": "bind",
            "type": "none"
        },
        "Scope": "local"
    }
]
```

```
[
    {
        "CreatedAt": "2025-11-03T06:17:49-05:00",
        "Driver": "local",
        "Labels": {
            "com.docker.compose.config-hash": "eb77c81af093fa593b736c0fefd9e52200cf5408539d9e2e1c56085e349d30ff",
            "com.docker.compose.project": "srcs",
            "com.docker.compose.version": "2.40.1",
            "com.docker.compose.volume": "wp-volume"
        },
        "Mountpoint": "/var/lib/docker/volumes/srcs_wp-volume/_data",
        "Name": "srcs_wp-volume",
        "Options": {
            "device": "/home/yeonjuki/data/wp-data", <- WordPress-related PHP files are stored here.
            "o": "bind",
            "type": "none"
        },
        "Scope": "local"
    }
]
```

The container read and write the files in user's filesystem.