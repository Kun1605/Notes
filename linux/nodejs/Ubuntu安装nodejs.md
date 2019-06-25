### 安装nodejs

```
sudoapt-getinstall-ynodejs
```

安装npm包管理器

```
sudoapt-getinstall-ynpm
```

然后查看版本号

```
npm-v
```

但是我发现，输入 node 不能进入到 node 环境，而要输入 nodejs 才可以进入环境，这多多少少让我感觉有点不爽。所以我决定做一个命令映射，让我的输入和 mac平台一样。

首先，我在 ~ 家目录中，用 ls -a 命令，看是否存在 .bash_profile 文件。看来系统默认是没有这个文件的。

于是，我用

```
vim.bash_profile
```

创建这个文件，录入以下内容：

```
aliasnode="nodejs"
```

:wq 保存退出之后，在终端里输入

```
.~/.bash_profile
```

node -v

OK了

- 安装镜像切换工具

```
npm install nrm -g
```



- 查看仓库列表

```
nrm ls
```



- 更换淘宝

```
nrm use taobao
```



- 更换完成后测试速度

```
nrm test npm
```



- 初始化vue工程

```
npm install -g vue-cli
```

```
vue init webpack newproject  
```



- 初始化package.json

```
npm init -y
```



- 只安装vue

```
npm install vue --save
```



- 安装webpack

```
npm install webpack webpack-cli --save-dev
```

 

```
sudo apt-get install -y npm
```

### 