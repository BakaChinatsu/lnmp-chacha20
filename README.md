# lnmp-chacha20

警告！！本项目组不保证此魔改脚本可以稳定工作在所有Linux发行版上，因使用此脚本而导致的任何服务器宕机/冒烟以及数据损毁本项目组概不负责！

提醒：此脚本需要与<a href="http://lnmp.org" target="_blank">LNMP一键安装包</a>配合使用

安装完毕后将达到以下效果：

1. 使用CHACHA20-POLY1305加密方法作为首要加密方法，并启用HSTS

2. 在Qualys SSL Labs 的 Server Test中得到A+

3. 凭借SPDY和PageSpeed获得极高的页面加载速度

4. 为百度等对https支持不好的搜索引擎进行单独优化

5. 其它所见及所得的好处

6. 无情的抛弃那些顽固不化的万年IE6和Android 2.3党

感谢：<a href="http://lnmp.org" target="_blank">LNMP一键安装包</a> <a href="https://www.futures.moe/" target="_blank">未来领域</a>


2015-11-02：本脚本已在bandwagonhost.com的Ubuntu 14.04 x86_64系统上测试成功
另：使用bandwagonhost.com的Ubuntu 14.04 x86会遇到PHP编译失败的问题（与本脚本无关）

2015-11-04: CentOS 7.1 64bit test passed

2015-11-21: upgrade_nginx-chacha20.sh on Ubuntu 14.04 64bit test passed
