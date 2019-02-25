# Java 消息中间件

* [1、JMS介绍](#1、JMS介绍)
* [2、点对点模式](#2、点对点模式)
* [3、发布/订阅模式](#3、发布/订阅模式)
* [4、JMS应用程序API接口](#4、JMS应用程序API接口)

<a name="1、JMS介绍"></a>
### 1、JMS介绍 ###

* JMS(Java Message Service) 为Java 程序创建、发送、接收和读取消息系统中的消息，并提供一种通用方法。  
* JMS 提供了两种主要的消息模式：1、点对点模式；2、发布/订阅模式。  
* JMS可以大致分为两个功能区域，即消息的生成和消费。
> JMS的具体实现 ActiveMQ 

	ActiveMQ 是一个易于使用的消息中间件。

	用途和优点：
		
		1. 将数据从一个应用/模块传送到另一个应用/模块；
		2. 负责建立网络通信的通道，进行数据的可靠传送；
		3. 保证数据不重发，不丢失；
		4. 能够实现跨平台操作。

[JMS官方文档](https://docs.spring.io/spring/docs/5.1.3.RELEASE/spring-framework-reference/integration.html#jms)

<a name="2、点对点模式"></a>
### 2、点对点模式 ###

* 点对点模式也称为队列模式【 queue 】

* 该模式主要建立在一个队列上面，当连接一个列队的时候，发送端不需要知道接收端是否正在接收，可以直接向队列【ActiveMQ】发送消息。

* 发送的消息，将会先进入队列中，如果有接收端在监听，则会发向接收端，如果没有接收端接收，则会保存在队列服务器，直到接收端接收消息。
  
* 该消息模式可以有多个发送端，多个接收端，但是**一条消息，只会被一个接收端给消费**，哪个接收端先连上队列服务器，则会先接收到，而后来的接收端则接收不到那条消息。  

<a name="3、发布/订阅模式"></a>
### 3、发布/订阅模式 ###

* 发布/订阅模式也称为主题模式【 topic 】

* 该模式同样可以有着多个发送端与多个接收端，但是**接收端与发送端存在时间上的依赖**，就是如果发送端发送消息的时候，接收端并没有监听消息，那么队列服务器将不会保存消息，将会认为消息已经发送，即**发送端发送消息的时候，接收端不在线，是接收不到消息的，哪怕以后监听消息，同样也是接收不到的。**

* 这个模式还有一个特点，那就是，**发送端发送的消息，将会被所有的接收端给消费**，不像点对点，一条消息只会被一个接收端给消费。

* 通过实现 MessageListener 接口的 onMessage(Message message) 方法对消息进行消费监听。

### 两种模式的实现区别 ###

> 如果是点对点，那么它的实现是 Queue，如果是订阅模式，那它的实现是 Topic。  
> 点对点与订阅模式唯一不同的地方，就是这一行代码，点对点创建的是Queue，而订阅模式创建的是Topic

	destination = session.createQueue("FirstQueue");
	destination = session.createTopic("FirstQueue");

<a name="4、JMS应用程序API接口"></a>
### 4、JMS应用程序API接口 ###

> 1、ConnectionFactory 接口（连接工厂） 

	用户用来创建到 JMS 提供者的连接的连接对象【Connection】。

> 2、Connection 接口（连接）  

	代表了 应用程序 和 消息服务器 之间的通信链路。
	在获得了连接工厂后，就可以创建一个与JMS提供者的连接。
	负责创建 Session。 
	根据不同的连接类型，连接允许用户创建会话，以发送和接收队列和主题到目标。

> 3、Destination 接口（目标）

	目标是一个包装了消息目标标识符的连接对象，消息目标是指消息发布和接收的地点，或者是队列，或者是主题。
	JMS管理员创建这些对象，然后用户通过JNDI发现它们。
	和连接工厂一样，管理员可以创建两种类型的目标，点对点模型的队列，以及发布者／订阅者模型的主题。 

> 4、MessageConsumer 接口（消息消费者）  

	由会话创建的对象，用于接收发送到目标的消息。
	消费者可以同步地（阻塞模式），或异步（非阻塞）接收队列和主题类型的消息。 

> 5、MessageProducer 接口（消息生产者）  

	由会话创建的对象，用于发送消息到目标。
	用户可以创建某个目标的发送者，也可以创建一个通用的发送者，在发送消息时指定目标。  

> 6、Message 接口（消息）  

	是在消费者和生产者之间传送的对象，即从一个应用程序送到另一个应用程序。

	一个消息有三个主要部分：
  
		1. 消息头（必须）
			包含用于识别和为消息寻找路由的操作设置。
 
		2. 一组消息属性（可选）
			包含额外的属性，支持其他提供者和用户的兼容。
			可以创建定制的字段和过滤器（消息选择器）。  

		3. 一个消息体（可选）：
			允许用户创建五种类型的消息（文本消息，映射消息，字节消息，流消息和对象消息）。
			消息接口非常灵活，并提供了许多方式来定制消息的内容。
	
> 7、Session 接口（会话） 

	表示一个单线程的上下文，用于发送和接收消息。会话的好处是它支持事务。
	由于会话是单线程的，所以消息是连续的，即消息是按照发送的顺序一个一个接收的。
	如果用户选择了事务支持，会话上下文将保存一组消息，直到事务被提交才发送这些消息。
	在提交事务之前，用户可以使用回滚操作取消这些消息。
	一个会话允许用户创建消息生产者来发送消息，创建消息消费者来接收消息。 
	创建 MessageProducer（用来发消息）和 MessageConsumer（用来接收消息）。 

### 会话模式 ###

	session = connection.createSession(paramA,paramB);

		paramA是设置事务的，表示是否支持事务；

		paramB设置 acknowledgment mode【消息应答模式】。

		paramA设置为false时：paramB的值可为Session.AUTO_ACKNOWLEDGE，Session.CLIENT_ACKNOWLEDGE，DUPS_OK_ACKNOWLEDGE 其中一个。 
 
		paramA 设置为true时：paramB的值忽略， acknowledgment mode被jms服务器设置为 SESSION_TRANSACTED 。 

### 生产者的模式【2种】 ###

> DeliveryMode.PERSISTENT【持久化】 

	当MQ关闭的时候，队列数据将会被保存。

> DeliveryMode.NON_PERSISTENT【非持久化】 

	当MQ关闭的时候，队列里面的数据将会被清空。

### 消息应答模式【3种】 ###

> Session.AUTO_ACKNOWLEDGE 

	自动确认，客户端发送和接收消息不需要做额外的工作。 
	
> Session.CLIENT_ACKNOWLEDGE 

	客户端确认。
	客户端接收到消息后，必须调用javax.jms.Message的 acknowledge方法进行确认，jms服务器才会删除消息。 

> DUPS_OK_ACKNOWLEDGE 

	允许副本的确认模式。
	一旦接收方应用程序的方法调用从处理消息处返回，会话对象就会确认消息的接收；而且允许重复确认。
	在需要考虑资源使用时，这种模式非常有效。

### 发送消息的数据类型 ###

> 创建消息，是通过session这个对象来创建的。  
> 只要是实现了这个接口【javax.jms.Message】的数据，都可以被发送。

	//发送纯字符串的数据
	TextMessage message = session.createTextMessage();
	
	//发送序列化的对象
	session.createObjectMessage();
	
	//发送流，可以用来传递文件等
	session.createStreamMessage();
	
	//发送用来传递字节
	session.createBytesMessage();
	
	//这个方法创建出来的就是一个map，可以把它当作map来用
	session.createMapMessage();


### 例子1 -- 使用原生API ###

> 标准API涉及创建许多中间对象。

	1. 发送消息步骤
		ConnectionFactory->Connection->Session->MessageProducer->send

> 消息生产者

	package com.hdc.activemq.sender;

	import javax.jms.Connection;
	import javax.jms.ConnectionFactory;
	import javax.jms.DeliveryMode;
	import javax.jms.Destination;
	import javax.jms.JMSException;
	import javax.jms.MessageProducer;
	import javax.jms.Session;
	import javax.jms.TextMessage;
	
	import org.apache.activemq.ActiveMQConnectionFactory;
	
	public class Sender {
	
		private static final int SEND_NUMBER=5;
		private static String username = "ActiveMQConnection.DEFAULT_USER";
		private static String passwd = "ActiveMQConnection.DEFAULT_PASSWORD";
		private static String url = "tcp://192.168.1.30:61616";
		
		public static void main(String[] args) {
	
			//连接工厂，用来创建连接
			ConnectionFactory connectionFactory;
			
			//连接，客户端到生产者的连接
			Connection connection=null;
			
			//一个发生或接收消息的会话
			Session session;
			
			//消息的目的地，消息发给谁
			Destination destination;
			
			//消息发送者
			MessageProducer producer;
			
			//根据用户名，密码，url创建一个连接工厂
			connectionFactory = new ActiveMQConnectionFactory(username, passwd, url);
			
			try {
				//构建从工厂得到连接对象
				connection = connectionFactory.createConnection();
				
				//启动
				connection.start();
				
				session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
				
				//FirstQueue 队列名
				destination = session.createQueue("FirstQueue");
				//destination = session.createTopic("FirstQueue");
						
	            //得到消息生成者【发送者】
				producer = session.createProducer(destination);
				
				producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);
				
				//构建消息，项目就是参数，或者通过方法获取
				sendMessage(session, producer);
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				try {
					if(connection!=null){
						connection.close();
					}
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
		}
		
		//消息发送
		public static void sendMessage(Session session, MessageProducer producer){
			
			for(int i=1;i<=SEND_NUMBER;i++)
			{
				try {
					//创建一条消息
					TextMessage message = session.createTextMessage("ActiveMq 发送的消息"+ i);
					
					//发送消息到目的地
					System.out.println("发送消息："+ "ActiveMq 发送的消息"+i);
					producer.send(message);
					
				} catch (JMSException e) {
					e.printStackTrace();
				}		
			}
		}
	}

> 消息消费者

	package com.hdc.activemq.receiver;

	import javax.jms.Connection;
	import javax.jms.ConnectionFactory;
	import javax.jms.Destination;
	import javax.jms.MessageConsumer;
	import javax.jms.Session;
	import javax.jms.TextMessage;
	import org.apache.activemq.ActiveMQConnectionFactory;
	
	public class Receiver {
	
		private static String username = "ActiveMQConnection.DEFAULT_USER";
		private static String passwd = "ActiveMQConnection.DEFAULT_PASSWORD";
		private static String url = "tcp://192.168.1.30:61616";
		
		public static void main(String[] args) {
	
			ConnectionFactory connectionFactory;
			Connection connection = null;
			Session session;
			Destination destination;
			
			//消费者，消息接收者
			MessageConsumer consumer;
			
			connectionFactory = new ActiveMQConnectionFactory(username, passwd, url);
			
			try {
				connection = connectionFactory.createConnection();
				connection.start();
				session = connection.createSession(false, Session.CLIENT_ACKNOWLEDGE);
				destination = session.createQueue("FirstQueue"); 

				//destination = session.createTopic("FirstQueue");
				consumer = session.createConsumer(destination);
				
				while(true){
					//设置接收者接收消息的时间,100s
					TextMessage message = (TextMessage) consumer.receive(100000);
					if(message!=null){
						message.acknowledge();
						System.out.println("收到消息 "+ message.getText());
					}else{
						break;
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				try {
					if(connection!=null){
						connection.close();
					}
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
		}
	}

> Spring + ActiveMQ 整合

	Spring提供了一个JMS集成框架，它简化了JMS API的使用，就像Spring对JDBC API的集成一样。

> JmsTemplate

	JmsTemplate类用于 消息生成 和 同步消息接收。
	JmsTemplate类是JMS核心包中的中心类。 
	它简化了JMS的使用，因为它在发送或同步接收消息时处理资源的创建和释放，这样就不用开发者去关心资源的连接和释放。
	
	JmsTemplate需要引用ConnectionFactory。

	为了便于发送域模型对象，JmsTemplate具有各种发送方法，这些方法将Java对象作为消息数据内容的参数。 

	JmsTemplate中的重载方法convertAndSend（）和receiveAndConvert（）方法将转换过程委托给MessageConverter接口的实例。 
	此接口定义了一个简单的合约，用于在Java对象和JMS消息之间进行转换。
	默认实现（SimpleMessageConverter）支持String和TextMessage，byte []和BytesMesssage以及java.util.Map和MapMessage之间的转换。 
	通过使用转换器，您和您的应用程序代码可以专注于通过JMS发送或接收的业务对象，而不关心它如何表示为JMS消息的详细信息。

> **pom.xml **

	<!--日志-->
    <dependency>
      <groupId>org.slf4j</groupId>
      <artifactId>slf4j-api</artifactId>
      <version>1.7.25</version>
    </dependency>
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

    <!--spring-->
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-context</artifactId>
      <version>4.3.11.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-beans</artifactId>
      <version>4.3.11.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-jms</artifactId>
      <version>4.3.11.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-test</artifactId>
      <version>4.3.11.RELEASE</version>
    </dependency>

    <!--activemq中间件-->
    <dependency>
      <groupId>org.apache.activemq</groupId>
      <artifactId>activemq-pool</artifactId>
      <version>5.15.1</version>
    </dependency>
    <dependency>
      <groupId>org.apache.activemq</groupId>
      <artifactId>activemq-all</artifactId>
      <version>5.9.0</version>
    </dependency>

	<!--activemq整合spring-->
    <dependency>
      <groupId>org.apache.xbean</groupId>
      <artifactId>xbean-spring</artifactId>
      <version>4.6</version>
    </dependency>

> **activemq.properties**

	broker.url=tcp://localhost:61616
	admin.username=admin
	admin.password=POEVb9[rxwYd6e0H
	publisher.username=publisher
	publisher.password=JIur[9]rEVy5JGaV
	consumer.username=consumer
	consumer.password=HaMGde(Mo6{pmhdP
	
	queue.destination=Queue.test
	topic.destination=Topic.test

> **publisher.xml**

	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
	       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	       xmlns:context="http://www.springframework.org/schema/context"
	       xmlns:amq="http://activemq.apache.org/schema/core"
	       xsi:schemaLocation="http://www.springframework.org/schema/beans
	       http://www.springframework.org/schema/beans/spring-beans.xsd
	       http://www.springframework.org/schema/context
	       http://www.springframework.org/schema/context/spring-context.xsd
	       http://activemq.apache.org/schema/core
	       http://activemq.apache.org/schema/core/activemq-core.xsd">
	
	    <context:property-placeholder location="classpath:activemq.properties"/>
	    <context:component-scan base-package="com.jms.spring.publisher"/>
	    <context:annotation-config/>
	
	    <!-- ActiveMQ 连接工厂【url地址，生产者账号密码】 -->
	    <amq:connectionFactory id="publisherConnection" optimizeAcknowledge="true" brokerURL="${broker.url}"
	    userName="${publisher.username}" password="${publisher.password}" />
	
	    <!--由spring jms 提供的连接池,Spring用于管理真正的ConnectionFactory的ConnectionFactory -->
	    <bean id="jmsPublisherFactory" class="org.apache.activemq.pool.PooledConnectionFactory" destroy-method="stop">
	        <property name="connectionFactory" ref="publisherConnection"/>
	        <property name="maxConnections" value="1000"/>
	    </bean>
	
	    <!--使用缓存可以提升效率-->
	    <bean id="cachingConnectionFactory" class="org.springframework.jms.connection.CachingConnectionFactory">
	        <property name="targetConnectionFactory" ref="jmsPublisherFactory"/>
			<property name="exceptionListener" ref="jmsExceptionListener" />
	        <!-- Session缓存数量 -->
	        <property name="sessionCacheSize" value="100"/>
	    </bean>
	
	    <!--一个队列的目的地【点对点模式】-->
	    <bean id="queueDestination" class="org.apache.activemq.command.ActiveMQQueue">
	        <!--队列名称-->
	        <constructor-arg value="${queue.destination}"/>
	    </bean>
	
	    <!--一个主题的目的地【订阅模式】-->
	    <bean id="topicDestination" class="org.apache.activemq.command.ActiveMQTopic">
	        <!--队列名称-->
	        <constructor-arg value="${topic.destination}"/>
	    </bean>
	
	    <!-- Spring JmsTemplate 的消息生产者【用于发送消息】start-->

	    <bean id="jmsQueueTemplate" class="org.springframework.jms.core.JmsTemplate">
	        <constructor-arg ref="cachingConnectionFactory" />
	        <!-- 非pub/sub模型（发布/订阅），即队列模式 -->
	        <property name="pubSubDomain" value="false" />
	    </bean>

	    <bean id="jmsTopicTemplate" class="org.springframework.jms.core.JmsTemplate">
	        <constructor-arg ref="cachingConnectionFactory" />
	        <!-- pub/sub模型（发布/订阅 -->
	        <property name="pubSubDomain" value="true" />
	    </bean>

	    <!-- Spring JmsTemplate 的消息生产者【用于发送消息】end-->
	
	</beans>

> **consumer.xml**

	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
	       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	       xmlns:context="http://www.springframework.org/schema/context"
	       xmlns:amq="http://activemq.apache.org/schema/core"
	       xmlns:jms="http://www.springframework.org/schema/jms"
	       xsi:schemaLocation="http://www.springframework.org/schema/beans
	       http://www.springframework.org/schema/beans/spring-beans.xsd
	       http://www.springframework.org/schema/context
	       http://www.springframework.org/schema/context/spring-context.xsd
	       http://activemq.apache.org/schema/core
	       http://activemq.apache.org/schema/core/activemq-core.xsd
	       http://www.springframework.org/schema/jms
	       http://www.springframework.org/schema/jms/spring-jms.xsd">
	
	    <context:property-placeholder location="classpath:activemq.properties"/>
	    <context:component-scan base-package="com.jms.spring.consumer"/>
	    <context:annotation-config/>
	
	    <!-- ActiveMQ 连接工厂【url地址，消费者账号密码】 -->
	    <amq:connectionFactory id="consumerConnection" optimizeAcknowledge="true" brokerURL="${broker.url}"
	                           userName="${consumer.username}" password="${consumer.password}" />
	
	    <!--由spring jms 提供的 连接池,Spring用于管理真正的ConnectionFactory的ConnectionFactory -->
	    <bean id="jmsConsumerFactory" class="org.apache.activemq.pool.PooledConnectionFactory" destroy-method="stop">
	        <property name="connectionFactory" ref="consumerConnection"/>
	        <property name="maxConnections" value="1000"/>
	    </bean>
	
	    <!--使用缓存可以提升效率-->
	    <bean id="cachingConsumerConnectionFactory" class="org.springframework.jms.connection.CachingConnectionFactory">
	        <property name="targetConnectionFactory" ref="jmsConsumerFactory"/>
			<property name="exceptionListener" ref="jmsExceptionListener" />
	        <!-- Session缓存数量 -->
	        <property name="sessionCacheSize" value="100"/>
	    </bean>
	
	    <!-- 消息消费者 start-->
	
	    <!-- jms消息驱动器容器【配置连接工厂、消息目的地、消息监听器】, 默认是队列模式-->
	    <jms:listener-container receive-timeout="1000" connection-factory="cachingConsumerConnectionFactory"  >
	        <!-- jms消息监听器-->
	        <jms:listener destination="${queue.destination}" ref="consumerMessageLister"/>
	    </jms:listener-container>
	
	    <!-- 发布/订阅模式-->
	    <jms:listener-container receive-timeout="1000" connection-factory="cachingConsumerConnectionFactory" destination-type="topic">
	        <jms:listener destination="${topic.destination}" ref="consumerMessageLister"/>
	    </jms:listener-container>
	
	    <!-- 消息消费者 end-->
	
	</beans>

> 监听异常

	import javax.jms.ExceptionListener;
	import javax.jms.JMSException;
	import org.slf4j.Logger;
	import org.slf4j.LoggerFactory;
	
	public class JmsExceptionListener implements ExceptionListener {
	    private static final Logger log = LoggerFactory.getLogger(JmsExceptionListener.class);
	
	    public JmsExceptionListener() {
	    }
	
	    public void onException(JMSException e) {
	        log.warn("Jms Listener throw exception:" + e.getMessage());
	        e.printStackTrace();
	    }
	}

> **生产者接口**

	public interface PublisherServer {
	    void sendQueueMessage(String message);
	    void sendTopicMessage(String message);
	}

> **生产者**

	import com.onlineShop.activemq.ProducerServer;
	import org.slf4j.Logger;
	import org.slf4j.LoggerFactory;
	import org.springframework.jms.core.JmsTemplate;
	import org.springframework.stereotype.Service;
	import javax.annotation.Resource;
	import javax.jms.DeliveryMode;
	import javax.jms.Destination;
	
	@Service
	public class PublisherServerImpl implements PublisherServer {
	
	    @Resource(name = "jmsQueueTemplate")
	    private JmsTemplate jmsQueueTemplate;

	    @Resource(name = "queueDestination")
	    private Destination queueDestination;
	
	    @Resource(name = "jmsTopicTemplate")
	    private JmsTemplate jmsTopicTemplate;

	    @Resource(name = "topicDestination")
	    private Destination topicDestination;
	
	    @Override
	    public void sendQueueMessage(String message) {
	        //设置消息生成模式【不持久化】
	        jmsQueueTemplate.setDeliveryMode(DeliveryMode.NON_PERSISTENT);
	        //发送消息
	        jmsQueueTemplate.convertAndSend(queueDestination, message);
	    }
	
	    /**
	     * 订阅/发布模式
	     */
	    @Override
	    public void sendTopicMessage(String message) {
	        jmsTopicTemplate.convertAndSend(topicDestination, message);
	    }
	}

> **消费者**

	package com.jms.spring.consumer;

	import org.springframework.stereotype.Component;
	import javax.jms.*;
	
	/**
	 *
	 * 实现消息监听器 接口 MessageListener的方法 onMessage 来监听消息
	 */
	@Component
	public class ConsumerMessageLister implements MessageListener {
	    @Override
	    public void onMessage(Message message) {
	        TextMessage textMessage = (TextMessage) message;
	        try {
				//接收文本消息
	            System.out.println("接收的消息："+textMessage.getText());
	        } catch (JMSException e) {
	            e.printStackTrace();
	        }
	    }
	}


> **测试**

	@RunWith(SpringJUnit4ClassRunner.class)
	@ContextConfiguration(locations = {"classpath:config/publisher.xml"})
	public class activemqTest {
	
	    private static Logger logger = LoggerFactory.getLogger(activemqTest.class);
	
	    @Resource
	    private PublisherServer publisherServer;
	
	    @Test
	    public void sendQueueMessage() throws Exception {
	        //发送消息
	        String message = "this is queueTest";
	        for (int i = 0; i < 5; i++) {
	            publisherServer.sendQueueMessage(message+i);
	            logger.info("发送队列消息：{}", message+i);
	        }
	    }
	
	    @Test
	    public void sendTopicMessage() throws Exception {
	        //发送消息
	        String message = "this is TopicTest";
	        for (int i = 0; i < 5; i++) {
	            publisherServer.sendTopicMessage(message+i);
	            System.out.println("发送订阅消息："+message+i);
	        }
	    }
	}

#### 封装发送和接收消息的方法 ####

> 消息发送抽象类

	public abstract class AbstractQueueSender {
	    private static final Logger log = LoggerFactory.getLogger(AbstractQueueSender.class);
	
	    @Autowired
	    protected Properties activeMQProps;
	
	    private final JmsTemplate jmsTemplate;
	
	    public AbstractQueueSender(JmsTemplate jmsTemplate ) {
	        this.jmsTemplate = jmsTemplate;
	    }
	
	    public void send(Map<String, Object> map){
	        log.debug("send to queue: " + getQueueNameKey());
	        jmsTemplate.convertAndSend(getQueueNameKey(), map);
	    }
	
	    abstract String getQueueNameKey();
	}

> 消息发送具体子类

	public class ParentsQueueSender extends AbstractQueueSender {
	    private static final Logger log = LoggerFactory.getLogger(ParentsQueueSender.class);
	
	    @Autowired
	    protected Properties activeMQProps;
	
	    public ParentsQueueSender(JmsTemplate jmsTemplate) {
	        super(jmsTemplate);
	    }
	
	    @Override
	    public String getQueueNameKey(){
	        return activeMQProps.getProperty("queue.name.parents");
	    }
	}

	【说明】
	可以通过不同的子类实现向不同的队列发送消息。

> 将消息发送的具体类注册到 Spring，并注入构造属性

	<bean id="parentsQueueSender"
          class="com.taihaoli.platform.context.jms.sender.ParentsQueueSender">
        <constructor-arg name="jmsTemplate" ref="jmsTemplate"/>
    </bean>

> 消息接收抽象类

	public abstract class AbstractQueueListener implements MessageListener {
	    private static final Logger log = LoggerFactory.getLogger(AbstractQueueListener.class);
	
	    @Autowired(required = false)
	    Map<String, MessageHandlerInterface> handlerInterfaceMap;
	
	    @Override
	    public void onMessage(Message message) {
	        MapMessage mapMessage = (MapMessage) message;
	        try {
	            Integer type= mapMessage.getInt("type");
	            log.debug("type: " + type);
	            MessageHandlerInterface handlerInterface =
	                    handlerInterfaceMap.get(MessageTypeEnum.getType(type)
	                            + MessageHandlerInterface.BEAN_SUFFIX);
	            handlerInterface.messageHandle(mapMessage);
	        } catch (JMSException e) {
	            e.printStackTrace();
	        }
	    }
	}

	【说明】
	根据监听到的消息的类型而采用相对应的消息处理方法。

> MessageHandlerInterface【消息处理接口】

	public interface MessageHandlerInterface {

	    /** 处理器实现类 bean id或名称后缀 */
	    String BEAN_SUFFIX = "MessageHandler";
	
	    /**
	     * 消息处理抽象方法
	     * @param mapMessage map消息 model
	     */
	    void messageHandle(MapMessage mapMessage);
	}

	【说明】
	将消息的处理方法抽象出来，针对不同类型的消息可以实现不同的处理方法。

> 消息接收具体子类

	@Service
	public class ParentsQueueListener extends AbstractQueueListener {
	    private static final Logger log = LoggerFactory.getLogger(ParentsQueueListener.class);
	
	}

	【说明】
	消息处理的方法在抽象类中。
