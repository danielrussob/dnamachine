# WTF?

Simple Ubuntu 18.04 for devel with:

- php-fpm 5.6, 7.1, 7.2, 7.3
- composer
- nginx 
- ssh access with root:root

to allow remote php execution for debug

# Usage

`docker build -t machine .`

`docker run -d -it -p 22:22 -p 80:80 -p 443:443 --name=machine machine`