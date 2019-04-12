# Node.js #

* [1、模块化规范](#1、模块化规范)
* [2、NodeJS介绍](#2、NodeJS介绍)
* [3、NodeJS安装与使用](#3、NodeJS安装与使用)
* [4、NodeJS模块](#4、NodeJS模块)
* [5、NPM和CNPM](#5、NPM和CNPM)
* [6、异步](#6、异步)
* [7、Nodejs模块API](#7、Nodejs模块API)
* [8、Express框架](#8、Express框架)


<a name="1、模块化规范"></a>
### 1、模块化规范 ###
	
1.1、服务端规范 

	CommonJS：定义服务器端的JS规范，同步加载文件方式，自适用于服务端。
		Node.js是最好的实现者

1.2、客户端浏览器规范

	AMD：异步模块定义【Asynchronous Module Definition】，国外客户端异步的模块化规范；
		1. RequireJS 是最好的实现者
		2. AMD规范：https:github.com/amdjs/amdjs-api/wiki/AMD
		3. AMD 规范定义了一个自由变量或者说是全局变量define的函数；
		4. define(moduleId,dependencies,function);
			1. moduleId:字符串类型，表示模块标识【可选】，加载器会自动定义为请求脚本的标识；
			2. dependencies: 是当前模块需要依赖的，已被模块定义的模块标识的数组字面量；
			3. function: 是一个需要进行实例化的回调函数或者对象。
		
		//定义模块
		 define("module",["require","beta"],function(param1){
				return function(){....}
			);
		
		//引入模块
		require( desc,callback)
			deps: 模块所需要的依赖;
			callback: 模块的主函数。
		
	CMD：【Common Module Definition】国内客户端异步的模块化规范；
		1. SeaJS 是最好的实现者
		2. define(function);
			1. function: 是一个需要进行实例化的回调函数或者对象。
		define(function(require,exports.module){
			//模块代码	
		...});

1.3、JS模块的共性

	1. 模块中使用var变量都是局部变量，不会造成全局污染；
	2. 模块的功能都定义在函数中，属于局部；
	3. 模块有一个模块对象，包括 moduleId【模块名,define对象】、exports【导出对象】；
	4. 如果模块中需要暴露方法或熟悉给外部使用，可以在exports对象上面添加；
	5. 导入一个模块使用方法require("moduleId"),该方法返回的就是模块对象的exports对象。
		var a = require("./a.js");
		a.xxx	//等同于模块中使用exports.xxx

<a name="2、NodeJS介绍"></a>
### 2、NodeJS介绍 ###
	
	Node.js 就是运行在服务端的 JavaScript。
	Node.js 是一个基于 Chrome V8 引擎的 JavaScript 运行环境。 
	Node.js 使用了一个事件驱动、非阻塞式 I/O 的模型，使其轻量又高效。 
	Node.js 的包管理器 npm，是全球最大的开源库生态系统。

Node.js 和 JS 的区别
	
	node.js：一个服务端JS的运行环境，与浏览器的JS执行功能是一样的。
	JS：客户端的编程语言，需要浏览器的javascript解释器进行解释执行。

NodeJS作用

	NodeJS的目的是为了实现高性能Web服务器
	前端工具基本都是基于NodeJS
	前后端语言统一
	前后端分离

<a name="3、NodeJS安装与使用"></a>
### 3、NodeJS安装与使用【掌握】 ###

[https://nodejs.org/en/](https://nodejs.org/en/ "官方文档")  
[http://nodejs.cn/](http://nodejs.cn/ "中文文档")  
[https://www.runoob.com/nodejs/nodejs-tutorial.html](https://www.runoob.com/nodejs/nodejs-tutorial.html "菜鸟文档")

> 下载并安装对应的NodeJS安装包

	32 位安装包下载地址 : https://nodejs.org/dist/v4.4.3/node-v4.4.3-x86.msi
	64 位安装包下载地址 : https://nodejs.org/dist/v4.4.3/node-v4.4.3-x64.msi

	window安装node.js一路回车即可。
	配置环境变量
		1. 新建NODE_HOME，添加nodejs安装目录D:\Program Files\nodejs
		2. 在Path中添加 %NODE_HOME%
		
	检测是否安装成功
	node -v
	npm -v
	显示版本号即安装成功

> 安装模块

	在nodejs的文件夹中新建两个文件夹node_cache【node缓存】和node_global【node全局安装的模块】

	打开命令行设置nodejs的全局安装路径和缓存路径【不然默认安装在C盘】

		npm config set prefix D:\Program Files\nodejs\node_global 
		npm config set cache D:\Program Files\nodejs\node_cache

	更改配置环境变量
		修改NODE_HOME 的值为 D:\Program Files\nodejs\node_modules

> 运行node.js文件

	node <JS文件>

<a name="4、NodeJS模块"></a>
### 4、NodeJS模块【掌握】 ###

	模块：一个具有特定功能的文件。
	模块间相互独立，也可能存在一定的依赖关系，使用模块可以很好的把这些依赖关系整合起来。

> 自定义模块

	//1. 定义模块
	function 模块方法名(){
		//TODO
	};
	module.exports = <需要暴露的模块方法名>;

	比如：
		//a.js
		function show(content){
			return content;
		};
		
		module.exports=show;

	//2. 引入模块
	require( '模块所需要的依赖');

	比如：
		var a = require('a');

> 主模块

	一个项目只允许有一个主模块。
	通常命名：main.js/index.js/app.js，可以在package.json文件中的main属性设置自定义主模块名。

> Node.js的模块组成

	所有用户编写的代码都放在模块中，模块就是文件【函数】。
	函数有五个参数：
		1. exports：暴露对象，可以将模块中的方法、属性暴露给需要引入的文件；
		2. require：引入模块的函数，用于在一个模块中引入另一个模块；
		3. module：模块对象，包含了当前模块的所有信息；
		4. __filename：当前模块的文件名；
		5. __dirname：当前模块所在的路径【目录路径】。

> 例子

	exports.username = 'alex';
	console.log(arguments.callee.toString());	//获取模块对象本身信息
	console.log(arguments);	//获取模块对象的参数信息

	【注】arguments.callee可以调用自身，可以在递归函数中使用。

![](images/nodejs1.png)
	
	0-4分别对应着5个参数信息

> 模块名后缀名

	CommonJS模块规范允许在标识符中不指定文件扩展名，Node 会按 js、json、node的顺序依次补齐扩展名，依次尝试查找。
	即只要模块的后缀名是 js、json、node，可以不用显示指定。

> require 函数

	作用：在当前模块中加载引入另一个模块。
	模块分类：
		1. 引入自定义模块，需要使用 ../或者./作为开始的标识符
			require('');
			
			【注意】
				1. 子模块没有暴露数据时，返回空对象；
				2. 引入自定义模块时，如果在同级目录必须加 "./",因为在node.js中默认在node_modules目录中查找模块。require("./a");

		2. 第三方模块
			需要安装才可以使用，使用npm包安装管理工具进行安装。
			模块自动安装在node_modules目录中。
			npm install <模块包名>
			npm uninstall <模块包名>

			比如：
			npm install jquery

			引用：
				var jquery = require('jquery');

		3. 系统模块
			node.js 开发团队开发好的功能模块，直接引入即可使用，不需要安装。
			比如： fs【文件系统】、http、url、path ..
			require('模块名');

			var fs = require('fs');
			console.log(fs);
			fs.readFile('./a.js',function(err,data){
				console.log(data.toString());
			});

		【注意】
			1. 当引入的模块有语法错误时，运行时会报错；
			2. 当引入的模块路径有错误时会报错；
			3. 当一个模块被多次引入时，只会执行一次；
				1. 先返回数据给引入模块的对象；
				2. 再将导出的数据缓存到缓存区，重复利用。
			4. 引入模块对象首先去缓存区查找数据，如果没有再去被引用的模块对象中查找。

> exports 导出对象

	作用：将模块中需要共享给其他模块的数据暴露【导出】到引用处。
	语法：
		exports.属性名 = 值；
		exports.方法名 = 函数；
		
	【注意】
		1. exports 是 module.exports对象的引用，指向同一内存地址空间。
		2. exports 不能改指向，只能添加属性/方法；
			exports=对象/函数 //返回空，不能修改指向

		2. module.exports【推荐使用】才是真正的暴露对象，可以修改指向。
			module.exports=对象/函数		//可以修改指向

> module 模块对象

	module.exports【推荐使用，重点】才是真正的暴露对象，可以修改指向。
	语法：
		module.exports.属性名 = 值;
		module.exports.方法名 = 函数;
		module.exports = 对象/函数;
	
	属性【了解】：	
		module.id			模块标识，模块id
		module.parent		模块的父级
		module.children		模块的子模块列表
		module.filename		模块的文件名和路径
		module.paths		模块查找node_module路径，如果当前目录下没找到，会往上一级目录查找，直到根目录。

> node.js的作用域

	node.js中定义的变量都是局部的。
	实现跨域访问：
		1. 暴露对象
			定义：module.exports
			
		2. 全局对象【尽量少用】
			定义：global.属性/方法 = 值；
	
			【注】引用的时候global可以省略，global类似于window。

> 缓存区

	1. 缓存区概念
		在内存中开辟一个临时空间用于存储需要运算的字节码。

	2. 创建缓存区
		2.1. 创建指定长度的缓存区
			var buf = new Buffer(10)	//10个字节

		2.2. 按指定数组【编码】创建缓存区

		2.3. 按指定字符创建缓存区
			var buf = new Buffer('字符串');

	3. 读写缓存区
		buf.write('字符串');	//写缓存区，nodejs默认采用UTF-8编码
		buf.toString();		//读缓存区

	4. 缓存区复制
		//将缓存区buf1的数据复制给buf2
		buf1.copy(buf2);
		

<a name="5、NPM和CNPM"></a>
### 5、NPM和CNPM【掌握】 ###

	官方网站：https://www.npmjs.com/
	NPM(Node Package Manager)是基于nodejs的包管理工具。

> package.json

	是nodejs项目的包描述文件，以JSON格式描述项目文件信息【项目名称、版本、描述、作者、依赖列表、开发时依赖列表、主模块入口、脚本...】。

	查看package.json帮助文档，可以执行 npm help package.json

	// package.json

	{
	  "name": "nodeDemo1",	//项目名称（必须）
	  "version": "1.0.0",   //项目版本（必须）
	  "description": "This is for study gulp project !",   //项目描述（必须）
	  "main": './index.js',
	  "scripts": {			//运行脚本，可以使用 npm 命令运行
	    "start": "webpack-dev-server --open",
	    "build": "webpack"
	  },
	  "keywords": [],	//关键字，供外部搜索使用
	  "author": {    	//项目作者信息
	    "name": "alex",
	    "email": "xxx"
	  },
	  "repository": {    //项目资源库
	    "type": "git",
	    "url": "https://git.oschina.net/xxxx"
	  },
	  "license": "ISC",
	  "devDependencies": {		//项目依赖的插件【开发模式】 --save-dev
	    "jquery": "^3.3.1",
	  },
	  "dependencies": {}		//项目依赖的插件【线上】 --save
	}


	创建package.json:
		npm init 	//自定义项目信息生成
		npm init -y	//自动使用默认生成

	【说明】
	scripts 脚本的运行需要安装 CLI
		npm install --save-dev webpack-cli
		npm install -g webpack-cli	

	scripts 脚本的作用：
		通过加载该脚本来运行脚本名字所对应的命令。
		比如：运行 npm run start 就可以运行 start所对应的命令 	webpack-dev-server --open

	由于 npm 的 start 命令是一个特殊的脚本名称，其特殊性表现在，在命令行中使用 npm start 就可以执行其对应的命令。
	如果对应的此脚本名称不是 start，想要在命令行中运行时，需要这样用 npm run {script.name} 如: npm run build

	devDependencies 和 dependencies的区别

		dependencies 程序正常运行需要的包。
		devDependencies 是开发需要的包，比如 一些单元测试的包之类的。

		dependencies 是正常运行该包时所需要的依赖项，而后者则是开发的时候需要的依赖项，像一些进行单元测试之类的包。
		运行 npm install 默认会安装这两种依赖。
		
		npm install packagename 		// 安装dependencies
		npm install packagename --dev	// 安装devDependencies



|NPM命令|说明|
|:--|:--|
|npm install <模块包名> |安装指定的包，最新版本的包|
|npm i <模块包名>|效果同上，缩写|				
|npm i <模块包名@版本号>|安装指定版本的包|
|npm i <模块包名> -g |全局安装指定的包，包安装路径是nodejs安装目录下的node_module|
|npm i <模块包名> --save| 将安装包写入package.json的依赖列表|
|npm i <模块包名> --save-dev| 将安装包写入package.json的开发时依赖列表|
|npm search <模块包名> |搜索包|
|npm view <模块包名> |查看包信息|
|npm uninstall <模块包名>|卸载指定包|

> cnpm

	npm 默认情况下会去 npmjs.com(github.com)下载资源。
	由于在国内下载npmjs.com的数据比较慢，所以就有了cnpm。
	cnpm: 淘宝制作的 npmjs.com的镜像【只能下载不能上传】，可以很快的下载nodejs资源。

	安装cnpm:
		npm install -g cnpm --registry=https://registry.npm.taobao.org

	使用命令和npm的一样：
		cnpm install <模块包名>

> 控制台命令

	console.log() 
	console.dir()
	console.time('标志')				//计时开始
	console.timeEnd('标志')			//计时结束
	console.assert(表达式，描述信息)	//断言，表达式为false时抛出错误，显示描述信息

<a name="6、异步"></a>
### 6、异步【掌握】 ###

> 回调函数【callback】

	又称为回调,将A函数作为参数传入B函数中，B函数在执行过程中根据条件决定是否调用A函数，A函数即为回调函数。

	回调函数机制：
		1. 定义一个普通函数【可做回调函数】；
		2. 将函数作为参数传入另一个函数【调用者】；
		3. 调用者在执行过程中根据时机或者条件决定是否调用函数。

	回调函数的用途
		通常用于在达到某种条件时才需要执行的函数，比如计时，异步，事件绑定。

> 异步的执行
	
	主线程中，异步的执行是在同步执行的后面。
	主线程运行到异步代码时，会生成任务线程去执行异步代码，主线程依然执行同步代码，当异步代码执行完且紧跟后面的同步代码执行完后，异步代码的结果才会返回主线程。

> 异步的实现方式：

	1. 回调函数
		回调函数不一定是异步，但是异步一定有回调函数。
		
	2. 事件
		事件源.on('事件类型',回调函数);

	3. promise
		Promise是ES6中新增的承诺对象。

		作用：
			用于对异步操作进行消息的传递。
			由于异步操作的返回结果顺序不固定，将异步操作的结果交给promise进行统一显示。
			
		promise的状态：
			1. Pending  等待中
			2. Resolved	成功
			3. Rejected	失败
			
		状态转换
			Pending ==》Resolved
			Pending ==》Rejected

	4. async/await
		是ES6新增的异步处理方式。【ECMAScripts6笔记有详解】

例子：
		
	var fs = require('fs');

	var p1 = new Promise(function(resolve,reject){
		fs.readFile('./a1.txt',function(err,data){
			// a.txt的异步消息交给promise对象进行管理
			if (err) {
				reject('a.txt出错');
			}else{
				resolve(data.toString());
			}
		});
	});
	
	var p2 = new Promise(function(resolve,reject){
		fs.readFile('./b.txt',function(err,data){
			// b.txt的异步消息交给promise对象进行管理
			if (err) {
				reject('b.txt出错');
			}else{
				resolve(data.toString());
			}
		});
	});
	
	//利用all方法将这两个异步的执行结果以数组的形式固定顺序显示
	Promise.all([p1,p2])
		.then(function(data){		//返回运行结果
			console.log(data);
		}).catch(err){				//返回运行异常结果
			//TODO
		};

<a name="7、Nodejs模块API"></a>
### 7、Nodejs模块API ###

[http://nodejs.cn/api](http://nodejs.cn/api "nodejs中文网API")

### fs文件系统【掌握】 ###

> 文件系统操作

	引入文件系统模块
	const fs = require('fs');

	1. 直接读取读取文件
		
		将硬盘上的所有内容全部读入内存后才触发回调函数。
		写法：
			同步【没有回调函数】：
				var data = fs.readFileSync('文件路径');

			异步：
				定义一个回调函数，接收读取到的内容。
				fs.readFile('文件路径',function(错误对象,数据){
					//读取完文件后的操作
				});
					
	2. 写文件
		2.1. 同步:
			fs.writeFileSync('文件路径','数据');

		2.2. 异步:
			fs.writeFile('文件路径','数据',function(错误对象){
				//写完文件后进行的操作
			});

	3. 读取文件信息

		fs.stat('文件路径',function(err,state){
			//state是文件的信息对象，包含了常用的文件信息
			state.isFile();
		});

	4. 删除文件

		fs.unlink('文件路径',function(错误对象){
			//...
		})

		比如：
		fs.unlink('./a.txt',function(err){
			if(err){
				throw err;
			}else{
				console.log('删除成功');
			}
		});

	5. 删除非空目录

		//1.读取目录中的文件及文件及列表
		fs.readFile()
		//2.读取目录中的文件的详细信息
		fs.state()
		//3.如果是文件则删除文件
		state.isFile()
		fs.unlink()
		//4. 如果是空目录则删除
		fs.rmdir()
		//5. 如果是非空目录则调用自己
		state.isDirectory()
		

> 流式操作文件

	流式读取
		将数据以流的方式读取到内存中。

	1. 读取文件
		//创建一个可以读取的流
		var stream = fs.createReadStream('文件路径');
		stream.setEncoding('UTF8');			

		//绑定data 处理流事件，当读取到内容就执行
		stream.on('data',function(data){
			//操作读取的内容
		)

		//绑定读取流事件: end 完成事件 
		stream.on('end',function(){
			//读取完成后操作
		)

		//绑定读取流事件: error 错误事件
		stream.on('error',function(err){
			//读取错误操作
		)

	2.写入文件

		//创建一个可以读取的流
		var stream = fs.createWriteStream('文件路径');

		//写入数据
		stream.write(data,'UTF8');
		stream.write(data2,'UTF8');
		stream.end();	//显示的声明写入结束

		//绑定finish 写入流事件
		stream.on('finish',function(err){
			//写入完成后操作
		)

> 管道

	管道是node.js中流的实现机制，直接定义一个输出流，导入一个输入流。
	一种输入流和输出流之间传输数据的机制。
	用于大文件的操作。

	语法：
		输出流.pipe(输入流);

	比如：
	const fs = require('fs');
	var out = fs.createReadStream('./a.txt');
	var in = fs.createWriteStream('./b.txt');
	
	//使用管道进行大文件的复制
	out.pipe(in);
	
> 链式流

	作用：将多个管道连接起来，实现链式处理。
	out.pipe(in).pipe(in2)..;

### 网络模块 ###

> path模块

	path模块是node.js中提供的一个系统模块，用于格式化或拼接一个完整的路径。
		const path = require('path');

|常用方法|说明|
|:--|:--|
|path.join(__dirname,'文件路径');|将多字符串拼成一个完整路径|
|path.parse('文件');	|解析路径：返回一个包含路径中的各个部分的对象|
|path.dirname('文件');|返回路径中的文件夹路径|
|path.basename('文件');|返回路径中的文件部分【文件名和扩展名】|
|path.extname('文件');|返回路径中的文件扩展名|


> URL模块

	node.js中提供了两套对于url进行处理的API功能,用于获取URL中的信息。
	const url = require('url');
		1. 旧版的url模块；
		2. 新版的url模块【WHATWG URL标准模块】

	// 解析 url 参数
    let params = url.parse(req.url, true).query;

> 例子：

	const url = require('url');
	var u = 'http://ke.qq.com/webcourse/index.html?cid=315597&term_id=100374543';
	
	//旧版的url模块
	console.log(url.parse(u));

	//新版的url模块
	var obj = new url.URL(u);
	console.log(obj);
	
	结果：
	Url {
	  protocol: 'http:',
	  slashes: true,
	  auth: null,
	  host: 'ke.qq.com',
	  port: null,
	  hostname: 'ke.qq.com',
	  hash: null,
	  search: '?id=315597&term_id=100374543',
	  query: 'id=315597&term_id=100374543',
	  pathname: '/webcourse/index.html',
	  path: '/webcourse/index.html?id=315597&term_id=100374543',
	  href: 'http://ke.qq.com/webcourse/index.html?id=315597&term_id=100374543' }

	URL {
	  href: 'http://ke.qq.com/webcourse/index.html?id=315597&term_id=100374543',
	  origin: 'http://ke.qq.com',
	  protocol: 'http:',
	  username: '',
	  password: '',
	  host: 'ke.qq.com',
	  hostname: 'ke.qq.com',
	  port: '',
	  pathname: '/webcourse/index.html',
	  search: '?id=315597&term_id=100374543',
	  searchParams: URLSearchParams { 'id' => '315597', 'term_id' => '100374543' },
	  hash: '' }


> HTTP模块

	作用：用于处理网络请求。
	要使用 HTTP 服务器与客户端，需要 require('http')。

	发起网络请求
	http.get(options[, callback])

	比如：
	const http = require('http');
	
	//发起get请求
	http.get('http://www.baidu.com',function(response){
		//以流的方式监听事件
		response.on('data',function(data){
			//...
			console.log(data);
		});
	});

	http.request()	//可以发起post请求

	//http.createServer()返回 http.Server 对象
	//创建http服务并绑定端口
	http.createServer(function (request, response) {
	
	    // 发送 HTTP 头部 
	    // HTTP 状态值: 200 : OK
	    // 内容类型: text/plain
	    response.writeHead(200, {'Content-Type': 'text/plain'});

		// 发送响应数据 "Hello World"
		response('<p>Hello World</p>')	

	    //显示指定结束返回
	    response.end();

	}).listen(8888);

> 可以创建 HTML模板页面来构建html页面，然后HTTP模块html模板文件进行渲染即可。

	HTML模板即静态的html页面，里面包含需要渲染的数据。
	<%静态代码%>
	<%=变量%>

	比如：
	<ul>
    	<%for(var i in users){%>
    	<li>username:<%=users[i].name%>,age:<%=users[i].age%></li>
    	<%}%>
    </ul>

<a name="8、模板引擎"></a>
### 8、模板引擎 ###

> Jade 模板引擎使用

	1. 标签调用
		//test.jade
		p hello jade
		其上的 jade 模板会被解析成	<p>hello jade</p>
	
		如果文本比较长可以使用
		p
		  | foo bar baz
		  | rawr rawr
		或者
		p.
		  foo bar baz
		  rawr rawr
		两种情况都可以处理为	<p>foo bar baz rawr rawr</p>

	2. jade 变量调用
		jade 的变量调用有 3 种方式
		
		#{表达式}
		= 表达式
		!= 表达式
		【注意】符号 - 开头在 jade 中属于服务端执行的代码。
		
		- console.log('hello'); // 这段代码在服务端执行
		- var s = 'hello world' // 在服务端空间中定义变量
		p #{s}
		p = s
		会被渲染成为
			<p>hello world</p>
			<p>hello world</p>

	除了直接在 jade 模板中定义变量，更常见的应用是在 express 中调用 res.render 方法的时候将变量一起传递进模板的空间中。

	res.render(test, {
	    s: 'hello world'
	});

	3. 循环判断语句
	
	if 判断

		- var user = { description: '我喜欢猫' }
		- if (user.description)
		    h2 描述
		    p.description= user.description
		- else
		    h1 描述
		    p.description 用户无描述

		结果：
		<div id="user">
		  <h2>描述</h2>
		  <p class="description">我喜欢猫</p>
		</div>

	循环

		- var array = [1,2,3]
		ul
		  - for (var i = 0; i < array.length; ++i) {
		    li hello #{array[i]}
		  - }
		  - 
		结果	
		<ul>
		    <li>hello 1</li>
		    <li>hello 2</li>
		    <li>hello 3</li>
		</ul>

		或者

		ul
		  each val, index in ['西瓜', '苹果', '梨子']
		    li= index + ': ' + val

		结果
		<ul>
		  <li>0: 西瓜</li>
		  <li>1: 苹果</li>
		  <li>2: 梨子</li>
		</ul>

		该方法同样适用于 json 数据
		
		ul
		  each val, index in {1:'苹果',2:'梨子',3:'乔布斯'}
		    li= index + ': ' + val

		结果：
		<ul>
		  <li>1: 苹果</li>
		  <li>2: 梨子</li>
		  <li>3: 乔布斯</li>
		</ul>
		
	Case
		类似 switch 里面的结果，不过这里的 case 不支持case 穿透，如果 case 穿透的话会报错。
		
		- var friends = 10
		case friends
		  when 0
		    p you have no friends
		  when 1
		    p you have a friend
		  default
		    p you have #{friends} friends

		结果：
		<p>you have 10 friends</p>

		简略写法：
		
		- var friends = 1
		case friends
		  when 0: p you have no friends
		  when 1: p you have a friend
		  default: p you have #{friends} friends

		结果：
		<p>you have a friend</p>

> 例子

	//app.js
	var listRouter = require('./routes/list');
	app.use('/list', listRouter);

	//list.jade
	doctype html
	html
	  head
	    title= title
	    link(rel='stylesheet', href='/stylesheets/style.css')
	  body
	    block content
	  ul 
	  - for(var i in users){
	  li username:#{users[i].name},age:#{users[i].age}
	  - }

	//list.js
	var express = require('express');
	var router = express.Router();
	
	/* GET home page. */
	router.get('/list', function(req, res) {
	
	  var data = [
	  		{'name':'alex','age':23},
	  		{'name':'kevin','age':25}
	  	];
	  res.render('list',{users:data});
	});
	
	module.exports = router;

	运行 npm start
	访问：http://localhost:3000/list
	结果：
		username:alex,age:23
		username:kevin,age:25

> 将 ejs 模板转为 html 模板使用

	// app.js
	app.set('view engine', 'html');
	app.engine('.html', require('ejs').__express);
	
	app.listen(8000,function(){
		console.log('开启服务');
	});

	// 在 views下创建 html文件
	<ol>
        <% for (var user of users) { %>
        <li><%= user.name %> -- <%= user.age %></li>
        <% } %>
    </ol>

	// 路由js index.js
	var express = require('express');
	var router = express.Router();
	
	router.get('/list', function(req, res) {
	
	    var data = [{'name':'alex','age':23},{'name':'kevin','age':25}];
	    res.render('list',{ users: data});
	});
	
	module.exports = router;

	// 热启动
	supervisor app

	localhost:8000/list 访问	

<a name="9、Express框架"></a>
### 9、Express 框架 ###

> Express简介

	Express 是一个基于Node.js平台的简单灵活的web应用开发框架。
	可以实现非常强大的web服务器功能。

> Express特点
	
	1. 可以设置中间件响应或过滤 http 请求；
	2. 可以使用路由实现动态网页，响应不同的 http 请求；
	3. 内置支持 ejs 模板【默认是jade模板】实现模板渲染生成 html。

> Express-generator生成器

	是express官方团队开发的一个快速生成工具，可以快速的生成一个基本的express框架。

> Express安装与使用

	1. 安装 express-generator 生成器
		cnpm i -g express-generator		//安装完成后可以使用express命令

		//查看 express 版本
		express --version
		4.16.0

	2. 生成项目
		express -e <项目名称>	//自动创建项目目录
		express -e				//手动创建项目目录,cd后再运行生成项目


		比如：
		express -e demo3
		
		生成的项目：

			bin				可执行文件目录
			node_modules	依赖包的目录
			public			静态文件的根目录,存放静态资源
			routes			路由模块目录，动态文件的目录【JS文件】
							优先查找静态文件，若没有则找动态路由，若还没有则404显示
			views			视图目录，存储所有的模板文件，默认是后缀名jade。
			app.js			项目的主文件，对整个项目的所有资源进行统筹安排
			package.json	项目描述文件，声明项目的名称、版本、依赖等信息


			// app.js文件【重点】
			var createError = require('http-errors');
			var express = require('express');
			var path = require('path');
			var cookieParser = require('cookie-parser');
			var logger = require('morgan');
			
			var indexRouter = require('./routes/index');	//引入处理根目录请求的路由
			var usersRouter = require('./routes/users');	//引入处理users目录请求的路由
			
			var app = express();
			
			// view engine setup
			app.set('views', path.join(__dirname, 'views'));	//设置模板的默认目录
			app.set('view engine', 'jade');		//设置模板引擎，默认是jade模板
			
			app.use(logger('dev'));
			app.use(express.json());
			app.use(express.urlencoded({ extended: false }));
			app.use(cookieParser());
			app.use(express.static(path.join(__dirname, 'public')));	//设置静态文件的目录，也是静态文件的根目录
			
			app.use('/', indexRouter);		//分配根目录下的请求给index 模块去处理
			app.use('/users', usersRouter);	//分配users 目录下的请求给 users 模块去处理
			
			// catch 404 and forward to error handler
			app.use(function(req, res, next) {
			  next(createError(404));
			});
			
			// error handler
			app.use(function(err, req, res, next) {
			  // set locals, only providing error in development
			  res.locals.message = err.message;
			  res.locals.error = req.app.get('env') === 'development' ? err : {};
			
			  // render the error page
			  res.status(err.status || 500);
			  res.render('error');
			});
			
			module.exports = app;

	3. 安装依赖
		cnpm i

	4. 开启项目【3种方式】
	
		node app	
			【推荐】需要手动添加监听端口的代码
			// app.js
			app.listen(70,function(){
				console.log('开启服务');
			});
		
		【注】热部署

			npm install -g supervisor  #安装
			supervisor app  #启动

			或者
			npm i -g nodemon
			nodemon app

		npm start
			自动查找当我目录下的package.json 文件，找到start 对应的命令进行执行，默认端口是3000。后台也是运行 node ./bin/www

		node ./bin/www

	5. 测试项目
		浏览器访问 localhost:70 或者localhost:3000


> 路由

	路由是指接收用户请求，处理用户数据，返回结果给用户的一套程序。
	可以理解为：处理动态网页的程序。
	后端路由的核心：URL

> express 路由

	express 对象自带有一个 Router 类，可以实例化除路由对象，可以在该对象上挂载非常多的路由节点。

> 路由的写法

	var express = require('express');
	var router = express.Router();		//创建路由实例

	//挂载路由线路的写法【请求地址不需要加父目录】
	router.请求方式('请求地址',function(req,res){
		res.send('数据');
	});

> 创建一个独立的test路由模块

	创建路由模块步骤：
		1. 引入express 模块
		2. 创建路由实例
		3. 挂载路由线路到路由对象上【请求地址不需要加父目录】
		4. 暴露路由对象

	将创建好的路由模块引入主模块，由主模块分配对应的请求到该模块去处理
		

	比如：
	//test.js【分路由模块】
	var express = require('express');
	var test = express.Router();
	
	/* GET home page. */
	test.get('/', function(req, res, next) {
	  res.render('index', { title: 'Express' });	//views目录下的index.jade
	});

	test.get('/test.html', function(req, res) {
	  res.send('<div>this is test</div>');
	});
	
	module.exports = test;

	//app.js【总路由模块】
	var testRouter = require('./routes/test');	//引入test路由模块
	app.use('/test', testRouter);	//分配test目录下的请求到test路由模块去处理


> 路由区分

	总路由：	app.js	负责接收所有请求，对请求进行分配；
	分路由：	/routers下面的所有路由模块，只负责处理自己能管理的目录下的请求。

> 响应对象方法

	response.send();	//返回任意类型的数据。

	【注】
		1. 如果返回一个数字，会被当成是状态码，此时需要对数字加引号转为字符串；
		2. send()方法只能出现一次，重复无效会报错
		3. 设置状态码，还可以链式调用返回内容 
			response.status(500).send('error');

	//将数据按JSON格式返回，自动设置application/json响应头
	response.json();	

	//读取模板文件并拼接数据，自动将结果返回给浏览器
	response.reder('模板名',{数据});	

	比如：
	var data = [
	  		{'name':'alex','age':23},
	  		{'name':'kevin','age':25}
	  	];
	 response.render('list',{users:data});


	response.download();	//下载

	response.redirect();	//跳转

	response.set();			//设置响应头
		response.set({'Content-Type':'text/html';'charset':'utf-8'});

	response.status();		//设置状态码

> 请求对象

	获取GET方式传的值
		语法：req.query.参数名;
		实例：var id = req.qurey.id;

	接收POST方式传的值
		语法：req.body.参数名;
		实例：var passwd = req.body.password;

	匹配URL上的数据
		在接收请求的地方匹配，再通过语法进行接收；
		语法：req.params.参数名;

> 中间件

	中间件就是一个函数【关口】，位于客户端和路由之间，可以访问请求对象和响应对象，可以调用下一个中间件。
	Express 就是一个由中间件构建起来的框架。

	语法：
		app.use(function(req,res,next){
			// TODO
		});

	自定义中间件
		app.use(function(req,res,next){
			res.send('中间件');
		});

	尾函数 next
		如果在中间件不调用尾函数，整个请求响应流程就中止不会往后执行。
		调用next函数就相当于调用下一个中间件，执行完后如果自己的函数还有内容则继续往下执行。

		比如:
			app.use(function(req,res,next){
				res.send('中间件1');
				next();	//调用下一个中间件
			});
	
			app.use(function(req,res,next){
				res.send('中间件2');
			});

	app.use(function(err, req, res, next) {
	  res.status(err.status || 500);
	  res.render('error', {
	    message: err.message,
	    error: {}
	  });
	});
	




