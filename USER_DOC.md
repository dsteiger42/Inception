Overview of Services

This project provides a Docker-based infrastructure composed of the following services:
    - WordPress website accessible via HTTPS.
    - WordPress administration panel.
    - MariaDB database.

All services run in separate Docker containers and communicate with each other through a dedicated Docker network.


Commands:
    - make prep: create volumes
    - make build: build Docker images
    - make up: start the services in the Docker-Compose file. Creates and starts the containers
    - make down: stops containers
    - make clean: deletes everything
    - make fclean: deletes everything the subject tells us to delete before starting an evaluation
    - make logs SERVICE="...": check a container's logs
    - make exec SERVICE='...": enter inside a container
    - make restart: restart containers
    - docker ps: check the containers


Accessing the Website and Admin Panel:
    Website:
        https://dsteiger.42.fr

    WordPress Admin Panel:
        https://dsteiger.42.fr/wp-admin


Credential Management

Project credentials are securely managed through:
    - Environment variables defined in the .env file.
    - No passwords or sensitive information are included in the Dockerfiles or project source code.
