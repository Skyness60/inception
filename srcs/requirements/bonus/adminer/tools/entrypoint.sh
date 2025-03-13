#!/bin/bash

# Set up php-fpm
mkdir -p /var/run/php
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/7.4/fpm/pool.d/www.conf

# Set up adminer
mkdir -p /var/www/wordpress
wget "http://www.adminer.org/latest.php" -O /var/www/wordpress/adminer.php
chown www-data:www-data /var/www/wordpress/adminer.php
chmod 755 /var/www/wordpress/adminer.php

# Start php-fpm
php-fpm7.4 -F