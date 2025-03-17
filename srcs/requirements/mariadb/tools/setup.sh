#!/bin/bash

set -e  # Stopper si une commande échoue
mkdir -p /run/mysqld
chmod 777 /run/mysqld 
chown -R mysql:mysql /run/mysqld

# Fichier d'init SQL
cat <<EOF > /etc/mysql/init.sql
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

# Assurer que le dossier est prêt
# Lancer MySQL
exec mysqld
