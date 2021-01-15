FROM debian:buster

# Tools needed
RUN apt update && apt upgrade -y && apt install -y wget

# Needed packages
RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring
&& apt install -y nginx \
&& apt install -y mariadb-server \