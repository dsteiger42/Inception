Pre requisites

Before building and running the Inception project, make sure you have:
    - Docker installed.
    - Docker Compose installed.
    - A Linux Virtual Machine (mandatory according to the subject).
    - Access to the project folder with correct permissions.


Structure
    .
    ├── Makefile
    ├── README.md
    ├── USER_DOC.md
    ├── DEV_DOC.md
    └── srcs/
        ├── .env
        ├── docker-compose.yml
        └── requirements/
            ├── nginx/
            ├── wordpress/
            └── mariadb/

    srcs/: contains Dockerfiles, scripts, configuration files, and .env.
    Makefile: facilitates building and managing the infrastructure.


Create the .env file in the srcs/ folder with the configuration variables:
    DOMAIN_NAME=dsteiger.42.fr
    MYSQL_DATABASE=wordpress
    MYSQL_USER=wpuser
    WP_TITLE=Inception
    WP_ADMIN_USER=dsteiger42
    WP_ADMIN_EMAIL=student.42.fr
    WP_USER=editor42
    WP_USER_EMAIL=editor@student.42.fr


Create persistent data folders on the host:
    mkdir -p /home/dsteiger/data/mariadb
    mkdir -p /home/dsteiger/data/wordpress


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


Services and Ports:
    NGINX	443	443	TLS 1.2/1.3, single entry point.
    WordPress	-	9000	PHP-FPM, communicates internally with NGINX.
    MariaDB	-	3306	Internal access only (for WordPress).


Network:
    Name: inception
    Type: bridge


Provides:
    Internal communication between containers by service name.
    Isolation from the host system.
    Automatic internal DNS.


Security:
    Passwords are stored outside of the code (.env).
    TLS is configured only on NGINX (HTTPS enforced).
    Containers are isolated (no host network, no --link).
    One container per service.