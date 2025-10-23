#!/bin/bash

# Définir les permissions nécessaires
chmod -R 775 /var/www/html/storage
chmod -R 775 /var/www/html/bootstrap/cache
chown -R www-data:www-data /var/www/html

# Vérifier si nous sommes dans /var/www/html
if [ ! -d "/var/www/html" ]; then
    echo "Error: /var/www/html directory not found"
    exit 1
fi

cd /var/www/html

# Copier le fichier .env.production vers .env si en production
if [ "$APP_ENV" = "production" ]; then
    echo "Setting up production environment..."
    if [ -f .env.production ]; then
        cp .env.production .env
        echo "Copied .env.production to .env"
    else
        echo "Warning: .env.production not found"
        ls -la
    fi
fi

# Créer le fichier .env si nécessaire
if [ ! -f .env ]; then
    echo "Creating .env file..."
    cat > .env << EOF
APP_NAME="Gestion Comptes API"
APP_ENV=${APP_ENV:-production}
APP_KEY=${APP_KEY}
APP_DEBUG=${APP_DEBUG:-false}
APP_URL=${APP_URL:-http://localhost}

LOG_CHANNEL=${LOG_CHANNEL:-stack}
LOG_LEVEL=${LOG_LEVEL:-error}

DB_CONNECTION=${DB_CONNECTION:-pgsql}
DB_HOST=${DB_HOST}
DB_PORT=${DB_PORT:-5432}
DB_DATABASE=${DB_DATABASE}
DB_USERNAME=${DB_USERNAME}
DB_PASSWORD=${DB_PASSWORD}

L5_SWAGGER_CONST_HOST=${APP_URL}
EOF
fi

# Installer les dépendances de composer en mode production si nécessaire
if [ "$APP_ENV" = "production" ]; then
    echo "Installing composer dependencies..."
    composer install --no-dev --optimize-autoloader
fi

# Générer la clé d'application si elle n'existe pas
if [ -z "$APP_KEY" ]; then
    echo "Generating application key..."
    php artisan key:generate --force
fi

# Optimiser l'application en production
if [ "$APP_ENV" = "production" ]; then
    echo "Optimizing application..."
    php artisan config:cache
    php artisan route:cache
    php artisan view:cache
fi

# Exécuter les migrations
echo "Running migrations..."
php artisan migrate --force || echo "Migration failed, continuing..."

# Générer la documentation Swagger
echo "Generating Swagger documentation..."
php artisan l5-swagger:generate || echo "Swagger generation failed, continuing..."

# S'assurer que le storage est correctement lié
php artisan storage:link || echo "Storage link failed, continuing..."

# Démarrer PHP-FPM
echo "Starting PHP-FPM..."
php-fpm -D

# Attendre que PHP-FPM soit prêt
sleep 2

# Démarrer Nginx
echo "Starting Nginx..."
nginx -g 'daemon off;'