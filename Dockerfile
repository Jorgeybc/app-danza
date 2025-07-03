FROM php:8.2-fpm

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    unzip curl libzip-dev zip git npm nodejs supervisor \
    && docker-php-ext-install pdo pdo_mysql zip

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Instala Caddy de forma oficial (recomendado en Render)
RUN apt-get update && apt-get install -y debian-keyring debian-archive-keyring curl gnupg && \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-archive-keyring.gpg && \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list && \
    apt-get update && apt-get install -y caddy


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

RUN ln -sf $(which node) /usr/bin/node


CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
