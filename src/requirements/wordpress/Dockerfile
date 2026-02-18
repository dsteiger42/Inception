FROM debian:oldstable

# php extensions
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    php-fpm \
    php-mysql \
    php-zip \
    php-redis \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    curl \
    unzip \
    sendmail \
    vim && mkdir -p /run/php

# wp-cli (command-line interface for Wordpress) installation
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp && \
    wp core download --allow-root --path=/var/www/html

# wordpress files are here
WORKDIR /var/www/html

COPY tools/entry.sh /etc/entry.sh

ENTRYPOINT ["bash", "/etc/entry.sh"]