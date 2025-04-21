FROM composer/composer AS composer

COPY . /app

RUN composer install

FROM node AS node

COPY package.json /app/

WORKDIR /app

RUN ls -la

RUN npm install

FROM php:8.3-apache

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN apt-get update
RUN apt-get install -y libxml2-dev libpng-dev libcurl4-openssl-dev libonig-dev ffmpeg

RUN docker-php-ext-install mysqli
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install xml
RUN docker-php-ext-install gd
RUN docker-php-ext-install curl
# RUN docker-php-ext-install imagick

COPY --from=composer /app /var/www/html
COPY --from=node /app /var/www/html

