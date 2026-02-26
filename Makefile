COMPOSE = docker-compose -f ./srcs/docker-compose.yml
VOLUMES = /home/dsteiger/data/mariadb /home/dsteiger/data/wordpress
SERVICES = wordpress mariadb nginx

prep:
	@echo "Creating Volumes directories..."
	mkdir -p $(VOLUMES)
	sudo chown -R 33:33 $(VOLUMES)
	sudo chmod -R 755 $(VOLUMES)
	
build: prep
	@echo "Building images..."
	$(COMPOSE) build

up: prep
	@echo "Creating containers..."
	$(COMPOSE) up -d

down:
	@echo "Stopping containers..."
	$(COMPOSE) down -v

clean:
	@echo "Cleaning Docker..."
	$(COMPOSE) down -v
	docker system prune -f
	sudo rm -rf $(VOLUMES)

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