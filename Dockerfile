FROM php:7.2-apache
LABEL maintainer="Marc Wickenden <marc@4armed.com>"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq \
        libapache2-modsecurity \
        libyaml-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
	net-tools \
	netcat-traditional \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo pdo_mysql \
    && pecl install mcrypt-1.0.1 && docker-php-ext-enable mcrypt \
    && rm -rf /var/lib/apt/lists/*
