# AngularJS #

	MVVM【Model View ViewModel】架构,ViewModel视图模型，用来管理model和view之间的关系。
	视图表单的数据和程序数据是对应关联的，一个变化，另一个直接改变，而不需要使用控制器对其进行对应修改。
	
	AngularJS是一个开发动态Web应用的框架。
	Angular是为了扩展HTML在构建应用时本应具备的能力而设计的。
	Angular通过指令（directive）扩展HTML的语法。
	指令使用 ng- 作为前缀。
	
	例如：
		通过{{}}进行数据绑定。
		使用DOM控制结构来进行迭代或隐藏DOM片段。
		支持表单和表单验证。
		将逻辑代码关联到DOM元素上。
		将一组HTML做成可重用的组件。

双向数据绑定

	在Angular网页应用中，数据绑定是数据模型(model)与视图(view)组件的自动同步。
	Angular的实现方式允许你把应用中的模型看成单一数据源。而视图始终是数据模型的一种展现形式。
	当模型改变时，视图就能反映这种改变，反之亦然。
	angular是局部刷新，不是全局刷新。
	表单数据和程序数据进行双向绑定，程序数据或者表单数据的改变会自动更新到视图中显示。
	不直接去操作DOM元素,只需要关心怎么操作数据。
	
	ng-model指令将程序数据和表单元素进行双向绑定
		ng-model="name"
	
	用途：
		插入表单和空程序数据对象绑定，插入的表单的数据即输入到程序数据中，这样就可以在程序中获取用户输入的数据。

模块

	用于注册函数和对象。
	创建模块invoice,依赖模块finance
	angular.module('invoice', ['finance']);
	
	没有依赖模块
	angular.module('invoice', []);
	
	使用：
		在表单中使用指令 ng-app='模块名'来指定使用的模块。
		一个视图页面只能使用一个 ng-app。

控制器

	用来在将来真正需要的时候创建这个控制器函数的实例。
	控制器的用途是导出一些变量和函数，供模板中的表达式(expression)和指令(directive)使用。
	当一个控制器通过 ng-controller 指令被添加到DOM中时，ng 会调用该控制器的构造函数来生成一个控制器对象，这样，就创建了一个新的子级 作用域(scope)。
	我们使用控制器做两件事：
	
		初始化 $scope 对象
		为 $scope 对象添加行为（方法）
	
	如果需要使用服务的话，首先要在控制器中注入服务。
	
	//js
	var app = angular.module('模块名',[]);
	app.controller('控制器类',['依赖实参',function(依赖形参){
		//操作变量/函数
	}]);
	
	//需要在表单中创建控制器指令属性
	ng-controller="控制器类 as 控制器实例"
	
	在表单中就可以使用控制器实例.xxx引用js中控制器定义的变量或函数。
	函数也可以传参。

例子：

	<!doctype html>
	<!doctype html>
	<script src="G:\前端\lib\angular-1.7.4\angular.js"></script>
	<html ng-app="MyApp">
	  <body >
	     <div ng-controller="User as user">
	      <input type="text" name="name" ng-model="name"><br/>
	      <input type="password" name="password" ng-model="user.password"><br/>
	      <button ng-click = "double(age)">按钮</button>
	      <p>{{name +":"+user.password +":" + age}}</p>
	    </div>
	
	    <script type="text/javascript">
	        var app = angular.module('MyApp',[]);
	        app.controller('User',['$scope',function($scope){
	          $scope.name = "alex";
	          $scope.age = 12;
	          this.password = "123456";
	          $scope.double =function(age){
	           $scope.age = age + 1;
	          }
	        }]);
	    </script>
	   
	  </body>
	</html>

> 遍历

	使用指令 ng-repear 来遍历数据。
	语法：ng-repeat="变量名 in 数组数据"
	
	<tr ng-repeat="item in score.data">
		<td>{{ item.sid }}</td>
		<td>{{ item.name }}</td>
		<td>{{ item.yuwen }}</td>
		<td>{{ item.shuxue }}</td>
	</tr>

