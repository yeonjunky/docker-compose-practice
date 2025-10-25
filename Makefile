COMPOSE = ./srcs/docker-compose.yml
DC = docker compose -f $(COMPOSE)

all:
	$(MAKE) up \

up:
	$(DC) up -d

stop:
	$(DC) stop

down:
	$(DC) down

ps:
	$(DC) ps

log:
	$(DC) logs -f

build:
	$(DC) up --build -d

remove_volume:
	$(DC) down -v

restart:
	$(DC) restart

.phony: all up stop down ps log build remove_volume restart
