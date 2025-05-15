#!/bin/bash

# Configuramos para mostrar los comandos y finalizar si hay error
set -ex

# Importamos el archivo de variables 
source .env

# Actualizamos los repositorios
apt update

# Actualizamos los paquetes
apt upgrade -y

# Instalamos apache2 y módulos proxy necesarios
apt install apache2 libapache2-mod-proxy-html libxml2-dev -y

# Habilitamos módulos necesarios para proxy inverso
a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests headers rewrite

# Deshabilitamos el virtualhost por defecto si existe
if [ -f "/etc/apache2/sites-enabled/000-default.conf" ]; then
    a2dissite 000-default.conf
fi

# Copiamos el archivo de configuración de apache
cp /home/ubuntu/Presta2/conf/load-balancer-apache.conf /etc/apache2/sites-available/load-balancer-conf.conf

# Habilitamos el sitio load-balancer
a2ensite load-balancer.conf

# Reiniciamos apache para aplicar cambios
systemctl restart apache2