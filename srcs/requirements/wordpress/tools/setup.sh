#!/bin/bash

sleep 10

# Créer le répertoire nécessaire
mkdir -p /run/php
chown -R www-data:www-data /run/php
chmod 755 /run/php

# Configuration de PHP
sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|g" /etc/php/7.4/fpm/pool.d/www.conf

# Vérifier et installer WordPress si nécessaire
echo "Starting WP download..."
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    wp core download --allow-root
fi

# Configurer WordPress
echo "Starting WP configuration ..."
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    # Si WordPress n'est pas installé, créer le fichier wp-config.php
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb --allow-root --skip-check
    # Installer WordPress
    wp core install --url=$DOMAIN_NAME --title=Inception --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
    # Créer un utilisateur WordPress
    wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root
else
    echo "WordPress is already installed."
fi

# Finaliser les permissions
chown -R www-data:www-data /var/www/wordpress

# Lancer PHP-FPM
echo "Starting PHP Fast Process Manager:"
exec php-fpm7.4 -F
