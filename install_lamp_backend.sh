#!/bin/bash

# Configuramos para mostrar los comandos y finalizar si hay error
set -ex

# Importamos el archivo de variables 
source .env

# Actualizamos los repositorios
sudo apt update && sudo apt upgrade -y

# Actualiza los paquetes
apt upgrade -y

#Instalamos mariadb-server
sudo apt install mariadb-server -y

# Copiamos el archivo de configuracion de mysql
sed -i "s/^bind-address\s*=.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# Borramos la base de datos y el usuario si existen
mysql -u root <<EOF
DROP DATABASE IF EXISTS prestashop;
DROP USER IF EXISTS 'psuser'@'localhost';
DROP USER IF EXISTS 'psuser'@'%';
FLUSH PRIVILEGES;
EOF

# Creamos la base de datos y el usuario para PRESTASHOP
mysql -u root <<EOF
CREATE DATABASE prestashop CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER 'psuser'@'localhost' IDENTIFIED BY 'pspass';
GRANT ALL PRIVILEGES ON prestashop.* TO 'psuser'@'%';
FLUSH PRIVILEGES;
EOF

# Reiniciamos el servicio de MySQL
systemctl restart mariadb