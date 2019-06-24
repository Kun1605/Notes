## Elasticsearch 5.2.0 安装

### 环境

- 机子 IP：192.168.1.127

- Ubuntu 16.04Lts

- JDK 版本：1.8（最低要求），主推：JDK 1.8.0_121 以上

- Elasticsearch 版本：5.2.0

- 关闭 firewall

  ```shell
  $centos
  systemctl stop firewalld.service #停止firewall
  systemctl disable firewalld.service #禁止firewall开机启动
  #ubuntu 
  
  ```

  

### zip 解压安装

- 官网总的安装文档：<https://www.elastic.co/guide/en/elasticsearch/reference/5.x/zip-targz.html>

- 我的解压目录：`/search/hadoop/elasticsearch/elasticsearch-5.2.0`，解压包名：`elasticsearch-5.2.0.zip`

- 添加组和用户

  ```
  该版本不能使用 root 用户进行使用
  useradd elasticsearch -p 123456，添加一个名为 elasticsearch 的用户，还有一个同名的组
  ```

- 添加数据目录：

  ```
  /search/hadoop/elasticsearch/elasticsearch-5.2.0/data
  /search/hadoop/elasticsearch/elasticsearch-5.2.0/log
  ```

- 赋权限

  ```shell
  chown -R elasticsearch:elasticsearch /search/hadoop/elasticsearch/elasticsearch-5.2.0
  ```

- 编辑配置文件

  ```
  vim /search/hadoop/elasticsearch/elasticsearch-5.2.0/config/elasticsearch.yml
  ```

  打开下面注释，并修改

  ```
  cluster.name: youmeek-cluster
  node.name: youmeek-node-1
  path.data: /opt/elasticsearch/data
  path.logs: /opt/elasticsearch/log
  bootstrap.memory_lock: true
  network.host: 0.0.0.0 # 也可以是本机 IP
  http.port: 9200
  discovery.zen.ping.unicast.hosts: ["192.168.1.127"]  #如果有多个机子集群，这里就写上这些机子的 IP，格式：["192.168.1.127","192.168.1.126"]
  ```

  - 重点说明：Elasticsearch 的集群环境，主要就是上面这段配置文件内容的差别。如果有其他机子：node.name、discovery.zen.ping.unicast.hosts 需要改下。集群中所有机子的配置文件中 discovery.zen.ping.unicast.hosts 都要有所有机子的 IP 地址。
  - 修改这个配置文件，不然无法锁内存：`vim /etc/security/limits.conf`
  - 在文件最尾部增加下面内容：

```shell
# allow user 'elasticsearch' mlockall
yk soft memlock unlimited
yk hard memlock unlimited
* soft nofile 262144
* hard nofile 262144

#   ******
#   *代表所有用户 elasticsearch代表当前的启动elastic的用户
```

- 修改：`vim /etc/sysctl.conf`，添加下面配置

```shell
vm.max_map_count=262144
```

退出，然后冲进

- 切换用户：`su elasticsearch`

- 控制台运行（启动比较慢）：`cd /usr/program/elasticsearch-5.2.0 ; ./bin/elasticsearch`

- 后台运行：`cd /search/hadoop/elasticsearch/elasticsearch-5.2.0 ; ./bin/elasticsearch -d -p 自定义pid值`

- 在本机终端输入该命令：`curl -XGET 'http://192.168.2.172:9200/'`，（也可以用浏览器访问：<http://192.168.1.127:9200/>）如果能得到如下结果，则表示启动成功：

```json
{
  "name" : "node-1",
  "cluster_name" : "my-application",
  "cluster_uuid" : "g_JUkCmjQYm7cK0C1KdgJg",
  "version" : {
    "number" : "5.2.0",
    "build_hash" : "24e05b9",
    "build_date" : "2017-01-24T19:52:35.800Z",
    "build_snapshot" : false,
    "lucene_version" : "6.4.0"
  },
  "tagline" : "You Know, for Search"
}
```

## 安装 Kibana 5.2.0



- 官网下载地址：<https://www.elastic.co/cn/downloads/kibana>

- Kibana 5.2.0 版本下载地址（36M）：<https://artifacts.elastic.co/downloads/kibana/kibana-5.2.0-linux-x86_64.tar.gz>

- Kibana 5.2.0 官网文档：<https://www.elastic.co/guide/en/kibana/5.2/index.html>

- Kibana 5.2.0 官网安装文档：<https://www.elastic.co/guide/en/kibana/5.2/targz.html>

  ### tar.gz 解压安装

  安装目录：

  ```
  /search/hadoop/elasticsearch/kibana-5.2.0-linux-x86_64
  ```

  修改配置：`vim /search/hadoop/elasticsearch/kibana-5.2.0-linux-x86_64/config/kibana.yml`，默认配置都是注释的，我们这里打开这些注释：

  ```shell
  server.port: 5601
  server.host: "0.0.0.0" # 请将这里改为 0.0.0.0 或是当前本机 IP，不然可能会访问不了
  erver.name: "yk-kibana"
  elasticsearch.url: "http://192.168.2.172:9200"
  elasticsearch.username: "yk"
  elasticsearch.password: ""
  ```

   然后运行

  ```shell
  ./bin/kibana
  ```

  - 浏览器访问：[http://192.168.2.172:5601](http://192.168.1.127:5601/)，可以看到 Kibana `Configure an index pattern` 界面

- 访问 Dev Tools 工具，后面写 DSL 语句会常使用该功能：<http://192.168.2.172:5601/app/kibana#/dev_tools/console?_g=()>

安装ik分词器

```sh
wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v6.3.2/elasticsearch-analysis-ik-6.3.2.zip
```

创建分词article文章

> PUT http://node0:9200/banji/

```json
<<<<<<< HEAD
PUT http://node0:9200/banji/





=======
>>>>>>> origin/master
{
  "mappings": {
    "article": {
      "properties": {
        "doc_id": {
          "type": "long"
        },
        "title": {
          "type": "text",
<<<<<<< HEAD
          "analyzer": "ik_max_word"
        },
        "img": {
          "type": "text"
        },
        "content": {
          "type": "text",
          "analyzer": "ik_max_word"
        },
        "author": {
          "type": "text",
          "analyzer": "ik_max_word"
        },
        "subtitle": {
          "type": "text",
          "analyzer": "ik_max_word"
        },
        "date": {
=======
          "analyzer": "ik_smart"
        },
        "content": {
          "type": "text",
          "analyzer": "ik_smart"
        },
        "contentNoTag": {
          "type": "text",
          "analyzer": "ik_smart"
        },
        "image": {
          "type": "text"
        },
        "create_time": {
          "type": "date"
        },
        "update_time": {
>>>>>>> origin/master
          "type": "date"
        }
      }
    }
  }
}
```

