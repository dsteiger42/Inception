COMPOSE = docker-compose -f ./srcs/docker-compose.yml
VOLUMES = ./srcs/data/db ./srcs/data/wordpress
SERVICES = wordpress mariadb nginx
	
build:
	@echo "Building images..."
	$(COMPOSE) build

up:
	@echo "Creating containers..."
	$(COMPOSE) up -d

down:
	@echo "Stopping containers..."
	$(COMPOSE) down -v

clean:
	@echo "Cleaning Docker..."
	$(COMPOSE) down -v
	docker system prune -f

fclean:
	@echo "Cleaning everything..."
	-@docker stop $$(docker ps -qa) || true
	-@docker rm $$(docker ps -qa) || true
	-@docker rmi -f $$(docker images -qa) || true
	-@docker volume rm $$(docker volume ls -q) || true
	-@docker network rm $$(docker network ls -q) 2>/dev/null || true

logs:
	@echo "Check logs of a specific service (ex: make logs SERVICE=wordpress)"
	$(COMPOSE) logs -f $(SERVICE)

exec:
	@echo "Entering a container (ex: make exec SERVICE=mariadb)"
	$(COMPOSE) exec $(SERVICE) bash

restart: clean build up
	@echo "Reseting all containers..."