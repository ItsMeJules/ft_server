#!bin/sh
if [ "$1" = "true" ]
then
    sed -i "s/autoindex off/autoindex on/" /etc/nginx/sites-available/site
	echo "on"
    service nginx restart
fi
if [ "$1" = "false" ]
then
    sed -i "s/autoindex on/autoindex off/" /etc/nginx/sites-available/site
	echo "off"
    service nginx restart
fi
