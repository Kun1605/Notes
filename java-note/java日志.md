# JAVA日志

* [1、SLF4J](#1、SLF4J)
* [2、log4j](#2、log4j)
* [3、logback](#3、logback)

<a name="1、SLF4J"></a>
### 1、SLF4J ###

- SLF4J简单日记门面(simple logging Facade for Java),为各种loging APIs提供一个简单统一的日志接口。
- slf4j是一个单面日志，并不是日志解决方案，只是服务于其他日志框架(系统)，允许用户在部署时选择不同的日志框架，这样可以实现日志框架的切换。
- 由于每个编写者使用的日志系统有可能不同，可以使用slf4j日志接口来转换到自己的日志系统中，实现不同日志框架的调用。
- 在代码中使用{}作为占位符。
- 需要关联日志实现类来提供日志服务，各个日志框架之间的API通常是不兼容的。

<a name="2、log4j"></a>
### 2、log4j ###

> log4j + slf4j
	
	<!-- 关闭spring-core中的commons-logging，绑定slfj和log4j12 -->
	<dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-core</artifactId>
      <version>${spring.version}</version>
      <exclusions>
        <exclusion>
          <groupId>commons-logging</groupId>
          <artifactId>commons-logging</artifactId>
        </exclusion>
      </exclusions>
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
    <dependency>
      <groupId>log4j</groupId>
      <artifactId>log4j</artifactId>
      <version>1.2.17</version>
    </dependency>

	slf4j-log4j12 这个jar包由于已经依赖了slf4j,log4j,所以不用在添加log4j的依赖了。
	slf4j-log4j12 这个jar包 将对slf4j接口的调用转换为对log4j的调用，不同的日志实现框架，这个转换工具不同。

> log4j.properties路径

	idea会自动去resources目录下查找，myeclipse 会在src下查找。
	属性配置文件要放在上述的位置。

> Log4j的组件

	Log4j由三个重要的组件构成：日志信息的优先级，日志信息的输出目的地，日志信息的输出格式。
	日志信息的优先级
		从高到低有ERROR、WARN、 INFO、DEBUG，分别用来指定这条日志信息的重要程度：
		ERROR 为严重错误 主要是程序的错误
		WARN 为一般警告，比如session丢失
		INFO 为一般要显示的信息，比如登录登出
		DEBUG 为程序的调试信息

	日志信息的输出目的地【appenderName】
		指定了日志将打印到控制台还是文件中
	
	日志信息的输出格式
		控制了日志信息的显示内容

> Log4j基本使用方法
		
	1.配置根Logger

			log4j.rootLogger = [ ...level ]
			log4j.rootLogger=INFO,Console,File  //表示INFO级别 日志信息输出到控制台和文件

	2.配置日志信息输出目的地

			log4j.appender.appenderName = appender.class全限类名
			log4j.appender.appenderName.option1 = value1  
			…  
			log4j.appender.appenderName.option = valueN
			
		2.1.appender.class全限类名选项有：

			org.apache.log4j.ConsoleAppender（控制台）； 
			org.apache.log4j.FileAppender（文件）；
			org.apache.log4j.DailyRollingFileAppender（每天产生一个日志文件）；
			org.apache.log4j.RollingFileAppender（文件大小到达指定尺寸的时候产生一个新的文件）；
			org.apache.log4j.WriterAppender（将日志信息以流格式发送到任意指定的地方）。
				
		2.2.appender.class全限类名各选项参数：

			ConsoleAppender【控制台】
				Threshold=DEBUG:		指定日志消息的输出最低层次。
				ImmediateFlush=true:	默认值是true,意谓着所有的消息都会被立即输出。
				Target=System.err：		默认情况下是：System.out,指定输出控制台

			FileAppender【文件】
				Threshold=DEBUF:		指定日志消息的输出最低层次。
				ImmediateFlush=true:	默认值是true,意谓着所有的消息都会被立即输出。
				File=mylog.txt:			指定消息输出到mylog.txt文件。
				Append=false:			默认值是true,即将消息增加到指定文件中，false指将消息覆盖指定的文件内容。
			
			RollingFileAppender【每天产生一个日志文件】
				Threshold=DEBUG:		指定日志消息的输出最低层次。
				ImmediateFlush=true:	默认值是true,意谓着所有的消息都会被立即输出。
				File=mylog.txt:			指定消息输出到mylog.txt文件。
				Append=false:			默认值是true,即将消息增加到指定文件中，false指将消息覆盖指定的文件内容。
				MaxFileSize=100KB: 		后缀可以是KB, MB 或者是 GB. 在日志文件到达该大小时，将会自动滚动，即将原来的内容移到mylog.log.1文件。
				MaxBackupIndex=2:		指定可以产生的滚动文件的最大数。

	3.配置日志信息的格式【布局】

		log4j.appender.appenderName.layout = layout.class 全限类名 
		log4j.appender.appenderName.layout.option1 = value1  
		…  
		log4j.appender.appenderName.layout.option = valueN
				
		Log4j提供的layout选项：

			org.apache.log4j.HTMLLayout（以HTML表格形式布局）；
			org.apache.log4j.PatternLayout（可以灵活地指定布局模式）；
			org.apache.log4j.SimpleLayout（包含日志信息的级别和信息字符串）；
			org.apache.log4j.TTCCLayout（包含日志产生的时间、线程、类别等等信息）。

		【注】如果使用PatternLayout布局就要指定的具体文件格式ConversionPattern。

	4.日志文件格式

		log4j.appender.Console.layout.ConversionPattern=%d [%t] %-5p [%c] - %m%n 
			
		日志信息格式中符号所代表的含义：
			-X: 信息输出时左对齐；
			%p: 输出日志信息优先级，即DEBUG，INFO，WARN，ERROR，FATAL,
			%d: 输出日志时间点的日期或时间，默认格式为ISO8601，也可以在其后指定格式，比如：%d{yyy MMM dd HH:mm:ss,SSS}，输出类似：2002年10月18日 22：10：28，921
			%r: 输出自应用启动到输出该log信息耗费的毫秒数
			%c: 输出日志信息所属的类目，通常就是所在类的全名
			%t: 输出产生该日志事件的线程名
			%l: 输出日志事件的发生位置，相当于%C.%M(%F:%L)的组合,包括类目名、发生的线程，以及在代码中的行数。如：Testlog4.main (TestLog4.java:10)
			%x: 输出和当前线程相关联的NDC(嵌套诊断环境),尤其用到像java servlets这样的多客户多线程的应用中。
			%%: 输出一个"%"字符
			%F: 输出日志消息产生时所在的文件名称
			%L: 输出代码中的行号
			%m: 输出代码中指定的消息,产生的日志具体信息
			%n: 输出一个回车换行符，Windows平台为"/r/n"，Unix平台为"/n"输出日志信息换行
			%20c: 指定输出category的名称，最小的宽度是20，如果category的名称小于20的话，默认的情况下右对齐
			%-20c: 指定输出category的名称，最小的宽度是20，如果category的名称小于20的话，"-"号指定左对齐
			%.30c: 指定输出category的名称，最大的宽度是30，如果category的名称大于30的话，就会将左边多出的字符截掉，但小于30的话也不会有空格
			%20.30c: 如果category的名称小于20就补空格，并且右对齐，如果其名称长于30字符，就从左边较远输出的字符截掉

> 控制台console日志输出器
	
	log4j.appender.console=org.apache.log4j.ConsoleAppender
	log4j.appender.console.Threshold=DEBUG
	log4j.appender.console.ImmediateFlush=true
	log4j.appender.console.Target=System.err
	log4j.appender.console.layout=org.apache.log4j.PatternLayout
	log4j.appender.console.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss} [%p] %m%n
			
> 文件logFile日志输出器
	
	log4j.appender.logFile=org.apache.log4j.FileAppender
	log4j.appender.logFile.Threshold=DEBUG
	log4j.appender.logFile.ImmediateFlush=true
	log4j.appender.logFile.Append=true
	log4j.appender.logFile.File=D:/logs/log.log4j
	log4j.appender.logFile.layout=org.apache.log4j.PatternLayout
	log4j.appender.logFile.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss} [%p] %m%n

> 滚动文件rollingFile日志输出器

	log4j.appender.rollingFile=org.apache.log4j.RollingFileAppender
	log4j.appender.rollingFile.Threshold=DEBUG
	log4j.appender.rollingFile.ImmediateFlush=true
	log4j.appender.rollingFile.Append=true
	log4j.appender.rollingFile.File=D:/logs/log.log4j
	log4j.appender.rollingFile.MaxFileSize=200KB
	log4j.appender.rollingFile.MaxBackupIndex=50
	log4j.appender.rollingFile.layout=org.apache.log4j.PatternLayout
	log4j.appender.rollingFile.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss} [%p] %m%n

