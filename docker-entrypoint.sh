#!/bin/sh

# Wait for MySQL to be ready
while ! mysqladmin ping -h db --silent; do
    echo "Waiting for database connection..."
    sleep 2
done

# Run migrations and seeds
php artisan migrate --force
php artisan db:seed --force

# Start PHP-FPM
#exec php-fpm