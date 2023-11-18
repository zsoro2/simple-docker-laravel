FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    curl \
    vim \
    cron \
    supervisor \
    net-tools

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

#Copy php.ini
COPY /docker-compose/php/php.ini /usr/local/etc/php/conf.d/

WORKDIR /var/www

# Set scheduler
COPY /docker-compose/crontab/crontab /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab
RUN crontab /etc/cron.d/crontab
RUN touch /var/log/cron.log

COPY /docker-compose/supervisor/cron.conf /etc/supervisor/conf.d/cron.conf
COPY /docker-compose/supervisor/php-fpm.conf /etc/supervisor/conf.d/php-fpm.conf
COPY /docker-compose/supervisor/laravel-worker.conf /etc/supervisor/conf.d/laravel-worker.conf

CMD ["/usr/bin/supervisord", "-n"]

EXPOSE 9000

