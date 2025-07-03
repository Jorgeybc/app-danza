FROM php:8.2-fpm

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    unzip curl libzip-dev zip git npm nodejs supervisor \
    && docker-php-ext-install pdo pdo_mysql zip

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Instalar Caddy (versión estable desde repositorios de Debian)
RUN apt-get update && apt-get install -y debian-keyring debian-archive-keyring curl gnupg2 && \
    curl -fsSL https://dl.cloudsmith.io/public/caddy/stable/gpg.key | gpg --dearmor -o /usr/share/keyrings/caddy.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/caddy.gpg] https://dl.cloudsmith.io/public/caddy/stable/deb/debian any-version main" > /etc/apt/sources.list.d/caddy.list && \
    apt-get update && apt-get install -y caddy

# Establecer directorio de trabajo
WORKDIR /var/www/html

# Copiar archivos del proyecto
COPY . .

# Instalar dependencias de PHP y JS
RUN composer install --no-dev --optimize-autoloader
RUN npm install && npm run build

# Permisos
RUN chmod -R ug+rwx storage bootstrap/cache && \
    chown -R www-data:www-data storage bootstrap/cache


# Configurar supervisord
COPY ./supervisord.conf /etc/supervisord.conf
COPY ./Caddyfile /etc/Caddyfile

EXPOSE 80
RUN touch database/database.sqlite && \
    chmod -R 775 database && \
    chown -R www-data:www-data database

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
