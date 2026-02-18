# --dbname --dbuser etc are flags. No flags is a positional argument. WP_cli parses them both

#!/bin/sh

# Go to WordPress directory
cd /var/www/html

# Only install WordPress if not already installed
if [ ! -f wp-config.php ]
then
    # Download WordPress core
    wp core download --allow-root

    # Create wp-config.php
    wp config create \
        --dbname=$WP_DB_NAME \
        --dbuser=$WP_DB_USER \
        --dbpass=$WP_DB_PASSWORD \
        --dbhost=$WP_DB_HOST \
        --allow-root

    # Install WordPress site
    wp core install \
        --url=$DOMAIN_NAME \
        --title="$WP_TITLE" \
        --admin_user=$WP_ADM_USER \
        --admin_password=$WP_ADM_PASS \
        --admin_email=$WP_ADM_EMAIL \
        --allow-root

    # Create a normal WordPress user (for comments, posts)
    wp user create \
        $WP_USER \
        $WP_USER_EMAIL \
        --user_pass=$WP_USER_PASS \
        --role=author \
        --allow-root

    # Activate the Wordpress theme
    wp theme install twentytwentyfour --activate --allow-root
fi

# Run PHP-FPM in foreground so container stays alive
exec php-fpm8.2 -F
