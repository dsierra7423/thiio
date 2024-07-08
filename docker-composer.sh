#!/bin/sh

composer install --no-interaction --no-scripts --prefer-dist && php artisan key:generate