#!/bin/sh

# Site folder
mkdir /var/www/site && touch /var/www/site/index.php
echo "<?php phpinfo(); ?>" >> /var/www/site/index.php

# SSL setup
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/site.crt -keyout /etc/nginx/ssl/site.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=jpeyron/CN=site"

# nginx setup
mv nginx_conf /etc/nginx/sites-available/site
ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled/site
rm -rf /etc/nginx/sites-enabled/default

# Database setup
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'root'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

# phpMyAdmin
mkdir /var/www/site/phpMyAdmin
wget -c https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
tar -xvzf phpMyAdmin-5.0.4-all-languages.tar.gz 
mv phpMyAdmin-5.0.4-all-languages /var/www/site/phpMyAdmin
mv phpMyAdmin_conf /var/www/site/phpMyAdmin/config.inc.php

# WordPress setup
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/ /var/www/site
mv wp_config.php /var/www/site/wordpress

rm -rf *tar.gz

# Service starting
/etc/init.d/php7.3-fpm start
service nginx start
bash
