# syntax=docker/dockerfile:1
FROM php:8.4.3-apache
RUN apt-get update && apt-get install -y mariadb-client
RUN docker-php-ext-install pdo pdo_mysql && docker-php-ext-enable pdo_mysql
COPY app/ /var/www/html/
EXPOSE 80
ENV MYSQL_USER raulhr
ENV MYSQL_PASSWORD raulhr
ENV MYSQL_DATABASE biblioteca
ENV MYSQL_HOST s_mysql
COPY docker-entrypoint.sh /usr/local/bin/script.sh
COPY app/biblioteca.sql /opt
RUN a2enmod rewrite
RUN chmod +x /usr/local/bin/script.sh
CMD /usr/local/bin/script.sh
