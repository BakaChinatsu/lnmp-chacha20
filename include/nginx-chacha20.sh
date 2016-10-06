#!/bin/bash
#PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
#export PATH
$libresslver=2.5.0
$nginxver=1.11.4
$pagespeedver=1.11.33.2


Install_Nginx()
{
<<<<<<< HEAD
<<<<<<< HEAD
    Echo_Blue "Installing Nginx with Pagespeed-v$pagespeedver-beta,Libressl... "
=======
    Echo_Blue "Installing Nginx_1.11.4 with Pagespeed-v1.11.33.2-beta,Libressl-2.5.0... "
>>>>>>> 0e30784... 更新Nginx,libressl的版本
=======
    Echo_Blue "Installing Nginx with Pagespeed-v$pagespeedver-beta,Libressl... "
>>>>>>> a47207e... 修复上个提交所产生的bug，新增变量
    groupadd www
    useradd -s /sbin/nologin -g www www

    cd /etc/ssl/certs
    openssl dhparam -out dhparam.pem 4096

    cd ${cur_dir}/addone
    if [ -s v$pagespeedver-beta.tar.gz ]; then
        echo "pagespeed.tar.gz [found]"
    else
        echo "Error: pagespeed_v$pagespeedver-beta.tar.gz not found!!!download now......"
        wget -c https://github.com/pagespeed/ngx_pagespeed/archive/v$pagespeedver-beta.tar.gz
        fi
    if [ -s $pagespeedver.tar.gz ]; then
        echo "pagespeed.tar.gz [found]"
<<<<<<< HEAD
    else
        echo "Error: pagespeed.tar.gz not found!!!download now......"
    wget -c https://dl.google.com/dl/page-speed/psol/$pagespeedver.tar.gz
    fi
    
<<<<<<< HEAD
    if [ -s libressl-$libresslver.tar.gz ]; then
        echo "libressl.tar.gz [found]"
    else
        echo "Error: libressl-2.4.1.tar.gz not found!!!download now......"
    wget -c http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-$libresslver.tar.gz
    fi
    
    if [ -s nginx-$nginxver.tar.gz ]; then
        echo "nginx.tar.gz [found]"
    else
        echo "Error: nginx.tar.gz not found!!!download now......"
    wget -c http://nginx.org/download/nginx-$nginxver.tar.gz
    fi
    
    tar zxf libressl-$libresslver.tar.gz 
=======
    if [ -s libressl-2.5.0.tar.gz ]; then
        echo "libressl-2.5.0.tar.gz [found]"
=======
    else
        echo "Error: pagespeed.tar.gz not found!!!download now......"
    wget -c https://dl.google.com/dl/page-speed/psol/$pagespeedver.tar.gz
    fi
    
    if [ -s libressl-$libresslver.tar.gz ]; then
        echo "libressl.tar.gz [found]"
>>>>>>> a47207e... 修复上个提交所产生的bug，新增变量
    else
        echo "Error: libressl-2.4.1.tar.gz not found!!!download now......"
    wget -c http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-$libresslver.tar.gz
    fi
    
    if [ -s nginx-$nginxver.tar.gz ]; then
        echo "nginx.tar.gz [found]"
    else
        echo "Error: nginx.tar.gz not found!!!download now......"
    wget -c http://nginx.org/download/nginx-$nginxver.tar.gz
    fi
    
<<<<<<< HEAD
    tar zxf libressl-2.5.0.tar.gz
>>>>>>> 0e30784... 更新Nginx,libressl的版本
=======
    tar zxf libressl-$libresslver.tar.gz 
>>>>>>> a47207e... 修复上个提交所产生的bug，新增变量

    mkdir -p /usr/local/nginx/modules
    tar xvfvz v$pagespeedver-beta.tar.gz -C /usr/local/nginx/modules --no-same-owner
    tar xvfvz $pagespeedver.tar.gz -C /usr/local/nginx/modules/ngx_pagespeed-$pagespeedver-beta --no-same-owner
    find /usr/local/nginx/modules/ngx_pagespeed-$pagespeedver-beta/ -type d -exec chmod +rx {} \;
    find /usr/local/nginx/modules/ngx_pagespeed-$pagespeedver-beta/ -type f -exec chmod +r {} \;
    
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> a47207e... 修复上个提交所产生的bug，新增变量
    tar zxf nginx-$nginxver.tar.gz
    cd nginx-$nginxver
    ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6 --with-http_v2_module --with-openssl=../libressl-$libresslver/ --add-module=/usr/local/nginx/modules/ngx_pagespeed-$pagespeedver-beta --with-http_sub_module --with-ld-opt="-lrt" ${NginxMAOpt}
    #--add-module=/usr/local/nginx/modules/ngx_pagespeed-$pagespeedver-beta
<<<<<<< HEAD
=======
    tar zxf nginx-1.11.4.tar.gz
    cd nginx-1.11.1
    ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6 --with-http_v2_module --with-openssl=../libressl-2.4.1/ --add-module=/usr/local/nginx/modules/ngx_pagespeed-1.11.33.2-beta --with-http_sub_module --with-ld-opt="-lrt" ${NginxMAOpt}
    #--add-module=/usr/local/nginx/modules/ngx_pagespeed-1.11.33.2-beta
>>>>>>> 0e30784... 更新Nginx,libressl的版本
=======
>>>>>>> a47207e... 修复上个提交所产生的bug，新增变量
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
