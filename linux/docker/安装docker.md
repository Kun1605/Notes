## 简介

Docker 是一个开源的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。容器是完全使用沙箱机制，相互之间不会有任何接口。

1. 如果以前安装过老版本，可以先卸载以前版本

```shell
sudo apt-get remove docker.io docker-engine
```



2安装docker-ce与密钥管理与下载相关的工具

**说明：** 这里主要是提供curl命令、add-apt-repository和密钥管理工具。 **更正：**这里还需要software-properties-common包提供**add-apt-repository**工具。

```shell
sudo apt-get install apt-transport-https ca-certificates curl python-software-properties software-properties-common
```

3下载并安装密钥

鉴于国内网络问题，强烈建议使用国内源，官方源请在注释中查看。 国内源可选用[清华大学开源软件镜像站](https://mirrors.tuna.tsinghua.edu.cn/help/docker-ce/) 或 [中科大开源镜像站](http://mirrors.ustc.edu.cn/)，示例选用了中科大的。

为了确认所下载软件包的合法性，需要添加软件源的 GPG 密钥。

```shell
curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/debian/gpg | sudo apt-key add -
// 官方源，能否成功可能需要看运气。
// curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
```

4查看是否安装成功

```shell
sudo apt-key fingerprint 0EBFCD88
```

如果安装成功，会出现如下内容：

```shell
  pub   4096R/0EBFCD88 2017-02-22              
  Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88  
  uid     Docker Release (CE deb) <docker@docker.com>  
  sub   4096R/F273FCD8 2017-02-22
```


添加docker官方仓库
然后，我们需要向 source.list 中添加 Docker CE 软件源：

```shell
sudo add-apt-repository "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/debian  wheezy stable"
//官方源
// sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/debian wheezy stable"
```


Note： 这点很奇怪，官方在 wheezy 位置使用的是 $(lsb_release -cs)，而在deepin下执行lsb_release -cs这个命令时，而deepin显示的是unstable，而默认debian根据正式发行版本会显示是 jessie 或者wheezy 这个如果不更改成特定版本信息，在sudo apt-get update更新时就不起作用。
更正： 之所以获取的 unstable 不成功，是因为docker官方没有提供sid版本的docker。想安装必须将该部分替换成相应版本。Note：这里例子的debian的版本代号是wheezy，应该替换成deepin基于的debian版本对应的代号，查看版本号命令：cat /etc/debian_version，再根据版本号对应的代号替换上面命令的wheezy即可。

例如对于deepin15.5，我操作上面的命令得到debain版本是8.0，debian 8.0的代号是jessie，把上面的wheezy替换成 jessie，就可以正常安装docker,当前docker的版本为17.12.0-ce.

更新仓库
sudo apt-get update

安装docker-ce
由于网络不稳定，可能会下载失败。如果下载失败了，可以多试几次或者找个合适的时间继续。

sudo apt-get install docker-ce

在安装完后启动报错，查看docker.service的unit文件，路径为/lib/systemd/system/docker.service，把ExecStart=/usr/bin/dockerd -H fd:// 修改为ExecStart=/usr/bin/dockerd，则可以正常启动docker,启动 命令为 systemctl start docker

查看安装的版本信息
docker version

验证docker是否被正确安装并且能够正常使用
sudo docker run hello-world
如果能够正常下载，并能够正常执行，则说明docker正常安装。

更换国内docker加速器
如果使用docker官方仓库，速度会很慢，所以更换国内加速器就不可避免了。

方式一：使用阿里云的docker加速器。

在阿里云申请一个账号
打开连接 https://cr.console.aliyun.com/#/accelerator 拷贝您的专属加速器地址。

修改修改daemon配置文件/etc/docker/daemon.json来使用加速器(下面是4个命令，分别单独执行)
注意 这里的https://jxus37ad.mirror.aliyuncs.com是申请者的加速器地址，在此仅仅用于演示，而使用者要个根据自己的使用的情况填写自己申请的加速器地址。

```json
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://jxus37ad.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```


方式二：使用docker-cn提供的镜像源

编辑/etc/docker/daemon.json文件，并输入docker-cn镜像源地址
sudo nano /etc/docker/daemon.json
输入以下内容

```json
{
  "registry-mirrors": ["https://registry.docker-cn.com"]
}
```


重启docker服务
sudo service docker restart
禁止开机自启
默认情况下Docker是开机自启的，如果我们想禁用开机自启，可以通过安装chkconfig命令来管理Deepin自启项

# 安装chkconfig
sudo apt-get install chkconfig
# 移除自启
sudo chkconfig --del docker