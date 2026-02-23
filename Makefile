COMPOSE = docker-compose
VOLUMES = ./data/db ./data/wordpress
SERVICES = wordpress mariadb nginx phpmyadmin

# Criar diretórios de volumes se não existirem
prep:
	@echo "Creating Volumes directories..."
	mkdir -p $(VOLUMES)
	sudo chown -R 33:33 ./data/wordpress
	sudo chmod -R 755 ./data/wordpress
	
# Build das imagens
build: prep
	@echo "Building images..."
	$(COMPOSE) build

# Criar tudo
up: prep
	@echo "Creating containers..."
	$(COMPOSE) up -d

# Parar containers
down:
	@echo "Stopping containers..."
	$(COMPOSE) down -v

# Limpar tudo (containers, imagens, volumes não usados)
clean:
	@echo "Cleaning Docker..."
	$(COMPOSE) down -v
	docker system prune -f
	sudo rm -rf ./data

# Ver logs de um serviço
logs:
	@echo "Check logs of a specific service (ex: make logs SERVICE=wordpress)"
	$(COMPOSE) logs -f $(SERVICE)

# Entrar num container
exec:
	@echo "Entering a container (ex: make exec SERVICE=mariadb)"
	$(COMPOSE) exec $(SERVICE) bash

# Reiniciar containers
restart: clean build up
	@echo "Reseting all containers..."