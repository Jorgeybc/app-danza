FROM php:8.2-fpm

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    unzip curl libzip-dev zip git npm nodejs supervisor \
    && docker-php-ext-install pdo pdo_mysql zip

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Instalar Caddy
RUN curl -s https://caddyserver.com/api/download?os=linux&arch=amd64 | tar -xz -C /usr/bin caddy && \
    chmod +x /usr/bin/caddy

# Establecer directorio de trabajo
WORKDIR /var/www/html

# Copiar archivos del proyecto
COPY . .

# Instalar dependencias de PHP y JS
RUN composer install --no-dev --optimize-autoloader
RUN npm install && npm run build

# Permisos
RUN chmod -R 775 storage bootstrap/cache

# Configurar supervisord
COPY ./supervisord.conf /etc/supervisord.conf
COPY ./Caddyfile /etc/Caddyfile

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
