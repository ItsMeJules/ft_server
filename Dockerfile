FROM debian:buster

# Needed packages
RUN apt update && apt upgrade -yq && apt install -yq nginx php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring mariadb-server openssl wget

COPY ./srcs/config.sh / 
COPY ./srcs/nginx_conf / 
COPY ./srcs/phpMyAdmin_conf / 
COPY ./srcs/wp_config.php / 
