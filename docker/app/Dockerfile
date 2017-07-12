FROM php:5.6-apache
MAINTAINER yKicchan
COPY php.ini /usr/local/etc/php/
RUN apt-get update
RUN apt-get -y install mysql-client
RUN docker-php-ext-install mysqli
# RUN a2enmod rewrite
RUN mkdir /var/lib/php
RUN mkdir /var/lib/php/session
RUN chmod 777 /var/lib/php/session
