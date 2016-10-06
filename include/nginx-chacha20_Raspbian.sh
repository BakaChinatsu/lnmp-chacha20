apt-get install libpcre3 libpcre3-dev
wget -c https://github.com/pagespeed/ngx_pagespeed/archive/v1.11.33.2-beta.tar.gz
wget -c https://dl.google.com/dl/page-speed/psol/1.11.33.2.tar.gz
wget -c http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-2.5.0.tar.gz
wget -c http://nginx.org/download/nginx-1.11.4.tar.gz
tar zxf libressl-2.5.0.tar.gz

mkdir -p /usr/local/nginx/modules
    
tar zxf nginx-1.11.4.tar.gz
cd nginx-1.11.4

groupadd www
useradd -s /sbin/nologin -g www www

cd /etc/ssl/certs
openssl dhparam -out dhparam.pem 1024

./configure --user=www --group=www --prefix=/usr/local/nginx --sbin-path=/usr/sbin/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6 --with-http_v2_module --with-openssl=../libressl-2.4.1/ --with-http_sub_module --with-ld-opt="-lrt"

make && make install

systemctl enable nginx.service
systemctl unmask nginx.service
