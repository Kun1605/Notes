Ubuntu 14.04取消了系统托盘白名单机制，导致使用传统系统托盘技术的程序无法显示出托盘图标,dconf-editor也无力解决这个问题 。UbuntuUnity桌面目前使用的技术是indicator-application-service。那么如何继续让传统程序显示托盘图标呢？执行如下命令即可解决：

```sh
sudo apt-get install libappindicator1
sudo apt-add-repository ppa:gurqn/systray-trusty
sudo apt-get update
sudo apt-get upgrade
```

