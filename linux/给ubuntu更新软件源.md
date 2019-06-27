给自家的Ubuntu下载软件速度有点慢，毕竟是从国外下载软件，就想更换到国内比较好的更新源（就是这些软件所在的服务器），一般直接百度Ubuntu更新源就能出来一大堆，这时候最好是找和自己Ubuntu版本一致的更新源，我的Ubuntu版本是16.04，下面是我找到的一个比较好的更新源

下面是更换步骤：

**1  备份原来的更新源**

```shell
cp /etc/apt/sources.list /etc/apt/sources.list.backup
```

 

**2  修改更新源**　

　　**打开sources.list (这就是存放更新源的文件)**

```
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





Ubuntu 14.04取消了系统托盘白名单机制，导致使用传统系统托盘技术的程序无法显示出托盘图标,dconf-editor也无力解决这个问题 。UbuntuUnity桌面目前使用的技术是indicator-application-service。那么如何继续让传统程序显示托盘图标呢？执行如下命令即可解决：

```sh
sudo apt-get install libappindicator1
sudo apt-add-repository ppa:gurqn/systray-trusty
sudo apt-get update
sudo apt-get upgrade
```

安装搜狗输入法更新系统后，菜单栏出现两个输入法图标。

这两个图标一个是搜狗用的fcitx-ui-classic，另一个是fcitx的fcitx-ui-qimpanel。

而删除 fcitx-ui-qimpanel，只保留 fcitx-ui-classic就可以解决问题了，打开终端执行：

```shell
sudo apt-get remove fcitx-ui-qimpanel
```

注销或重启系统即可。

托盘图标

```shell
sudo apt-add-repository ppa:fixnix/indicator-systemtray-unity
sudo apt-get update
sudo apt-get install indicator-systemtray-unity


  sudo add-apt-repository ppa:fossfreedom/indicator-sysmonitor  
  sudo apt-get update 
  sudo apt-get install indicator-sysmonitor   
```

编辑shell主题的css文件，比如我的shell主题是`Vimix-Beryl`：

```
sudo gedit /usr/share/themes/Vimix-Beryl/gnome-shell/gnome-shell.css
```

打开之后搜索`top bar`，会看到这样一段：

```
/* TOP BAR */
#panel {
  background-color: rgba(0, 0, 0, 0.6);
  /* transition from solid to transparent */
  transition-duration: 250ms;
  font-weight: bold;
  height: 32px;
}
```

按照自己的喜好修改`background-color`即可^_^

补充：修改完可能并不能直接看到效果，可以在tweaks里先切换成别的主题再换成修改了的主题。

再补充：因为我是把透明度调到了大概0.2左右，导致使用hide top bar扩展时使用鼠标触发top bar后几乎看不清，可以往下找一下`#panel.solid`，把`background-color`改成这样：

```
#panel.solid {
  background-color: rgba(0, 0, 0, 0.5);;
  /* transition from transparent to solid */
  transition-duration: 250ms;
  background-gradient-direction: none;
  text-shadow: none;
}
```

配置sublime

```
git clone https://github.com/dennisfaust/sublime2config.git

git clone https://github.com/Kun1605/SublimeText2-Config.git
```

安装flash插件

```sh
sudo apt-get install flashplugin-installer
```

禁用笔记本的触摸板

```
由于笔记本触摸板太多灵敏，影响使用，所以禁用掉触摸板。
禁用触摸板命令：
sudo rmmod psmouse
启用触摸板命令
sudo modprobe psmouse
注意：启用之后可能会有几秒钟的延迟之后才生效。


```

安装苹果字体

```
https://github.com/cstrap/monaco-font
```

```
Gnome Global Application Menu
unblank


sudo apt-get install gtk2-engines-pixbuf


sudo apt-get install fonts-droid-fallback ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-ukai fonts-arphic-uming
```
    第一种方法是编译8188eu的驱动，这个在github上有，而且有很多解决办法，编译前需要安装相应的头文件和编译环境，如何你能这样解决的话，当然是最好了，如果这样没能解决，编译失败又解决不来的话，可以换第二种方法。
    第二种方法是编译带8188eu的hostapd来实现，具体实现步骤如下：
    1.卸载已有的hostapd
    sudo apt-get autoremove hostapd
    2.下载带有rtl8188eu的源码。
    wget https://github.com/jenssegers/RTL8188-hostapd/archive/v2.0.tar.gz
    tar -zxvf v2.0.tar.gz
    3.编译
    cd RTL8188-hostapd-2.0/hostapd
    sudo make
    4.安装
    sudo  make install
   此时可能你还是无法创建热点，这是因为ubuntu自带的Nerwork Manager 会对热点的创建产生影响，把无线网卡设置为未托管即可。

   



```sh
sudo apt-get install git dkms
git clone https://github.com/lwfinger/rtl8188eu.git
sudo dkms add ./rtl8188eu
sudo dkms install 8188eu/1.0
```

配制typora
```
"Code Fences": "Ctrl+Shift+F",  
"Orderd List": "Ctrl+Alt+o",  
"Unorders List": "Ctrl+Alt+u" 
```
使用ibus的情况

```
在使用ibus时，默认的简繁切换快捷键是Ctrl+Shift+F，该快捷键与idea、eclipse等ide中默认的全局搜索快捷键冲突。导致无法全局搜索。
 但在gentoo下，ibus并未提供修改快捷键的程序。ibus-setup与gnome3 自带的设置界面仅能修改切换输入源的快捷键。
 一般人用不到简繁切换的快捷键，所以这里想办法将该快捷键禁掉。
 在gnome下，ibus安装时默认的use里不包含gconf，这里修改/etc/portage/package.use文件，或该目录下的文件，增加 app-i18n/ibus gconf 配置项，并重装ibus。
 之后便可通过gnome3的dconf editor来禁用快捷键。位置在Desktop >> ibus >> general >> hotkey下面。
 修改 disable-unconditional项的值为['Ctrl+Shift_F']，并保存即可禁用ibus的简繁切换快捷键。
 
搜狗词库下载地址：http://hslinuxextra.googlecode.com/files/android.7z
解压下载的文件,你会得到一个叫android.db的文件，大约在100M左右。

用下面的命令：

Sudo cp android.db  /usr/share/ibus-pinyin/db/

```

 

```
三个命令安装chrome浏览器
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
然后安装flash插件
1、安装pepperflashplugin-nonfree
$ sudo apt-get install pepperflashplugin-nonfree
2、更新
$ sudo update-pepperflashplugin-nonfree --install
3、查看PepperFlashPlayer版本
$ sudo update-pepperflashplugin-nonfree --status
```

安装系统监控器

```
sudo add-apt-repository ppa:fossfreedom/indicator-sysmonitor  
sudo apt-get update
sudo apt-get install indicator-sysmonitor 
```

 