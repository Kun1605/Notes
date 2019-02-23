# Ajax #


<a name="1、Ajax简介"></a>
### 1、Ajax简介 ###

- Ajax 是 Asynchronous java script and XML 的缩写。
- 浏览器和服务器进行交互通信，而不用刷新当前页面的技术。
- Ajax由 HTML、javascript技术、DHTML(动态HTML) 和 DOM(文档对象模型) 组成。
- Ajax使用XMLHttpRequest对象获得和显示来自服务器的信息.
	
> Ajax 应用程序所用到的基本技术： 

	1. HTML 用于建立 Web 表单并确定应用程序其他部分使用的字段。 
	2. java script 代码是运行 Ajax 应用程序的核心代码，帮助改进与服务器应用程序的通信。
	3. DHTML 或 Dynamic HTML，用于动态更新表单。我们将使用 div、span 和其他动态 HTML 元素来标记HTML。
	4. 文档对象模型 DOM 用于（通过 java script 代码）处理 HTML 结构和（某些情况下）服务器返回的 XML。
	
<a name="2、XMLHttpRequest"></a>
### 2、XMLHttpRequest ###	

> XMLHttpRequest 对象的生成：

	var request=new XMLHttpRequest();
	
> XMLHttpRequest发送请求：

	1. open(method,url,async) 
		method,请求的方式(get/post),async【同步/异步】true为同步，false为异步,默认是true
	2. request.send(string)
		请求的参数，method为get时，string为空，method为post时，就需要加上String
		
	request.open("GET","get.php",true);
	request.send();
	
	request.open("POST","post.php",true);
	request.send("name=kevin");
	
	var request=new XMLHttpRequest();
	request.open("POST","post.php",true);
	//添加请求头的编码方式
	request.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	request.send("name=kevin");
	
> XMLHttpRequest取得响应

	1. responseText: 获得字符串形式的响应数据
	2. responseXML: 获得XML形式的响应数据【较少用】
	3. status和statusText: 以数字和文本形式返回HTTP状态码
	4. getAllResponseHeader()：获得所有的响应报头
	5. getResponseHeader()：查询响应中的某个字段的值
	
> readyState属性：表示服务器的响应状态，

	有5中状态值：
		0：表示请求未初始化，open还没有调用
		1：表示服务器连接已建立，open已经调用
		2：表示请求已接收，即接收到头信息了
		3：表示请求处理中，即接收到响应主体了
		4：表示请求已完成，且响应已就绪，即响应完成了
	
	即监听readyState属性的值就可以知道服务器的响应状态。
	onreadystatechange //事件处理函数 ，有服务器触发，而不是用户
	
	request.onreadystatechange=function(){
		if(request.readyState==4&&request.status==200){
			//响应成功
			}
	}

> 使用XMLHttpRequest对象实现Ajax 【了解即可】

	//1.创建一个XMLHttpRequest对象
	var request=new XMLHttpRequest();
	//2.准备发射请求的数据：url
	var url = this.href;
	var method="GET";
	
	//3.调用XMLHttpRequest对象的open方法
	request.open(method, url);
	
	//4.调用XMLHttpRequest对象的send方法
	request.send();

	//5.为XMLHttpRequest对象添加 onreadystatechange 响应函数
	request.onreadystatechange= function(){
		//6.判断响应是否完成：XMLHttpRequest 对象的readyState属性值为4则完成
		if(request.readyState==4){
			//7.再判断响应是否可用：XMLHttpRequest对象的status属性值为200
			if(request.status==200){
				
	  		//8.打印响应结果：responseText
				alert(request.responseText)
				document.getElementById("searchResult").innerHTML=request.responseText;
			}
		}
	} 		 		 

	
> Ajax 传输数据的3中方式：
	1. XML ：笨重，解析困难，但XML是通用的数据交换格式
	2. HTML: 不需要解析就可以直接放到文档中，但传输的数据不是很方便，且HTML代码需要拼装完成
	3. JSON： 小巧，有面向对象的特征，且有很多第三方的jar包可以把Java对象或集合转为JSON字符串
	
