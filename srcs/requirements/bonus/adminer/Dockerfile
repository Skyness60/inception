FROM        debian:bullseye

RUN         apt -y update && apt -y upgrade
RUN         apt -y install wget php7.4 php7.4-fpm

EXPOSE      9000

COPY        ./tools/entrypoint.sh /usr/local/bin/
RUN         chmod 755 /usr/local/bin/entrypoint.sh

ENTRYPOINT  [ "bash", "/usr/local/bin/entrypoint.sh" ]
