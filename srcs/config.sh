#!/bin/sh

# Site folder
mkdir /var/www/site && mkdir /var/www/site/php && touch /var/www/site/php/index.php
echo "<?php phpinfo(); ?>" >> /var/www/site/php/index.php

# nginx setup
mv nginx_conf /etc/nginx/sites-available/site
ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled/site
rm -rf /etc/nginx/sites-enabled/default
bash autoindex.sh $AUTO_INDEX

# Allow access to nginx User
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

# Database setup
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'root'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

# phpMyAdmin
mv phpMyAdmin-5.0.4-all-languages /var/www/site/phpMyAdmin
mv phpMyAdmin_conf /var/www/site/phpMyAdmin/config.inc.php

# WordPress setup
mv wordpress/ /var/www/site
mv wp_config.php /var/www/site/wordpress

rm -rf *tar.gz

# Service starting
/etc/init.d/php7.3-fpm start
service nginx start
bash
