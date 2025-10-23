all:
	$(MAKE) up

up:
	docker compose -f ./srcs/docker-compose.yml up -d

stop:
	docker compose -f ./srcs/docker-compose.yml stop

down:
	docker compose -f ./srcs/docker-compose.yml down

ps:
	docker compose -f ./srcs/docker-compose.yml ps

log:
	docker compose -f ./srcs/docker-compose.yml logs -f

build:
	docker compose -f ./srcs/docker-compose.yml up --build -d

remove_volume:
	docker compose -f ./srcs/docker-compose.yml down -v

.phony: all up stop down ps build
