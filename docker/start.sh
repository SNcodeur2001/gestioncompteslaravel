#!/bin/bash

# Attendre que la base de données soit prête (si nécessaire)
# echo "Waiting for database..."
# while ! pg_isready -h $DB_HOST -p $DB_PORT -U $DB_USERNAME; do
#   sleep 1
# done
# echo "Database is ready!"

# Exécuter les migrations et seeders si en production
if [ "$APP_ENV" = "production" ]; then
    echo "Running migrations..."
    php artisan migrate --force || echo "Migration failed, continuing..."
    echo "Running seeders..."
    php artisan db:seed --force || echo "Seeding failed, continuing..."
fi

# Générer la clé d'application si elle n'existe pas
if [ ! -f .env ]; then
    echo "Generating application key..."
    php artisan key:generate --force
fi

# Créer le fichier .env si nécessaire avec les variables d'environnement
if [ ! -f .env ]; then
    echo "Creating .env file..."
    cat > .env << EOF
APP_NAME="API Bancaire - Gestion des Comptes"
APP_ENV=${APP_ENV:-production}
APP_KEY=${APP_KEY}
APP_DEBUG=${APP_DEBUG:-false}
APP_URL=${APP_URL:-http://localhost}

DB_CONNECTION=${DB_CONNECTION:-pgsql}
DB_HOST=${DB_HOST}
DB_PORT=${DB_PORT:-5432}
DB_DATABASE=${DB_DATABASE}
DB_USERNAME=${DB_USERNAME}
DB_PASSWORD=${DB_PASSWORD}

L5_SWAGGER_CONST_HOST=${L5_SWAGGER_CONST_HOST:-http://localhost}
EOF
fi

# Générer la documentation Swagger
echo "Generating Swagger documentation..."
php artisan l5-swagger:generate || echo "Swagger generation failed, continuing..."

# Démarrer PHP-FPM en arrière-plan
php-fpm -D

# Attendre que PHP-FPM soit prêt
sleep 2

# Démarrer Nginx
nginx -g 'daemon off;'