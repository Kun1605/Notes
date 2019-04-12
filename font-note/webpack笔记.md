# Webpack #

<a name="1、Webpack介绍"></a>
### 1、Webpack介绍 ###

- webpack是文件打包工具，可以把项目的各种js文、css文件等打包合并成一个或多个文件，主要用于模块化方案，预编译模块的方案。
- 将根据模块的依赖关系进行动态加载，并依据规则生成对应的静态资源，使得浏览器可以识别。
- 生成一个统一的模块文件，模块间的依赖关系由它内部处理，开发者不用关心。
- 分析你的项目结构，找到JavaScript模块以及其它的一些浏览器不能直接运行的拓展语言（Scss，TypeScript等），并将其转换和打包为合适的格式供浏览器使用。

	1. 打包工具
	2. 模块化识别
	3. 编译模块代码方案用

> webpack的工作方式
 
	把项目当做一个整体，通过一个给定的主文件（如：index.js），Webpack将从这个文件开始找到你的项目的所有依赖文件，使用 rules 依据规则处理它们，最后打包为一个（或多个）浏览器可识别的JavaScript文件。

	所以就需要有 入口文件、出口文件、加载规则

[中文文档](https://www.webpackjs.com/guides/installation/)

<a name="2、webpack安装"></a>
### 2、webpack安装 ###

> 要安装最新版本或特定版本

	单项目安装
	npm install --save-dev webpack
	npm install --save-dev webpack@<version>  
	
	全局安装 -g
	npm install webpack -g
	
> 安装 CLI 【提供命令行参数运行】

	npm install --save-dev webpack-cli
	npm install -g webpack-cli

> 配置环境变量

	新建 WEBPACK_HOME，值为 D:\Program Files\nodejs\node_global
	在 Path中添加 %WEBPACK_HOME%

<a name="3、webpack使用"></a>
### 3、webpack使用 ###

> 初始化

	1. 创建项目
	
	2. 初始化项目 -- 生成 package.json 文件
		npm init -y	
		
		package.json文件包含项目名称，项目描述，作者等信息

	3. 创建以下目录结构、文件和内容
		1. 输出目录 -- dist【存放输出文件，包括 index.html】;
		2. 静态文件目录 -- src【存放js/images/css等资源文件】

	4. 创建配置文件 webpack.config.js 【位于项目根目录】
		配置所有的与打包相关的信息，webpack的配置文件会暴露出一个对象
	
		module.exports = {
		    entry: __dirname + "/src/main.js",  //唯一入口文件
		    output: {
		        path: __dirname + "/dist",  //打包后的文件存放的地方
		        filename: "bundle.js"   	//打包后输出文件的文件名
		    }

			// 配置项
		};

> webpack.config.js 常用配置项说明

	1. entry：打包的入口文件，一个字符串或者一个对象
		1. entry: __dirname + "/src/main.js",  //唯一入口文件

		2. 入口文件也可以设置多个，即作为一个对象。打包成多个模块时，可以使用这种方式。
		entry: {
		    index:'./src/js/index.js',
		    main:'./src/js/main.js'
		  },

		【注】
		当entry是一个键值对形式的对象时，包名就是键名，output的 filename 不能是一个固定的值，因为每个包的名字不能一样 filename: "bundle-[name].js"

		"__dirname" 是node.js中的一个全局变量，它指向当前执行脚本所在的目录。

	2. output：配置打包输出的结果，一个对象
			filename：定义输出文件名，一个字符串
			path：定义输出文件路径，一个字符串

		当输出多个文件，output.filename不能为一个确定的字符串。
		为了让每个文件有一个唯一的名字，需要用到下面的变量。
		比如 bundle-[hash].js、[name].[hash].bundle.js
			[name] 对应entry的键名
			[hash] 随机哈希值

		output: {
		        path: __dirname + "/dist",  //打包后的文件存放的地方
		        filename: "bundle.js"   	//打包后输出文件的文件名
		    }

[https://www.webpackjs.com/configuration/output/](https://www.webpackjs.com/configuration/output/ "更多可选变量")

	3. module:定义对模块的处理逻辑，一个对象
　　　　　　rules：定义一系列的规则，一个数组
　　　　　　　　[
　　　　　　　　　　{
　　　　　　　　　　　　test:	正则表达式，用于匹配到的文件
　　　　　　　　　　　　use：对象【需要添加选项时】或者数组，处理匹配到的文件。
					  use: [
		  					'style-loader',
			  				{
		                    loader: "css-loader",
		                    options: {
		                        modules: true,  // 启用 css module
		                    }
						}
		  				]
　　　　　　　　　　　　include：字符串或者数组，指包含的文件夹
　　　　　　　　　　　　exclude：字符串或者数组，指排除的文件夹
　　　　　　　　　　}
　　　　　　　　]

	4. resolve: 影响对模块的解析，一个对象
		extensions：自动补全识别后缀，是一个数组
			resolve.extensions并不是必须配置的，当不配置时，会使用默认值["", ".webpack.js", ".web.js", ".js"]。
			当手动为 resolve.extensions 设置值时，它的默认值会被覆盖。


	5. plugins: 定义插件，一个数组

	

> 暴露模块【即该模块暴露的方法可以被其他JS中引用】

	function show(content){
		return content;
	}
	
	module.exports=show
	
> 引入模块

	同级目录需要使用 ./引用
	require("./show.js");

> 加载CSS文件

	为了从 JavaScript 模块中 import 一个 CSS 文件，你需要在 module 配置中 安装并添加 style-loader 和 css-loader：

	npm install --save-dev style-loader css-loader

	然后指示 webpack 对每个 .css 使用 css-loader。
	//webpack.config.js
	module: {
	  	rules: [
	  		{
	  			test: /\.css$/,
	  			use: [
	  				'style-loader',
	  				'css-loader' 
	  				]
	  		}
	  	]
	  }

> 模式

	打包的时候需要指定使用的模式 
		development -- 开发模式
		production -- 生产模式
	
	指定方式：
		1. 在 配置文件 webpack.config.js中指定 mode: 'development'
		2. 从 CLI 参数中传递：webpack --mode=production

> 运行webpack

	方式一：
		在项目根目录下运行命令：
			webpack --mode development/production 【指定开发模式/生产模式】
	
			node_modules/.bin/webpack --mode development/production 【非全局安装需使用】
	
		这条命令会自动引用 webpack.config.js 文件中的配置选项。
		生成打包的js 文件 -- bundle.js

	方式二：
		通过 npm 命令行来启动 npm start
		需要在 package.json 中对 scripts 对象进行相关设置，通过对脚本【scripts】的加载引用来运行对应的命令。
		比如：
			"scripts": {
			    "start": "webpack-dev-server --open",
			    "build": "webpack"
			  },

		运行 npm run start/build 就可以运行start/build 所对应的命令【webpack-dev-server --open 或者 webpack】。

		由于 npm 的 start 命令是一个特殊的脚本名称，其特殊性表现在，在命令行中使用 npm start 就可以执行其对应的命令。
		如果对应的此脚本名称不是 start，想要在命令行中运行时，需要这样用 npm run {script.name} 如: npm run dev

		"scripts": {
		    "dev":"webpack --mode development",
		    "bulid":"webapck --mode production"
		  },


例子：

	//webpack.config.js
	const path = require('path');

	module.exports = {
	  entry: './src/js/index.js',
	  output: {
	    filename: 'bundle.js',
	    path: path.resolve(__dirname, 'dist')
	  },
	  mode: 'development',
	  module: {
		  	rules: [
		  		{
		  			test: /\.css$/,
		  			use: [
		  				'style-loader',
		  				'css-loader'
		  				],
		  			exclude: /node_modules/
		  		},
		  		{
		  			test: /\.(png|svg|jpg|gif)$/,
		  			use: [
		  				'file-loader'
		  				/*loader: 'file-loader',
		  				options: {
		  					//文件上传大小 
		  				}*/
		  				]
		  		}
		  	]
		  }
	};

	//在src/css中创建style.css
	//在src/js中创建index.js/show.js
	//index.js
	var fn = require("./show.js");
	require('../css/style.css');
	var image = require("../images/001.png");
	
	var img = document.createElement('img');
	var div = document.getElementsByTagName('div')[0];
	console.log(div);
	div.onclick = function(Events){
		console.log('点击了test');
		Events.target.appendChild(img).setAttribute("src","image");
	};
	document.write(fn('显示测试'));

	//show.js
	function show(content){
		return content;
	}
	
	module.exports=show


	//index.html
	<body>
    	<div>this is test</div>
    	<script src="./dist/bundle.js"></script>
  	</body>

	//打包
	webpack

	//运行
	npm run start

### webpack 功能 ###

> 1、生成 Source Maps（使调试更容易）

	通过简单的配置，webpack 就可以在打包时为我们生成的 source maps，这为我们提供了一种对应编译文件和源文件的方法，使得编译后的代码可读性更高，也更容易调试。

	在webpack的配置文件中配置source maps，需要配置devtool【调试工具】

|devtool选项|配置结果|
|:--|:--|
|source-map	|在一个单独的文件中产生一个完整且功能完全的文件。这个文件具有最好的source map，但是它会减慢打包速度；|
|cheap-module-source-map|在一个单独的文件中生成一个不带列映射的map，不带列映射提高了打包速度，但是也使得浏览器开发者工具只能对应到具体的行，不能对应到具体的列（符号），会对调试造成不便；|
|eval-source-map|使用eval打包源文件模块，在同一个文件中生成干净的完整的source map。这个选项可以在不影响构建速度的前提下生成完整的sourcemap，但是对打包后输出的JS文件的执行具有性能和安全的隐患。在开发阶段这是一个非常好的选项，在生产阶段则一定不要启用这个选项；|
|cheap-module-eval-source-map|这是在打包文件时最快的生成source map的方法，生成的Source Map 会和打包后的JavaScript文件同行显示，没有列映射，和eval-source-map选项具有相似的缺点；|

	上述选项由上到下打包速度越来越快，不过同时也具有越来越多的负面作用，较快的打包速度的后果就是对打包后的文件的的执行有一定影响。

	对小到中型的项目中，eval-source-map是一个很好的选项，只应该开发阶段使用它。

	module.exports = {
	    entry: __dirname + "/src/main.js", 
	    output: {
	        path: __dirname + "/dist",  
	        filename: "bundle.js"   	
	    },
		devtool: 'eval-source-map',
	};

> 2、使用webpack构建本地服务器

	让浏览器监听你的代码的修改，并自动刷新显示修改后的结果。
	使用Webpack提供一个可选的本地开发服务器，这个本地服务器基于node.js构建。
	需要安装插件：
		npm install -g webpack-dev-server --save-dev

|devserver的配置选项|功能描述|
|:--|:--|
|contentBase| 默认 webpack-dev-serve r会为根文件夹提供本地服务器，即默认打开根目录的html文件【无需设置该属性】，若想默认打开指定目录的文件，可以设置该属性，比如设置到目录 dist|
|port|	设置默认监听端口，如果省略，默认为”8080“|
|inline| 设置为true，当源文件改变时会自动刷新页面|
|historyApiFallback| 在开发单页应用SPA时非常有用，它依赖于HTML5 history API，如果设置为true，所有的跳转将都指向 index.html|

[更多配置查看官网](https://www.webpackjs.com/configuration/dev-server/)

	devServer: {
        contentBase: "./dist",//本地服务器所加载的页面所在的目录
        historyApiFallback: true,//不跳转
        inline: true,   //实时刷新
        open: true,     // 打开浏览器
        hot: true       // 热更新
    },

	【注】
	开启hot 热更新时需要配置插件 new webpack.HotModuleReplacementPlugin()

> 在package.json中的 scripts对象中添加如下命令，用以开启本地服务器：

	"scripts": {
	    "start": "webpack-dev-server --open",
	    "build": "webpack"
	  },

	也可以在 脚本中使用参数形式 配置 devserver
	--open：                       //打开默认浏器，index.html
	--config  webpack.config.js     //运行webpack。cofig.js文件
	--hot：                        //实现热替换
	--inline:                      //实现自更新
	--quiet                       //  控制台中不输出打包的信息
	--compress                      //开启gzip压缩
	--progress                    //显示打包的进度
	--colors:                    //进度用颜色表示

> 运行如下命令即可在本地的 8080 端口查看结果

	npm start

### loader ###
[loaders说明](https://www.webpackjs.com/loaders/)
> loader的作用

	通过使用不同的loader，webpack有能力调用外部的脚本或工具，实现对不同格式的文件的处理。
	比如说分析转换scss为css，或者把下一代的JS文件（ES6，ES7)转换为现代浏览器兼容的JS文件，对React的开发而言，合适的Loaders可以把React的中用到的JSX文件转换为JS文件。

	Loader 需要单独安装并且需要在 webpack.config.js 中的 modules 关键字下进行配置，Loader 的配置包括以下几方面：

		1. test：一个用以匹配 loader 所处理文件的拓展名的正则表达式【必须】
		2. loader：loader的名称【必须】
		3. include/exclude：	手动添加必须处理的文件（文件夹）或屏蔽不需要处理的文件（文件夹）【可选】；
		4. options：为loaders提供额外的设置选项【可选】

	module: {
        rules: [
            {
                test: /(\.jsx|\.js)$/,
                use: {
                    loader: "babel-loader",
                    options: {
                        presets: [
                            "env", "react"	
                        ]
                    }
                },
                exclude: /node_modules/
            }
        ]
    }

> Babel 的安装与配置

	Babel其实是一个编译JavaScript的平台，它可以编译代码帮你达到以下目的：

		1. 让你能使用最新的JavaScript代码（ES6，ES7...），而不用管新标准是否被当前使用的浏览器完全支持；
		2. 让你能使用基于JavaScript进行了拓展的语言，比如 React 的JSX；

	Babel其实是几个模块化的包，其核心功能位于称为 babel-core 的npm包中，webpack可以把其不同的包整合在一起使用，对于每一个你需要的功能或拓展，你都需要安装单独的包。
		用得最多的是解析 ES6 的 babel-preset-env 包和解析 React【JSX】的 babel-preset-react 包。

	// npm一次性安装多个依赖模块，模块之间用空格隔开
	npm install --save-dev babel-core babel-loader babel-preset-env babel-preset-react

	// 在 webpack.config.js 中进行配置，提供对 ES6，react语法的转码功能
	module: {
        rules: [
            {
                test: /(\.jsx|\.js)$/,
                use: {
                    loader: "babel-loader",
                    options: {
                        presets: [
                            "env", "react"	 //允许使用ES6以及react的语法
                        ]
                    }
                },
                exclude: /node_modules/
            }
        ]
    }

	由于涉及到 react，所以先安装 React 和 React-DOM
	npm install --save react react-dom

	【注】
	babel-core babel-loader 间有可能会因为版本的问题报错

> Babel 的配置
	
	考虑到都在 webpack.config.js 中配置显得这个文件过于太大，所以把babel的配置选项放在一个单独的名为 ".babelrc" 的配置文件中。
	webpack会自动调用 .babelrc 里的 babel 配置选项

	// webpack.config.js 
	module: {
        rules: [
            {
                test: /(\.jsx|\.js)$/,
                use: {
                    loader: "babel-loader"
                },
                exclude: /node_modules/
            }
        ]
    }

	// .babelrc
	{
	  "presets": [
	    "env", "react"
	  ]
	}
	

### 模块 ###

> 一切皆模块

	Webpack有一个不可不说的优点，它把所有的文件都当做模块处理，JavaScript代码，CSS和fonts以及图片等等通过合适的loader都可以被处理。

	创建模块时，匹配请求的规则数组。
	这些规则能够修改模块的创建方式。这些规则能够对模块(module)应用 loader，或者修改解析器(parser)。

	每个入口(entry)指定使用一个 loader。
	传递字符串（如：use: [ "style-loader" ]）是 loader 属性的简写方式

	use: [
	  'style-loader',
	  {
	    loader: 'css-loader',
	    options: {
	      importLoaders: 1
	    }
	  },
	  {
	    loader: 'less-loader',
	    options: {
	      noIeCompat: true
	    }
	  }
	]

	条件 rules

		字符串：匹配输入必须以提供的字符串开始。是的。目录绝对路径或文件绝对路径。
		正则表达式：test 输入值。
		函数：调用输入的函数，必须返回一个真值(truthy value)以匹配。
		条件数组：至少一个匹配条件。
		对象：匹配所有属性。每个属性都有一个定义行为。
		{ test: Condition }：匹配特定条件。一般是提供一个正则表达式或正则表达式的数组，但这不是强制的。
		
		{ include: Condition }：匹配特定条件。一般是提供一个字符串或者字符串数组，但这不是强制的。
		
		{ exclude: Condition }：排除特定条件。一般是提供一个字符串或字符串数组，但这不是强制的。
		
		{ and: [Condition] }：必须匹配数组中的所有条件
		
		{ or: [Condition] }：匹配数组中任何一个条件
		
		{ not: [Condition] }：必须排除这个条件
		
		示例:
		
		{
		  test: /\.css$/,
		  include: [
		    path.resolve(__dirname, "app/styles"),
		    path.resolve(__dirname, "vendor/styles")
		  ]
		}

> 加载 CSS 

	webpack提供两个工具处理样式表【CSS 文件】：css-loader 和 style-loader，二者处理的任务不同。
	css-loader 使你能够使用类似 @import 和 url(...)的方法实现 require()的功能；
	style-loader 将所有的计算后的样式加入页面中。
	二者组合在一起使你能够把样式表嵌入webpack打包后的JS文件中。

	// 安装 loader
	npm install --save-dev style-loader css-loader

	
	// 配置 webpack.config.js，指示 webpack 对每个 .css 使用 css-loader
	module: {
	  	rules: [
	  		{
	  			test: /\.css$/,
	  			use: [
	  				'style-loader',
	  				'css-loader' 
	  				]
	  		}
	  	]
	  }

	// 创建 .css 文件 style.css
	// js 文件引入css 
	import '../css/style.css';

> CSS module

	把JS的模块化思想带入CSS中来。
	Webpack对CSS模块化提供了非常好的支持，只需要在CSS loader中进行简单配置即可，然后就可以直接把CSS的类名传递到组件的代码中，这样做有效避免了全局污染。
	
		{
            test: /\.css$/,
            use: [{
                loader: "style-loader"
                },{
                loader: "css-loader",
                options: {
                    modules: true,  // 启用 css module
                    localIdentName: '[name]__[local]--[hash:base64:5]' // 指定css的类名格式
                }
            }
            ],
            exclude: /node_modules/
        }

	// style.css
	.root {
	    background-color: #eee;
	    padding: 10px;
	    border: 3px solid #ccc;
	}

	// 在 js中 导入 css

	import React,{ Component } from 'react';
	import config from '../config.json';
	import styles from '../css/style.css';
	
	class Greeter extends Component{
	    render() {
	        return (
	            <div className={styles.root}>
	                { config.content }
	            </div>
	        );
	    }
	}
	
	export default Greeter;

	这样就可以避免不同组件之间的 css 污染。

	// 浏览器显示
	<div class="style__root--2kfbL">
		Hi there and greetings from JSON!!!
	</div>


<a name="常用插件"></a>
### 常用插件 ###

> 插件（Plugins）的作用

	插件是用来拓展Webpack功能的，它们会在整个构建过程中生效，执行相关的任务。

	Loaders 和 Plugins 常常被弄混，但是他们其实是完全不同的东西。
		loaders是在打包构建过程中用来处理源文件的（JSX，Scss，Less..），一次处理一个；
		插件并不直接操作单个文件，它直接对整个构建过程其作用。

> 使用插件的方法

	要使用某个插件，我们需要通过 npm 安装它，然后要做的就是在webpack配置中的plugins关键字部分添加该插件的一个实例（plugins是一个数组）

> 添加说明

	该插件给打包的 js 文件添加说明。

	plugins: [
        new webpack.BannerPlugin("版权所有"),
  		//...
    ]

	// bundle.js
	/*! 版权所有 */

> HtmlWebpackPlugin

	这个插件的作用是依据一个简单的 index.html 模板，生成一个自动引用你打包后的JS文件的新index.html。
	这在每次生成的js文件名称不同时非常有用（比如添加了hash值）。
	可以避免由于客户端缓存了js,而无法获取最新的js，需要为暴露给客户端的js路径上添加hash参数。

	npm install html-webpack-plugin --save-dev

	// 配置 webpack.config.js，导入插件，并配置插件

	const webpack = require('webpack');
	const HtmlWebpackPlugin = require('html-webpack-plugin');
	
	module.exports = {
		...
		plugins: [
	        new webpack.BannerPlugin("版权所有"),
	        new HtmlWebpackPlugin({
	            template: __dirname + "/src/template/index.temp.html",   //new 一个这个插件的实例，并传入相关的参数
	            minify: {
	                collapseWhitespace: true,	//压缩html空格
	                "removeComments": true
	            },
	            hash: true,		// 在 bundle.js后添加随机 hash值
	        })
	    ]
	}

	运行 npm run dev 后在dist 中自动生成 bundle.js、index.html 文件。

> Hot Module Replacement
	
	Hot Module Replacement（HMR）也是webpack里很有用的一个插件，它允许你在修改组件代码后，自动刷新实时预览修改后的效果。

	在webpack中实现HMR也很简单，只需要做2项配置
		1. 在 webpack 配置文件中添加 HMR插件；
		2. 在 Webpack Dev Server 中添加 "hot" 参数；

	plugins: [
        
        new webpack.HotModuleReplacementPlugin()//热加载插件
        
    ]

	devServer: {
        ...
        hot: true       // 热更新
    },


> 去除build文件中的残余文件

	filename: "bundle-[hash].js"

	添加了hash之后，会导致改变文件内容后重新打包时，文件名不同而内容越来越多，因此这里介绍另外一个很好用的插件 clean-webpack-plugin。

	安装：
	npm install clean-webpack-plugin --save-dev

	使用：
	
	const CleanWebpackPlugin = require("clean-webpack-plugin");
	  plugins: [
	    ...
	    new CleanWebpackPlugin('dist/*.*', {
	      root: __dirname,
	      verbose: true,
	      dry: false
	  	})
	  ]

	运行 npm run dev 后可以清空 dist 下的文件，并生成新的 bundle-[hash].js和 index.html

> CommonsChunkPlugin

	这个插件可以把多个html中公共依赖的部分打包成一个和多个公共依赖包（chunk），这样每个页面只需要引入这个公共chunk和自己单独的js就可以了。

	var CommonsChunkPlugin = require("webpack/lib/optimize/CommonsChunkPlugin");

	entry: {
	    index:'./src/js/index.js',
	    main:'./src/js/main.js'
	  },

	new CommonsChunkPlugin({
      name: "commons",
      // (the commons chunk name)

      filename: "commons.js",
      // (the filename of the commons chunk)

       minChunks: 2,
      // (Modules must be shared between 2 entries)

      chunks: ["index", "main"]
      // (Only use these entries)

    })//定义公共chunk

	CommonsChunkPlugin的参数：

		name：chunk名
		
		filename：生成的文件名
		
		minChunks：最小引用次数，一个依赖最少被引入这个次数才会被加到公共的chunk中
		
		chunks：指定这个chunk是由哪些页面构成的


> 优化插件 -- 压缩文件插件

	// 压缩 JS 文件
	const uglify = require('uglifyjs-webpack-plugin');

	plugins:[
        new uglify()
    ]

> webpack.config.js

	const webpack = require('webpack');
	const HtmlWebpackPlugin = require('html-webpack-plugin');
	// const CleanWebpackPlugin = require('clean-webpack-plugin');
	
	module.exports = {
	    entry: __dirname + "/src/js/main.js",  //唯一入口文件
	    output: {
	        path: __dirname + "/dist",  //打包后的文件存放的地方
	        filename: "bundle.js"   //打包后输出文件的文件名
	    },
	    devtool: 'eval-source-map',
	    mode: "development",
	    devServer: {
	        contentBase: "./dist",//本地服务器所加载的页面所在的目录
	        historyApiFallback: true,//不跳转
	        inline: true//实时刷新
	    },
	    module: {
	        rules: [
	            {
	                test: /(\.jsx|\.js)$/,
	                use: {
	                    loader: "babel-loader",
	                },
	                exclude: /node_modules/
	            },
	            {
	                test: /\.css$/,
	                use: [
	                    "style-loader",
	                    {
	                    loader: "css-loader",
	                    options: {
	                        modules: true,  // 启用 css module
	                        localIdentName: '[name]__[local]--[hash:base64:5]' // 指定css的类名格式
	                    }
	                }
	                ],
	                exclude: /node_modules/
	            }
	        ]
	    },
	    plugins: [
	        new webpack.BannerPlugin("版权所有"),
	        new HtmlWebpackPlugin({
	            template: __dirname + "/src/template/index.temp.html",   //new 一个这个插件的实例，并传入相关的参数
	            minify: {
	                collapseWhitespace: true,	//压缩html空格
	                "removeComments": true
	            },
	            hash: true, // 添加随机 hash值
	        }),
	        // new webpack.HotModuleReplacementPlugin()//热加载插件
	        /*new CleanWebpackPlugin('dist/!*.*', {
	            root: __dirname,
	            verbose: true,
	            dry: false
	        })*/
	    ]
	};


### gulp ###

> gulp 是什么？

	gulp是基于 流 的工具链、构建工具，可以配合各种插件做js压缩，css压缩，less编译 替代手工实现自动化工作。利用gulb 插件完成更多的任务。
	gulp 是基于 Nodejs 的自动任务运行器， 能自动化地完成 javascript/coffee/sass/less/html/image/css 等文件的的测试、检查、合并、压缩、格式化、浏览器自动刷新、部署文件生成，并监听文件在改动后重复指定的这些步骤。
	在实现上，她借鉴了Unix操作系统的管道（pipe）思想，前一级的输出，直接变成后一级的输入，使得在操作上非常简单。

		1. 构建工具
		2. 自动化
		3. 提高效率用

> gulp

	对 app/**/*.js 进行监听，当文件发生变化时自动执行 scripts脚本
	gulp.watch('app/**/*.js',['scripts']);
[gulp更多API](https://www.gulpjs.com.cn/docs/api/)  
[更多插件](http://www.ydcss.com/archives/tag/gulp)  
[Gulp中文网](https://www.gulpjs.com.cn/)

### webpack和gulp ###

> 整合

	webpack 负责处理 js ，其他的资源文件交给 gulp处理。
	需要插件 webpack-stream
	npm i  --save-dev webpack-stream

	例子：
	var webpack = require('webpack-stream');

	gulp.task('testLess', function () {
	    gulp.src('src/less/index.less') //该任务针对的文件
	        .pipe(less()) //该任务调用的模块
	        .pipe(gulp.dest('src/css')) //将会在src/css下生成index.css
	        .pipe(webpack( require('./webpack.config.js') ))	//处理webpack
	        .pipe(gulp.dest('dist'))
	});

> 区别

	gulp 是基于流的**构建工具**：all in one的打包模式，输出一个js文件和一个css文件，优点是减少http请求，万金油方案。  
	webpack 是**模块化管理工具**，使用webpack可以对模块进行压缩、预处理、打包、按需加载等。
