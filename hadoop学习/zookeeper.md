# 简介

Zookeeper是一个**分布式协调服务**；就是为用户的分布式应用程序提供协调服务

Zookeeper是为别的分布式程序服务的

Zookeeper本身就是一个分布式程序（只要有半数以上节点存活，zk就能正常服务）

Zookeeper所提供的服务涵盖：主从协调、服务器节点动态上下线、统一配置管理、分布式共享锁、统一名称服务……

虽然说可以提供各种服务，但是zookeeper在底层其实只提供了两个功能

1. 管理(存储，读取)用户程序提交的数据
2. 为用户程序提供数据节点监听服务

# 安装

## 单机版安装

1. 创建data目录存放ZooKeeper数据

2. conf下编写zoo.cfg指定data目录

   ```
    # The number of milliseconds of each tick
    # 心跳周期毫秒
    tickTime=2000
    # The number of ticks that the initial
    # synchronization phase can take
    # 初始化心跳个数
    initLimit=10
    # The number of ticks that can pass between
    # sending a request and getting an acknowledgement
    # 发送请求到响应的心跳个数
    syncLimit=5
    # the directory where the snapshot is stored.
    # do not use /tmp for storage, /tmp here is just
    # example sakes.
    # 数据目录
    dataDir=/Users/miaoqi/Documents/zookeeper-3.4.6/data
    # the port at which the clients will connect
    # 客户端端口
    clientPort=2181
    # the maximum number of client connections.
    # increase this if you need to handle more clients
    #maxClientCnxns=60
    #
    # Be sure to read the maintenance section of the
    # administrator guide before turning on autopurge.
    #
    # http://zookeeper.apache.org/doc/current/zookeeperAdmin.html#sc_maintenance
    #
    # The number of snapshots to retain in dataDir
    #autopurge.snapRetainCount=3
    # Purge task interval in hours
    # Set to "0" to disable auto purge feature
    #autopurge.purgeInterval=1
   ```

## 集群安装

1. 修改每一个zookeeper的配置文件

   ```
    # 2881 是leader和follower通信的端口 默认是2888
    # 3881 是投票的端口 默认是3888
    server.1=127.0.0.1:2881:3881
    server.2=127.0.0.1:2882:3882
    server.3=127.0.0.1:2883:3883
   ```

2. 到数据目录下创建文件myid, 文件内容就是myid的值

3. 分别启动三台机器, 使用status查看状态

# 服务端命令

启动

```
zkServer.sh start
```

状态

```
zkServer.sh status
```

客户端连接

```
zkCli.sh [-server host:port]
```

# Zookeeper的数据模型

1. 层次化的目录结构, 命名符合常规文件系统规范, 它很像数据结构当中的树，也很像文件系统的目录
2. 每个节点在Zookeeper中叫做**Znode**, 并且其有一个唯一的路径标识
3. 节点Znode可以包含数据和子节点
4. 客户端应用可以在节点上设置监视器

