#!/bin/bash

# Actualizamos los repositorios
sudo apt update && sudo apt upgrade -y

# Instalamos las dependencias necesarias
sudo apt install wget unzip apache2

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
sudo apt install php7.4 php7.4-cli php7.4-xml php7.4-curl php7.4-gd php7.4-mbstring php7.4-zip php7.4-intl libapache2-mod-php7.4 -y

# Instalamos el servidor LAMP
cd /tmp

# Descargamos la última versión de Prestashop
wget https://assets.prestashop3.com/dst/edition/corporate/8.2.1/prestashop_edition_classic_version_8.2.1.zip

# Descomprimimos el archivo
unzip prestashop_edition_classic_version_8.2.1.zip -d prestashop

# Eliminamos instalaciones anteriores
sudo rm -rf /var/www/html/*

# Movemos los archivos a la carpeta de Apache
sudo mv prestashop/* /var/www/html/

# Cambiamos los permisos de la carpeta
sudo chown -R www-data:www-data /var/www/html/

# Cambiamos los permisos de la carpeta
sudo chmod -R 755 /var/www/html/

# Reiniciamos el servicio de Apache
sudo systemctl reload apache2

