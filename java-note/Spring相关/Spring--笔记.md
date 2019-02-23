# Spring #

* [1、Spring简介](#1、Spring简介)
* [2、Spring开发流程](#2、Spring开发流程)
* [3、Spring的Bean](#3、Spring的Bean)
* [4、XML配置选项](#4、XML配置选项)
* [5、SpEL表达式](#5、SpEL表达式)
* [6、面向切面编程【AOP】](#6、面向切面编程【AOP】)
* [7、Spring事务管理](#7、Spring事务管理)
* [8、Spring单元测试](#8、Spring单元测试)
* [9、Spring数据连接管理](#9、Spring数据连接管理)
* [10、Spring缓存机制](#10、Spring缓存机制)
* [11、Spring自带的定时任务](#11、Spring自带的定时任务)
* [12、Spring集合的注入](#12、Spring集合的注入)
* [13、Spring表单标签库](#13、Spring表单标签库)
* [14、classpath与classpath*](#14、classpath与classpath*)
* [15、分布式架构中session一致性问题](#15、分布式架构中session一致性问题)

<a name="1、Spring简介"></a>
### 1、Spring简介 ###

	Spring是轻量级的容器框架【非侵入式】，横跨各个层。
	它可以管理web层、业务层、dao层、持久层，该Spring可以创建配置各个层的组件【bean】，并且维护各个 bean 之间的关系。

	bean 是Java中的任何一种对象（javabean/service/action/数据源/dao），即被Spring 容器实例化并管理的 Java 对象。

> spring的核心
	
	IOC (控制反转 inverse of control)
		
		即把创建对象bean和维护对象bean的关系的控制行为从程序转移到Spring的容器【applicationContext.xml】来管理。
		由Spring的容器控制管理创建对象(Bean)，和维护对象(Bean)的关系，不再由程序管理维护。

		当某个java实例(调用者)需要调用另一个java实例(被调用者)时，传统情况下，通过调用者来创建被调用者的实例，通常通过 new 来创建，而在依赖注入 的模式下创建被调用者的工作不再由调用者来完成，因此称之为"控制反转"；

	DI (依赖注入  dependency injection)
		
		实际上DI和IOC是同一个概念，spring设计者认为DI更准确的表示Spring的核心。

		即让调用类对被调用类的依赖关系由第三方注入，以移除调用类对该实现类的依赖。

		创建被调用者实例的工作通常由Spring来完成，然后将实例化完成的被调用这实例注入到调用者，所以也称之为"依赖注入"。

	使用DI和接口编程，修改spring的配置文件，可以实现减少web层和业务层的耦合度。
	【注】学spring就是学配置，主要在配置文件中实现功能。

> Spring各jar包详解
	
|jar包|说明|
|:--|:--|
|spring-beans | 是所有应用都要用到的，它包含访问配置文件、创建和管理bean 以及进行Inversion ofControl / Dependency Injection（IoC/DI）操作相关的所有类|
|spring-context | 为Spring 核心提供了大量扩展。可以找到使用Spring ApplicationContext特性时所需的全部类，JDNI 所需的全部类，instrumentation组件以及校验Validation 方面的相关类|
|spring-context-support | 包含支持缓存Cache（ehcache）、JCA、JMX、 邮件服务（Java Mail、COS Mail）、任务计划Scheduling（Timer、Quartz）方面的类|
|spring-core | 包含Spring 框架基本的核心工具类,需要外部依赖Commons Logging|
|spring-tx | 提供的一致的声明式和编程式事务管理支持|
|spring-web | 包含Web 应用开发时，用到Spring 框架时所需的核心类|
|spring-webmvc | 包含Spring MVC 框架相关的所有类。包括框架的Servlets，Web MVC框架，控制器和视图支持|
|spring-test | 对Junit等测试框架的简单封装|
|spring-jdbc | 包含对Spring 对JDBC 数据访问进行封装的所有类|
|spring-aop | 包含在应用中使用Spring 的AOP 特性时所需的类和源码级元数据支持|
|spring-aspects | 提供对AspectJ的支持，以便可以方便的将面向方面的功能集成进IDE中，比如Eclipse AJDT|
|spring-jms | 提供了对JMS 1.0.2/1.1的支持类|
|spring-messaging|为集成messaging api和消息协议提供支持|
|spring-oxm | Spring 对Object/XMl的映射支持,可以让Java与XML之间来回切换|
|spring-orm | 包含Spring对DAO特性集进行了扩展|
|spring-expression | Spring表达式语言|
|spring-instrument | Spring3.0对服务器的代理接口|


<a name="2、Spring开发流程"></a>
### 2、Spring开发流程 ###

> 2.1、引入spring的jar包，及日志包 common-logging.jar【spring-core包默认依赖这个日志框架】，也可以使用其他日志，但需要转换
	
	<!--Spring 核心包-->
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-core</artifactId>
      <version>4.3.11.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-beans</artifactId>
      <version>4.3.11.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-tx</artifactId>
      <version>4.3.11.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-context</artifactId>
      <version>4.3.11.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-aop</artifactId>
      <version>4.3.11.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-web</artifactId>
      <version>4.3.11.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-test</artifactId>
      <version>4.3.11.RELEASE</version>
    </dependency>

> 2.2、创建spring的一个核心文件 applicationContext.xml
	
	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
	       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	       xmlns:p="http://www.springframework.org/schema/p"
	       xmlns:context="http://www.springframework.org/schema/context"
	       xmlns:tx="http://www.springframework.org/schema/tx"
	       xmlns:aop="http://www.springframework.org/schema/aop"
	       xsi:schemaLocation="
	        http://www.springframework.org/schema/beans
	        http://www.springframework.org/schema/beans/spring-beans.xsd
	        http://www.springframework.org/schema/context
	        http://www.springframework.org/schema/context/spring-context.xsd
	        http://www.springframework.org/schema/tx
	        http://www.springframework.org/schema/tx/spring-tx.xsd
	        http://www.springframework.org/schema/aop 
	        http://www.springframework.org/schema/aop/spring-aop.xsd">

		<!-- 在容器文件中配置bean -->
		<bean id="userbean" class="com.hdc.model.userbean">
			<!-- 属性注入 -->
			<property name="name" value="kevin"/>
			<!-- 调用了 id="sayBye"的bean-->
			<property name="saybye" ref="sayBye"></property> 
		</bean>
		
		<bean id="sayBye" class="com.hdc.model.sayBye"/>
	</beans>
		
> bean元素的作用：

	当spring框架加载的时候，spring就会自动的创建一个单例的bean，并实例化对象。
	bean中的id是唯一的，在容器中注入参数值，可以通过ref关联各个bean。

> 2.3、获取 spring的applicationContext对象（IOC 容器对象）
	
	ClassPathXmlApplicationContext("applicationContext.xml");	//通过类路径加载配置文件
	执行这个语句的时候就加载Spring，并生成Spring容器，同时applicationContext.xml中配置的bean就会被创建【通过Java的反射机制写入内存】（在内存中[HaspMap/HashTable]）。
	当需要使用某个bean时可以使用 getBean(id) 即可。
	
> 例子
		
	import org.springframework.context.ApplicationContext;
	import org.springframework.context.support.ClassPathXmlApplicationContext;
	
	public class applicationContextUtil {
	
		private static ApplicationContext ac=null;
		
		private applicationContextUtil(){}
		
		static{
			//得到spring的容器对象,从类路径中加载
			ac=new ClassPathXmlApplicationContext("applicationContext.xml");
		}
		
		//提供返回ApplicationContext的方法
		public static ApplicationContext getApplicationContext(){
			return ac;
		}	
	}

> 获得 xml 配置文件中的Bean的方法【使用接口来访问Bean】
	
	1. 使用应用上下文【ApplicationContext 接口】获取
	
		应用上下文(applicationContext)在启动后预载入【创建】所有单例bean，这样可确保应用不需要等待他们被创建。

		ApplicationContext ac = new ClassPathXmlApplicationContext("com/hdc/ioc/bean.xml");

		ApplicationContext 接口继承了 BeanFactory 接口。

	2. 使用bean工厂【BeanFactory 接口】
		
		工厂设计模式，创建各种bean。
		配置好它们之间的协作关系，参与bean的生命周期。

		只是实例化该容器，bean工厂只把bean的定义信息载进来并没有实例化bean对象，用到的时候才实例化bean，类似于懒加载。

		BeanFactory beanfactory = new XmlBeanFactory(new ClassPathResource("com/hdc/ioc/bean.xml"));
		//使用getBean某个bean时，才会实例化bean，就会创建一个bean
		beanfactory.getBean("student");

	比较
		1. 如果使用ApplicationContext【应用上下文】 ，则配置的bean如果是 singleton不管你用不用，都被实例化。(好处就是可以预先加载，缺点就是耗内存)
		2. 如果是 BeanFactory【bean工厂】，则当你获取beanfacotry时候，配置的bean不会被马上实例化，当你使用的时候，才被实例。(好处节约内存，缺点就是速度)
		3. 规定: 一般没有特殊要求，应当使用 ApplicatioContext 完成。

> 获得应用上下文【ApplicationContext】
	
	1. 通过类加载【常用】
		ApplicationContext ac = new ClassPathXmlApplicationContext("com/hdc/ioc/bean.xml");

	2. 通过文件系统加载【绝对路径】
		ApplicationContext ac = new FileSystemXmlApplicationContext("G:\\Java\\Workspaces\\MyEclipse Professional 2014\\spring1\\src\\com\\hdc\\ioc\\bean.xml");

	3. 从web系统中加载
		XmlWebApplicationContext();

> XML特殊标签
	
	<![CDATA[特殊字符]]>
	作用：让 XML 解析器将标签中的字符串作为普通的文本对待，避免特殊字符对XML 格式造成破坏
	处理特殊字符x的方法
		1、使用 <![CDATA[x]]> 封装；
		2、使用 XML 转义序列表示这个特殊字符
	特殊字符 -- 转义序列
		<  --  &lt;
		>  --  &gt;
		&  --  &amp;
		"  --  &quot;
		'  --  &apos;

<a name="3、Spring的Bean"></a>
### 3、Spring的Bean ###

> 3.1、Bean作用域
	
	1. singleton
		在每个Spring IoC容器中一个bean定义对应一个对象实例。
	
	2. prototype
		一个bean定义对应多个对象实例。
	
	3. request
		在一次HTTP请求中，一个bean定义对应一个实例；
		即每次HTTP请求将会有各自的bean实例，它们依据某个bean定义创建而成
		该作用域仅在基于web的Spring ApplicationContext情形下有效。
	
	4. session
		在一个HTTP Session中，一个bean定义对应一个实例。
		该作用域仅在基于web的Spring ApplicationContext情形下有效
	
	5. global session
		在一个全局的HTTP Session中，一个bean定义对应一个实例。
		该作用域仅在基于web的Spring ApplicationContext情形下有效。

> 3.2、bean的生命周期【完整版】
	
	1、实例化【当我们程序加载bean.xml文件时】
	
	2、调用set()方法设置属性值
		
	3、若你实现了bean名字关注接口[BeanNameAware]，则可以通过setBeanName()获得bean的id名
		
	4、若你实现了bean工厂关注接口[BeanFactoryAware],则可以通过setBeanFactory()获得bean工厂对象
		
	5、若你实现了应用上下文关注接口[ApplicationContextAware]，则可以通过setApplicationContext()获得应用上下文对象
		
	6、若bean和一个后置处理器关联，则会自动执行postProcessBeforeInitialization方法
		
	7、若使用<bean/>元素中的'init-method'定义了初始化方法，则可以调用自定义的初始化方法
		
	8、若bean和一个后置处理器关联，则会自动执行postProcessAfterInitialization方法
		
	9、执行你的bean方法
		
	10、容器关闭
		
	11、若使用<bean/>元素中的'destroy-method'定义了注销方法，则可以调用自定义的注销方法

	【注意】：
	bean在bean工厂的生命周期和在应用上下文的生命周期是不一样的。在bean工厂的生命周期中没有第5个。


> bean 的生命周期【实际开发中常用】：

	1、通过构造器或者是工厂方法创建对象【实例化】；

	2、调用set()方法将属性值进行注入；

	3、若关联后置处理器【BeanPostProcessor】，则会自动执行 前置初始化postProcessBeforeInitialization(Object bean, String beanName) 方法；

	4、若<bean/>元素中的【init-method】定义了初始化方法，则可以调用自定义的初始化方法；

	5、若关联后置处理器，则会自动执行 后置初始化 postProcessAfterInitialization(Object bean, String beanName) 方法；

	6、执行bean方法；

	7、容器关闭，若使用<bean/>元素中的【destroy-method】定义了注销方法，则可以调用自定义的注销方法。

> 例子--静态工厂方法及实例工厂方法配置bean

	/**
	 * bean的生命周期
	 */
	package com.hdc.beanlife;
	
	import org.springframework.beans.BeansException;
	import org.springframework.beans.factory.BeanFactory;
	import org.springframework.beans.factory.BeanFactoryAware;
	import org.springframework.beans.factory.BeanNameAware;
	import org.springframework.context.ApplicationContext;
	import org.springframework.context.ApplicationContextAware;
	
	public class lifeServer implements BeanNameAware,BeanFactoryAware,ApplicationContextAware{
	
		private String name;
	
		public String getName() {
			return name;
		}
	
		public void setName(String name) {
			this.name = name;
		}
		
		//实例化就会生成构造函数
		public lifeServer(){
			System.out.println("lifeServer实例化");
		}
		
		public void sayHi(){
			System.out.println("hi "+getName());
		}
	
		//该方法可以传送[args0]正在被实例化的bean的id名
		@Override
		public void setBeanName(String arg0) {
			System.out.println(arg0+" 被调用");
		}
	
		//该方法可以传递beanFactory对象
		@Override
		public void setBeanFactory(BeanFactory arg0) throws BeansException {
			System.out.println("setBeanFactory "+arg0);
		}
	
		//该方法传递ApplicationContext对象
		@Override
		public void setApplicationContext(ApplicationContext arg0)
				throws BeansException {
			System.out.println("setApplicationContext "+arg0);
		}
		
		//定义自己的初始化
		public void init(){
			System.out.println("调用自己的init");
		}
		
		//定义自己的注销方法
		public void mydestroy(){
			System.out.println("调用自己的mydestroy");
		}	
	}
	
	/*
	 * 自己的后置处理器,只需在xml里配置，就会被所有的类所自动调用，类似filter
	 */
	package com.hdc.beanlife;
	
	import org.springframework.beans.BeansException;
	
	public class MyBeanPostProcessor implements org.springframework.beans.factory.config.BeanPostProcessor{
	
		@Override
		public Object postProcessAfterInitialization(Object arg0, String arg1)
				throws BeansException {
			System.out.println("postProcessAfterInitialization被调用");
			return arg0;
		}
	
		@Override
		public Object postProcessBeforeInitialization(Object arg0, String arg1)
				throws BeansException {
			System.out.println("postProcessBeforeInitialization被调用");
			return arg0;
		}
	
	}
	
	
	<bean id="lifeServer" init-method="init" destroy-method="mydestroy" class="com.hdc.beanlife.lifeServer">
		<!-- 这是是注入参数，前提是有setXxx方法 -->
		<property name="name" value="kevin"></property>
	</bean>
	
	<!-- 配置自己的后置处理器（类似filter） -->
	<bean id="MyBeanPostProcessor" class="com.hdc.beanlife.MyBeanPostProcessor"></bean>
		
	public static void main(String[] args) {
			
			ApplicationContext ac=new ClassPathXmlApplicationContext("com/hdc/beanlife/bean.xml");
			lifeServer ls=(lifeServer) ac.getBean("lifeServer");
			ls.sayHi();
		}

	结果【程序执行顺序】：
		lifeServer实例化
		lifeServer 被调用
		setBeanFactory org.springframework.beans.factory.support.DefaultListableBeanFactory@4ac68d3e: defining beans [lifeServer,MyBeanPostProcessor]; root of factory hierarchy
		setApplicationContext org.springframework.context.support.ClassPathXmlApplicationContext@1d56ce6a: display name [org.springframework.context.support.ClassPathXmlApplicationContext@1d56ce6a]; startup date [Fri Aug 04 15:02:32 CST 2017]; root of context hierarchy
		postProcessBeforeInitialization被调用
		调用自己的init
		postProcessAfterInitialization被调用
		hi kevin

> 3.3、Bean注入  
> 3.3.1、属性注入
		
	Spring 先调用 Bean 的默认构造函数并实例化 Bean 对象，然后通过反射的方式调用 Setter 方法注入属性值。
	所以 POJO类 必须 提供一个默认的构造函数(无参函数)，并为属性提供一个setter 方法。
	【注意】Spring 配置文件的 bean的属性名对应的是 setXxx 后面的 Xxx，而不是java 类的属性名。
	SetName(value)
	<property name="name" value="kevin"/>

	1. 通过set方法注入值 -- 给集合类型注入值。
		
		java中主要的集合有几种: map、set、list、数组 ；
		注入时可以使用集合类型的值【list<object>、map<string,object>、set<object>】
		
		给 list 注入值，list中可以有相同对象；
		给 set 注入值 ，set中不可以有相同对象，相同则覆盖；
		给 map 注入值，map中key不相同就装配value，相同则覆盖 。
		
		<ref> 元素通过下面3个属性引用容器中的其他 Bean 
			1.1. bean：	可以引用同一容器或父容器中的 Bean；
			1.2. local:	只能引用同一培训文件中定义的 Bean；
			1.3. parent:	引用父容器中的 Bean。	<ref parent="">

	比如：
	<?xml version="1.0" encoding="utf-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xmlns:context="http://www.springframework.org/schema/context"
			xmlns:tx="http://www.springframework.org/schema/tx"
			xsi:schemaLocation="http://www.springframework.org/schema/beans 
			http://www.springframework.org/schema/beans/spring-beans-2.5.xsd
			http://www.springframework.org/schema/context 
			http://www.springframework.org/schema/context/spring-context-2.5.xsd
			http://www.springframework.org/schema/tx 
			http://www.springframework.org/schema/tx/spring-tx-2.5.xsd">
	
		<bean id="class" class="com.hdc.collection.Class">
		
			<!-- 给属性注入值 -->
			<property name="className" value="中文班"/>
		
			<!-- 给数组注入值 -->
			<property name="stuName">
				<list>
					<value>kevin</value>
					<value>alex</value>
					<value>sam</value>
				</list>
			</property>
			
			<!-- 给list注入值，list中可以有相同对象 -->
			<property name="stuList" >
				<list>
					<ref bean="student1" />
					<ref bean="student2"/>
					<ref bean="student2"/>
					<ref bean="student1"/>
				</list>
			</property>
			
			<!-- 给set注入值 ，set中不可以有相同对象，相同则覆盖-->
			<property name="stuSet">
				<set>
					<ref bean="student1"/>
					<ref bean="student2"/>
					<ref bean="student2"/>
					<ref bean="student1"/>
				</set>
			</property>
			
			<!-- 给map注入值,map中key不相同就装配value，相同则覆盖 
				Map 元素的键值可以是任何类型的对象
				简单的常量可以使用 key-value; 引用bean 则使用 key-ref/value-ref 
			-->
			<property name="stuMap">
				<map>
					<entry key="1" value-ref="student1" />
					<entry key="2" value-ref="student2" />
					<entry key-ref="keyBean" value-ref="student2" />
					<entry key="4" value="ken" />
				</map>
			</property>
			
		</bean>
	
		<!--内部bean【类似内部类】,只被自己引用 -->
		<bean id="foo" class="....Foo">
			<property name="属性">
			<!--第一方法引用-->
			<ref bean="bean对象名"/>
			<!--内部bean-->
			<bean class="">
				<property/>
			</bean>
			<properyt></property>
		</bean>

	</beans>

> 3.3.2、通过构造函数注入值【前提：Bean提供一个带参的构造函数】
	
	通过索引值和类型确定属性名，不需要为每个属性提供 Setter 方法。

	<bean id="student" class="com.hdc.constructor.Student">
		<!-- 通过构造函数来注入属性值 -->
		<constructor-arg index="0" type="java.lang.String" value="kevin"/>
		<constructor-arg index="1" type="int" value="20"/>
	</bean>

> 3.3.3、注入Null 值

	若使用 
	<property name="degree" >
		<value></value>
	</property>
	Spring 会将 <value></value> 解析为空字符串。
	
	必须使用 <null/>元素标签，才可以为 Bean 的字符串或者其他对象类型的属性注入 null 值。
	<property name="degree" >
		<null/>
	</property>

> 3.3.4、继承注入【继承并重写】

	public class Student 
	public class Gradate extends Student

	<!-- 配置一个学生对象 -->
	<bean id="student" class="com.hdc.Student">
		<property name="name" value="Kevin" />
		<property name="age" value="30"/>
		<property name="favorites">
			<set>
				<value>看书</value>
				<value>游泳</value>
				<value>打篮球</value>
			</set>
		</property>
	</bean>

	<!-- 配置Grdate对象 ，继承student-->
	<bean id="grdate" parent="student" class="com.hdc.Gradate">

		<!-- 如果自己配置属性name,age,则会替换从父对象继承的数据  -->
		<property name="name" value="alex"/>
		<property name="degree" value="学士"/>
		<property name="favorites">
			<set merge="true">
				<value>爬山</value>
				<value>旅游</value>
			</set>
		</property>
	</bean>

	merge="true" 属性表示 子<bean>,父<bean> 中的同名属性值进行合并，即最终子<bean> 的 "favorites"有5个值。
	merge="false" 即不合并，子<bean>的 "favorites"只有2个值【不合并父bean的同名属性】。
		
	在父<bean>中指定 abstract="true" ，即表示该<bean> 不实例化为一个对应的 <Bean>，只作为一个bean 模板。

> 3.3.5、自动注入 Bean

	使用注解 @Resource 或 @Autowired 。

	1. 共同点
	
		@Resource 和 @Autowired 都是做Bean的注入时使用；
		两者都可以写在字段和setter方法上。
		两者如果都写在字段上，那么就不需要再写setter方法。
		通过@Autowired 或 @Resource 为 Bean 的成员变量、方法入参或构造函数入参提供自动注入的功能。

	2. 不同点
	
		2.1. @Autowired
	
		@Autowired(required=false)，即Spring若找不到匹配的Bean完成注入也不要抛出异常。
	
		@Autowired 为Spring提供的注解，需要导入包org.springframework.beans.factory.annotation.Autowired;
	
		public class TestServiceImpl {
		    // 下面两种@Autowired只要使用一种即可
		    @Autowired
		    private UserDao userDao; // 用于字段上
		    
		    @Autowired
		    public void setUserDao(UserDao userDao) { // 用于属性的方法上
		        this.userDao = userDao;
		    }
		}
	
		@Autowired 注解是按照类型（byType）装配依赖对象，默认情况下它要求依赖对象必须存在。
		如果允许null值，可以设置它的 required 属性为false。
		如果我们想使用按照名称（byName）来装配，可以结合 @Qualifier 注解一起使用。如下：
	
		public class TestServiceImpl {
		    @Autowired
		    @Qualifier("userDao")
		    private UserDao userDao; 
		}
	
	
		2.2. @Resource
	
		@Resource 并不是Spring的注解，它的包是javax.annotation.Resource，需要导入，但是Spring支持该注解的注入。
		@Resource 默认按照 ByName自动注入，由J2EE提供，需要导入包javax.annotation.Resource。
		@Resource 有两个重要的属性：name 和 type，而Spring将 @Resource 注解的name属性解析为Bean的名字，而type属性则解析为Bean的类型。
		如果使用 name属性，则使用 byName的自动注入策略；
		如果使用 type属性，则使用 byType自动注入策略；
		如果既不制定name也不制定type属性，这时将通过反射机制使用byName自动注入策略。
	
	
		public class TestServiceImpl {
		    // 下面两种@Resource只要使用一种即可
		    @Resource(name="userDao")
		    private UserDao userDao; // 用于字段上
		    
		    @Resource(name="userDao")
		    public void setUserDao(UserDao userDao) { // 用于属性的setter方法上
		        this.userDao = userDao;
		    }
		}
	
	【注】最好是将@Resource放在setter方法上，因为这样更符合面向对象的思想，通过set、get去操作属性，而不是直接去操作属性。

	@Resource的作用相当于@Autowired，只不过@Autowired按照byType自动注入。

> 将属性文件注册为Bean

	<bean id="sysProperties" class="org.springframework.beans.factory.config.PropertiesFactoryBean">
        <property name="location" value="classpath:conf/config-properties/system.properties"/>
        <property name="fileEncoding" value="UTF-8"/>
    </bean>

	访问
	@Autowired
	private Properties sysProperties;

	// 获取属性文件的值
	sysProperties.getProperty("xxx")

#### Spring 容器成功启动的三大要件: ####

	Bean定义信息、Bean实现类、Spring本身。
	采用基于 XML 配置：Bean定义信息、Bean实现类是分开的；
	采用基于 注解 配置：Bean定义信息通过在 Bean实现类上标注注解实现。
	
> 3.4、Bean 的定义【三种方法】

	1. 基于xml 配置文件定义；
	2. 基于注解定义：
		1. 在类中标注 @Component、@Repository、@Service、@Controller；【其他3个注解都标注了 @Component 】
		2. 或者在类中标注  @Configuration【该类就相当于 xml 配置文件】，在类方法中标注 @Bean 即相当于定义了一个Bean。

> 3.4.1、使用注解定义 Bean

	@Component("user")
	public class User{...}
	
	等效于 XML 配置：
	<bean id="user" class="com.hdc.entity.User">
	
	【作用】在声明处被标注的类会被Spring容器识别，并自动将该类 转换为容器管理的 Bean。
	
	@Component:		用于对 POJO 类进行标注
	@Repository:	用于对 DAO 实现类进行标注
	@Service:		用于对 Service 实现类进行标注
	@Controller:	用于对 Controller 实现类进行标注
	
	@Configuration 、@Bean
	任何POJO 标注了 @Configuration 注解后就可以为Spring 容器提供 Bean的定义信息；
	在类方法中标注了 @Bean 相当于定义了一个 Bean，同时还提供了Bean实例化的逻辑。

> 3.5、获取运行时Bean的信息

	  实现以下三个接口：
	  BeanNameAware:			知道自己的名字。
	  BeanFactoryAware：			知道所处的bean工厂。
	  ApplicationContextAware：	知道所在的应用上下文。

<a name="4、XML配置选项"></a>
### 4、XML配置选项 ###

> 4.1、简化 XML 配置：

	使用 P 命名空间  
		xmlns:p="http://www.springframework.org/schema/p"
		由于 p 命名空间中的属性名是可变的，所以没有对应的 Schema定义文件。
		即无需在 xsi:schemaLocation 为 p 命名空间指定 Schema定义文件。
		
	使用格式：
		p:<属性名>="xxx"
		p:<属性名>-ref="xxx"
		
	即省略了<property>
	<bean id="user" class="com.hdc.domain.User" p:salary="20000"/>

> 4.2、导入properties 文件

	<context:property-placeholder location="classpath:com/hdc/dispatch/db.properties"/>

	<!-- 引入多个properties文件 ，使用逗号隔开-->
	<context:property-placeholder location="classpath:com/hdc/dispatch/db.properties,classpath:com/hdc/dispatch/db2.properties"/>

	在配置Bean对象时，使用 ${}占位符号读取properties文件数据。

> 4.3、导入其他XML配置文件

	<import resource="xxx.xml">
	使用 <import> 组合多个外部的配置文件，resource 指定资源路径。

> 4.4、自动扫描包【控制扫描的粒度】

	<context:component-scan base-package=""/>

	Spring会去自动扫描 base-package对应的路径或者该路径的子包下面的java文件，如果扫描到文件中带有@Service, @Component, @Repository, @Controller等这些注解的类，则把这些类注册为Bean，同时完成 bean 的注入。

	如果配置了<context:component-scan>那么<context:annotation-config/>标签就可以不用在xml中再配置了，因为前者包含了后者。
	另外<context:annotation-config/>还提供了两个子标签 <context:include-filter>和 <context:exclude-filter>。

	<context:component-scan> 
		有两个属性：
    		1. base-package:			告诉Spring要扫描的包；
    		2. use-default-filters： 	表示是否使用默认的过滤器，默认值为true。
    				默认会扫描指定包下标有 @Service, @Component, @Repository, @Controller的注解的全部类，并注册成bean。

		有两个子标签：
    		<context:include-filter>: 可以指定需要扫描的路径来扫描这些文件；
			<context:exclude-filter>: 可以指定不需要扫描的路径来排除扫描这些文件。

		由于use-dafault-filters的值默认为true，所以使用子标签的使用需要修改为false，即使用自定义的过滤器。
		子标签中都有两个属性：
			1. type: 		过滤表达式的类型；
			2. expression：	具体过滤表达式，指定需要过滤的类。

> 例子：
	
	<context:component-scan base-package="com.hdc" use-default-filters="false">

        <!--过滤正则表达式，扫描包下的所有包含 service 的包名下的所有类-->
        <context:include-filter type="regex" expression=".*.service.*"/>

		<!--过滤正则表达式，扫描包下的所有类名包含 Service 的类-->
		<!--<context:include-filter type="regex" expression=".*.Service"/>-->

    </context:component-scan>


|过滤器类型|表达式|描述|
|:-       |:-   |:-  |		
|annotation | org.example.SomeAnnotation |	符合SomeAnnoation的target class |
|assignable | org.example.SomeClass	| 指定class或interface的全名 |
|aspectj | org.example..*Service+ |	AspectJ语法 |
|regex | org\\.example\\.Default.* | 正则表达式 |
|custom	| org.example.MyTypeFilter | Spring3新增自订Type，实作org.springframework.core.type.TypeFilter |

    【注意】regex在正则里面 . 表示所有字符，而 \. 才表示真正的 . 字符【 .*  表达任意多个任意字符】。

<a name="5、SpEL表达式"></a>
### 5、SpEL表达式 ###

- 格式：#{ }   
- 语法 类似 EL 表达式  
- 可以使用 逻辑运算符【and, or, not】、算术运算符、比较运算符、三元运算符【? :】、正则表达式。  

> 作用：
		
	1. 通过 bean 的 id 对bean进行引用
			
		<bean class="com.hdc.collection.Classes">
			<property  name="student" value=#{student1} />
		</bean>
		 #{bean_id}  等效于 ref=bean_id

	2. 获取对象中的属性以及调用其对应的方法

		<bean id="student1" class="com.hdc.collection.Student">
			<property  name="name" value="kevin"/>
			<property name="age" value="22"/>
		</bean>

		<bean id="student2" class="com.hdc.collection.Student">
			<!--  调用方法 -->
			<property name="name" value=#{student1.name.toUpperCase()}/>
			<!--  获取对象属性 -->
			<property name="age" value=#{student1.age}/>
		</bean>

<a name="6、面向切面编程【AOP】"></a>
### 6、面向切面编程【AOP】 ###

> 6.1、AOP定义:
	
	AOP( aspect oriented programming ) 面向切面编程，是对所有对象或者是一类对象编程。
	核心是【在不增加代码的基础上，还增加新功能】将经常使用的重复使用的单独提出来，做成系统化的切面。

> 6.2、AOP术语：

	1. 切面【Aspect】：横切关注点，跨越多个类别的关注点的模块化。如日志记录，事务管理。
					在Spring AOP中，使用常规类（基于模式的方法）或使用@Aspect注释（@AspectJ样式）注释的常规类来实现方面。
	
	2. 通知【Advice】：AOP框架在特定的切入点执行的切面工作【强化程序处理】，通知有around、before和After等类型。
					如在日志通知包含了实现日志功能的代码，如向日志文件写日志。
					通知在连接点被织入到应用程序中。
					许多AOP框架将通知建模为拦截器，在连接点周围维护一系列拦截器。
	
	3. 目标对象：被通知【代理】的对象。既可以是你编写的类也可以是第三方类。
	
	4. AOP代理：AOP框架将通知应用到目标对象后创建的对象，简单的说，代理就是对目标对象的通知。
	
	5. 连接点【Joinpoint】:程序执行过程中可以织入通知的地点【静态概念】，例如方法的执行或异常的处理。
					在Spring AOP中，连接点始终表示执行的方法。
	
	6. 切入点【Pointcut】：可以织入通知的连接点【动态概念】，通知可以应用到AOP框架支持的任何连接点。
					当某个连接点匹配切入点表达式时，该连接点就被认为是切入点，即将被添加通知，执行具有特定名称的方法。
					Spring默认使用AspectJ切入点表达式语言。
					
	7. 引入：代表类型声明其他方法或字段。将方法添加到被处理的类中，Spring允许引入新的接口到任何被处理的对象。
	
	8. 织入【Weaving】：将通知应用到目标对象中，并创建一个被通知【代理】对象的过程。
		织入发生在目标对象生命周期的多个点上：
            编译期【AspectJ】：通知可以在目标对象编译时织入，这需要一个特殊的编译器；
            类装载期：通知可以在目标对象被载入JVM时织入，这需要一个特殊的类载入器；
            运行期【JDK、CGLIB】：通知可以在应用系统运行时织入。

> 6.3、AOP步骤:
	
	1. 定义接口【普通业务组件】
	2. 定义对象【目标对象】
	3. 定义通知【AOP框架为普通业务组件织入的处理动作， 前置通知目标方法调用前调用】
	4. 在beans.xml文件配置
		4.1. 配置 目标对象
		4.2. 配置 通知
		4.3. 配置 代理对象是 ProxyFactoryBean的对象实例
			4.3.1. 代理接口集 
			4.3.2. 织入通知
			4.3.3. 配置被代理对象	
	
> 6.4、使用 Aspect 注解配置AOP：

	1. 创建一个切面类，使用 @Aspect 标注；JoinPoint: 接口类型，连接点类型；

	2. 抽取出可重用业务的方法【切面方法】，并标注指定的通知；

	3. 通知类型：前置通知、后置通知、返回通知、异常通知、环绕通知；

		@Before("execution(切入点表达式)")
		@After("execution(切入点表达式)")
		@AfterReturning(pointcut="execution(表达式)",returning="返回值变量名")
		@AfterThrowing(pointcut="execution(表达式)",throwing="异常变量名")
		@Around("execution(切入点表达式)")

	4. 配置Spring 配置文件，加入如下标签，使标注了 @Aspect 注解的类进行自动生成代理的工作；
	
		<aop:aspectj-autoproxy/>

	5. 使用 注解 @Component 可以使 Spring 管理切面类和接口实现类。


		/**
	     * 返回通知
	     * 在返回值通知中获取方法执行之后的返回值
	     * 被标注通知的方法参数列表中，指定一个形参名字必须和 returning 指定的变量名一致；
	     * 可以指定具体类型，也可以使用Object
	     */
	    @AfterReturning(value = "getPointCut()", returning = "result")
	    public void AfterReturning(JoinPoint joinPoint, Object result){
	        Object[] args = joinPoint.getArgs();
	        String methodName = joinPoint.getSignature().getName();
	        System.out.println("在调用"+methodName+"方法后,参数是:"+ Arrays.asList(args)+"，结果是："+result);
	    }


		/**
	     * 异常通知
	     * 获取异常信息
	     * 异常通知的形参名必须和 throwing 指定的变量名一致
	     * 形参的类型可以使用具体的异常类型，也可以使用超类 Exception
	     */
	    @AfterThrowing(value ="getPointCut()", throwing = "exception")
	    public void AfterThrowing(JoinPoint joinPoint, Exception exception){
	        Object[] args = joinPoint.getArgs();
	        String methodName = joinPoint.getSignature().getName();
	        System.out.println("在调用"+methodName+"方法后,参数是:"+ Arrays.asList(args)+"异常信息："+exception);
	    }


> 6.5、切入点表达式：

	用于匹配执行方法的连接点，即在哪里织入通知	

	execution(* com.spring.model.service..*.*(..))
  	
	   	第一个 * 代表任意返回值类型/修饰符，
	   	第二个 * 代表service下的任意类，
	   	第三个 * 代表任意方法，
	   	第一个 .. 代表需要拦截的包名，后面的两个句点表示当前包和当前包的所有子包，cn.smd.service.impl包、子孙包下所有类的方法。
	   	第二个 .. 代表拦截任意数量的方法参数。

	 1. execution(* springlibs.service.*.*(..)) 	
		 表示 springlibs.service包下所有的类跟所有的方法；

	 2. execution(* springlibs.service..*(..)) 	
		 表示 springlibs.service当前包和当前包的所有子包下所有的方法；

	 3. execution(* springlibs.service.*.save*(..)) 	
		 表示 springlibs.service 下所有的以 save 开头的方法；

	 4. execution(public * springlibs.service.*.*(..))
	 	表示 springlibs.service 下所有的公共方法;

	 5. execution(public int springlibs.service.*.*(..))
	 	表示 springlibs.service 下所有的返回值为int 类型的公共方法;

	 6. expression="execution(* com.spring.service+.*(..))" 
		+ 表示包括service 的子类

> 6.6、设置切面的优先级：
	
	方法1：使用注解 @Order(n) 标注切面类的优先级；n-->优先级数字,数字越小，优先级越高；

	方法2：实现接口 Ordered ，使用接口的方法 getOrder() 的返回值设定优先级；返回值越小，优先级越高；


> 6.7、重用切面表达式：
	
	1. 创建可重用的切面表达式方法，使用注解 @Pointcut(切面表达式)，该方法的方法体是空的，无需加入业务方法：

		@Pointcut("execution(public * com.spring.aspect.ArithmeticImpl.*(..))")
    	public void getPointCut(){}

	2. 在通知方法上标注
		@Before("getPointCut()")
		@After("getPointCut()")  
		@AfterReturning(value = "getPointCut()",returning = "result")
		@AfterThrowing(value ="getPointCut()",throwing = "exception")
		即可。

> 组合切入点表达式：

	Spring支持3中逻辑运算符来组合切入点表达式：

		&&：要求连接点同时匹配两个切入点表达式；

		||：只要连接点匹配任意一个切入点表达式；

		！：要求连接点不匹配指定切入点表达式。

> 6.8、基于XML 配置AOP：

	所有的切面、切入点和增强处理都必须定义在 <aop:config../>元素内部。
	<beans../>元素下可以包含多个 <aop:config../>元素。
	一个<aop:config../> 可以包含多个 pointcut、advisor 和 aspect元素，且这3个元素必须按照此顺序类定义。

	1. 配置切入点

		使用 <aop:pointcut ../> 元素定义切入点，同时定义该切入点的切入表达式。

		<aop:config>
		    <aop:pointcut id="a" expression="切入点表达式"/>
			...
		</aop:config>

	2. 配置切面

		使用 <aop:aspect ../> 元素定义切面，作用就是将一个已有的Spring Bean转换成切面Bean。
		因为切面Bean可以当成一个普通的SpringBean来配置，所以可以为该切面Bean配置依赖注入。

		配置<aop:aspect ../>元素时可以指定如下3个属性：
			id：		定义该切面的标识名；
			ref：	指定以指定ref所引用的的普通Bean作为切面Bean。
			order：	指定该切面Bean的优先等级，数字越小，等级越大。

		<aop:config>
		    <aop:pointcut id="a" expression="切入表达式"/>
		    <aop:aspect id="c" order=1 ref="引用的类的实例bean">
		        // 通知
		    </aop:aspect>
		</aop:config>

	3. 配置通知【增强处理】
	
		<aop:before .../>			前置通知
		<aop:after ../>				后置通知
		<aop:after-returning .../>	返回通知
		<aop:after-throwing ../>	异常通知
		<aop:around .../>			环绕通知

		上面的元素不能配置子元素，但可以配置如下属性：

		pointcut：		该属性指定一个切入点表达式，Spring将在匹配该表达式的连接点时织入通知。

		pointcut-ref：	该属性指定一个已经存在的切入点的名称，通常 pointcut与pointcut-ref 只需要使用其中的一个。

		method：			该属性指定一个方法名，指定切面Bean的该方法将作为通知。

		throwing：		该属性只对<aop:after-throwing../>起作用，用于指定一个形参名，afterThrowing通知方法可以通过该形参访问目标方法所抛出的异常。

		returning：		该属性只对<aop:after-returning.../>起作用，用于指定一个形参名，afterReturning通知方法可以通过该形参访问目标方法的返回值。
    
		当定义切入点表达式时，XML文件支持组合切入点表达式，但XML配置方式不再使用简单的&&、||、！作为组合运算符，而是使用 and(相当于&&)、or(||)和not(!)。
	
		<aop:config>
		    <aop:pointcut id="a" expression="切入表达式"/>
		    <aop:aspect  ref="引用的类的实例bean">

		        <aop:before method="方法名" pointcut-ref="a"/>
		        <aop:after method="方法名" pointcut-ref="a"/>

		    </aop:aspect>
		</aop:config>

	比如：
	<aop:config>
		<aop:pointcut id="pointCut" expression="execution(public * com.spring.aspect.ArithmeticImpl.*(..))"/>
		<aop:aspect ref="myAspect">
		    <aop:before method="methodBefore" pointcut-ref="pointCut"/>
		    <aop:after method="methodAfter" pointcut-ref="pointCut"/>
		</aop:aspect>
	</aop:config>

> expose-proxy

	作用：
		当前代理是否为可暴露状态，值是"ture"，则为可访问。

	<aop:config expose-proxy="true">
		...
	</aop:config> 

> proxy-target-class

	作用：
		强调 Spring 应该使用何种代理方式：JDK 和 CGLIB。
		默认使用JDK动态代理，强制使用CGLIB代理时需要将 proxy-target-class设置为 true。

	<aop:config proxy-target-class="true" >
		...
	</aop:config> 

> spring的 AOP 中，当你通知代理对象去实现aop的时候，获得的ProxyFactoryBean是什么类型？
	
	返回的是一个代理对象，若目标对象实现了接口，则spring使用 JDK动态代理技术；
	若目标对象没有实现接口，则spring使用 CGLIB库技术。

<a name="7、Spring事务管理"></a>
### 7、Spring事务管理 ###

- Spring 使用 ThreadLocal 解决事务管理多线程的问题。

> Spring支持的事务策略：

	JavaEE应用程序的传统事务有两种策略：

	1. 全局事务：
		全局事务由应用服务器管理，需要底层的服务器的JTA支持。

	2. 局部事务：
		局部事务和底层采用的持久化技术有关。
		当采用JDBC持久化技术时，需要采用Connection对象来操作事务；
		而采用Hibernate持久化技术时，需要使用session操作事务。

> Spring事务策略是通过 PlatformTransactionManager接口体现的，该接口是Spring事务策略的核心。

	public interface PlatformTransactionManager {

	    TransactionStatus getTransaction(TransactionDefinition var1) throws TransactionException;
	
	    void commit(TransactionStatus var1) throws TransactionException;
	
	    void rollback(TransactionStatus var1) throws TransactionException;
	}

	Spring本身没有任何事务支持，它只是负责包装底层的事务。
	当我们在程序中面向 PlatformTransactionManager 接口编程时，Spring在底层负责将这些操作转换成具体的事务操作代码。
	所以应用底层支持什么样的事务策略，Spring就支持什么样的事务策略。
	Spring事务管理的优势是将应用从具体的事务API中 分离出来，而不是真正提供事务管理的底层实现。

> Spring的具体的事务管理由 PlatformTransactionManager 的不同实现类来完成，在Spring容器中配置PlatformTransactionManager时必须针对不同的环境提供不同的实现类。

	<!-- 配置JDBC数据源的局部事务管理器，使用DataSourceTransactionManager 类 -->
	<!-- 该类实现PlatformTransactionManager接口，是针对采用数据源连接的特定实现-->
	<bean id="transactionManager" 
	        class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
       
		<property name="dataSource" ref="dataSource"/>
	</bean>

	<!--使用JtaTransactionManager类，该类实现PlatformTransactionManager接口-->
	<!--针对采用全局事务管理的特定实现-->
	<bean id="transactionManager" class="org.springframework.transaction.jta.JtaTransactionManager"/>

	
> 事务的实现分两种：

	1. 编程式事务实现；
		1.1. 通过模板化的操作一致性的管理事务。

	2. 声明式事务。
		2.1. 基于 注解 的方式；
		2.2. 使用 AOP 进行事务管理。
		
> 需要引入命名空间：xmlns:tx="http://www.springframework.org/schema/tx"  
> Spring中的事务的实现：

	要求低侵入式的编程模式：将通用服务与业务逻辑分离出来，将事务从业务逻辑中分离。

> 7.1、编程式事务实现【事务管理的粒度更细】：

	方法一：
		通过 TransactionTemplate 类【模板化】来完成，该类提供了一个execute方法来处理事务，可以更简洁的方式来进行事务操作。
		该类拥有 PlatformTransactionManager 属性。

	1. 注册 TransactionTemplate

		<bean id="transactionManager"
          class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
        <property name="dataSource" ref="dataSource"/>
	    </bean>
	
	    <bean id="transactionTemplate"
	          class="org.springframework.transaction.support.TransactionTemplate">
	        <property name="transactionManager">
	            <ref bean="transactionManager"/>
	        </property>
	    </bean>

	2. 将TransactionTemplate注入到业务层方法中, 并使用
		@Autowired
		TransactionTemplate transactionTemplate;

		使用 TransactionTemplate 的 execute(TransactionCallback<T> action)方法对业务代码单独进行事务管理，不对引入的第三方接口进行事务管理。

		由源码可知，真正执行业务方法的关键代码是: action.doInTransaction(status);

		public interface TransactionCallback<T> {

			T doInTransaction(TransactionStatus status);
		}

		在 execute 方法中匿名内部调用，将需要进行事务处理的业务代码放在 doInTransaction中


	3. 在需要添加事务的方法上标注 @Transactional(propagation= Propagation.NEVER)
		表示不进行事务传播【仅标注该方法为事务方法，避免其他事务方法调用该方法时传递事务】，由方法中的事务方法 execute 处理事务。

	编程式事务只针对 某段代码进行事务管理，而不是针对整个方法。
	调用第三方的方法时不要添加事务，避免由于网络的延迟造成线程的耗尽，所以需要使用编程式事务来处理。

	方法二：

		可以直接获取容器中的 TransactionManager Bean，该Bean总是PlatformTransactionManager的实例，可以通过该接口提供的3个方法来开始事务，提交事务和回滚事务。

> 7.2、声明式事务管理【基于注解的方式】  
> 配置事务管理器

	<!-- 1、配置事务管理器，统一配置 sessionFactory的事务-->
	<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
        <property name="dataSource" ref="dataSource"/>
    </bean>
	
	<!--2、声明式事务，支持事务注解的【@Transactional】-->
	<tx:annotation-driven transaction-manager="transactionManager" />

	transaction-manager属性：指定使用哪个事务管理器，
	 
	默认情况下 <tx:annotation-driven> 会自动使用名为 "transactionManager" 的事务管理器。
	所以，如果用户的事务管理器的 id="transactionManager",则配置可以简化为<tx:annotation-driven/>。
	 
	<tx:annotation-driven> 还有另外两个属性：
		1. proxy-target-class:	为 true ，则spring将通过创建子类来代理业务类；为 false，则使用基于接口的代理【默认】。
			使用子类代理，需要在类路径添加 CGLIB 库。
		2. order: 当织入多个切面时，可以控制事务切面在目标连接点的织入顺序。
	
	
> 使用注解配置声明式事务【业务实现类上】
	
	1. 在需要事务管理的类或者方法进行标注 @Transactional。
	2. 可以在 @Transactional 中添加事务的传播特性、隔离级别、是否只读、事务回滚。
	@Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.DEFAULT,readOnly = false)
	 
	事务会对性能产生影响，所以使用范围越小越好，最好将 @Transactional 标注在方法上。

> 7.3、配置事务管理【使用AOP 进行事务管理】
		
	aop的命名空间：
		xmlns:aop="http://www.springframework.org/schema/aop"  
		xsi:schemaLocation="http://www.springframework.org/schema/aop
		http://www.springframework.org/schema/aop/spring-aop-xsd"


	<!--配置事务通知 -->
	<tx:advice id="txAdvice" transaction-manager="transactionManager">
		<!--事务属性定义 -->
	    <tx:attributes>

			<!--定义事务的传播特性、隔离级别、是否只读、事务回滚 -->
	      <tx:method name="save*" propagation="REQUIRED" rollback-for="Exception"/>
	      <tx:method name="del*" propagation="REQUIRED" rollback-for="Exception"/>
	      <tx:method name="update*" propagation="REQUIRED" rollback-for="Exception"/>
	      <tx:method name="add*" propagation="REQUIRED" rollback-for="Exception"/>
	      <tx:method name="find*" propagation="REQUIRED"/>
	      <tx:method name="get*" read-only="true"/>
	      <tx:method name="apply*" propagation="REQUIRED"/>

	    </tx:attributes>
	</tx:advice>

	<!--配置事务切面，将事务通知织入 -->
	<aop:config>

		<!-- 定义事务增强的切入点 -->
		<aop:pointcut id="allTestServiceMethod" expression="execution(* com.spring.model.service.*.*(..))"/>
		
		<!-- 将 事务通知和切入点 进行关联-->
		<aop:advisor pointcut-ref="allTestServiceMethod" advice-ref="txAdvice" />

	</aop:config>

> 需要注意的地方:

	1. advice（建议）的命名：由于每个模块都会有自己的Advice，所以在命名上需要作出规范，初步的构想就是模块名+Advice（只是一种命名规范）。

	2. tx:attribute 所配置的是作为事务的方法的命名类型。

		如<tx:method name="save*" propagation="REQUIRED"/>

		其中*为通配符，即代表以save为开头的所有方法，即表示符合此命名规则的方法作为一个事务。

	3. aop:pointcut 配置参与事务的类。
		
		由于是在Service中进行数据库业务操作，配的应该是包含那些作为事务的方法的Service类。
		aop 通过切点表达式语言就可以对业务Bean 进行定位。

	4. aop:advisor 将 事务通知和切入点 进行关联整合起来作为整个事务管理。

> 事务属性：
	
	1. 事务隔离：当前事务和其他事务的隔离程度。
	2. 事务传播：
	3. 事务超时：事务在超时前能运行多久，超过时间后，事务被回滚。
	4. 只读状态：只读事务不修改任何数据，可以提高运行性能。

> Spring中常用事务传播类型：

|传播类型|说明|
|:-|:-|
|PROPAGATION_REQUIRED | 支持当前事务，如果当前没有事务，就新建一个事务【这是最常见的选择】|
|PROPAGATION_SUPPORTS | 支持当前事务，如果当前没有事务，就以非事务方式执行|
|PROPAGATION_MANDATORY | 支持当前事务，如果当前没有事务，就抛出异常|
|PROPAGATION_REQUIRES_NEW | 新建事务，如果当前存在事务，把当前事务挂起|
|PROPAGATION_NOT_SUPPORTED | 以非事务方式执行操作，如果当前存在事务，就把当前事务挂起|
|PROPAGATION_NEVER | 以非事务方式执行，不进行事务传播，如果当前存在事务，则抛出异常|
|PROPAGATION_NESTED | 如果当前存在事务，则在嵌套事务内执行；如果当前没有事务，则进行与PROPAGATION_REQUIRED类似的操作|
	
> Spring中<tx:method> 元素属性【只有 name 是必需的】

|属性|默认值|说明|
|:-|:-|:-|
|name | 与事务属性关联的方法名 | get* 等，可以使用通配符（*）|			
|propagation | REQUIRED | 事务传播行为 |
|isolation | DEFAULT| 事务隔离级别|
|timeout |-1 | 事务超时时间(s)|
|read-only | false | 事务是否只读|
|rollback-for | 所有运行期异常回滚 | 触发事务回滚的Exception,可以设置多个，逗号隔开，如：IOException,SqlException|
|no-rollback-for | 所有检查型异常不回滚 | 不触发事务回滚的Exception,可以设置多个，逗号隔开|
	
	spring 默认的事务管理策略(PROPAGATION_REQUIRED, read only)

	即 @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT, readOnly = false)
	 
> 不能被 Spring AOP事务增强的方法：
	
	1. 基于接口的动态代理：除 public 外的其他所有方法，包括 public static；
	2. 基于 CGLIB 的动态代理：private,static,final。
	 
	这些方法不能启动事务，但并非就不工作在事务环境下。
	外层环境的事务上下文依然可以传播给这些方法，只是这些方法不能主动的启动事务。
	这些方法被无事务上下文的方法调用，则它们就工作在无事务上下文中；
	反之，这些方法被有事务上下文的方法调用，则它们就工作在事务上下文中。

> Spring实现对**分布式事务**的支持：

	默认的Spring事务只支持单数据源，而实际上一个系统往往需要写多个数据源，即使用分布式事务组件：Atomikos。

> atomikos 多数据源配置【可以是mysql, orcle, db2】

	<bean id="dataDataSource" class="com.atomikos.jdbc.AtomikosDataSourceBean"
          init-method="init" destroy-method="close">

        <!--唯一数据源库名-->
        <property name="uniqueResourceName" value="db_ilearning_data"/>

        <!--数据源驱动-->
        <property name="xaDataSourceClassName"
                  value="com.mysql.jdbc.jdbc2.optional.MysqlXADataSource"/>

         <!--数据源连接属性-->
        <property name="xaProperties">
            <props>
                <prop key="url">${data.jdbc.url}</prop>
                <prop key="user">${data.jdbc.username}</prop>
                <prop key="password">${data.jdbc.password}</prop>
            </props>
        </property>

        <!--私有属性-->
        <property name="minPoolSize" value="5" />
        <property name="maxPoolSize" value="100" />
        <property name="borrowConnectionTimeout" value="30" />
        <property name="testQuery" value="select 1" />
        <property name="maintenanceInterval" value="60" />
    </bean>

> atomikos 分布式事务

    <bean id="atomikosTransactionManager"
          class="com.atomikos.icatch.jta.UserTransactionManager"
          init-method="init" destroy-method="close">
        <property name="forceShutdown" value="false"/>
    </bean>

    <bean id="atomikosUserTransaction" class="com.atomikos.icatch.jta.UserTransactionImp">
        <property name="transactionTimeout" value="300"/>
    </bean>

    <bean id="transactionManager" class="org.springframework.transaction.jta.JtaTransactionManager">
        <property name="transactionManager" ref="atomikosTransactionManager"/>
        <property name="userTransaction" ref="atomikosUserTransaction"/>
        <property name="globalRollbackOnParticipationFailure" value="false"/>
    </bean>


<a name="8、Spring单元测试"></a>
### 8、Spring单元测试 ###
	
> spring 项目就可以使用Spring 的单元测试，可以自动注入我们需要的组件。

	1. 导入spring-test 模块；
	
	2. @RunWith：这个是指定使用的单元测试执行类；
		@RunWith(SpringJUnit4ClassRunner.class)

	3. @ContextConfiguration 可以指定加载spring配置文件的位置。
		@ContextConfiguration(locations={"classpath:config/spring-mybatis.xml"})

> 例子

	package com.ssm.tool;

	import java.util.UUID;
	import org.apache.ibatis.session.SqlSession;
	import org.junit.Test;
	import org.junit.runner.RunWith;
	import org.springframework.beans.factory.annotation.Autowired;
	import org.springframework.test.context.ContextConfiguration;
	import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
	import com.ssm.dao.DepartmentMapper;
	import com.ssm.dao.EmployeeMapper;
	import com.ssm.entity.Department;
	import com.ssm.entity.Employee;
	
	@RunWith(SpringJUnit4ClassRunner.class)
	@ContextConfiguration(locations={"classpath:config/spring-mybatis.xml"})
	public class MapperTest {
	
		@Autowired
		private EmployeeMapper employeeMapper;
		@Autowired
		private DepartmentMapper deptMapper;
		
		@Autowired
		private SqlSession sqlSession;
		
		@Test
		public void testCRUD(){
			//1、插入部门
			deptMapper.insertSelective(new Department(null,"开发部"));
			deptMapper.insertSelective(new Department(null,"测试部"));
			deptMapper.insertSelective(new Department(null,"运维部"));
			
			//2、插入员工，带部门信息
			//employeeMapper.insertSelective(new Employee(null,"alex","M","@163.com",1));
			
			//批量插入
			EmployeeMapper eMapper = sqlSession.getMapper(EmployeeMapper.class);
			for(int i=0;i<1000;i++)
			{
				String username = UUID.randomUUID().toString().substring(0,5)+i;
				String gender = i%2==0? "M":"F";
				eMapper.insertSelective(new Employee(null,username,gender,username+"@163.com",1));
			}
			System.out.println("插入完成");
		}
	}

<a name="9、Spring数据连接管理"></a>
### 9、Spring数据连接管理 ###

> 数据连接泄露：

	从数据源直接获取连接，且使用完后不主动归还给数据源【关闭连接】，就会造成数据连接泄露，数据连接泄露会导致数据连接资源耗尽而崩溃。
	
	使用Spring 管控的数据连接，则数据连接从数据源获取到返回数据源都被Spring 管控，使用者就无需关心数据源的连接、释放。

> 获取spring 管控的数据连接：
	
	1. 使用数据资源获取工具类【DataSourceUtils、JdbcTemplate、HibernateTemplate、Mybatis】；
	2. 对数据源进行代理【如 Hibernate 的 SessionFactory】。
	 
	 尽量使用 JdbcTemplate,HibernateTemplate 等模板进行数据访问操作，避免直接获取数据连接的操作。它们已经集成了获取连接及释放连接的模式化流程。

> 使用 Mybatis 的dao接口  
> 使用 JdbcTemplate 
	
	在dao 中注入 JdbcTemplate，在Spring配置文件定义JdbcTemplate的Bean。
	
	<context:component-scan base-package="com.hdc"/>
     	<context:property-placeholder location="classpath:jdbc.properties"/>
     
	<bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource" destroy-method="close"
	     	p:driverClassName="${jdbc.driverClass}"
	     	p:url="${jdbc.Url}"
	     	p:username="${jdbc.username}"
	     	p:password="${jdbc.password}"/>

	<bean id="jdbcTemplate" class="org.springframework.jdbc.core.JdbcTemplate"
		p:dataSource-ref="dataSource"/>

		
	更新数据：
		update(String sql);
		update(String sql,Object[],int[]);
			sql为带？占位符的sql语句，Object[]填充占位符的参数数组，int[] 为定义参数的类型，使用 Types 定义。
		update(String sql,PreparedStatementSetter pss);
			PreparedStatementSetter 为回调函数，其中有 void setValues(PreparedStatement ps) 接口方法。
			使用sql语句创建 PreparedStatement 实例后，将可以调用该回调函数执行绑定参数的操作。
			PreparedStatement 绑定参数时，参数索引从1开始。
			
	批量更改数据
	
	jdbcTemplate.batchUpdate( String sql,BatchPreparedStatementSetter bpss){}
	
	BatchPreparedStatementSetter 定义了两个方法：
		int getBatchSize()	指定本批次的大小
		void setValues(PreparedStatement ps, int index)	为给定的 PreparedStatement 绑定参数。
		
	BatchPreparedStatementSetter 是一次性批量提交数据。
	 
	使用 RowCallbackHandler接口 处理结果集，匿名内部类实现这些回调接口。
	该接口只有一个方法：void processRow(ResultSet result) 
	
	 jdbcTemplate.query(sql, params, new RowCallbackHandler() {     
			@Override    
			public void processRow(ResultSet rs) throws SQLException {     
				User user  = new User();  
				user.setId(rs.getInt("id"));  
				user.setUsername(rs.getString("username"));  
				user.setPassword(rs.getString("password"));    
			}     
		});   
	);
	 
	 spring会遍历结果集，对结果集中的每一行都调用 RowCallbackHandler 回调接口处理数据。
	 无须调用 ResultSet 的next方法，只需要定义好如何获取结果集数据的逻辑即可。
	 
	 RowCallbackHandler 和 RowMapper 比较：
		RowMapper 的操作方法是先获取数据，然后在处理数据，采用批量化数据处理；
		RowCallbackHandler 是一边获取一边处理，处理完就丢弃，采用流化处理。
	 
	 JdbcTemplate 使用大量的回调接口完成数据的访问操作，一般都是通过匿名内部类实现这些回调接口。
	 
> 数据层主键  
> 应用层主键：使用数据库的序列或表产生主键值。  
> 使用 HibernateTemplate

	HibernateTemplate 提供了非常多的常用方法来完成基本的操作，比如增加、删除、修改及查询等操作:

	delete(Object entity): 删除指定持久化实例。

	deleteAll(Collection entities): 删除集合内全部持久化类实例。

	find(String queryString): 根据 HQL 查询字符串来返回实例集合。

		模糊查询：this.getHibernateTemplate().find("from bean.User u where u.name like ?", "%test%");
	
	findByNamedQuery(String queryName): 根据命名查询返回实例集合。
	
	load或get(Classentity Class,Serializable id): 根据主键加载特定持久化类的实例。

	loadAll(Classentity);	返回结果集
	
	save(Object entity): 保存新的实例。
	
	saveOrUpdate(Object entity): 根据实例状态，选择保存或者更新。

	update(Object entity): 更新实例的状态，要求entity 是持久状态。

	setMaxResults(intmax Results): 设置分页的大小。

	bulkUpdate提供了批量删除和更新，直接转换为相应的update/delete SQL进行批量删除和更新
	

> HibernateDaoSupport【抽象类】的使用

	在接口的实现类上继承 HibernateDaoSupport，使用 this.getHibernateTemplate().save(user);

	简化 HibernateTemplate 的配置，改用 HibernateDaoSupport
	它是一个抽象类，该类里可以直接调用 HibernateTemplate 对象。

	<bean id="hibernateDaoSupport" class="org.springframework.orm.hibernate4.support.HibernateDaoSupport"
	    	abstract="true"
    		p:sessionFactory-ref="sessionFactory"></bean>
		
	报错：
	Caused by: java.lang.IllegalArgumentException: 'sessionFactory' or 'hibernateTemplate' is required

	说明 HibernateDaoSupport 没有注入sessionFactory

	看HibernateDaoSupport的源代码得知：setSessionFactory方法是：
	
	public final void setSessionFactory(SessionFactory sessionFactory) {
	  if (this.hibernateTemplate == null || sessionFactory != this.hibernateTemplate.getSessionFactory()) {
	   this.hibernateTemplate = createHibernateTemplate(sessionFactory);
	  }
	 }

	不能通过注解的方式注入，只能调用 super.setSessionFactory(sessionFactory) 设置 sessionFactory。
 
	//重写sessionFactory
	@Autowired
	private void setMySessionFactory(SessionFactory sessionFactory){
		super.setSessionFactory(sessionFactory);
	}


<a name="10、Spring缓存机制"></a>
### 10、Spring缓存机制 ###

> Spring 提供的4个注解来声明缓存规则：

	1. @Cacheable
		Spring 在调用被标注的方法前，首先会去缓存中查找方法的返回值。
		若找到，就会返回缓存的值；否则，该方法就会被调用，并将返回值放入缓存中。

	2. @CachePut
		Spring 将方法的返回值放入缓存中。即执行方法前并不会去检查缓存，方法始终会被调用。

	3. @CacheEvict
		Spring 在缓存中清除一个或多个缓存数据。

	4. @Caching
		这是一个分组的注解，能够同时应用多个其他的缓存注解。

	缓存注解可以标注在类、方法、接口上，只是应用的范围不一样。

	@Cacheable、@CachePut 标注的方法需要有返回值；
	@CacheEvict 标注的方法可以有返回值，也可以为 void。

	@Cacheable、@CachePut 的共同属性：

		value ： 	String[] 类型，表示要使用的缓存名称；
		key：		String 类型，用来计算自定义的缓存key;
		condition：	String 类型，SpEL 表达式，得到的值为false，则该方法的缓存被禁止使用；
		unless：		String 类型，SpEL 表达式，得到的值为true，返回值不会放到缓存中。

	unless、condition条件属性:
		共同点：
			接收一个 SpEL 表达式，根据返回结果判断是否使用缓存。
			unless:  	SpEL 表达式计算结果为 true，那么缓存方法返回的数据就不会被放入缓存中；
			condition: 	SpEL 表达式计算结果为 false，那么这个方法的缓存就被禁止使用。

		不同点：
			unless 属性只能阻止将对象放入缓存中，但是该缓存的方法被调用时，依然会去缓存中查找数据，若有数据也会返回。
			condition 属性 是不会去缓存中查找，也不会将对象放入缓存。

> 默认的缓存 key:

		默认的缓存 key  要基于方法的参数来确定。 
		若被标注的方法的参数只有一个，则该参数就是 缓存key。

> 自定义缓存key：

		SpEL扩展：

		#root.args：传递给缓存方法的参数，形式为数组
		#root.caches：该方法执行是所对应的缓存，形式为数组
		#root.target：目标对象
		#root.targetClass：目标对象的类
		#root.method：缓存方法
		#root.methodName：缓存方法的名称
		#result：方法调用的返回值【不能用在 @Cacheable注解上】
		#argName：任意的方法参数名【id】或者参数索引

		@CachePut(value="cache",key="#result.id")
		@CachePut(value="cache",key="#id")


> spring-ehcache.xml 配置

	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
	       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	       xmlns:context="http://www.springframework.org/schema/context"
	       xmlns:cache="http://www.springframework.org/schema/cache"
	       xsi:schemaLocation="http://www.springframework.org/schema/beans
	       http://www.springframework.org/schema/beans/spring-beans.xsd 
	       http://www.springframework.org/schema/context 
	       http://www.springframework.org/schema/context/spring-context.xsd
	       http://www.springframework.org/schema/cache 
	       http://www.springframework.org/schema/cache/spring-cache.xsd">
	
	    <context:component-scan base-package="com.hdc.cache"/>
	
	    <!-- 配置EhCache的CacheManager,通过configLocation指定ehcache.xml文件的位置 -->
	    <bean id="ehCacheManager" class="org.springframework.cache.ehcache.EhCacheManagerFactoryBean">
	        <property name="configLocation" value="classpath:ehcache.xml"/>
	        <property name="shared" value="false"/>
	    </bean>
	
	    <!-- 配置基于EhCache的缓存管理器,并将EhCache的CacheManager注入该缓存管理器Bean -->
	    <bean id="cacheManager" class="org.springframework.cache.ehcache.EhCacheCacheManager">
	        <property name="cacheManager" ref="ehCacheManager"/>
	    </bean>
	
	    <!--cache-manager 默认是 cacheManager-->
	    <cache:annotation-driven/>
	
	</beans>

> ehcache.xml 配置：

	<?xml version="1.0" encoding="UTF-8"?>
	<ehcache>
	    <diskStore path="java.io.tmpdir" />
	         <!-- 配置默认的缓存区 -->
	         <defaultCache
	             maxElementsInMemory="10000"
	             eternal="false"
	             timeToIdleSeconds="120"
	             timeToLiveSeconds="120"
	             maxElementsOnDisk="10000000"
	             diskExpiryThreadIntervalSeconds="120"
	             memoryStoreEvictionPolicy="LRU"/>

	         <!-- 配置名为users的缓存区 -->
	         <cache name="users"
	                maxBytesLocalHeap="50m"
	                timeToIdleSeconds="300"
	                timeToLiveSeconds="600" />
	</ehcache>


> ehcache 元素的属性：

        name：缓存名称

        maxElementsInMemory：内存中最大缓存对象数

        maxElementsOnDisk：硬盘中最大缓存对象数，若是0表示无穷大

        maxBytesLocalHeap：最大的堆储存容量。

        eternal：true表示对象永不过期，此时会忽略timeToIdleSeconds和timeToLiveSeconds属性，默认为false

        overflowToDisk：true表示当内存缓存的对象数目达到了

        maxElementsInMemory界限后，会把溢出的对象写到硬盘缓存中。注意：如果缓存的对象要写入到硬盘中的话，则该对象必须实现了Serializable接口才行。

        diskSpoolBufferSizeMB：磁盘缓存区大小，默认为30MB。每个Cache都应该有自己的一个缓存区。

        diskPersistent：是否缓存虚拟机重启期数据，是否持久化磁盘缓存,当这个属性的值为true时,系统在初始化时会在磁盘中查找文件名为cache名称,后缀名为index的文件，这个文件中存放了已经持久化在磁盘中的cache的index,找到后会把cache加载到内存，要想把cache真正持久化到磁盘,写程序时注意执行net.sf.ehcache.Cache.put(Element element)后要调用flush()方法。

        diskExpiryThreadIntervalSeconds：磁盘失效线程运行时间间隔，默认为120秒

        timeToIdleSeconds： 设定允许对象处于空闲状态的最长时间，以秒为单位。当对象自从最近一次被访问后，如果处于空闲状态的时间超过了timeToIdleSeconds属性值，这个对象就会过期，EHCache将把它从缓存中清空。只有当eternal属性为false，该属性才有效。如果该属性值为0，则表示对象可以无限期地处于空闲状态。

        timeToLiveSeconds：设定对象允许存在于缓存中的最长时间，以秒为单位。当对象自从被存放到缓存中后，如果处于缓存中的时间超过了 timeToLiveSeconds属性值，这个对象就会过期，EHCache将把它从缓存中清除。只有当eternal属性为false，该属性才有效。如果该属性值为0，则表示对象可以无限期地存在于缓存中。timeToLiveSeconds必须大于timeToIdleSeconds属性，才有意义

        memoryStoreEvictionPolicy：当达到maxElementsInMemory限制时，Ehcache将会根据指定的策略去清理内存。可选策略有：LRU（最近最少使用，默认策略）、FIFO（先进先出）、LFU（最少访问次数）。

<a name="11、Spring自带的定时任务"></a>
### 11、Spring自带的定时任务 ###
	
> 依赖于 spring-context.jar 包  
> 流程：
		
	1. 在xml里加入task的命名空间；

		xmlns:task="http://www.springframework.org/schema/task" 
		http://www.springframework.org/schema/task
        http://www.springframework.org/schema/task/spring-task.xsd

	2. 启用注解驱动的定时任务；

		<task:annotation-driven scheduler="myScheduler"/>   

	3. 配置定时任务的线程池；

		<task:scheduler id="myScheduler" pool-size="5"/>  

	4. 编写我们的定时任务。

		在类名前 @Component/@Service，在方法上标注 @Scheduled(cron = "0/1 * * * * *") 注解为定时任务，cron表达式里编写执行的定时。


- spring的定时任务默认是单线程，多个任务执行起来时间会有问题（B任务会因为A任务执行起来需要20S而被延后20S执行）；  
- 当我们配置了线程池后再来看结果（多线程下，B任务再也不会因为A任务执行起来要20S而被延后了）。

> cron表达式详解：

	一个cron表达式有至少6个（也可能7个）有空格分隔的时间元素【秒、分、时、日、月、星期、年】，年是可选的。	   
	       秒（0~59）
	       分钟（0~59）
	      小时（0~23）
	      天（0~31）
	      月（0~11）
	      星期（1~7 1=SUN 或 SUN，MON，TUE，WED，THU，FRI，SAT）
	      年份（1970－2099）

	*: 代表所有可能的值。
	/: 用来指定数值的增量，在子表达式（分钟）里的“3/20”表示从第3分钟开始，每20分钟。
    ?: 仅被用于天（月）和天（星期）两个子表达式，表示不指定值，仅作为占位符。
    L: 仅被用于天（月）和天（星期）两个子表达式，它是单词“last”的缩写。
	W：代表着工作日(Mon-Fri)，并且仅能用于日域中。它用来指定离指定日的最近的一个工作日。
	C：代表“Calendar”的意思。它的意思是计划所关联的日期，如果日期没有被关联，则相当于日历中所有日期。
		例如5C在日期字段中就相当于日历5日以后的第一天。1C在星期字段中相当于星期日后的第一天。

> 任务执行器【task:executor】配置详细参数说明：  

	1. pool-size：			可以指定执行线程池的初始大小、最大大小 ；
	2. queue-capacity：		等待执行的任务队列的容量 ；
	3. rejection-policy：	当等待队列爆了时的策略，分为丢弃、由任务执行器直接运行等方式。

	作用：
		Spring的 TaskExecutor 接口等同于java.util.concurrent.Executor接口。
		支持线程池操作。
		支持异步操作使用，使用 @Async 注解。

	实际上，它存在的主要原因是为了在使用线程池的时候，将对Java 5的依赖抽象出来。 
	这个接口只有一个方法 execute(Runnable task)，它根据线程池的语义和配置，来接受一个执行任务。
	需要使用线程池时，不用再次创建线程池，可以直接从 executor 线程池中获取一个线程来执行，把自己的Runnable类加入到队列中去，TaskExecutor使用它自己的内置规则来决定何时应该执行任务。

	@Component
	public class TaskDemo {

	    @Resource
	    Executor executor;

	    //基于注解的定时任务
	    @Scheduled(cron = "0/1 * * * * *")
	    public void test(){
	        for (int i = 0; i < 10; i++) {
	            executor.execute(new Runnable() {
	                @Override
	                public void run() {
	                    Calendar calendar = Calendar.getInstance();
	                    System.out.println(Thread.currentThread().getName());
	                    System.out.println(calendar.getTime()+"测试");
	                }
	            });
	        }
	    }
	}


> 开启异步任务使用方法：

	方法1：使用xml 配置开启异步任务 ；

		1. 在 xml 中开启异步操作支持
		
			<!--异步操作使用，支持 @Async 注解 -->
			<task:executor id="executor" pool-size="5" />
	
		2. 在类/方法上标注 @Async 注解
		
			在Spring中，基于@Async标注的方法，称之为异步方法；
			这些方法将在执行的时候，将会在独立的线程中被执行，调用者无需等待它的完成，即可继续其他的操作。
	
			@Async 注解可以标记一个异步执行的方法，也可以用来标注类，表示类中的所有方法都是异步执行的。
	
		【@Async 说明】
		1. 入参随意，返回值：不要返回值直接void；需要返回值用AsyncResult或者CompletableFuture；
	
		2. 可自定义执行器并指定例如：@Async("otherExecutor")；
			
			如果不指定名字，会使用缺省的“asyncExecutor”

		3. @Async  必须不同类间调用： A类--》B类.C方法()（@Async注释在B类/方法中），如果在同一个类中调用，会变同步执行,例如:A类.B()-->A类.@Async C()。
			原因是：底层实现是代理对注解扫描实现的，B方法上没有注解，没有生成相应的代理类。(当然把@Async加到类上也能解决但所有方法都异步了，一般不这么用！)

	方法2：使用注解配置开启异步任务
		
		1. 在启动类或者配置类上标注 @EnableAsync，表示支持异步操作。
		2. 在方法上标注 @Async 注解


> 配置定时任务时有两种方法

	1. 基于注解的定时任务;

		在配置文件配置定时器驱动注解<task:annotation-driven />，然后在类中需要定时任务的方法中使用注解 @Scheduled(cron = "")来标注即可。

	2. 基于XML的定时任务。

		在xml配置文件中配置需要定时任务的类和方法，以及定时表达式即可。
		<task:scheduled-tasks scheduler="taskScheduler" >
	        <task:scheduled ref="myTaskXml" method="show" cron="0/2 * * * * *" />
	        <task:scheduled ref="myTaskXml" method="print" cron="0/5 * * * * *"/>
	    </task:scheduled-tasks>

> task:scheduled-tasks 内的 task:scheduled 属性：

	ref: 工作类;

	method: 工作类中要执行的方法;

	initial-delay: 任务第一次被调用前的延时，单位毫秒;

	fixed-delay: 上一个调用完成后再次调用的延时;

	fixed-rate: 上一个调用开始后再次调用的延时（不用等待上一次调用完成）;

	cron: 表示在什么时候进行任务调度。

	【说明】
	直接在 xml 中配置需要添加定时任务的类的具体方法，以及执行时间。

> 任务调度器【task:scheduler】的配置详细参数说明：

	pool-size：调度线程池的大小，调度线程在被调度任务完成前不会空闲 ；
	cron：cron表达式，注意，若上次任务未完成，即使到了下一次调度时间，任务也不会重复调度。

	作用：在多线程情况下调度任务的执行。
	【说明】
	可以使用注解 @Scheduled(cron = "0/1 * * * * *") 在需要使用定时任务的方法上标记定时，比较灵活。

> spring-task.xml配置：

	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
	       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	       xmlns:task="http://www.springframework.org/schema/task"
	       xmlns:context="http://www.springframework.org/schema/context"
	       xsi:schemaLocation="http://www.springframework.org/schema/beans
	       http://www.springframework.org/schema/beans/spring-beans.xsd
	        http://www.springframework.org/schema/task
	        http://www.springframework.org/schema/task/spring-task.xsd
	        http://www.springframework.org/schema/context
	        http://www.springframework.org/schema/context/spring-context.xsd">

	    <context:component-scan base-package="com.hdc.task"/>

	    <!--定义线程池，多线程情况下使用-->
	    <task:scheduler id="taskScheduler" pool-size="5"/>

	    <!--需要操作多线程，异步操作时使用，支持 @Async 注解 -->
	    <task:executor id="executor" pool-size="5" queue-capacity="10"/>

	    <!-- 方法一：基于 @Scheduled 注解，启动定时器驱动注解,使用线程池-->
	    <task:annotation-driven scheduler="taskScheduler" executor="executor"/>
	    
	    <!--方法二：基于XML的定时任务,多任务，使用线程池-->
	    <task:scheduled-tasks scheduler="taskScheduler" >
	        <task:scheduled ref="myTaskXml" method="show" cron="0/2 * * * * *" />
	        <task:scheduled ref="myTaskXml" method="print" cron="0/5 * * * * *"/>
	    </task:scheduled-tasks>

	</beans>

> 方法一：基于注解操作定时任务

	import org.springframework.scheduling.annotation.Scheduled;
	import org.springframework.stereotype.Component;

	@Component
	public class TaskDemo {

	    @Scheduled(cron = "0/1 * * * * *")
	    public void test(){
	        System.out.println("测试");
	    }
	}


> 方法二：基于XML 定时任务

	import org.springframework.stereotype.Component;
	import java.util.Calendar;

	@Component("myTaskXml")
	public class MyTaskXml {

	    public void show(){
	        Calendar calendar = Calendar.getInstance();
	        System.out.println(calendar.getTime()+"执行show方法");
	    }

	    public void print(){
	        Calendar calendar = Calendar.getInstance();
	        System.out.println(calendar.getTime()+"执行print方法");
	    }
	}


<a name="12、Spring集合的注入"></a>
### 12、Spring集合的注入 ###

> 使用 Spring-util 完成集合的注入

	将实例注册为bean，再将这些bean 包装成为一个集合bean，方便在其他bean中引入。	

> Spring util命名空间中的元素：

|元素|描述|
|:- |:-|		
|<util:constant> | 引用某个类型public static 域，并将其暴露为bean|
|<util:list> | 创建一个java.util.list类型的bean，其中包含值或者引用|
|<util:map>	| 创建一个java.util.map类型的bean，其中包含值或者引用|
|<util:properties> | 创建一个java.util.properties类型的bean|
|<util:property-path> |	引用一个属性（或内嵌属性），并将其暴露为bean|
|<util:set>	| 创建一个java.util.set类型的bean，其中包含值或者引用|

> 1、constant：该标签用于将指定的静态Field暴露成一个Bean实例。

	属性：
		id：该属性指定将静态Field定义成名为id的Bean实例；
		static-field: 该属性指定将哪个类，哪个静态Field暴露出来。

> 2、property-path:该标签用于将指定Bean实例的指定属性暴露成一个Bean实例。

	属性：
		id：该属性指定将属性定义为名为id的Bean实例；
		path：该属性指定将哪个Bean实例，哪个属性（支持复合属性）暴露出来。

> 3、list：该标签用于定义一个List Bean，支持使用<value.../>,<ref.../><bean.../>等标签来定义List集合元素。

	属性:
		id: 指定定义一个名为id的List Bean实例；
		list-class: 指定Spring使用哪个List实例类来创建Bean实例；
		scope：指定该List Bean实例的作用域。

	比如：
	<util:list id="messagePropertiesList" value-type="java.lang.String">
        <value>classpath:conf/message-properties/messages</value>
        <value>classpath:conf/message-properties/configInfo</value>
        <value>classpath:conf/manage/message-properties/fields/statsQuery</value>
    </util:list>

	<bean id="allMessagePropertiesList" class="com.test.core.util.CompositeList">
        <constructor-arg ref="messagePropertiesList"/>
    </bean>

> 4、set：该标签用于定义一个Set Bean，支持<value.../>,<ref.../><bean.../>等标签来定义Set集合元素。

	属性:
		id: 指定定义一个名为id的Set Bean实例；
		set-class: 指定Spring使用哪个Set实例类来创建Bean实例；
		scope：指定该Set Bean实例的作用域。

> 5、map：该标签用于定义一个Map Bean，支持使用<entry.../>来定义Map的key-value对。

	属性:
		id: 指定定义一个名为id的Map Bean实例；
		map-class: 指定Spring使用哪个map实例类来创建Bean实例；
		scope：指定该map Bean实例的作用域。

> 6、properties：该标签用于加载一份资源文件，并根据加载的资源文件创建一个Properties Bean实例。

	属性：
		id: 指定定义一个名为id的Properties Bean实例；
		location: 指定资文件的位置；
		scope：指定该Properties Bean实例的作用域。

<a name="13、Spring表单标签库"></a>
### 13、Spring表单标签库 ###

> 这些表单标签库捆绑在 spring-webmvc.jar中。  
> 这些标签库的描述符被称为 spring-form.tld。

	<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

> <s:message code=""/>

	根据code【代码参数】从资源包中输出一个字符串，用于国际化。
	<s:message code="system.name"/>  
		
> <s:url value="" />

	在 value 前追加 应用上下文的路径作为前缀。
	<script src="<s:url value="/js/require.js" />"></script> 
		等效于
	<script src="${request.getContextPath()}/js/require.js"></script>

> form:form 标签

	使用Spring的form标签主要有两个作用：
		1. 它会自动的绑定来自Model中的一个属性值到当前form对应的实体对象，可以使用commandName属性或modelAttribute属性指定，这样就可以在form表单里面使用该对象的属性了；
		
		2. 它支持我们在提交表单的时候使用除GET和POST之外的其他方法进行提交，包括DELETE和PUT等。

	<form:form modelAttribute="queryFilter" id="adminForm" name="adminForm" action="${listURL}">

> form:input 标签

	作用: 绑定表单数据。
	input标签会被渲染为一个type为 text 的普通Html input标签。
	input标签在没有指定id的情况下它会自动获取 path指定的属性作为 id和name。

	<form:input path="username"/>
	相当于
	<input id="username" name="username" type="text" />

> form:hidden标签

	hidden标签会被渲染为一个type为hidden的普通Html input标签。
	用法跟input标签一样，也能绑定表单数据，只是它生成的是一个隐藏域。

> form:checkbox标签

	checkbox标签会被渲染为一个type为checkbox的普通HTML input标签。
	checkbox标签也是支持绑定数据的。
	checkbox标签的选中与否状态是根据它绑定的值来判断的。

		1. 绑定一个boolean数据。
		当绑定的是一个boolean数据，那么checkbox的状态跟该boolean数据的状态是一样的，即true对应选中，false对应不选中。
		<form:checkbox path="male"/>

		2. 绑定列表数据【包括数组、List和Set】。
		当checkbox标签的value在我们绑定的列表数据中存在的时候该checkbox将为选中状态。

		<td>  
           <form:checkbox path="roles" value="role1"/>Role1<br/>  
           <form:checkbox path="roles" value="role2"/>Role2<br/>  
           <form:checkbox path="roles" value="role3"/>Role3<br/>   
        </td> 

		当拥有role1的时候对应的<form:checkbox path="roles" value="role1"/>就会为选中状态。
		也就是说roles列表中包含role1的时候该checkbox就会为选中状态。

		3. 绑定一个Object数据
		Spring会将所绑定对象数据的toString结果跟当前checkbox的value进行比较，如果能够进行匹配则该checkbox将为选中状态。

> form:checkboxes标签

	一个checkboxes标签将根据其绑定的数据生成N个复选框。
	checkboxes绑定的数据可以是数组、集合和Map。
	在使用checkboxes时我们有两个属性是必须指定的:
		1. items属性：表示当前要用来展现的项有哪些；
		2. path属性：表示所绑定的表单对象的属性。
	
	当在items所展现的所有选项中，path指定的表单对象中拥有的选项会被设定为选中状态。
	<form:checkboxes path="roles" items="${roleList}"/>

	比如：
		User的roles属性有两个选项：role1,role2;
		roleList中包含3个选项：role1,role2,role3;
		则只有 role1,role2 会被设定为选中状态。

	使用Map作为checkboxes的items属性的数据源时，Key将作为真正的复选框的value，而Map的value将作为Label进行展示。
	绑定的表单对象属性的类型可以是Array、集合和Map，这种情况就是判断items Map中是否含有对应的key来决定当前的复选框是否处于选中状态。
	<form:checkboxes path="roles" items="${roleMap}"/>

> form:select标签  
> form:option标签  
> form:options标签

<a name="14、classpath与classpath*"></a>
### 14、classpath与classpath* ###

> classpath/classpath*:

	首先 classpath是指 WEB-INF文件夹下的classes目录 。

> classes含义： 
	
	1. 存放各种资源配置文件 init.properties、log4j.properties、spring.xml等 ；
	2. 存放模板文件 eg.actionerror.ftl ；
	3. 存放class文件 对应的是项目开发时的src目录编译文件 。
	
	总结：这是一个定位资源的入口 。

> web.xml 配置中classpath 和 classpath* 区别： 

	classpath：只会到你的class路径中查找文件;
	classpath*：不仅包含class路径，还包括jar文件中(class路径)进行查找。

	<param-value>classpath:applicationContext-*.xml</param-value>  
	或者
	<param-value>classpath:context/conf/controller.xml</param-value>  

	classpath*的使用：当项目中有多个classpath路径，并同时加载多个classpath路径下（此种情况多数不会遇到）的文件，*就发挥了作用，如果不加*，则表示仅仅加载第一个classpath路径 。

	<param-value>classpath*:context/conf/controller*.xml</param-value>  

	"**/" 表示的是任意目录； 
	"**/applicationContext-*.xml"  表示任意目录下的以"applicationContext-"开头的XML文件。  
	程序部署到tomcat后，src目录下的配置文件会和class文件一样，自动copy到应用的 WEB-INF/classes目录下 。


	【注意】 
	用classpath*:需要遍历所有的classpath，所以加载速度是很慢的。
	因此，在规划的时候，应该尽可能规划好资源文件所在的路径，尽量避免使用classpath*。

<a name="15、分布式架构中session一致性问题"></a>
### 15、分布式架构中session一致性问题 ###

> Spring Session

	提供了用于管理用户会话信息的API和实现。同时支持集群会话。

	提供的集成：
				
		1. HttpSession 
		
			允许以应用程序容器（即Tomcat）中立的方式替换HttpSession【覆盖 Tomcat 容器原有的 HttpSession 的实现】，支持在 headers 文件中提供 会话ID 以使用 RESTful API。
			同时支持集群会话。
		
		2. WebSocket
		
			提供在接收 WebSocket 消息时保持 HttpSession 存活的能力。
		
		3. WebSession 
			
			允许以应用程序容器中立方式替换Spring WebFlux的WebSession。

	Spring Session 2.X 
		1. 提取SessionRepository实现以分离模块
		2. 改进了Session和SessionRepository API
		3. 为所有支持的会话存储提供改进和协调的配置支持
		4. 添加了使用 SessionCookieConfig 配置默认 CookieSerializer 的支持。

> 在使用HttpSession之前需要添加Servlet过滤器来启用使用 Spring Session 和 HttpSession。

	1. 添加所需的依赖项后，我们可以创建Spring配置。 
	2. Spring配置负责创建一个Servlet过滤器，该过滤器用Spring Session支持的实现替换 HttpSession实现。 	
		<bean class="org.springframework.session.data.redis.config.annotation.web.http.RedisHttpSessionConfiguration"/>
		// redis连接池配置...
	
> Session 集中统一管理：

	使用 spring-session 集成的 HttpSession 将session 统一交给集群 redis 来管理，session的读写都由redis 来完成。
	避免集群中的session 不一致。
	
	在web.xml配置了 spring-session 过滤器，过滤所有的 session 请求；
	只要使用标准的 servlet api 调用session，在底层就会通过 spring-session 得到的，并且会存储到Redis或其他你所选择的数据源中。

	HttpSession数据在Redis中是以 Hash结构存储的。

> pom.xml

	<dependency>
	  <groupId>org.springframework.session</groupId>
	  <artifactId>spring-session-data-redis</artifactId>
	  <version>1.2.1.RELEASE</version>
	</dependency>
	<dependency>
	  <groupId>redis.clients</groupId>
	  <artifactId>jedis</artifactId>
	  <version>2.8.1</version>
	</dependency>

> 1、web.xml 添加 spring-session 过滤器【放在首位】：

	Spring配置创建了一个名为 springSessionRepositoryFilter 的Spring Bean，它实现了Filter。 springSessionRepositoryFilter bean负责将 HttpSession 替换为 Spring Session支持的自定义实现。

	需要确保我们的Servlet容器（即Tomcat）对每个请求都使用 springSessionRepositoryFilter 过滤器。

	DelegatingFilterProxy 将以 springSessionRepositoryFilter 的名称查找Bean并将其强制转换为Filter。 对于调用 DelegatingFilterProxy 的每个请求，将调用 springSessionRepositoryFilter。

	<filter>
	    <filter-name>springSessionRepositoryFilter</filter-name>
	    <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
	</filter>
	<filter-mapping>
	    <filter-name>springSessionRepositoryFilter</filter-name>
	    <url-pattern>/*</url-pattern>
		<dispatcher>REQUEST</dispatcher>
		<dispatcher>ERROR</dispatcher>
	</filter-mapping>

> 2、redis.properties

	spring.redis.cluster.nodes=192.168.1.30:7000,192.168.1.30:7001,192.168.1.30:7002
	# 数据在session中的有效期1800s
	spring.redis.cluster.timeout=1800
	spring.redis.cluster.max-redirects=5

	redis.minIdle=5
	redis.maxIdle=100
	redis.maxTotal=300
	redis.maxWait=1000
	redis.testOnBorrow=true

> 3、spring-redis.xml
		
	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
	       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	       xmlns:context="http://www.springframework.org/schema/context"
	       xsi:schemaLocation="http://www.springframework.org/schema/beans
	       http://www.springframework.org/schema/beans/spring-beans.xsd
	       http://www.springframework.org/schema/context
	       http://www.springframework.org/schema/context/spring-context.xsd">
	
	
	    <!-- 加载数据库属性文件 -->
	    <context:property-placeholder
	            location="classpath:redis.properties" ignore-unresolvable="true" />
	
		<!-- 加载redis属性文件，并将redis 集群中使用到的配置自动加载 -->
	    <bean id="redisPropertySource"
	          class="org.springframework.core.io.support.ResourcePropertySource">
	        <constructor-arg name="resource" value="classpath:redis.properties"/>
	    </bean>
	
		 <!-- 使用spring-session把 HttpSession 放到redis里  -->
    	<bean class="org.springframework.session.data.redis.config.annotation.web.http.RedisHttpSessionConfiguration">
        	<!--redis中session数据最大有效期，默认1800s-->
	        <property name="maxInactiveIntervalInSeconds" value="2000"/>
	    </bean>

		<!--配置 redis集群，加载集群属性-->
	    <bean id="redisClusterConfiguration"
	          class="org.springframework.data.redis.connection.RedisClusterConfiguration">
	        <constructor-arg name="propertySource" ref="redisPropertySource"/>
	    </bean>
	
	    <!--配置 JedisPoolConfig -->
	    <bean id="jedisPoolConfig" class="redis.clients.jedis.JedisPoolConfig">
	        <property name="maxIdle" value="${redis.maxIdle}"/>
	        <property name="minIdle" value="${redis.minIdle}"/>
	        <property name="maxTotal" value="${redis.maxTotal}"/>
	        <property name="maxWaitMillis" value="${redis.maxWait}"/>
	        <property name="testOnBorrow" value="${redis.testOnBorrow}"/>
	    </bean>
	
	    <!--配置 JedisConnectionFactory -->
	    <bean id="jedisConnectionFactory"
	          class="org.springframework.data.redis.connection.jedis.JedisConnectionFactory">
	        <constructor-arg ref="redisClusterConfiguration"/>
	        <constructor-arg ref="jedisPoolConfig"/>
	    </bean>
	
		<!--
	     spring-data-redis的RedisTemplate<K, V>模板类在操作redis时默认使用JdkSerializationRedisSerializer来进行序列化,
	     会使key添加序列化前缀，造成key不一致 ["\xac\xed\x00\x05t\x00\x04name"],
		所以需要添加序列化策略：键采用String 序列化，值采用 jackson
	     -->
	    <bean id="redisTemplate" class="org.springframework.data.redis.core.RedisTemplate">
	        <property name="connectionFactory" ref="jedisConnectionFactory"/>
	        <property name="keySerializer">
	            <bean class="org.springframework.data.redis.serializer.StringRedisSerializer"/>
	        </property>
	        <property name="valueSerializer">
	            <bean class="org.springframework.data.redis.serializer.StringRedisSerializer"/>
	        </property>
	        <property name="hashKeySerializer">
	            <bean class="org.springframework.data.redis.serializer.StringRedisSerializer"/>
	        </property>
	        <property name="hashValueSerializer">
	            <bean class="org.springframework.data.redis.serializer.StringRedisSerializer"/>
	        </property>
	    </bean>
	    

		<!-- StringRedisTemplate 默认使用 StringRedisSerializer进行序列化 -->
	    <bean id="stringRedisTemplate"
	          class="org.springframework.data.redis.core.StringRedisTemplate">
	        <property name="connectionFactory" ref="jedisConnectionFactory"/>
	    </bean>
	
	</beans>


> 4、编写实例

	req.getSession().setAttribute(attributeName, attributeValue);

	session.setAttribute("name","alex");

	spring-session 就会自动将session 的数据以Hash结构保存到redis中，前缀 spring:session: 。
	如下：

	192.168.1.30:7003> hgetall "spring:session:sessions:d11b90e1-05d7-4dff-9e2c-027d2c1f52da"
	1) "sessionAttr:name"
	2) "\xac\xed\x00\x05t\x00\x04alex"
	3) "creationTime"
	4) "\xac\xed\x00\x05sr\x00\x0ejava.lang.Long;\x8b\xe4\x90\xcc\x8f#\xdf\x02\x00\x01J\x00\x05valuexr\x00\x10java.lang.Number\x86\xac\x95\x1d\x0b\x94\xe0\x8b\x02\x00\x00xp\x00\x00\x01b\xad\xc5K\xab"
	5) "maxInactiveInterval"
	6) "\xac\xed\x00\x05sr\x00\x11java.lang.Integer\x12\xe2\xa0\xa4\xf7\x81\x878\x02\x00\x01I\x00\x05valuexr\x00\x10java.lang.Number\x86\xac\x95\x1d\x0b\x94\xe0\x8b\x02\x00\x00xp\x00\x00\x02X"
	7) "lastAccessedTime"
	8) "\xac\xed\x00\x05sr\x00\x0ejava.lang.Long;\x8b\xe4\x90\xcc\x8f#\xdf\x02\x00\x01J\x00\x05valuexr\x00\x10java.lang.Number\x86\xac\x95\x1d\x0b\x94\xe0\x8b\x02\x00\x00xp\x00\x00\x01b\xad\xc5K\xab"


	存放的是序列化后的结果。

> 序列化策略

	spring-data-redis 默认采用的序列化策略有两种：
		1. String 的序列化策略；
		2. JDK 的序列化策略。

    StringRedisTemplate默认采用的是String的序列化策略，保存的key和value都是采用此策略序列化保存的。StringRedisSerializer

    RedisTemplate 默认采用的是JDK的序列化策略，保存的key和value都是采用此策略序列化保存的。JdkSerializationRedisSerializer

	由于因为序列化策略的不同，即使是同一个key用不同的Template去序列化，结果是不同的。
	此时根据key去删除数据的时候就出现了删除失败的问题。
	所以需要统一一种序列化策略。

	spring-data-redis 提供的序列化策略还有：
		GenericJackson2JsonRedisSerializer	使用Jackson2 将对象序列化为 JSON；
	    GenericToStringSerializer   		使用 Spring 转换服务进行序列化；
	    OxmSerializer   



> spring-session 源码分析

	AbstractHttpSessionApplicationInitializer

		注册 springSessionRepositoryFilter

	DelegatingFilterProxy

		initFilterBean()
		doFilter
		invokeDelegate

	SessionRepositoryFilter

		doFilterInternal() 对request/response 的 HttpSession 进行包装 HttpSessionWrapper

	public interface HttpSessionStrategy {

	    String getRequestedSessionId(HttpServletRequest var1);
	
	    void onNewSession(Session var1, HttpServletRequest var2, HttpServletResponse var3);
	
	    void onInvalidateSession(HttpServletRequest var1, HttpServletResponse var2);
	}

	CookieHttpSessionStrategy 实现接口 HttpSessionStrategy
	
		使用cookie 方式处理session

> SessionRepository

	public interface SessionRepository<S extends Session> {

		S createSession();
	
		void save(S session);
	
		S getSession(String id);
	
		void delete(String id);
	}

	SessionRepository 负责创建，检索和持久化Session实例。

> RedisOperationsSessionRepository

	RedisOperationsSessionRepository 实现 SessionRepository 接口

	在redis中处理 session 。
	RedisOperationsSessionRepository 是使用Spring Data的 RedisOperations 实现的SessionRepository。 
	在Web环境中，这通常与 SessionRepositoryFilter 结合使用。 
	该实现通过SessionMessageListener支持SessionDestroyedEvent和SessionCreatedEvent。

> DefaultCookieSerializer		
		
	序列化cookie信息

	# 在 RedisHttpSessionConfiguration 中可以添加属性 cookieSerializer
	<bean id="defaultCookieSerializer" class="org.springframework.session.web.http.DefaultCookieSerializer">
        <property name="domainName" value=".happymmall.com" />
        <property name="useHttpOnlyCookie" value="true" />
        <property name="cookiePath" value="/" />
        <property name="cookieMaxAge" value="31536000" />
    </bean>