[![http://www.miaomiaoqi.cn/images/bigdata/zookeeper/1.png](assets/687474703a2f2f7777772e6d69616f6d69616f71692e636e2f696d616765732f626967646174612f7a6f6f6b65657065722f312e706e67.png)](https://camo.githubusercontent.com/6f06ba01bc5cbb5cb86294a0612f0f72323cb67b/687474703a2f2f7777772e6d69616f6d69616f71692e636e2f696d616765732f626967646174612f7a6f6f6b65657065722f312e706e67)

## Znode

Znode 包含了数据, 子节点引用, 访问权限等等

[![http://www.miaomiaoqi.cn/images/bigdata/zookeeper/2.png](assets/687474703a2f2f7777772e6d69616f6d69616f71692e636e2f696d616765732f626967646174612f7a6f6f6b65657065722f322e706e67.png)](https://camo.githubusercontent.com/64e7a67a93d6883ceb89b66b4796ad4dbc9db6a1/687474703a2f2f7777772e6d69616f6d69616f71692e636e2f696d616765732f626967646174612f7a6f6f6b65657065722f322e706e67)

**data:** Znode存储的数据信息。

**ACL:** 记录Znode的访问权限，即哪些人或哪些IP可以访问本节点。

**stat:** 包含Znode的各种元数据，比如事务ID、版本号、时间戳、大小等等。

**child:** 当前节点的子节点引用，类似于二叉树的左孩子右孩子。

这里需要注意一点，Zookeeper是为读多写少的场景所设计。Znode并不是用来存储大规模业务数据，而是用于存储少量的状态和配置信息，**每个节点的数据最大不能超过1MB**。

# 节点类型

Znode分为四种类型：

- 持久节点(PERSISTENT)默认

  默认的节点类型, 创建节点的客户端与zookeeper断开连接后, 该节点依旧存在

- 持久节点顺序节点(PERSISTENT_SEQUENTIAL)

  所谓顺序节点, 就是在创建节点时, Zookeeper根据创建的时间顺序给该节点名称进行编号

- 临时节点(EPHEMERAL)

  和持久节点相反, 当创建节点的客户端与zookeeper断开连接后, 临时节点会被删除：

- 临时顺序节点(EPHEMERAL_SEQUENTIAL)

  顾名思义, 临时顺序节点结合和临时节点和顺序节点的特点: 在创建节点时, Zookeeper根据创建的时间顺序给该节点名称进行编号, 当创建节点的客户端与zookeeper断开连接后, 临时节点会被删除

# 客户端命令

- ls path [watch]

  查看节点下的子节点

  ```
    ls /
  ```

- create [-s] [-e] path data acl

  在某个节点下创建节点, 默认是持久节点

  ```
    create /app1 "This is app1 server parent"
    
    create /app1/server01 "192.168.1.1,100"
  ```

  -e是短暂节点, 客户端断开连接节点销毁

  ```
    create -e /app-e "aaaa"
  ```

  -s是顺序节点, 会自动给节点加上序号

  ```
    [zk: 127.0.0.1:2220(CONNECTED) 5] create -s /test/aa 999
    Created /test/aa0000000000
    [zk: 127.0.0.1:2220(CONNECTED) 6] create -s /test/bb 999
    Created /test/bb0000000001
    [zk: 127.0.0.1:2220(CONNECTED) 7] create -s /test/aa 999
    Created /test/aa0000000002
    [zk: 127.0.0.1:2220(CONNECTED) 8] ls /test
    [aa0000000000, aa0000000002, bb0000000001]
  ```

  -s和-e结合使用就是临时顺序节点

- get path [watch]

  获取节点内容

  ```
    get /app1/server01
  ```

  开启watch功能

  ```
    get /app1 watch
  ```

  当其他机器修改/app1节点的内容时, 监听会收到通知, 但是只能监听一次, 监听器也分类型

  ```
    WATCHER::
    
    WatchedEvent state:SyncConnected type:NodeDataChanged path:/app1
  ```

- quit

  客户端断开连接

- set

  更新节点内容

  ```
    set /app1 "xxx"
  ```

  会同步到其他机器上, 如果节点过多, 会有短暂延迟

- delete

  删除节点

  ```
  delete /app1
  ```

- exists

  判断节点是否存在

- getData

  获得一个节点的数据

- setData

  设置一个节点的数据

- getChildren

  获取节点下的所有子节点

这其中，exists，getData，getChildren属于读操作。Zookeeper客户端在请求读操作的时候，可以选择是否设置**Watch**。

我们可以理解成是注册在特定Znode上的触发器。当这个Znode发生改变，也就是调用了create，delete，setData方法的时候，将会触发Znode上注册的对应事件，请求Watch的客户端会接收到**异步通知**。

# Zookeeper监听器原理(Watch)

当客户端设置Watch时, 会开启两个线程, 一个线程负责监听器, 一个线程负责和Zookeeper服务端通信告诉服务端监听线程的端口, 当服务端变化时, 服务端主动调用客户端监听器端口, 监听器调用zkClient的watch方法实现监听器, 原理是各种rpc调用

1. 客户端调用getData方法，watch参数是true。服务端接到请求，返回节点数据，并且在对应的哈希表里插入被Watch的Znode路径，以及Watcher列表。

   [![http://www.miaomiaoqi.cn/images/bigdata/zookeeper/3.png](assets/687474703a2f2f7777772e6d69616f6d69616f71692e636e2f696d616765732f626967646174612f7a6f6f6b65657065722f332e706e67.png)](https://camo.githubusercontent.com/08bacbd301075842a595cacc88e0fa42bee6d57f/687474703a2f2f7777772e6d69616f6d69616f71692e636e2f696d616765732f626967646174612f7a6f6f6b65657065722f332e706e67)

2. 当被Watch的Znode已删除，服务端会查找哈希表，找到该Znode对应的所有Watcher，异步通知客户端，并且删除哈希表中对应的Key-Value。

   [![http://www.miaomiaoqi.cn/images/bigdata/zookeeper/4.png](assets/687474703a2f2f7777772e6d69616f6d69616f71692e636e2f696d616765732f626967646174612f7a6f6f6b65657065722f342e706e67.png)](https://camo.githubusercontent.com/dc28359b60b6492dbbffa539d71fc65f59808dc4/687474703a2f2f7777772e6d69616f6d69616f71692e636e2f696d616765732f626967646174612f7a6f6f6b65657065722f342e706e67)

# Zookeeper的一致性

Zookepper身为分布式系统协调服务, 如果自身挂掉了怎么办呢? 为了防止单机挂掉的情况, Zookeeper 维护了一个集群

[![http://www.miaomiaoqi.cn/images/bigdata/zookeeper/5.png](assets/687474703a2f2f7777772e6d69616f6d69616f71692e636e2f696d616765732f626967646174612f7a6f6f6b65657065722f352e706e67.png)](https://camo.githubusercontent.com/03ec261e01ea7b499e7cc3243b0081b7ec6f318b/687474703a2f2f7777772e6d69616f6d69616f71692e636e2f696d616765732f626967646174612f7a6f6f6b65657065722f352e706e67)

Zookeeper Service集群是一主多从结构

1. 在更新数据时，首先更新到主节点（这里的节点是指服务器，不是Znode），再同步到从节点
2. 在读取数据时，直接读取任意从节点。

为了保证主从节点的数据一致性，Zookeeper采用了**ZAB协议**，这种协议非常类似于一致性算法**Paxos**和**Raft**。

# Zookeeper分布式锁

1. 获取锁

   首先，在Zookeeper当中创建一个持久节点ParentLock。当第一个客户端想要获得锁时，需要在ParentLock这个节点下面创建一个临时顺序节点 Lock1.

   之后，Client1查找ParentLock下面所有的临时顺序节点并排序，判断自己所创建的节点Lock1是不是顺序最靠前的一个。如果是第一个节点，则成功获得锁。

   这时候，如果再有一个客户端 Client2 前来获取锁，则在ParentLock下载再创建一个临时顺序节点Lock2。

   Client2查找ParentLock下面所有的临时顺序节点并排序，判断自己所创建的节点Lock2是不是顺序最靠前的一个，结果发现节点Lock2并不是最小的。

   于是，Client2向排序仅比它靠前的节点Lock1注册Watcher，用于监听Lock1节点是否存在。这意味着Client2抢锁失败，进入了等待状态。

   这时候，如果又有一个客户端Client3前来获取锁，则在ParentLock下载再创建一个临时顺序节点Lock3。

   Client3查找ParentLock下面所有的临时顺序节点并排序，判断自己所创建的节点Lock3是不是顺序最靠前的一个，结果同样发现节点Lock3并不是最小的。

   于是，Client3向排序仅比它靠前的节点Lock2注册Watcher，用于监听Lock2节点是否存在。这意味着Client3同样抢锁失败，进入了等待状态。

   这样一来，Client1得到了锁，Client2监听了Lock1，Client3监听了Lock2。这恰恰形成了一个等待队列，很像是Java当中ReentrantLock所依赖的AQS（AbstractQueuedSynchronizer）。

2. 释放锁

   释放锁分为两种情况：

   1. 任务完成，客户端显示释放

      当任务完成时，Client1会显示调用删除节点Lock1的指令。

   2. 任务执行过程中，客户端崩溃

      获得锁的Client1在任务执行过程中，如果Duang的一声崩溃，则会断开与Zookeeper服务端的链接。根据临时节点的特性，相关联的节点Lock1会随之自动删除。

   由于Client2一直监听着Lock1的存在状态，当Lock1节点被删除，Client2会立刻收到通知。这时候Client2会再次查询ParentLock下面的所有节点，确认自己创建的节点Lock2是不是目前最小的节点。如果是最小，则Client2顺理成章获得了锁。

   同理，如果Client2也因为任务完成或者节点崩溃而删除了节点Lock2，那么Client3就会接到通知。

3. Zookeeper与Redis分布式锁比较

   | 分布式锁  | 优点                                                         | 缺点                                                         |
   | --------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
   | Zookeeper | 1. 有封装好的框架, 容易实现 2.有等待锁的队列, 大大提升抢锁效率 | 添加和删除节点性能较低                                       |
   | Redis     | Set和Del指令的性能较高                                       | 1. 实现复杂, 需要考虑超时, 原子性, 误删 2. 没有等待锁的队列, 只能在客户端自旋来等锁, 效率低下 |