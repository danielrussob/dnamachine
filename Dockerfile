FROM ubuntu:18.04

#
#--------------------------------------------------------------------------
# Digging the foundations
#--------------------------------------------------------------------------
#

RUN apt-get update -yqq && \
    apt-get install -y \
    mysql-client \
    vim \
    telnet \
    netcat \
    git-core \
    nano \
    zip \
    unzip \
    unzip \
	openssh-client \
	openssh-server && \
    rm -rf /var/lib/apt/lists/* && apt-get purge -y --auto-remove

RUN apt-get update -yqq && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common && \
    rm -rf /var/lib/apt/lists/* && apt-get purge -y --auto-remove

#
#--------------------------------------------------------------------------
# Building batcave
#--------------------------------------------------------------------------
#

ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -yqq && \
    apt-get install -y \
    mysql-server \
    mysql-client \
    nginx && \
    rm -rf /var/lib/apt/lists/* && apt-get purge -y --auto-remove

RUN add-apt-repository ppa:ondrej/php && apt-get update -yqq && \
    apt-get install -y \
    php7.1-common \
    php7.1-cli \
    php7.1-fpm \
    php7.1-opcache \
    php7.1-gd \
    php7.1-mysql \
    php7.1-curl \
    php7.1-intl \
    php7.1-xsl \
    php7.1-mbstring \
    php7.1-zip \
    php7.1-bcmath \
    php7.1-soap  \
    php7.1-mcrypt && \
    rm -rf /var/lib/apt/lists/* && apt-get purge -y --auto-remove

RUN add-apt-repository ppa:ondrej/php && apt-get update -yqq && \
    apt-get install -y \
    php7.2-common \
    php7.2-cli \
    php7.2-fpm \
    php7.2-opcache \
    php7.2-gd \
    php7.2-mysql \
    php7.2-curl \
    php7.2-intl \
    php7.2-xsl \
    php7.2-mbstring \
    php7.2-zip \
    php7.2-bcmath \
    php7.2-soap && \
    rm -rf /var/lib/apt/lists/* && apt-get purge -y --auto-remove

RUN add-apt-repository ppa:ondrej/php && apt-get update -yqq && \
    apt-get install -y \
    php7.3-common \
    php7.3-cli \
    php7.3-fpm \
    php7.3-opcache \
    php7.3-gd \
    php7.3-mysql \
    php7.3-curl \
    php7.3-intl \
    php7.3-xsl \
    php7.3-mbstring \
    php7.3-zip \
    php7.3-bcmath \
    php7.3-soap && \
    rm -rf /var/lib/apt/lists/* && apt-get purge -y --auto-remove

RUN add-apt-repository ppa:ondrej/php && apt-get update -yqq && \
    apt-get install -y \
    php5.6-common \
    php5.6-cli \
    php5.6-fpm \
    php5.6-opcache \
    php5.6-gd \
    php5.6-mysql \
    php5.6-curl \
    php5.6-intl \
    php5.6-xsl \
    php5.6-mbstring \
    php5.6-zip \
    php5.6-bcmath \
    php5.6-soap  \
    php5.6-mcrypt && \
    rm -rf /var/lib/apt/lists/* && apt-get purge -y --auto-remove

RUN add-apt-repository ppa:ondrej/php && apt-get update -yqq && \
    apt-get install -y php-xdebug && \
    rm -rf /var/lib/apt/lists/* && apt-get purge -y --auto-remove

#
#--------------------------------------------------------------------------
# Sharpen Swiss Army Knives
#--------------------------------------------------------------------------
#

RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer

RUN apt-get update -yqq && \
    apt-get install -y nodejs npm && \
    rm -rf /var/lib/apt/lists/* && apt-get purge -y --auto-remove

#
#--------------------------------------------------------------------------
# Attach some template
#--------------------------------------------------------------------------
#

RUN mkdir /etc/nginx/sites-template
ADD nginx/laravel.conf /etc/nginx/sites-template/laravel.conf
ADD nginx/magento1.conf /etc/nginx/sites-template/magento1.conf
ADD nginx/magento2.conf /etc/nginx/sites-template/magento2.conf

#
#--------------------------------------------------------------------------
# Spreading ass
#--------------------------------------------------------------------------
#

RUN echo 'root:root' | chpasswd && \
    echo 'www-data:www-data' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    echo "AllowUsers www-data root" >> /etc/ssh/sshd_config

RUN usermod -u 1000 www-data -s /bin/bash
WORKDIR /var/www

EXPOSE 22 80 443
ENTRYPOINT service ssh restart && bash