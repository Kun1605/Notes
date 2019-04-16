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