FROM php:8.2-fpm

# Installation des dépendances système
RUN apt-get update && apt-get install -y \
    nginx \
    libpq-dev \
    git \
    zip \
    unzip \
    && docker-php-ext-install pdo pdo_pgsql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configurer PHP
COPY docker/php/php.ini /usr/local/etc/php/conf.d/app.ini

# Configuration du répertoire de travail
WORKDIR /var/www/html

# Installation de Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copier les fichiers de l'application
COPY . .
COPY .env.production .env.production

# Installer les dépendances de Composer
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Configurer Nginx
COPY docker/nginx/conf.d/app.conf /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/sites-enabled/default 2>/dev/null || true

# Définir les permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 . \
    && chmod -R 775 storage bootstrap/cache \
    && find . -type f -exec chmod 644 {} \; \
    && find . -type d -exec chmod 755 {} \; \
    && chmod 775 docker/start.sh

# Copier le script de démarrage
COPY docker/start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 80

# Définir les variables d'environnement par défaut
ENV APP_ENV=production \
    APP_DEBUG=false \
    LOG_CHANNEL=stack \
    LOG_LEVEL=error \
    DB_CONNECTION=pgsql \
    CACHE_DRIVER=file \
    SESSION_DRIVER=file \
    QUEUE_CONNECTION=sync

# Utiliser le script de démarrage
CMD ["/usr/local/bin/start.sh"]