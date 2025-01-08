FROM php:8.3-apache

RUN docker-php-ext-install mysqli pdo_mysql

RUN apt-get update \
 && apt-get install -y git zlib1g-dev \
 && apt-get install -y git zlib1g-dev \
 && apt-get install -y libicu-dev \
 && apt-get install -y mc \
 && a2ensite 000-web \
 && a2enmod rewrite \
 && sed -i 's!/var/www/html!/var/www/public!g' /etc/apache2/sites-available/000-default.conf \
 && mv /var/www/html /var/www/public \
 && curl -sS https://getcomposer.org/installer \
  | php -- --install-dir=/usr/local/bin --filename=composer \
 && echo "AllowEncodedSlashes On" >> /etc/apache2/apache2.conf

# Installing libs and php extensions
RUN apt-get update
RUN apt-get install -y \
            libfreetype6-dev \
            libjpeg62-turbo-dev \
            libpng-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd intl

WORKDIR /var/www
