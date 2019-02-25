# Dubbo 

* [1、背景](#1、背景)
* [2、概述](#2、概述)
* [3、架构](#3、架构)
* [4、负载均衡](#4、负载均衡)

> 官方文档

	http://dubbo.apache.org/#/docs/user/quick-start.md?lang=zh-cn

<a name="1、背景"></a>
### 1、背景 ###

- 随着互联网的发展，网站应用的规模不断扩大，常规的垂直应用架构已无法应对，分布式服务架构以及流动计算架构势在必行，亟需一个治理系统确保架构有条不紊的演进。

![](images/dubbo1.jpg)

* 单一应用架构

> 当网站流量很小时，只需一个应用，将所有功能都部署在一起，以减少部署节点和成本。此时，用于简化增删改查工作量的数据访问框架(ORM)是关键。

* 垂直应用架构

> 当访问量逐渐增大，单一应用增加机器带来的加速度越来越小，将应用拆成互不相干的几个应用，以提升效率。此时，用于加速前端页面开发的Web框架(MVC)是关键。

* 分布式服务架构

> 当垂直应用越来越多，应用之间交互不可避免，将核心业务抽取出来，作为独立的服务，逐渐形成稳定的服务中心，使前端应用能更快速的响应多变的市场需求。此时，用于提高业务复用及整合的分布式服务框架(RPC)是关键。


* 流动计算架构【微服务架构】

> 当服务越来越多，容量的评估，小服务资源的浪费等问题逐渐显现，此时需增加一个调度中心基于访问压力实时管理集群容量，提高集群利用率。此时，用于提高机器利用率的资源调度和治理中心(SOA)是关键。

<a name="2、概述"></a>
### 2、概述 ###

- Dubbo是阿里巴巴公司开源的一个高性能优秀的服务框架，使得应用可通过高性能的 RPC 实现服务的输出和输入功能，可以和Spring框架无缝集成。

> 主要核心部件编辑

	Remoting: 网络通信框架，实现了 sync-over-async 和 request-response 消息机制。
	RPC: 一个远程过程调用的抽象，支持负载均衡、容灾和集群功能【默认使用 Netty 】
	Registry: 服务目录框架用于服务的注册和服务事件发布和订阅【推荐使用 Zookeeper】


<a name="3、架构"></a>
### 3、架构 ###

![](images/dubbo2.jpg)

> 节点角色说明

| 节点 | 角色说明 |
|:------:| :------:|
| Provider  | 暴露服务的服务提供方 |
| Consumer  | 调用远程服务的服务消费方 |
| Registry  | 服务注册与发现的注册中心 |
| Monitor   | 统计服务的调用次数和调用时间的监控中心 |
| Container | 服务运行容器 |


> 调用关系说明

	0. 服务容器负责启动，加载，运行服务提供者。
	1. 服务提供者在启动时，向注册中心注册自己提供的服务。
	2. 服务消费者在启动时，向注册中心订阅自己所需的服务。
	3. 注册中心返回服务提供者地址列表给消费者，如果有变更，注册中心将基于长连接推送变更数据给消费者。
	4. 服务消费者，从提供者地址列表中，基于软负载均衡算法，选一台提供者进行调用，如果调用失败，再选另一台调用。
	5. 服务消费者和提供者，在内存中累计调用次数和调用时间，定时每分钟发送一次统计数据到监控中心。

> 配置命名空间说明【具体参数参考官方文档--schema配置参考手册】

| 标签 | 用途	| 解释 |
| :-: | :-: | :-: |
|<dubbo:registry/>|	注册中心配置| 用于配置连接注册中心相关信息|
| <dubbo:service/>| 服务配置| 用于暴露一个服务，定义服务的元信息，一个服务可以用多个协议暴露，一个服务也可以注册到多个注册中心|
|<dubbo:reference/>| 引用配置| 用于创建一个远程服务代理，一个引用可以指向多个注册中心|
|<dubbo:protocol/>| 协议配置| 用于配置提供服务的协议信息，协议由提供方指定，消费方被动接受|
|<dubbo:application/>| 应用配置| 用于配置当前应用信息，不管该应用是提供者还是消费者|
|<dubbo:module/>| 模块配置| 用于配置当前模块信息，可选|
|<dubbo:monitor/>| 监控中心配置| 用于配置连接监控中心相关信息，可选|
|<dubbo:provider/>| 提供方配置| 当 ProtocolConfig 和 ServiceConfig 某属性没有配置时，采用此缺省值，可选|
|<dubbo:consumer/>|	消费方配置| 当 ReferenceConfig 某属性没有配置时，采用此缺省值，可选|
|<dubbo:method/>|	方法配置| 用于 ServiceConfig 和 ReferenceConfig 指定方法级的配置信息|
|<dubbo:argument/>|	参数配置| 用于指定方法参数配置|

### 注册中心【Multicast、Zookeeper、Redis、Simple】  
> **Zookeeper** 是 Apacahe Hadoop 的子项目，是一个带有监听机制的树型目录服务，支持变更推送，适合作为 Dubbo 服务的注册中心，工业强度较高，可用于生产环境，并**推荐使用**

![](images/dubbo3.jpg)
### 流程说明：###

- 服务提供者启动时: 向 /dubbo/com.foo.BarService/providers 目录下写入自己的 URL 地址
- 服务消费者启动时: 订阅 /dubbo/com.foo.BarService/providers 目录下的提供者 URL 地址。并向 /dubbo/com.foo.BarService/consumers 目录下写入自己的 URL 地址
- 监控中心启动时: 订阅 /dubbo/com.foo.BarService 目录下的所有提供者和消费者 URL 地址。
- 底层使用 Netty 的长连接 header+body【序列化】进行数据传输

> 注册zookeeper的结果
	
	ls /dubbo/com.dubbo.service.OrderService/providers 

	[dubbo%3A%2F%2F192.168.79.1%3A20880%2Fcom.dubbo.service.OrderService%3Fanyhost%3Dtrue%26application%3D
	dubbo-provider%26dubbo%3D2.5.3%26interface%3Dcom.dubbo.service.OrderService%26methods%3DgetOrders%26owner%3D
	programmer%26pid%3D19660%26revision%3Dapi%26side%3Dprovider%26timestamp%3D1526954109913]

	url 解码后

	[dubbo://192.168.79.1:20880/com.dubbo.service.OrderService?anyhost=true&
	application=dubbo-provider&dubbo=2.5.3&interface=com.dubbo.service.OrderService&methods=getOrders&
	owner=programmer&pid=19660&revision=api&side=provider&timestamp=1526954109913]

### 支持以下功能：###

- 当提供者出现断电等异常停机时，注册中心能自动删除提供者信息
- 当注册中心重启时，能自动恢复注册数据，以及订阅请求
- 当会话过期时，能自动恢复注册数据，以及订阅请求
- 当设置 <dubbo:registry check="false" /> 时，记录失败注册和订阅请求，后台定时重试
- 可通过 <dubbo:registry username="admin" password="1234" /> 设置 zookeeper 登录信息
- 可通过 <dubbo:registry group="dubbo" /> 设置 zookeeper 的根节点，不设置将使用无根树
- 支持 * 号通配符 <dubbo:reference group="*" version="*" />，可订阅服务的所有分组和所有版本的提供者


> 依赖

	<dependency>
        <groupId>org.apache.zookeeper</groupId>
        <artifactId>zookeeper</artifactId>
        <version>3.4.9</version>
    </dependency>
	<-- zk客户端 -->
    <dependency>
        <groupId>com.101tec</groupId>
        <artifactId>zkclient</artifactId>
        <version>0.10</version>
    </dependency>

### 用法 -- 远程服务 Spring 配置 ###

- 将服务定义部分放在服务提供方 remote-provider.xml，将服务引用部分放在服务消费方 remote-consumer.xml。

- 并在提供方增加暴露服务配置 <dubbo:service>，在消费方增加引用服务配置 <dubbo:reference>


> dubbo-provider.xml

	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
	       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	       xmlns:dubbo="http://code.alibabatech.com/schema/dubbo"
	       xsi:schemaLocation="http://www.springframework.org/schema/beans
	       http://www.springframework.org/schema/beans/spring-beans.xsd
	       http://code.alibabatech.com/schema/dubbo
	       http://code.alibabatech.com/schema/dubbo/dubbo.xsd">
	
	    <!--定义了提供方应用信息，用于计算依赖关系；在 dubbo-admin 或 dubbo-monitor 会显示这个名字，方便辨识-->
	    <dubbo:application name="dubbo-provider" owner="programmer"/>
	
	    <!--注册服务，使用 zookeeper协议 作为注册中心暴露服务>
	    <dubbo:registry  protocol="zookeeper" address="192.168.1.30:2181,192.168.1.30:2182,192.168.1.30:2183" />
	
	    <!-- 默认用dubbo协议在20880端口暴露服务,默认端口是20880 ,使用json 序列化，默认是hessian2 -->
	    <dubbo:protocol name="dubbo" port="20880" serialization="json" />
	
	    <!--声明需要暴露的服务接口-->
	    <dubbo:service interface="dubbo.service.OrderService" ref="orderService"  />
	    <dubbo:service interface="dubbo.service.MemberService" ref="memberService"/>
	
	    <bean id="orderService" class="com.dubbo.service.impl.OrderServiceImpl"/>
	    <bean id="memberService" class="com.dubbo.service.impl.MemberServiceImpl"/>

	</beans>

	【注】提供方注册的接口的POJO需要序列化

> dubbo-consumer.xml

	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
	       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	       xmlns:dubbo="http://code.alibabatech.com/schema/dubbo"
	       xsi:schemaLocation="http://www.springframework.org/schema/beans
	       http://www.springframework.org/schema/beans/spring-beans.xsd
	       http://code.alibabatech.com/schema/dubbo
	       http://code.alibabatech.com/schema/dubbo/dubbo.xsd">
	
	    <!-- 消费方应用名，用于计算依赖关系，不要与提供方一样 -->
	    <dubbo:application name="dubbo-consumer" owner="programmer"/>
	
	    <!--向 zookeeper 订阅 provider 的地址，由 zookeeper 定时推送-->
	    <dubbo:registry  protocol="zookeeper" address="192.168.1.30:2181,192.168.1.30:2182,192.168.1.30:2183" />
	
	    <!-- 生成远程服务代理，可以和本地bean一样使用demoService -->
	    <dubbo:reference id="orderService" interface="dubbo.service.OrderService"/>
	    <dubbo:reference id="memberService" interface="dubbo.service.MemberService"/>
	
	</beans>


<a name="4、负载均衡"></a>
### 4、负载均衡 ###

- 在集群负载均衡时，Dubbo 提供了多种均衡策略，缺省为 random 随机调用,可以自行扩展负载均衡策略。  
> 负载均衡策略

	Random 随机，按权重设置随机概率。
	Roundrobin 轮询，按公约后的权重设置轮循比率。
	LeastActive  最少活跃数调用，相同活跃数的随机，活跃数指调用前后计数差。
	ConsistentHash 哈希一致性，相同参数的请求总是发到同一提供者。

- 配置
> 服务端服务级别

	<dubbo:service interface="..." loadbalance="roundrobin" />

> 客户端服务级别

	<dubbo:reference interface="..." loadbalance="roundrobin" />

> 服务端方法级别

	<dubbo:service interface="...">
	    <dubbo:method name="..." loadbalance="roundrobin"/>
	</dubbo:service>


> 客户端方法级别

	<dubbo:reference interface="...">
	    <dubbo:method name="..." loadbalance="roundrobin"/>
	</dubbo:reference>