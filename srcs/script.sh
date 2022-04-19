#! /bin/bash

#INSTALL PACKAGES
apt-get update
apt-get install -y vim
apt-get install -y unzip
apt-get install -y nginx
apt-get install -y mariadb-server
apt-get install -y php-fpm php-mysql php-mbstring php-dev php-gd php-pear php-zip php-xml php-curl

#NGINX SETUP
mkdir -p /var/www/ft_server
rm -rf /etc/nginx/sites-enabled/default
cp /tmp/ftserver.conf /etc/nginx/sites-available/ftserver
ln -s /etc/nginx/sites-available/ftserver /etc/nginx/sites-enabled/

# SSL
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=tpierre/CN=ftserver"

#DATABASE SETUP
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'tpierre'@'localhost' IDENTIFIED BY 'tpierrepass';" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'tpierre'@'localhost' IDENTIFIED BY 'tpierrepass' WITH GRANT OPTION;" | mysql -u root
echo "FLUSH PRIVILIEGES;" | mysql -u root

#WORDPRESS INSTALL
cd /var/www/ft_server
tar -xzvf /tmp/wordpress.tar.gz

# PHPMYADMIN SETUP
unzip /tmp/phpMyAdmin.zip -d /var/www/ft_server
mv /var/www/ft_server/php* /var/www/ft_server/phpmyadmin

#ALLOW NGINX PERMISSION
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

#RESTART SERVICES
service php7.3-fpm start
service mysql start
service nginx start
service nginx configtest
service nginx status

tail -f /var/log/nginx/access.log /var/log/nginx/error.log