<a name="3、使用jquery完成Ajax操作"></a>
### 使用jquery完成Ajax操作 ###

	1. load 方法：可以用于HTML文档的元素节点，把结果直接加为对应节点的子元素。
		通常load 方法加载后的数据是一个 HTML 片段。 返回值:jQuery
		
		var $obj=...
		var url=...
		var args={key:value,...};
		$obj.load(url,args);

	2. $.get,$post,$getJSON  返回值:XMLHttpRequest
		
		1.基本使用：
			url: Ajax 请求的目标url
			args: 传递的参数： JSON格式
			data: Ajax响应成功后的数据。可能是XML,JSON,HTML
			$.get(url,args,function(date){});
			
		2.请求JSON数据
			$.get(url,args,function(date){}，"JSON");
			或者
			$.post(url,args,function(date){}，"JSON");
			或者
			$.getJSON(url,args,function(date){});
	
> jquery中使用ajax的方法：

	1. load(url, [data], [callback])		载入远程 HTML 文件代码并插入至 DOM 中，返回值:jQuery
	2. jQuery.get(url, [data], [callback], [type]) 	通过远程 HTTP GET 请求载入信息，返回值:XMLHttpRequest
	3. jQuery.post(url, [data], [callback], [type])	通过远程 HTTP POST 请求载入信息，返回值:XMLHttpRequest
	4. jQuery.getJSON(url, [data], [callback])
	
	callback 载入成功时回调函数。
	
> 例子：

	<script src="js\jquery-3.2.1.min.js"></script> 
	<script type="text/javascript">

	/*  $(function(){
		$("a").click(function(){
			//可以有选择性的将结果插入节点中，但URL和选择之间要有空格
			//只插入 h3 节点中的 a元素到HTML 节点中
			var url=this.href + " h3 a";  
			//取消缓存
			//json格式
			var args={"time":new Date()};
			
			//任何一个HTML 节点都可以使用load加载ajax，结果将直接插入HTML 节点中
			$("#Result").load(url,args);
			
			return false;
		});
	}); */
	 
	 //args:JSON格式
	 //function(data): 回调函数：当响应结束时，回调函数被触发，响应结果在data中
	 /* $(function(){
	$("a").click(function(){
		var url=this.href;
		 var objectVal=$("input").val();
		 var args={name:objectVal,time:new Date()};
		 $.get(
		 	url,
		 	args,
		 	function(data){
		 		$("input").val(data);
		 		$("p").html(data);
		 		alert(data);
		 	}
		 );
		 
		 return false;
		});
	});  */
  	
	 /* $(function(){
		$("a").click(function(){
		var url=this.href;
		 var objectVal=$("#name").val();
		 var args={name:objectVal,time:new Date()};
		 $.post(
		 	url,
		 	args,
		 	function(data){
		 		$("p").html(data);
		 	}
		 );
		 
		 return false;
		});
	});  */
	
	/* $(function(){
		$("a").click(function(){
			var url=this.href;
			var objVal=$("#name").val();
			var args={name:objVal,time:new Date()};
			$.get(  			
				url,
				args,
				function(data){
					$("p").html(data);
				},
				"JSON"
			);
			
			return false;
		});
		
	}); */
	
	/* 	$(function(){
			$("a").click(function(){
				var url=this.href;
				var args={time:new Date()};
				$.get(  			
					url,
					args,
					function(data){
						//由于是XML格式的，所有先转为jquery格式，再提取数据
						var name=$(data).find("name").text();
						var age=$(data).find("age").text();
						var email=$(data).find("email").text();
						
						$("#Result").append("name="+name+"<br>")
									.append(" age="+age+"<br>")
									.append(" email="+email);
					}
				);
				
				return false;
			});
		}); */
		
		//通过 HTTP GET 请求载入 JSON 数据
		/* 	$(function(){
			$("a").click(function(){
				var url=this.href;
				var args={time:new Date()};
				$.getJSON(  			
					url,
					args,
					function(data){
						//由于是JSON格式的，可以直接提取数据
						var name=data.person[1].name;
						var age=data.person[1].age;
						var email=data.person[1].email;
						
						$("#Result").append("name="+name+"<br>")
									.append(" age="+age+"<br>")
									.append(" email="+email); 
					}
				);
				
				return false;
			});
		});
		 */
	  	 
		 //返回JSON格式的数据
		$(function(){
			$("a").click(function(){
				var url=this.href;
				var args={time:new Date()};
				$.post(  			
					url,
					args,
					function(data){
						//由于是JSON格式的，可以直接提取数据
						var name=data.person[1].name;
						var age=data.person[1].age;
						var email=data.person[1].email;
						
						$("#Result").append("name="+name+"<br>")
									.append(" age="+age+"<br>")
									.append(" email="+email); 
					},
					"JSON"
				);
				
				return false;
			});
		});
	  	
	</script>

	</head>
	
	<body>
		<h1>测试</h1>
		 <a href="ajax.js" >AjaxJSON</a><br><br>
		 <a href="index.html" >AjaxHTML</a><br><br>
		 <a href="test1.xml" >AjaxXML</a><br><br>
		<p id="Result"></p>
		<input type="hidden" id="name" name="name" value="kevin"/>
	</body>
	
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#delete").click(function(){
			
			    var url = this.href;
			    if(confirm("你确定要删除这条数据吗？")){		
					//确定
				    $.get(
				    	url,
				    	function(data){
				    		//刷新当前页面
				    		window.location.reload();
				    	}
				    );
			    }
				else{
					//取消
				}
				return false;
			});
		});
	</script>
	
	<input type="button" id="button2" value="删除">
	<a href="note.txt">测试</a>
	<p id="test"></p>
		

