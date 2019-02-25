# Intellij-IDEA 的使用


* [常用快捷键](#常用快捷键 )
* [快捷键--跳转](#快捷键--跳转 )
* [快捷键--定位](#快捷键--定位 )
* [快捷键--页面显示](#快捷键--页面显示 )
* [快捷键--调试](#快捷键--调试 )
* [使用](#使用)

<a name="常用快捷键"></a>
### 常用快捷键 ###

> alt + Enter

	可以自动在该接口的实现类中创建实现方法，自我修复，代码优化     
> alt + insert

	可以自动生成构造器、getter/setter等等常用方法，可用于新建各种文件
> Ctrl + Alt+L 

	自动格式化代码 
> Ctrl + 左键单击类 

	查看该类的源码  
> Ctrl + R

	替换文本
> Ctrl + F
 
	查找文本，按 F3 可以选择下一个
> Ctrl+Shift+F

	全局查找
> Ctrl + D

	复制行
> Ctrl + Y

	删除当前行
> Ctrl + / 或 Ctrl + Shift + /

	注释【//或者/**/】
> Ctrl + Q

	显示注释文档
> Ctrl + H

	显示类结构图（类的继承层次）
> Ctrl+O

	重写/覆盖方法
> Ctrl+I

	实现方法
> Alt + 1

	快速打开或隐藏工程面板
> Alt + F1

	查找代码所在位置

> Alt + F7

	查看在哪里被调用

> Alt + F8

	打开Evaluate Expression计算表达式窗口
	debug调试的时候，当需要动态查看某一个值的时候使用

> Ctrl+F4

	关闭当前页面
> Ctrl+F7

	可以查询当前元素在当前文件中的引用，按 F3 可以选择下一个
> Ctrl+F12

	可以显示当前文件的结构
> Shift+F6

	重构 - 重命名
> Ctrl+Shift+C
	
	复制绝对路径
> Ctrl + Shift + U

	大小写转化
> Ctrl + Shift + T

	创建测试类【自动在测试目录中创建测试包和类】
> Ctrl + N

	可以快速打开搜索的类
> Ctrl + E

	查看最近打开的文件
> Ctrl+Shift+E

	最近更改的文件

> Ctrl+Alt+V

	可以引入变量。例如：new String(); 自动导入变量定义
> Ctrl+Alt+T
 
	可以把代码包在一个块内，例如：try/catch,if/else等
> Ctrl+Alt+I

	将选中的代码进行自动缩进编排，这个功能在编辑 JSP 文件时也可以工作
> Ctrl+Alt+S

	打开设置对话框
> sout
 
	System.out.println();  
> psvm

	main函数
> Ctrl+J

	查看更多的缩写
> F6，移动当前类  
> F5，复制当前类
> 
<a name="快捷键--跳转"></a>
### 快捷键--跳转

> Alt + left/right

	切换代码视图
> Alt + Up/Down

	在方法间快速移动定位
> Alt + Shift + Up/Down 或 Ctrl + Shift + Up/Down
	
	上/下移一行
> Ctrl+Alt+left/right

	返回至上次浏览的位置
> Alt+Home

	跳转到导航栏
<a name="快捷键--定位"></a>
### 快捷键--定位

> F2 或 Shift+F2

	高亮错误或警告快速定位

<a name="快捷键--页面显示"></a>
### 快捷键--页面显示 ###

> Ctrl + "+/-"

	当前方法展开、折叠
> Ctrl + Shift + "+/-"
	
	全部展开、折叠

<a name="快捷键--调试"></a>
### 快捷键--调试 ###

> Ctrl+F2

	停止调试
> Alt+Shift+F9

	选择 Debug
> Alt+Shift+F10

	选择 Run
> Ctrl+Shift+F9

	编译
> Ctrl+Shift+F10
 
	运行
> Ctrl+Shift+F8

	查看断点
> F8，步出 
> F7，步入  
> Alt+Shift+F8

	强制步过  
> Alt+Shift+F7
 
	强制步入  
> Alt+F9

	运行至光标处  
> Ctrl+Alt+F9
	
	强制运行至光标处  
> F9，恢复程序  
> Alt+F10，定位到断点  
> Ctrl+F8，切换行断点  

<a name="使用"></a>
### 使用 ###

> 个性化设置你自己的代码风格

	File-->Settings-->Editor-->CodeStyle

> 项目中Java版本不一致，可以查看项目中的jdk配置 

	1、查看项目的jdk（Ctrl+Alt+shift+S） 
	File ->Project Structure->Project Settings ->Project 
	
	2、查看工程的jdk（Ctrl+Alt+shift+S） 
	File ->Project Structure->Project Settings -> Modules -> （需要修改的工程名称） -> Sources -> 
	
	3、查看idea中Java配置 
	File -> Setting -> Build..->Compiler ->Java Compiler

> 自动生成的 web.xml版本过低，需要修改

	<?xml version="1.0" encoding="UTF-8"?>
	<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee
                      http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd" version="3.1">


	</web-app>

> 需要JSP页面时，IDEA 默认都没有引入，这两个jar一般myeclipse会自动引入的

	request.getContextPath()	//需要引入servlet-api.jar
	pageContext.setAttribute()	//需要引入jsp-api.jar

> 无法安装插件

	idea默认使用 https下载安装插件。
	在setting的Updates中去掉use secure connection前面的勾，这样我们就可以 使用普通的http连接插件中心了。

> 注解@Slf4j后找不到log问题解决

	安装lombok插件即可。

	该插件提供的注解：
		@Slf4j、@Getter、@Setter...

	<dependency>
		<groupId>org.projectlombok</groupId>
		<artifactId>lombok</artifactId>
		<version>1.16.10</version>
	</dependency>