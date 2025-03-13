# Base image
FROM        debian:bullseye

# Define build arguments passed from docker-compose.yml
ARG         FTP_USER
ARG         FTP_PASSWORD

# Set environment variables
ENV         FTP_USER=${FTP_USER}
ENV         FTP_PASSWORD=${FTP_PASSWORD}

# Update and upgrade system & install FTP
RUN         apt -y update && apt -y upgrade
RUN         apt -y install vsftpd ftp

# Set up FTP
COPY        ./conf/vsftpd.conf /usr/local/bin/
COPY        ./tools/setup.sh /usr/local/bin/
RUN         chmod 755 /usr/local/bin/setup.sh

# Expose port
EXPOSE      220 221

# Run FTP
ENTRYPOINT  [ "bash", "/usr/local/bin/setup.sh" ]