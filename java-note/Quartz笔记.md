# Quartz #
	
> Quartz关键属性  
> 1、Job：

	是一个接口，只有一个方法void execute(JobExecutionContext context)，开发者实现该接口定义运行任务，JobExecutionContext类提供了调度上下文的各种信息。
	Job运行时的信息保存在 JobDataMap 实例中；
		
> 2、JobDetail：

	Quartz在每次执行Job时，都重新创建一个Job实例，所以它不直接接受一个Job的实例，相反它接收一个Job实现类，以便运行时通过newInstance()的反射机制实例化Job。
	因此需要通过一个类来描述Job的实现类及其它相关的静态信息，如Job名字、描述、关联监听器等信息，JobDetail承担了这一角色。
	通过该类的构造函数可以更具体地了解它的功用：JobDetail(java.lang.String name, java.lang.String group, java.lang.Class jobClass)，该构造函数要求指定Job的实现类，以及任务在Scheduler中的组名和Job名称。
	
> 3、Trigger：

	是一个类【触发器】，描述触发Job执行的时间触发规则。主要有SimpleTrigger和CronTrigger这两个子类。
	当仅需触发一次或者以固定时间间隔周期执行，SimpleTrigger是最适合的选择；
	而CronTrigger则可以通过Cron表达式定义出各种复杂时间规则的调度方案：
	如每早晨9:00执行，周一、周三、周五下午5:00执行等；
		
> 4、Scheduler：

	调度器，代表一个Quartz的独立运行容器。
	Trigger和JobDetail可以注册到Scheduler中，两者在Scheduler中拥有各自的组及名称，组及名称是Scheduler查找定位容器中某一对象的依据，Trigger的组及名称必须唯一，JobDetail的组和名称也必须唯一（但可以和Trigger的组和名称相同，因为它们是不同类型的）。
	Scheduler定义了多个接口方法，允许外部通过组及名称访问和控制容器中Trigger和JobDetail。
	
	Scheduler可以将Trigger绑定到某一JobDetail中，这样当Trigger触发时，对应的Job就被执行。
	一个Job可以对应多个Trigger，但一个Trigger只能对应一个Job。可以通过SchedulerFactory创建一个Scheduler实例。
	Scheduler拥有一个SchedulerContext，它类似于ServletContext，保存着Scheduler上下文信息，Job和Trigger都可以访问SchedulerContext内的信息。
	SchedulerContext内部通过一个Map，以键值对的方式维护这些上下文数据，SchedulerContext为保存和获取数据提供了多个put()和getXxx()的方法。可以通过Scheduler# getContext()获取对应的SchedulerContext实例；
	
> 5、Calendar：

	org.quartz.Calendar和java.util.Calendar不同，它是一些日历特定时间点的集合（可以简单地将org.quartz.Calendar看作java.util.Calendar的集合——java.util.Calendar代表一个日历时间点，无特殊说明后面的Calendar即指org.quartz.Calendar）。
	一个Trigger可以和多个Calendar关联，以便排除或包含某些时间点。
	假设，我们安排每周星期一早上10:00执行任务，但是如果碰到法定的节日，任务则不执行，这时就需要在Trigger触发机制的基础上使用Calendar进行定点排除。针对不同时间段类型，Quartz在org.quartz.impl.calendar包下提供了若干个Calendar的实现类，如AnnualCalendar、MonthlyCalendar、WeeklyCalendar分别针对每年、每月和每周进行定义；
	
> 6、ThreadPool：

	Scheduler 使用一个线程池作为任务运行的基础设施，任务通过共享线程池中的线程提高运行效率。
	通过线程池获取触发器来触发任务。
	
	
> 关于name和group
	
	JobDetail和Trigger都有name和group。
	name是它们在这个sheduler里面的唯一标识。
	如果我们要更新一个JobDetail定义，只需要设置一个name相同的JobDetail实例即可。
	group是一个组织单元，sheduler会提供一些对整组操作的API，比如 scheduler.resumeJobs()。

	.withIdentity(String name,String group)参数用来定义jobKey，
	如果不设置，也会自动生成一个独一无二的jobKey用来区分不同的job
	
> Trigger

	startTime和endTime指定的Trigger会被触发的时间区间。
	在这个区间之外，Trigger是不会被触发的。
	优先级（Priority）:优先级只有在同一时刻执行的Trigger之间才会起作用。
		
