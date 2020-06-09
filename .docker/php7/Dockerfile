FROM php:7.4-fpm

RUN apt-get update

RUN apt-get install -y \
        git \
        libzip-dev \
        unzip \
        rsync \
        && docker-php-ext-install opcache \
        && docker-php-ext-install zip

# Install PostgreSQL + PDO
RUN apt-get install -y \
        libpq-dev \
        && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
        && docker-php-ext-install pdo pdo_pgsql pgsql

# Install intl
RUN apt-get install -y libicu-dev\
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

# Install GD
RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxpm-dev
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ \
                                --with-jpeg=/usr/include/ \
                                --with-xpm=/usr/include/ \
                                --enable-gd-jis-conv \
    && docker-php-ext-install gd

# Install xmlrpc and SOAP
RUN apt-get install libxml2 libxml2-dev -y
RUN docker-php-ext-install xmlrpc
RUN docker-php-ext-install soap

# Install cron
RUN apt-get install -y \
        cron
COPY config/crontab /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab
RUN crontab /etc/cron.d/crontab

COPY config/php.ini /usr/local/etc/php/conf.d/
WORKDIR /moodle
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]
