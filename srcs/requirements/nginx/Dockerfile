FROM alpine:3.20

RUN     apk update && apk upgrade && apk add --no-cache \
        nginx openssl

RUN     mkdir /etc/nginx/ssl
RUN     openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
				-out /etc/nginx/ssl/sperron.pem \
				-keyout /etc/nginx/ssl/sperron.key \
				-subj "/C=IT/ST=Paris/L=Paris/O=42/OU=student/CN=sperron/"

RUN     mkdir -p /run/nginx

COPY    conf/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]