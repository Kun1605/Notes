# OkHttp3

* [1、OkHttp简介](#1、OkHttp简介)
* [2、OkHttp使用](#2、OkHttp使用)


<a name="1、OkHttp简介"></a>
### 1、OkHttp简介 ###

- OkHttp 库的设计和实现的首要目标是高效。这也是选择 OkHttp 的重要理由之一。OkHttp 提供了对最新的 HTTP 协议版本 HTTP/2 和 SPDY 的支持，这使得对同一个主机发出的所有请求都可以共享相同的套接字连接。如果 HTTP/2 和 SPDY 不可用，OkHttp 会使用连接池来复用连接以提高效率。OkHttp 提供了对 GZIP 的默认支持来降低传输内容的大小。OkHttp 也提供了对 HTTP 响应的缓存机制，可以避免不必要的网络请求。当网络出现问题时，OkHttp 会自动重试一个主机的多个 IP 地址。

- Java 平台上的新一代 HTTP 客户端

<a name="2、OkHttp使用"></a>
### 2、OkHttp使用 ###

> 依赖包

	<dependency>
		<groupId>com.squareup.okhttp3</groupId>
		<artifactId>okhttp</artifactId>
		<version>3.8.1</version>
	</dependency>

> 初始化

	new OkHttpClient()只是一种快速创建OkHttpClient的方式，更标准的是使用 OkHttpClient.Builder()。
	后者可以设置一堆参数，例如超时时间什么的。

	new OkHttpClient.Builder()
			.connectTimeout(10, TimeUnit.SECONDS)
			.writeTimeout(10,TimeUnit.SECONDS)
			.readTimeout(20, TimeUnit.SECONDS)
			.build();

> 请求方式

	创建request对象时可以设置请求方式 get()/post(params)  ，在构建时默认设置请求方式为GET。

> Get请求

	public static void sendGet(String httpUrl){

		OkHttpClient okHttpClient = new OkHttpClient();
	
		Request request = new Request.Builder()
									.url(httpUrl)
									.build();

		try {
			Response response = okHttpClient.newCall(request).execute();
	
			if (!response.isSuccessful()){
				logger.error("服务端错误：{}",response);
			}
	
			//获取响应头
			Headers headers = response.headers();
			System.out.println("======响应头===========");
			for (int i = 0; i < headers.size(); i++) {
				System.out.println(headers.name(i)+":"+headers.value(i));
			}
			System.out.println("响应体："+response.body().string());
	
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	【注】
	System.out.println(response.body().string());
	response的body有很多种输出方法，string()只是其中之一，注意是string()不是toString()。
	如果是下载文件就是response.body().bytes()，另外可以根据response.code()获取返回的状态码。

> 添加/修改请求头参数

	如果你需要在request的的header添加参数。例如Cookie，User-Agent什么的，就是

	Request request = new Request.Builder()
				    .url(url)
				    .header("键", "值")
				    .addHeader("键", "值")
				    ...
				    .build();

> 实例

	public static void HeaderTest(String httpUrl){
		OkHttpClient client = new OkHttpClient();
		Request request = new Request.Builder()
				.url(httpUrl)
				.header("User-Agent", "My super agent")  //修改请求头的 User-Agent 信息
				.addHeader("Accept", "text/html")          //添加请求头
				.build();
	
		try {
			Response response = client.newCall(request).execute();
			if (!response.isSuccessful()){
				logger.error("服务端错误：{}",response);
			}
	
			//获取响应头的单个值
			System.out.println(response.header("Server"));
			//获取响应头的所有值
			System.out.println(response.headers("Set-Cookie"));
			//获取响应头
			Headers headers = response.headers();
			System.out.println("======响应头===========");
			for (int i = 0; i < headers.size(); i++) {
				System.out.println(headers.name(i)+":"+headers.value(i));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}


> Post请求

	OkHttpClient okHttpClient = new OkHttpClient();
	
	// 请求体
	RequestBody body = new FormBody.Builder()
	    .add("key", "value")
	    .add("key", "value")
	    ...
	    .build();
	
	// 将请求体加入post请求
	Request request = new Request.Builder()
	    .url(url)
	    .post(body)
	    .build();

	Call call = okHttpClient.newCall(request);
	try {
	    Response response = call.execute();
	    System.out.println(response.body().string());
	} catch (IOException e) {
	    e.printStackTrace();
	}

### 处理请求的方式【2种】： ###

> 1、直接执行请求

	try {
		//执行请求，返回响应
		Response response = client.newCall(request).execute();
		if (!response.isSuccessful()){
			logger.error("服务端错误：{}",response);
		}
		//响应体
		System.out.println(response.body().string());
	} catch (IOException e) {
		e.printStackTrace();
	}

> 2、异步操作请求

	//创建Call
	Call call = client.newCall(request);
	//加入队列，异步操作
	call.enqueue(new Callback() {
		//请求错误回调方法
		@Override
		public void onFailure(Call call, IOException e) {
			System.out.println("连接失败");
		}
	
		//处理响应回调方法
		@Override
		public void onResponse(Call call, Response response) throws IOException {
			if (!response.isSuccessful()){
				logger.error("服务端错误：{}",response);
			}
			//请求成功的响应体
			System.out.println(response.body().string());
		}
	});
	

> RequestBody的数据格式都要指定Content-Type，常见的有三种：

	application/x-www-form-urlencoded 	数据是个普通表单
	multipart/form-data 				数据里有文件,下载文件时使用
	application/json 					数据是json

> FormBody继承了RequestBody，它已经指定了数据类型为application/x-www-form-urlencoded。

	/**
	 * 发送 post请求
	 * 请求参数为 K/V
	 * @param httpUrl
	 */
	public static void sendPost(String httpUrl){
		
		OkHttpClient client = new OkHttpClient();
	
	   //创建请求体
		RequestBody requestBody = new FormBody.Builder()
				.add("username","alex")
				.add("passwd","123456")
				.build();
	
		//创建request对象，加入请求体
		Request request = new Request.Builder()
				.url(httpUrl)
				.post(requestBody)
				.build();
	
		try {
			//执行请求，返回响应
			Response response = client.newCall(request).execute();
			if (!response.isSuccessful()){
				logger.error("服务端错误：{}",response);
			}

			//响应体
			System.out.println(response.body().string());

		} catch (IOException e) {
			e.printStackTrace();
		}
	}


	/**
	 * 发送 post请求
	 * 参数为 json字符串
	 * @param httpUrl
	 */
	public static void sendPostJson(String httpUrl){
	
		User user = new User();
		user.setUsername("alex");
		user.setPasswd("123456");
		ObjectMapper objectMapper = new ObjectMapper();
		String jsonStr = null ;
		try {
			//转换成JSON格式字符串
			jsonStr = objectMapper.writeValueAsString(user);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		OkHttpClient client = new OkHttpClient();
	
		//MediaType  设置Content-Type 标头中包含的媒体类型值
		MediaType mediaType = MediaType.parse("application/json; charset=utf-8");

		//请求体
		RequestBody requestBody = FormBody.create(mediaType,jsonStr);
	
		Request request = new Request.Builder()
				.url(httpUrl)
				.post(requestBody)
				.build();
		
		//创建Call
		Call call = client.newCall(request);
		//加入队列，异步操作
		call.enqueue(new Callback() {
			//请求错误回调方法
			@Override
			public void onFailure(Call call, IOException e) {
				System.out.println("连接失败");
			}
	
			//处理响应回调方法
			@Override
			public void onResponse(Call call, Response response) throws IOException {
				if (!response.isSuccessful()){
					logger.error("服务端错误：{}",response);
				}
				//请求成功的响应体
				System.out.println(response.body().string());
			}
		});
	}



	
