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

.phony: all up stop down ps
