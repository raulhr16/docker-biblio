#!/bin/bash
# Esperar a que la base de datos esté lista
while ! mysql -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -h ${MYSQL_HOST} -e ";" ; do
	sleep 1
done

# Importar base de datos si es necesario
mysql -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -h ${MYSQL_HOST} ${MYSQL_DATABASE} < /opt/biblioteca.sql

# Habilitar el uso de .htaccess cambiando AllowOverride None por AllowOverride All
sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Reiniciar Apache para aplicar los cambios
apache2ctl -D FOREGROUND
