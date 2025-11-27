FROM debian:oldstable

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y mariadb-client mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/conf.sh /etc/conf/conf.sh

RUN chmod +x /etc/conf/conf.sh

EXPOSE 3306

ENTRYPOINT ["bash", "/etc/conf/conf.sh"];