#!/bin/bash

# Configuramos para mostrar los comandos y finalizar si hay error
set -ex

# Importamos el archivo de variables 
source .env

# Actualizamos los repositorios
sudo apt update && sudo apt upgrade -y

# Instalamos las dependencias necesarias
sudo apt install wget unzip apache2 mariadb-client -y

# Instalamos las dependencias de PHP
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update

# Habilitamos el modulo rewrite
sudo a2enmod rewrite

# Copiamos el archivo de configuración de Apache
cp /home/ubuntu/conf/000-default.conf /etc/apache2/sites-available

# Activamos el sitio
sudo a2ensite 000-default.conf

# Instalamos las extensiones de PHP necesarias
sudo apt install php7.4 php7.4-mysql php7.4-cli php7.4-xml php7.4-curl php7.4-gd php7.4-mbstring php7.4-zip php7.4-intl libapache2-mod-php7.4 -y

sudo sed -i 's/^memory_limit = .*/memory_limit = 512M/' "$PHP_INI"
sudo sed -i 's/^upload_max_filesize = .*/upload_max_filesize = 64M/' "$PHP_INI"
sudo sed -i 's/^post_max_size = .*/post_max_size = 64M/' "$PHP_INI"
sudo sed -i 's/^max_execution_time = .*/max_execution_time = 300/' "$PHP_INI"
sudo sed -i 's/^max_input_time = .*/max_input_time = 300/' "$PHP_INI"

# Reiniciamos el servicio de Apache
sudo systemctl reload apache2