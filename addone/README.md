这个LNMP脚本为魔改版，由 @雨宮千夏 修改，在安装前请执行以下命令

-------以下代码已被install-nginx.conf替代-------

cd addone/
sudo tar zxvf libresssl-2.3.0.tar.gz

sudo mkdir -p /usr/local/nginx/modules
sudo tar xvfvz v1.9.32.10-beta.tar.gz -C /usr/local/nginx/modules --no-same-owner
sudo tar xvfvz 1.9.32.10.tar.gz -C /usr/local/nginx/modules/ngx_pagespeed-1.9.32.10-beta --no-same-owner
sudo find /usr/local/nginx/modules/ngx_pagespeed-1.9.32.10-beta/ -type d -exec chmod +rx {} \;
sudo find /usr/local/nginx/modules/ngx_pagespeed-1.9.32.10-beta/ -type f -exec chmod +r {} \;

-------以上代码已被install-nginx.conf替代-------

安装完毕后将达到以下效果：

1.使用CHACHA20-POLY1305加密方法作为首要加密方法，并启用HSTS。
2.在Qualys SSL Labs 的 Server Test中得到A+
3.凭借SPDY和PageSpeed获得极高的页面加载速度
4.为百度等对https支持不好的搜索引擎进行单独优化
5.其它所见及所得的好处
6.无情的抛弃那些顽固不化的万年IE6和Android 2.3党
