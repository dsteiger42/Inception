#NOTE: RUN happens at build time and CMD at container runtime

FROM debian:oldstable

# openssl is for TSLv1.3 do allow for private keys, and encryptic stuff.
# 2nd line - store the ssl keys and certs / store the php files and what the user requests.
# last line is to delete cache
RUN apt-get update && apt-get install -y nginx openssl \
    && mkdir -p /etc/nginx/ssl /var/www/html \
    && openssl req -x509 -nodes -days 365 \
        -subj "/C=PT/ST=LISBON/L=LISBON/O=42/Inception/CN=dsteiger.42.fr" \
        -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.cert \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# copiar o ficheiro que configura o nginx
COPY ./conf/nginx.conf /etc/nginx/nginx1.conf

# port 80 is the normal web trafic port for HTTP. 443 for HTTPS
EXPOSE 80 443

# ["executable", "param1", "param2"]A
# daemon off means to run a program in the foreground instead of the background
ENTRYPOINT ["nginx"]

CMD ["-g", "daemon off;"]
