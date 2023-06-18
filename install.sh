#!/bin/bash

sudo apt-get update
# Menambahkan repository PHP
sudo add-apt-repository ppa:ondrej/php -y

# Menginstal Apache2
sudo apt install apache2 -y

# Mengedit file konfigurasi apache2.conf
sudo sed -i 's/AllowOverride None/AllowOverride all/g' /etc/apache2/apache2.conf
sudo sed -i 's/Require all denied/Require all granted/g' /etc/apache2/apache2.conf

# Mengaktifkan modul rewrite
sudo a2enmod rewrite

# Menginstal PHP dan paket-paket yang diperlukan
sudo apt-get install php8.2
sudo apt-get install php8.2-{gd,cli,mbstring,zip,curl,mysql,dom,pdo,fpm} -y
sudo apt-get install php8.2 php8.2-gd php8.2-cli php8.2-mbstring php8.2-zip php8.2-curl php8.2-mysql php8.2-dom php8.2-pdo -y

# Menginstal MySQL Server
sudo apt-get install mysql-server -y

# Mengakses MySQL Shell
sudo mysql <<EOF
CREATE USER 'user'@'%' IDENTIFIED BY 'Ahmadsofuwan@123';
GRANT ALL PRIVILEGES ON * . * TO 'user'@'%';
FLUSH PRIVILEGES;
ALTER USER 'user'@'%' IDENTIFIED WITH mysql_native_password BY 'Ahmadsofuwan@123';
quit
EOF

# Mengganti nilai bind-address dan mysqlx-bind-address
sudo sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i 's/mysqlx-bind-address\s*=\s*127.0.0.1/mysqlx-bind-address = 0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf


# Restart MySQL service
sudo systemctl restart mysql

# Menginstal Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Menginstal Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs



