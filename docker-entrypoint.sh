#!/bin/sh


# Run migrations and seeds
php artisan migrate --force
php artisan db:seed --force
