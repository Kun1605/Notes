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

 