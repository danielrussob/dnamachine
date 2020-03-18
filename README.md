# WTF?

Simple Ubuntu 18.04 for devel with:

- php-fpm 5.6, 7.1, 7.2, 7.3
- composer
- nginx 
- ssh access with root:root & www-data:www-data

to allow remote php execution for debug or just for dev

# Usage

`docker build -t machine .`

`docker run -d -it -p 22:22 -p 80:80 -p 443:443 --name=machine machine`


Inside container, launch to see stopped service (all)
`service --status-all`

To start service
`service service-name start`

To activate service at startup
`systemctl enable php7.1-fpm`

As developer you should activate at least: nginx, phpX.Y-fpm and attach to it by

`/var/run/php/php5.6-fpm.sock`

`/var/run/php/php7.1-fpm.sock`

`/var/run/php/php7.2-fpm.sock`

`/var/run/php/php7.3-fpm.sock`


Use private bin/dna to attach it automatically

To change default php version:
`update-alternatives --config php`

Attach c-php from private bin/dna to use different php version in different folder

To use external nginx container, you must switch php-fpm from socket to tcp

For database, use instead: dnafactory/mariadb (remember to attach external connection)
For phpmyadmin, use instead: dnafactory/phpmyadmin

# Host

`*.local.dnalab.online ----> 127.0.0.1`

