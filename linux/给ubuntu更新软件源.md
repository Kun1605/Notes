给自家的Ubuntu下载软件速度有点慢，毕竟是从国外下载软件，就想更换到国内比较好的更新源（就是这些软件所在的服务器），一般直接百度Ubuntu更新源就能出来一大堆，这时候最好是找和自己Ubuntu版本一致的更新源，我的Ubuntu版本是16.04，下面是我找到的一个比较好的更新源

下面是更换步骤：

**1  备份原来的更新源**

```shell
cp /etc/apt/sources.list /etc/apt/sources.list.backup

如果提示权限不够就输入下面两行，先进入到超级用户，再备份
sudo -s
cp /etc/apt/sources.list /etc/apt/sources.list.backup
```

 

**2  修改更新源**　

　　**打开sources.list (这就是存放更新源的文件)**

```shell
gedit /etc/apt/sources.list
```

　　**将下面所有内容复制，粘贴并覆盖sources.list文件中的所有内容**　

```shell
# deb cdrom:[Ubuntu 16.04 LTS _Xenial Xerus_ - Release amd64 (20160420.1)]/ xenial main restricted
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security multiverse](javascript:void(0);)
```

 

**3  让更新源生效**

```shell
sudo apt-get update
```

 

**4  安装软件**

```shell
sudo apt-get install 软件名称
例如：
sudo apt-get install vim    安装vim
```



##### 5换回win7

```
ubuntu下制作win7/win10启动盘工具woeusb
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt-get update
sudo apt-get install woeusb
```

##### 安装qq微信等

1，安装deepin-wine环境：上https://gitee.com/wszqkzqk/deepin-wine-for-ubuntu页面下载zip包（或用git方式克隆），解压到本地文件夹，在文件夹中打开终端，输入sudo sh ./install.sh一键安装。

2，安装deepin.com应用容器：在http://mirrors.aliyun.com/deepin/pool/non-free/d/中下载想要的容器，点击deb安装即可。以下为推荐容器:

    QQ：http://mirrors.aliyun.com/deepin/pool/non-free/d/deepin.com.qq.im/
    TIM：http://mirrors.aliyun.com/deepin/pool/non-free/d/deepin.com.qq.office/
    QQ轻聊版：http://mirrors.aliyun.com/deepin/pool/non-free/d/deepin.com.qq.im.light/
    微信：http://mirrors.aliyun.com/deepin/pool/non-free/d/deepin.com.wechat/
    Foxmail：http://mirrors.aliyun.com/deepin/pool/non-free/d/deepin.com.foxmail/
    百度网盘：http://mirrors.aliyun.com/deepin/pool/non-free/d/deepin.com.baidu.pan/
    360压缩：http://mirrors.aliyun.com/deepin/pool/non-free/d/deepin.cn.360.yasuo/

3，Ubuntu 18.04 Gnome桌面显示传统托盘图标：安装TopIconPlus的gnome-shell扩展，命令：sudo apt-get install gnome-shell-extension-top-icons-plus gnome-tweaks，然后用gnome-tweaks开启这个扩展。

* Ubuntu系发行版包括Ubuntu、LinuxMint、ZorinOS等。



## wps缺少字体

安装，打开终端：

```
cd 下载
sudo dpkg -i wps-office_10.1.0.5672~a21_amd64.deb 
```

 解决打开WPS时出现的系统缺失字体问题：

下载

<https://pan.baidu.com/s/1eS6xIzo>

wps_symbol_fonts.zip

 

将wps_symbol_fonts.zip解压

```
cd wps_symbol_fonts
ls
```

 将目录中所有文件复制到/usr/share/fonts下：

```
sudo cp mtextra.ttf  symbol.ttf  WEBDINGS.TTF  wingding.ttf  WINGDNG2.ttf  WINGDNG3.ttf  /usr/share/fonts
```

重新打开WPS，问题解决。

另外，安装完WPS后就没有必要保留libreOffice

卸载libreOffice：

```
sudo apt-get remove libreoffice-common
```

顺便把Amazon链接删除了吧：