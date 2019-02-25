
### Lombok插件 ###

[https://www.projectlombok.org/](https://www.projectlombok.org/ "官方网站")

> IDEA需要安装lombok插件才可使用

	<dependency>
		<groupId>org.projectlombok</groupId>
		<artifactId>lombok</artifactId>
		<version>1.16.10</version>
	</dependency>

> 提供简洁的注解使用

	使用 Lombok 可以减少很多重复代码的书写，简化代码。
	比如说getter/setter/toString等方法的编写。

	在类上标注 @Slf4j 后，可以直接在类中使用 log方法【slf4j + logback】。

> Lombok有哪些注解

	@Setter
	@Getter
	@Data	【包含了getter/setter】
	@Log(这是一个泛型注解，具体有很多种形式--@Slf4j/@Log4j/@CommonsLog/...)
	@AllArgsConstructor【全参构造器】
	@NoArgsConstructor【无参构造器】
	@EqualsAndHashCode【重写Equals和HashCode】
	@NonNull
	@Cleanup
	@ToString
	@RequiredArgsConstructor
	@Value
	@SneakyThrows
	@Synchronized

> 例子

	@Getter
	@Setter
	@NoArgsConstructor
	@AllArgsConstructor
	public class Cart {
	
	    private Integer id;
	
	    private Integer userId;
	
	    private Integer productId;
	
	    private Integer quantity;
	
	    private Integer checked;
	
	    private Date createTime;
	
	    private Date updateTime;
	
	}