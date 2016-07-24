# lnmp-chacha20

## WARNING!
**本项目组不保证此魔改脚本可以稳定工作在所有Linux发行版上，因使用此脚本而导致的任何服务器宕机/冒烟以及数据损毁本项目组概不负责！**

##获取开发版

`apt-get install git` or `yum install git`

`apt-get install screen` or `yum install screen`

`wget -c http://soft.vpser.net/lnmp/lnmp1.2.tar.gz && tar zxf lnmp1.2.tar.gz && rm lnmp1.2.tar.gz`

`git clone https://github.com/BakaChinatsu/lnmp-chacha20.git`
  
 `cp -af lnmp-chacha20/* lnmp1.2/ && rm -rf lnmp-chacha20`
  
  `screen -S lnmp`
  
  `cd lnmp1.2 && ./install.sh lnmp`

## NOTICE
此脚本需要与<a href="http://lnmp.org" target="_blank">LNMP一键安装包</a>配合使用

安装完毕后，请将 `/home/wwwroot/default/p.php` 以及 `/home/wwwroot/default/phpinfo.php` 移动至不容易被猜到的文件夹

## RESULT
1. 使用 `CHACHA20-POLY1305` 加密方法作为首要加密方法，并启用 HSTS

2. 在 <a href="https://ssllabs.com" target="_blank">Qualys SSL Labs</a> 的 <a href="https://ssllabs.com/ssltest" target="_blank">Server Test</a> 中得到 A+

3. 凭借 SPDY 和 PageSpeed 获得极高的页面加载速度

4. 为百度等对 HTTPS 站点支持不好的搜索引擎进行单独优化

5. 其它所见及所得的好处

6. 无情的抛弃那些顽固不化的万年 IE6 和 Android 2.3 党

## SPECIAL THANKS
<a href="http://lnmp.org" target="_blank">LNMP一键安装包</a>

<a href="https://www.futures.moe" target="_blank">未来领域</a>

## TEST RESULT
2015-11-02：本脚本已在bandwagonhost.com的Ubuntu 14.04 x86_64系统上测试 **成功**
<br />
另：使用bandwagonhost.com的Ubuntu 14.04 x86会遇到PHP编译失败的问题（与本脚本无关）

2015-11-04: CentOS 7.1 x64 Test **Passed**

2015-11-21: `upgrade_nginx-chacha20.sh` on Ubuntu 14.04 64bit Test **Passed**

2015-12-02: CentOS 6 x64 Test **Passed**
