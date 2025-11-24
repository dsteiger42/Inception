#NOTE: RUN happens at build time and CMD at container runtime

FROM debian:oldstable

# -y is to always assume yes in [Y/N]
# openssl is for TSLv1.3 do allow for private keys, and encryptic stuff
RUN apt-get update && apt-get install -y nginx openssl

# copiar o ficheiro que configura o nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# ["executable", "param1", "param2"]
# daemon off means to run a program in the foreground instead of the background
ENTRYPOINT ["nginx"]

CMD ["-g", "daemon off;"]
