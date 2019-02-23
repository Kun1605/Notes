# SpringBoot

* [1、SpringBoot简介](#1、SpringBoot简介)
* [2、SpringBoot核心注解类](#2、SpringBoot核心注解类)
* [3、SpringBoot的HTML模板](#3、SpringBoot的HTML模板)
* [4、SpringBoot使用](#4、SpringBoot使用)
* [5、SpringBoot整合Mybatis](#5、SpringBoot整合Mybatis)
* [6、SpringBoot整合Redis](#6、SpringBoot整合Redis)
* [7、SpringBoot整合ActiveMQ](#7、SpringBoot整合ActiveMQ)
* [8、SpringBoot部署tomcat上](#8、SpringBoot部署tomcat上)

<a name="1、SpringBoot简介"></a>
### 1、SpringBoot简介 ###
	
- 首先Spring Boot不是一个框架，它是一种用来轻松创建具有最小或零配置的独立应用程序的方式。
- 这种方法用来开发基于Spring的应用，但只需非常少的配置。
- 它提供了默认的代码和注释配置，快速启动新的Spring项目而不需要太多时间。
- 它利用现有的Spring项目以及第三方项目来开发生产就绪(投入生产)的应用程序。
- 它提供了一组Starter Pom或gradle构建文件，可以使用它们添加所需的依赖项，并且还便于自动配置。
- Spring Boot根据其类路径上的库自动配置所需的类。假设应用程序想要与数据库交互，如果在类路径上有Spring数据库，那么它会自动建立与数据源类的连接。
- **作用**：用来简化新Spring应用的初始搭建以及开发过程，核心思想就是**约定优于配置**，将功能组件化。主要是 提供starter 启动器 + 配置注解 + 少量的配置说明【yml】。
- 默认配置文件【.yml|.properties】直接在resources下创建即可。

> 优点

	1. 独立运行的Spring 项目，SpringBoot 可以以 jar 包的形式来运行。
	2. 内嵌 Servlet 容器【默认Tomcat】,无需以war 包形式部署。
	3. 提供 starter 启动器简化 Maven配置，无需配置太多依赖。starter 启动器已经通过maven方式添加了所需依赖。不同的starter 启动器 满足不同的功能组件的开发。
	4. 自动配置 Spring。
	5. 准生产的应用监控。
	6. 无 XML配置文件生成。

> Spring Boot 推荐的基础 POM 文件

|Pom文件|说明|
|:--|:--|
|spring-boot-starter | 核心 POM，包含自动配置支持、日志库和对 YAML 配置文件的支持。|
|spring-boot-starter-amqp |	通过 spring-rabbit 支持 AMQP。|
|spring-boot-starter-aop | 包含 spring-aop 和 AspectJ 来支持面向切面编程（AOP）。|
|spring-boot-starter-data-jpa | 包含 spring-data-jpa、spring-orm 和 Hibernate 来支持 JPA。|
|spring-boot-starter-data-mongodb | 包含 spring-data-mongodb 来支持 MongoDB。|
|spring-boot-starter-data-rest | 通过 spring-data-rest-webmvc 支持以 REST 方式暴露 Spring Data 仓库。|
|spring-boot-starter-jdbc | 支持使用 JDBC 访问数据库。|
|spring-boot-starter-security | 包含 spring-security。|
|spring-boot-starter-test | 包含常用的测试所需的依赖，如 JUnit、Hamcrest、Mockito 和 spring-test 等。|
|spring-boot-starter-web | 支持 Web 应用开发，包含 Tomcat 和 spring-mvc。|
|spring-boot-starter-websocket | 支持使用 Tomcat 开发 WebSocket 应用。|
|spring-boot-starter-ws | 支持 Spring Web Services。|
|spring-boot-starter-actuator | 添加适用于生产环境的功能，如性能指标和监测等功能。|
|spring-boot-starter-log4j | 添加 Log4j 的支持。|
|spring-boot-starter-logging | 使用 Spring Boot 默认的日志框架 Logback。|
|spring-boot-starter-tomcat | 使用 Spring Boot 默认的 Tomcat 作为应用服务器。|

<a name="2、SpringBoot核心注解类"></a>
### 2、SpringBoot核心注解类 ###

> @RestController 
	
	@Controller+@ResponseBody组合，支持RESTful访问方式，返回结果都是json字符串。

> @SpringBootApplication
		
	统一的注解【复合型注解】
	@SpringBootApplication = (默认属性)@Configuration + @EnableAutoConfiguration + @ComponentScan 。
			
	@Target({ElementType.TYPE})
	@Retention(RetentionPolicy.RUNTIME)
	@Documented
	@Inherited
	@SpringBootConfiguration
	@EnableAutoConfiguration
	@ComponentScan(
	    excludeFilters = {@Filter(type = FilterType.CUSTOM,classes = {TypeExcludeFilter.class}
	), @Filter(
	    type = FilterType.CUSTOM,classes = {AutoConfigurationExcludeFilter.class}
	)}
	)
	public @interface SpringBootApplication {
	    @AliasFor(
	        annotation = EnableAutoConfiguration.class,
	        attribute = "exclude"
	    )
	    Class<?>[] exclude() default {};
	
	    @AliasFor(
	        annotation = EnableAutoConfiguration.class,
	        attribute = "excludeName"
	    )
	    String[] excludeName() default {};
	
	    @AliasFor(
	        annotation = ComponentScan.class,
	        attribute = "basePackages"
	    )
	    String[] scanBasePackages() default {};
	
	    @AliasFor(
	        annotation = ComponentScan.class,
	        attribute = "basePackageClasses"
	    )
	    Class<?>[] scanBasePackageClasses() default {};
	}

> @Configuration

	@Configuration、@Bean。使用这两个注解就可以创建一个简单的spring配置类，可以用来替代相应的xml配置文件。
	@Configuration的注解类标识这个类可以使用Spring IoC容器作为bean定义的来源。
	@Bean注解告诉Spring，一个带有@Bean的注解方法将返回一个对象，该对象应该被注册为在Spring应用程序上下文中的bean。

> @EnableAutoConfiguration
		
	能够自动配置spring的上下文，试图猜测和配置你想要的bean类，通常会自动根据你的类路径和你的bean定义自动配置。

> @ComponentScan

	会自动扫描指定包下的全部标有@Component的类，并注册成bean，当然包括@Component下的子注解@Service,@Repository,@Controller。

> @SpringBootTest  
> @GetMapping、@PostMapping

	@RequestMapping(method = RequestMethod.GET)
	@RequestMapping(method = RequestMethod.POST)

<a name="3、SpringBoot的HTML模板"></a>
### 3、SpringBoot的HTML模板 ###

> 3.1、Thymeleaf模板  
> 3.1.1、pom.xml
	
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-thymeleaf</artifactId>
    </dependency>
	
> 3.1.2、在properties.yml中声明采用HTML5格式
	
	spring:
		thymeleaf:
    	mode: HTML5
	
> 3.1.3、创建html文件
		
	在resources下创建template目录，存放 .html文件
		
> 3.1.4、例子
			
	<!DOCTYPE html>
	<html lang="en" xmlns:th="http://www.w3.org/1999/xhtml">
	<head>
	    <meta charset="UTF-8"/>
	    <title>hello</title>
	</head>
	<body>
	    <span th:text="${name}"></span>
	</body>
	</html>
	
> 3.1.5、默认Thymeleaf配置
		
	# 是否启用thymeleaf模板解析
	spring.thymeleaf.enabled=true
	# 是否开启模板缓存（建议：开发环境下设置为false，生产环境设置为true）
	spring.thymeleaf.cache=false 
	# Check that the templates location exists.
	spring.thymeleaf.check-template-location=true 
	# 模板的媒体类型设置，默认为text/html
	spring.thymeleaf.content-type=text/html
	# 模板的编码设置，默认UTF-8
	spring.thymeleaf.encoding=UTF-8
	# 设置可以被解析的视图，以逗号,分隔
	#spring.thymeleaf.view-names=
	# 排除不需要被解析视图，以逗号,分隔
	#spring.thymeleaf.excluded-view-names=
	# 模板模式设置，默认为HTML5
	#spring.thymeleaf.mode=HTML5 
	# 前缀设置，SpringBoot默认模板放置在classpath:/template/目录下
	spring.thymeleaf.prefix=classpath:/templates/ 
	# 后缀设置，默认为.html
	spring.thymeleaf.suffix=.html

> 3.2、FreeMarker模板引擎  
> 3.2.1、pom.xml

	<dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-start-freemarker</artifactId>
    </dependency>

> 3.2.2、properties.yml
	
	spring:
	  freemarker:
	    allow-request-override: false
	    cache: false
	    check-template-location: true
	    charset: UTF-8
	    content-type: text/html
	    expose-request-attributes: false
	    expose-session-attributes: false
	    expose-spring-macro-helpers: false
	    template-loader-path=classpath: /templates/

> 3.2.3、默认FreeMarker配置

	# 是否开启模板缓存
	spring.freemarker.cache=true
	# 编码格式
	spring.freemarker.charset=UTF-8
	# 模板的媒体类型设置
	spring.freemarker.content-type=text/html
	# 前缀设置 默认为 ""
	spring.freemarker.prefix=
	# 后缀设置 默认为 .ftl
	spring.freemarker.suffix=.ftl
	#spring.freemarker.allow-request-override=false
	#spring.freemarker.check-template-location=true
	#spring.freemarker.expose-request-attributes=false
	#spring.freemarker.expose-session-attributes=false
	#spring.freemarker.expose-spring-macro-helpers=false
	#spring.freemarker.request-context-attribute=
	#spring.freemarker.template-loader-path=classpath:/templates/
	#spring.freemarker.view-names=

<a name="4、SpringBoot使用"></a>
### 4、SpringBoot使用 ###

> 自动配置
	
	Spring Boot 推荐采用基于Java注解的配置方式，而不是传统的 XML。
	只需要在主配置 Java 类上加"@SpringBootApplication "注解就可以启用自动配置。

> 环境配置
	
	application-test.properties：测试环境
	application-dev.properties：开发环境
	application-prod.properties：生产环境

> Spring-Boot属性文件【2种】
	
	1. application.yml
		
		server:
		  port: 9999
		spring:
		  thymeleaf:
		    mode: HTML5
		com:
		  hdc:
		    name: alex
		    age: 23
		
		冒号后面要隔空格。

		读取配置文件的值只需要加@Value(“${属性名}”)
		@Value("${com.hdc.name}")
		private String name;
		
	
	2. application.properties
		
		server.port=9999
		spring.thymeleaf.mode=HTML5

		只是和application.yml 格式不一样，其他相同。

> 最少pom.xml
	
	<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
							http://maven.apache.org/maven-v4_0_0.xsd">
	  <modelVersion>4.0.0</modelVersion>
	  <groupId>com.hdc</groupId>
	  <artifactId>springBoot</artifactId>
	  <packaging>war</packaging>
	  <version>1.0-SNAPSHOT</version>
	  <name>springBoot Maven Webapp</name>
	  <url>http://maven.apache.org</url>
	
	  <parent>
	    <!--继承Spring Boot的默认值-->
	    <groupId>org.springframework.boot</groupId>
	    <artifactId>spring-boot-starter-parent</artifactId>
	    <version>1.5.8.RELEASE</version>
	  </parent>

	  <dependencies>
	    <dependency>
	      <groupId>junit</groupId>
	      <artifactId>junit</artifactId>
	      <version>4.12</version>
	      <scope>test</scope>
	    </dependency>

	    <!--为Web应用程序添加典型的依赖关系-->
	    <dependency>
	      <groupId>org.springframework.boot</groupId>
	      <artifactId>spring-boot-starter-web</artifactId>
	    </dependency>
	  </dependencies>

	  <build>
	    <finalName>springBoot</finalName>
	    <plugins>
	      <plugin>
	        <!--作为可执行的插件使用-->
	        <groupId>org.springframework.boot</groupId>
	        <artifactId>spring-boot-maven-plugin</artifactId>
	      </plugin>
	    </plugins>
	  </build>
	</project>

> pom.xml 讲解

	1. 继承 parent 父模块，spring-boot-starter-parent 模块中包含了自动配置、日志和YAML，使构建spring项目变得简单。
		<parent>
			<!--继承Spring Boot的默认值-->
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-parent</artifactId>
			<version>1.5.8.RELEASE</version>
		</parent>

	2. pom.xml中依赖 spring-boot-starter-web 模块，包括了Tomcat和spring-webmvc，不需要指定version 版本，因为父模块中已经有默认配置，如果需要指定版本可添加。

		<!-- 该模块默认依赖了tomcat的starter，所以项目可以直接运行而不需要部署到tomcat中-->
		<dependency>
		    <groupId>org.springframework.boot</groupId>
		    <artifactId>spring-boot-starter-web</artifactId>
		</dependency>
	
	3. pom.xml中依赖 spring-boot-starter-test 测试模块，包括JUnit、Hamcrest、Mockito。
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
		</dependency>
	
	4. spring-boot-maven-plugin 插件模块,作为可执行的插件使用
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
			</plugin>
		</plugins>

> 例子  
> pom.xml
		
	<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
	  <modelVersion>4.0.0</modelVersion>
	  <groupId>com.hdc</groupId>
	  <artifactId>springBoot</artifactId>
	  <packaging>war</packaging>
	  <version>1.0-SNAPSHOT</version>
	  <name>springBoot Maven Webapp</name>
	  <url>http://maven.apache.org</url>
	
	  <parent>
	    <groupId>org.springframework.boot</groupId>
	    <artifactId>spring-boot-starter-parent</artifactId>
	    <version>1.5.8.RELEASE</version>
	  </parent>
	  <dependencies>
	    <dependency>
	      <groupId>junit</groupId>
	      <artifactId>junit</artifactId>
	      <version>4.12</version>
	      <scope>test</scope>
	    </dependency>

	    <dependency>
	      <groupId>org.springframework.boot</groupId>
	      <artifactId>spring-boot-starter-web</artifactId>
	    </dependency>

		<!--slf4j日志接口-->
		<dependency>
		  <groupId>org.slf4j</groupId>
		  <artifactId>slf4j-api</artifactId>
		  <version>1.7.25</version>
		</dependency>
		<!--slf4j与log4j的关联-->
		<dependency>
		  <groupId>org.slf4j</groupId>
		  <artifactId>slf4j-log4j12</artifactId>
		  <version>1.7.21</version>
		</dependency>

	  </dependencies>
	  <build>
	    <finalName>springBoot</finalName>
	    <plugins>
	      <plugin>
	        <groupId>org.springframework.boot</groupId>
	        <artifactId>spring-boot-maven-plugin</artifactId>
	      </plugin>
	    </plugins>
	  </build>
	</project>

		
	package com.hdc.Controller;
	
	import org.springframework.boot.SpringApplication;
	import org.springframework.boot.autoconfigure.SpringBootApplication;
	import org.springframework.web.bind.annotation.GetMapping;
	import org.springframework.web.bind.annotation.RestController;
	
	@RestController
	@SpringBootApplication
	public class Example {
	
	    @GetMapping("/")
	    public String home(){
	        return "hello world";
	    }
	
	    public static void main(String[] args) {
	        SpringApplication.run(Example.class,args);
	    }
	}

	运行应用：
	mvn spring-boot:run或在IDE中运行main()方法,或者在maven plugin里面运行，在浏览器中访问http://localhost:8080
	
> 分析
		
	1. SpringApplication是Spring Boot框架中描述Spring应用的类，它的run()方法会创建一个Spring应用上下文（Application Context）。
	另一方面它会扫描当前应用类路径上的依赖，例如本例中发现spring-webmvc（由 spring-boot-starter-web传递引入）在类路径中，那么Spring Boot会判断这是一个Web应用，并启动一个内嵌的Servlet容器（默认是Tomcat）用于处理HTTP请求。
		
	2. Spring WebMVC框架会将Servlet容器里收到的HTTP请求根据路径分发给对应的@Controller类进行处理，@RestController是一类特殊的@Controller，它的返回值直接作为HTTP Response的Body部分返回给浏览器。

> Spring Boot 热部署

	应用启动后会把编译好的Class文件加载的虚拟机中，正常情况下在项目修改了源文件是需要全部重新编译并重新加载（需要重启应用）。
	而热部署就是监听Class文件的变动，只把发生修改的Class重新加载，而不需要重启应用，使得开发变得简便。
	
	所需的依赖
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-devtools</artifactId>
			<optional>true</optional>
		</dependency>

	在application.properties文件中配置spring.thymeleaf.cache=false来实现），yml中不需要，默认就是false,实现类文件热部署（类文件修改后不会立即生效），实现对属性文件的热部署。

	IDEA配置
		当我们修改了Java类后，IDEA默认是不自动编译的，而spring-boot-devtools又是监测classpath下的文件发生变化才会重启应用，所以需要设置IDEA的自动编译：
		File-->Settings-->Compiler-->Build Project automatically
		或者ctrl + shift + alt + /,选择Registry
		勾上 Compiler autoMake allow when app running。

> springBoot测试

	<dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-test</artifactId>
      <version> 1.5.1.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-test</artifactId>
      <version>4.3.6.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version> 4.12</version>
    </dependency>
	
> 例子
		
	@RunWith(SpringJUnit4ClassRunner.class)
	@SpringBootTest(classes = SpringBootMain.class)
	public class ControllerTest {
	
	    @Resource
	    UserService userService;
	
	    @Test
	    public void insert() throws Exception {
	        User user = new User();
	        user.setId(1);
	        user.setUsername("kevin");
	        user.setAge(23);
	        int result = userService.insert(user);
	        System.out.println("result="+result);
	    }
	
	}

> 终端乱码处理

	<plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>

        <!-- spring-boot:run 中文乱码解决 -->
        <configuration>
          <fork>true</fork>
          <!--增加jvm参数-->
          <jvmArguments>-Dfile.encoding=UTF-8</jvmArguments>
        </configuration>

	</plugin>

<a name="5、SpringBoot整合Mybatis"></a>
### 5、SpringBoot整合Mybatis ###

> pom.xml

	<!--引入mybatis 启动器-->
    <dependency>
      <groupId>org.mybatis.spring.boot</groupId>
      <artifactId>mybatis-spring-boot-starter</artifactId>
      <version>1.3.1</version>
    </dependency>

    <dependency>
      <groupId>mysql</groupId>
      <artifactId>mysql-connector-java</artifactId>
    </dependency>

> application.yml
		
	# 整合mybatis
	mybatis:
	  type-aliases-package: com.hdc.model
	  mapper-locations: classpath:mapper/*Mapper.xml
	
	spring:
	  datasource:
	    url: jdbc:mysql://localhost:3306/hdc?useUnicode=true&characterEncoding=utf-8
	    driver-class-name: com.mysql.jdbc.Driver
	    username: root
	    password: "123456"

> SpringBoot 的启动入口

	@SpringBootApplication(scanBasePackages = "com.hdc")
	@MapperScan("com.hdc.dao")
	public class SpringBootMain {
	    public static void main(String[] args) {
	        SpringApplication.run(SpringBootMain.class,args);
	    }
	}

> dao/xml/controller/service 和SSM一样  
> 事务由 @Transactional 进行标注    
> 访问静态资源
		
	SpringBoot 默认提供的静态资源目录放在 classpath下，目录名需符合 /static 或者 /public。
	即可以在 src/main/resources/ 目录下创建目录static或者public 来存放静态资源文件，springBoot启动后，直接访问 localhost:port/静态文件 即可，不用带上目录。

<a name="6、SpringBoot整合Redis"></a>
### 6、SpringBoot整合Redis ###

> pom.xml
		
	<!--整合redis 的启动器-->
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-data-redis</artifactId>
    </dependency>
    <dependency>
      <groupId>redis.clients</groupId>
      <artifactId>jedis</artifactId>
      <version>2.9.0</version>
    </dependency>

> application.yml
		
	spring:
	  # 整合redis 集群
	  redis:
	    #cluster:
	      #nodes: 192.168.1.30:7000,192.168.1.30:7001,192.168.1.30:7002
	    # 整合redis 单机
	    host: 127.0.0.1
	    port: 6379
	
> Controller 测试:
		
	@RestController
	public class WakeListController {
	
	//    @Autowired
	//    private RedisTemplate redisTemplate;
	
	    @Autowired
	    private StringRedisTemplate redisTemplate;  //StringRedisTemplate 默认使用 StringRedisSerializer进行序列化，不会添加序列化前缀
	
	    @Autowired
	    private WakeListService wakeListService;
	
	    /**
	     * spring-data-redis的RedisTemplate<K, V>模板类在操作redis时默认使用JdkSerializationRedisSerializer来进行序列化
	     * 会使key添加序列化前缀，造成key不一致 ["\xac\xed\x00\x05t\x00\x04name"]
	     *
	     */
	    /*@Autowired(required = false)
	    public void setRedisTemplate(RedisTemplate redisTemplate) {
	        RedisSerializer stringSerializer = new StringRedisSerializer();
	        redisTemplate.setKeySerializer(stringSerializer);
	        redisTemplate.setValueSerializer(stringSerializer);
	        redisTemplate.setHashKeySerializer(stringSerializer);
	        redisTemplate.setHashValueSerializer(stringSerializer);
	        this.redisTemplate = redisTemplate;
	    }*/
	
	    @GetMapping("/wakelist")
	    @ResponseBody
	    public String wakelist(@RequestParam(required = false) String channel,
	                         @RequestParam(required = false,defaultValue = "notify") String action){
	
	        if (StringUtils.isNotBlank(channel)){
	            String resultKey = String.format("wakepool_%s_list_%s",action,channel);
	            String result = redisTemplate.opsForValue().get(resultKey,0,-1);
	            if (StringUtils.isBlank(result)){
	                result = wakeListService.getChannelWakelist(channel, action);
	                redisTemplate.opsForValue().set(resultKey,result,86400, TimeUnit.SECONDS);
	            }
	            return result;
	        }
	        return null;
	    }

> SpringBoot 的启动入口

	import org.mybatis.spring.annotation.MapperScan;
	import org.springframework.boot.SpringApplication;
	import org.springframework.boot.autoconfigure.SpringBootApplication;

	@SpringBootApplication(scanBasePackages = "com.test")
	@MapperScan("com.test.dao")
	public class SpringBootMain {
	    public static void main(String[] args) {
	        SpringApplication.run(SpringBootMain.class,args);
	    }
	}

<a name="7、SpringBoot整合ActiveMQ"></a>
### 7、SpringBoot整合ActiveMQ ###

> pom.xml
		
	<!--整合 activemq-->
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-activemq</artifactId>
    </dependency>
	producer
	
> application.yml

	# 整合activemq
	  activemq:
	    broker-url: tcp://192.168.1.30:61616
	    in-memory: true
	    user: admin
	    password: tucker10:escritoires
	    pool:
	      enabled: false

> 生产者	

	@Component
	public class Producer {
	
	    @Resource
	    private JmsMessagingTemplate jmsMessagingTemplate;
	
	    //发送消息
	    public void sendMessage(Destination destination, String message){
	        jmsMessagingTemplate.convertAndSend(destination,message);
	    }
	}

> 消费者

	@Component
	public class Consumer {
	
	    //消息监听
	    @JmsListener(destination = "myQueue")
	    public void receiveMsg(String message){
	
	        System.out.println("接收到的消息=" + message);
	    }
	}

> controller.java

	@Resource
    private Producer producer;

    @GetMapping("/sendMessage")
    public String sendMsg(){

        //点对点的目的地
        Destination destination = new ActiveMQQueue("myQueue");
        for (int i = 0; i < 10; i++) {
            producer.sendMessage(destination,"this is test "+ i);
        }
        return "ok";
    }


<a name="8、SpringBoot部署tomcat上"></a>
### 8、SpringBoot部署tomcat上 ###

> spring boot发布jar包web程序的入口是main函数所在的类，使用@SpringBootApplication注解。
> 但是如果war包发布至tomcat，需要增加 SpringBootServletInitializer 子类，并覆盖它的 configure 方法，或者直接将main函数所在的类继承 SpringBootServletInitializer 子类，并覆盖它的 configure 方法。

	@SpringBootApplication
	public class DemoApplication extends SpringBootServletInitializer {
	     
	    @Override
	    protected SpringApplicationBuilder configure(
	            SpringApplicationBuilder application) {
	        return application.sources(DemoApplication.class);
	    }
	 
	     
	    public static void main(String[] args) {
	        SpringApplication.run(DemoApplication.class, args);
	    }
	}

> 例子

	@SpringBootApplication(scanBasePackages = "com.test")
	@MapperScan("com.test.dao")
	public class SpringBootMain extends SpringBootServletInitializer {
	
	    @Override
	    protected SpringApplicationBuilder configure(
	            SpringApplicationBuilder application) {
	        return application.sources(SpringBootMain.class);
	    }
	
	    public static void main(String[] args) {
	        SpringApplication.run(SpringBootMain.class,args);
	    }
	
	}