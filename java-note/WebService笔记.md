# WebService #

* [1、WebService简介](#1、WebService简介)
* [2、WebService特点](#2、WebService特点)
* [3、WebService开发](#3、WebService开发)
* [4、WebService拦截器](#4、WebService拦截器)
* [5、WSDL文档结构](#5、WSDL文档结构)

<a name="1、WebService简介"></a>
### 1、WebService简介 ###

- WebService是一种跨编程语言和跨操作系统平台的远程调用技术。
- 所谓远程调用，就是一台计算机a上的一个程序可以调用到另外一台计算机b上的一个对象的方法。
- 譬如，银联提供给商场的pos刷卡系统，商场的POS机转账调用的转账方法的代码其实是跑在银行服务器上。
- 再比如淘宝网，百度等把自己的系统服务以webservice服务的形式暴露出来，让第三方网站和程序可以调用这些服务功能，这样扩展了自己系统的市场占有率，就是所谓的SOA应用。
- WebService就是**一个应用程序向外界暴露出一个能通过Web进行调用**的API，也就是说能用编程的方法通过Web来调用这个应用程序。
- 我们把调用这个WebService的应用程序叫做客户端，而把提供这个WebService的应用程序叫做服务端。
- 从深层次看，WebService是建立可互操作的分布式应用程序的新平台，是一个平台，是一套标准。
通过使用 WebService，您可以在不同的应用程序与平台之间来交换数据。

<a name="2、WebService特点"></a>
### 2、WebService特点 ###

> WebService 服务的三种途径：
  
	1. Endpoint
        Web 服务的URL 地址，你访问之后就会出现 web 服务的相关类描述、方法列表以及方法描述。
        服务的终端接口，WEBService用来处理客户端请求的接口。

    2. Disco
        通过它可以找到该web 服务礼仪了发现机制中的那种发现机制disco

    3. WSDL
        WebService 服务的描述性语言【web service description language】。
        用来描述 WebService 服务端和客户端应用交互时传递请求和响应数据的格式和方式。
        对应一种类型的文件 .wsdl。
        一个webservice 请求对应一个唯一的 wsdl 文件

> 基础的 WebService 平台是 XML + HTTP。

     HTTP 协议是最常用的因特网协议。
     XML 提供了一种可用于不同的平台和编程语言之间的语言,调用WebService后返回xml格式的数据。

> Webservice 平台的三大元素：

     SOAP (简易对象访问协议)
        基于 XML + HTTP 的协议，用于在WEB 上交换结构化的数据；
        soap 消息：请求消息 和 响应消息；
        消息格式：http请求 + xml 片段；

     UDDI (通用描述、发现及整合)

     WSDL (Web services 描述语言)

> 一次 webservice 请求的流程：
  
	1. 客户端向服务端发送一个 soap 消息【http请求 + xml片段】；
    2. 服务端处理完请求后，向客户端返回一个 soap 消息。

<a name="3、WebService开发"></a>
### 3、WebService开发 ###

> 开发服务器端：

     @WebService : 用在类上或者接口上指定将此类/实现类发布成一个ws。
     ws 上的方法：
         1. 接口方法上加 @WebMethod(exclude=true)后，此方法不被发布；
         2. 静态方法不会被发布；
         3. 非静态的，会被发布，即供客户端调用的方法。


     【jdk方式】通过 EndPoint 的 publish() 方法发布一个WebService ，将对象绑定到一个地址的端口上。
     Endpoint.publish(address,implementor); //参数1：本地的服务地址;参数2：提供服务的类【添加@WebService的类】;

     CXF : 一个apache 的用于开发webservice 服务端和客户端的框架

     【CXF 方式实现】
         JaxWsServerFactoryBean factoryBean = new JaxWsServerFactoryBean();
         factoryBean.setAddress(address);    //设置暴露的地址
         factoryBean.setServiceBean(webservice); //设置接口类
         factoryBean.setServiceClass(Webservice.class); //设置接口实现类

         //服务端添加入口拦截器
         factoryBean.getInInterceptors().add(new MyInterceptor());
         //服务端添加出口拦截器
        //  factoryBean.getOutInterceptors().add(new LoggingOutInterceptor());

         factoryBean.create();   //创建webservice 接口

> CXF 支持传输的数据类型：
  
	1. 基础类型；
	2. 引用类型：string/数组/List/Set，不支持 Map
    3. 自定义类型

    不支持map 转换，需要自定义类型转换适配器【MapAdapter】,并标注在方法上
    @XmlJavaTypeAdapter(MapAdapter.class)
    Map<String,List<User>> getUsers();

    自定义类型转换适配器继承 XmlAdapter<T,E>类,泛型是需要转换的类型
    public class MapAdapter extends XmlAdapter<MyUsers[],Map<String,List<User>>>

> 客户端：
  
	工具自动生成【apache-cxf-3.1.15.zip】 下载网站：http://cxf.apache.org/download.html
    解压--> bin --> wsdl2java
    打开CMD
    C:\WINDOWS\system32> g:
    G:\> cd G:\Java\workSpace\webservice\webservice-client\src\main\java
    G:\Java\workSpace\webservice\webservice-client\src\main\java> wsdl2java  -encoding utf-8  http://192.168.1.60:8080/sayHello?wsdl
    即可自动生成客户端
    再创建main 程序入口类即可启动。

    利用 apache-cxf 工具根据提供的 wsdl 文件自动生成相应的代码。

<a name="4、WebService拦截器"></a>
### 4、WebService拦截器 ###

> 为了在webservice请求过程中,能动态操作请求和响应数据, CXF设计了拦截器。

    拦截器分类：
        按所处的位置分：服务端拦截器，客户端拦截器
        按消息的方向分：入拦截器，出拦截器
        按定义者分：系统拦截器，自定义拦截器

    基于jdk的webservice没有拦截器的功能实现；
    基于CXF框架就可以。

> 自定义拦截器【自定义拦截器都继承 AbstractPhaseInterceptor 】：
  
	public class MyInterceptor extends AbstractPhaseInterceptor<SoapMessage>


<a name="5、WSDL文档结构"></a>
### 5、WSDL文档结构 ###

    <!-- 用于请求 -->
    <xs:complexType name="sayHello">
        <xs:sequence>
            <xs:element minOccurs="0" name="arg0" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>
    <!-- 用于响应 -->
    <xs:complexType name="sayHelloResponse">
        <xs:sequence>
            <xs:element minOccurs="0" name="return" type="xs:string"/>
        </xs:sequence>
    </xs:complexType>

    <!--
        message: 用于定于消息结构
            part: 用于引用types 中定义的标签片段
     -->
    <wsdl:message name="sayHello">
        <wsdl:part element="tns:sayHello" name="parameters"></wsdl:part>
    </wsdl:message>
    <wsdl:message name="sayHelloResponse">
        <wsdl:part element="tns:sayHelloResponse" name="parameters"></wsdl:part>
    </wsdl:message>

    <!--
        portType: 用于定义服务端的 接口
            operation：用于指定接口中的处理请求的方法
                input: 指定客户端应用传来的数据，会引用 上面定义的<message>
                output: 指定服务端返回给客户端的数据，会引用 上面定义的<message>
     -->
    <wsdl:portType name="Webservice">
        <wsdl:operation name="getUsers">
            <wsdl:input message="tns:getUsers" name="getUsers"></wsdl:input>
            <wsdl:output message="tns:getUsersResponse" name="getUsersResponse"></wsdl:output>
        </wsdl:operation>
    </wsdl:portType>

    <!--
        wsdl:binding: 用于定义服务端的 接口的实现类
            type：引用上面的<portType>
            <soap:binding style="document"/> //绑定的是document-xml
            wsdl:operation: 用于定义实现的方法
                <soap:operation soapAction="" style="document"/> ：传输的是document-xml
                input: 指定客户端应用传来的数据，会引用 上面定义的<message>
                    body: 文本数据
                output: 指定服务端返回给客户端的数据，会引用 上面定义的<message>
                    body: 文本数据
     -->
    <wsdl:binding name="WebserviceImplServiceSoapBinding" type="tns:Webservice">
        <soap:binding style="document" transport="http://schemas.xmlsoap.org/soap/http"/>
        <wsdl:operation name="sayHello">
            <soap:operation soapAction="" style="document"/>
            <wsdl:input name="sayHello">
                <soap:body use="literal"/>
            </wsdl:input>
            <wsdl:output name="sayHelloResponse">
                <soap:body use="literal"/>
            </wsdl:output>
        </wsdl:operation>
    </wsdl:binding>

    <!--
        service: 服务端的一个 webservice的容器
            name：用于指定客户端容器类
            port: 用于指定服务器端处理请求的入口【接口的实现】
                binding: 引用上面定义的 <binding>
                address: 当前webservice 的请求地址

     -->
    <wsdl:service name="WebserviceImplService">
        <wsdl:port binding="tns:WebserviceImplServiceSoapBinding" name="WebserviceImplPort">
            <soap:address location="http://localhost:8080/webservice/te"/>
        </wsdl:port>
    </wsdl:service>



