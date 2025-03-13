FROM debian:bullseye

# Installer nginx, openssl et nettoyer
RUN apt-get update && apt-get install -y \
    nginx openssl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Générer le certificat SSL auto-signé
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/CN=sperron.42.fr" && \
    chmod 600 /etc/nginx/ssl/nginx.key && \
    chmod 644 /etc/nginx/ssl/nginx.crt

# Copier la config nginx (mieux vaut un volume, mais au cas où)
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Exposer le port HTTPS
EXPOSE 443 30

# Lancer nginx en mode foreground
CMD ["nginx", "-g", "daemon off;"]
