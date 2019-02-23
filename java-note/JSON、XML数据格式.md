# JSON、XML数据格式

* [1、JSON数据格式](#1、JSON数据格式)
* [2、XML数据格式](#2、XML数据格式)
* [3、JSON、XML比较](#3、JSON、XML比较)

<a name="1、JSON数据格式"></a>
### 1、JSON数据格式 ###

- json简介：JSON的全称是JavaScript Object Notation，是一种轻量级的**数据交换格式**。 
- 特点：JSON与 XML具有相同的特性，例如**易于人编写和阅读**，易于机器生成和解析。但是 JSON比XML数据传输的有效性要高出很多。JSON采用兼容性很高的、完全独立于语言的文本格式，在**不同平台之间**进行数据交换。
- 数据格式
> JSON的数据格式是键/值对，其中值可以是:

	1. 数字（整数或浮点数）
	2. 字符串（在双引号中）
	3. 逻辑值（true 或 false）
	4. 数组（在方括号中）
	5. 对象（在花括号中）
	6. null

> 样式：
	
	{  
	  "brand": "Mercedes",  
	  "doors": 5,  
	  "owner": {  
	    "first": "Gatsby",  
	    "last": "Newton"  
	  },  
	  "component": ["engine", "brake"]  
	}  

#### json工具 ####
- 1、Jackson
> Jackson的在线API文档可以在http://wiki.fasterxml.com/JacksonInFiveMinutes中找到。  
> Jackson的源代码托管在：https://github.com/FasterXML/jackson。  
> Jackson提供了两种不同的JSON解析器  

	1. ObjectMapper：把JSON解析到自定义的Java类中，或者解析到一个Jackson指定的树形结构中（Tree model）;
	2. Jackson JsonParser：一种“拉式”（pull）解析器，每次解析一组JSON数据。

> Jackson提供了两种不同的JSON生成器  

	1. ObjectMapper：把自定义的Java类，或者一个Jackson指定的树形结构生成为JSON文件;
	2. Jackson JsonGenerator：每次只生成一组JSON数据。
	
> Jackson的安装 

	Jackson包含一个core JAR，和两个依赖core JAR的JAR;
	Jackson Core
	Jackson Annotations
	Jackson Databind
	其中Jackson Annotations依赖Jackson Core，Jackson Databind依赖Jackson Annotations。

	<dependency>  
	      <groupId>com.fasterxml.jackson.core</groupId>  
	      <artifactId>jackson-databind</artifactId>  
	      <version>${jackson-version}</version>  
	</dependency>  
	<dependency>  
	      <groupId>com.fasterxml.jackson.core</groupId>  
	      <artifactId>jackson-core</artifactId>  
	      <version>${jackson-version}</version>  
	</dependency>  
	<dependency>  
	      <groupId>com.fasterxml.jackson.core</groupId>  
	      <artifactId>jackson-annotations</artifactId>  
	      <version>${jackson-version}</version>  
	</dependency>
		 
> 使用ObjectMapper生成、解析JSON 数据

	com.fasterxml.jackson.databind.ObjectMapper在Jackson Databind中。
	ObjectMapper是JSON操作的核心，Jackson的所有JSON操作都是在ObjectMapper中实现。 
	ObjectMapper有多个JSON序列化的方法，可以把JSON字符串保存File、OutputStream等不同的介质中。

> objectMapper 配置

	//对象的所有字段全部列入【默认】
    objectMapper.setSerializationInclusion(Inclusion.ALWAYS);

    //取消默认转换timestamps形式【默认为true】
    objectMapper.configure(SerializationConfig.Feature.WRITE_DATES_AS_TIMESTAMPS,false);

    //忽略空Bean转json的错误，防止报异常【默认为true】
    objectMapper.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS,false);

    //所有的日期格式都统一为以下的样式，即yyyy-MM-dd HH:mm:ss
    objectMapper.setDateFormat(new SimpleDateFormat(DateTimeUtil.STANDARD_FORMAT));

    //忽略 在json字符串中存在，但是在java对象中不存在对应属性的情况，防止错误【默认为true】
    objectMapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES,false);

> ObjectMapper将数据转换为JSON格式【JSON序列化】  

	1. writeValue(File arg0, Object arg1)			把arg1转成json序列，并保存到arg0文件中。 
	2. writeValue(OutputStream arg0, Object arg1)	把arg1转成json序列，并保存到arg0输出流中。 
	3. writeValueAsBytes(Object arg0)				把arg0转成json序列，并把结果输出成字节数组。 
	4. writeValueAsString(Object arg0)				把arg0转成json序列，并把结果输出成字符串。 
	
> 生成JSON 字符串

	public static void writeToString(){

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date birthday = null;
        try {
            birthday = simpleDateFormat.parse("1990-01-01");
        } catch (ParseException e) {
            e.printStackTrace();
        }
        User user = new User("alex","M",26,birthday);

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            //User类转JSON
            String json = objectMapper.writeValueAsString(user);
            System.out.println("userJson:"+json);
            //userJson:{"name":"alex","gender":"M","age":25,"birthday":631123200000}

            //Java集合转JSON
            List<User> users = new ArrayList<>();
            users.add(user);
            String listJson = objectMapper.writeValueAsString(users);
            System.out.println("listJson:"+listJson);
            //listJson:[{"name":"alex","gender":"M","age":25,"birthday":631123200000}]
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
    }

> 生成为JSON 格式字符串到file中

	public static void writeToFile(){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date birthday = null;
        try {
           birthday = simpleDateFormat.parse("1990-01-01");
        } catch (ParseException e) {
            e.printStackTrace();
        }
        User user = new User("alex","M",26,birthday);
        ObjectMapper objectMapper = new ObjectMapper();
        OutputStream outputStream = null;
        try {
            outputStream = new FileOutputStream(new File("src/main/java/com/hdc/json/car2.json"));
            objectMapper.writeValue(outputStream,user);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (JsonGenerationException e) {
            e.printStackTrace();
        } catch (JsonMappingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if (outputStream != null){
                try {
                    outputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

> ObjectMapper解析JSON【JSON反序列化】  

	ObjectMapper可以从String，File，InputStream，URL，自定义的Java类等中读取JSON；
	1. <T> readValue(String json, Class<T> valueType) 将json 解析到自定义类【T】中

> 解析json字符串

    public static void readFromString() {

        String carJson = "{ \"brand\" : \"Mercedes\"," +
                "  \"doors\" : 5," +
                "  \"owners\" : [\"John\", \"Jack\", \"Jill\"]," +
                "  \"nestedObject\" : { \"field\" : \"value\" } }";

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            //读取json 字符串，返回json 格式
            JsonNode jsonNode = objectMapper.readValue(carJson,JsonNode.class);
            System.out.println("jsonNode="+jsonNode);
            //jsonNode={"brand":"Mercedes","doors":5,"owners":["John","Jack","Jill"],"nestedObject":{"field":"value"}}

            //value 为字符串
            JsonNode brandNode = jsonNode.get("brand");
            String brand = brandNode.asText();
            System.out.println("brand:"+brand);

            //value 为数字
            JsonNode doorsNode = jsonNode.get("doors");
            int doors = doorsNode.asInt();
            System.out.println("doors:"+doors);

            //value 为数组
            JsonNode owners = jsonNode.get("owners");
            JsonNode ownersNode = owners.get(1);
            String owner = ownersNode.asText();
            System.out.println("owner:"+owner);

            //value 为对象
            JsonNode nestNode = jsonNode.get("nestedObject");
            JsonNode fieldNode = nestNode.get("field");
            String field = fieldNode.asText();
            System.out.println("field:"+field);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

> 解析JSON到Java类【POJO类】

	public static void readToPOJO(){

        String json = "{ \"name\": \"Gatsby\","
                + "  \"gender\": \"MALE\","
                + "  \"age\": 24"
                + "}";

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            User user = objectMapper.readValue(json,User.class);
            System.out.println("user:"+user);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

> 从File中解析JSON

	public static void readFromFile(){
        try {
            String path = "src/main/java/com/hdc/json/car.json";

            // Read JSON from an InputStream.
            InputStream input = new FileInputStream(path);
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode node = objectMapper.readValue(input, JsonNode.class);

            JsonNode brandNode = node.get("brand");
            String brand = brandNode.asText();
            System.out.println("brand = " + brand);

            JsonNode doorsNode = node.get("doors");
            Integer doors = doorsNode.asInt();
            System.out.println("doors = " + doors);

            JsonNode ownerNode = node.get("owner");
            JsonNode nameNode = ownerNode.get("first");
            String first = nameNode.asText();
            System.out.println("first = " + first);

            JsonNode comsNode = node.get("component");
            JsonNode comNode = comsNode.get(0);
            String component = comNode.asText();
            System.out.println("component = " + component);
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

- 2、FastJson
> 特点

	Fastjson是解析速度最快的json解析工具；
	支持将Java Bean序列化为JSON字符串，也可以从JSON字符串反序列化到JavaBean；
	JSON这个类是fastjson API的入口，主要的功能都通过这个类提供,它的方法都是静态类。
> 依赖包

	<dependency>
	    <groupId>com.alibaba</groupId>
	    <artifactId>fastjson</artifactId>
	    <version>x.x.x</version>
	</dependency>

> 序列化API【参考源码】

	1. public static String toJSONString(Object object, SerializerFeature... features);
		将Java对象序列化为JSON字符串，支持各种各种Java基本类型和JavaBean
	
	2. public static byte[] toJSONBytes(Object object, SerializerFeature... features);
		将Java对象序列化为JSON字符串，返回JSON字符串的utf-8 bytes
	
	3. 将Java对象序列化为JSON字符串，写入到Writer中
	4. 将Java对象序列化为JSON字符串，按UTF-8编码写入到OutputStream中
	......

> JSON字符串反序列化API【参考源码】

	1. public static <T> T parseObject(String text, Class<T> clazz, Feature... features)
		将JSON字符串反序列化为JavaBean
	
	2. public static <T> T parseObject(byte[] input, Type clazz, Feature... features)
		将JSON字符串反序列化为JavaBean
	
	3. public static JSONObject parseObject(String text);
		将JSON字符串反序列为JSONObject
	......

	解析时增加参数不调整顺序，避免顺序错乱
	JSONObject.parseObject(jsonStr, Feature.OrderedField);

> JSONObject对象--针对JSON对象，可以直接使用JSON的方法，可以理解为**Map<String, Object>**

	public class JSONObject extends JSON implements Map<String, Object>, Cloneable, Serializable, InvocationHandler
	
	//JSON解析为 JSONObject 对象,并获取key的值
    String str = JSONObject.parseObject(string).getString("birthday");
    System.out.println("birthday="+str);

	//将POJO 转为JSON 对象
    Object o1 = JSONObject.toJSON(users); 

> JSONArray对象--针对JSON 数组，可以直接使用JSON的方法，可以理解为**List<Object>**

	public class JSONArray extends JSON implements List<Object>, Cloneable, RandomAccess, Serializable
	
	//将 JSON 字符串解析为 List
    List<User> users1 =  JSONArray.parseArray(o1.toString(),User.class);
    for (User u:users1
         ) {
        System.out.println(u);
    }

<a name="2、XML数据格式"></a>
### 2、XML数据格式 ###

- 扩展标记语言 (Extensible Markup Language, XML) ，用于标记电子文件使其具有结构性的标记语言，可以用来标记数据、定义数据类型，是一种允许用户对自己的标记语言进行定义的源语言。
-  XML格式统一，**跨平台和语言**，是标准通用标记语言 (SGML) 的子集，非常适合 Web 传输。
- XML 提供统一的方法来描述和交换独立于应用程序或供应商的结构化数据。
- xml文件属于树形结构【主节点，子节点，属性名，属性值】
> 格式

	<?xml version="1.0" encoding="UTF-8"?>
	<root>
		<child index="value"></child>
		<child >
			<index>value</index>
		</child>
	</root>

- 解析 xml 文件【主节点，子节点，属性名，属性值】
- 基础方法：DOM,SAX
- 扩展方法：JDOM,DOM4J 【需要导入jar包】 
> 1、DOM 方式解析xml步骤：

	1. 创建一个DocumentBuilderFactory 对象；
	2. 创建一个DocumentBuilder 对象；
	3. 通过 DocumentBuilder 对象的parse(String fileName) 方法解析xml 文件。
		
> 2、SAX 方式解析xml步骤：
		
	1. 创建一个 SAXParserFactory 对象；
	2. 创建一个 SAXParser 对象；
	3. 通过 SAXParser 对象的parse(String fileName,DefaultHandle saxParserHandle) 方法解析xml 文件；
	4. 创建 saxParserHandle ， 继承DefaultHandle ，实现 startElement方法【用来遍历xml文件的开始标签】；
	5. 具体操作都在handler里面完成。
		
> 3、JDOM 方式解析xml步骤：
		
	1. 获取 SAXBuilder 对象；
	2. 通过SAXBuilder 对象的 build方法获取 Document 对象；
	3. 通过 Document 对象获取根节点；
	4. 获取根节点下的子节点集合；
	5. 获取属性集合。
	
> 4、【推荐使用】DOM4J 方式解析xml步骤：
		
	1. 创建 SAXReader 对象；
	2. 通过SAXReader 对象的read方法加载xml 文件,获取 Document 对象；
	3. 通过 Document 对象获取根节点；
	4. 获取指定节点的迭代；
	5. 遍历迭代获取属性。

> DOM4J 方式解析xml

	<dependency>
	  <groupId>org.dom4j</groupId>
	  <artifactId>dom4j</artifactId>
	  <version>2.1.0</version>
	</dependency>

	package com.hdc.DOM4Jxml;
	import org.dom4j.Attribute;
	import org.dom4j.Document;
	import org.dom4j.DocumentException;
	import org.dom4j.Element;
	import org.dom4j.io.SAXReader;
	import java.util.Iterator;
	import java.util.List;
	
	public class DOM4JReadXML {
	
	    public static void main(String[] args) {
	        DOM4JReadXml();
	
	    }
	
	    public static void DOM4JReadXml() {
	        //1、创建 SAXReader 对象
	        SAXReader saxReader = new SAXReader();
	
	        //2、通过SAXReader 对象的read方法加载xml 文件,获取 Document 对象
	        try {
	            Document document = saxReader.read("src/main/resources/student.xml");
	            //3、通过  Document 对象获取根节点
	            Element element = document.getRootElement();
	            //4、获取指定节点的迭代
	            Iterator iterator = element.elementIterator("group");
	
	            while (iterator.hasNext()){
	                System.out.println("=========开始遍历==========");
	                Element ele = (Element) iterator.next();
	                //获取属性名及属性值
	               List<Attribute> attributeList = ele.attributes();
	                for (Attribute attr:attributeList
	                     ) {
	                    System.out.println("属性名："+attr.getName()+" 属性值："+attr.getValue());
	                }
	
	                Iterator iteratorC  = ele.elementIterator();
	                while (iteratorC.hasNext()){
	                    Element elementC = (Element) iteratorC.next();
	                    System.out.println("子节点："+elementC.getName()+ " 子节点值："+elementC.getStringValue());
	                }
	
	                System.out.println("=========结束遍历==========");
	            }
	
	        } catch (DocumentException e) {
	            e.printStackTrace();
	        }
	    }
	}

> DOM4J 方式创建 xml步骤：
	
	1. 创建 Document 对象，代表整个xml 文档；
	2. 创建根节点 rss,并添加属性；
	3. 生成子节点并添加属性及内容；
	4. 设置生成xml的格式；
	5. 生成xml 文件,并指定xml格式；
	6. 写入xml文档；
	7. 关闭写入。
	
> DOM4J 方式创建 xml

	<dependency>
		<groupId>org.dom4j</groupId>
		<artifactId>dom4j</artifactId>
		<version>2.1.0</version>
	</dependency>

	package com.hdc.DOM4Jxml;
	import org.dom4j.Document;
	import org.dom4j.DocumentHelper;
	import org.dom4j.Element;
	import org.dom4j.io.OutputFormat;
	import org.dom4j.io.XMLWriter;
	import java.io.*;
	
	public class DOM4JCreateXml {
	    public static void main(String[] args) {
	        createXML();
	    }
	
	    private static void createXML(){
	        //1、创建 Document 对象，代表整个xml 文档
	        Document document = DocumentHelper.createDocument();
	
	        //2、创建根节点 rss,并添加属性
	        Element elementRoot = document.addElement("rss");
	        elementRoot.addAttribute("namespace","default");
	
	        //3、生成子节点并添加属性及内容
	        Element elementChild = elementRoot.addElement("channel");
	        elementChild.addAttribute("index","1");
	        Element title = elementChild.addElement("title");
	        Element decription = elementChild.addElement("decription");
	        //在<></>中间添加内容
	        title.setText("国内最新新闻");
	        decription.setText("<![CDATA[国内最新新闻]]>");
	
	        //4、设置生成xml的格式
	        OutputFormat outputFormat = OutputFormat.createPrettyPrint();
	        outputFormat.setEncoding("GBK");
	
	        //5、生成xml 文件,并指定xml格式
	        File file = new File("src/main/resources/test.xml");
	        try {
	            XMLWriter xmlWriter = new XMLWriter(new FileOutputStream(file),outputFormat);
	
	            //设置是否转义，默认是true,代表转义
	            xmlWriter.setEscapeText(false);
	
	            //6、写入xml文档
	            xmlWriter.write(document);
	
	            //7、关闭写入
	            xmlWriter.close();
	            System.out.println("xml文档生成完毕");
	        } catch (UnsupportedEncodingException e) {
	            e.printStackTrace();
	        } catch (FileNotFoundException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	}

> 结果 test.xml

	<?xml version="1.0" encoding="GBK"?>
	<rss namespace="default">
		<channel index="1">
			<title>国内最新新闻</title>
			<decription><![CDATA[国内最新新闻]]></decription>
		</channel>
	</rss>

<a name="3、JSON、XML比较"></a>
### 3、JSON、XML比较 ###

> 3.1、XML的优缺点  
> 3.1.1、XML的优点

	1. 格式统一，符合标准；
	2. 容易与其他系统进行远程交互，数据共享比较方便。
	
> 3.1.2、XML的缺点
		
	1. XML文件庞大，文件格式复杂，传输占带宽；
	2. 服务器端和客户端都需要花费大量代码来解析XML，导致服务器端和客户端代码变得异常复杂且不易维护；
	3. 客户端不同浏览器之间解析XML的方式不一致，需要重复编写很多代码；
	4. 服务器端和客户端解析XML花费较多的资源和时间。

> 3.2、JSON的优缺点  
> 3.2.1、JSON的优点

	1. 数据格式比较简单，易于读写，格式都是压缩的，占用带宽小；
	2. 易于解析，客户端JavaScript可以简单的通过eval()进行JSON数据的读取；
	3. 支持多种语言，包括ActionScript, C, C#, ColdFusion, Java, JavaScript, Perl, PHP, Python, Ruby等服务器端语言，便于服务器端的解析；
	4. 在PHP世界，已经有PHP-JSON和JSON-PHP出现了，偏于PHP序列化后的程序直接调用，PHP服务器端的对象、数组等能直接生成JSON格式，便于客户端的访问提取；
	5. 因为JSON格式能直接为服务器端代码使用，大大简化了服务器端和客户端的代码开发量，且完成任务不变，并且易于维护。

> 3.2.2、JSON的缺点

	1. 没有XML格式这么推广的深入人心和喜用广泛，没有XML那么通用性；
	2. JSON格式目前在Web Service中推广还属于初级阶段。