# 简介

Redis是非关系型数据库, 即NoSql数据库, 存储的数据模型是key-value, 特点是访问速度快

# 为什么使用Redis

性能: 我们在碰到需要执行耗时特别久，且结果不频繁变动的SQL，就特别适合将运行结果放入缓存。这样，后面的请求就去缓存中读取，使得请求能够迅速响应。

并发: 在大并发的情况下，所有的请求直接访问数据库，数据库会出现连接异常。这个时候，就需要使用redis做一个缓冲操作，让请求先访问到redis，而不是直接访问数据库。

# Redis的缺点

缓存和数据库双写一致性问题

缓存雪崩问题

缓存击穿问题

缓存的并发竞争问题

# 单线程Redis为什么这么快?

纯内存操作

单线程操作，避免了频繁的上下文切换

采用了非阻塞I/O多路复用机制

我们现在要仔细的说一说I/O多路复用机制，因为这个说法实在是太通俗了，通俗到一般人都不懂是什么意思。博主打一个比方：小曲在S城开了一家快递店，负责同城快送服务。小曲因为资金限制，雇佣了一批快递员，然后小曲发现资金不够了，只够买一辆车送快递。

- 经营方式一

  客户每送来一份快递，小曲就让一个快递员盯着，然后快递员开车去送快递。慢慢的小曲就发现了这种经营方式存在下述问题

  几十个快递员基本上时间都花在了抢车上了，大部分快递员都处在闲置状态，谁抢到了车，谁就能去送快递

  随着快递的增多，快递员也越来越多，小曲发现快递店里越来越挤，没办法雇佣新的快递员了

  快递员之间的协调很花时间

  综合上述缺点，小曲痛定思痛，提出了下面的经营方式

- 经营方式二

  小曲只雇佣一个快递员。然后呢，客户送来的快递，小曲按送达地点标注好，然后依次放在一个地方。最后，那个快递员依次的去取快递，一次拿一个，然后开着车去送快递，送好了就回来拿下一个快递。

  对比上述两种经营方式对比，是不是明显觉得第二种，效率更高，更好呢。在上述比喻中:

每个快递员------------------>每个线程

每个快递-------------------->每个socket(I/O流)

快递的送达地点-------------->socket的不同状态

客户送快递请求-------------->来自客户端的请求

小曲的经营方式-------------->服务端运行的代码

一辆车---------------------->CPU的核数

1. 于是我们有如下结论:
   - 经营方式一就是传统的并发模型，每个I/O流(快递)都有一个新的线程(快递员)管理。
   - 经营方式二就是I/O多路复用。只有单个线程(一个快递员)，通过跟踪每个I/O流的状态(每个快递的送达地点)，来管理多个I/O流。

# 数据结构

- String类型, value只能是String类型

  这个其实没啥好说的，最常规的set/get操作，value可以是String也可以是数字。一般做一些**复杂的计数功能的缓存**。

  - set

    设置key对应的值为String类型的value

    ```
      127.0.0.1:6379> set name zhangsan
      OK
    ```

    结合了setnx和expire的功能参数可选

    ```
      key value [EX seconds] [PX milliseconds] [NX|XX]
    
      127.0.0.1:6379> set k 30 EX 30 NX
      OK
      127.0.0.1:6379> set k 30 EX 30 NX
      (nil)
    ```

  - setnx

    如果不存在这个key就设置

    ```
      127.0.0.1:6379> SETNX name lisi
      (integer) 0
      127.0.0.1:6379> SETNX name1 lisi
      (integer) 1
    ```

  - get

    获取key对应的值

    ```
      127.0.0.1:6379> get name
      "zhangsan"
    ```

  - mget

    批量获取多个key的值，如果可以不存在则返回nil

    ```
      127.0.0.1:6379> mget xx name name1
      1) (nil)
      2) "zhangsan"
      3) "lisi"
    ```

  - incr && incrby

    incr对key对应的值进行加加操作，并返回新的值;incrby加指定值

    ```
      127.0.0.1:6379> set age 10
      OK
      127.0.0.1:6379> set age1 "20"
      OK
      127.0.0.1:6379> incr age
      (integer) 11
      127.0.0.1:6379> incr age1
      (integer) 21
      127.0.0.1:6379> type age
      string
      127.0.0.1:6379> type age1
      string
      127.0.0.1:6379> get age
      "11"
      127.0.0.1:6379> get age1
      "21"
      
      127.0.0.1:6379> OBJECT encoding age
      "int"
      127.0.0.1:6379> object encoding age1
      "int"
    ```

    从上面的结果可以看出，我们对int型的age和string型的age1都能进行incr操作时， 实际上type=string代表value存储的是一个普通字符串，那么对应的encoding可以是raw或者是int，如果是int则代表实际redis内部是按数值型类存储和表示这个字符串的，当然前提是这个字符串本身可以用数值表示，**比如"20"这样的字符串，当遇到incr、decr等操作时会转成数值型进行计算，此时redisObject的encoding字段为int**。如果你试图对name进行incr操作则报错。

  - decr && decrby

    decr对key对应的值进行减减操作，并返回新的值;decrby减指定值

  - 其他命令

    | 命令     | 说明                                                         |
    | -------- | ------------------------------------------------------------ |
    | setex    | 设置key对应的值为String类型的value，并设定有效期             |
    | setrange | 设置key对应value的子字符串                                   |
    | getrange | 获取key对应value的子字符串                                   |
    | mset     | 批量设置多个key的值，如果成功表示所有值都被设置，否则返回0表示没有任何值被设置 |
    | msetnx   | 同mset，不存在就设置，不会覆盖已有的key                      |
    | getset   | 设置key的值，并返回key旧的值                                 |
    | append   | 给指定key的value追加字符串，并返回新字符串的长度             |
    | strlen   | 取指定key的value的长度                                       |

  String是最常用的一种数据类型，普通的key/value存储都可以归为此类。