> ng-options

	label为显示的对象；value为对象的值
	
	1. 数据为普通数组形式
		this.arr = ['a','b','c'];
		ng-options = "item for item in mainCtrl.arr"
	
	2. 数据为数组对象形式
		this.arr2 = [
				{'sid' : 10001, 'name' : 'alex', 'age' : 23 },
				{'sid' : 10002, 'name' : 'kevin', 'age' : 27},
				{'sid' : 10003, 'name' : 'sam', 'age' : 25}
			];
		ng-options = "item.sid as item.name for item in mainCtrl.obj">
	
		ng-options格式： <提交的值> as <显示的值> for 迭代变量 in 数组
	
	3.数据为普通对象形式
		this.obj = {
				'sid' : 10001, 
				'name' : 'alex',
				'age' : 23
			};
		ng-options = "value as key for (key,value) in mainCtrl.obj"
	
		ng-options格式： <提交的值> as <显示的值> for (key,value) in 数组


依赖注入

	注入服务到控制器中。
	angular使用ajax 发送请求，需要使用内置 $http服务。
	所有的内置服务都是 $开头。
	使用依赖注入的语法引入到控制器中，实参注入形参。
	
	var app = angular.module('myapp',[]);
	app.controller('MainCtrl',['$http',function($http){
			$http.get('').then(function(){
				
			})
	}]);

表单验证

	<body ng-app="myapp" ng-controller="MainCtrl as mainCtrl">
	{{ mainCtrl.formObj }}
	<form name="myform">
		<p>
			姓名:<input type="text" name="name" required ng-model="mainCtrl.formObj.name" 
				ng-pattern="/^[\u4e00-\u9fa5]{2,5}$/">
			<span ng-show="myform.name.$dirty && myform.name.$error.required">请填写用户名</span>
			<span ng-show="myform.name.$error.pattern">用户名不合法</span>
		</p>
	
		<p>
			年龄:<input type="number" name="age" required ng-model="mainCtrl.formObj.age" max="60" min="15">
			<span ng-show="myform.age.$dirty && myform.age.$error.required">请填写年龄</span>
			<span ng-show="myform.age.$error.max">最大年龄60</span>
			<span ng-show="myform.age.$error.min">最小年龄15</span>
		</p>
	
	</form>
	
	<script type="text/javascript">
		var app = angular.module('myapp',[]);
		app.controller('MainCtrl',[function(){
				this.formObj={};
		}]);
	
	</script>


​	
|属性|描述|
|:--|:--|
|$dirty|表单有填写记录|
|$valid	|字段内容合法的|
|$invalid|字段内容是非法的|
|$pristine|表单没有填写记录|
|$error|字段是否错误|

### 服务 ###

> service服务

	angular使用service函数可以定义一个服务，服务是一个函数或对象。
	服务是单例对象。惰性加载。
	
	var app = angular.module('模块名',[]);
	//创建服务
	app.service('服务名',[])


​	
	$http 是 AngularJS 应用中最常用的服务。 
		服务向服务器发送请求，应用响应服务器传送过来的数据。
	
	AngularJS $timeout 服务对应了 JS window.setTimeout 函数。
	AngularJS $interval 服务对应了 JS window.setInterval 函数。
	
		var app = angular.module('myApp', []);
		app.controller('myCtrl', function($scope, $timeout) {
		    $scope.myHeader = "Hello World!";
		    $timeout(function () {
		        $scope.myHeader = "How are you today?";
		    }, 2000);
		});

> factory服务

	返回一个对象的函数就是工厂【服务】。
	app.factory();	//定义一个工厂，也是一个服务
	
	//必须返回对象
	app.factory('myService' , [ function(){
			return {
				
			}
		}]);


​	
	和service()函数相比，factory()具有更高的封装性。
	factory()要求只能用暴露的函数来操作。

