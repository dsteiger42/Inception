FROM debian:oldstable

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y mariadb-client mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY tools/entry.sh /etc/entry.sh

RUN chmod +x /etc/entry.sh

EXPOSE 3306

ENTRYPOINT ["bash", "/etc/entry.sh"];