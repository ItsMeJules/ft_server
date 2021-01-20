FROM debian:buster

# Needed packages
RUN apt update && apt upgrade -yq && apt install -yq nginx php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring mariadb-server openssl wget && wget -c https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz && wget -c https://wordpress.org/latest.tar.gz

# Decompressing files
RUN tar -xvzf latest.tar.gz && tar -xvzf phpMyAdmin-5.0.4-english.tar.gz

# Creating the ssl contract
RUN mkdir /etc/nginx/ssl && openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/site.pem -keyout /etc/nginx/ssl/site.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=jpeyron/CN=site"

# Copying config files
COPY ./srcs/config.sh /
COPY ./srcs/nginx_conf /
COPY ./srcs/phpMyAdmin_conf /
COPY ./srcs/wp-config.php /
COPY ./srcs/autoindex.sh /

ENV AUTO_INDEX=true

# Executing the configuration script on start
CMD bash config.sh
