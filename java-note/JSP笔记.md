# JSP #

* [1、JSP简介](#1、JSP简介)
* [2、JSP特点](#2、JSP特点)
* [3、JSP的基本语法](#3、JSP的基本语法)
* [4、请求与响应](#4、请求与响应)
* [5、九大内置对象与四个作用域](#5、九大内置对象与四个作用域)
* [6、EL表达式](#6、EL表达式)
* [7、JSTL表达式](#7、JSTL表达式)
* [8、JSP页面国际化](#8、JSP页面国际化)

<a name="1、JSP简介"></a>
### 1、JSP简介 ###

- Java Server Page, Java EE组件，是一种动态网页开发技术,本质上是 Servlet。JSP是标签式的文本文件(Servlet是Java文件) 。
- 运行在 Web Container 接收 Http Request，生成 Http Response(默认协议是 Http 请求和响应) 。
- 基础是servlet，它的网页界面比servlet容易做。
- JSP不需要编译(其实是由服务器监测JSP文件的变化，再将其翻译成 Servlet 代码) 。
- jsp=html+java片段+jsp标签+javascript(css) -->比较综合
- JSP从本质上来说内核还是Servlet，但与Servlet不是替代关系而是一种互补的关系。JSP适合于写显示层的动态页面，而Servlet则适合写控制层的业务控制(页面转发)。
- jsp功能的强大是因为可以与javabean结合使用(即：jsp作前台(界面)，javabean作后台(逻辑层))。
- Jsp+javabean的基础上再结合servlet，就会构成mvc的开发模式.
- 服务器对其进行编译并在第一次请求时创建一个Servlet实例。所以，第一次访问JSP页面时会后延迟，以后再次访问同一页面就会感觉到速度明显变快，也是因为 class文件已经生成的原因。
- 只有当第一次请求页面或者是JSP文件发生改变的时候JSP文件才会被编译，然后服务器调用servlet类，处理浏览器的请求。

> JSP与Servlet的区别：
 
	1. jsp文件被服务器翻译成一个对应的servlet文件并编译成.class文件，对应的servlet文件放在work目录下。
	2. jsp是以servlet为基础的。
	3. jsp文件改变时，服务器能自动重新加载该文件，不需要重启服务器。
	  
<a name="2、JSP特点"></a>
### 2、JSP特点 ###

- 每一个JSP都会对应有一个servlet生成。
- 在 %tomcat%/work/Catalina/localhost/工程名/org/apache/jsp 目录下可找到对应生成的 Servlet 文件。
> 生命周期

	一般而言，每一个JSP对应的servlet都有如下的生命周期方法：
		1.  _jspInit()方法
			JSP容器第一次装载jsp文件时调用一次。
			public void _jspInit(){……}

		2.  _jspService()方法
			每当服务器接收到对该jsp的请求，都需要调用一次该方法一次。
			public void _jspService(HttpServletRequest request, HttpServletResponse response)throws java.io.IOException, ServletException { ……}

		3.  _jspDestroy()方法
			jsp文件被修改时，JSP容器会销毁旧的jsp文件对应的对象，重新装载一次更新后的jsp文件的内容(只调用一次)。
			public void _jspDestroy(){……}

> JSP处理过程

	1. JSP页面转换阶段：
		页面被编译成一个Java类，所有的HTML标记和JSP标记都被转换创建一个Servlet。这时，脚本和表达式还没有被执行;

	2. 请求处理阶段：
		发生在服务器，将一个客户端请求指向JSP页面。
		当这个servlet处理请求的时候它执行先前在JSP中定义的处理脚本小程序和表达式。
		服务器对其进行编译并在第一次请求时创建一个Servlet实例。所以，第一次访问JSP页面时会后延迟。
		jsp文件改变时，服务器能自动重新加载该文件，不需要重启服务器。

> Jsp的注释

	1.java格式注释
		<%-- JSP注释；可多行 --%> 
		<%// java 单行注释 %>
		<%/* java multi lines comments */%> 
		<%/**java 特有的注释*/%>
	
	2.html风格注释
		<!-- html风格注释 -->
		这种注释方式不好的地方就是当页面注释信息太多的时候会增大服务器的负荷， 还有注释信息需要在网络上传输，从而降低效率。

<a name="3、JSP的基本语法"></a>
### 3、JSP的基本语法 ###

> 3.1、Jsp的声明 
	
	格式：<%!.....%> 
	用来定义在产生的类文件中的类的属性和方法(成员变量)。
	可声明类(即是内部类)，属于类成员，最先加载，可写于任何位置。
	
	<%!String hello="Hello, World!";%>  //变量的声明
	<%=hello%>   //变量的调用
	<%! private int counter=0;  public int count(){ return ++counter;} %> //函数的声明
	<h1><%=count()%></h1> //函数的调用

	声明规则：
		1. JSP中声明的变量和方法对应于Servlet中的实例方法和实例变量。这些将被同时请求该页面的所有用户所共享;
		2. 在使用变量或方法前须先定义(不是说声明变量的位置在页面中要处于使用变量的前面，而是指变量不声明不能使用);
		3. 声明的变量或方法的作用域为当前页面或包含的页面;
		4. 语句间以分号分隔。

> 3.2、JSP代码段(Scriptlet)  

	格式：<% java代码 %>
	是一段可以在处理请求时间执行的Java代码。可以产生输出，也可以是一些流程控制语句。
	在代码段中定义的变量为service方法中的局部变量。

	<%  System.out.println("Hi,I like JSP."); %>   //在控制台打印出，网页上没显示
	<%  out.println("Hi,I like JSP."); %>          //打印在网页上

> 3.3、JSP表达式(expression)  

	格式：<%=……%>
	在JSP请求处理阶段计算他的值，表达式生成的代码是Service方法中的一个代码片断。
	1. 计算表达式的值
		<%="Hello,JSP world!"%>     //out.println("Hello,JSP world");

	2. 将值转换成String
		<%=name%>    //<%!String name="GiGi";%> out.println(name);

	3. 用out.println发送标签；把数据输出至页面的当前位置
		<%=new java.util.Date()%>   //out.println(new java.util.Date());

	表达式规则： 
		1. 你使用的脚本语言决定了脚本小程序的规则;
		2. 执行的顺序为从左到右;
		3. 分号不能用于表达式。

> 3.4、指令元素

	格式：<%@... %>
	作用：用于从jsp发送一个信息到容器，比如设置全局变量，文件字编码，引入包等。

	1. page指令：
		作用：声明页面的语言、内容类型、字符集、页面编码。
		<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
		<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
		
		指令属性：
			language：java唯一值，表示脚本中使用的编程语言。

			contentType：设置了内容的类型和静态页面的编码 (告诉浏览器以什么编码显示)
				默认：contentType="text/html; charset=ISO-8859-1"  --西欧，不支持中文。
			
			pageEncoding：页面本身的编码格式 (写页面时用的编码格式) 
			等价于servlet的： response.setContentType("text/html; charset=gbk");
			
			import：导入其他的包和类； 其中，JSP默认导入的包是java.util.*
				<%@page import="java.util.Date"%>	//具体的包和类
				<%@page import="java.sql.*"%>     //包下的所有类
				<%@page import="java.util.*, java.io.*, java.net.*"%> 	//导入多个包，逗号分隔
		
			extends	指定servlet从哪一个类继承
		
			Session：指示当前的jsp是否参与会话 (默认为session = true；)，可用内建对象session直接访问会话。
				<%  String name = (String)session.getAttribute("username");%>
		
			errorPage：Jsp页面中出现异常的处理方式
				<%@page errorPage="error.jsp"%> //异常时会跳转到处理异常的页面；这页面自己写
				对于处理异常的页面(error.jsp)添加:<%@page isErrorPage="true"%>，其中使用<%=exception.getMessage() %>把异常信息打印出来
			buffer	指定out对象使用缓冲区的大小

			autoFlush	控制out对象的 缓存区

			isThreadSafe	指定对JSP页面的访问是否为线程安全

			isELIgnored	指定是否执行EL表达式

	2. include指令
		把目标页面的内容包含到当前页面,产生页面叠加以后的输出效果 。
		<% @include file="filename" %>  /*静态引用filename文件，合并成一个serlvet进行编译*/

	3. taglib指令
		1. 使用系统标签JSTL
			<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		2. 自定义的标签
			<%@ taglib uri="WEB-INF/tld/lingirl.tld" prefix="lingirl" %>
			uri 指定 tld 定义文件的位置， prefix 指定对应的 taglib 前缀

> 3.5、动作元素
	
	动作元素是使用xml语法写的，是jsp规定的一系列标准确性动作，在容器处理jsp时，当容器遇到动作元素时，就执行相应的操作。
	
	1. <jsp:useBean> 
		创建一个JavaBean实例,scope--Java Bean对象的共享范围(page、request、session、application) 
		<jsp:useBean id="contact" class="com.hdc.model.Contact"  scope="application"/>

	2. <jsp:setProperty> 
		给一个java实例设置初始值                                                                                                      <jsp:setProperty name="JavaBean对象名" property="JavaBean属性名" value="属性值"/> 
		等价于： <% girl.setName("Lily");%>

		Java Bean中的属性名与form中输入域的名字保持一致的话，可以使用通配符*，一次设置所有字段的值。
		<jsp:setProperty name="contact" property="*"/>
		等价于:
		contact.setUsername(request.getParameter("username"));
		contact.setSex(request.getParameter("sex"));
		contact.setEmail(request.getParameter("email"));

	3. <jsp:getProperty> 
		取得一个javabean实例的成员变量
		<jsp:getProperty name="" property="" />
		name：标识具体的Bean对象，这与<jsp:useBean>标准动作中的id值相匹配

	4. <jsp:param>
		给一个jsp设置参数，常常与<jsp:include>结合使用
		<jsp:include file=”info.jsp”>
			<jsp:param name=”parameter1” value=”parameterValue” />
			<jsp:param name=”parameter2” value=”parameterValue” />
		</jsq:include>

	5. <jsp:include>
		引入另外一个文件，动态引入，作为单独的serlvet来编译运行。
		<jsp:include page="another.jsp" flush="true"/>
			等价于 Servlet中通过 RequestDispatcher().include();
			flush:布尔属性，定义在包含资源前是否刷新缓存区。
		
		可以传参数
		<jsp:include  page="b.jsp" flush="true">
			<jsp:param name="name" value="alex"/>
		</jsp:include>

	6. <jsp:forward>
		转发
		<jsp:forward page="another.jsp"/>
			等价于 Servlet中通过RequestDispatcher().forward();
		
	可以传参数
		<jsp:forward  page="another.jsp">
			<jsp:param name="name" value="alex"/>
			<jsp:param name="age" value="20" />
		</jsp:forward>

> 3.6、JSP中的异常处理

	1. try/catch/finally/throws/throw
		在局部代码里处理异常

	2. errorPage, isErrorPage
		在整个页面处理异常。
		
		errorPage
			 格式： <%@page errorPage="error.jsp"%>
			 表示：需要错误处理的页面。
		isErrorPage
			 格式： <%@page isErrorPage="true"%> 
			 表示：错误页面。
			有一个隐式对象exception可用： <%=exception%> 产生(隐含)内建对象exception,可通过它获得异常信息 <%=exception.getMessage() %> //把异常信息打印出来。

	3. 声明的方式处理异常
		在整个应用处理异常。(范围比前两种更大) 
		配置： 在web.xml进行配置异常处理。

		<error-page>
			<exception-type>java.lang.ArithmeticException</exception-type>
			<location>/MathError.jsp</location> 
		</error-page>
		<error-page>
			<error-code>404</error-code>
			<location>/404.jsp</location>
		</error-page>  

		通过类型判断或者通过状态码判断
		错误页面中要标明 <%@page isErrorPage="true" %>

	Java中的异常【有2种】
		 1. 受查异常(Checked Exception) 
		 2. 非受查异常(Unchecked Exception) 
			Java中的RuntimeException及其子类是不需要处理的(try/catch)，
			因为所有的RuntimeException总是可以通过优化代码来避免，因此，这种异常被称为"Unchecked Exception"。

<a name="4、九大内置对象与四个作用域"></a>
### 4、九大内置对象与四个作用域 ###

> 内置对象【隐含对象】特点:
		
	1. 由JSP规范提供，不用编写者实例化即可使用;
	2. 通过Web容器实现和管理;
	3. 所有JSP页面均可使用;
	4. 只有在脚本元素的表达式或代码段中才可使用(<%=使用内置对象%>或<%使用内置对象%>)。

> 常用内置对象:
		
	1. 输出输入对象:	request对象、response对象、out对象
	2. 通信控制对象:	pageContext对象、session对象、application对象
	3. Servlet对象:	page对象、config对象
	4. 错误处理对象:	exception对象
	
> 1、out【数据流 javax.servlet.jsp.jspWriter】
		
	向客户端输出数据，字节流，如：out.println("");
	类似servlet中的：PrintWriter out=res.getWriter();

|out方法| 说明|
|:-|:-|
|print或println|	输出数据|
|newLine|输出换行字符|
|flush|输出缓冲区数据|
|close|关闭输出流|
|clear|清除缓冲区中数据,但不输出到客户端|
|clearBuffer|清除缓冲区中数据,输出到客户端|
|getBufferSize|获得缓冲区大小|
|getRemaining|获得缓冲区中没有被占用的空间|
|isAutoFlush|是否为自动输出|

> 2、request【请求信息 javax.servlet.http.HttpServletrequest】

	作为域对象来接受客户端的http请求
	
|request方法| 说明|
|:-|:-|
|isUserInRole|判断认证后的用户是否属于某一成员组|
|getAttribute|获取指定属性的值,如该属性值不存在返回Null|
|getAttributeNames|获取所有属性名的集合枚举|
|getCookies	|获取所有Cookie对象|
|getCharacterEncoding|获取请求的字符编码方式|
|getContentLength	|返回请求正文的长度,如不确定返回-1|
|getHeader	|获取指定名字报头值|
|getHeaders	|获取指定名字报头的所有值,一个枚举|
|getHeaderNames	|获取所有报头的名字,一个枚举|
|getInputStream	|返回请求输入流,获取请求中的数据|
|getMethod	|获取客户端向服务器端传送数据的方法|
|getParameter|获取指定名字参数值|
|getParameterNames|获取所有参数的名字,一个枚举|
|getParameterValues	|获取指定名字参数的所有值|
|getProtocol|获取客户端向服务器端传送数据的协议名称|
|getQueryString|获取以get方法向服务器传送的查询字符串|
|getRequestURI	|获取发出请求字符串的客户端地址|
|getRemoteAddr	|获取客户端的IP地址|
|getRemoteHost	|获取客户端的名字|
|getSession	|获取和请求相关的会话|
|getServerName	|获取服务器的名字|
|getServerPath	|获取客户端请求文件的路径|
|getServerPort	|获取服务器的端口号|
|removeAttribute|删除请求中的一个属性|
|setAttribute	|设置指定名字参数值|

> 3、response【响应 javax.servlet.http.HttpServletResponse】

	封装jsp产生的回应
	
|response方法| 说明|
|:-|:-|
|addCookie	|添加一个Cookie对象|
|addHeader	|添加Http文件指定名字头信息|
|containsHeader	|判断指定名字Http文件头信息是否存在|
|encodeURL	|使用sessionid封装URL|
|flushBuffer|强制把当前缓冲区内容发送到客户端|
|getBufferSize	|返回缓冲区大小|
|getOutputStream|返回到客户端的输出流对象|
|sendError	|向客户端发送错误信息|
|sendRedirect|把响应重定向到另一个位置进行处理|
|setContentType	|设置响应的MIME类型|
|setHeader|	设置指定名字的Http文件头信息|

> 4、session【会话 javax.servlet.http.HttpSession】
	
	是serlvet中HttpSession类的实例,和serlvet的session的用法一样
	
|session方法| 说明|
|:-|:-|
|setAttribute|设定指定名字的属性值|
|getAttribute|获取指定名字的属性|
|getAttributeNames|获取session中全部属性名字,一个枚举|
|getCreationTime|	返回session的创建时间|
|getId|获取会话标识符|
|getLastAccessedTime|返回最后发送请求的时间|
|getMaxInactiveInterval|返回session对象的生存时间单位千分之一秒|
|invalidate|销毁session对象|
|isNew|每个请求是否会产生新的session对象|
|removeAttribute|	删除指定名字的属性|

> 5、application【上下文 javax.servlet.ServletContext】

	整个web应用共享，多个用户共享该对象，可以做计数器
	
|application方法| 说明|
|:-|:-|
|getAttribute|获取应用对象中指定名字的属性值|
|getAttributeNames|获取应用对象中所有属性的名字,一个枚举|
|getInitParameter|返回应用对象中指定名字的初始参数值|
|getServletInfo	|返回Servlet编译器中当前版本信息|
|setAttribute|设置应用对象中指定名字的属性值|

> 6、pageContext【页面上下文 javax.servlet.jsp.PageContext】
	
	代表jsp页面的上下文
	
|pageContext方法| 说明|
|:-|:-|
|forward|转发到另一页面或Servlet组件|
|getAttribute|获取某范围中指定名字的属性值|
|findAttribute|按范围搜索指定名字的属性|
|removeAttribute|删除某范围中指定名字的属性|
|setAttribute|设定某范围中指定名字的属性值|
|getException|	返回当前异常对象|
|getRequest	|返回当前请求对象|
|getResponse|返回当前响应对象|
|getServletConfig|返回当前页面的ServletConfig对象|
|getServletContext|返回所有页面共享的ServletContext对象|
|getSession	|返回当前页面的会话对象|

> 7、exception【运行时的异常,java.lang.Throwable】

	代表运行时的一个异常
	
	方法:
		被调用的错误页面的结果,只有在错误页面中才可使用,即在页面指令中设置:<%@page isErrorPage="true"%>
		getMessage()			返回运行异常信息

> 8、page

	代表jsp这个实例本身（使用比较少）
	当前JSP的实例,java.lang.object

> 9、config【Servlet的配置信息 javax.servlet.ServletConfig】

	代表jsp对应的servlet配置，可以得到web.xml中的参数
	
	方法:
		getServletContext		返回所执行的Servlet的环境对象
		getServletName			返回所执行的Servlet的名字
		getInitParameter		返回指定名字的初始参数值
		getInitParameterNames	返回该JSP中所有的初始参数名，一个枚举

### JSP四个作用域 ###

> 1、page ：当前页面范围（范围最小，生命周期最短）

	作用域里的变量没法从 index.jsp 传递到 test.jsp，只要页面跳转了，它们就不见了。

> 2、request ：同一个请求范围(forward,include )
	
	变量可以跨越 forward 前后的两页,但是只要刷新页面，它们就重新取值了。

> 3、session ：同一个会话（默认30min）

	变量一直在累加，只要关闭浏览器，再次重启浏览器访问这页，session 里的变量就重新计算了。

> 4、application :同一个应用（范围最大，生命周期最长）
		
	变量一直在累加，除非你重启 tomcat，否则它会一直增加。

> 作用域规定的是变量的有效期限：
	
	1. 如果把变量放到 pageContext 里，就说明它的作用域是 page，它的有效范围只在当前 jsp 页面里。从把变量放到 pageContext 开始，到当前 jsp 页面结束，你都可以使用这个变量。
	
	2. 如果把变量放到 request 里，就说明它的作用域是 request，它的有效范围是当前请求周期。
		所谓请求周期，就是指从 http 请求发起，到服务器处理结束，返回响应的整个过程。在这个过程中可能使用 forward 的方式跳转了多个 jsp 页面，在这些页面里你都可以使用这个变量。
	
	3. 如果把变量放到 session 里，就说明它的作用域是 session，它的有效范围是当前会话。
		所谓当前会话，就是指从用户打开浏览器开始，到用户关闭浏览器这中间的过程。这个过程可能包含多个请求响应。也就是说，只要用户不关浏览器，服务器就有办法知道这些请求是一个人发起的，整个过程被称为一个会话（session），而放到会话中的变量，就可以在当前会话的所有请求里使用。
	
	4. 如果把变量放到 application 里，就说明它的作用域是 application，它的有效范围是整个应用。
		整个应用是指从应用启动，到应用结束。application 作用域里的变量，它们的存活时间是最长的，如果不进行手工删除，它们就一直可以使用。
		
	【注意】application 里的变量可以被所有用户共用。如果用户甲的操作修改了 application 中的变量，用户乙访问时得到的是修改后的值。这在其他 scope 中都是不会发生的，page, request, session都是完全隔离的，无论如何修改都不会影响其他人的数据。

<a name="5、绝对路径和相对路径"></a>
### 5、绝对路径和相对路径 ###
- 使用相对路径可能有问题，但使用绝对路径肯定没有问题。

> 相对路径和绝对路径
		
	1. 相对路径
		指相对于当前资源所在路径：http://主机名:端口号/项目名/资源路径/
		由于转发的出现，相对路径会经常发生变化，容易出现错误的链接，所以在开发中我们一般不使用相对路径，而是使用绝对路径。

	2. 绝对路径
		绝对路径使用/开头 。

		由浏览器解析的绝对路径中的/代表的是服务器的根目录：http://主机名:端口号/
			由于没有项目名，故需要加上项目名才可以访问

		由服务器解析的绝对路径中的/代表的项目的根目录：http://主机名:端口号/项目名/
			由于已经带有项目名，故不要加项目名即可访问

> 绝对路径

	可以避免因为目录变动导致引入文件找不到的情况。
	 ${pageContext.request.contextPath} 的作用是取出部署的应用程序名，这样不管如何部署，所用路径都是正确的。
	 ${pageContext.request.contextPath} 等效于 <%=request.getContextPath()%>

> forward 的例子：
	
	<%request.getRequestDispatcher("/relative/result/result.jsp").forward(request, response);%>
	这里的绝对路径就是/relative/result/result.jsp。
	在本地测试时， forward 把 http://localhost:8080/03-03/当作根路径，在它的基础上计算绝对路径。
	
	这是由 jsp 的部署方式决定的， webapp 里可以放好多项目，为了让这些项目可以互不影响、独立运行，不能让请求从一个项目直接在服务器内部转移到另一个项目。
	为了防止出现这种情况，在执行 forward 的时候干脆把项目的路径当作根目录，开发者看不到其他项目，也就不会出现问题了。
	
> redirect 的例子：
	
	response.sendRedirect(request.getContextPath()+"/test/test.jsp");
	<%response.sendRedirect("/03-03/absolute/result/result.jsp");%>
	
	这里的绝对路径却是/03-03/absolute/result/result.jsp。
	在本地测试时， redirect 把 http://localhost:8080/当作根路径，在它的基础上计算绝对路径。

<a name="6、EL表达式"></a>
### 6、EL表达式 ###

> EL（express language）

	格式：${el}
	使用 EL 的时候，默认会以一定顺序搜索四个作用域，将最先找到的变量值显示出来
		pageContext --> request --> session --> application

	即使用${username}，会依次调用
		pageContext.getAttribute("username") -> request.getAttribute("username") ->  session.getAttribute("username")-> application.getAttribute("username"),
		只要找到某一个不为空的值就立刻返回，都找不到则返回null。

	为了避免有同名变量时的取值问题，EL引入了作用域的概念
		${pageScope.username}
		${requestScope.username}
		${sessionScope.username}
		${applicationScope.username}

	$!{var} 表示当${var} 不存在或者取值为null 时，前端页面则显示为空字符；
	
	表达式       	vs      EL表达式语言(JSP2.0) 
	<%=name%>     	<=>       ${name} 

	使用page指令将isELIgnored属性值设为true：
	<%@ page isELIgnored ="true|false" %>
	这样，EL表达式就会被忽略[停用]。若设为false，则容器将会计算EL表达式。

	EL表达式内可以使用整型数，浮点数，字符串，常量true、false，还有null。

	
|EL 中的作用域| 对应关系|
|:-|:-|
|pageContext | 当前页的 pageContext 对象|
|pageScope 	| 把 page 作用域中的数据映射为一个 map 对象|
|requestScope |	把 request 作用域中的数据映射为一个 map 对象|
|sessionScope |	把 session 作用域中的数据映射为一个 map 对象|
|applicationScope |	把 application 作用域中的数据映射为一个 map 对象|
|param 	| 对应 request.getParameter()|
|paramValues | 对应 request.getParameterValues(),得到的是一个字符串数组|
|header | 对应 request.getHeader()，是一个String类型的值|
|headerValues |	对应 request.getHeaderValues()，是一个String类型的数组|
|cookie | 对应 request.getCookies()|
|initParam | 对应 ServletContext.getInitParamter()|

	pageScope, requestScope, sessionScope, appliationScope 都可以看作是Map 型变量
	调用其中的数据可以使用${pageScope.name}或${pageScope["name"]}的形式，这两种写法是等价的。

	注：在某些情况下只能使用${pageScope["content-type"]}，这里不能写成
		${pageScope.content-type}， jsp 无法解析连字符（-）会出现错误。
	
	需要注意的是${paramValues.name}得到的是一个字符串数组，如果需要获
	得其中某个值，还需要使用${paramValues.name[0]}指定数组中的索引。

|EL的算术和逻辑操作符| 对应关系|
|:- |:-|
|.  | 访问一个Bean属性或者一个映射条目|
|[]	| 访问一个数组或者链表的元素|
|() | 组织一个子表达式以改变优先级|
|+  | 加|
|-  | 减或负|
|*  | 乘|
|/ or div | 除|
|% or mod | 取模|
|== or eq | 测试是否相等|
|!= or ne | 测试是否不等|
|< or lt  | 测试是否小于|
|> or gt  | 测试是否大于|
|<= or le | 测试是否小于等于|
|>= or ge | 测试是否大于等于|
|&& or and| 测试逻辑与|
|! or not | 测试取反|
|empty	  | 测试是否空值|
|?:       | 三元运算符|

<a name="7、JSTL表达式"></a>
### 7、JSTL表达式 ###

> JSTL(java standard taglib)   
> 由于taglib太复杂了，sun 为标签库定义了一套标准，叫做 jstl java 标准标签库。  
> JSTL 库安装

	官方下载地址：http://archive.apache.org/dist/jakarta/taglibs/standard/binaries/
	需要 standard.jar和jstl.jar 这两个jar包

> 在JSP中引用核心标签库
	
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

|核心标签|说明|
|:-- |:-|
|<c:out>|用于在JSP中显示数据，就像<%= ... >|
|<c:set>|用于保存数据|
|<c:remove>	|用于删除数据|
|<c:catch>	|用来处理产生错误的异常状况，并且将错误信息储存起来|
|<c:if>	|与我们在一般程序中用的if一样，没有else,但可以把判断的结果储存起来|
|<c:choose>	|本身只当做<c:when>和<c:otherwise>的父标签|
|<c:when>	|<c:choose>的子标签，用来判断条件是否成立|
|<c:otherwise>|	<c:choose>的子标签，接在<c:when>标签后，当<c:when>标签判断为false时被执行|
|<c:import>	|检索一个绝对或相对 URL，然后将其内容暴露给页面|
|<c:forEach>|基础迭代标签，接受多种集合类型，属性都是非必须的|
|<c:forTokens>|	根据指定的分隔符来分隔内容为一个数组并迭代输出|
|<c:param>	|用来给包含或重定向的页面传递参数|
|<c:redirect>|重定向至一个指定的URL|
|<c:url>|用于调用response.encodeURL()方法的一种可选的方法。<c:url>标签将URL格式化为一个字符串，然后存储在一个变量中|

> 例子

	<!-- value 可以使用el表达式 -->
	<c:set var="name" value="kevin" scope="page"/>  
	<c:remove var="name"/>
	<c:out value="${pageScope.name }"/>
			
	<!-- var 用来存储错误信息的变量 -->
	<c:catch var="catchException">
		<% int x=5/0; %>
	</c:catch>
	<c:if test="${catchException!=null}">

		异常为：${catchException} <br/>
		异常信息：${catchException.message}   

	</c:if>
			
	<!--c:if中没有else，但是可以把判断的结果储存起来，返回true|false-->
	<c:set var="age" value="20" scope="request"/>
	<c:if test="${age>18 }" var="isAdult" scope="request"></c:if>

	isAdult:<c:out value="${requestScope.isAdult }"/>
		
	<!-- c:choose标签  -->	
	<c:choose>
		<c:when test="${salary <= 0}">
			太惨了。
		</c:when>
		<c:when test="${salary > 1000}">
		   不错的薪水，还能生活。
		</c:when>
		<c:otherwise>
			什么都没有。
		</c:otherwise>
	</c:choose>

	【注】<c:when>，<c:otherwise>独立使用，必须要有<c:choose>；
		且<c:otherwise>必须在<c:when>的后面。
		
> c:forEach 标签【常用】
		
	作用: 循环控制，它可以将集合(Collection)中的成员循序遍历。

	<c:forEach
		items="<object>"
		begin="<int>"
		end="<int>"
		step="<int>"
		var="<string>"
		varStatus="<string>">

|forEach属性|说明|
|:-- |:-|	
|items|要被循环的信息	|
|begin|	开始的元素（0=第一个元素，1=第二个元素）|
|end|最后一个元素，默认是最后一个元素	|
|step|每一次迭代的步长，默认是1|
|var|代表当前条目的变量名称	|
|varStatus|	代表循环状态的变量名称|

	varStatus 属性还有另外属性：
		index	现在指到成员的索引(int)
		count	总共指到成员的总数(int)
		first 	现在指到的成员是否为第一个成员(boolean)
		last	现在指到的成员是否为最后一个成员(boolean)
		current 当前这次遍历的（集合中的）项

	<%
		String atts[]=new String[]{"aaa","bbb","ccc","ddd","eee"};
		request.setAttribute("atts", atts);
	%>
	<br/>
	<c:forEach  items="${atts}" begin="0" step="1" end="2" var="i" varStatus="status" >
		<c:out value="${status.index }"/>
		<c:out value="${i }"></c:out>
		<br>
	</c:forEach><br/>

	输出：
	0 aaa 
	1 bbb 
	2 ccc

> c:forTokens 语法格式 【不常用】
	
	处理字符串，类似于split()
	
	<c:forTokens
		items="<string>"
		delims="<string>"
		begin="<int>"
		end="<int>"
		step="<int>"
		var="<string>"
		varStatus="<string>">
		
		delims	分隔符，是必要的
		
	<c:forTokens items="aaa,bbb,ccc;ddd" delims="," var="abc">
		<c:out value="${abc}"/>
    </c:forTokens>
	
	输出：
	 aaa bbb ccc;ddd
	
> 格式化标签

	JSTL格式化标签用来格式化并输出文本、日期、时间、数字。
	<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
		
|格式化标签|说明|
|:-- |:-|
|<fmt:formatNumber>|使用指定的格式或精度格式化数字|
|<fmt:parseNumber>|解析一个代表着数字，货币或百分比的字符串|
|<fmt:formatDate>|使用指定的风格或模式格式化日期和时间|
|<fmt:parseDate>|解析一个代表着日期或时间的字符串|
|<fmt:bundle>|绑定资源|
|<fmt:setLocale>|指定地区|
|<fmt:setBundle>|绑定资源|
|<fmt:timeZone>	|指定时区|
|<fmt:setTimeZone>|指定时区|
|<fmt:message>|显示资源配置文件信息|
|<fmt:requestEncoding>|设置request的字符编码|

> SQL 标签

	JSTL SQL标签库提供了与关系型数据库（Oracle，MySQL，SQL Server等等）进行交互的标签。
	<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

|SQL标签|说明|
|:-- |:-|
|<sql:setDataSource>|指定数据源|
|<sql:query>|运行SQL查询语句|
|<sql:update>|运行SQL更新语句|
|<sql:param>|将SQL语句中的参数设为指定值|
|<sql:dateParam>|将SQL语句中的日期参数设为指定的java.util.Date 对象值|
|<sql:transaction>|在共享数据库连接中提供嵌套的数据库行为元素，将所有语句以一个事务的形式来运行|

> fn标签：

	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

|fn标签|说明|例子|
|:-|:-|:-|
|fn:contains |	判断字符串是否包含另外一个字符串 |  <c:if test="${fn:contains(name, searchString)}">|
|fn:containsIgnoreCase | 判断字符串是否包含另外一个字符串(大小写无关) |<c:if test="${fn:containsIgnoreCase(name, searchString)}">|
|fn:endsWith |	判断字符串是否以另外字符串结束 |<c:if test="${fn:endsWith(filename, ".txt")}">|
|fn:escapeXml | 把一些字符转成XML表示，例如<字符应该转为&lt; |  ${fn:escapeXml(param:info)}|
|fn:indexOf | 子字符串在母字符串中出现的位置 |${fn:indexOf(name, "-")}|
|fn:join | 将数组中的数据联合成一个新字符串，并使用指定字符格开 | ${fn:join(array, ";")}|
|fn:length | 获取字符串的长度，或者数组的大小  |  ${fn:length(shoppingCart.products)}|
|fn:replace | 替换字符串中指定的字符 |${fn:replace(text, "-", "&#149;")}|
|fn:split  | 把字符串按照指定字符切分  |  ${fn:split(customerNames, ";")}|
|fn:startsWith | 判断字符串是否以某个子串开始 | <c:if test="${fn:startsWith(product.id, "100-")}">|
|fn:substring | 获取子串 | ${fn:substring(zip, 6, -1)}|
|fn:substringAfter | 获取从某个字符所在位置开始的子串 |${fn:substringAfter(zip, "-")}|
|fn:substringBefore | 获取从开始到某个字符所在位置的子串  | ${fn:substringBefore(zip, "-")}|
|fn:toLowerCase | 转为小写  |  ${fn.toLowerCase(product.name)}|
|fn:toUpperCase | 转为大写字符 | ${fn.UpperCase(product.name)}|
|fn:trim | 去除字符串前后的空格 | ${fn.trim(name)}|

> 自定义一个JSTL标签

	1. 写一个java类，继承SimpleTag类

	2. 重写doTag()方法，在该方法里，实现相应的处理逻辑

		package com.hdc.tag;
		
		import java.io.IOException;
		
		import javax.servlet.jsp.JspContext;
		import javax.servlet.jsp.JspException;
		import javax.servlet.jsp.PageContext;
		import javax.servlet.jsp.tagext.JspFragment;
		import javax.servlet.jsp.tagext.JspTag;
		import javax.servlet.jsp.tagext.SimpleTag;
		
		public class MySimpleTag implements SimpleTag {
		
			//实际标签的逻辑体所在的方法
			public void doTag() throws JspException, IOException {
			
				System.out.println("调用doTag()");	
			}
			
			private PageContext pagecontext;
			
			// jsp引擎调用，把代表jsp页面的PageContext对象传入
			// PageContext 可以获取jsp页面的其他8个隐含对象
			// 所有只要是jsp页面上可以做的，标签处理器都可以做
			// 一定会被jsp调用，且先于doTag()被调用。
			@Override
			public void setJspContext(JspContext arg0) {
		
				this.pagecontext=(PageContext) arg0;
				System.out.println(arg0 instanceof PageContext);
			}
		}

	3. 在WEB-INF文件下创建一个以.tld【标签库描述文件】为扩展名的xml文件，描述该标签
		
		<?xml version="1.0" encoding="UTF-8"?>
		<taglib xmlns="http://java.sun.com/xml/ns/j2ee"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/web-jsptaglibrary_2_0.xsd"
			version="2.0">
			
			<!-- 描述TLD文件 -->
			<description>MyTag 1.0 core library</description>
			<display-name>MyTag core</display-name>
			<tlib-version>1.0</tlib-version>
			
			<!-- 建议在JSP页面上使用的标签的前缀 -->
			<short-name>hdc</short-name>
			
			<!-- 作为tld文件的ID，用来唯一标识当前的TLD文件，多个tld文件的URI不能重复
				通过jsp页面的taglib标签的uri属性来引用 -->
			<uri>http://www.hdc.com/mytag/core</uri>
			
		     <!-- 描述自定义的标签 -->
			<tag>
				<!-- 标签名称:在jsp页面上使用标签时的名字 -->
				<name>hello</name>
				
				<!-- 标签全类名 -->
				<tag-class>com.hdc.tag.MySimpleTag</tag-class>
				
				<!-- 标签体类型 -->
				<body-content>empty</body-content>
			
			</tag>
		 </taglib>

	4. 使用taglib导入标签（jsp中）

		 <%@taglib prefix="hdc" uri="http://www.hdc.com/mytag/core" %>
		 <body>
		 	<hdc:hello/>
		 </body>

<a name="8、JSP页面国际化"></a>
### 8、JSP页面国际化 ###

> 准备工作：建立properties资源

	建立2个properties文件：msg_en_US.properties和msg_zh_CN.properties。
	
	msg_en_US.properties
		title=title
		username=uname
		upasswd=upasswd
		submit=submit
		reset=reset

	msg_zh_CN.properties
		title=\u6807\u9898
		username=\u7528\u6237\u540D
		upasswd=\u5BC6\u7801
		submit=\u767B\u5F55
		reset=\u91CD\u7F6E

> JSP页面

	<%
	//获取资源包的对象
	ResourceBundle bundle=ResourceBundle.getBundle("msg",Locale.US);
	%>

	<form action="test" method="post">
	
		<%=bundle.getString("username") %>:<input type="text" name="username" /><br/>
		<%=bundle.getString("upasswd") %>:  <input type="password" name="passwd" /><br/>
		<input type="submit" value="<%=bundle.getString("submit") %>" />
		<input type="reset" value="<%=bundle.getString("reset") %>" />
		
	</form>
	

