#!/bin/sh

# Database setup
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'root'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

# WordPress setup
cd /tmp/
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/ /var/www/html
mv /tmp/wp-config.php /var/www/html/wordpress

# SSL setup
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/site.pem -keyout /etc/nginx/ssl/site.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=rchallie/CN=monsupersite"

# phpMyAdmin


# Service starting
service nginx start
service mysql restart
/etc/init.d/php7.3-fpm start
