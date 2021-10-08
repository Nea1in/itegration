#!/usr/bin/env bash

#== Import script args ==

timezone=$(echo "$1")

#== Bash helpers ==

function info {
  echo " "
  echo "--> $1"
  echo " "
}

#== Provision script ==

info "Provision-script user: `whoami`"

export DEBIAN_FRONTEND=noninteractive

info "Configure timezone"
timedatectl set-timezone ${timezone} --no-ask-password

#info "Prepare root password for MySQL"
#debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password \"''\""
#debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password \"''\""
#echo "Done!"

#info "Add php repository"
#add-apt-repository ppa:ondrej/php -y

info "Update OS software"
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt update
apt-cache policy docker-ce
apt install docker-ce -y
#apt-get upgrade -y

#info "Install additional software"
#apt-get install -y apache2 php5.6 php5.6-curl php5.6-cli php5.6-intl php5.6-mysqlnd php5.6-gd php5.6-mbstring php5.6-xml unzip mysql-server-5.7 php.xdebug
#
#info "Install memcached"
#apt-get install -y php5.6-memcached memcached
#echo "Done!"
#
#info "Configure MySQL"
#sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
#mysql -uroot <<< "CREATE USER 'root'@'%' IDENTIFIED BY ''"
#mysql -uroot <<< "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'"
#mysql -uroot <<< "DROP USER 'root'@'localhost'"
#mysql -uroot <<< "FLUSH PRIVILEGES"
#echo "Done!"
#
## info "Configure PHP-FPM"
## sed -i 's/user = www-data/user = vagrant/g' /etc/php/7.0/fpm/pool.d/www.conf
## sed -i 's/group = www-data/group = vagrant/g' /etc/php/7.0/fpm/pool.d/www.conf
## sed -i 's/owner = www-data/owner = vagrant/g' /etc/php/7.0/fpm/pool.d/www.conf
#cat << EOF > /etc/php/5.6/mods-available/xdebug.ini
#zend_extension=xdebug.so
#xdebug.remote_enable=1
#xdebug.remote_connect_back=1
#xdebug.remote_port=9000
#xdebug.remote_autostart=1
#EOF
#echo "Done!"

# info "Configure NGINX"
# sed -i 's/user www-data/user vagrant/g' /etc/nginx/nginx.conf
# echo "Done!"

# info "Enabling site configuration"
# ln -s /app/vagrant/nginx/app.conf /etc/nginx/sites-enabled/app.conf
# echo "Done!"
#
#info "Configure apache2"
## sed -i 's/user www-data/user vagrant/g' /etc/nginx/nginx.conf
#a2enmod rewrite
#echo "Done!"
#
#info "apache2 Enabling site configuration"
#ln -s /var/www/html/vagrant/apache2/frontend.conf /etc/apache2/sites-enabled/frontend.conf
#ln -s /var/www/html/vagrant/apache2/backend.conf /etc/apache2/sites-enabled/backend.conf
#echo "Done!"
#
#
#info "Initailize databases for MySQL"
#mysql -uroot <<< "CREATE DATABASE rm_dev"
#mysql -uroot <<< "CREATE DATABASE rm_test"
#echo "Done!"
#
#info "Install composer"
#curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer