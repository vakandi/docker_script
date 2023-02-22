#!/bin/bash

sudo apt-get update
sudo apt-get install apache2 php libapache2-mod-php -y
sudo a2enmod php7.4
sudo systemctl restart apache2

echo "<?php phpinfo(); ?>" > /var/www/html/info.php

echo "PHP has been installed and configured on Apache2."