> Misfire(错失触发）策略
	
	类似的Scheduler资源不足的时候，或者机器崩溃重启等，有可能某一些Trigger在应该触发的时间点没有被触发，也就是Miss Fire了。
	这个时候Trigger需要一个策略来处理这种情况。每种Trigger可选的策略各不相同。
	
	MisFire的触发是有一个阀值，这个阀值是配置在JobStore的。
	只有超过这个阀值，才会算MisFire。小于这个阀值，Quartz是会全部重新触发。
	
> Calendar种类
		
	HolidayCalendar：指定特定的日期，比如20140613。精度到天。
	DailyCalendar：指定每天的时间段（rangeStartingTime, rangeEndingTime)，格式是HH:MM[:SS[:mmm]]。也就是最大精度可以到毫秒。
	WeeklyCalendar：指定每星期的星期几，可选值比如为java.util.Calendar.SUNDAY。精度是天。
	MonthlyCalendar：指定每月的几号。可选值为1-31。精度是天
	AnnualCalendar： 指定每年的哪一天。使用方式如上例。精度是天。
	CronCalendar：指定Cron表达式。精度取决于Cron表达式，也就是最大精度可以到秒。
	
> Trigger实现类

	指定从某一个时间开始，以一定的时间间隔（单位是毫秒）执行的任务。
	
	属性：
		repeatInterval 重复间隔
		repeatCount 重复次数。实际执行次数是 repeatCount+1。因为在startTime的时候一定会执行一次
	
> 创建一个SimpleScheduleBuilder

	//SimpleScheduleBuilder是简单调用触发器，它只能指定触发的间隔时间和执行次数
	SimpleScheduleBuilder ss = SimpleScheduleBuilder.simpleSchedule();
	ss.withIntervalInSeconds(2);
	ss.withRepeatCount(3);		//触发次数：8次
	
	//创建触发器2
	SimpleTrigger trigger2 = TriggerBuilder.newTrigger()
			.withIdentity("trigger2", "group1")
			.startNow()
			.withSchedule(ss)
			.build();
						
	触发时间
	Date startTime = DateBuilder.todayAt(17, 30, 00);
	时间为下方15的倍数  会在任意时间段的  15S 30S 45S 60S 开始会触发一次  
	Date startTime = DateBuilder.nextGivenSecondDate(null, 15);  
		
	.startNow()				//一旦加入scheduler，立即生效
	.startAt(startTime)		//设置任务执行时间
	
	触发频率
	.withIntervalInHours(1) 		//每小时执行一次
	.withIntervalInMinutes(1) 		//每分钟执行一次
	.withIntervalInSeconds(2)		//每隔2秒执行一次
	
	触发次数
	.withRepeatCount(8);		//触发次数：8次
	.repeatForever())				//触发次数：不限，一直执行
	
	
> CalendarIntervalTrigger
	
	类似于SimpleTrigger，指定从某一个时间开始，以一定的时间间隔执行的任务。 
	间隔单位有秒，分钟，小时，天，月，年，星期。
		
	属性:
		interval 执行间隔
		intervalUnit 执行间隔的单位（秒，分钟，小时，天，月，年，星期）
	
		例子：
		CalendarIntervalScheduleBuilder cisb = CalendarIntervalScheduleBuilder.calendarIntervalSchedule();
		cisb.withIntervalInDays(1);
		
		//创建日历触发器
		CalendarIntervalTrigger cit = TriggerBuilder.newTrigger()
				.withIdentity("ctrigger2", "group1")
				.startAt(startTime)
				.withSchedule(cisb)
				.build();
				
		CalendarIntervalScheduleBuilder cisb = CalendarIntervalScheduleBuilder.calendarIntervalSchedule();
		cisb.withIntervalInDays(1) //每天执行一次
	
		cisb.withIntervalInWeeks(1) //每周执行一次
	
			
> DailyTimeIntervalTrigger
	
	指定每天的某个时间段内，以一定的时间间隔执行任务。并且它可以支持指定星期。
		
	属性有:
		startTimeOfDay 	每天开始时间
		endTimeOfDay 	每天结束时间
		daysOfWeek 		需要执行的星期
		interval 		执行间隔
		intervalUnit 	执行间隔的单位（秒，分钟，小时，天，月，年，星期）
		repeatCount 	重复次数
			
	例子：
		DailyTimeIntervalScheduleBuilder dtisb = DailyTimeIntervalScheduleBuilder.dailyTimeIntervalSchedule();
		dtisb.startingDailyAt(TimeOfDay.hourAndMinuteOfDay(9, 0));
		
		//创建日期触发器
		DailyTimeIntervalTrigger dtit = TriggerBuilder.newTrigger()
				.withIdentity("dtrigger2", "group1")
				.startAt(startTime)
				.withSchedule(dtisb)
				.build();
						
			.startingDailyAt(TimeOfDay.hourAndMinuteOfDay(9, 0)) //第天9：00开始
			.endingDailyAt(TimeOfDay.hourAndMinuteOfDay(16, 0)) //16：00 结束 
			.onDaysOfTheWeek(MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY) //周一至周五执行
			.withIntervalInHours(1) //每间隔1小时执行一次
			.withRepeatCount(100) //最多重复100次（实际执行100+1次）
	
			.startingDailyAt(TimeOfDay.hourAndMinuteOfDay(9, 0)) //第天9：00开始
			//每天执行10次，这个方法实际上根据 startTimeOfDay+interval*count 算出 endTimeOfDay
			.endingDailyAfterCount(10) 
			.onDaysOfTheWeek(MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY) //周一至周五执行
			.withIntervalInHours(1) //每间隔1小时执行一次
	
			
> CronTrigger
		
	属性: Cron表达式
	
> Cron表达式：
		
	Quartz使用类似于Linux下的Cron表达式定义时间规则，Cron表达式由6或7个由空格分隔的时间字段组成
	【秒、分、时、日、月、周、年】，年是可选的。
		
	//每天9:00执行
	CronScheduleBuilder csb = CronScheduleBuilder.cronSchedule("0 30 9 * * ?");
		
	//cron触发器
	Trigger cTrigger = TriggerBuilder.newTrigger()
			.withIdentity("ctrigger1", "group1")
			.startNow()
			.withSchedule(csb)
			.build();
	
	//注册并进行调度
	scheduler.scheduleJob(jobDetail, cTrigger);
	
	cronSchedule("0 0/2 8-17 * * ?") // 每天8:00-17:00，每隔2分钟执行一次

	cronSchedule("0 30 9 ? * MON") // 每周一，9:30执行一次

	weeklyOnDayAndHourAndMinute(MONDAY,9, 30) //等同于 0 30 9 ? * MON 
			
	【备注】在线生成cron -- http://cron.qqe2.com/
	特殊值：
		*	每个时间
		？	只在日和星期使用，无实质意义，相当于点位符；
		-	范围
		，	列表值
		/	x/y表达一个等步长序列，x为起始值，y为增量步长值。
		
		L	该字符只在日期和星期字段中使用，代表“Last”的意思。
			L在日字段中，表示这个月份的最后一天；L用在星期中，则表示星期六，等同于7；
			如果L出现在星期字段里，而且在前面有一个数值X，则表示“这个月的最后X天”，6L表示该月的最后星期五；
		
		W	该字符只能出现在日期字段里，表示离该日期最近的工作日。
			例如15W表示离该月15号最近的工作日，如果该月15号是星期六，则匹配14号星期五；如果15日是星期日，则匹配16号星期一；如果15号是星期二，那结果就是15号星期二。但必须注意关联的匹配日期不能够跨月，如你指定1W，如果1号是星期六，结果匹配的是3号星期一，而非上个月最后的那天。
			W字符串只能指定单一日期，而不能指定日期范围；
		
		LW	在日期字段可以组合使用LW，它的意思是当月的最后一个工作日；
		
		#	该字符只能在星期字段中使用，表示当月某个工作日。
			如6#3表示当月的第三个星期五(6表示星期五，#3表示当前的第三个)，而4#5表示当月的第五个星期三，
			假设当月没有第五个星期三，忽略不触发；
			
		C	该字符只在日和星期字段中使用，代表“Calendar”的意思
			5C在日字段中就相当于日历5日以后的第一天。1C在星期字段中相当于星期日后的第一天。
		
> 综合例子：

	/**
	 * Job接口的实现类
	 */
	package com.hdc.basic.quartz;
	
	import java.util.Date;
	
	import org.quartz.Job;
	import org.quartz.JobExecutionContext;
	import org.quartz.JobExecutionException;
	
	public class SimpleJob implements Job{
	
		//实现job接口
		@Override
		public void execute(JobExecutionContext jobEc) throws JobExecutionException {
			// TODO Auto-generated method stub
			System.out.println("triggerName="+jobEc.getTrigger().getKey()+"  trigger time:"+new Date());
		}
	
	}
	

	/**
	 * 对Job接口实现类进行调度
	 */
	package com.hdc.basic.quartz;
	
	import java.util.Date;
	
	import org.quartz.CalendarIntervalScheduleBuilder;
	import org.quartz.CalendarIntervalTrigger;
	import org.quartz.CronScheduleBuilder;
	import org.quartz.DailyTimeIntervalScheduleBuilder;
	import org.quartz.DailyTimeIntervalTrigger;
	import org.quartz.DateBuilder;
	import org.quartz.JobBuilder;
	import org.quartz.JobDetail;
	import org.quartz.Scheduler;
	import org.quartz.SchedulerFactory;
	import org.quartz.SimpleScheduleBuilder;
	import org.quartz.SimpleTrigger;
	import org.quartz.TimeOfDay;
	import org.quartz.Trigger;
	import org.quartz.TriggerBuilder;
	import org.quartz.TriggerKey;
	import org.quartz.impl.StdSchedulerFactory;
	
	//对 SimpleJob进行调度
	public class SimpleTriggerRunner {
	
		public static void main(String[] args) {
			// TODO Auto-generated method stub
	
			try {
				//通过SchedulerFactory来获取一个调度器  Scheduler
		        SchedulerFactory schedulerFactory = new StdSchedulerFactory();  
		        Scheduler scheduler= schedulerFactory.getScheduler();
		        
		        //通过JobDetail封装SimpleJob，同时指定Job在Scheduler中所属组及名称
				//JobDetail【任务数据】，不能直接被实例化， SimpleJob【Job的实现类，真正的执行逻辑】
		        //每执行一次就创建一个Job实例
				JobDetail jobDetail = JobBuilder.newJob(SimpleJob.class)
							.withIdentity("job1", "jgroup1")
							.build();  
				
				//设置任务触发时间
				Date startTime = DateBuilder.todayAt(17, 30, 00);
				
				//创建触发器
				//SimpleTrigger 不能直接被实例化
				//创建一个SimpleTrigger实例，指定该Trigger在Scheduler中所属组及名称,接着设置调度的时间规则。
				SimpleTrigger trigger = TriggerBuilder.newTrigger()
							.withIdentity(new TriggerKey("trigger1", "tgroup1"))	//定义name/group
							.startNow()		//一旦加入scheduler，立即生效
							.withSchedule(SimpleScheduleBuilder.simpleSchedule()	//使用SimpleTrigger
									.withIntervalInSeconds(2)		//每隔2秒执行一次
									.repeatForever())				//触发次数：不限，一直执行 
									.build();
				
				//创建一个SimpleScheduleBuilder
				//SimpleScheduleBuilder是简单调用触发器，它只能指定触发的间隔时间和执行次数
				SimpleScheduleBuilder ss = SimpleScheduleBuilder.simpleSchedule();
				ss.withIntervalInSeconds(2);
				ss.withRepeatCount(3);		//触发次数：8次
				
				CalendarIntervalScheduleBuilder cisb = CalendarIntervalScheduleBuilder.calendarIntervalSchedule();
				cisb.withIntervalInDays(1);
				
				//创建日历触发器
				CalendarIntervalTrigger cit = TriggerBuilder.newTrigger()
						.withIdentity("ctrigger2", "group1")
						.startAt(startTime)
						.withSchedule(cisb)
						.build();
				
				DailyTimeIntervalScheduleBuilder dtisb = DailyTimeIntervalScheduleBuilder.dailyTimeIntervalSchedule();
				dtisb.startingDailyAt(TimeOfDay.hourAndMinuteOfDay(9, 0));
				
				//创建日期触发器
				DailyTimeIntervalTrigger dtit = TriggerBuilder.newTrigger()
						.withIdentity("dtrigger2", "group1")
						.startAt(startTime)
						.withSchedule(dtisb)
						.build();
				
				//每天9:00执行
				CronScheduleBuilder csb = CronScheduleBuilder.cronSchedule("0 30 9 * * ?");
				
				//cron触发器
				Trigger cTrigger = TriggerBuilder.newTrigger()
						.withIdentity("ctrigger1", "group1")
						.startNow()
						.withSchedule(csb)
						.build();
				
	
				//创建触发器2
				SimpleTrigger trigger2 = TriggerBuilder.newTrigger()
						.withIdentity("trigger2", "group1")
						.startAt(startTime)
						.withSchedule(ss)
						.build();
				
				/**
				 * 注册并进行调度
				 * 	1.将JobDetail和trigger注册到Scheduler中
				 *  2.将trigger指派给JobDetail，将两者关联起来
				 */
				scheduler.scheduleJob(jobDetail, trigger);
				scheduler.scheduleJob(jobDetail, trigger2);
				scheduler.scheduleJob(jobDetail, cit);
				scheduler.scheduleJob(jobDetail, dtit);
				scheduler.scheduleJob(jobDetail, cTrigger);
				
				/**
				 * 启动调度
				 * 当Scheduler启动后，
				 * Trigger将定期触发并执行SimpleJob的execute(JobExecutionContext jobCtx)方法，
				 * 然后每 2 秒重复执行一次，一直运行
				 */
				scheduler.start();
				
				//运行10s后关闭调度
				Thread.sleep(10000);
				scheduler.shutdown(true);
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
	
	}
	
		
> JobDetail & Job
	
	JobDetail是任务的定义，而Job是任务的执行逻辑。在JobDetail里会引用一个Job Class定义。
	
	定义一个任务：
	
		1.创建一个org.quartz.Job的实现类，并实现实现自己的业务逻辑。比如上面的DoNothingJob。
		2.定义一个JobDetail，引用这个实现类
		3.加入scheduleJob
		
	Quartz调度一次任务，会干如下的事：
	
		1.	JobClass jobClass=JobDetail.getJobClass()
		2.	Job jobInstance=jobClass.newInstance()		//所以Job实现类，必须有一个public的无参构建方法。
			
		//JobExecutionContext是Job运行的上下文，可以获得Trigger、Scheduler、JobDetail的信息
		3.	jobInstance.execute(JobExecutionContext context)
		
		每次调度都会创建一个新的Job实例
		
> JobDataMap
		
	每一个JobDetail都会有一个JobDataMap。JobDataMap本质就是一个Map的扩展类,通过 JobDataMap 传值给Job实例。
		
	定义JobDetail，加入属性值：
		newJob().usingJobData("age", 18) //加入属性到ageJobDataMap

		job.getJobDataMap().put("name", "quertz"); //加入属性name到JobDataMap
			
	然后在Job实现类中可以获取这个JobDataMap的值：
		
		//方法一：获得JobDataMap
		JobDetail detail = context.getJobDetail();
        JobDataMap map = detail.getJobDataMap(); 
		
		//方法二：属性的setter方法，会将JobDataMap的属性自动注入
		public void setName(String name) { 
			this.name = name;
		}
			
	对于同一个JobDetail实例，执行的多个Job实例，是共享同样的JobDataMap，也就是说，如果你在任务里修改了里面的值，会对其他Job实例（并发的或者后续的）造成影响。
	
	除了JobDetail，Trigger同样有一个JobDataMap，共享范围是所有使用这个Trigger的Job实例。
	
	
> Job并发

	Job是有可能并发执行的，比如一个任务要执行10秒中，而调度算法是每秒中触发1次，那么就有可能多个任务被并发执行。
		
> Scheduler
		
	Scheduler就是Quartz的大脑，所有任务都是由它来设施。
	Schduelr包含一个两个重要组件: 
		JobStore：	JobStore是会来存储运行时信息的
		ThreadPool：线程池，Quartz有自己的线程池实现。所有任务的都会由线程池执行。
			
> SchedulerFactory
		
	用来创建Schduler，有两个实现：
		DirectSchedulerFactory：用来在代码里定制你自己的Schduler参数
		StdSchdulerFactory：直接读取classpath下的quartz.properties（不存在就都使用默认值）配置来实例化Schduler。
			
	任务调度信息存储
		包括运行次数、调度规则、JobDataMap 中的数据等
		持久化任务：将信息的任务保存到数据库中。
		
> quartz.properties 属性配置文件存在于 org.quarz 包下，提供了默认设置。

	若需要调整默认配置，则可以在类路径【src】下新建 quartz.properties 属性，它将自动被 quartz 加载并覆盖默认配置。
		
> 默认 quartz.properties
	
	org.quartz.scheduler.instanceName: DefaultQuartzScheduler	//集群的配置
	org.quartz.scheduler.rmi.export: false
	org.quartz.scheduler.rmi.proxy: false
	org.quartz.scheduler.wrapJobExecutionInUserTransaction: false
	org.quartz.threadPool.class: org.quartz.simpl.SimpleThreadPool		//	线程池
	org.quartz.threadPool.threadCount: 10
	org.quartz.threadPool.threadPriority: 5
	org.quartz.threadPool.threadsInheritContextClassLoaderOfInitializingThread: true
	org.quartz.jobStore.misfireThreshold: 60000
	org.quartz.jobStore.class: org.quartz.simpl.RAMJobStore		//数据保存在 RAM 内存中
	
	默认 quartz.properties 主要包含3方面：
		1.集群信息；
		2.调度器线程池；
		3.任务调度现场数据的保存。
		
	调整数据保存到数据库
	
	...
	org.quartz.jobStore.class: org.quartz.impl.jdbcjobstore.JobStoreTX
	org.quartz.jobStore.tablePrefix: QRTZ_	//数据库表的前缀
	org.quartz.jobStore.dataSource:	quartz		//定义了数据源
	
	//定义数据源的连接信息
	org.quartz.dataSource.quartz.driver: com.mysql.jdbc.Driver
	org.quartz.dataSource.quartz.URL: jdbc:mysql://192.168.1.30:3306/quartz_db
	org.quartz.dataSource.quartz.user:kevin
	org.quartz.dataSource.quartz.password: 123456
	org.quartz.dataSource.quartz.maxConnections: 10
	
	
	必须事先在相应的数据库中创建Quartz的数据表（共8张），在Quartz的完整发布包的docs/dbTables目录下拥有对应不同数据库的SQL脚本。对于 MYSQL innodb引擎而言，直接运行 tables_mysql_innodb.sql 即可。
	
	运行中断后，后续的触发信息将保存在数据库表QRTZ_SIMPLE_TRIGGERS 中：
		包含集群名，触发器名，触发器组名，(REPEAT_COUNT) 需要运行的总次数，触发间隔,(TIMES_TRIGGER)已经运行的次数。
		
	恢复中断的调度任务：
	
> Quartz 整合 Spring：
	
	// pom.xml
	<!-- quartz 的jar -->
	    <dependency>
	         <groupId>org.quartz-scheduler</groupId>
	         <artifactId>quartz</artifactId>
	         <version>2.2.1</version>
	    </dependency>
	    <dependency>
	        <groupId>org.quartz-scheduler</groupId>
	        <artifactId>quartz-jobs</artifactId>
	        <version>2.2.1</version>
	    </dependency>
	    <!-- spring相关jar -->
	        <dependency>
	            <groupId>org.springframework</groupId>
	            <artifactId>spring-context</artifactId>
	            <version>4.0.5.RELEASE</version>
	        </dependency>
	        <dependency>
	            <groupId>org.springframework</groupId>
	            <artifactId>spring-context-support</artifactId>
	            <version>4.0.5.RELEASE</version>
	        </dependency>
	        <dependency>
	            <groupId>org.springframework</groupId>
	            <artifactId>spring-jdbc</artifactId>
	            <version>4.0.5.RELEASE</version>
	        </dependency>
	        <dependency>
	            <groupId>org.springframework</groupId>
	            <artifactId>spring-tx</artifactId>
	            <version>4.0.5.RELEASE</version>
	        </dependency>
	        <dependency>
	            <groupId>org.springframework</groupId>
	            <artifactId>spring-test</artifactId>
	            <version>4.0.5.RELEASE</version>
	        </dependency>
	
	    <!-- 日志相关jar包 -->
	    <dependency>
	        <groupId>org.slf4j</groupId>
	        <artifactId>slf4j-api</artifactId>
	        <version>1.7.5</version>
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
	
	    <!-- MySql的包 -->
	    <dependency>
	        <groupId>mysql</groupId>
	        <artifactId>mysql-connector-java</artifactId>
	        <version>5.1.31</version>
	    </dependency>
	
		
> applicationContext.xml
	
	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
	    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:p="http://www.springframework.org/schema/p"
	    xmlns:context="http://www.springframework.org/schema/context" xmlns:tx="http://www.springframework.org/schema/tx"
	    xsi:schemaLocation="
	        http://www.springframework.org/schema/beans
	        http://www.springframework.org/schema/beans/spring-beans-4.0.xsd
	        http://www.springframework.org/schema/context
	        http://www.springframework.org/schema/context/spring-context-4.0.xsd
	        http://www.springframework.org/schema/tx
	        http://www.springframework.org/schema/tx/spring-tx-4.0.xsd">
	        
	     <!-- 
	        Spring整合Quartz进行配置遵循下面的步骤：
	        1.定义工作任务的Job
	        2.定义触发器Trigger，并将触发器与工作任务绑定
	        3.定义调度器，并将Trigger注册到Scheduler
	     -->
	     
	     <!-- 1.1、定义任务的bean -->
	    <bean id="jobD1" class="org.springframework.scheduling.quartz.JobDetailFactoryBean">
	    	<!-- 指定job的名称 -->
	    	<property name="name" value="spring_job1"/>
	    	<!-- 指定job的分组 -->
	    	<property name="group" value="spring_jgroup1"/>
	    	<!-- 指定具体的job类 -->
	    	<property name="jobClass" value="com.hdc.basic.quartz.SimpleJob"/>
	    	 <!-- 必须设置为true，如果为false，当没有活动的触发器与之关联时会在调度器中会删除该任务  -->
	    	<property name="durability" value="true"/>
	    	<!-- 指定spring容器的key，如果不设定在job中的jobmap中是获取不到spring容器的 -->
	    	<property name="applicationContextJobDataKey" value="applicationContext"/>
	    </bean>
	
	    <!--1.2、业务类的任务 -->  
	  <bean id="jobD2" class="org.springframework.scheduling.quartz.MethodInvokingJobDetailFactoryBean">
	    <!-- 引用服务层的类 -->  
	    <property name="targetObject" ref="jobServer"/>  
	    <!-- 指定目标bean 的方法 -->  
	    <property name="targetMethod" value="sendMessage"/>  
	    <!-- 指定最终封装出的任务是否有状态 -->  
	    <property name="concurrent" value="false"/> 
	  </bean>  
	    
	    <!-- 2.1：定义触发器的bean，定义一个Simple的Trigger，一个触发器只能和一个任务进行绑定 -->
	   <!--  <bean name="simpleTrigger" class="org.springframework.scheduling.quartz.SimpleTriggerFactoryBean">
	    	指定Trigger的名称
	    	<property name="name" value="spring_trigger1"/>
	    	指定Trigger的组名称
	    	<property name="group" value="spring_tgroup1"/>
	    	
	    	指定Tirgger绑定的Job
	    	<property name="jobDetail" ref="jobD1"/>
	    	指定Trigger的延迟时间 1s后运行
	    	<property name="startDelay" value="1000"/>
	    	指定Trigger的重复间隔  1s
	    	<property name="repeatInterval" value="1000"/>
	    	指定Trigger的运行次数
	    	<property name="repeatCount" value="5"/>
	    </bean> -->
	    
	    <!-- 2.2：定义触发器的bean，定义一个Cron的Trigger，一个触发器只能和一个任务进行绑定 -->
	    <bean id="cronTrigger" class="org.springframework.scheduling.quartz.CronTriggerFactoryBean">
	        <!-- 指定Trigger的名称 -->
	        <property name="name" value="spring_cron_trigger1"/>
	        <!-- 指定Trigger的组名 -->
	        <property name="group" value="spring_cron__group1"/>
	        <!-- 指定Tirgger绑定的Job -->
	        <property name="jobDetail" ref="jobD1"/>
	        <!-- 指定Cron 的表达式 ，当前是每隔1s运行一次 -->
	        <property name="cronExpression" value="0/1 * * * * ?" />
	    </bean>
	    
	    
	    <!-- 3.定义调度器，并将Trigger注册到调度器中 -->
	    <bean id="scheduler" class="org.springframework.scheduling.quartz.SchedulerFactoryBean">
	    	<property name="triggers">
	    		<list>
	    			<!-- <ref bean="simpleTrigger"/> -->
	    			<ref bean="cronTrigger"/>
	    		</list>
	    	</property>
	    	<!-- 容器启动就会执行调度程序 -->
	    	<!-- <property name="autoStartup" value="true" /> -->
	    </bean>
	    
	</beans>
		 
> SimpleTriggerRunner.java
	
	package com.hdc.basic.quartz;
	
	import org.springframework.context.ApplicationContext;
	import org.springframework.context.support.ClassPathXmlApplicationContext;
	
	
	public class SimpleTriggerRunner {
	
		public static void main(String[] args) {
			// TODO Auto-generated method stub
			ApplicationContext ac = new ClassPathXmlApplicationContext("config/applicationContext.xml");
		}
	}
	
	
> JDBC存储方式的xml配置文件
	
	 <!-- 
		持久化数据配置，需要添加quartz.properties
	 -->
	<bean name="scheduler" class="org.springframework.scheduling.quartz.SchedulerFactoryBean">
		<property name="applicationContextSchedulerContextKey" value="applicationContextKey"/>
		<property name="configLocation" value="classpath:quartz.properties"/>   
	</bean>
	
	报错：
	Unable to serialize JobDataMap for insertion into database because the value of property 'applicationContext' is not serializable: org.springframework.context.support.ClassPathXmlApplicationContext
		
		
	<!-- 
	        Spring整合Quartz进行配置遵循下面的步骤：
	        1.定义工作任务的Job
	        2.定义触发器Trigger，并将触发器与工作任务绑定
	        3.定义调度器，并将Trigger注册到Scheduler
	     -->
	     
	     <!-- 定义任务的bean -->
	    <bean id="jobD1" class="org.springframework.scheduling.quartz.JobDetailFactoryBean">
	    	<!-- 指定job的名称 -->
	    	<property name="name" value="spring_job1"/>
	    	<!-- 指定job的分组 -->
	    	<property name="group" value="spring_jgroup1"/>
	    	<!-- 指定具体的job类 -->
	    	<property name="jobClass" value="com.hdc.basic.quartz.SimpleJob"/>
	    	 <!-- 必须设置为true，如果为false，当没有活动的触发器与之关联时会在调度器中会删除该任务  -->
	    	<property name="durability" value="true"/>
	    	<!-- 指定spring容器的key，如果不设定在job中的jobmap中是获取不到spring容器的 -->
	    	<property name="applicationContextJobDataKey" value="applicationContext"/>
	    	<!-- 给任务所对应的 JobDataMap 提供值-->
	    	<property name="jobDataAsMap">
	    		<map>
	    			<!--指定 size的键，用于在  jobDataAsMap 保存 applicationContext -->
	    			<entry key="size" value="10"/>
	    		</map>
	    	</property>
	    	
	    </bean>
	    
	    <!-- 业务类的任务 -->
	    <bean id="jobD2" class="org.springframework.scheduling.quartz.MethodInvokingJobDetailFactoryBean">
	    	<!-- 引用服务层的类 -->
	    	<property name="targetObject" ref="myServer"/> 
	    	<!-- 指定目标bean 的方法 --> 
	        <property name="targetMethod" value="doJob"/>  
	        <!-- 指定最终封装出的任务是否有状态 -->
	        <property name="concurrent" value="false" /> 
	    	
	    </bean>
	    
	    <bean id="myServer" class="com.hdc.server.MyServer"/>
	    
	    <!-- 2.1：定义触发器的bean，定义一个Simple的Trigger，一个触发器只能和一个任务进行绑定 -->
	   <!--  <bean name="simpleTrigger" class="org.springframework.scheduling.quartz.SimpleTriggerFactoryBean">
	    	指定Trigger的名称
	    	<property name="name" value="spring_trigger1"/>
	    	指定Trigger的组名称
	    	<property name="group" value="spring_tgroup1"/>
	    	
	    	指定Tirgger绑定的Job
	    	<property name="jobDetail" ref="jobD1"/>
	    	指定Trigger的延迟时间 1s后运行
	    	<property name="startDelay" value="1000"/>
	    	指定Trigger的重复间隔  1s
	    	<property name="repeatInterval" value="1000"/>
	    	指定Trigger的运行次数
	    	<property name="repeatCount" value="5"/>
	    </bean> -->
	    
	    <!-- 2.2：定义触发器的bean，定义一个Cron的Trigger，一个触发器只能和一个任务进行绑定 -->
	    <bean id="cronTrigger" class="org.springframework.scheduling.quartz.CronTriggerFactoryBean">
	        <!-- 指定Trigger的名称 -->
	        <property name="name" value="spring_cron_trigger1"/>
	        <!-- 指定Trigger的组名 -->
	        <property name="group" value="spring_cron__group1"/>
	        <!-- 指定Tirgger绑定的Job -->
	        <property name="jobDetail" ref="jobD1"/>
	        <!-- 指定Cron 的表达式 ，当前是每隔1s运行一次 -->
	        <property name="cronExpression" value="0/1 * * * * ?" />
	        
	    </bean>
	    
	    
	    <!-- 3.定义调度器，并将Trigger注册到调度器中 -->
	    <bean id="scheduler" lazy-init="false" class="org.springframework.scheduling.quartz.SchedulerFactoryBean">
	    	<property name="triggers">
	    		<list>
	    			<!-- <ref bean="simpleTrigger"/> -->
	    			<ref bean="cronTrigger"/>
	    		</list>
	    	</property>
	    	
	    	<!-- 持久化数据配置，需要添加quartz.properties -->
	    	<!-- <property name="applicationContextSchedulerContextKey" value="applicationContextKey"/>
	        <property name="configLocation" value="classpath:quartz.properties"/>  -->
	        
	    </bean>