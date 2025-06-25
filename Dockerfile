# Etapa 1: Build de Vite
FROM node:20-alpine as vite-builder

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build


# Etapa 2: Composer (dependencias de Laravel)
FROM composer:2 as composer-deps

WORKDIR /app
COPY . .
RUN composer install --optimize-autoloader --no-dev


# Etapa 3: Apache con PHP 8.2
FROM php:8.2-apache

# Instalar extensiones necesarias
RUN apt-get update && apt-get install -y \
    zip unzip curl git libpng-dev libjpeg-dev libfreetype6-dev libonig-dev \
    libxml2-dev libzip-dev libicu-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl intl gd

# Habilitar mod_rewrite para Laravel
RUN a2enmod rewrite

# Cambiar el DocumentRoot para que apunte a public/
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

# Reescribir la configuración de Apache para usar el nuevo DocumentRoot
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/000-default.conf \
 && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}/../!g' /etc/apache2/apache2.conf

# Establecer el directorio de trabajo
WORKDIR /var/www/html

# Copiar toda la app (con dependencias)
COPY --from=composer-deps /app ./
COPY --from=vite-builder /app/public/build ./public/build

# Establecer permisos
RUN chown -R www-data:www-data /var/www/html

# Establecer permisos para Laravel
RUN chown -R www-data:www-data storage bootstrap/cache


EXPOSE 80
