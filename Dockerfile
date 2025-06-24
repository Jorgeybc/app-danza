# Etapa 1: Construcción de assets con Vite
FROM node:20-alpine as vite-builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build


# Etapa 2: Dependencias PHP con Composer
FROM composer:2 as composer-deps

WORKDIR /app
COPY . .
RUN composer install --optimize-autoloader --no-dev


# Etapa 3: Laravel con PHP-FPM
FROM php:8.2-fpm-alpine

# Instalamos dependencias necesarias
RUN apk add --no-cache \
    bash zip unzip curl git \
    libpng libpng-dev libjpeg-turbo-dev freetype-dev \
    libxml2-dev oniguruma-dev zlib-dev icu-dev \
    libzip-dev mysql-client \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl intl gd

# Copiar Composer desde la imagen oficial
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Copiar código fuente y dependencias PHP
COPY --from=composer-deps /app ./

# Copiar assets de Vite ya compilados
COPY --from=vite-builder /app/public/build ./public/build

# Copiar script de inicio
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Comando que ejecuta el contenedor
CMD ["/start.sh"]
