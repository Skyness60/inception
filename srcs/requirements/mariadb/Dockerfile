FROM debian:bullseye

# Install MariaDB
RUN apt-get update && apt-get install -y mariadb-server && apt-get clean && mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld

RUN mkdir workspace

WORKDIR /workspace

COPY ./tools/setup.sh .

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/my.cnf

RUN chmod +x setup.sh

CMD ["./setup.sh"]