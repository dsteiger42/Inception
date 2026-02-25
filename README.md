This project has been created as part of the 42 curriculum by dsteiger.

DESCRIPTION:
    This project introduces us to a tool called Docker.
    Docker’s purpose is to package an application together with everything it needs to run (code, runtime, system libraries, config) into a container so it runs the same way everywhere.
    In Inception, we run three containers (NGINX, MariaDB and Wordpress) to run a full WordPress website with Nginx and MariaDB.

    Concepts:
        - Docker Image: Is a blueprint of an application. It's what contains all the code, dependencies, configurations, that will be used to run your program. Images are used to create containers.

        - Docker Container: A Docker container is a running instance of a Docker image. It is what actually runs the application.

        - Docker Volume: Files that store persistent data. They are independent of Docker containers. Ex: a database uses a volume to store its data.

        - Docker-Compose: Tool used to define and run multiple Docker containers together. It allows containers to communicate through a shared network.

        - NGINX: Intermediary server that connects the User with Wordpress.

        - Wordpress: Application that creates a website. It uses a database to store content.

        - MariaDB: Database that provides the content for Wordpress.

    Extra Concepts:
        ---VIRTUAL MACHINE VS DOCKER---

        Virtual Machines
            - Emulate an entire computer.
            - Each VM has its own operating system.
            - Heavy on resources (RAM, disk, boot time).
            - Slower to start.

        Docker
            - Virtualizes applications, not entire machines.
            - Containers share the host OS kernel.
            - Lightweight and fast.
            - Ideal for microservices.

        Design Choice:
            - Docker was chosen because it is lighter, faster, and more efficient than virtual machines, while still providing strong isolation between services.
            - VM was used to be done in a closed environment.



        --- Secrets vs Environment Variables ---

        Secrets:
            - Designed specifically for sensitive data.
            - Stored securely by Docker, not in images or source code.
            - Access is restricted at runtime.

        Environment Variables:
            - Store configuration values like ports, usernames, passwords, URLs.
            - Easy to use.
            - Stored in .env file.
            - Not secure for sensitive data if exposed.

        Design Choice:
            - This project uses environment variables via a .env file for simplicity.
            - In production, Docker secrets are recommended for sensitive values like passwords or API keys.



        ---Docker Network vs Host Network---

        Docker Network
            - Isolated internal network for containers.
            - Containers communicate using service names.
            - Better security and organization.

        Host Network
            - Containers use the host’s network directly.
            - No isolation.
            - Higher security risk.

        Design Choice:
            - A Docker bridge network is used to isolate services while allowing controlled communication between them.



        ---Docker Volumes vs Bind Mounts---

        Docker Volumes
            - Managed by Docker.
            - Portable across different hosts.

        Bind Mounts
            - Host-dependent paths.
            - Requires manual permission handling.

        Design Choice:
            - Bind mounts are used to store the database and WordPress data in this project. 
            - This allows direct access to the files on the host while still keeping data persistent between container restarts.

INSTRUCTIONS:

    - make prep: create volumes.
    - make build: build Docker images.
    - make up: start the services in the Docker-Compose file. Creates and starts the containers.
    - make down: stops containers.
    - make clean: deletes everything.
    - make fclean: deletes everything the subject tells us to delete before starting an evaluation.
    - make logs SERVICE="...": check a container's logs.
    - make exec SERVICE='...": enter inside a container.
    - make restart: restart containers.


RESOURCES:
    - Youtube: used to learn all the concepts related to Docker.
    - AI: was used mainly for the scripts and configuration files.
    - https://tuto.grademe.fr/inception/: provides a clear and easy to follow explanation of the project.


EXTRA:
    Example on how Docker can be helpful:
        Lets say I build a program using Python3.0, React, PHP8.2 etc...
        If you want to run my program in your computer, you'd need to have this languages/tools/frameworks/etc all installed.
        With Docker, all these installations come included automatically.