> 定期滚动文件dailyFile日志输出器

	log4j.appender.dailyFile=org.apache.log4j.DailyRollingFileAppender
	log4j.appender.dailyFile.Threshold=DEBUG
	log4j.appender.dailyFile.ImmediateFlush=true
	log4j.appender.dailyFile.Append=true
	log4j.appender.dailyFile.File=D:/logs/log.log4j
	log4j.appender.dailyFile.DatePattern='.'yyyy-MM-dd
	log4j.appender.dailyFile.layout=org.apache.log4j.PatternLayout
	log4j.appender.dailyFile.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss} [%p] %m%n

> sql日志输出

	log4j.logger.java.sql.Connection=DEBUG  
	log4j.logger.java.sql.Statement=DEBUG  
	log4j.logger.java.sql.PreparedStatement=DEBUG  
	log4j.logger.java.sql.ResultSet=INFO  
	log4j.logger.com.ibatis=DEBUG
	log4j.logger.com.ibatis.common.jdbc.SimpleDataSource=DEBUG
	log4j.logger.com.ibatis.common.jdbc.ScriptRunner=DEBUG
	log4j.logger.com.ibatis.sqlmap.engine.impl.SqlMapClientDelegate=DEBUG
		
> 在程序中使用Log4j + slf4j

	1.得到记录器
		获取本类的日志记录器，这个记录器将负责控制日志信息
		private Logger logger = LoggerFactory.getLogger(StudentMapperTest.class);
		import org.slf4j.Logger;  //由于使用slf4j日志接口，所以使用slf4j的包

	2.插入记录信息（格式化日志信息）
		使用不同优先级别的日志记录语句插入到您想记录日志的任何地方
		Logger.debug ( String s ) ;  
		Logger.info ( String s ) ;  
		Logger.warn ( String s ) ;  
		Logger.error ( String s ) ;
		Logger.debug ( String s, Object message ) ;  
		Logger.info ( String s, Object message ) ;  
		Logger.warn ( String s, Object message ) ;  
		Logger.error ( String s, Object message ) ;
		Logger.debug ( String s, Throwable throwable ) ; 
		......

		logger.debug("21号的学生信息：{}",student);
			21号的学生信息：Student{sId=21, sName='hdc66cd6', classId=1}
		使用占位符 {} 加载studentd对象。

