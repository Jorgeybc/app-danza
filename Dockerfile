# Etapa 1: Build de Vite
FROM node:20-alpine as vite-builder

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build


# Etapa 2: Instalar dependencias con Composer
FROM composer:2 as composer-deps

WORKDIR /app
COPY . .
RUN composer install --optimize-autoloader --no-dev


# Etapa 3: Laravel con Apache
FROM php:8.2-apache

# Instalar extensiones necesarias
RUN apt-get update && apt-get install -y \
    zip unzip curl git libpng-dev libjpeg-dev libfreetype6-dev libonig-dev \
    libxml2-dev libzip-dev libicu-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl intl gd

# Habilitar mod_rewrite (necesario para Laravel)
RUN a2enmod rewrite

# Establecer el directorio de trabajo
WORKDIR /var/www/html

# Copiar la aplicación y los assets ya construidos
COPY --from=composer-deps /app ./
COPY --from=vite-builder /app/public/build ./public/build

# Copiar .htaccess para rutas amigables (si no existe en tu repo, créalo)
COPY .htaccess /var/www/html/.htaccess

# Establecer permisos opcionales
RUN chown -R www-data:www-data /var/www/html

# Render detectará automáticamente el puerto 80 de Apache
EXPOSE 80
