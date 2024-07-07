FROM php:8.1-fpm-alpine



# Copy composer.lock and composer.json
COPY composer.lock composer.json /var/www/

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apk --no-cache add \
    build-base \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    zip \
    jpegoptim \
    optipng \
    pngquant \
    gifsicle \
    vim \
    unzip \
    git \
    curl \
    oniguruma-dev \
    libzip-dev \
    gd-dev \
    shadow \
    bash \
    mysql-client


# Create the www group and user
RUN addgroup -g 1000 www && \
    adduser -u 1000 -D -S -G www -s /bin/bash www

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install pdo_mysql zip exif pcntl gd intl

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer


COPY . /var/www
COPY --chown=www:www . /var/www

RUN composer install && \
    php artisan key:generate

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]