- Hash类型, 可以对key进行分类

  Hash是一个String类型的field和value之间的映射表，即redis的Hash数据类型的key（hash表名称）对应的value实际的内部存储结构为一个HashMap，因此Hash特别适合存储对象。相对于把一个对象的每个属性存储为String类型，将整个对象存储在Hash类型中会占用更少内存。

  当前HashMap的实现有两种方式：当HashMap的成员比较少时Redis为了节省内存会采用类似一维数组的方式来紧凑存储，而不会采用真正的HashMap结构，这时对应的value的redisObject的encoding为zipmap，当成员数量增大时会自动转成真正的HashMap,此时encoding为ht。

  [![http://www.miaomiaoqi.cn/images/redis/hashstructure.png](https://camo.githubusercontent.com/0dfd90e87c405954af8354ad368c248ce6750874/687474703a2f2f7777772e6d69616f6d69616f71692e636e2f696d616765732f72656469732f686173687374727563747572652e706e67)](https://camo.githubusercontent.com/0dfd90e87c405954af8354ad368c248ce6750874/687474703a2f2f7777772e6d69616f6d69616f71692e636e2f696d616765732f72656469732f686173687374727563747572652e706e67)

  - hset

    设置key对应的HashMap中的field的value

    ```
      127.0.0.1:6379> hset myhash name zhangsan
      (integer) 1
      127.0.0.1:6379> hset myhash age 25
      (integer) 1
    ```

  - hget

    获取key对应的HashMap中的field的value

    ```
      127.0.0.1:6379> hget myhash name
      "zhangsan"
      127.0.0.1:6379> hget myhash age
      "25"
    ```

  - hgetall

    获取key对应的HashMap中的所有field的value

    ```
      127.0.0.1:6379> hgetall myhash
      1) "name"
      2) "zhangsan"
      3) "age"
      4) "25"
    ```

  - 其它命令

    | 命令    | 说明                                                     |
    | ------- | -------------------------------------------------------- |
    | hsetnx  | 设置key对应的HashMap中的field的value，如果不存在则先创建 |
    | hmset   | 批量设置key对应的HashMap中的field的value                 |
    | hmget   | 批量获取key对应的HashMap中的field的value                 |
    | hincrby | 给key对应的HashMap中的field的value加指定的值             |
    | hexits  | 测试key对应的HashMap中的field是否存在                    |
    | hlen    | 返回key对应的HashMap中的field的数量                      |
    | hdel    | 删除key对应的HashMap中的field                            |
    | hkeys   | 返回key对应的HashMap中所有的field                        |
    | hvals   | 返回key对应的HashMap中所有的field的value                 |

  用一个对象来存储用户信息，商品信息，订单信息等等。

- List类型, 所有元素是有序的

  Redis的List类型其实就是每一个元素都是String类型的双向链表。我们可以从链表的头部和尾部添加或者删除元素。这样的List既可以作为栈，也可以作为队列使用。

  - 在key对应的list的头部添加一个元素

    ```
      127.0.0.1:6379> lpush newlist new1 new2 new3
      (integer) 3
    ```

  - lrange

    获取key对应的list的指定下标范围的元素，-1表示右边第一个元素

    ```
      127.0.0.1:6379> lrange newlist 0 -1
      1) "new3"
      2) "new2"
      3) "new1"
    ```

  - lpop

    从key对应的list的尾部删除一个元素，并返回该元素

    ```
      127.0.0.1:6379> lpop newlist
      "new3"
    
      127.0.0.1:6379> lrange newlist 0 -1
      1) "new2"
      2) "new1"
    ```

  - rpush

    在key对应的list的尾部添加一个元素

    ```
      127.0.0.1:6379> rpush newlist new4
      (integer) 3
      
      127.0.0.1:6379> LRANGE newlist 0 -1
      1) "new2"
      2) "new1"
      3) "new4"
    ```

  - rpop

    从key对应的list的尾部删除一个元素，并返回该元素

    ```
      127.0.0.1:6379> rpop newlist
      "new4"
    ```

  - 其他命令

    | 命令      | 说明                                                   |
    | --------- | ------------------------------------------------------ |
    | linsert   | 在key对应的list的特定元素的前或后插入元素              |
    | lset      | 设置key对应的list中指定下标元素的值                    |
    | lrem      | 从key对应的list中删除n个和value相同的元素              |
    | ltrim     | 保留key对应的list中指定范围的元素                      |
    | rpoplpush | 从第一个list的尾部移除一个元素并添加到第二个list的头部 |
    | llen      | 返回key对应的list的长度                                |
    | lindex    | 返回key对应的list中index的元素                         |

  如好友列表，粉丝列表，消息队列，最新消息排行等。另外还有一个就是，可以利用lrange命令，做**基于redis的分页功能**，性能极佳，用户体验好。

- Set类型, 元素是无序的, 元素不能重复. 并集, 交集, 差集

  因为set堆放的是一堆不重复值的集合。所以可以做**全局去重**的功能。为什么不用JVM自带的Set进行去重？因为我们的系统一般都是集群部署，使用JVM自带的Set，比较麻烦，难道为了一个做一个全局去重，再起一个公共服务，太麻烦了。 另外，就是利用交集、并集、差集等操作，可以计算**共同喜好，全部的喜好，自己独有的喜好等功能**

  Redis 集合（Set类型）是一个无序的String类型数据的集合，类似List的一个列表，与List不同的是Set不能有重复的数据。实际上，Set的内部是用HashMap实现的，Set只用了HashMap的key列来存储对象

  - sadd

    在key对应的set中添加一个元素

    ```
      127.0.0.1:6379> sadd myset news1 news2 news3
      (integer) 3
    ```

  - smembers

    获取key对应的set的所有元素

    ```
      127.0.0.1:6379> smembers myset
      1) "news2"
      2) "news1"
      3) "news3"
    ```

  - spop

    随机返回并删除key对应的set中的一个元素

    ```
      127.0.0.1:6379> spop myset
      "news3"
    ```

  - sdiff

    求给定key对应的set与第一个key对应的set的差集

    ```
      127.0.0.1:6379> smembers myset
      1) "news1"
      2) "news3"
      
      127.0.0.1:6379> smembers myset2
      1) "news4"
      2) "news2"
      3) "news1"
      4) "news3"
      5) "news5"
    
      127.0.0.1:6379> sdiff myset2 myset
      1) "news4"
      2) "news5"
      3) "news2"
      
      127.0.0.1:6379> sdiff myset myset2
      (empty list or set)
    ```

  - sunion

    求给定key对应的set并集

    ```
      127.0.0.1:6379> sunion myset myset2
      1) "news3"
      2) "news2"
      3) "news5"
      4) "news1"
      5) "news4"
    ```

  - sinter

    求给定key对应的set交集

    ```
      127.0.0.1:6379> sinter myset myset2
      1) "news1"
      2) "news3"
    ```

  - 其他命令

    | 命令        | 说明                                                         |
    | ----------- | ------------------------------------------------------------ |
    | srem        | 删除key对应的set中的一个元素                                 |
    | sdiffstore  | 求给定key对应的set与第一个key对应的set的差集，并存储到另一个key对应的set中 |
    | sinterstore | 求给定key对应的set交集，并存储到另一个key对应的set中         |
    | suionstore  | 求给定key对应的set并集，并存储到另一个key对应的set中         |
    | somve       | 从第一个key对应的set中删除指定元素并添加到第二个key对应的set中 |
    | scard       | 返回key对应的set的元素个数                                   |
    | sismember   | 测试某个元素是否为key对应的set中的元素个数                   |
    | srandmember | 随机返回key对应的set中的一个元素，但不删除元素               |

  集合有取交集、并集、差集等操作，因此可以求共同好友、共同兴趣、分类标签等

- SortedSet, 有序的set, 元素不能重复且有序

  SortSet顾名思义，是一个排好序的Set，它在Set的基础上增加了一个顺序属性score，这个属性在添加修改元素时可以指定，每次指定后，SortSet会自动重新按新的值排序。

  sorted set的内部使用HashMap和跳跃表(SkipList)来保证数据的存储和有序，HashMap里放的是成员到score的映射，而跳跃表里存放的是所有的成员，排序依据是HashMap里存的score。

  - zadd

    在key对应的zset中添加一个元素

    ```
      127.0.0.1:6379> zadd myzset 1 "one" 2 "two" 3 "three"
      (integer) 3
    ```

  - zrange

    获取key对应的zset中指定范围的元素，-1表示获取所有元素

    ```
      127.0.0.1:6379> zrange myzset 0 -1
      1) "one"
      2) "two"
      3) "three"
    ```

    带分数查询

    ```
      127.0.0.1:6379> zrange myzset 0 -1 withscores
      1) "one"
      2) "1"
      3) "two"
      4) "2"
      5) "three"
      6) "3"
    ```

  - zrem

    删除key对应的zset中的一个元素

    ```
      127.0.0.1:6379> zrem myzset one
      (integer) 1
    ```

  - 其他命令

    | 命令          | 说明                                                         |
    | ------------- | ------------------------------------------------------------ |
    | zincrby       | 如果key对应的zset中已经存在元素member，则对member的score属性加指定的值 |
    | zrank         | 返回key对应的zset中指定member的排名。其中member按score值递增(从小到大）；排名以0为底，也就是说，score值最小的成员排名为0 |
    | zrevrank      | 获得成员按score值递减(从大到小)排列的排名                    |
    | zrevrange     | 返回有序集key中，指定区间内的成员。其中成员的位置按score值递减(从大到小)来排列 |
    | zrangebyscore | 返回有序集key中，指定分数范围的元素列表                      |
    | zcount        | 返回有序集key中，score值在min和max之间(默认包括score值等于min或max)的成员 |
    | zcard         | 返回key的有序集元素个数                                      |

  可以做**排行榜应用，取TOP N操作**。可以用来做**延时任务**。最后一个应用就是可以做**范围查找**。

- 键值常用命令

  ```
    keys/exists/del/expire/ttl/move/persist/randomkey/rename/type/object encoding
  ```

- 服务器常用命令

  ```
    ping/echo/select/quit/dbsize/info/config get/flushdb/flushall
  ```

# 内存结构

Redis内部使用一个redisObject对象来表示所有的key和value

redisObject主要的信息包括数据类型（type）、编码方式(encoding)、数据指针（ptr）、虚拟内存（vm）等。type代表一个value对象具体是何种数据类型，encoding是不同数据类型在redis内部式。

```
typedef struct redisObject{
    //类型
    unsigned type:4;
    
    //编码
    unsigned encoding:4;
    
    //指向底层实现数据结构的指针
    void *ptr
    
    //虚拟内存和其他信息等.....
}robj;
```

| 类型常量     | 对象的名称   | type值 |
| ------------ | ------------ | ------ |
| REDIS_STRING | 字符串对象   | string |
| REDIS_LIST   | 列表对象     | list   |
| REDIS_HASH   | 哈希对象     | hash   |
| REDIS_SET    | 集合对象     | set    |
| REDIS_ZSET   | 有序集合对象 | zset   |

# 过期时间及淘汰机制

redis采用的是定期删除+惰性删除策略。

- 为什么不用定时删除策略?

  定时删除,用一个定时器来负责监视key,过期则自动删除。虽然内存及时释放，但是十分消耗CPU资源。在大并发请求下，CPU要将时间应用在处理请求，而不是删除key,因此没有采用这一策略. 定期删除+惰性删除是如何工作的呢?

  - 定期删除，redis默认每个100ms检查，是否有过期的key,有过期key则删除。需要说明的是，redis不是每个100ms将所有的key检查一次，而是随机抽取进行检查(如果每隔100ms,全部key进行检查，redis岂不是卡死)。因此，如果只采用定期删除策略，会导致很多key到时间没有删除。
  - 惰性删除, 也就是说在你获取某个key的时候，redis会检查一下，这个key如果设置了过期时间那么是否过期了？如果过期了此时就会删除。

  采用定期删除+惰性删除就没其他问题了么?

  不是的，如果定期删除没删除key。然后你也没即时去请求key，也就是说惰性删除也没生效。这样，redis的内存会越来越高。那么就应该采用内存淘汰机制。 在redis.conf中有一行配置

  ```
    # maxmemory-policy volatile-lru
  ```

  该配置就是配内存淘汰策略的

  - noeviction：当内存不足以容纳新写入数据时，新写入操作会报错。**应该没人用吧**。
  - allkeys-lru：当内存不足以容纳新写入数据时，在键空间中，移除最近最少使用的key。**推荐使用，目前项目在用这种**。
  - allkeys-random：当内存不足以容纳新写入数据时，在键空间中，随机移除某个key。应该也没人用吧，**你不删最少使用Key,去随机删**。
  - volatile-lru：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，移除最近最少使用的key。**这种情况一般是把redis既当缓存，又做持久化存储的时候才用**。不推荐
  - volatile-random：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，随机移除某个key。**依然不推荐**
  - volatile-ttl：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，有更早**过期时间的key优先移除。不推荐**

  **如果没有设置 expire 的key, 不满足先决条件(prerequisites); 那么 volatile-lru, volatile-random 和 volatile-ttl 策略的行为, 和 noeviction(不删除) 基本上一致。**

# Redis中使用密码

Redis默认配置是不需要密码认证的，也就是说只要连接的Redis服务器的host和port正确，就可以连接使用。这在安全性上会有一定的问题，所以需要启用Redis的认证密码，增加Redis服务器的安全性。

1. 修改配置文件

   Redis的配置文件默认在/etc/redis.conf，找到如下行：

   \#requirepass foobared

   去掉前面的注释，并修改为所需要的密码：

   requirepass myPassword （其中myPassword就是要设置的密码）

2. 启动redis服务

3. 登录验证

   设置Redis认证密码后，客户端登录时需要使用-a参数输入认证密码，不添加该参数虽然也可以登录成功，但是没有任何操作权限。如下：

   ```
    $ ./redis-cli -h 127.0.0.1 -p 6379
    127.0.0.1:6379> keys *
    (error) NOAUTH Authentication required.
   ```

   使用密码认证登录，并验证操作权限

   ```
    $ ./redis-cli -h 127.0.0.1 -p 6379 -a myPassword
    127.0.0.1:6379> config get requirepass
    1) "requirepass"
    2) "myPassword"
   ```

4. 在Redis集群中使用认证密码

   如果Redis服务器，使用了集群。除了在master中配置密码外，也需要在slave中进行相应配置。在slave的配置文件中找到如下行，去掉注释并修改与master相同的密码即可：

   ```
    # masterauth master-password    
   ```

# Redis其他命令

## SCAN命令

**SCAN [key] cursor [MATCH pattern] [COUNT count]**

SCAN 命令及其相关的 SSCAN 命令、 HSCAN 命令和 ZSCAN 命令都用于增量地迭代（incrementally iterate）一集元素（a collection of elements）:

- SCAN 命令用于迭代当前数据库中的所有数据库键。
- SSCAN 命令用于迭代集合键中的元素。
- HSCAN 命令用于迭代哈希键中的键值对。
- ZSCAN 命令用于迭代有序集合中的元素（包括元素成员和元素分值）。

以上列出的四个命令都支持增量式迭代， 它们每次执行都只会返回少量元素， 所以这些命令可以用于生产环境， 而不会出现像 KEYS 命令、 SMEMBERS 命令带来的问题 —— 当 KEYS 命令被用于处理一个大的数据库时， 又或者 SMEMBERS 命令被用于处理一个大的集合键时， 它们可能会阻塞服务器达数秒之久。

不过， 增量式迭代命令也不是没有缺点的： 举个例子， 使用 SMEMBERS 命令可以返回集合键当前包含的所有元素， 但是对于 SCAN 这类增量式迭代命令来说， 因为在对键进行增量式迭代的过程中， 键可能会被修改， 所以增量式迭代命令只能对被返回的元素提供有限的保证 （offer limited guarantees about the returned elements）。

**需要注意的是:**

- SSCAN 命令、 HSCAN 命令和 ZSCAN 命令的第一个参数总是一个数据库键。
- 而 SCAN 命令则不需要在第一个参数提供任何数据库键 —— 因为它迭代的是当前数据库中的所有数据库键。

### SCAN命令基本用法

SCAN 命令是一个基于游标的迭代器（cursor based iterator）： SCAN 命令每次被调用之后， 都会向用户返回一个新的游标， 用户在下次迭代时需要使用这个新游标作为 SCAN 命令的游标参数， 以此来延续之前的迭代过程。

当 SCAN 命令的游标参数被设置为 0 时， 服务器将开始一次新的迭代， 而当服务器向用户返回值为 0 的游标时， 表示迭代已结束。

首先使用 `keys *` 可以看到数据库中一共有19条数据, key* 共14条, akey* 共5条

```
127.0.0.1:6379> keys *
 1) "key13"
 2) "key7"
 3) "akey5"
 4) "key11"
 5) "key12"
 6) "key14"
 7) "key6"
 8) "key2"
 9) "akey3"
10) "key3"
11) "key9"
12) "key10"
13) "key1"
14) "akey4"
15) "key5"
16) "akey2"
17) "akey1"
18) "key4"
19) "key8"
```

使用 `scan` 命令迭代过程如下:

```
127.0.0.1:6379> scan 0
1) "30"
2)  1) "key13"
    2) "key3"
    3) "key4"
    4) "key11"
    5) "key12"
    6) "akey1"
    7) "akey5"
    8) "key1"
    9) "key2"
   10) "akey3"
127.0.0.1:6379> scan 30
1) "0"
2) 1) "key9"
   2) "key10"
   3) "key7"
   4) "key6"
   5) "key8"
   6) "key14"
   7) "akey4"
   8) "key5"
   9) "akey2"
127.0.0.1:6379>
```

在上面这个例子中， 第一次迭代使用 0 作为游标， 表示开始一次新的迭代。

第二次迭代使用的是第一次迭代时返回的游标， 也即是命令回复第一个元素的值 —— 30 。

从上面的示例可以看到， SCAN 命令的回复是一个包含两个元素的数组， 第一个数组元素是用于进行下一次迭代的新游标， 而第二个数组元素则是一个数组， 这个数组中包含了所有被迭代的元素。

在第二次调用 SCAN 命令时， 命令返回了游标 0 ， 这表示迭代已经结束， 整个数据集（collection）已经被完整遍历过了。

以 0 作为游标开始一次新的迭代， 一直调用 SCAN 命令， 直到命令返回游标 0 ， 我们称这个过程为一次**完整遍历**（full iteration）。

### SCAN 命令的保证（guarantees）

SCAN 命令， 以及其他增量式迭代命令， 在进行完整遍历的情况下可以为用户带来以下保证： 从完整遍历开始直到完整遍历结束期间， 一直存在于数据集内的所有元素都会被完整遍历返回； 这意味着， 如果有一个元素， 它从遍历开始直到遍历结束期间都存在于被遍历的数据集当中， 那么 SCAN 命令总会在某次迭代中将这个元素返回给用户。

然而因为增量式命令仅仅使用游标来记录迭代状态， 所以这些命令带有以下缺点：

- 同一个元素可能会被返回多次。 处理重复元素的工作交由应用程序负责， 比如说， 可以考虑将迭代返回的元素仅仅用于可以安全地重复执行多次的操作上。
- 如果一个元素是在迭代过程中被添加到数据集的， 又或者是在迭代过程中从数据集中被删除的， 那么这个元素可能会被返回， 也可能不会， 这是未定义的（undefined）。

### SCAN 命令每次执行返回的元素数量

增量式迭代命令并不保证每次执行都返回某个给定数量的元素。

增量式命令甚至可能会返回零个元素， 但只要命令返回的游标不是 `0` ， 应用程序就不应该将迭代视作结束。

不过命令返回的元素数量总是符合一定规则的， 在实际中：

- 对于一个大数据集来说， 增量式迭代命令每次最多可能会返回数十个元素；
- 而对于一个足够小的数据集来说， 如果这个数据集的底层表示为编码数据结构（encoded data structure，适用于是小集合键、小哈希键和小有序集合键）， 那么增量迭代命令将在一次调用中返回数据集中的所有元素。

最后， 用户可以通过增量式迭代命令提供的 `COUNT` 选项来指定每次迭代返回元素的最大值。

### COUNT选项

虽然增量式迭代命令不保证每次迭代所返回的元素数量， 但我们可以使用 `COUNT` 选项， 对命令的行为进行一定程度上的调整。

基本上， `COUNT` 选项的作用就是让用户告知迭代命令， 在每次迭代中应该从数据集里返回多少元素。

虽然 `COUNT` 选项**只是对增量式迭代命令的一种提示**（hint）， 但是在大多数情况下， 这种提示都是有效的。

- `COUNT` 参数的默认值为 `10` 。
- 在迭代一个足够大的、由哈希表实现的数据库、集合键、哈希键或者有序集合键时， 如果用户没有使用 `MATCH` 选项， 那么命令返回的元素数量通常和 `COUNT` 选项指定的一样， 或者比 `COUNT` 选项指定的数量稍多一些。
- 在迭代一个编码为整数集合（intset，一个只由整数值构成的小集合）、 或者编码为压缩列表（ziplist，由不同值构成的一个小哈希或者一个小有序集合）时， 增量式迭代命令通常会无视 `COUNT` 选项指定的值， 在第一次迭代就将数据集包含的所有元素都返回给用户。

### MATCH 选项

和 [*KEYS*](http://doc.redisfans.com/key/keys.html#keys) 命令一样， 增量式迭代命令也可以通过提供一个 glob 风格的模式参数， 让命令只返回和给定模式相匹配的元素， 这一点可以通过在执行增量式迭代命令时， 通过给定 `MATCH <pattern>` 参数来实现。

以下是一个使用 `MATCH` 选项进行迭代的示例:

```
127.0.0.1:6379> SCAN 0 match key* count 5
1) "26"
2) 1) "key13"
   2) "key3"
   3) "key4"
   4) "key11"
   5) "key12"
127.0.0.1:6379> SCAN 26 match key* count 5
1) "30"
2) 1) "key1"
   2) "key2"
127.0.0.1:6379> SCAN 30 match key* count 5
1) "3"
2) 1) "key9"
   2) "key10"
   3) "key7"
   4) "key6"
   5) "key8"
127.0.0.1:6379> SCAN 3 match key* count 5
1) "0"
2) 1) "key14"
   2) "key5"
```

### 并发执行多个迭代

在同一时间， 可以有任意多个客户端对同一数据集进行迭代， 客户端每次执行迭代都需要传入一个游标， 并在迭代执行之后获得一个新的游标， 而这个游标就包含了迭代的所有状态， 因此， 服务器无须为迭代记录任何状态。

### 中途停止迭代

因为迭代的所有状态都保存在游标里面， 而服务器无须为迭代保存任何状态， 所以客户端可以在中途停止一个迭代， 而无须对服务器进行任何通知。

即使有任意数量的迭代在中途停止， 也不会产生任何问题。

### 使用错误的游标进行增量式迭代

使用间断的（broken）、负数、超出范围或者其他非正常的游标来执行增量式迭代并不会造成服务器崩溃， 但可能会让命令产生未定义的行为。

未定义行为指的是， 增量式命令对返回值所做的保证可能会不再为真。

只有两种游标是合法的：

1. 在开始一个新的迭代时， 游标必须为 `0` 。
2. 增量式迭代命令在执行之后返回的， 用于延续（continue）迭代过程的游标。

### 迭代终结的保证

增量式迭代命令所使用的算法只保证在数据集的大小有界（bounded）的情况下， 迭代才会停止， 换句话说， 如果被迭代数据集的大小不断地增长的话， 增量式迭代命令可能永远也无法完成一次完整迭代。

从直觉上可以看出， 当一个数据集不断地变大时， 想要访问这个数据集中的所有元素就需要做越来越多的工作， 能否结束一个迭代取决于用户执行迭代的速度是否比数据集增长的速度更快。