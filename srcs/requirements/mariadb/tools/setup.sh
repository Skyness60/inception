#!/bin/bash

set -e  # Stopper si une commande échoue

# Fichier d'init SQL
cat <<EOF > /etc/mysql/init.sql
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

# Assurer que le dossier est prêt
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Lancer MySQL
exec mysqld
