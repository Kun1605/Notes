# httpClient #

### 简介 ###

- HttpClient相比传统JDK自带的URLConnection，增加了易用性和灵活性（具体区别，日后我们再讨论），它不仅是客户端发送Http请求变得容易，而且也方便了开发人员测试接口（基于Http协议的），即提高了开发的效率，也方便提高代码的健壮性。
- HttpClient是Apache Jakarta Common下的子项目，用来提供高效的、最新的、功能丰富的支持HTTP协议的客户端编程工具包
- [英文文档](http://hc.apache.org/httpcomponents-client-ga/tutorial/html/index.html)

### 特性 ###

	1. 基于标准、纯净的java语言。实现了Http1.0和Http1.1
	
	2. 以可扩展的面向对象的结构实现了Http全部的方法（GET, POST, PUT, DELETE, HEAD, OPTIONS, and TRACE）。
	
	3. 支持HTTPS协议。
	
	4. 通过Http代理建立透明的连接。
	
	5. 利用CONNECT方法通过Http代理建立隧道的https连接。
	
	6. Basic, Digest, NTLMv1, NTLMv2, NTLM2 Session, SNPNEGO/Kerberos认证方案。
	
	7. 插件式的自定义认证方案。
	
	8. 便携可靠的套接字工厂使它更容易的使用第三方解决方案。
	
	9. 连接管理器支持多线程应用。支持设置最大连接数，同时支持设置每个主机的最大连接数，发现并关闭过期的连接。
	
	10. 自动处理Set-Cookie中的Cookie。
	
	11. 插件式的自定义Cookie策略。
	
	12. Request的输出流可以避免流中内容直接缓冲到socket服务器。
	
	13. Response的输入流可以有效的从socket服务器直接读取相应内容。
	
	14. 在http1.0和http1.1中利用KeepAlive保持持久连接。
	
	15. 直接获取服务器发送的response code和 headers。
	
	16. 设置连接超时的能力。
	
	17. 实验性的支持http1.1 response caching。
	
	18. 源代码基于Apache License 可免费获取。

### 使用方法 ###

> 使用HttpClient发送请求、接收响应很简单，一般需要如下几步即可。

	1. 创建 HttpClient 对象。
	
	2. 创建请求方法的实例，并指定请求URL。
		如果需要发送 GET 请求，创建 HttpGet 对象；
		如果需要发送 POST 请求，创建 HttpPost 对象。
	
	3. 如果需要发送请求参数，可调用HttpGet、HttpPost共同的setParams(HttpParams params)方法来添加请求参数；
		对于HttpPost对象而言，也可调用setEntity(HttpEntity entity)方法来设置请求参数。
	
	4. 调用HttpClient对象的execute(HttpUriRequest request)发送请求，该方法返回一个HttpResponse。
	
	5. 调用 HttpResponse 的 getAllHeaders()、getHeaders(String name)等方法可获取服务器的响应头；
		调用HttpResponse的getEntity()方法可获取HttpEntity对象，该对象包装了服务器的响应内容。
		程序可通过该对象获取服务器的响应内容。
	
	6. 释放连接。无论执行方法是否成功，都必须释放连接。


> POST 参数格式 

	1. json格式

	    if(null != headers) {
	        for (String name : headers.keySet()) {
	            httpPost.setHeader(name, headers.get(name));
	        }
	    }
	
	    StringEntity entity = new StringEntity(json, HTTP.UTF_8);
	    httpPost.setEntity(entity);
	    entity.setContentType("application/json");
	
	    CloseableHttpResponse response = httpClient.execute(httpPost, context);
	
		response.setLocale(Locale.CHINESE);
	
	    if(response.getStatusLine().getStatusCode()==HttpStatus.SC_OK){
	        entity = response.getEntity() ;
	
	        String html = EntityUtils.toString(entity, charSet);
	        response.close();
	    }

	2. urlencoded格式

	    StringEntity entity = new StringEntity(postDataEncode, HTTP.UTF_8);
	
	    entity.setContentType("application/x-www-form-urlencoded");
	
	    httpPost.setEntity(entity);
	
	    CloseableHttpResponse response = httpClient.execute(httpPost, context);
                
	3. key-value格式

	    if(null != params) {
	        List<NameValuePair> nvps = new ArrayList<NameValuePair>();
	        for (String name : params.keySet()) {
	            nvps.add(new BasicNameValuePair(name, params.get(name)));
	        }
	        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
	    }

	4. 文件格式  
     
        FileBody bin = new FileBody(new File("F:\\image\\sendpix0.jpg"));   
        StringBody comment = new StringBody("A binary file of some kind", ContentType.TEXT_PLAIN);   
 
        HttpEntity reqEntity = MultipartEntityBuilder.create().addPart("bin", bin).addPart("comment", comment).build();   
 
        httppost.setEntity(reqEntity);   
   
        CloseableHttpResponse response = httpclient.execute(httppost);   

> 最简单post请求

	public static void main(String[] args) throws Exception{  

        List<NameValuePair> formparams = new ArrayList<NameValuePair>();  
        formparams.add(new BasicNameValuePair("account", ""));  
        formparams.add(new BasicNameValuePair("password", ""));  
        HttpEntity reqEntity = new UrlEncodedFormEntity(formparams, "utf-8");  
    
        RequestConfig requestConfig = RequestConfig.custom()  
        		.setConnectTimeout(5000)	
                .setSocketTimeout(5000)		  
                .setConnectionRequestTimeout(5000)  
                .build();  
    
        HttpClient client = new DefaultHttpClient();  
        HttpPost post = new HttpPost("http://cnivi.com.cn/login");  
        post.setEntity(reqEntity);  
        post.setConfig(requestConfig);  
        HttpResponse response = client.execute(post);  
    
        if (response.getStatusLine().getStatusCode() == 200) {  
            HttpEntity resEntity = response.getEntity();  
            String message = EntityUtils.toString(resEntity, "utf-8");  
            System.out.println(message);  
        } else {  
            System.out.println("请求失败");  
        }  
    }  


> RequestConfig的配置

	public void requestConfig(){  

		//新建一个RequestConfig：  
        RequestConfig defaultRequestConfig = RequestConfig.custom()  
            //一、连接目标服务器超时时间：ConnectionTimeout-->指的是连接一个url的连接等待时间  
            .setConnectTimeout(5000)  
            //二、读取目标服务器数据超时时间：SocketTimeout-->指的是连接上一个url，获取response的返回等待时间  
            .setSocketTimeout(5000)  
            //三、从连接池获取连接的超时时间:ConnectionRequestTimeout  
            .setConnectionRequestTimeout(5000)  
            .build();  
	           
		//这个超时可以设置为客户端级别,作为所有请求的默认值：  
		CloseableHttpClient httpclient = HttpClients.custom()  
	            .setDefaultRequestConfig(defaultRequestConfig)  
	            .build();  
    }  
