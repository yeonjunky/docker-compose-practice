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
Both are deployment technologies that make your application independent from your computing environment.

Container: A package of software that includes an application's code plus all the libraries and dependencies it needs to run.

Containers run on top of the host OS. Thay share the host's OS kernel, and a container engine manages resources allocation and isolation. The container holds only what the application needs (libraries, dependencies, etc).

Virtural machine: A virtualized copy of a full physical machine - including its own complete operating system, hardware abstractions, and the applications running on it.

VMs rely on a hypervior layer that emulates an entire machine (virtual hardware). Each VM runs its own guest OS - isolated from other VMs and from the host OS.

## Secrets vs Environment Variables

### Environment Variables
Environment variables are key-value pairs passed to containers at runtime using `-e` flag or `environment:` section in compose files.

**Security concerns:**
- **Plain text exposure**: Values are visible in plain text via `docker inspect` command
- **Process exposure**: Accessible through `/proc/<pid>/environ` file system
- **Log leakage**: Can accidentally appear in application logs or error messages
- **Image exposure**: If hardcoded in Dockerfile, they persist in image layers and can be extracted
- **No encryption**: Stored and transmitted without encryption

**Appropriate use cases:**
- Non-sensitive configuration (ports, hostnames, debug flags)
- Development/testing environments
- Public configuration values

### Docker Secrets
Docker Secrets provide encrypted storage for sensitive data in Docker Swarm (or Kubernetes). Secrets are mounted as files in `/run/secrets/` directory inside containers.

**Security advantages:**
- **Encrypted at rest**: Stored encrypted in Swarm's Raft log
- **Encrypted in transit**: Transmitted over TLS-encrypted channels between nodes
- **Memory-only**: Mounted as tmpfs (memory filesystem), never written to disk
- **Access control**: Only accessible to services explicitly granted permission
- **No inspect exposure**: Secret values don't appear in `docker inspect` output
- **Minimal attack surface**: Not exposed through environment variables or process list

**Implementation requirements:**
- Requires Docker Swarm mode or Kubernetes
- Application must read secrets from `/run/secrets/<secret_name>` files
- Slightly more complex setup than environment variables

**Example comparison:**

Using environment variables (insecure):
```yaml
services:
  db:
    environment:
      - MYSQL_ROOT_PASSWORD=my_password
```

Using secrets (secure):
```yaml
services:
  db:
    secrets:
      - db_root_password

secrets:
  db_root_password:
    file: ./secrets/db_root_password.txt
```

**Best practice:** Use environment variables for non-sensitive configuration and Docker Secrets for all sensitive data (passwords, API keys, certificates) in production environments.

## Docker Network vs Host Network

Docker Network (Bridge) and Host Network represent two fundamentally different approaches to how containers connect to networks.

### Docker Network (Bridge Mode - Default)
Containers run in an **isolated virtual network** created by Docker.

**How it works:**
- Docker creates a virtual bridge network (default: `docker0`)
- Each container receives a unique virtual IP address (e.g., 172.17.0.x)
- Containers communicate with each other using container names or IPs
- Communication with host and external networks happens through NAT (Network Address Translation)

**Key characteristics:**
- **Network isolation**: Containers run in their own network namespace
- **Port mapping required**: Use `-p 8080:80` to map host port 8080 to container port 80
- **Security**: External access only through explicitly exposed ports
- **Flexibility**: Multiple containers can use the same internal port (e.g., port 80) with different host port mappings

### Host Network Mode
Container **directly shares the host's network stack** with no isolation.

**How it works:**
- Container uses the same network namespace as the host
- No virtual network or NAT layer
- Container's network interfaces are identical to the host's

**Key characteristics:**
- **No network isolation**: Container accesses all host network interfaces
- **No port mapping needed**: Container port 80 directly uses host port 80
- **Better performance**: No NAT overhead
- **Port conflicts**: Multiple containers cannot use the same port
- **Security risk**: Container has direct access to host network

**Example:**
```yaml
services:
  web:
    image: nginx
    network_mode: host
```

Access: `localhost:80` on both host and container (same)

### Comparison Table

| Aspect | Docker Network (Bridge) | Host Network |
|--------|------------------------|--------------|
| **Network isolation** | Yes (virtual network) | No (shares host) |
| **IP address** | Unique container IP | Uses host IP |
| **Port mapping** | Required (`-p` flag) | Not needed |
| **Port conflicts** | Avoided (isolated) | Possible |
| **Performance** | Slight NAT overhead | Optimal (no NAT) |
| **Security** | More secure (isolated) | Less secure (exposed) |
| **Container-to-container** | Via names/IPs | Via localhost |
| **Use case** | General applications | Specific performance needs |

### When to Use Each

**Use Docker Network (Recommended):**
- Web applications and microservices
- Running multiple containers on the same host
- When security and isolation are important
- When you need flexible port management

**Use Host Network (Special Cases):**
- Extreme network performance requirements (e.g., high-performance packet processing)
- Container needs access to all host network interfaces
- Legacy applications requiring localhost binding
- Network monitoring/debugging tools

**Best practice:** Use Docker's default bridge network unless you have a specific reason to use host networking. Bridge mode provides better security and flexibility.

## Docker Volumes vs Bind Mounts
Docker provides two primary mechanisms for persisting data generated and by Docker containers: volumes and bind mounts.

Both allow data to be stored outside the container's writable layer, ensuring data persistance even if the container is removed.

However, they differ in how they manage and access the data.

Volumes
- Docker managed
- Offering more features and protability
- Stored in Docker's designed area.
- More secure as they isolate container data from the host's filesystem

Bind Mounts
- User managed
- Providing direct control over host files
- Can be located anywhere on the host's filesystem
- Can expose host files, requiring careful consideration of permissions.
