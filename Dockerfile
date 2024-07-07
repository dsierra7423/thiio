FROM php:8.1-fpm-alpine



# Copy composer.lock and composer.json
COPY composer.lock composer.json /var/www/

# Set working directory
WORKDIR /var/www

# Install dependencies
#3RUN apt-get update && apt-get install -y \
 #   build-essential \
 #   libpng-dev \
 #   libjpeg62-turbo-dev \
 #   libfreetype6-dev \
 #   locales \
 #   zip \
 #   jpegoptim optipng pngquant gifsicle \
 #   vim \
 #   unzip \
 #   git \
 #   curl \
 #   libonig-dev \
 #   libzip-dev \
 #   libgd-dev

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
    bash

# Clear cache
#RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-configure gd --with-external-gd
RUN docker-php-ext-install gd

# Install composer
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install pdo_mysql zip exif pcntl gd intl


# Add user for laravel application
#RUN groupadd -g 1000 www
#RUN useradd -u 1000 -ms /bin/bash -g www www

# Create the www group and user
RUN addgroup -g 1000 www && \
    adduser -u 1000 -D -S -G www -s /bin/bash www

COPY . /var/www
COPY --chown=www:www . /var/www

RUN composer install && \
    php artisan key:generate

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]