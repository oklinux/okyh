      
 欧侃OKYH简介

欧侃OKYH0.2是一个集成化的系统设置、优化及辅助工具，它完全是建立在Liinux Shell之上，并使用Xdialog作为图形界面支持。主要功能包括ADSL、本地网络、局域网共享设置，输入法设置，Wine设置和优化，桌面环境选择，减少自启动服务，源码编译向导，制作和可引导ISO等。使用说明

命令     功能及使用方法

okyh
优化和设置系统 

Okyh yhkde 主要是去除KDE启动时不必要启动的程序，如自动载入 光盘等。
okyh cdzh 转换开始菜单，可以把一些已经安装但开始菜单里没有出现 的程序图标转换出来。如在共创桌面2005中安装OpenOffice.org后，菜单里没有快捷方式 等，只要执行一下‘okyh cdzh’即可。
okyh srf 设置默认输入法，不同的用户可以把不同的输入法设为默认，比如把 红旗输入法设为默认，执行‘okyh srf rfinput’即可。仅支持KDE环境。
okyh bf是把整个系统[不包括mnt目录]备份到 /mnt/.okbf/目录里。
Okyh hf 是恢复整个系统［不包括boot目录］
okyh yhbf是把/root和/home两个目录备份到/mnt/.okbf/目录里。
Okyh wbf 在双系统下备份Windows系统［非虚拟分区］
Okyh whf 在双系统下还原Windows系统［非虚拟分区］
okyh yhhf是删除root和home目录 后再解压/mnt/.okbf/目录里的对应文件。
okyh auto 主要是自动选择默认启动的输入法。优先顺序为fcitx/scim/3jj/chinput/rfinput。就是说首先检查有没有fcitx，有，就启动它，没有fcitx再检查有没有 scim，依此类推。
Okyh xwin 是一个选择桌面管理器的工具，在字符界面下执行‘okyh xwin’就会出现桌面管理器列表。可以选择您想进入的桌面管理器，如XFEC等。

okwine
优化Wine
我认为，至少有80%的Windows的应用程序可以在 Wine上运行，主要是配置。okwine就是用来自动配置wine的。它也是国内第一个Wine配置工具，

okwine 初始化Wine的用户配置
okwine yp是直接从安装在硬盘上的Windows中导入的DLL文件
okwine gp是从WIN98安装光盘上导入常用的DLL文件.[还没完成]
okwine xpgp是直接从WinXP安装光盘中导入DLL。
okwine zc是注册虚拟c:\windows\system目录下的所有存在的DLL
okwine ie安装IE浏览器，在其后面可加上IE安装程序所在目录即可，如 ‘okwine ie /root/iesetup/’
okwine cxpz 给Windows程序配置DLL和系统版本号，由于不同的Win版软件可能需要不同的DLL和版本配置, 但我不可能对没种软件进行测试.所以,在okwine里预设了七种DLL配置,并用1到7来表示,大家可以分别对自己需要的软件配置一下看看.比如有个主程序是okyh.exe的软件,可以这样配置：okwine cxpz okyh.exe 1 或者是okwine cxpz okyh.exe 1 --bb win98
okwine cjcd 给一些没有建立开始菜单项的Windows程序创建菜单项，针对一些股票软件设计的功能，例如安装大智慧后，执行：okwine cjcd 大智慧 /root/.wine_c/dzh/interet/hypmine.exe

注：okwine（okdll）只是提供一个可以使用DLL的工具，不对微软公司的权利造成任何有意识的侵害。

okadsl
网络设置工具

Okadsl sz 是一个字符界面下的ADSL设置向导，采用全程拼音提示。
Okadsl ks [宽带账号] [密码] 是一个快速连接ADSL的选项，它不必任何设置，只需把宽带账号和密码写在命令后面，如'okadsl ks ad56044123 888888'
Okadsl [网卡] [IP地址] [网关] 给网卡指定IP地址和网关，例如：‘okadsl eth0 192.168.1.55 192.168.1.1'
Okadsl gx 把本机ADSL连接共享给其他计算机，设置方法如下（例如eth0是作为ADSL连接设备，eth1是连接其它计算机的设备。选用192.168.0.0内网网段。)
只需键入以下命令：
Okadsl eth0 123.123.123.123
Okadsl eth1 192168.0.1
Okadsl ks ad43215678 888888
Okadsl gx
Reboot
重启后生效

其它功能不再一一说明