> 例子：

	<body  ng-app = "myapp"  ng-controller="MainCtrl as mainCtrl">
	
		{{ mainCtrl.getA() }}
		<button type="button" ng-click="mainCtrl.add()">+</button>
	
		<script type="text/javascript">
			
			var app = angular.module('myapp' , []);
	
			app.controller('MainCtrl', ['myService' , function(myService){
				// alert(myService.a);
				this.getA = function(){
					return myService.getA();
				}
	
				this.add = function(){
					//引用工厂暴露的API
					return myService.add();
				}
				
			}]);
	
			//服务
			app.factory('myService' , [ function(){
	
				var a = 10;
				function add(){
					a++;
				}
	
				function getA(){
					return a;
				}
	
				//暴露的API
				return {
					getA : getA,
					add : add
				};
			}]);
	
		</script>
	</body>

> service()和factory()区别

	service()定义的是构造函数，服务名一般首字母大写，里面可以使用this来定义属性、方法，都是静态的属性、方法，使用类名来调用。
	
	factory()定义的是一个工厂，工厂就会返回一个对象【API清单】，且不能使用this 来定义属性、方法，必须使用return来返回，封装性更好。

> constant服务

	定义一个唯一的对象【常量】，使用服务名引用属性、方法。
	constant创建用于存放一些数据或方法以供使用的服务，不会去修改它的内容【固定的】，需要修改内容的，最好使用value去创建服务。
	语法：
		app.constant(nae,{//对象});
	
	app.constant('constantService',{
			'sid' : 10001,
			'user' : {
				'name' : 'alex',
				'age' : 23
			},
			'add' : function(){
				return //TODO;
			}
		});

> value服务

	value创建用于存放一些数据或方法以供使用的服务，value服务存放可能会被修改的内容。
	语法：
		app.value(nae,{//对象});
	
	app.value('valueService',{
			'sid' : 10001,
			'user' : {
				'name' : 'alex',
				'age' : 23
			},
			'add' : function(){
				return //TODO;
			}
		});

> provider()服务

	provider(name,fn)是service()和factory()的底层函数。
		fn: 函数，返回一个对象，该对象必须有$get方法，该方法还必须返回一个对象，该对象才是真实被注入的服务。
	
	语法：
		app.provider('providerService',function(){
				return{
					$get : function(){
						return {
	
						}
					}
				}
			});
	
	provider中第一层函数返回外的属性、方法都是给config()函数【配置】使用的。
	语法：
		app.config(function(形参){//TODO})	//形参命名: provider服务名 + Provider
	
	例子：
		//配置服务,形参命名：provider服务名 + Provider
		app.config(function(providerServiceProvider){
			providerServiceProvider.setA(110);
		});
	
		//provider服务
		app.provider('providerService',function(){
				var a = 10;
				return{
					setA : function(number){
						a = number;
					},
					$get : function(){
						return {
							a : a
						}
					}
				}
			});

> directive()指令

	自定义标签指令。
	定义指令名的时候，不可以使用‘-’，如果有大写字符，标签中使用驼峰命名格式的指令名
	
	例子：
		<body ng-app = "myapp">
	    
			<div my-direct>默认内容</div>
			<my-direct></my-direct>
		
		    <script type="text/javascript">
		    	
		    	var app = angular.module('myapp' , [ ]);
		
		    	app.directive('myDirect' , [function(){
		    		//返回一个指令对象
		    		return {
		    			template :  "<h1>你好</h1>"
		    		}
		    	}]);
		
		    </script>
		</body>

属性：

	name
		表示当前scope的名称，一般声明时使用默认值，不用手动设置此属性。
	priority
		优先级。当有多个directive定义在同一个DOM元素上时，有时需要明确他们的执行顺序。这个属性用于在directive的compile function调用之前进行排序。如果优先级相同，则执行顺序是不确定的（根据经验，优先级高的先执行，相同优先级时按照先绑定后执行）。
	teminal
		最后一组。如果设置为true，则表示当前的priority将会成为最后一组执行的directive，即比此directive的priority更低的directive将不会执行。同优先级依然会执行，但是顺序不确定。
	scope
		true，将为这个directive创建一个新的scope。
		如果在同一个元素中有多个directive需要新的scope的话，它还是只会创建一个scope。
		新的作用域规则不适用于根模版，因为根模版往往会获得一个新的scope。
	{}
		将创建一个新的、独立的scope，此scope与一般的scope的区别在于它不是通过原型继承于父scope的。这对于创建可复用的组件是很有帮助的，可以有效的防止读取或者修改父级scope的数据。这个独立的scope会创建一个拥有一组来源于父scope的本地scope属性hash集合。这些本地scope属性对于模版创建值的别名很有帮助。本地的定义是对其来源的一组本地scope property的hash映射。
	controller
		controller构造函数。controller会在pre-linking步骤之前进行初始化，并允许其他directive通过指定名称的require进行共享。这将允许directive之间相互沟通，增强相互之间的行为。
		controller默认注入了以下本地对象：
			$scope 与当前元素结合的scope
			$element 当前的元素
			$attrs 当前元素的属性对象
			$transclude 一个预先绑定到当前scope的转置linking function
	require
		请求另外的controller，传入当前directive的linking function中。require需要传入一个directive controller的名称。如果找不到这个名称对应的controller，那么将会抛出一个error。
		名称可以加入以下前缀：
			? 不要抛出异常。这将使得这个依赖变为一个可选项
			^ 允许查找父元素的controller
	restrict
		EACM的子集的字符串，它限制了directive为指定的声明方式。
		如果省略的话，directive将仅仅允许通过属性声明
		E 元素名称：
		A 属性名：
		 
		C class名：
		 
		M 注释：
	template
		如果replace为true，则将模版内容替换当前的html元素，并将原来元素的属性、class一并转移；如果replace为false，则将模版元素当作当前元素的子元素处理。
	templateUrl
		与template基本一致，但模版通过指定的url进行加载。因为模版加载是异步的，所有compilation、linking都会暂停，等待加载完毕后再执行。
	replace
		如果设置为true，那么模版将会替换当前元素，而不是作为子元素添加到当前元素中。（为true时，模版必须有一个根节点）
	transclude
		编译元素的内容，使它能够被directive使用。需要在模版中配合ngTransclude使用。transclusion的有点是linking function能够得到一个预先与当前scope绑定的transclusion function。一般地，建立一个widget，创建独立scope，transclusion不是子级的，而是独立scope的兄弟级。这将使得widget拥有私有的状态，transclusion会被绑定到父级scope中。（上面那段话没看懂。但实际实验中，如果通过调用myDirective，而transclude设置为true或者字符串且template中包含的时候，将会将的编译结果插入到sometag的内容中。如果any的内容没有被标签包裹，那么结果sometag中将会多了一个span。如果本来有其他东西包裹的话，将维持原状。但如果transclude设置为’element’的话，any的整体内容会出现在sometag中，且被p包裹）
	true/false 转换这个directive的内容。（这个感觉上，是直接将内容编译后搬入指定地方）
	‘element’ 转换整个元素，包括其他优先级较低的directive。（像将整体内容编译后，当作一个整体（外面再包裹p），插入到指定地方）
	compile
	这里是compile function，将在下面实例详细说明
	link
	这里是link function ，将在下面实例详细讲解。这个属性仅仅是在compile属性没有定义的情况下使用。
	
	$scope：
	scope:默认是false,为true则将作用域为私有

scope 对象中的特殊标识符：

	scope: {}
	
	=	表明HTML属性值是JSON对象，并进行双向绑定
	@	表明HTML属性值是字符串，并进行双向绑定
	&	表明HTML属性值是一个函数
	
	通过属性将值传入组件中
	scope:{
		name: "@"	//将标签中的属性name的值传入到组件中
	}
