# RequireJS #

* [1、RequireJS简介](#1、RequireJS简介)
* [2、RequireJS配置文件](#2、RequireJS配置文件)
* [3、RequireJS使用](#3、RequireJS使用)

<a name="1、RequireJS简介"></a>
### 1、RequireJS简介 ###

- [中文官网](http://www.requirejs.cn/)  
- [英文官网](https://requirejs.org/docs)
- 客户端**模块化**规范
- 可以用它来加速、优化代码，但其主要目的还是为了代码的模块化。它鼓励在使用脚本时以 module ID 替代 URL 地址。
- RequireJS 默认假定所有的依赖资源都是js脚本，因此在创建或者读取模块时，无需在模块名上加 ".js" 后缀，RequireJS在进行模块名到path的解析时会**自动补上后缀**。

<a name="2、RequireJS配置文件"></a>
### 2、RequireJS 配置文件 ###

> requirejs下，其主要API主要是下面三个函数:

	define： 该函数用户创建模块。
		每个模块拥有一个唯一的模块ID，它被用于RequireJS的运行时函数，define函数是一个全局函数，不需要使用requirejs命名空间；

	require：该函数用于读取依赖，加载模块。
		同样它是一个全局函数，不需要使用requirejs命名空间；

	config：该函数用于配置RequireJS。
		使用requirejs命名空间 requirejs.config。

	【注】
		requirejs 只是require的一个别名，requirejs === require
		
> define创建模块

	语法：
		define = function (name, deps, callback)
			name：定义模块名，可选；
			deps: 定义模块所需要的依赖;
			callback: 定义模块的主函数。

	【注】
	模块所需要的依赖是以数组的形式入参，多个依赖使用逗号隔开，数组的形参要和函数中的参数一一对应。
	模块的定义，通常不用自己显示写模块名，用官方的说法是:让优化工具去自动生成这些模块名。

	比如：
	// script/desc.js ，没有依赖
	define(function(){
	    return{
	        decs : 'this js will be request only if it is needed',
	    };
	})

	// script/alertdesc.js，有依赖
	define(['script/desc'],function(desc){
	    return function (){
	        alert(JSON.stringify(desc));
	    };
	})

> require读取模块

	语法：
		require(desc,callback)
			deps: 模块所需要的依赖;
			callback: 模块的主函数。

	【注】
	模块所需要的依赖是以数组的形式入参，多个依赖使用逗号隔开，数组的形参要和函数中的参数一一对应。
	主函数和require的回调函数一样，同样是在依赖加载完以后再调用执行。

	比如：
	require(['script/desc'],function(desc){
       	alert(JSON.stringify(desc)
		);

    点击按钮，通过require获得的desc模块就会alert出来。

> require.config配置参数选项

	baseUrl：设置加载模块的根路径。

	paths：用于映射不存在根路径下面的模块路径，为模块设置别名。
		以对象的形式 {路径别名：真实路径名}或者{模块别名：模块名}。

	deps：加载依赖关系数组。

> requirejs.config()应该抽出来，单独放在一个js文件里面，这样方便移植和重用。
	
	requirejs.config({
	    
	    baseUrl: 'js/lib',
	
	    paths: {
	        app: '../app'
	    }
	});

	加载解析路径 "baseUrl + paths"，加载这个路径下的js 脚本。

<a name="3、RequireJS使用"></a>
### 3、RequireJS 使用 ###

> 需要在页面中引入的文件

	<script data-main="js/main" src="xxx/xxxx/require.js"></script>
	 或者
	  <script  src="xxx/xxxx/require.js"></script>

> requireJS在不同情况下的相对路径。

	以下是相对路径的规则:
	
		1.如果<script>标签引入require.js时没有指定data-main属性，则以引入该js的html文件所在的路径为根路径。
	
		2.如果有指定data-main属性，也就是有指定入口文件，则以入口文件所在的路径为根路径。
	
		3.如果在 requirejs.config() 中有配置 baseUrl，则以baseUrl的路径为根路径。
	
		以上三条优先级逐级提升，如果有重叠，后面的根路径覆盖前面的根路径。

> 官网例子：

	//index.html:
	<script data-main="js/app.js" src="js/require.js"></script>
	
	//app.js:
	requirejs.config({
	    //By default load any module IDs from js/lib
	    baseUrl: 'js/lib',
	    //except, if the module ID starts with "app",
	    //load it from the js/app directory. paths
	    //config is relative to the baseUrl, and
	    //never includes a ".js" extension since
	    //the paths config could be for a directory.
	    paths: {
	        app: '../app'
	    }
	});

	// Start the main app logic.
	requirejs(['jquery', 'canvas', 'app/sub'],function($, canvas, sub) {
	    //jQuery, canvas and the app/sub module are all
	    //loaded and can be used here now.
	});


> 例子：

	//1. 引入require.js
	//2. 导入配置文件模块config
	//3. 定义模块 module
	//4. 导入依赖模块module

	<script src="<s:url value="/js/require.js" />"></script>
	<script type="text/javascript">
	    require([ '../config'], function() {
	        require(['app/module'], function(module) {
	            var config = {
	                url: {
	                    list: "${listURL}",
	                    back: "${pagination.getCurrentPageURL()}"
	                }
	            };
	            module.initEdit(config);
	        });
	    });
	</script>