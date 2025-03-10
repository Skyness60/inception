FROM debian:bullseye

# Install MariaDB
RUN apt-get update && apt-get install -y mariadb-server && rm -rf /var/lib/apt/lists/* && mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld

COPY ./config/my.cnf /etc/mysql/my.cnf

EXPOSE 3306

CMD ["mysqld"]