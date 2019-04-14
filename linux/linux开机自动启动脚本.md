 ubuntu-16.10 开始不再使用initd管理系统，改用systemd

> systemd is now used for user sessions. System sessions had already been provided by systemd in previous Ubuntu releases.

快速看了 systemd 的使用方法，发现改动有点大， 包括用 systemctl 命令来替换了 service 和 chkconfig 的功能。

比如以前启动 mysql 服务用:

```
sudo service mysql start
```

现在用：

```
sudo systemctl start mysqld.service
```

其实这个改动到不是算大，主要是开机启动比以前复杂多了。systemd 默认读取 /etc/systemd/system 下的配置文件，该目录下的文件会链接/lib/systemd/system/下的文件。

执行 ls /lib/systemd/system 你可以看到有很多启动脚本，其中就有我们需要的 `rc.local.service`

打开脚本内容：

```
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation; either version 2.1 of the License, or
#  (at your option) any later version.

# This unit gets pulled automatically into multi-user.target by
# systemd-rc-local-generator if /etc/rc.local is executable.
[Unit]
Description=/etc/rc.local Compatibility
ConditionFileIsExecutable=/etc/rc.local
After=network.target

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
RemainAfterExit=yes
```

**一般正常的启动文件主要分成三部分**

> [Unit] 段: 启动顺序与依赖关系 
> [Service] 段: 启动行为,如何启动，启动类型 
> [Install] 段: 定义如何安装这个配置文件，即怎样做到开机启动

可以看出，/etc/rc.local 的启动顺序是在网络后面，但是显然它少了 Install 段，也就没有定义如何做到开机启动，所以显然这样配置是无效的。 因此我们就需要在后面帮他加上 [Install] 段:

```
[Install]  
WantedBy=multi-user.target  
Alias=rc-local.service
```

这里需要注意一下，ubuntu-18.04 默认是没有 /etc/rc.local 这个文件的，需要自己创建

```
sudo touch /etc/rc.local 
```

然后把你需要启动脚本写入 /etc/rc.local ，我们不妨写一些测试的脚本放在里面，以便验证脚本是否生效.

```
echo "this just a test" > /usr/local/text.log
```

**做完这一步，还需要最后一步** 前面我们说 systemd 默认读取 /etc/systemd/system 下的配置文件, 所以还需要在 /etc/systemd/system 目录下创建软链接

```
ln -s /lib/systemd/system/rc.local.service /etc/systemd/system/ 
```

 接下来，重启系统，然后看看 /usr/local/text.log 文件是否存在就知道开机脚本是否生效了。

 

**rc.local脚本**

rc.local脚本是一个ubuntu开机后会自动执行的脚本，我们可以在该脚本内添加命令行指令。该脚本位于/etc/路径下，需要root权限才能修改。

**该脚本具体格式如下：**

**注意:** 一定要将命令添加在 exit 0之前