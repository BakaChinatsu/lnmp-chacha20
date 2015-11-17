#!/bin/bash

Upgrade_Nginx()
{
    # You can add other modules arguments to nginx_modules_arguments variable#
    Nginx_Modules_Arguments=""
    Cur_Nginx_Version=`/usr/local/nginx/sbin/nginx -v 2>&1 | cut -c22-`
    Cur_Pgs_Version=`/usr/local/nginx/sbin/nginx -V 2>&1 | cut -c 276-284` #How to find out the current pagespeed vertion?#先这样测试一下。。 。
    Cur_Lbs_Version=`/usr/local/nginx/sbin/nginx -V 2>&1 | cut -c 217-221`
    
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
    
     Pgs_Version=""
    #if [ "${Nginx_Version}" != "" ]; then
        echo "Current ngx_pagespeed Version:${Cur_Pgs_Version}"
        echo "You can get version number from https://github.com/pagespeed/ngx_pagespeed/"
        read -p "Please enter pagespeed version you want, (example: 1.9.32.10 ): " Pgs_Version
        #fi
        
#        if ["${Pgs_Version}" < "1.9.32.10"]; then
#        echo "Error: You must enter a pagespeed version or the version must > 1.9.32.10"
#        exit 1    
        #statements
#    fi

Lbs_Version=""
echo "Current Libressl Version:${Cur_Lbs_Version}"
        echo "You can get version number from http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/"
        read -p "Please enter pagespeed version you want, (example: 2.3.0 ): " Lbs_Version
        
    echo "+---------------------------------------------------------+"
    echo "|    You will upgrade nginx version to ${Nginx_Version}   |"
    echo "|            with pagespeed ${Pgs_Version} and Libressl ${Lbs_Version}   |"
    echo "+---------------------------------------------------------+"

    Press_Start

    echo "============================check files=================================="
    cd ${cur_dir}/addone
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

        if [ -s v${Pgs_Version}-beta.tar.gz ]; then
        echo "pagespeed,v${Nginx_Version}-beta.tar.gz [found]"
    else
        echo "Error: pagespeed,v${Nginx_Version}-beta.tar.gz not found!!!download now......"
        wget -c https://github.com/pagespeed/ngx_pagespeed/archive/v${Pgs_Version}.tar.gz
        wget -c https://dl.google.com/dl/page-speed/psol/${Pgs_Version}.tar.gz
        if [ $? -eq 0 ]; then
            echo "Download pagespeed,v${Pgs_Version}-beta.tar.gz successfully!"
        else
            echo "You enter Pagespeed Version was:"v${Pgs_Version}-beta
            Echo_Red "Error! You entered a wrong version number, please check!"
            sleep 5
            exit 1
        fi
    fi
    
    if [ -s libressl-${Lbs_Version}.tar.gz ]; then
        echo "Libressl,${Lbs_Version}.tar.gz [found]"
    else
        echo "Error: Libressl,${Lbs_Version}.tar.gz not found!!!download now......"
        wget -c http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-${Lbs_Version}.tar.gz
        if [ $? -eq 0 ]; then
            echo "Download Libressl,${Lbs_Version}.tar.gz successfully!"
        else
            echo "You enter Libressl Version was:"${Lbs_Version}
            Echo_Red "Error! You entered a wrong version number, please check!"
            sleep 5
            exit 1
        fi
    fi
    echo "============================check files=================================="

    cd ${cur_dir}/addone
    tar zxf libressl-${Lbs_Version}.tar.gz
    tar xfz v${Pgs_Version}-beta.tar.gz -C /usr/local/nginx/modules --no-same-owner
    tar xfz ${Pgs_Version}.tar.gz -C /usr/local/nginx/modules/ngx_pagespeed-${Pgs_Version}-beta --no-same-owner

    find /usr/local/nginx/modules/ngx_pagespeed-${Pgs_Version}-beta/ -type d -exec chmod +rx {} \;
    find /usr/local/nginx/modules/ngx_pagespeed-${Pgs_Version}-beta/ -type f -exec chmod +r {} \;

    tar zxf nginx-${Nginx_Version}.tar.gz

        ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6 --with-http_v2_module --with-openssl=../libressl${Lbs_Version}/ --add-module=/usr/local/nginx/modules/ngx_pagespeed-${Pgs_Version}-beta --with-http_sub_module --with-http_sub_module --with-ld-opt="-lrt" ${NginxMAOpt}
        #install if Nginx_Version > 1.9.5
        
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
