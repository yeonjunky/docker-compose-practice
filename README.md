# *This project has been created as part of the 42 curriculum by yeonjuki*

# Description
This project consists of having you set up a small infrastructure composed of different services under specific rules. The whole project has to be done in a virtual machine. You have to use docker compose.

You then have to set up:
- NGINX container
- Wordpress + php-fpm container
- MariaDB container
- Wordpress database volume
- A volume that contains Wordpress website files
- A docker network

Bonus requirements
- Set up redis cache container for your wordpress container.
- Set up a FTP server conatainer
- Create a simple static website in the language of your choice except PHP
- Set up Adminer container.
- Set up a service of your choice that you think is useful.

# Instructions
Project dependencies
- Make
- Docker / Docker compose
- Git

## Installation
1. Download the project files by `git pull`
2. Make sure that Docker is installed on your computer.

    If not, [refer to this guide](https://docs.docker.com/engine/install/)
3. Make sure that Make is installed on your computer.

    If not, run the following command `sudo apt-get update && sudo apt-get install build-essential`
4. Add the following line `127.0.0.1   yeonjuki.42.fr` to `/etc/hosts` file.

    If the hostname on your machine is `yeonjuki.42.fr`, then change the IP to `127.0.1.1` to adhere to convention of Debian-based OSes.
5. You're all set. Just run `make` on your terminal.

# Resources
- [The difference between containers and virtual machines](https://aws.amazon.com/compare/the-difference-between-containers-and-virtual-machines/)
- [Docker guide](https://docs.docker.com/)
- [Nginx documentation](https://nginx.org/en/docs/index.html)
- [Mariadb documentation](https://mariadb.com/docs)
- [Wordpress documentation](https://wordpress.org/documentation/)
- [Redis documentation](https://redis.io/docs/latest/)
- [Adminer](https://www.adminer.org/en/)
- [FTP server wikipedia](https://en.wikipedia.org/wiki/FTP_server)
- [vsftpd ubuntu wiki](https://help.ubuntu.com/community/vsftpd)
- [IRC wikipedia](https://en.wikipedia.org/wiki/IRC)
- [ngircd documentation](https://ngircd.barton.de/documentation.php.en)
- [Python `http.server` module](https://docs.python.org/3/library/http.server.html)

# Project description
## Virtual machines vs Docker

## Secrets vs Environment Variables

## Docker Network vs Host Network

## Docker Volumes vs Bind Mounts
