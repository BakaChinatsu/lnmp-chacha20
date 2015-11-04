#!/bin/bash

Upgrade_Nginx()
{
    # You can add other modules arguments to nginx_modules_arguments variable#
    Nginx_Modules_Arguments=""
    Cur_Nginx_Version=`/usr/local/nginx/sbin/nginx -v 2>&1 | cut -c22-`

    if [ -s /usr/local/include/jemalloc/jemalloc.h ] && /usr/local/nginx/sbin/nginx -V 2>&1|grep -Eqi 'ljemalloc'; then
        NginxMAOpt="--with-ld-opt='-ljemalloc'"
    elif [ -s /usr/local/include/gperftools/tcmalloc.h ] && grep -Eqi "google_perftools_profiles" /usr/local/nginx/conf/nginx.conf; then
        NginxMAOpt='--with-google_perftools_module'
    else
        NginxMAOpt=""
    fi

    Nginx_Version=""
    echo "Current Nginx Version:${Cur_Nginx_Version}"
    echo "You can get version number from http://nginx.org/en/download.html"
    read -p "Please enter nginx version you want, (example: 1.9.5 ): " Nginx_Version
    if [ "${Nginx_Version}" = "" ]; then
        echo "Error: You must enter a nginx version!!"
        exit 1
    fi

    if [ "${Nginx_Version}" > "1.9.5" ]; then
        echo "Current ngx_pagespeed Version:${Cur_Pgs_Version}"
        echo "You can get version number from https://github.com/pagespeed/ngx_pagespeed/"
        read -p "Please enter pagespeed version you want, (example: 1.9.32.10 ): " Pgs_Version
    fi

    if ["${Pgs_Version}" < "1.9.32.1"]; then
        echo "Error: You must enter a pagespeed version or the version must > 1.9.32.1"
        exit 1    
        #statements
    fi
    echo "+---------------------------------------------------------+"
    echo "|    You will upgrade nginx version to ${Nginx_Version},with pagespeed ${Pgs_Version}"
    echo "+---------------------------------------------------------+"

    Press_Start

    echo "============================check files=================================="
    cd ${cur_dir}/src
    if [ -s nginx-${Nginx_Version}.tar.gz ]; then
        echo "nginx-${Nginx_Version}.tar.gz [found]"
    else
        echo "Error: nginx-${Nginx_Version}.tar.gz not found!!!download now......"
        wget -c http://nginx.org/download/nginx-${Nginx_Version}.tar.gz
        if [ $? -eq 0 ]; then
            echo "Download nginx-${Nginx_Version}.tar.gz successfully!"
        else
            echo "You enter Nginx Version was:"${Nginx_Version}
            Echo_Red "Error! You entered a wrong version number, please check!"
            sleep 5
            exit 1
        fi
    fi
    echo "============================check files=================================="

    Tar_Cd nginx-${Nginx_Version}.tar.gz nginx-${Nginx_Version}
    if ["${Nginx_Version}" < "1.9.5"]; then
        ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_spdy_module --with-http_gzip_static_module --with-ipv6 --with-http_sub_module ${NginxMAOpt} ${Nginx_Modules_Arguments}
    make
    else
        ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6 --with-http_v2_module --with-openssl=../libressl-2.3.0/ --add-module=/usr/local/nginx/modules/ngx_pagespeed-1.9.32.10-beta --with-http_sub_module --with-http_sub_module --with-ld-opt="-lrt" ${NginxMAOpt}
        #install if Nginx_Version > 1.9.5
    fi
    mv /usr/local/nginx/sbin/nginx /usr/local/nginx/sbin/nginx.${Upgrade_Date}
    \cp objs/nginx /usr/local/nginx/sbin/nginx
    echo "Test nginx configure file..."
    /usr/local/nginx/sbin/nginx -t
    echo "upgrade..."
    make upgrade
    Echo_Green "======== upgrade nginx completed ======"
    echo "Program will display Nginx Version......"
    /usr/local/nginx/sbin/nginx -v
}