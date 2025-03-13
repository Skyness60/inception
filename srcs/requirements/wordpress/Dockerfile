
FROM debian:bullseye

RUN apt-get update \
    && apt-get install wget curl php-mysql php7.4-fpm netcat-traditional php7.4-redis redis-tools -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

	
RUN         mv /etc/php/7.4/fpm/pool.d/www.conf /etc/php/7.4/fpm/pool.d/www.conf.default
COPY        ./conf/www.conf /etc/php/7.4/fpm/pool.d/

COPY ./tools /execute
RUN chmod -R +x /execute

EXPOSE 9000/tcp

ENTRYPOINT ["sh", "/execute/setup.sh" ]
CMD ["/usr/sbin/php-fpm7.4", "-F"]