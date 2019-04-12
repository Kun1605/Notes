# Jquery #

* [1、Jquery简介](#1、Jquery简介)
* [2、Jquery使用](#2、Jquery使用)
* [3、文件操作](#3、文件操作)
* [4、插件【重点】](#4、插件【重点】)

<a name="1、Jquery简介"></a>
### 1、Jquery简介 ###

	一个JS函数库，封装简化DOM操作 （CRUN）/Ajax

> 作用

	强大选择器：方便快速查找DOM元素
	隐式遍历：一次操作多个元素
	读写合一：读数据/写数据用的是一个函数
	事件处理；
	链式调用；
	DOM操作（CUN）；
	样式操作

<a name="2、Jquery使用"></a>
### 2、Jquery使用 ###

> 引入 jQuery库
		
	本地引入和CDN远程引入；
	测试版和生产版（压缩版）

	<!-- jquery的压缩库 网页版-->
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script> 
	
	 <!-- jquery的压缩库 本地加载版【相对路径】-->
	<script src="js\jquery-3.2.1.min.js"></script> 
	
	 <!-- jquery的压缩库 本地加载版【绝对路径】-->
	<script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
	
	【注意】myeclipse 中引入js报错：
		处理方法：
			右击 jquery-3.2.1.min.js -->MyEclipse --> 
			1.先点击Exclude From Validation ；
			2.点击Run Validation 即可
		
> 使用 jQuery
		
	使用jQuery 函数：$/jQuery
	使用jQuery 对象：xxx(执行$()得到的)

	jQuery 向外暴露的就是 jQuery 函数，可以直接使用
	当成一般函数使用：$(param)
		param 是function：相当于 window.onload = function (文档加载完成的监听)
		param 是选择器字符串：查找所有匹配的DOM 元素，返回包含所有DOM 元素的jQuery对象
		param 是DOM 元素：将DOM 元素对象包装为 jQuery 对象返回 $(this)
		param 是标签字符串：创建标签DOM 元素对象并包装为 jQuery 对象返回
		
	当成对象使用： $.xxx
		each(obj/arr,function(key,value){})
		trim(str)
		
	jQuery 对象：
		包含所有匹配的n个DOM 元素的伪数组对象。
		执行$()返回的就是 jQuery 对象。
		基本行为：
			size()/length : 包含的 DOM 元素个数
			[index]/get(index)： 得到对应位置的DOM 元素
			each(function(index,domEle){})： 遍历包含的所有DOM 元素
			index()： 得到当前dom元素在所在兄弟元素中的下标
		
		$("div").each(function(index, domEle){
			 	... 
			 })
		$.each("div",function(index, domEle){
			...
		})

> 选择器：
	
	具有特定语法规则（css选择器）的字符串。
	用来查找某个/些 DOM 元素: $(selector)。
	分类：
	  基本：
		#id
		tagName/*		标签名下所有
		.class
		selector1,selector2,selector3   并集选择器
		selector1selector2selector3  	交集
		
	  层次：
		找子孙元素，兄弟元素
		selector>selector1		子元素
		selector selector1		后代元素

	  过滤：
		在原有匹配元素中筛选出其中一些
		:first
		:last
		:eq(index)
		:not(selector)	去除所有与给定选择器匹配的元素
		:even		索引为偶数的
		:odd		索引为奇数的
		:lt
		:gt
		:hidden		匹配所有不可见元素，或者type为hidden的元素
		:visible	匹配所有的可见元素
		[attrName]
		[attrName=value]
		
	  表单：
		:input
		:text		匹配所有的单行文本框
		:checkbox
		:radio
		:checked	被选中的

	$(this)					当前 HTML 元素
	$("p")					所有 <p> 元素
	$("p .intro")			所有 class="intro" 的 <p> 元素
	$(".intro")				所有 class="intro" 的元素
	$("#intro")				id="intro" 的元素
	$("ul li:first")		每个 <ul> 的第一个 <li> 元素
	$("ul>li")  $("ul li)	每个 <ul> 的所有 <li> 元素
	$("[href$='.jpg']")		所有带有以 ".jpg" 结尾的属性值的 href 属性
	$("div#intro .head")	id="intro" 的 <div> 元素中的所有 class="head" 的元素
	:first  				过滤选择器
	$(".searce option:selected");		//获得下拉列表的值

		
> 属性
		
	操作标签的属性，标签体文本
	attr(name) / attr(name,value)	读写操作属性值为 非布尔值的属性
	prop(name) / prop(name,value)	读写操作属性值为 布尔值的属性
	removeAttr(name) / removeProp(name)	删除属性
	addClass(classValue)			添加clas
	removeClass(classValue)			移除指定的class
	val() / val(value)				读写标签的value
	html() / html(htmlString)		读写标签体文本

> 隐式遍历（迭代）

	一次操作多个元素 $('ul>li').click( function(){}	

> javascript:void(0)

	javascript:是表示在触发<a>默认动作时，执行一段JavaScript代码，而 javascript:; 表示什么都不执行，这样点击<a>时就没有任何反应。
	一般让一个超链接点击后不链接到任何地方，而鼠标移上去仍然显示手指形状的图标，就用javascript:void(0)

> jQuery 事件

	$(document).ready(function)		将函数绑定到文档的就绪事件（当文档完成加载时）
	$(selector).click(function)		触发或将函数绑定到被选元素的点击事件
	$(selector).dblclick(function)	触发或将函数绑定到被选元素的双击事件
	$(selector).focus(function)		触发或将函数绑定到被选元素的获得焦点事件
	$(selector).blur(function)		失去焦点事件
	$(selector).mouseover(function)	触发或将函数绑定到被选元素的鼠标悬停事件
	$(selector).change(function)	修改事件
	$(selector).keydown(function)   按键被按下
	$(selector).keypress(function)	与 keydown 事件不同，每插入一个字符，就会发生 keypress 事件
	$(selector).keyup(function)
	$(selector).mousedown(function)
	$(selector).mouseenter(function)
	$(selector).mouseleave(function)
	$(selector).mousemove(function)
	$(selector).mouseover(function)
	$(selector).mouseup(function)	松开鼠标按键
	$(selector).mouseout(function)	当鼠标从元素上移开时
	$("p").slideToggle();			隐藏或显示元素
	$(selector).one(event,data,function)	one() 方法为被选元素附加一个或多个事件处理程序
		event	必需。规定添加到元素的一个或多个事件。由空格分隔多个事件。必须是有效的事件。
		data	可选。规定传递到函数的额外数据。
		function	必需。规定当事件发生时运行的函数。
	
> 事件例子：

	<script src="js\jquery-3.2.1.min.js"></script> 
	
	  <script type="text/javascript">
		$(document).ready(function(){
		  	$("input").blur(function(){ 
		  	alert("hello hdc"); 
		  	});
		  });
	</script>
	  <body>
	    Enter your name: <input type="text" />
	<p>请在上面的输入域中点击，使其获得焦点，然后在输入域外面点击，使其失去焦点。</p>
	  </body>
	  
	  
	  $("#name")，$("input")是jquery对象【类数组对象】
	  
	  显示返回的信息：
		  $("input").val(data);		//修改标签为input的列的值
		  $("p").html(data);		//在标签为p的列显示data数据
		  alert(data);				//浏览器弹窗显示data数据
	
	<script src="js/jquery-3.2.1.min.js"></script> 
	
	  <script type="text/javascript">
		$(document).ready(function(){
		  	/* $("input").blur(function(){ 
		  	alert("hello hdc"); 
		  	}); */
	
		/*获得焦点*/
		/* $("input").focus(function(){
		    $("input").css("background-color","#FFFFCC");
		  }); */
		  
		  /*失去焦点*/
		  /* $("input").blur(function(){
		    $("input").css("background-color","#D6D6FF");
		  }); */
		  
		  	/*  $("#name").blur(function(){ 
		  	alert("姓名是"+$("#name").val()); 
		  	}); 
		  	 */
		  	 
		  	/* 点击id=button1的按键后，id=img的属性就被隐藏了*/
		  	/* $("#button1").click(function(){
		  		 $("#img").hide()
		  	}); */
		  
		  	/* 当id=name的值被修改后，该对象的背景颜色就被修改了*/
		   /* $("#name").change(function(){ 
		  	  $(this).css("background-color","#FFFFCC");
		  	});  */
		  	
		  	/* $("#button2").one("click",function(){
		  		 alert($("#name").val()); 
		  	
		  	}); */
		  	
		  /*带有提示框的删除确认*/
		  	$("#button3").click(function(){
		  		if(confirm("确定要删除数据？")){
		  			$("#result").html("确认删除");
		  		}else{
		  			$("#result").html("取消删除");
		  		}
		  	});
		  	
		  });
		  
	</script>
	  <body>
	    Enter your name: <input type="text" />
	<p>请在上面的输入域中点击，使其获得焦点，然后在输入域外面点击，使其失去焦点。</p>
		<label>姓名：</label><input type="text" id="name" name="username" value="hdc"/><br>
		<label>文本：</label><input type="text" id="content" name="content"/><br>
		<!-- <input type="image" id="img" src="images/none.jpg"/> -->
		<!-- <input type="button" id="button1" value="隐藏图片"> -->
		<input type="button" id="button2" value="增加">
		<input type="button" id="button3" value="删除">
		<p id="result"></p>
	  </body>

> 导航

	window.location.reload();	//刷新  
	window.history.go(1);		//前进  
	window.history.go(-1);		//返回+刷新  
	window.history.forward();  	//前进  
	window.history.back();		//返回  

> 事件委托

	将对子元素的事件委托给父元素进行绑定，避免由于子元素没有生成而导致绑定失败。
	'父元素'.on(events,'子元素',fn)

	当点击鼠标时，隐藏或显示 p 元素【委托】：
	$("div").on("click","button",function(){
	  $("p").slideToggle();
	});

> event对象中 target和currentTarget 属性的区别

	event.target		返回 触发事件的元素
	event.currentTarget	返回 绑定事件的元素

> 定时器：setTimeout和setInterval

	它们都有两个参数，一个是将要执行的代码字符串，还有一个是以毫秒为单位的时间间隔，当过了那个时间段之后就将执行那段代码。
	区别：
		setInterval在执行完一次代码之后，经过了那个固定的时间间隔，它还会自动重复执行代码，
		而setTimeout只执行一次那段代码。
		
		setTimeout("function",time)；//设置一个超时对象，只执行一次,无周期 
		setInterval("function",time)；//设置一个超时对象，周期＝'交互时间'
		停止定时： 
		clearTimeout(对象) 清除已设置的setTimeout对象
		clearInterval(对象) 清除已设置的setInterval对象
		
	可以使用 setInterval 做循环定时器，time为循环间隔时间

> 校验

	Validate验证插件，内置丰富的验证规则，还有灵活的自定义规则接口，HTML、CSS与JS之间的低耦合能让您自由布局和丰富样式，支持input,select,textarea的验证。

	 <div class="form_control">
	 <input class="required" value="315359131@qq.com" type="text" name="email" data-tip="请输入您的邮箱" data-valid="isNonEmpty||isEmail" data-error="email不能为空||邮箱格式不正确">
	</div>
	<div class="form_control">
	 <select class="required" data-valid="isNonEmpty" data-error="省份必填">
	  <option value="">请选择省份</option>
	  <option value="001">001</option>
	  <option value="002">002</option>
	 </select>
	 
	 <div class="form_control">
	 <span class="required" data-valid="isChecked" data-error="性别必选" data-type="radio">
	   <label><input type="radio" name="sex">男</label>
	   <label><input type="radio" name="sex">女</label>
	   <label><input type="radio" name="sex">未知</label>
	 </span>
	</div>
	<div class="form_control">
	 <span class="required" data-valid="isChecked" data-error="标签至少选择一项" data-type="checkbox">
	   <label><input type="checkbox" name="label">红</label>
	   <label><input type="checkbox" name="label">绿</label>
	   <label><input type="checkbox" name="label">蓝</label>
	 </span>
	</div>
	
	<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jquery邮箱验证.aspx.cs" Inherits="练习.jquery邮箱验证" %>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
	  <title></title>
	  <style type="text/css">
	  #aa{ color:Red;}
	  </style>
	   <script src="Jquery1.7.js" type="text/javascript"></script>
	  <script src="jquery.validate.js" type="text/javascript"></script>
	  <script src="messages_cn.js" type="text/javascript"></script>
	  <script type="text/javascript">
	    $(function () {
	 
	 
	    $('#form1').validate({
	      rules: {
	        username: { required: true, minlength: 6, maxlength: 12 },
	        password: { required: true, minlength: 6 },
	        passwordok:{required: true, equalTo: "#password"},
	        index: { required: true, url: true },
	        birthday: { required: true, dateISO: true },
	        bloodpress:{required: true,digits:true},
	        email: { required: true, email: true }
	    },
	    errorshow: function (error, element) {
	      error.appendTo(element.siblings('span'));
	    }
	 
	 })
	    })
	   
	  </script>
	</head>
	<body>
	  <form id="form1" runat="server">
	  <div>
	  <table>
	  <tr><td>用户名：</td><td>
	  <input name="username" type="text" /><span id="aa">*</span></td></tr>
	  <tr><td>密码：</td><td>
	  <input id="password" name="password" type="text" /><span id="aa">*</span></td></tr>
	  <tr><td>确认密码：</td><td>
	  <input id="repassword" name="passwordok" type="text" /><span id="aa">*</span></td></tr>
	   <tr><td>主页：</td><td>
	  <input name="index" type="text" /><span id="aa">*</span></td></tr>
	  <tr><td>生日：</td><td>
	  <input name="birthday" type="text" /><span id="aa">*</span></td></tr>
	  <tr><td>血压：</td><td>
	  <input name="bloodpress" type="text" /><span id="aa">*</span></td></tr>
	 <tr><td>邮箱：</td><td><input name="email" type="text" /><span id="aa">*</span></td></tr>
	 <tr><td></td><td>
	  <input id="Button1" type="button" value="button" /></td></tr>
	</table>
	  </div>
	  </form>
	</body>
	</html>
	</div>

> JS取得绝对路径的实现代码

	function getRealPath(){
	  //获取当前网址，如： http://localhost:8083/myproj/view/my.jsp
	   var curWwwPath=window.document.location.href;

	   //获取主机地址之后的目录，如： myproj/view/my.jsp
	  var pathName=window.document.location.pathname;
	  var pos=curWwwPath.indexOf(pathName);

	  //获取主机地址，如： http://localhost:8083
	  var localhostPaht=curWwwPath.substring(0,pos);

	  //获取带"/"的项目名，如：/myproj
	  var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
	 
	 //得到了 http://localhost:8083/myproj
	  var realPath=localhost+projectName;
	  alert(realPath);
	}
	
> 平滑返回顶部
	
	<style>
		.to_top{
			background:green;
			position:absolute;
			left:10px;
			top:100px;
			width:300px;
			height:800px;
		}
		.to_top span{
			font-size:26px;
			position:absolute;
			bottom:100px;
			left:100px;
			background-attachment:fixed;	/*固定于浏览器某处*/
		}
		.test{
			background:red;
			position:absolute;
			left:10px;
			top:200px;
			width:100px;
			height:100px;
			
		}
		.test span{
			font-size:15px;
			position:absolute;
			top:45px;
			left:10px;
		}
		
	</style>
	
	<body>
	
		<div class="to_top" id="to_top"><span>返回顶部</span></div>
		<div class="test"><span>测试位置</span></div>
	    
	    <script type="text/javascript">
	    	$("#to_top").click(function(){
				//瞬间滚动到顶部
				//$('html,body').scrollTop(0)
				
				//平滑滚动到顶部
				//总距离
				var distance = $('html').scrollTop() + $('body').scrollTop()
				//总时间
				var time = 500
				//间隔时间
				var intervalTime = 50
				var itemDistance = distance/(time/intervalTime)
				
				//使用循环定时器不断滚动
				var intervalId = setInterval(function(){
					
					distance -= itemDistance;
					//到达顶部，停止定时器
					if(distance<=0){
						//修正位置为顶部
						distance = 0;
						clearInterval(intervalId)
						}
						$('html,body').scrollTop(distance)
					},intervalTime)
				
			})
	    </script>

> 例子

	1. 粒子移动插件：
	<body>
		<script zIndex="-1" src="js/canvas-nest.min.js"></script>
	</body>

	2.jquery分页插件：

	<!-- 导航条 --> 
	<div id="J_orderListPages">
	  <c:if test="orderVOs.getSize() gt orderVOs.getPageSize() and not empty orderVOs}">
		<div id="pager" data-pager-href="${ctx}/uc/order/list?type=${type}&search=${search}&page="
			 data-pager-totalPage="${orderVOs.getPages()}" data-pager-nowpage="${orderVOs.getPageNum()}"
			 data-pager-total="${orderVOs.getTotal()}">
		</div>
	  </c:if>
	</div>
	
	<!-- 分页js --> 
	<script src="${ctxsta}/common/pager/jquery.pager.js"></script>
	<script type="text/javascript">
		var pagecount = $('#pager').attr('data-pager-totalPage'); // 总页面数
		var nowpage = $('#pager').attr('data-pager-nowpage'); // 当前页数
		var href = $('#pager').attr('data-pager-href'); // 链接地址
		$(document).ready(function() {
			$("#pager").pager({
				pagenumber : nowpage,
				pagecount : pagecount,
				buttonClickCallback : PageClick
			});
		});
		PageClick = function(number) {
			$("#pager").pager({
				pagenumber : number,
				pagecount : pagecount,
				buttonClickCallback : PageClick
			});
			window.location.href = href + number;
	
	}
	</script>

<a name="3、文件操作"></a>
### 3、文件操作 ###

> 上传文件：
  
	1、XMLHttpRequest方式
  
	//上传文件
	function uploadFile(){
		var fileObj = $("#add_photoFile")[0].files[0];	// 获取文件对象【dom对象】,单个文件
		var filePath = "static/upload/";		// 上传文件的后台地址
		
		// FormData 对象
		var form = new FormData();
		form.append("author","hdc");	//文件参数,可以增加表单数据
		form.append("file",fileObj);	//文件对象
		
		//XMLHttpRequest 对象
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange=state_Change;
		xhr.open("post", "upload", true);
		xhr.send(form);
		
		function state_Change(){
			if(xhr.readyState==4){
				//4=="loaded"
				if(xhr.status==200){
					console.log("上传成功！");
				}else{
					console.log("上传失败！");
				}
			}
		}
		//显示图片
		$("#userAddModal img").show();
		$("#userAddModal img").attr("src",filePath+result.extend.newFileName);
		
	}
	
	  注释：onreadystatechange 是一个事件句柄。它的值 (state_Change) 是一个函数的名称，当 XMLHttpRequest 对象的状态发生改变时，会触发此函数。
	  状态从 0 (uninitialized) 到 4 (complete) 进行变化。仅在状态为 4 时，我们才执行代码。
		为什么使用 Async=true ？
		我们的实例在 open() 的第三个参数中使用了 "true"。
		该参数规定请求是否异步处理。
		True 表示脚本会在 send() 方法之后继续执行，而不等待来自服务器的响应。
		onreadystatechange 事件使代码复杂化了。
		但是这是在没有得到服务器响应的情况下，防止代码停止的最安全的方法。
		通过把该参数设置为 "false"，可以省去额外的 onreadystatechange 代码。
		如果在请求失败时是否执行其余的代码无关紧要，那么可以使用这个参数。
	  
	  2、ajax 方式
	  
	  function uploadFile(){
		// FormData 对象
		var form = new FormData();
		var name = $("#add_photoFile").val();
		var fileObj = $("#add_photoFile")[0].files[0];
		form.append("file",fileObj);
		form.append("name",name);
		
		$.ajax({
			url:"upload",
			type:"POST",
			data:form,
			processData:false,		//告诉jQuery 不要去处理发送的数据
			contentType:false,		//告诉jQuery 不要去设置 Content-Type请求头
			beforeSend:function(){
				console.log("正在进行上传，请稍后");
			},
			success:function(result){
				if(result.code===200){
					console.log(result.extend.uploadMsg);
					//显示图片
					$("#userAddModal img").show();
					$("#userAddModal img").attr("src",filePath+result.extend.newFileName);
				}else{
					console.log("失败");
				}
			},
			error:function(result){
				console.log("上传失败");
			}
		});
	}

> 图片上传前预览
	
	创建FileReader对象并调用其方法：
	
	1.检测浏览器对FileReader的支持
	
		if(window.FileReader) {  
			var fr = new FileReader();  
			// add your code here  
		}  
		else {  
			alert("Not supported by your browser!");  
		}  
	
	
	2. 调用FileReader对象的方法
		FileReader 的实例拥有 4 个方法，其中 3 个用以读取文件，另一个用来中断读取。
		下面的表格列出了这些方法以及他们的参数和功能，需要注意的是 ，无论读取成功或失败，方法并不会返回读取结果，这一结果存储在 result属性中。

|方法名|参数|描述|
|:--|:--|:--|
|abort|	none|中断读取|
|readAsBinaryString|file|将文件读取为二进制码|
|readAsDataURL|file|将文件读取为 DataURL|
|readAsText	|file, [encoding]|将文件读取为文本|

	readAsText：该方法有两个参数，其中第二个参数是文本的编码方式，默认值为 UTF-8。
	这个方法非常容易理解，将文件以文本方式读取，读取的结果即是这个文本文件中的内容。
	readAsBinaryString：该方法将文件读取为二进制字符串，通常我们将它传送到后端，后端可以通过这段字符串存储文件。
	readAsDataURL：这是例子程序中用到的方法，该方法将文件读取为一段以 data: 开头的字符串，这段字符串的实质就是 Data URL，Data URL是一种将小文件直接嵌入文档的方案。这里的小文件通常是指图像与 html 等格式的文件。

	3. 处理事件
	FileReader 包含了一套完整的事件模型，用于捕获读取文件时的状态，下面这个表格归纳了这些事件。
	
	事件			描述
	onabort		中断时触发
	onerror		出错时触发
	onload		文件读取成功完成时触发
	onloadend	读取完成触发，无论成功或失败
	onloadstart	读取开始时触发
	onprogress	读取中

	文件一旦开始读取，无论成功或失败，实例的 result 属性都会被填充。
	如果读取失败，则 result 的值为 null ，否则即是读取的结果，绝大多数的程序都会在成功读取文件的时候，抓取这个值。

	fr.onload = function(e) {  
		//this 指的是实例
	    this.result;  
	};  
	fr.onload = function(e) {  
	    e.target.result;
	};  


> 图片上传预览

	function imgPreview(fileDom){
		//判断是否支持FileReader
		if(window.FileReader){
			var reader = new FileReader();
			//获取文件
			var file = fileDom.files[0];
			var imageType = /^image\//;
			
			//判断是否是图片
			if(!imageType.test(file.type)){
				alert("请选择图片");
				return false;
			}
			
			//将文件读取为 DataURL
			reader.readAsDataURL(file);
			
			//文件读取成功完成时触发
			reader.onload = function(e){
				
				//图片路径设置为读取的图片,由于display默认是none【不会显示】
				$("#showImg").attr("src",this.result).css("display","block");
				//在div中插入img 标签
				//$("#showImg").html('<img src="'+this.result+'"/>');
	
			};
		}else{
			alert("您的设备不支持图片预览功能，如需该功能请升级您的设备！");
		}
		
	}

	$("#add_photoFile").change(function(){
		imgPreview(this);
	});

> JSP

	<div class="form-group" >
	<label for="photo" class="col-sm-2 control-label">证件照:</label>
	<div class="form-group">
	   <label for="photoInputFile"></label>
	   <input type="file" id="add_photoFile" name="idpicpath">
	</div>
	</div>
	<div class="form-group" >
		<img id="showImg" alt="" />
	</div>
		
	【备注】
	//获取文件
	var file = $("#add_photoFile".files[0]);
	console.log(file);
	/*
	File {
		lastModified:1499326165461
		lastModifiedDate:Thu Jul 06 2017 15:29:25 GMT+0800 (中国标准时间) {}
		name:"1.jpg"
		size:6133
		type:"image/jpeg"
		}
	*/

<a name="4、插件【重点】"></a>
### 4、插件【重点】 ###

插件分类

	1. 封装对象方法的插件【原型扩展】
		大部分使用，操作原型,将功能挂载在jquery的原型上，对jquery框架侵入性较小。
		比如：parent()、append()等dom操作方法。

	2. 封装全局函数的插件【静态扩展】
		将功能挂载在jquery 类上面，是一个静态方法。
		比如： $.trim()/$.now()

	3. 选择器插件
		帮助选择页面元素

插件命名

	插件文件名：jquery.插件名.js 、jquery.插件名.min.js
	插件方法名：插件名

插件中的冲突

	当存在多个库的时候，由于其他库也使用变量 $，为了避免jquery 不会和其他库的$ 对象发生冲突，jquery会将变量$的控制权让渡给第一个实现它的那个库，此时就只能使用jQuery变量访问jQuery对象。

	让渡【让出变量$】：
		jQuery.noConflict();

		// 使用 jQuery
		jQuery("div p").hide();

		// 使用其他库的 $()
		$("content").style.display = 'none';

	深度让渡时，将全局变量$和jQuery的控制器都让出，只能通过将 jQuery 移到一个新的命名空间，然后通过新的命名空间去调用jQuery函数。
	
	深度让渡【让出变量$和jQuery】：
		//完全将 jQuery 移到一个新的命名空间。
		var a = jQuery.noConflict(true);

		// 使用新的命名空间
		a("div p").hide();

		// 使用其他库的 $()
		$("content").style.display = 'none';

插件中的关键字this

	由于this 的指向会发生变化，所以进入插件后，首先将this【指向对象本身】 存起来，以便后面使用对象本身，避免由于变化后无法调用对象本身。
	that = this;	//保存对象本身

确保 $ 永远指向 jQuery

	由于可能让 $ 让渡，为了能继续使用 $,可以将jQuery作为实参传入函数中的形参$ 

	(function($){
		...
	})(jQuery);

正确使用分号【；】

	避免在(function(){})()前输入不加分号的代码，jQuery会将该代码识别为该函数名,从而发生错误。
	显示的在前面添加结束符【；】
	;(function($){
		...
	})(jQuery);

尽可能返回jQuery 对象

	为了实现链式调用，尽可能返回 jQuery 对象,这样就可以继续调用jQuery 对象的其他API。
	$('div').css('').css('');
	
	that = this;

	在函数中 return that; //jQuery对象本身

	//index.html
	$("#btn").color('yellow').css('background','red');

插件的固定写法【闭包形式】
	
	//写法一
	;(function($){
		var that;		//保存对象本身

		function 插件名(){
			that = this;
			//实现插件的代码
			return that;
			
		}

		//将插件挂载在jQuery上
		jQuery.prototype.插件名=插件名;

	})(jQuery)

	//写法二
	;(function($){
		var that;		//保存对象本身

		$.fn.插件名 = function(){
			that = this;
			//实现插件的代码
			return that;
		}

	})(jQuery)

	//写法三
	;(function($){
		var that;		//保存对象本身

		$.fn.extend(
			插件名：function(){
					that = this;
					//实现插件的代码
					return that;
				}，
			插件名：function(){
					that = this;
					//实现插件的代码
					return that;
				}
		)

	})(jQuery)

	【注】
	jQuery === $
	jQuery.fn === jQuery.prototype
	jQuery.prototype === jQuery.fn === $.fn === $.prototype

例子：

	;(function($){
		var that;		//保存对象本身
	
		$.fn.color = function(a){
				that = this;
				$(that).css('color',a);
				return that;
			}
	
	})(jQuery)

	;(function($){
		var that;		

		jQuery.fn.extend({
		  color: function(config) {
		  	that = this;
		  	$(that).css('color',config);
		    return that;
		  },
		  width: function(config) {
		  	that = this;
		    $(that).css('width',config);
		    return that;
		  }
		});
	
	})(jQuery)


为了避免多个参数时输入顺序出错，使用对象形式配置参数
	
	//样式插件
	;(function($){
		var that;		//保存对象本身
	
		$.fn.color = function(config){
			that = this;
			$(that).css('color',config.color);
			$(that).css('width',config.width);
			$(that).css('height',config.height);
			return that;
		}
	
	})(jQuery)

	//index.html
	$("#btn").color({color:'red',width:'300px'}).css('margin-top','300px');

配置默认值

	;(function($){
		var that;		//保存对象本身
	
		$.fn.color = function(config){
			that = this;
			//设置默认值
			var def = {width: '200px',height: '200px',color: 'blue'}
	
			//将默认值对象和用户传参对象进行合并生成最终的设置对象
			var setting = $.extend({},def,config);
	
			$(that).css('color',setting.color);
			$(that).css('width',setting.width);
			$(that).css('height',setting.height);
			return that;
		}
	
	})(jQuery)

命名空间

	当插件中有多个方法时，为了避免和其他插件的同名方法产生冲突，统一使用插件命名空间来动态引用插件中的方法。

	;(function($){
		var that;		//保存对象本身
	
		var obj = {
			"init":function(){
				console.log("init");
			},
			"show":function(){
				console.log("show");
			},
			"hide":function(){
				console.log("hide");
			},
		}
	
		$.fn.show = function(config){
			that = this;
			obj[config.fn]();	//动态调用插件的方法
		}
	
	})(jQuery)

	//index.html 通过show这个命名空间调用自己的方法
	$("#btn").show({fn:'show'});
	$("#btn").show({fn:'init'});


### jQuery 事件 ###

	1. 事件四要素
		事件源、事件类型、事件的处理函数、事件对象

	2. 事件的操作
		2.1. 绑定事件
			// jQuery绑定事件
			$(事件源).on('事件类型'，事件处理函数(事件对象)){
					...
				});
			
				$('#id').on('click',function(){
						...
				});
				
				
			// 原生绑定事件
			事件源.on+事件类型 = 事件处理函数(事件对象){
					...
				};

				id.onclick = function(){...}

			事件源.addEventListener('事件类型'，事件处理函数(事件对象)){
					...
				});

				id.addEventListener('click',function(){
						...
				});

		2.2. 解除绑定
			//jQuery
			$(事件源).off('事件类型')；

				$('#id').off('click');

			//原生方法
			事件源.on+事件类型 = null;

				id.onclick = null;

	3. 事件的命名空间

		由于可以给同一个事件源绑定多个相同的事件，为了区分每一个事件，可以使用命名空间。
		语法：
			事件类型[.命名空间]

		$('事件源').on('事件类型.命名空间',function(){
				...
			});

	4. 事件委派/委托
	
		正常绑定事件必须是同步加载页面时就已有的元素才可以绑定成功，但有些元素是有用户交互产生的，无法正常绑定，可以使用事件委托的方式绑定。
		即将时间绑定在同步加载时就存在的父元素上，再通过事件触发冒泡机制，点击子元素时，父元素也会被点击触发事件。
		再利用时间对象来反查时间源，给时间源做相应操作。

		作用：
			事件委托可以给用户交互产生的新元素绑定事件。

		写法：
			//jQuery 方式
			$(父元素).on('事件名称','子元素',function(){...})

			比如：
			$('div').on('click','span',function(){...})

			//原生方法
			父元素.onclick = function(事件对象){
				// 通过事件对象反查获取事件源【子元素】,在获取的事件源上进行事件操作
				事件对象.target;		
			}
			
			比如：
			div.onclick = function(Events){
				Events.target.css('color','red');
			}



		


	

		

	