#!/bin/bash
#PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
#export PATH

Install_Nginx()
{
    Echo_Blue "Installing Nginx_1.10.0 with Pagespeed-v1.11.33.2-beta,Libressl-2.3.0... "
    groupadd www
    useradd -s /sbin/nologin -g www www

    cd /etc/ssl/certs
    openssl dhparam -out dhparam.pem 2048

    cd ${cur_dir}/addone
    if [ -s v1.11.33.2-beta.tar.gz ]; then
        echo "pagespeed_v1.11.33.2-beta.tar.gz [found]"
    else
        echo "Error: pagespeed_v1.11.33.2-beta.tar.gz not found!!!download now......"
        wget -c https://github.com/pagespeed/ngx_pagespeed/archive/v1.11.33.2-beta.tar.gz
        fi
    if [ -s 1.11.33.2.tar.gz ]; then
        echo "pagespeed_1.11.33.2.tar.gz [found]"
    else
        echo "Error: pagespeed_1.11.33.2.tar.gz not found!!!download now......"
    wget -c https://dl.google.com/dl/page-speed/psol/1.11.33.2.tar.gz
    fi
    
    if [ -s libressl-2.4.1.tar.gz ]; then
        echo "libressl-2.4.1.tar.gz [found]"
    else
        echo "Error: libressl-2.4.1.tar.gz not found!!!download now......"
    wget -c http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-2.4.1.tar.gz
    fi
    
    if [ -s nginx-1.10.0.tar.gz ]; then
        echo "nginx-1.10.0.tar.gz [found]"
    else
        echo "Error: nginx-1.10.0.tar.gz not found!!!download now......"
    wget -c http://nginx.org/download/nginx-1.10.0.tar.gz
    fi
    
    tar zxf libressl-2.4.1.tar.gz

    mkdir -p /usr/local/nginx/modules
    tar xvfvz v1.11.33.2-beta.tar.gz -C /usr/local/nginx/modules --no-same-owner
    tar xvfvz 1.11.33.2.tar.gz -C /usr/local/nginx/modules/ngx_pagespeed-1.11.33.2-beta --no-same-owner
    find /usr/local/nginx/modules/ngx_pagespeed-1.11.33.2-beta/ -type d -exec chmod +rx {} \;
    find /usr/local/nginx/modules/ngx_pagespeed-1.11.33.2-beta/ -type f -exec chmod +r {} \;
    
    tar zxf nginx-1.10.0.tar.gz
    cd nginx-1.10.0
    ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6 --with-http_v2_module --with-openssl=../libressl-2.3.0/ --add-module=/usr/local/nginx/modules/ngx_pagespeed-1.11.33.2-beta --with-http_sub_module --with-http_sub_module --with-ld-opt="-lrt" ${NginxMAOpt}
    #--add-module=/usr/local/nginx/modules/ngx_pagespeed-1.11.33.2-beta
    make && make install
    cd ../
    
    ln -sf /usr/local/nginx/sbin/nginx /usr/bin/nginx
    
    rm -f /usr/local/nginx/conf/nginx.conf
    
    cd ${cur_dir}
    if [ "${Stack}" = "lnmpa" ]; then
        \cp conf/nginx_a.conf /usr/local/nginx/conf/nginx.conf
        \cp conf/proxy.conf /usr/local/nginx/conf/proxy.conf
    else
        \cp conf/nginx.conf /usr/local/nginx/conf/nginx.conf
    fi
    \cp conf/rewrite/dabr.conf /usr/local/nginx/conf/dabr.conf
    \cp conf/rewrite/discuz.conf /usr/local/nginx/conf/discuz.conf
    \cp conf/rewrite/sablog.conf /usr/local/nginx/conf/sablog.conf
    \cp conf/rewrite/typecho.conf /usr/local/nginx/conf/typecho.conf
    \cp conf/rewrite/typecho2.conf /usr/local/nginx/conf/typecho2.conf
    \cp conf/rewrite/wordpress.conf /usr/local/nginx/conf/wordpress.conf
    \cp conf/rewrite/discuzx.conf /usr/local/nginx/conf/discuzx.conf
    \cp conf/rewrite/none.conf /usr/local/nginx/conf/none.conf
    \cp conf/rewrite/wp2.conf /usr/local/nginx/conf/wp2.conf
    \cp conf/rewrite/phpwind.conf /usr/local/nginx/conf/phpwind.conf
    \cp conf/rewrite/shopex.conf /usr/local/nginx/conf/shopex.conf
    \cp conf/rewrite/dedecms.conf /usr/local/nginx/conf/dedecms.conf
    \cp conf/rewrite/drupal.conf /usr/local/nginx/conf/drupal.conf
    \cp conf/rewrite/ecshop.conf /usr/local/nginx/conf/ecshop.conf
    \cp conf/pathinfo.conf /usr/local/nginx/conf/pathinfo.conf
    \cp conf/enable-php.conf /usr/local/nginx/conf/enable-php.conf
    \cp conf/enable-php-pathinfo.conf /usr/local/nginx/conf/enable-php-pathinfo.conf
    \cp conf/proxy-pass-php.conf /usr/local/nginx/conf/proxy-pass-php.conf
    \cp conf/enable-ssl-example.conf /usr/local/nginx/conf/enable-ssl-example.conf
    
    mkdir -p /home/wwwroot/default
    chmod +w /home/wwwroot/default
    mkdir -p /home/wwwlogs
    chmod 777 /home/wwwlogs
    
    cp conf/nginx_error.log /home/wwwlogs
    
    chown -R www:www /home/wwwroot/default
    mkdir -p /path/baka
    cp -R  ${cur_dir}/conf/vhost /usr/local/nginx/conf/
    
    if [ "${Stack}" = "lnmp" ]; then
    cat >/home/wwwroot/default/.user.ini<<EOF
open_basedir=/home/wwwroot/default:/tmp/:/proc/
EOF
    chmod 644 /home/wwwroot/default/.user.ini
    chattr +i /home/wwwroot/default/.user.ini
    fi

    \cp init.d/init.d.nginx /etc/init.d/nginx
    chmod +x /etc/init.d/nginx

    if [ "${SelectMalloc}" = "3" ]; then
        mkdir /tmp/tcmalloc
        chown -R www:www /tmp/tcmalloc
        sed -i '/nginx.pid/a\
google_perftools_profiles /tmp/tcmalloc;' /usr/local/nginx/conf/nginx.conf
    fi
}
