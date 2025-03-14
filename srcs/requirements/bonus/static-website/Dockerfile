# Base image
FROM 		debian:bullseye

RUN mkdir -p /var/www/website
RUN apt -y update && apt -y upgrade && apt -y install nodejs npm
COPY ./conf/* /var/www/website/


CMD ["node", "/var/www/website/server.js"]
