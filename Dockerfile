FROM debian:buster

# Tools needed
RUN apt update && apt upgrade -yq && apt install -yq wget

# Needed packages
RUN apt install -yq nginx \
&& apt install -yq php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring \
&& apt install -yq mariadb-server \
&& apt install -yq openssl