> 实例 log4j.properites

	log4j.rootLogger=DEBUG,Console
  
	#Console  
	log4j.appender.Console=org.apache.log4j.ConsoleAppender  
	log4j.appender.Console.layout=org.apache.log4j.PatternLayout  
	log4j.appender.Console.layout.ConversionPattern=%d [%t] %-5p [%c] - %m%n  
	
	#mybatis显示SQL语句日志配置 
	log4j.logger.java.sql.ResultSet=INFO   
	log4j.logger.java.sql.Connection=DEBUG  
	log4j.logger.java.sql.Statement=DEBUG  
	log4j.logger.java.sql.PreparedStatement=DEBUG  
	log4j.logger.com.ibatis=DEBUG
	log4j.logger.com.ibatis.common.jdbc.SimpleDataSource=DEBUG
	log4j.logger.com.ibatis.common.jdbc.ScriptRunner=DEBUG
	log4j.logger.com.ibatis.sqlmap.engine.impl.SqlMapClientDelegate=DEBUG

> log4j.xml

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE log4j:configuration PUBLIC "-//log4j/log4j Configuration//EN" "log4j.dtd">
	
	<log4j:configuration xmlns:log4j="http://jakarta.apache.org/log4j/">
	
	    <!-- 日志输出到控制台 -->
	    <appender name="console" class="org.apache.log4j.ConsoleAppender">
	        <!-- 日志输出格式 -->
	        <layout class="org.apache.log4j.PatternLayout">
	            <param name="ConversionPattern" value="[%p][%d{yyyy-MM-dd HH:mm:ss SSS}][%c]-[%m]%n"/>
	        </layout>
	
	        <!--过滤器设置输出的级别-->
	        <filter class="org.apache.log4j.varia.LevelRangeFilter">
	            <!-- 设置日志输出的最小级别 -->
	            <param name="levelMin" value="INFO"/>
	            <!-- 设置日志输出的最大级别 -->
	            <param name="levelMax" value="ERROR"/>
	        </filter>
	    </appender>
	
	
	    <!-- 输出日志到文件 -->
	    <appender name="fileAppender" class="org.apache.log4j.FileAppender">
	        <!-- 输出文件全路径名-->
	        <param name="File" value="/data/applogs/own/fileAppender.log"/>
	        <!--是否在已存在的文件追加写：默认时true，若为false则每次启动都会删除并重新新建文件-->
	        <param name="Append" value="false"/>
	        <param name="Threshold" value="INFO"/>
	        <!--是否启用缓存，默认false-->
	        <param name="BufferedIO" value="false"/>
	        <!--缓存大小，依赖上一个参数(bufferedIO), 默认缓存大小8K  -->
	        <param name="BufferSize" value="512"/>
	        <!-- 日志输出格式 -->
	        <layout class="org.apache.log4j.PatternLayout">
	            <param name="ConversionPattern" value="[%p][%d{yyyy-MM-dd HH:mm:ss SSS}][%c]-[%m]%n"/>
	        </layout>
	    </appender>
	
	
	    <!-- 输出日志到文件，当文件大小达到一定阈值时，自动备份 -->
	    <!-- FileAppender子类 -->
	    <appender name="rollingAppender" class="org.apache.log4j.RollingFileAppender">
	        <!-- 日志文件全路径名 -->
	        <param name="File" value="/data/applogs/RollingFileAppender.log" />
	        <!--是否在已存在的文件追加写：默认时true，若为false则每次启动都会删除并重新新建文件-->
	        <param name="Append" value="true" />
	        <!-- 保存备份日志的最大个数，默认值是：1  -->
	        <param name="MaxBackupIndex" value="10" />
	        <!-- 设置当日志文件达到此阈值的时候自动回滚，单位可以是KB，MB，GB，默认单位是KB，默认值是：10MB -->
	        <param name="MaxFileSize" value="10KB" />
	        <!-- 设置日志输出的样式 -->`
	        <layout class="org.apache.log4j.PatternLayout">
	            <!-- 日志输出格式 -->
	            <param name="ConversionPattern" value="[%d{yyyy-MM-dd HH:mm:ss:SSS}] [%-5p] [method:%l]%n%m%n%n" />
	        </layout>
	    </appender>
	
	
	    <!-- 日志输出到文件，可以配置多久产生一个新的日志信息文件 -->
	    <appender name="dailyRollingAppender" class="org.apache.log4j.DailyRollingFileAppender">
	        <!-- 文件文件全路径名 -->
	        <param name="File" value="/data/applogs/own/dailyRollingAppender.log"/>
	        <param name="Append" value="true" />
	        <!-- 设置日志备份频率，默认：为每天一个日志文件 -->
	        <param name="DatePattern" value="'.'yyyy-MM-dd'.log'" />
	
	        <!--每分钟一个备份-->
	        <!--<param name="DatePattern" value="'.'yyyy-MM-dd-HH-mm'.log'" />-->
	        <layout class="org.apache.log4j.PatternLayout">
	            <param name="ConversionPattern" value="[%p][%d{HH:mm:ss SSS}][%c]-[%m]%n"/>
	        </layout>
	    </appender>
	
	
	
	    <!--
	        用来设置某一个包或者具体的某一个类的日志打印级别、以及指定<appender>。
			<loger>仅有一个name属性，一个可选的level和一个可选的addtivity属性。
				1. name:用来指定受此loger约束的某一个包或者具体的某一个类。
				2. level:用来设置打印级别（日志级别），大小写无关：TRACE, DEBUG, INFO, WARN, ERROR, ALL 和 OFF。
					如果未设置此属性，那么当前loger将会继承上级的级别。
				3. addtivity:是否向上级loger传递打印信息。默认是true。

			<loger>可以包含零个或多个<appender-ref>元素，标识这个appender将会添加到这个loger。
	    -->
	    <logger name="logTest" additivity="false">
	        <level value ="INFO"/>
	        <appender-ref ref="dailyRollingAppender"/>
	    </logger>
	
	
	    <!-- 
			它也是<loger>元素，但是它是根loger,是所有<loger>的上级。
			只有一个level属性，应为已经被命名为"root".
			level:用来设置打印级别，大小写无关：TRACE, DEBUG, INFO, WARN, ERROR, ALL 和 OFF。默认是DEBUG。
	
			<root>可以包含零个或多个<appender-ref>元素，标识这个appender将会添加到这个loger。
			-->
	    <root>
	        <appender-ref ref="console"/>
	        <appender-ref ref="fileAppender"/>
	        <appender-ref ref="rollingAppender"/>
	        <appender-ref ref="dailyRollingAppender"/>
	    </root>
	
	</log4j:configuration>

> log4j.xml

	<?xml version="1.0" encoding="UTF-8" ?>
	<!DOCTYPE log4j:configuration PUBLIC "-//log4j/log4j Configuration//EN" "log4j.dtd">
	
	<log4j:configuration xmlns:log4j="http://jakarta.apache.org/log4j/">
		<appender class="org.apache.log4j.ConsoleAppender" name="console">
			<layout class="org.apache.log4j.PatternLayout">
				<!--<param name="ConversionPattern" value="%d %-5p [%t-%L] %-17c{2}- %m%n" />-->
				<param name="ConversionPattern" value="%d %-5p [%C-%L] - %m%n" />
			</layout>
		</appender>
		<!--<appender class="org.apache.log4j.DailyRollingFileAppender"
			name="file">
			<param name="File" value="test.log" />
			<layout class="org.apache.log4j.PatternLayout">
				&lt;!&ndash;<param name="ConversionPattern" value="=%d %-5p [%t-%L] %-17c{2}- %m%n" />&ndash;&gt;
				<param name="ConversionPattern" value="%d %-5p [%C-%L] - %m%n" />
			</layout>
		</appender>-->
	
		<!-- specify the logging level for loggers from other libraries -->
	
		<logger name="com.apache">
			<level value="INFO" />
		</logger>
	
		<logger name="com.apache.ibatis">
			<level value="INFO" />
		</logger>
	
		<logger name="com.mybatis">
			<level value="INFO" />
		</logger>
	
		<logger name="java.sql">
			<level value="INFO" />
		</logger>
	
		<logger name="com.mysql">
			<level value="INFO" />
		</logger>
	
		<logger name="org.springframework">
			<level value="WARN" />
		</logger>
	
	    <logger name="org.springframework.security">
	        <level value="WARN" />
	    </logger>
	
		<logger name="org.springframework.amqp">
			<level value="INFO"/>
		</logger>
	
		<!-- for all other loggers log only INFO and above log messages -->
		<root>
			<priority value="INFO" />
			<!--<appender-ref ref="file" />-->
	        <appender-ref ref="console" />
		</root>
	</log4j:configuration> 


<a name="3、logback"></a>
### 3、logback ###

> Logback是由log4j创始人设计的另一个开源日志组件,官方网站： http://logback.qos.ch  
> 当前分为下面下个模块

	logback-core：其它两个模块的基础模块。
	logback-classic：它是log4j的一个改良版本，同时它完整实现了slf4j API，使你可以很方便地更换成其它日志系统如log4j或JDK14 Logging。

> logback的配置介绍

	Logger
		作为日志的记录器，把它关联到应用的对应的context上后，主要用于存放日志对象，也可以定义日志类型、级别。

	Appender
		主要用于指定日志输出的目的地，目的地可以是控制台、文件、远程套接字服务器、 MySQL、PostreSQL、 Oracle和其他数据库、 JMS和远程UNIX Syslog守护进程等。 

	Layout
		负责把事件转换成字符串，格式化的日志信息的输出。

	logger context
		各个logger 都被关联到一个 LoggerContext，LoggerContext负责制造logger，也负责以树结构排列各logger。
		其他所有logger也通过org.slf4j.LoggerFactory 类的静态方法getLogger取得。
		getLogger方法以 logger名称为参数。用同一名字调用LoggerFactory.getLogger 方法所得到的永远都是同一个logger对象的引用。

	logback的默认配置
		如果配置文件 logback-test.xml 和 logback.xml 都不存在，那么 logback 默认地会调用BasicConfigurator ，创建一个最小化配置。
		最小化配置由一个关联到根 logger 的ConsoleAppender 组成；
		输出用模式为%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n 的 PatternLayoutEncoder 进行格式化；
		root logger 默认级别是 DEBUG。

> logback.xml常用配置详解

	1. 根节点<configuration>
	
		scan: 
			当此属性设置为true时，配置文件如果发生改变，将会被重新加载。
			默认值为true。
		scanPeriod: 
			设置监测配置文件是否有修改的时间间隔，如果没有给出时间单位，默认单位是毫秒。
			当scan为true时，此属性生效，默认的时间间隔为1分钟。
		debug: 
			当此属性设置为true时，将打印出logback内部日志信息，实时查看logback运行状态。
			默认值为false。

		<configuration scan="true" scanPeriod="60 seconds" debug="false"> 

	2. 子节点<contextName>
	
		用来设置上下文名称，每个logger都关联到logger上下文，默认上下文名称为default
		可以使用<contextName>设置成其他名字，用于区分不同应用程序的记录。一旦设置，不能修改。
		<contextName>myAppName</contextName>

	3. 子节点<property>
	
		用来定义变量值，它有两个属性name和value，通过<property>定义的值会被插入到logger上下文中，可以使“${}”来使用变量。
		<property name="LOG_HOME" value="/home" />

	4. 子节点<timestamp>
	
		获取时间戳字符串
		key: 标识此<timestamp> 的名字；
		datePattern: 设置将当前时间（解析配置文件的时间）转换为字符串的模式。
		<timestamp key="bySecond" datePattern="yyyyMMdd'T'HHmmss"/> 

	5. 子节点<appender>

		负责写日志的组件，它有两个必要属性name和class
		name指定appender名称，class指定appender的全限定名
		<!--格式化输出：%d表示日期，%thread表示线程名，%-5level：级别从左显示5个字符宽度%msg：日志消息，%n是换行符-->
		<pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>

	6. 子节点<logger>
	
		用来设置某一个包或者具体的某一个类的日志打印级别、以及指定<appender>。

		<logger>仅有一个name属性，一个可选的level和一个可选的addtivity属性。
			1. name:用来指定受此logger约束的某一个包或者具体的某一个类。
			2. level:用来设置打印级别（日志级别），大小写无关：TRACE, DEBUG, INFO, WARN, ERROR, ALL 和 OFF。
				如果未设置此属性，那么当前loger将会继承上级的级别。
			3. addtivity:是否向上级loger传递打印信息。默认是true。

			<logger>可以包含零个或多个<appender-ref>元素，标识这个appender将会添加到这个logger。

	7. 子节点<root>
	
		它也是<logger>元素，但是它是根loger,是所有<loger>的上级。
		只有一个level属性，应为已经被命名为"root"。
		level:用来设置打印级别，大小写无关：TRACE, DEBUG, INFO, WARN, ERROR, ALL 和 OFF。默认是DEBUG。

		<root>可以包含零个或多个<appender-ref>元素，标识这个appender将会添加到这个logger。

> ConsoleAppender 把日志输出到控制台【Catalina.out 日志文件中】

	<encoder>：对日志进行格式化
	<target>：字符串System.out(默认)或者System.err

	<configuration> 
		<appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender"> 
		　　<encoder> 
		　　　　　<pattern>%-4relative [%thread] %-5level %d %logger{35} - %msg %n</pattern> 
		　　</encoder> 
	　　</appender> 
	
	　　<root level="DEBUG"> 
	　　　　<appender-ref ref="STDOUT" /> 
	　　</root> 
	</configuration>

> FileAppender：把日志添加到文件
				
	<file>：被写入的文件名，可以是相对目录，也可以是绝对目录，如果上级目录不存在会自动创建，没有默认值。
	<append>：如果是 true，日志被追加到文件结尾，如果是 false，清空现存文件，默认是true。
	<encoder>：对记录事件进行格式化。
	<prudent>：如果是 true，日志会被安全的写入文件，即使其他的FileAppender也在向此文件做写入操作，效率低，默认是 false。
	
	<configuration> 
		<appender name="FILE" class="ch.qos.logback.core.FileAppender"> 
		<file>testFile.log</file> 
		<append>true</append> 
			<encoder> 
				<pattern>%-4relative [%thread] %-5level %logger{35} - %msg%n</pattern> 
			</encoder> 
		</appender> 
	
		<root level="DEBUG"> 
			<appender-ref ref="FILE" /> 
		</root> 
	</configuration>

> RollingFileAppender：滚动记录文件
				
	先将日志记录到指定文件，当符合某个条件时，将日志记录到其他文件。

	<file>
		被写入的文件名，可以是相对目录，也可以是绝对目录，如果上级目录不存在会自动创建，没有默认值。

	<append>
		如果是 true，日志被追加到文件结尾，如果是 false，清空现存文件，默认是true。

	<encoder>
		对记录事件进行格式化,一是把日志信息转换成字节数组，二是把字节数组写入到输出流,有一个<pattern>节点，用来设置日志的输入格式。

	<triggeringPolicy >
		告知 RollingFileAppender 什么时候开始滚动，即设置单个日志文件最大的大小。
		<triggeringPolicy class="ch.qos.logback.core.rolling.SizeBasedTriggeringPolicy">
			<MaxFileSize>10MB</MaxFileSize>
		</triggeringPolicy>
	<rollingPolicy>

		当发生滚动时，决定RollingFileAppender的行为，涉及文件移动和重命名。
		属性class定义具体的滚动策略类。

	具体的滚动策略类：

		1. 最常用的滚动策略，它根据时间来制定滚动策略。
		<rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy"> 
		<fileNamePattern>：日志文件名称格式，包含文件名及“%d”转换符,直接使用 %d，默认格式是 yyyy-MM-dd
		<maxHistory>  可选节点，控制保留的归档文件的最大数量，超出数量就删除旧文件。
	
		<rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
			<!--日志文件输出的文件名-->
			<FileNamePattern>${LOG_HOME}/TestWeb.log.%d{yyyy-MM-dd}.log</FileNamePattern>
			<!--日志文件保留天数-->
			<MaxHistory>30</MaxHistory>
		</rollingPolicy>

		2. 查看当前活动文件的大小，如果超过指定大小会告知RollingFileAppender 触发当前活动文件滚动
		<rollingPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
			<maxFileSize>:这是活动文件的大小，默认值是10MB

		3. 根据固定窗口算法重命名文件的滚动策略 
		class="ch.qos.logback.core.rolling.FixedWindowRollingPolicy"
			<minIndex>:窗口索引最小值
			<maxIndex>:窗口索引最大值，当用户指定的窗口过大时，会自动将窗口设置为12
			<fileNamePattern > 必须包含“%i”例如，假设最小值和最大值分别为1和2，命名模式为 mylog%i.log,会产生归档文件mylog1.log和mylog2.log。还可以指定文件压缩选项，例如，mylog%i.log.gz 或者 没有log%i.log.zip。
			
> 例子  
> 日志每天归档

	<file>mylog.txt</file>
	<rollingPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
	  <!-- 每天一归档 -->
	  <fileNamePattern>mylog-%d{yyyy-MM-dd}.%i.txt</fileNamePattern>
	   <!-- 单个日志文件最多 100MB, 60天的日志周期，最大不能超过20GB -->
	   <maxFileSize>100MB</maxFileSize>    
	   <maxHistory>60</maxHistory>
	   <totalSizeCap>20GB</totalSizeCap>
	</rollingPolicy>

> logback + slf4j  
> pom.xml

	<!--slf4j日志接口-->
    <dependency>
      <groupId>org.slf4j</groupId>
      <artifactId>slf4j-api</artifactId>
      <version>1.7.25</version>
    </dependency>
    
    <!--logback日志-->
    <dependency>
      <groupId>ch.qos.logback</groupId>
      <artifactId>logback-core</artifactId>
      <version>1.1.11</version>
    </dependency>
    <dependency>
      <groupId>ch.qos.logback</groupId>
      <artifactId>logback-classic</artifactId>
      <version>1.1.11</version>
    </dependency>
		
> logback.xml

	<?xml version="1.0" encoding="UTF-8"?>
	<configuration>
	    <appender name="FILE" class="ch.qos.logback.core.FileAppender">
	        <file>testFile.log</file>
	        <append>true</append>
	        <encoder>
	            <pattern>%-4relative [%thread] %-5level %d %logger{35} - %msg%n</pattern>
	        </encoder>
	    </appender>
	　　<appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
	　　<encoder>
	　　　　　<pattern>%-4relative [%thread] %-5level %d %logger{35} - %msg %n</pattern>
	　　</encoder>
	　　</appender>
	
	    <root level="DEBUG">
	        <appender-ref ref="FILE" />
	        <appender-ref ref="STDOUT"/>
	    </root>
	</configuration>

	【说明】
	没有显式指定logger 子节点，即表示对所有的文件都使用 root 子节点进行日志记录。

