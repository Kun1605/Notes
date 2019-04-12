## 				linux配制ssh服务

## 前言

> SSH为Secure Shell的缩写，由IETF的网络工作小组（Network Working 
> Group）所制定；SSH为建立在应用层和传输层基础上的安全协议。SSH是目前较可靠，专为远程登录会话和其他网络服务提供安全性的协议。利用SSH协议可以有效防止远程管理过程中的信息泄露问题。
>
> SSH最初是UNIX系统上的一个程序，后来又迅速扩展到其他操作平台。SSH在正确使用时可弥补网络中的漏洞。SSH客户端适用于多种平台。几乎所有UNIX平台—包括HP-UX、Linux、AIX、Solaris、Digital 
> UNIX、lrix，以及其他平台—都可运行SSH。
>
> 此条目简单介绍Linux下的SSH服务的安装与配置。

## 安装

### SSH分客户端openssh-client和openssh-server

如果你只是想登陆别的机器的SSH只需要安装openssh-client，深度操作系统有默认安装，如果没有终端执行：

```shell
sudo apt-get install openssh-client
```

如果要使本机开放SSH服务就需要安装openssh-server，终端执行：

```shell
sudo apt-get install openssh-server
```

卸载 
SSH分客户端openssh-client和openssh-server，如果需要卸载，请终端执行：

```shell
sudo apt-get remove openssh-clientsudo apt-get remove openssh-server
```

配置 
然后确认sshserver是否启动了,终端执行：

```shell
ps -e |grep ssh
```

如果看到sshd那说明ssh-server已经启动了。

如果没有则可以这样启动：

```shell
sudo /etc/init.d/ssh start 
```

或者

```shell
service ssh start
```

ssh-server配置文件位于/etc/ssh/sshd_config，在这里可以定义SSH的服务端口，默认端口是22，你可以自己定义成其他端口号，如222。

然后重启SSH服务：

```sh
sudo /etc/init.d/ssh stopsudo /etc/init.d/ssh start
```

然后使用以下方式登陆SSH： `ssh username@192.168.1.112`

其中username为192.168.1.112 机器上的用户，需要输入密码。

常见问题 
查看已登录用户 
首先使用w命令查看当前登陆的用户

这里解释一下相关列选项:

> USER：显示登录用户帐号名。用户重复登录，该帐号也会重复出现。 
> TTY: 用户登录所用的终端。 FROM: 显示用户在何处登录系统。 
> LOGIN@: 是LOGIN AT的意思，表示登录进入系统的时间。 
> IDLE: 用户空闲时间，从用户上一次任务结束后，开会记时。 
> JCPU: 一终端代号来区分，表示在摸段时间内，所有与该终端相关的进程任务所耗费的CPU时间。 
> PCPU: 指WHAT域的任务执行后耗费的CPU时间。 
> WHAT: 表示当前执行的任务。 pkill强制注销指定的登陆的活动 使用pkill -kill -t 
> [TTY]命令来完成这项操作，其中[TTY]表示终端名，即用户登录所用的终端。

我这里要结束的是pts/0，pts/1为我当前活动的登录帐号，因为WHAT表明我在进行w命令。

运行后，可以再次使用w命令来验证是否成功。

------

用XSHELL 连接时显示ssh服务器拒绝了密码，应该是应该是sshd的设置不允许root用户用密码远程登录 
修改 /etc/ssh/sshd_config文件，注意，安装了openssh才会有这个文件，如果文件不存在请检查是否安装了openssh。

```shell
vim /etc/ssh/sshd_config
```

找到

```shell
# Authentication:LoginGraceTime 120PermitRootLogin prohibit-passwordStrictModes yes
```

改成

```shell
# Authentication:LoginGraceTime 120PermitRootLogin yesStrictModes yes
```

然后输入命令

```shell
/etc/init.d/ssh restart 
```

重启ssh服务即可。

发现root的控制台不是彩色的，那么就把当前 用户的 ～/.bashrc 拷贝到 /root/.bashrc



### 接下来破解securesfx系列

```shell
sudo perl securecrt_linux_crack.pl /usr/bin/SecureCRT
```

```
Name: ygeR
Company: TEAM ZWT
Serial Number:03-36-338639
License Key: ADJE19 7U19YF 46RJWC 3CGK73 ADF3GN S66TJJ YU7BJP 6WJF1G
Issue Date: 03-10-2017
```

```shell
sudo perl securefx_linux_crack.pl /usr/bin/SecureFX
```

```
Name: ygeR
Company: TEAM ZWT
Serial Number:06-70-001589
License Key: ACUYJV Q1V2QU 1YWRCN NBYCYK ABU767 D4PQHA S1C4NQ GVZDQF
Issue Date: 03-10-2017
```

