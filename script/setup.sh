#!/bin/bash

echo "$(cat /etc/apache2/apache2.conf | sed "s#/var/www#/var/www/html#g")" > /etc/apache2/apache2.conf

cd /var/www/html

echo "root:leetsec***" | chpasswd

echo -e "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf

service ssh restart

a2enmod php7.4
service apache2 restart

echo "<?php phpinfo(); ?>" > /var/www/html/info.php

echo "PHP has been installed and configured on Apache2."

echo -e "\n\nRestart apache & mariadb ...\n\n"

service apache2 restart
service mariadb restart
service ssh restart

mariadb -u root <<EOF
CREATE USER 'DBuser'@localhost IDENTIFIED BY 'password';
CREATE DATABASE hotel;
GRANT ALL PRIVILEGES ON *.* TO 'DBuser'@localhost IDENTIFIED
BY 'password;
GRANT ALL PRIVILEGES ON hotel.* TO 'DBuser'@'%' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
EOF

MYSQL_USER="DBuser"
MYSQL_PASSWORD="password"
DB_TABLE="users"
db_name="hotel"


sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

SQL_SETUP_FILE="/var/www/html/hotel.sql"
echo -e "Installing Website & dependencies..."
rm /var/www/html/index*
cp -r /mnt/website/* /var/www/html/
cd /var/www/html
npm install
composer install
#mariadb -u root -e "source /var/www/html/hotel.sql"
mariadb --user="$MYSQL_USER" --database="$db_name" --password="$MYSQL_PASSWORD" < $SQL_SETUP_FILE


echo "Setting up permissions for var/www/html"
chown -R www-data:www-data /var/www/html 

cp -r /mnt/script/personal_script /root/script/
cp -r /mnt/script/personal_script /home/leetsec/script
chown -R leetsec:leetsec /home/leetsec/script/
sh /root/script/zshputlinux

clear
echo -e "\033[35m \n\n\n\nStarting the verification ...\033[0m"


echo -e "Checking for root apache2 folder.."
check_folder_apache="$(cat /etc/apache2/apache2.conf | grep "/var/www/html")"
if [ -z "$check_folder_apache" ] 
then
	echo -e "\033[31m\n\n\n!!!!!!!!!!\nIT DIDN'T WORK, the folder is still /var/www/, Change it\n!!!!!!!!\033[0m"
else
	echo -e "\033[32mAll good, the folder /var/www/html is setup correctly\033[0m"
fi

echo -e "Checking Apache2 config syntax\n"
apachectl configtest
echo ""

# Check if the MariaDB database  exists
database_exist=$(mariadb -u root -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '$db_name'" | grep -o "$db_name")
if [ "$database_exist" = "$db_name" ]; then
  echo -e "\033[32mThe MariaDB database '$db_name' exists.\033[0m"
else
  echo -e "\033[31mThe MariaDB database '$db_name' does not exist.\033[0m"
fi

# Check if the user "DBuser" exists and has access to the database "nftstoredatabase"
user_exist=$(mariadb -u root -e "SELECT User FROM mysql.user" | grep -o "$MYSQL_USER" | head -n1)
if [ "$user_exist" = "$MYSQL_USER" ]; then
  echo -e "\033[32mThe user '$MYSQL_USER' exists.\033[0m"
  database_access=$(mariadb -u root -e "SHOW GRANTS FOR '$MYSQL_USER'@'%'" | grep "$db_name")
  if [ -n "$database_access" ]; then
    echo -e "\033[32mThe user '$MYSQL_USER' has access to the MariaDB database '$db_name'.\033[0m"
  else
    echo -e "\033[31mThe user '$MYSQL_USER' does not have access to the MariaDB database '$db_name'.\033[0m"
  fi
else
  echo -e "\033[31mThe user '$MYSQL_USER' does not exist.\033[0m"
fi


echo -e "\033[35m\n\n The verification is done ... \n\n \033[0m"


echo -e "\033[32mThe docker is accessible on ssh leetsec@$(sh /root/script/iplocal) -p 42 \033[0m"
echo -e "\033[32mThe docker is accessible on http://$(sh /root/script/showip) \033[0m"
