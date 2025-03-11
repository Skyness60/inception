#!/bin/bash

sleep 3

mkdir -p /run/php
chown -R www-data:www-data /run/php
chmod 755 /run/php
sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|g" /etc/php/7.4/fpm/pool.d/www.conf

echo "Starting WP download..."
wp core download --allow-root

echo "Starting WP configuration ..."
wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb --allow-root
wp core install --url=localhost --title=Inception --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root

# # ftp config
# wp config set FTP_HOST ftp --allow-root
# wp config set FTP_USER $FTP_USER --allow-root
# wp config set FTP_PASS $FTP_PASSWORD --allow-root

# # update plugins
# wp plugin update --all --allow-root

# # redis config
# wp plugin install redis-cache --activate --allow-root
# wp config set WP_REDIS_HOST redis_cache --allow-root
# wp config set WP_REDIS_PORT 6379 --allow-root
# wp redis enable --allow-root

chown -R www-data:www-data /var/www/wordpress

echo "Starting PHP Fast Procces Manager:"
exec "$@"