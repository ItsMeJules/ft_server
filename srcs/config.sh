#!/bin/sh

# Database setup
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'root'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

# phpMyAdmin


# Service starting
service nginx start
service mysql restart
/etc/init.d/php7.3-fpm start
