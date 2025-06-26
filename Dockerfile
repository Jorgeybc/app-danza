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

# Etapa 3: PHP-FPM + Caddy
FROM php:8.2-fpm-alpine

# Dependencias
RUN apk add --no-cache curl git zip unzip bash \
    libpng libpng-dev libjpeg-turbo-dev freetype-dev \
    libxml2-dev oniguruma-dev zlib-dev icu-dev libzip-dev \
    supervisor \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl intl gd

# Instalar Caddy (web server)
RUN curl -fsSL https://get.caddyserver.com | bash -s personal

# Copiar código
WORKDIR /var/www/html
COPY --from=composer-deps /app ./
COPY --from=vite-builder /app/public/build ./public/build

# Configuración de Caddy
COPY Caddyfile /etc/caddy/Caddyfile
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]
