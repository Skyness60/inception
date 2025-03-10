FROM debian:bullseye

# Install nginx
RUN apt-get update && apt-get install -y nginx && apt-get clean

# Copy the configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Installer openssl
RUN apt-get update && apt-get install -y openssl

# Créer un dossier pour les certificats
RUN mkdir -p /etc/nginx/ssl

# Générer un certificat SSL auto-signé
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/CN=sperron.42.fr" && \
    ls -l /etc/nginx/ssl/


RUN chmod 600 /etc/nginx/ssl/nginx.key && chmod 644 /etc/nginx/ssl/nginx.crt

# Expose the port
EXPOSE 443

# Start the service
CMD ["nginx", "-g", "daemon off;"]