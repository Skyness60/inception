FROM debian:bullseye

# Install MariaDB
RUN apt-get update && apt-get install -y mariadb-server && apt-get clean && mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld

COPY ./conf/my.cnf /etc/mysql/my.cnf

COPY ./conf/init.sql /tmp/init.sql

EXPOSE 3306

CMD ["mysqld"]