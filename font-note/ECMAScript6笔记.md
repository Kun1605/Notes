# ES6语法 #

* [1、ECMAScript 6简介](#1、ECMAScript6简介)
* [2、变量的解构赋值](#2、变量的解构赋值)
* [3、扩展](#3、扩展)
* [4、Set和Map](#4、Set和Map)
* [5、Promise对象](#5、Promise对象)
* [6、async/await函数](#6、async/await函数)
* [7、Class类](#7、Class类)
* [8、Module模块](#8、Module模块)
* [9、Proxy和Reflect](#9、Proxy和Reflect)

<a name="1、ECMAScript6简介"></a>
### 1、ECMAScript 6简介 ###

	ECMAScript 和 JavaScript 的关系是，前者是后者的规格，后者是前者的一种实现（另外的 ECMAScript 方言还有 Jscript 和 ActionScript）。
	日常场合，这两个词是可以互换的。

- [ES6中文文档](http://es6.ruanyifeng.com/#docs/intro)

> Babel 转码器

	Babel 是一个广泛使用的 ES6 转码器，可以将 ES6 代码转为 ES5 代码，从而在现有环境执行。
	这意味着，你可以用 ES6 的方式编写程序，又不用担心现有环境是否支持。
	下面是一个例子。

	// 转码前
	input.map(item => item + 1);
	
	// 转码后
	input.map(function (item) {
	  return item + 1;
	});

	上面的原始代码用了箭头函数，Babel 将其转为普通函数，就能在不支持箭头函数的 JavaScript 环境执行了。

	【注】
	Babel默认只转换新的 JavaScript句法（syntax），而不转换新的API。
	比如Iterator、Generator、Set、Maps、Proxy、Reflect、Symbol、Promise等全局对象，
	以及一些定义在全局对象上的方法（比如Object.assign）都不会转码。
	
	为了转码API，需要使用 babel-polyfill。
	安装：	npm install --save babel-polyfill

	然后，在脚本头部，加入如下一行代码。
	import 'babel-polyfill';
	
	// 或
	
	require('babel-polyfill');


> 声明变量

	var: 声明变量，声明会提升到顶级，作用域即为全局。

	let：声明变量【用法类似var】，但是声明不会提升，作用域是块级,即代码块中有效。
		let不允许在相同作用域内，重复声明同一个变量。

	const: 声明一个只读的常量。
		一旦声明，常量的值就不能改变。
		即一旦声明变量，就必须立即初始化，不能留到以后赋值。

<a name="2、变量的解构赋值"></a>
### 2、变量的解构赋值 ###

	ES6 允许按照一定模式，从数组和对象中提取值，对变量进行赋值，这被称为解构（Destructuring）。
	也称为模式匹配赋值，需要左右两边的参数模式相同才可以。

	解构赋值允许指定默认值，即右边没有指定值的话，左边的变量即使用默认值。

	默认值生效的条件是，对象的属性值严格等于 undefined,null会被认为是一个值。

> 扩展/剩余【rest】模式
	
	语法：...数组
	内部使用 for...of 循环。
	即将剩余的参数都赋值给标记了前缀'...'的变量。
	比如：let [head, ...tail] = [1, 2, 3, 4];

	也可以将标记了前缀'...'的数组的值扩展出来赋值给变量,将伪数组/类似数组转为真正的数组。
	比如：
		let usersList = ['alex','kevin','tom'];
		let users = [...usersList];

> 1、数组的解构赋值
	
	1. let [a, b, c] = [1, 2, 3];
	2. let [foo, [[bar], baz]] = [1, [[2], 3]];
	3. let [ , , third] = ["foo", "bar", "baz"];
	【注】
		只要某种数据结构具有 Iterator 接口，都可以采用数组形式的解构赋值。
		左边变量的赋值是按照数组的索引对应赋值的。

> 2、对象的解构赋值
	
	let { foo, bar } = { foo: "aaa", bar: "bbb" };

	【注】
		对象的属性没有次序，变量必须与属性同名，才能取到正确的值。
		若变量名好属性名不一致，可以使用别名，如 let{f:foo}。

> 3、字符串的解构赋值
	
	1. const [a, b, c, d, e] = 'hello';
	2. let {length : len} = 'hello';
		len // 5

	【注】
		字符串被转换成了一个类似数组的对象。
		类似数组的对象都有一个length属性【比如arguments】，因此还可以对这个属性解构赋值。

> 4、数值的解构赋值  
> 5、函数参数的解构赋值
	
	//其实也是使用数组或者对象对其进行解构
	function add([x, y]){
	  return x + y;
	}
	
	add([1, 2]); // 3

	//使用默认值
	function move({x = 0, y = 0} = {}) {
	  return [x, y];
	}
	
	move({x: 3, y: 8}); // [3, 8]
	move(); // [0, 0]

> 作用

	1. 交换变量的值，不需要使用中间变量。
		let x = 1;
		let y = 2;
		
		[x, y] = [y, x];

	2. 从函数返回多个值
		函数只能返回一个值，如果要返回多个值，只能将它们放在数组或对象里返回。有了解构赋值，取出这些值就非常方便。
		// 返回一个数组
		function example() {
		  return [1, 2, 3];
		}
		let [a, b, c] = example();

	3. 函数参数的定义
		解构赋值可以方便地将一组参数与变量名对应起来。

	4. 提取 JSON 数据
		解构赋值对提取 JSON 对象中的数据，尤其有用。
		let jsonData = {
		  id: 42,
		  status: "OK",
		  data: [867, 5309]
		};
		
		let { id, status, data: number } = jsonData;
		
		console.log(id, status, number);	// 42, "OK", [867, 5309]

	5. 函数参数的默认值

		jQuery.ajax = function (url, {global = true} = {}) {
		  // ... do stuff
		};
		指定参数的默认值，就避免了在函数体内部再写var foo = config.foo || 'default foo';这样的语句。

	6. 遍历 Map 结构

		任何部署了 Iterator 接口的对象，都可以用for...of循环遍历。
		Map 结构原生支持 Iterator 接口，配合变量的解构赋值，获取键名和键值就非常方便。
		
		const map = new Map();
		map.set('first', 'hello');
		map.set('second', 'world');
		
		for (let [key, value] of map) {
		  console.log(key + " is " + value);
		}
		
		// 获取键名
		for (let [key] of map) {
		  // TODO
		}
		
		// 获取键值
		for (let [,value] of map) {
		  // TODO
		}

	7. 输入模块的指定方法

		加载模块时，往往需要指定输入哪些方法。解构赋值使得输入语句非常清晰。
		const { SourceMapConsumer, SourceNode } = require("source-map");

<a name="3、扩展"></a>
### 3、扩展 ###

> 字符串扩展

	repeat()：
		返回一个新字符串，表示将原字符串重复n次。'x'.repeat(3) 
		参数如果是小数，会被取整。
		如果repeat的参数是负数或者Infinity，会报错。

	ES6 又提供了新方法。

	includes()：		返回布尔值，表示是否找到了参数字符串。

	startsWith()：	返回布尔值，表示参数字符串是否在原字符串的头部。

	endsWith()：		返回布尔值，表示参数字符串是否在原字符串的尾部。
	【注】这三个方法都支持第二个参数，表示开始搜索的位置。

	字符串补全长度的功能。
		如果某个字符串不够指定长度，会在头部或尾部补全。

		padStart(param1,param2)：用于头部补全；
		padEnd(param1,param2)：用于尾部补全。

			param1: 用来指定字符串的最小长度;
			param2: 用来补全的字符串。

	模板字符串（template string）

		增强版的字符串，用反引号（`）标识，使用${}当占位符。
		它可以当作普通字符串使用，也可以用来定义多行字符串，或者在字符串中嵌入变量。

		// 普通字符串
		`In JavaScript '\n' is a line-feed.`
		
		// 多行字符串
		`In JavaScript this is
		 not legal.`
		
		console.log(`string text line 1
		string text line 2`);
		
		// 字符串中嵌入变量
		let name = "Bob", time = "today";
		`Hello ${name}, how are you ${time}?`

> 数值的扩展

	ES6 在Number对象上，新提供了两个方法：

		Number.isFinite()：	用来检查一个数值是否为有限的（finite），即不是Infinity。

		Number.isNaN()：		用来检查一个值是否为NaN。
			
	【注】如果参数类型不是数值，Number.isFinite一律返回false。

	Math.trunc()：用于去除一个数的小数部分，返回整数部分。
	Math.sign()：用来判断一个数到底是正数、负数、还是零。

> 函数的扩展

	1. 直接为函数的参数指定默认值;
		function test(x, y = 'world'){
		    console.log('默认值',x,y);
		  }

		test('hello');			// 默认值hello world
		test('hello','hdc');	// 默认值hello hdc

	作用域
		let x='test';
			function test2(x,y=x){
				// x 指的是函数外的变量x
				console.log('作用域',x,y);
			}
		test2('hdc');


	2. ES6 引入 rest 参数（形式为...变量名），用于获取函数的多余参数，这样就不需要使用arguments对象了。
		rest 参数搭配的变量是一个数组，该变量将多余的参数放入数组中。
		
	rest 参数代替 arguments 变量的例子。
	
		// arguments变量的写法
		function sortNumbers() {
		  return Array.prototype.slice.call(arguments).sort();
		}
		
		// rest参数的写法
		const sortNumbers = (...numbers) => numbers.sort();。
	
		arguments对象不是数组，而是一个类似数组的对象。
		所以为了使用数组的方法，必须使用Array.prototype.slice.call先将其转为数组。
		rest 参数就不存在这个问题，它就是一个真正的数组，数组特有的方法都可以使用。

	3.箭头函数 
		ES6 允许使用“箭头”（=>）定义函数,用处是简化 回调函数

		var f = v => v;
		// 等同于
		var f = function (v) {
		  return v;
		};

		如果箭头函数不需要参数或需要多个参数，就使用一个圆括号代表参数部分。
		var f = () => console.log('test');
		// 等同于
		var f = function (v) {
		  	//TODO;
			console.log('test');
		};

		如果箭头函数的代码块部分多于一条语句，就要使用大括号将它们括起来，并且使用return语句返回。
		var sum = (num1, num2) => { //TODO; return num1 + num2; }

		由于大括号被解释为代码块，所以如果箭头函数直接返回一个对象，必须在对象外面加上括号，否则会报错。
		
		// 报错
		let getTempItem = id => { id: id, name: "Temp" };
		
		// 不报错
		let getTempItem = id => ({ id: id, name: "Temp" });

		【注】
			1. 函数体内的this对象，就是定义时所在的对象，而不是使用时所在的对象，即箭头函数中的this对象是固定的。
			2. 不可以当作构造函数，也就是说，不可以使用new命令，否则会抛出一个错误。
			3. 不可以使用 arguments 对象，该对象在函数体内不存在。如果要用，可以用 rest 参数代替。
			4. 不可以使用 yield 命令，因此箭头函数不能用作 Generator 函数。

	4. 双冒号运算符

		并排的两个冒号（::），双冒号左边是一个对象，右边是一个函数。
		用来取代call、apply、bind调用。
		该运算符会自动将左边的对象，作为上下文环境（即this对象），绑定到右边的函数上面。
			foo::bar;
			// 等同于
			bar.bind(foo);
			
			foo::bar(...arguments);
			// 等同于
			bar.apply(foo, arguments);

		如果双冒号左边为空，右边是一个对象的方法，则等于将该方法绑定在该对象上面。

			var method = obj::obj.foo;
			// 等同于
			var method = ::obj.foo;
			
			let log = ::console.log;
			// 等同于
			var log = console.log.bind(console);

	5. 尾调用
		将一个函数作为返回值返回。

> 数组的扩展

	扩展运算符(...),用于扩展数组，提取数组的元素。
	rest 参数的逆运算，将一个数组转为用逗号分隔的参数序列。
	
	function f(x, y, z) {
	  // TODO
	}
	let args = [0, 1, 2];
	f(...args);

	Math.max(...[14, 3, 77])	//77

	将一个数组添加到另一个数组的尾部
		let arr1 = [0, 1, 2];
		let arr2 = [3, 4, 5];
		arr1.push(...arr2);

	复制数组
		const a1 = [1, 2];
		// 写法一
		const a2 = [...a1];
		// 写法二
		const [...a2] = a1;

	合并数组
		[...a1,...a2]

	与解构赋值结合,rest只能放在参数的最后一位
		[a, ...rest] = list

	扩展运算符还可以将字符串转为真正的数组。
		[...'hello']
		// [ "h", "e", "l", "l", "o" ]

	Array.from()
		将带有length属性的对象【拟数组】转为真正的数组

	Array.of()
		用于将一组值，转换为数组。
		Array.of(3, 11, 8) // [3,11,8]

> 对象的扩展

	1. 简介写法
	属性的简洁写法
		let name = 'alex';
		let user = {name} 等效于ES5的 let user = {name:name};

	方法的简洁写法也一样。
		let es5_method={
		    hello: function(){
		      console.log('hello');
		    }
		  };

		let es6_method={
		    hello(){
		      console.log('hello');
		    }
		  };

	省掉了 属性名: 和 : function


	2. 属性表达式
		语法：[变量]
		
		let key= 'name';

		var obj = {[key]:'alex'}	==》 var obj = {name: 'alex'}

	3. 对象方法
	Object.is() 
		用来比较两个值是否严格相等，与严格比较运算符（===）的行为基本一致。
		不同之处只有两个：
			1. +0 不等于 -0；
			2. NaN 等于 自身。

	Object.assign(param1,[..params])
		用于对象的合并，将源对象（source）的所有可枚举属性，复制到目标对象（target）。
		param1：		目标对象；
		..param2：	源对象

		【注】
		如果目标对象与源对象有同名属性，或多个源对象有同名属性，则后面的属性会覆盖前面的属性。
		Object.assign 方法实行的是浅拷贝，而不是深拷贝。
			即如果源对象某个属性的值是对象，那么目标对象拷贝得到的是这个对象的引用。

		Object.assign 可以用来处理数组，但是会把数组视为对象。
			Object.assign([1, 2, 3], [4, 5])	// [4, 5, 3]
			即将数组视为属性名为索引值的对象，进行了覆盖。

	Object.entries(数组)		遍历数组

		let test={k:123,o:456};
		  for(let [key,value] of Object.entries(test)){
		    console.log([key,value]);
		  }

> Iterator（遍历器）

	遍历器（Iterator）就是这样一种机制。
	它是一种接口，为各种不同的数据结构提供统一的访问机制。
	任何数据结构只要部署 Iterator 接口，就可以完成遍历操作（即依次处理该数据结构的所有成员）。

	Iterator 的作用有三个：
		1. 为各种数据结构，提供一个统一的、简便的访问接口；
		2. 使得数据结构的成员能够按某种次序排列；
		3. ES6 创造了一种新的遍历命令for...of循环，Iterator 接口主要供for...of消费。

	Iterator 的遍历过程是这样的。

		1. 创建一个指针对象，指向当前数据结构的起始位置。也就是说，遍历器对象本质上，就是一个指针对象。
		
		2. 第一次调用指针对象的next方法，可以将指针指向数据结构的第一个成员。
		
		3. 第二次调用指针对象的next方法，指针就指向数据结构的第二个成员。
		
		4. 不断调用指针对象的next方法，直到它指向数据结构的结束位置。

	每一次调用next方法，都会返回数据结构的当前成员的信息。
	具体来说，就是返回一个包含 value 和 done 两个属性的对象。
	其中，value属性是当前成员的值，done属性是一个布尔值，表示遍历是否结束。

> Symbol.iterator属性本身是一个函数，就是当前数据结构默认的遍历器生成函数。执行这个函数，就会返回一个遍历器。

	ES6 规定，默认的 Iterator 接口部署在数据结构的Symbol.iterator属性，或者说，一个数据结构只要具有Symbol.iterator属性，就可以认为是“可遍历的”（iterable）。
	Symbol.iterator属性本身是一个函数，就是当前数据结构默认的遍历器生成函数。
	执行这个函数，就会返回一个遍历器。

	let arr = ['a', 'b', 'c'];
	let iter = arr[Symbol.iterator]();
	
	iter.next() // { value: 'a', done: false }
	iter.next() // { value: 'b', done: false }
	iter.next() // { value: 'c', done: false }
	iter.next() // { value: undefined, done: true }

> for...of循环

	ES6 借鉴 C++、Java、C# 和 Python 语言，引入了for...of循环，作为遍历所有数据结构的统一的方法。
	for...of循环内部调用的是数据结构的 Symbol.iterator 方法。
	可以遍历具有Iterator 属性的对象。

	for...of 循环可以代替数组实例的forEach方法。

	JavaScript 原有的for...in循环，只能获得对象的键名，不能直接获取键值。
	ES6 提供for...of循环，允许遍历获得键值。
	对于普通的对象，for...in循环可以遍历键名，for...of循环会报错。

	Set 和 Map 结构也原生具有 Iterator 接口，可以直接使用for...of循环。

		var arr = ['a', 'b', 'c', 'd'];
		
		//读取键名
		for (let a in arr) {
		  console.log(a); // 0 1 2 3
		}
		
		//读取键值
		for (let a of arr) {
		  console.log(a); // a b c d
		}

		for...of默认是读取键值,可以通过 arr.entries/arr.keys 方法读取数组的实例和索引。

	循环比较：
		1. for/i：过程繁琐；
		
		2. forEach()：无法中途跳出 forEach 循环，break命令或return命令都不能奏效；
		
		3. for/in ：只能获得对象的键名，不能直接获取键值；
				1. 不仅遍历数字键名，还会遍历手动添加的其他键，甚至包括原型链上的键。
				2. 数组的键名是数字，但是for...in循环是以字符串作为键名“0”、“1”、“2”等等。
				3. 会返回所有索引属性，包括非数字索引的属性。
				4. for...in 循环主要是为遍历 对象 而设计的，不适用于遍历 数组。
				
		4. for/of：
				1. 不同于forEach方法，它可以与 break、continue和return配合使用。
				2. 提供了遍历所有数据结构的统一操作接口。
				3. 允许遍历获得键名、键值。
				4. 调用遍历器接口，数组的遍历器接口只返回具有数字索引的属性。


<a name="4、Set和Map"></a>
### 4、Set和Map ###

> Set

	类似于数组，但是成员的值都是唯一的，没有重复的值。可以利用 set 来达到去重 的目的。	
	Set 本身是一个构造函数，用来生成 Set 数据结构。

		const s = new Set();
		
		[2, 3, 5, 4, 5, 2, 2].forEach(x => s.add(x));
		
		for (let i of s) {
		  console.log(i);	// 2 3 5 4
		}

		const a = new Set([2,3,4])	//构造并初始化

	操作方法
	
		add(value)：		添加某个值，返回 Set 结构本身。
		size()：			集合的成员数。
		delete(value)：	删除某个值，返回一个布尔值，表示删除是否成功。
		has(value)：		返回一个布尔值，表示该值是否为Set的成员。
		clear()：		清除所有成员，没有返回值。

	遍历方法【Set的遍历顺序就是插入顺序】
	
		keys()：		返回键名的遍历器
		values()：	返回键值的遍历器
		entries()：	返回键值对的遍历器
		forEach()：	使用回调函数遍历每个成员
			parma1: 键值
			parma2: 键名
			parma3: 集合本身
	
		Set 结构的键名就是键值（两者是同一个值）

	扩展运算符和 Set 结构相结合，就可以去除数组的重复成员。
		let arr = [3, 5, 2, 2, 5, 5];
		let unique = [...new Set(arr)];	// [3, 5, 2]

	set 修改成员时，需要遍历再修改。

> Map

	JavaScript 的对象（Object），本质上是键值对的集合（Hash 结构），但是传统上只能用字符串当作 键。
	Map类似于对象，也是键值对的集合，但是“键”的范围不限于字符串，各种类型的值（包括对象）都可以当作键。

	构造函数 const map = new Map();

	方法：
		set(key,value)：	添加某个键值对。
		get(key)		获取key 对应的值
		size()：			集合的成员数。
		delete(value)：	删除某个值，返回一个布尔值，表示删除是否成功。
		has(value)：		返回一个布尔值，表示该值是否为 Map 的成员。
		clear()：		清除所有成员，没有返回值。
		

	遍历方法【Map 的遍历顺序就是插入顺序】

		keys()：		返回键名的遍历器。
		values()：	返回键值的遍历器。
		entries()：	返回所有成员的遍历器。
		forEach()：	遍历 Map 的所有成员。
		
	Map 转为数组

		const myMap = new Map()
		  .set(true, 7)
		  .set({foo: 3}, ['abc']);

		[...myMap]
		// [ [ true, 7 ], [ { foo: 3 }, [ 'abc' ] ] ]

	数组 转为 Map

		将数组传入 Map 构造函数，就可以转为 Map。
		
		new Map([
		  [true, 7],
		  [
			{foo: 3}, 
			['abc']
		  ]
		])；

> 处理数据结构时，优先考虑使用 map和set，而不是 array或 Object

<a name="5、Promise对象"></a>
### 5、Promise对象 ###

> Promise介绍

	Promise 是异步编程的一种解决方案，比传统的解决方案【回调函数和事件】更合理和更强大。
	Promise，简单说就是一个容器，里面保存着某个未来才会结束的事件（通常是一个异步操作）的结果。
	Promise对象代表一个异步操作。
	promise的状态：
			1. Pending  等待中
			2. Resolved	成功
			3. Rejected	失败
			
	状态转换
		Pending ==》Resolved
		Pending ==》Rejected

	一旦状态改变，就不会再变，任何时候都可以得到这个结果。
	有了Promise对象，就可以将异步操作以同步操作的流程表达出来，避免了层层嵌套的回调函数。
	此外，Promise对象提供统一的接口，使得控制异步操作更加容易。

> 基本用法

	ES6 规定，Promise对象是一个构造函数，用来生成Promise实例。

		const promise = new Promise(function(resolve, reject) {
		  // TODO
		
		  if (/* 异步操作成功 */){
		    resolve(value);

		  } else {
		    reject(error);

		  }
		});
	
	resolve 函数的作用：
		将 Promise对象 的状态从“未完成”变为“成功”（即从 pending 变为 resolved）。
		在异步操作成功时调用，并将异步操作的结果，作为参数传递出去，比如传递给then()处理；
		resolve(value/Promise) 的参数除了正常的值以外，还可能是另一个 Promise 实例。

	reject函数的作用：
		将Promise对象的状态从“未完成”变为“失败”（即从 pending 变为 rejected）。
		在异步操作失败时调用，并将异步操作抛出的错误，作为参数传递出去。
		reject(reason)

	Promise实例生成以后，可以用 then() 方法分别指定 resolved 状态和 rejected 状态的回调函数。

	then方法可以接受两个回调函数【成功函数，错误函数】作为参数,第二个函数是可选的。
	then方法 返回的是一个 Promise实例，所以还可以继续使用 then()方法，从而形成链式操作。

		const promise = new Promise(function(resolve, reject) {
		  // TODO
		
		  if (/* 异步操作成功 */){
		    resolve(value);

		  } else {
		    reject(error);

		  }
		});

		// Promise 实例生成
		promise.then(function(value) {
		  // resolve
			console.log(value);

		}, function(error) {
		  // rejected

		});

	then() 的作用：
		当 异步操作 处理完成时，成功则调用resolved 状态的回调函数，失败则调用rejected 状态的回调函数或者使用catch方法。

	catch 方法接收回调函数，用于处理异常信息
		promise
			.then(result => console.log(result))
			.catch(error => console.log(error))

	Promise.all()

		该方法用于将多个 Promise 实例，包装成一个新的 Promise 实例。
		const p = Promise.all([p1, p2, p3]);

		p的状态由p1、p2、p3决定，分成两种情况。

		1. 只有p1、p2、p3的状态都变成fulfilled，p的状态才会变成fulfilled，此时p1、p2、p3的返回值组成一个数组，传递给p的回调函数。

		2. 只要p1、p2、p3之中有一个被rejected，p的状态就变成rejected，此时第一个被reject的实例的返回值，会传递给p的回调函数。

		【注】
			Promise.all([p1, p2, p3]).catch(//TODO);
			如果p1、p2、p3里面没有定义catch，则会调用Promise.all()的catch()
	
	Promise.race()

		该方法同样是将多个 Promise 实例，包装成一个新的 Promise 实例。
		const p = Promise.race([p1, p2, p3]);

		只要p1、p2、p3之中有一个实例率先改变状态，p的状态就跟着改变。
		那个率先改变的 Promise 实例的返回值，就传递给p的回调函数。
	
	Promise.resolve()

		将现有对象转为 Promise 对象。

	Promise.reject()

		Promise.reject(reason)方法也会返回一个新的 Promise 实例，该实例的状态为rejected。

	// 也可以使用 call 来间接调用 resolve()、reject()
	new Promise((resolve,reject)=>{
            $.ajax({
                url:'/get/state',
                data:{
                    issue:issue
                },
                dataType:'json',
                success:function(res){
                    resolve.call(self, res);
                },
                error:function(err){
                    reject.call(err);
                }
            })
        })

> 例子

	let ajax = function(num){

	    return new Promise(function(resolve,reject){
	      if(num/6){
	        resolve();

	      }else{
	          reject('出错了');
	      }
	    })
	  };

	ajax(2).then(function(){
		console.log('success');

	}).catch(function(err){
		console.log('catch',err);

	});

	// success	

	ajax(0).then(function(){
		console.log('success');

	}).catch(function(err){
		console.log('catch',err);

	});

	//catch 出错了


<a name="6、async/await函数"></a>
### 6、async/await函数 ###

	ES2017 标准引入了 async 函数，使得异步操作变得更加方便。
	比 Promise、Generator 函数更方便快捷。

	语法：
		async funtion(){
			await //TODO
			await //TODOO
		}

	async表示函数里有异步操作，await表示紧跟在后面的表达式需要等待结果【异步操作】。

> 基本用法

	async函数返回一个 Promise 对象，可以使用then方法添加回调函数。
	当函数执行的时候，一旦遇到await就会先返回，等到异步操作完成，再接着执行函数体内后面的语句。
	即只有 async 函数内部的异步操作执行完，才会执行then方法指定的回调函数，除非遇到 return语句或者抛出错误。

	async函数完全可以看作多个异步操作，包装成的一个 Promise 对象，而 await命令就是内部then命令。

> async 函数有多种使用形式。
	
	// 函数声明
	async function foo() {}
	
	// 函数表达式
	const foo = async function () {};
	
	// 对象的方法
	let obj = { async foo() {} };
	obj.foo().then(...)
	
	// Class 的方法
	class Storage {
	  constructor() {
	    this.cachePromise = caches.open('avatars');
	  }
	
	  async getAvatar(name) {
	    const cache = await this.cachePromise;
	    return cache.match(`/avatars/${name}.jpg`);
	  }
	}
	
	const storage = new Storage();
	storage.getAvatar('jake').then(…);
	
	// 箭头函数
	const foo = async () => {};

> await命令

	正常情况下，await命令后面是一个 Promise 对象。如果不是，会被转成一个立即resolve的 Promise 对象。

	await命令后面的 Promise 对象如果变为reject状态，则reject的参数会被catch方法的回调函数接收到。

	只要一个await语句后面的 Promise 变为reject，那么整个async函数都会中断执行。

	如果希望一个await操作错误不会影响到后面的运行，可以使用 catch方法处理该await。
		async function f() {
		  await Promise.reject('出错了').catch(e => console.log(e));
		  await Promise.resolve('hello world');
		}

	也可以把await命令放在try...catch代码块中
		try {
		    const val1 = await firstStep();
		    const val2 = await secondStep(val1);
		    const val3 = await thirdStep(val1, val2);
		
		    console.log('Final: ', val3);
		  }
		  catch (err) {
		    console.error(err);
		  }

	【注】
		1. await命令后面的Promise对象，运行结果可能是rejected，所以最好把await命令放在try...catch代码块中。
		2. 多个await命令后面的异步操作，如果不存在继发关系，最好让它们同时触发。
			let foo = await getFoo();
			let bar = await getBar();
			修改为
			let [foo, bar] = await Promise.all([getFoo(), getBar()]);
			getFoo和getBar都是同时触发，这样就会缩短程序的执行时间。

		3. await命令只能用在async函数之中，如果用在普通函数，就会报错。

> for await...of

	作用：
		用于遍历异步的 Iterator 接口。
		部署了 asyncIterable 操作的异步接口，可以直接放入这个循环。
		也可以用于同步遍历器。

	async function f() {
	  for await (const x of createAsyncIterable(['a', 'b'])) {
	    console.log(x);
	  }
	}
	// a
	// b
	createAsyncIterable()返回一个拥有异步遍历器接口的对象，for...of循环自动调用这个对象的异步遍历器的next方法，会得到一个 Promise 对象。
	await用来处理这个 Promise 对象，一旦resolve，就把得到的值（x）传入for...of的循环体。

<a name="7、Class类"></a>
### 7、Class类 ###

> Class 的基本语法

	JavaScript 语言中，生成实例对象的传统方法是通过构造函数。
		function Point(x, y) {
		  this.x = x;
		  this.y = y;
		}
		
		Point.prototype.toString = function () {
		  return '(' + this.x + ', ' + this.y + ')';
		};
		
		var p = new Point(1, 2);

	ES6 提供了更接近传统语言的写法，引入了 Class（类）这个概念，作为对象的模板。
	通过class关键字，可以定义类。

		//定义类
		class Point {
		  constructor(x, y) {	//构造方法
		    this.x = x;
		    this.y = y;
		  }
		
		  toString() {
			//this 关键字则代表实例对象
		    return '(' + this.x + ', ' + this.y + ')';	
		  }
		}

	typeof Point // "function"
	Point === Point.prototype.constructor // true
	类的数据类型就是函数，类本身就指向构造函数。

	【注】
		1. 在类的实例上面调用方法，其实就是调用原型上的方法。
		2. 类和模块的内部，默认就是严格模式。
		3. 类不存在变量提升
	
> 使用

	使用的时候，也是直接对类使用new命令，跟构造函数的用法完全一致。
		var p = new Point();
		p.toString();

> 构造函数 

	constructor方法是类的默认方法，通过new命令生成对象实例时，自动调用该方法。
	一个类必须有constructor方法，如果没有显式定义，一个空的constructor方法会被默认添加。
	
	class Point {
	}
	
	// 等同于
	class Point {
	  constructor() {}
	}

> Class 的取值函数（getter）和存值函数（setter）

	在“类”的内部可以使用 get和set 关键字，对某个属性设置存值函数和取值函数，拦截该属性的存取行为。

	class Parent {
        constructor(name = 'alex') {
            this.name = name;
        }

        get longName() {
            return 'mk' + this.name
        }

        set longName(value) {
            this.name = value;
        }
    }

    let v = new Parent();
    console.log('getter', v.longName);	// getter mkalex
    v.longName = 'hello';
    console.log('setter', v.longName);	// setter mkhello

	
> Class 的静态方法

	类相当于实例的原型，所有在类中定义的方法，都会被实例继承。
	如果在一个方法前，加上 static 关键字，就表示该方法不会被实例继承，而是直接通过类来调用，这就称为 “静态方法”。

	class Parent {
        constructor(name = 'alex') {
            this.name = name;
        }

		// 静态方法
        static tell() {
            console.log('tell');
        }
    }

	// 通过类直接调用
    Parent.tell();

> 静态属性

	class Parent {
        constructor(name = 'alex') {
            this.name = name;
        }

        static tell() {
            console.log('tell');
        }
    }

	// 静态属性
    Parent.type = 'test';

    console.log('静态属性', Parent.type);	// test

	
> 私有方法和私有属性

	将方法移除模块，放到外部函数中。因为模块内部的所有方法都是对外可见的。

	私有属性还在提案。

> Class的继承 -- extends

	Class 可以通过 extends 关键字实现继承，这比 ES5 的通过修改原型链实现继承，要清晰和方便很多。

	class B extends A {
	  constructor() {
	    super();
	  }
	}

	super() 必须放在构造函数的首行，指定子类继承父类的所有属性。
	super(props) 指定子类继承父类的某一个属性

	子类B中的构造函数的 super() 相当于 A.prototype.constructor.call(this)。


	 // 继承传递参数
    class Parent {
        constructor(name = 'alex',age) {
            this.name = name;
            this.age = age;
        }
    }

    class Child extends Parent {
        constructor(name = 'child',age) {
            super();
            this.type = 'child';
            this.age = age;
        }
    }

    console.log('继承传递参数', new Child('hello',22));	//{name: "alex", age: 22, type: "child"}


<a name="8、Module模块"></a>
### 8、Module模块 ###

	ES6 模块不是对象，而是通过export命令显式指定输出的代码，再通过import命令输入。
	import { stat, exists, readFile } from 'fs';	//选择从fs模块中引入的模块方法
			
> 严格模式 

	ES6 的模块自动采用严格模式，不管你有没有在模块头部加上"use strict";。
	
	严格模式主要有以下限制:
	
		变量必须声明后再使用
		函数的参数不能有同名属性，否则报错
		不能使用with语句
		不能对只读属性赋值，否则报错
		不能使用前缀 0 表示八进制数，否则报错
		不能删除不可删除的属性，否则报错
		不能删除变量delete prop，会报错，只能删除属性delete global[prop]
		eval不会在它的外层作用域引入变量
		eval和arguments不能被重新赋值
		arguments不会自动反映函数参数的变化
		不能使用arguments.callee
		不能使用arguments.caller
		禁止this指向全局对象
		不能使用fn.caller和fn.arguments获取函数调用的堆栈
		增加了保留字（比如protected、static和interface）

	顶层的this指向undefined，即不应该在顶层代码使用this。

> export 命令

	模块功能主要由两个命令构成：export 和 import。
	export命令用于规定模块的对外接口;
	import命令用于输入其他模块提供的功能。

	一个模块就是一个独立的文件。该文件内部的所有变量，外部无法获取。
	如果你希望外部能够读取模块内部的某个变量，就必须使用export关键字输出该变量。

	写法：
		export {暴露的模块属性/方法};		//使用大括号指定所要输出的一组属性/方法

	export输出的变量就是本来的名字，但是可以使用as关键字重命名。
	export {
		fn as firstName, lastName, year
	};

> import 命令

	语法： import {} from 'JS文件'
	如果需要导入的 JS文件是 export default 暴露的，可以不加{}
		import xxx from './xxx'

	其他 JS 文件就可以通过 import 命令加载 export 暴露的模块。
	import 必须知道 export时的属性/方法名称，否则无法加载。
	
	import命令要使用as关键字，将输入的变量重命名。
		import { lastName as surname } from './profile.js';

	import后面的from指定模块文件的位置，可以是相对路径，也可以是绝对路径，.js后缀可以省略。
	由于import是静态执行，所以不能使用表达式和变量。

	【注】
	整体加载，使用通配符 *
	import * as profile from './profile.js';

> export default 命令

	export default命令，为模块指定默认输出，只能使用一次。
	其他模块加载该模块时，import命令可以为该匿名函数指定任意名字。
	用户不用知道该暴露的模块对象的名称。
	
	【注】
	export default 和 import 该模块对象时，都不用加{}。
		export default foo;
		import f from 'foo';

> 浏览器加载

	传统两种异步加载的语法：
		<script src="path/to/myModule.js" defer></script>
		<script src="path/to/myModule.js" async></script>
	渲染引擎遇到这一行命令，就会开始下载外部脚本，但不会等它下载和执行，而是直接执行后面的命令。
	
	defer与async的区别是：
		defer要等到整个页面在内存中正常渲染结束（DOM 结构完全生成，以及其他脚本执行完成），才会执行；
		async一旦下载完，渲染引擎就会中断渲染，执行这个脚本以后，再继续渲染。
		即defer是“渲染完再执行”，async是“下载完就执行”。
		另外，如果有多个defer脚本，会按照它们在页面出现的顺序加载，而多个async脚本是不能保证加载顺序的。

	ES6加载规则

		<script type="module" src="./foo.js"></script>

		在网页中插入一个模块foo.js，由于type属性设为 module，所以浏览器知道这是一个 ES6 模块。
		浏览器对于带有 type="module" 的<script>，都是异步加载，不会造成堵塞浏览器。
		即等到整个页面渲染完，再执行模块脚本，等同于打开了<script>标签的defer属性。

> ES6 模块与 CommonJS 模块的差异

	1. CommonJS 模块是运行时加载，ES6 模块是编译时输出接口。
		1. CommonJS 加载的是一个对象（即module.exports属性），该对象只有在脚本运行完才会生成。
			1. 通过 require() 加载
			
		2. 而 ES6 模块不是对象，它的对外接口只是一种静态定义，在代码静态解析阶段就会生成。
			1. 通过 import {x} from './Xxx' 加载，生成一个只读引用，类似软连接。
			2. 等到脚本真正执行时，再根据这个只读引用，到被加载的那个模块里面去取值。
			3. 由于是只读的，所以不能修改指向的对象，但是可以添加属性
				export = 对象/函数；	//返回空
				export.属性名 = 值；
				export.方法名 = 函数；

	2. CommonJS 模块输出的是一个值的拷贝 module.exports，ES6 模块输出的是值的引用 export。
		1. CommonJS模块 一旦输出一个值，模块内部的变化就影响不到这个值。
			1. 该值会被缓存下来，只有使用函数才可以获取内部变动后的该值。
			2. 可以修改对象，也可以添加属性
				module.exports.属性名 = 值;
				module.exports.方法名 = 函数;
				module.exports = 对象/函数;

			例子：
			// lib.js
			var counter = 3;
			function incCounter() {
			  counter++;
			}
			module.exports = {
			  counter: counter,
			  incCounter: incCounter,
			};

			// main.js
			var mod = require('./lib');
			
			console.log(mod.counter);  // 3
			mod.incCounter();
			console.log(mod.counter); // 3 ，得到缓存的值，而不是内部修改后的值

			
			// lib.js
			var counter = 3;
			function incCounter() {
			  counter++;
			}
			module.exports = {
			  get counter() {
			    return counter	//输出的counter属性就是一个取值器函数
			  },
			  incCounter: incCounter,
			};

			// main.js
			var mod = require('./lib');
			
			console.log(mod.counter);  // 3
			mod.incCounter();
			console.log(mod.counter); // 4 通过取值器函数获取内部修改后的值

		2. ES6 模块是动态引用，并且不会缓存值，模块里面的变量绑定其所在的模块。

			// lib.js
			var counter = 3;
			function incCounter() {
			    counter ++;
			}
			
			export {counter, incCounter};

			//main.js
			import {counter, incCounter} from './lib';

			console.log("修改前：" + counter);	//3
			incCounter();
			console.log("修改后：" + counter);	//4，直接获取变量修改后的值
		
		3. 顶层 this 关键字的指向不同
			1. ES6 模块之中，顶层的 this 指向undefined；
			2. CommonJS 模块的顶层 this 指向当前模块，部分顶层变量在ES6中是不存在的，比如 exports,module,require,arguments,__filename,__dirname

<a name="9、Proxy和Reflect"></a>
### 9、Proxy和Reflect ###

> Proxy

	Proxy 可以理解成，在目标对象之前架设一层“拦截”，外界对该对象的访问，都必须先通过这层拦截，因此提供了一种机制，可以对外界的访问进行过滤和改写。

> Proxy 构造函数

	var obj = new Proxy({}, {
	  get(target, key, receiver) {
	    console.log(`getting ${key}!`);
	    return Reflect.get(target, key, receiver);
	  },

	  set(target, key, value, receiver) {
	    console.log(`setting ${key}!`);
	    return Reflect.set(target, key, value, receiver);
	  }
	});


	ES6 原生提供 Proxy 构造函数，用来生成 Proxy 实例。
	var proxy = new Proxy(target, handler);

	target参数表示所要拦截的目标对象；
	handler参数也是一个对象，用来定制拦截行为。
		对于每一个被代理的操作，需要提供一个对应的处理函数，该函数将拦截对应的操作。
		如果handler没有设置任何拦截，那就等同于直接通向原对象，访问proxy就等同于访问target。

	Proxy 对象的所有用法，都是上面这种形式，不同的只是handler参数的写法。

> Proxy 支持的常用拦截操作

	
	get(target, propKey, receiver)：
		target：目标对象，被代理对象；
		propKey：目标对象属性名
		receiver：proxy实例本身【可选】

		拦截对象属性的读取，比如proxy.foo和proxy['foo']。

	set(target, propKey, value, receiver)：
		target：目标对象，被代理对象；
		propKey：目标对象属性名
		value: 目标对象属性值
		receiver：proxy实例本身【可选】

		拦截对象属性的设置，比如proxy.foo = v或proxy['foo'] = v，返回一个布尔值。

	has(target, propKey)：
		拦截 propKey in proxy的操作，返回一个布尔值。

	deleteProperty(target, propKey)：
		拦截 delete proxy[propKey]的操作，返回一个布尔值。

	ownKeys(target)：
		拦截 Object.getOwnPropertyNames(proxy)、Object.getOwnPropertySymbols(proxy)、Object.keys(proxy)、for...in循环，返回一个数组。
		该方法返回目标对象所有自身的属性的属性名，而Object.keys()的返回结果仅包括目标对象自身的可遍历属性。

> Proxy 例子

	let obj = {
	    time: '2017-03-11',
	    name: 'net',
	    _r: 123
	};
	
	let monitor = new Proxy(obj, {
	    // 拦截对象属性的读取
	    get(target, key) {
	        return target[key].replace('2017', '2018')
	    },

	    // 拦截对象设置属性
	    set(target, key, value) {
	        if (key === 'name') {
	            return target[key] = value;
	        } else {
	            return target[key];
	        }
	    },

	    // 拦截key in object操作
	    has(target, key) {
	        if (key === 'name') {
	            return target[key]
	        } else {
	            return false;
	        }
	    },

	    // 拦截delete
	    deleteProperty(target, key) {
	        if (key.indexOf('_') > -1) {
	            delete target[key];
	            return true;
	        } else {
	            return target[key]
	        }
	    },

	    // 拦截Object.keys,Object.getOwnPropertySymbols,Object.getOwnPropertyNames
	    ownKeys(target) {
	        return Object.keys(target).filter(item => item != 'time')
	    }
	});
	
	console.log('get', monitor.time);
	
	monitor.time = '2018';
	monitor.name = 'alex';
	console.log('set', monitor.time);
	console.log(monitor);
	
	console.log('has', 'name' in monitor, 'time' in monitor);
	
	// delete monitor.time;
	// console.log('delete',monitor);
	//
	// delete monitor._r;
	// console.log('delete',monitor);
	console.log('ownKeys', Object.keys(monitor));

> Reflect

	作用：优化某些Object方法的返回结果，让其变得更合理。

> 方法

	Reflect对象的方法与Proxy对象的方法一一对应，只要是Proxy对象的方法，就能在Reflect对象上找到对应的方法。
	
	不需要构造函数，直接以静态方式来引用Reflect 方法。

	Reflect.get(target, name, receiver)
	Reflect.set(target, name, value, receiver)
	Reflect.deleteProperty(target, name)
	Reflect.has(target, name)
	Reflect.ownKeys(target)

> 例子

	let obj = {
        time: '2017-03-11',
        name: 'net',
        _r: 123
    };

    let proxy = new Proxy(obj,{
        // 拦截相应的操作
        get(target,key) {
            return Reflect.get(target,key);
        },

        // 拦截赋值操作
        set(target,key,value) {
            return Reflect.set(target,key,value);
        },

		// 拦截 in 操作
        has(target,key) {
            return Reflect.has(target,key);
        }
    });

    console.log('Reflect get', proxy.name);
    proxy.name = 'alex';
    console.log('Reflect set ', proxy.name);
    console.log(obj);
    console.log('Reflect has', 'name' in proxy);

### ES6 项目构建 ###

- 基础架构 -- 目录构建
- 任务自动化 -- gulb
- 编译工具 -- babel,webpack
	1. Babel 是一个广泛使用的 ES6 转码器，可以将 ES6 代码转为 ES5 代码，从而在现有环境执行。
	2. webpack 通过 webpack-stream 整合 gulb。

- 也可以直接使用 webpack 进行模块化打包处理。
- 使用 Mock 来模拟后端数据发送


	

	