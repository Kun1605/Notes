# SSM

* [1、SSM简介](#1、SSM简介)
* [2、SSM项目的开发步骤](#2、SSM项目的开发步骤)
* [3、SSM项目的开发实例](#3、SSM项目的开发实例)

<a name="1、SSM简介"></a>
### 1、SSM简介 ###

	SSM = Spring + SpringMvc + Mybatis
	spring 作为轻量级的底层框架：
	SpringMVC 相较于Struts2而言更加简洁轻便
	Mybatis 注意是JDBC使用，连接数据库，比hibernate 配置轻便
	SSM 适合开发中小型项目

> 项目开发步骤
	
	一、使用的开发工具
		intellij-IDEA、myeclipse
		jar包管理工具--Maven
		项目管理工具 -- SVN/GIT
	二、需求分析--画出用例图
	三、实体设计
		分析设计实体（确定实体关系以及实体属性）
	四、数据库设计
		建库建表
	五、功能设计
		功能模块划分
		使用xmind 思维导图设计
	六、原型图
		使用 axure设计原型【功能操作流程，页面显示流程】
	七、框架设计
		前端
			jquery + bootstrap
		后端
			视图技术：jsp
			参数验证：hibernate-validate
			MVC 框架：springMVC / Strust2
			容器框架：spring
			持久层：mybatis / Hibernate
			任务调度：quartz
		数据库
			连接池：C3P0 / JDBC
			数据库：mysql
			数据缓存：redis
		部署容器
			Tomcat8
	八、部署
		完成项目后，关闭Tomcat，使用run as --> maven install 打包项目成war 包,再部署到Tomcat上运行

<a name="2、SSM项目的开发步骤"></a>
### 2、SSM项目的开发步骤 ###

	1. 导入所需jar 包
	2. 编写数据库的表的实体类【逆向生成】
	3. 编写数据层接口 【Dao接口】
	4. 编写sql 映射文件 【XxxMapper.xml，并调用Dao接口操作数据库】
		【注】当sql映射文件的路径和Dao接口的路径一致时，Spring会自动加载映射文件，不用手动配置。
	5. 编写服务层接口 【XxxService】
	6. 编写服务层接口的实现类 	【XxxServiceImpl】
	7. 编写控制类 【XxxController】
	8. 编写 Mybatis 的全局配置文件 【mybatis-conf.xml】
	9. 编写 Spring 整合 Mybatis 的配置文件【spring-mybatis.xml，配置数据库连接，bean的注入，加载mybatis全局配置】
	10. 编写 SpringMVC 的配置文件 【springMVC.xml】
	11. 配置工程文件【/WEB-INF/web.xml】
	12. 编写相关视图页面 【/WEB-INF/page/*.jsp】

<a name="3、SSM项目的开发实例"></a>
### 3、SSM项目的开发实例 ###	
	
> 3.1、导入所需jar包

	<properties>
    	<spring.version>4.3.0.RELEASE</spring.version>
	</properties>

	<!--spring-->
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-beans</artifactId>
      <version>${spring.version}</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-context</artifactId>
      <version>${spring.version}</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-core</artifactId>
      <version>${spring.version}</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-jdbc</artifactId>
      <version>${spring.version}</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-web</artifactId>
      <version>${spring.version}</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-webmvc</artifactId>
      <version>${spring.version}</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-test</artifactId>
      <version>${spring.version}</version>
    </dependency>

    <!--mybatis-->
    <dependency>
      <groupId>org.mybatis</groupId>
      <artifactId>mybatis</artifactId>
      <version>3.4.2</version>
    </dependency>
    <dependency>
      <groupId>org.mybatis</groupId>
      <artifactId>mybatis-spring</artifactId>
      <version>1.3.0</version>
    </dependency>
    <!-- dbcp 数据库连接池-->
    <dependency>
      <groupId>commons-dbcp</groupId>
      <artifactId>commons-dbcp</artifactId>
      <version>1.4</version>
    </dependency>
	<!--mysql-->
    <dependency>
      <groupId>mysql</groupId>
      <artifactId>mysql-connector-java</artifactId>
      <version>5.1.38</version>
    </dependency>
    <dependency>
      <groupId>com.mchange</groupId>
      <artifactId>c3p0</artifactId>
      <version>0.9.5.2</version>
    </dependency>

    <!--日志-->
	<dependency>
      <groupId>org.slf4j</groupId>
      <artifactId>slf4j-api</artifactId>
      <version>1.7.25</version>
    </dependency>
    <dependency>
      <groupId>ch.qos.logback</groupId>
      <artifactId>logback-core</artifactId>
      <version>1.2.3</version>
    </dependency>
    <dependency>
      <groupId>ch.qos.logback</groupId>
      <artifactId>logback-classic</artifactId>
      <version>1.2.3</version>
      <scope>test</scope>
    </dependency>

    <dependency>
      <groupId>javax.servlet</groupId>
      <artifactId>javax.servlet-api</artifactId>
      <version>3.0.1</version>
      <scope>provided</scope>
    </dependency>
    <dependency>
      <groupId>javax.servlet.jsp</groupId>
      <artifactId>jsp-api</artifactId>
      <version>2.1</version>
      <scope>provided</scope>
    </dependency>
    <dependency>
      <groupId>jstl</groupId>
      <artifactId>jstl</artifactId>
      <version>1.2</version>
    </dependency>

    <!--<dependency>-->
      <!--<groupId>com.alibaba</groupId>-->
      <!--<artifactId>fastjson</artifactId>-->
      <!--<version>1.2.7</version>-->
    <!--</dependency>-->
    <dependency>
      <groupId>com.fasterxml.jackson.core</groupId>
      <artifactId>jackson-core</artifactId>
      <version>2.8.8</version>
    </dependency>
    <dependency>
      <groupId>com.fasterxml.jackson.core</groupId>
      <artifactId>jackson-annotations</artifactId>
      <version>2.8.8</version>
    </dependency>
    <dependency>
      <groupId>com.fasterxml.jackson.core</groupId>
      <artifactId>jackson-databind</artifactId>
      <version>2.8.8</version>
    </dependency>

	<!--提供了一系列static的方法Utils类-->
    <dependency>
      <groupId>org.apache.commons</groupId>
      <artifactId>commons-lang3</artifactId>
      <version>3.4</version>
    </dependency>

> 3.2、根据数据库逆向生成实体类  
> 3.3、Dao 接口
	
	/*
	 * 数据层接口
	 */
	package com.ssm.mapper;
	
	import java.util.List;
	
	import com.ssm.entity.Users;
	
	public interface UsersDao {
	
		public int countAll();
		
		public List<Users> getAll();
		
		public Users getUser(int userid);
		
		public void deleteUser(int userid);
		
		public void addUser(Users user);
		
		public void updateUser(Users user);
	}

> 3.4、 定义操作users表的sql映射文件 UserServiceImpl.xml

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
	
	<!-- namespace 的名称要映射到数据层的接口 -->
	<mapper namespace="com.ssm.mapper.UsersDao">
		<select id="countAll" resultType="int">
			select count(*) from users
		</select>
	    <select id="getAll" resultType="Users">
	    	select * from users
	    </select>
	    
	    <select id="getUser" parameterType="int" resultType="Users">
	    	select * from users where userid=#{userid}
	    </select>
	    
	    <!-- 删除用户【Remove】 -->
	 	<delete id="deleteUser" parameterType="int">
	 		delete from users where userid=#{userid}
	 	</delete>
	 	
	 	<!-- 添加用户 -->
	 	<insert id="addUser" parameterType="Users">
	 		insert into users(userid,username,passwd,age) values(#{userid},#{username},#{passwd},#{age})
	 	</insert>
	 	
	 	<!-- 修改用户 -->
	 	<update id="updateUser" parameterType="Users">
	 		update users set username=#{username},passwd=#{passwd},age=#{age} where userid=#{userid} 
	 	</update>
	</mapper>

> 3.5、定义服务层的接口

	package com.ssm.service;
	
	import java.util.List;
	
	import com.ssm.entity.Users;
	
	public interface UserService {
	
		public int countAll();
		
		public List<Users> getAll();
		
		public Users getUser(int userid);
		
		public void deleteUser(int userid);
		
	    public void addUser(Users user);
		
		public void updateUser(Users user);
	}

> 3.6、定义服务层的接口的实现类

	package com.ssm.service.impl;
	
	import java.util.List;
	import javax.annotation.Resource;
	import org.springframework.stereotype.Service;
	import org.springframework.transaction.annotation.Transactional;
	import com.ssm.entity.Users;
	import com.ssm.mapper.UsersDao;
	import com.ssm.service.UserService;
	
	/*
	 * @Service 定义该类为服务类
	 * @Transactional 定义该服务类的事务交给spring来接管
	 */
	
	@Service
	@Transactional
	public class UserServiceImpl implements UserService {
	
		@Resource
		public UsersDao usersDao;
		
		@Override
		public int countAll() {
			int count = usersDao.countAll();
			return count;
		}
	
		@Override
		public List<Users> getAll() {
			List<Users> findAllUser = usersDao.getAll();
			return findAllUser;
		}
	
		@Override
		public Users getUser(int userid) {
			Users user = usersDao.getUser(userid);
			return user;
		}
	
		@Override
		public void deleteUser(int userid) {	
			usersDao.deleteUser(userid);
		}
	
		@Override
		public void addUser(Users user) {	
			usersDao.addUser(user);
		}
	
		@Override
		public void updateUser(Users user) {	
			usersDao.updateUser(user);
		}
	}

> 3.7、定义控制类  UsersController

	package com.ssm.controller;
	
	import java.io.IOException;
	import java.util.ArrayList;
	import java.util.List;
	import java.util.regex.Matcher;
	import java.util.regex.Pattern;
	import javax.annotation.Resource;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpSession;
	import org.springframework.context.annotation.Scope;
	import org.springframework.stereotype.Controller;
	import org.springframework.web.bind.annotation.RequestMapping;
	import org.springframework.web.bind.annotation.RequestParam;
	import org.springframework.web.servlet.ModelAndView;
	import com.ssm.entity.Page;
	import com.ssm.entity.SePage;
	import com.ssm.entity.Users;
	import com.ssm.service.UserService;
	
	@Controller
	public class UsersController {
	
		//自动注入bean
		@Resource
		private UserService userService;
		
		@RequestMapping("/findCount")
		public String findCount(HttpServletRequest request){
			int count = userService.countAll();
			request.setAttribute("count", count);
			//页面重定向
			return "forward:index.jsp";
		}
			
		@RequestMapping("/findAllUser")
		public String findAllUser(HttpServletRequest request){
			List<Users> listUser =  userService.getAll();
	        request.setAttribute("listUser", listUser);
	        
	        return "allUser";
		}
		
		@RequestMapping("/findOneUser")
		public ModelAndView findOneUser(@RequestParam(value="userid") Integer userid,HttpServletRequest request){
			ModelAndView modelAndView = new ModelAndView();
			Users user = userService.getUser(userid);
			if(user!=null){
				modelAndView.addObject("user",user);
				modelAndView.setViewName("showUser");
				return modelAndView;
			}else{
				request.setAttribute("error", "没有该用户");
				modelAndView.setViewName("error");
				return modelAndView;
			}
		}
		
		@RequestMapping("/addUser")
		public String addUser(Users user,HttpServletRequest request){
			userService.addUser(user);
			return "redirect:findAllUser";
		}
		
		@RequestMapping("/deleteUser")
		public String deleteUser(@RequestParam(value="userid") Integer userid){
			userService.deleteUser(userid);
			return "redirect:findAllUser";
		}
		
		@RequestMapping("/updateUser")
		public String updateUser(Users user){
	
			userService.updateUser(user);		
			return "redirect:findAllUser";
		}
		
		@RequestMapping("/edit")
		public ModelAndView edit(@RequestParam(value="userid") Integer userid){
			ModelAndView modelAndView = new ModelAndView();
			Users user = userService.getUser(userid);
			modelAndView.addObject("user",user);
			modelAndView.setViewName("updateUser");
			return modelAndView;
		}
		
		@RequestMapping("/login")
		public String login(@RequestParam(value="username") String username,
				@RequestParam(value="passwd") String passwd,HttpServletRequest request){
			HttpSession session = request.getSession();
			int result= userService.chkLogin(username, passwd);
			if(result==0){
				//登录成功
				session.setAttribute("username", username);
				return "redirect:index.jsp";
			}
			else {
				if(result==1){
					//登录失败
					request.setAttribute("error","用户名错误");
					return "error";
				}
				else{
					request.setAttribute("error","密码错误");
					return "error";
				}
			}
		}
		
		//登出
		@RequestMapping("/logout")
		public String logout(HttpServletRequest request,HttpSession session){
			//清除登录缓存缓存
			//session.invalidate();
			session.removeAttribute("username");
			return "forward:login.jsp";
		}
		
		@RequestMapping("/Paging")
		public String fenye(@RequestParam(value="pageNow",required=false ) String pageNow,
				HttpServletRequest request,SePage sePage){
			
			Page page = null;
			List<Users> listUser =  new ArrayList<Users>();
			//初始定义页面记录数
			int pageSize=5;
			//总记录数
			int totalCount = userService.countAll();
	
			page = new Page(totalCount, pageSize);
			
			/**
			 * 即不是第一页
			 * 用户输入的页数必须是数字，否则返回显示首页
			 * 且在页数范围内，否则返回显示尾页
			 */
			if(pageNow!=null&&isNumeric(pageNow)){
				if(Integer.parseInt(pageNow) > 0 && Integer.parseInt(pageNow) <= page.getTotalPage()){
					page.setPageNow(Integer.parseInt(pageNow));
				}
				else{
					page.setPageNow(page.getTotalPage());
				}
				sePage.setPage(page);
				listUser = userService.fenye(sePage);
			}
			//第一页
			else{
				page.setPageNow(1);
				sePage.setPage(page);
				listUser = userService.fenye(sePage);
			}
			
			request.setAttribute("listUser", listUser);
			request.setAttribute("page", page);
			
			return "Paging";
		}
		
		//正则判断是否是数字
		public static boolean isNumeric(String str){
			Pattern pattern = Pattern.compile("[0-9]*");
			Matcher isNum = pattern.matcher(str);
			//不是数字
			if(!isNum.matches()){
				return false;
			}
			return true;
		}
		
		@RequestMapping("/chkUsername")
		public String chkUsername(@RequestParam(value="username") String username,HttpServletRequest request) throws IOException{
			List<String> usernames = userService.getUsername();
			if(usernames.contains(username)){
				return "deny";
			}
			else{
				return "allow";
			}
		}
		
	}


> 3.8、配置 mybatis 的全局配置文件 mybatis-config.xml

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN" 
	"http://mybatis.org/dtd/mybatis-3-config.dtd">
	<configuration>
	    <typeAliases>
	        <!-- 批量给实体类设置别名 -->
	        <package name="com.ssm.entity"/>
	    </typeAliases>
	    <mappers>
	        <!-- 注册sql映射文件 -->
	        <mapper resource="com/ssm/mapper/UsersMapper.xml" /> 
	        
	        <!-- 注册sql 映射接口 -->
	       <!--  <mapper class="com.ssm.mapper.UsersMapperInter"/> -->
	    </mappers>
	</configuration>

> jdbc.properties

	jdbc.driverClass=com.mysql.jdbc.Driver
	jdbc.jdbcUrl=jdbc:mysql://127.0.0.1:3306/test?useUnicode=true&amp;characterEncoding=utf8
	jdbc.user=root
	jdbc.password=123456
	jdbc.initialPoolSize=10
	jdbc.maxActive=100
	jdbc.maxIdle=30
	jdbc.minIdle=5

> 3.9、配置 spring 整合 mybatis 的配置文件 spring-mybatis.xml

	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
	    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:p="http://www.springframework.org/schema/p"
	    xmlns:context="http://www.springframework.org/schema/context" xmlns:tx="http://www.springframework.org/schema/tx"
	    xsi:schemaLocation="
	        http://www.springframework.org/schema/beans
	        http://www.springframework.org/schema/beans/spring-beans-4.0.xsd
	        http://www.springframework.org/schema/context
	        http://www.springframework.org/schema/context/spring-context-4.0.xsd
	        http://www.springframework.org/schema/tx
	        http://www.springframework.org/schema/tx/spring-tx-4.0.xsd">
			
		<context:property-placeholder location="classpath:config/jdbc.properties"/>

	    <!-- 1. 数据库连接配置-->
	    <bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource" destroy-method="close" >
	        <property name="driverClassName" value="${jdbc.driverClass}" />
	        <property name="url" value="${jdbc.jdbcUrl}" />
	        <property name="username" value="${jdbc.user}" />
	        <property name="password" value="${jdbc.password}" />
	        <property name="initialSize" value="${jdbc.initialPoolSize}"/>
	        <property name="maxActive" value="${jdbc.maxActive}"/>
	        <property name="maxIdle" value="${jdbc.maxIdle}"/>
	        <property name="minIdle" value="${jdbc.minIdle}"/>
	    </bean>
	
	    <!--
	        2. mybatis的SqlSession的工厂: SqlSessionFactoryBean 
	        	dataSource:引用数据源        
	        	MyBatis定义数据源,同意加载配置
	    -->
	    <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
	        <property name="dataSource" ref="dataSource"/>
	        <property name="configLocation" value="classpath:config/mybatis-config.xml" /> 
	    </bean>
	
	    <!--
	        3. mybatis自动扫描加载Sql映射文件/接口 : MapperScannerConfigurer sqlSessionFactory         
	        	basePackage:指定sql映射文件/dao 接口所在的包（自动扫描）
	    -->
	    <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
	        <property name="basePackage" value="com.ssm.dao"/>
	        <property name="sqlSessionFactoryBeanName" value="sqlSessionFactory"/>
	    </bean>
	
	    <!--
	        4. 事务管理 : DataSourceTransactionManager ，dataSource:引用上面定义的数据源
	    -->
	    <bean id="txManager"
	        class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
	        <property name="dataSource" ref="dataSource"/>
	    </bean>
	
	    <!-- 5. 使用声明式事务，transaction-manager：引用上面定义的事务管理器
	     -->
	    <tx:annotation-driven transaction-manager="txManager" />
	
	</beans>


> 3.10、定义SpringMVC 的配置文件spring-mvc.xml

	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
	    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:context="http://www.springframework.org/schema/context"
	    xmlns:mvc="http://www.springframework.org/schema/mvc"
	    xsi:schemaLocation="http://www.springframework.org/schema/beans 
	    http://www.springframework.org/schema/beans/spring-beans.xsd
	    http://www.springframework.org/schema/context
	    http://www.springframework.org/schema/context/spring-context-4.0.xsd
	    http://www.springframework.org/schema/mvc
	    http://www.springframework.org/schema/mvc/spring-mvc-4.0.xsd">
	    
	    <!-- 注解扫描包 -->    
	    <context:component-scan base-package="com.ssm" />
	    
	    <!-- 开启注解 -->
	    <mvc:annotation-driven />
	    
	    <!-- 定义跳转的文件的前后缀 ，视图模式配置-->
	    <bean id="viewResolver"
	        class="org.springframework.web.servlet.view.InternalResourceViewResolver">
	        <property name="prefix" value="/WEB-INF/page/" />
	        <property name="suffix" value=".jsp" />
	    </bean>
	</beans>

> 3.11、配置工程文件 web.xml

	<?xml version="1.0" encoding="UTF-8"?>
	<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee" 
	xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd" version="3.0">
	 
	    <!-- 加载Spring容器配置 -->
	    <listener>
	        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
	    </listener>
	    <!-- 设置Spring容器加载所有的配置文件的路径 ,默认加载的是WEB-INF下的applicationcontext.xml文件，此处是自定义-->
	    <context-param>
	        <param-name>contextConfigLocation</param-name>
	        <param-value>classpath*:config/spring-*.xml</param-value>
	    </context-param>
	
	    <!-- 配置SpringMVC核心控制器 -->
	    <servlet>
	        <servlet-name>springMVC</servlet-name>
	        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
	         <init-param>
	            <param-name>contextConfigLocation</param-name>
	            <param-value>classpath*:config/spring-mvc.xml</param-value>
	        </init-param> 
	        <!-- 启动加载一次 -->  
	        <load-on-startup>1</load-on-startup>
	    </servlet>
	
	    <!--为DispatcherServlet建立映射 -->
	    <servlet-mapping>
	        <servlet-name>springMVC</servlet-name>
	        <url-pattern>/</url-pattern>
	    </servlet-mapping>
	
	    <!-- 防止Spring内存溢出监听器 -->
	    <listener>
	        <listener-class>org.springframework.web.util.IntrospectorCleanupListener</listener-class>
	    </listener>
	
	    <!-- 解决工程编码过滤器 -->
	    <filter>
	        <filter-name>encodingFilter</filter-name>
	        <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
	        <init-param>
	            <param-name>encoding</param-name>
	            <param-value>UTF-8</param-value>
	        </init-param>
	        <init-param>
	            <param-name>forceEncoding</param-name>
	            <param-value>true</param-value>
	        </init-param>
	    </filter>
	    
	    <filter-mapping>
	        <filter-name>encodingFilter</filter-name>
	        <url-pattern>/*</url-pattern>
	    </filter-mapping>

	</web-app>
	
	【注意】web.xml的启动顺序  context-param --> listener --> filter -->servlet


> 整合故障：
		
	java.lang.AbstractMethodError: org.mybatis.spring.transaction.SpringManagedTransaction.getTimeout()Ljava/lang/Integer; 
	在mybatis+spring整合中，jar包的版本不对应
	mybatis 使用3.4 ，spring使用4.3，mybatis-spring使用1.2就会报上诉错误，改为1.3就正常
	
> 故障：

	Caches collection already contains value for
	spring 和 mybatis的配置文件都设置了数据库链接造成的。

	
	