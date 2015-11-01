#!/bin/bash
tar zxvf libresssl-2.3.0.tar.gz
mkdir -p /usr/local/nginx/modules
tar xvfvz v1.9.32.10-beta.tar.gz -C /usr/local/nginx/modules --no-same-owner
tar xvfvz 1.9.32.10.tar.gz -C /usr/local/nginx/modules/ngx_pagespeed-1.9.32.10-beta --no-same-owner
find /usr/local/nginx/modules/ngx_pagespeed-1.9.32.10-beta/ -type d -exec chmod +rx {} \;
find /usr/local/nginx/modules/ngx_pagespeed-1.9.32.10-beta/ -type f -exec chmod +r {} \;
