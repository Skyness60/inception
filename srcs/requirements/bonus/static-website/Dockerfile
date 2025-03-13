# Base image
FROM 		debian:bullseye

RUN mkdir -p /var/www/website
COPY ./conf/* /var/www/website/
COPY ./tools /execute
RUN chmod -R +x /execute

ENTRYPOINT ["sh", "/execute/setup.sh" ]