> 代码就可以修改为：  
> Ajax原生写法：

	request.onreadystatechange = function(){
		if(request.readyState==4){
			if(request.status==200){
				//请求成功
				//将结果返回页面
				var data = JSON.psrse(responseText);
				if(data.success){
				document.getElementById("searchResult").innerHTML=data.msg;
				}
				else{
				document.getElementById("searchResult").innerHTML="出现错误"+data.msg;
				}
			}
			else{
				//弹出页面错误窗口
				alter("发生错误:"+request.status);
			}
		}

		
	<script>
	
	document.getElementById("search").onclick=function(){
		//发送Ajax查询请求并处理
		var request=new XMLHttpRequest();
		request.open("GET","#?number="+ document.getElementById("keyword").value);
		request.send();
		
		//监听服务器响应状态
		request.onreadystatechange = function(){
			if(request.readyState==4){
				if(request.status==200){
					//请求成功
					//将结果返回页面
					document.getElementById("searchResult").innerHTML=request.responseText;
				}
				else{
					//弹出页面错误窗口
					alter("发生错误:"+request.status);
				}
			}
		}
	}
	
	document.getElementById("save").onclick=function(){
		//发送Ajax查询请求并处理
		var request=new XMLHttpRequest();
		request.open("POST","#");
		var data="name" + document.getElementById("staffName").value
			+"&number" + document.getElementById("staffNumber").value
			+"&sex" + document.getElementById("staffSex").value
			+"&job" + document.getElementById("staffJob").value;
		request.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		request.send(data);
		
		//监听服务器响应状态
		request.onreadystatechange = function(){
			if(request.readyState===4){
				if(request.status===200){
					//请求成功
					//将结果返回页面
					document.getElementById("searchResult").innerHTML=request.responseText;
				}
				else{
					//弹出页面错误窗口
					alter("发生错误:"+request.status);
				}
			}
		}
	}
	</script>

> jquery+Ajax验证用户的方法：

	<!-- 
  	1. 导入jquery库
  	2. 获得 name="username" 的节点：username
  	3. 为username 添加 change 响应函数
	  	3.1 获得username 的value 属性值，取出前后空格且不为空
	  	3.2 发送ajax 请求校验 username 是否可用
	  	3.3 在服务端直接返回一个HTML 的片段
	  	3.4 在客户端浏览器把器直接添加到 id="message"的HTML 中。
   -->
   
	<script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script> 
	<script type="text/javascript">
		$(function(){
			$("input[name='username']").change(function(){
				var name_val= $(this).val();
				name_val = $.trim(name_val);
				
				if(name_val!=""){
					var url = "${pageContext.request.contextPath}/ValidateUserServlet";
					var args = {"username":name_val,time:new Date()};
					
					$.post(
						url,args,function(data){
							$("#message").html(data);
						}
					);
				}
			});
		});
	</script>
	
	</head>
	<body>
    	<form action="?" method="post">
    		username:<input type="text" name="username"/><br><br>
    		<input type="submit" value="提交"/><br>
    		<p id="message"></p>
    	</form>
	</body>

	//servlet类
	//ValidateUserServlet.java
	
	List<String> usernames=Arrays.asList("kevin","alex","ken");
		String name=request.getParameter("username");
		String result=null;
		
		if(usernames.contains(name)){
			result = "<font color='red'>该用户已存在</font>";
		}
		else{
			result = "<font color='green'>该用户可用</font>";
		}
		
		response.setContentType("text/html");
		response.getWriter().print(result);
		

	window.location.reload()	刷新当前页面. 
	parent.location.reload()	刷新父亲对象（用于框架） 
	opener.location.reload()	刷新父窗口对象（用于单开窗口） 
	top.location.reload()		刷新最顶端对象（用于多开窗口）
