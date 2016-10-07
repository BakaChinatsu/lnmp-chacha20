#!/bin/bash
#PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
#export PATH
$libresslver=2.5.0
$nginxver=1.11.4
$pagespeedver=1.11.33.2

apt-get install libpcre3 libpcre3-dev
wget -c https://github.com/pagespeed/ngx_pagespeed/archive/v$pagespeedver-beta.tar.gz
wget -c https://dl.google.com/dl/page-speed/psol/$pagespeedver.tar.gz
wget -c http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-$libresslver.tar.gz
wget -c http://nginx.org/download/nginx-$nginxver.tar.gz
tar zxf libressl-$libresslver.tar.gz

mkdir -p /usr/local/nginx/modules
    
tar zxf nginx-$nginxver.tar.gz
cd nginx-$nginxver

groupadd www
useradd -s /sbin/nologin -g www www

cd /etc/ssl/certs
openssl dhparam -out dhparam.pem 1024

./configure --user=www --group=www --prefix=/usr/local/nginx --sbin-path=/usr/sbin/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6 --with-http_v2_module --with-openssl=../libressl-$libresslver/ --with-http_sub_module --with-ld-opt="-lrt"

make && make install

systemctl enable nginx.service
systemctl unmask nginx.service
