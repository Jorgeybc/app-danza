# Etapa 1: Build de Vite
FROM node:20-alpine as vite-builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build


# Etapa 2: Composer install
FROM composer:2 as composer-deps

WORKDIR /app
COPY . .
RUN composer install --optimize-autoloader --no-dev


# Etapa 3: PHP y NGINX
FROM php:8.2-fpm-alpine as app

# Dependencias del sistema
RUN apk add --no-cache bash nginx curl git zip unzip supervisor \
    libpng libpng-dev libjpeg-turbo-dev freetype-dev \
    libxml2-dev oniguruma-dev zlib-dev icu-dev libzip-dev

# Extensiones PHP necesarias
RUN docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl intl gd

# Crear carpetas necesarias
RUN mkdir -p /var/log/supervisor /var/www/html

# Copiar código desde etapas anteriores
COPY --from=composer-deps /app /var/www/html
COPY --from=vite-builder /app/public/build /var/www/html/public/build
COPY default.conf /etc/nginx/conf.d/default.conf

# Copiar script de inicio y configuración de supervisord
COPY start.sh /start.sh
COPY supervisord.conf /etc/supervisord.conf

RUN mkdir -p /run/php && touch /run/php/php-fpm.sock
RUN chmod +x /start.sh

WORKDIR /var/www/html

CMD ["/start.sh"]

