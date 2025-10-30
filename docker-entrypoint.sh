#!/bin/sh

echo "Waiting for database to be ready..."
while ! pg_isready -h $DB_HOST -p $DB_PORT -U $DB_USERNAME; do
  echo "Database is unavailable - sleeping"
  sleep 1
done

echo "Database is up - executing migrations"
php artisan migrate --force

echo "Seeding database with initial data"
php artisan db:seed --force

echo "Fixing storage permissions"
chmod -R 775 storage

echo "Clearing and caching configuration for production"
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear

echo "Installing Passport clients if not exist"
php artisan passport:install --force

php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "Starting Laravel application..."
exec "$@"
