

## git配置免密登陆

**解决方案：**
方案一：

1. 在你的用户目录下新建一个文本文件`.git-credentials`

   - **Windows：C:/Users/username**
   - **Mac OS X： /Users/username**
   - **Linux： /home/username**
     注意：鼠标右键新建文件`重复命名`是成功不了的，需要借助`Sublime`等`IDE`工具来创建文件。

2. `.git-credentials`在文件中输入以下内容：

   ```shell
   https:{username}:{password}@github.com
   ```

   `{username}`和`{password}`是你的`github`的`账号`和`密码`

3. 修改`git`配置
   执行命令：

   ```shell
   git config --global credential.helper store
   ```

   

4. 经过上述三步配置之后, 你`push代码`到github时, 便`无需再输入用户名密码`了

方案二：

1. 在命令行输入命令:

   ```shell
   git config --global credential.helper store
   ```

   这一步会在用户目录下的`.gitconfig`文件最后添加：

   ```shell
   [credential]
   helper = store
   ```

2. git push 代码
   `push`你的代码 (`git push`), 这时会让你输入`用户名`和`密码`, 这一步输入的用户名密码会被`记住`, 下次再push代码时就不用输入用户名密码!这一步会在用户目录下生成文件`.git-credential`记录用户名密码的信息。

### 治疗git下载速度太慢的办法(刷新DNS缓存)

```shell
sudo /etc/init.d/networking restart
```

