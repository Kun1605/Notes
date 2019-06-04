# **keepalived安装文档**

# 1. **安装依赖**

```shell
yum -y install kernel-devel*

yum -y install openssl-*

yum -y install popt-devel

yum -y install lrzsz

yum -y install openssh-clients
```

# 2. **安装keepalived**

## 2.1. **上传**

1、cd /usr/local

2、rz –y

3、选择keepalived安装文件

## 2.2. **解压**

```shell
tar –zxvf keepalived-1.2.2.tar.gz
```



## 2.3. **重命名**

```shell
mv keepalived-1.2.2 keepalived
```



## 2.4. **安装keepalived**

1、cd keepalived

2、执行命令

```shell
./configure --prefix=/usr/local/keepalived -enable-lvs-syncd --enable-lvs --with-kernel-dir=/lib/modules/2.6.32-431.el6.x86_64/build
```

3、编译

```shell
make
```

4、安装

```shell
make install
```



## 2.5. **配置服务和加入开机启动**

```sh
cp /usr/local/keepalived/etc/rc.d/init.d/keepalived /etc/init.d/ 

cp /usr/local/keepalived/etc/sysconfig/keepalived /etc/sysconfig/

mkdir -p /etc/keepalived

cp /usr/local/keepalived/etc/keepalived/keepalived.conf /etc/keepalived/

ln -s /usr/local/keepalived/sbin/keepalived /sbin/

chkconfig keepalived on
```



## 2.6. **修改配置文件**

```
 vim /etc/keepalived/keepalived.conf
```

2、 详解：

```properties
global_defs {
   notification_email {#指定keepalived在发生切换时需要发送email到的对象，一行一个
     #acassen@firewall.loc
     #failover@firewall.loc
     #sysadmin@firewall.loc
   }
   notification_email_from Alexandre.Cassen@firewall.loc#指定发件人
   #smtp_server 192.168.200.1#指定smtp服务器地址
   #smtp_connect_timeout 30 #指定smtp连接超时时间
   router_id LVS_DEVEL#运行keepalived机器的一个标识
}

vrrp_instance VI_1 {
    state BACKUP#指定那个为master，那个为backup
    interface eth1#设置实例绑定的网卡
    virtual_router_id 51#同一实例下virtual_router_id必须相同
    priority 100#定义优先级，数字越大，优先级越高,备机要小于主
	advert_int 1#MASTER与BACKUP负载均衡器之间同步检查的时间间隔，单位是秒
	nopreempt#设置为不抢占,从启动后主不会自动切换回来, 注：这个配置只能设置在backup主机上，而且这个主机优先级要比另外一台高
    
    authentication {#设置认证
        auth_type PASS
        auth_pass 1111
    }
    virtual_ipaddress {#设置vip
        192.168.56.70#虚拟IP
    }
}

virtual_server 192.168.56.70 8080 {
    delay_loop 6#健康检查时间间隔
    lb_algo rr #调度算法rr|wrr|lc|wlc|lblc|sh|dh
    lb_kind DR #负载均衡转发规则NAT|DR|RUN
    #nat_mask 255.255.255.0 #需要验证
    persistence_timeout 1#会话保持时间
    protocol TCP#使用的协议

    real_server 192.168.56.201 8080 {
        weight 10 #默认为1,0为失效
        SSL_GET {
            url { #检查url，可以指定多个
              path /
              digest ff20ad2481f97b1754ef3e12ecd3a9cc #检查后的摘要信息
            }
            url {
              path /mrtg/
              digest 9b3a0c85a887a256d6939da88aabd8cd
            }
            connect_timeout 3#连接超时时间
            nb_get_retry 3#重连次数
            delay_before_retry 3#重连间隔时间
        }
    }

}
```

 

 

# 3. **按照上面步骤安装备机器**

注意：备的配置文件不相同。

 

# 4. **两台机器启动keepalived：**

```shell
service keepalived start
```

 

# 5. **验证**

```
ip a
```



# 6. **监控**

因为keepalive只能监控机器的死活，所以当软件死掉后，keepalived仍然不会切换；

所以需要写一个脚本，监控软件的死活。

运行wangsf.sh，监控软件

```shell
#!/bin/bash
while true;
do
    A=`ps -ef|grep tomcat |wc -l`
	B=`ps -ef|grep keepalived |wc -l`
echo $A
if [ $A -eq 1 ];then
                echo 'restart tomcat!!!!'
                /usr/local/server/apache-tomcat-6.0.37/bin/startupsss.sh
				 if [ $A -eq 1 ];then
					if [ $B -gt 1 ];then
						   echo 'tomcat dead  !!!! kill keepalived'
						   killall keepalived
					fi
				fi				
fi
if [ $A -eq 2 ];then
					if [ $B -eq 1 ];then
						   echo 'tomcat live  !!!! start keepalived'
						   service keepalived start
					fi
				fi
sleep 3
done

```







备注已经配置好的文件直接拿来修改使用的

## 主

```properties
! Configuration File for keepalived

global_defs {
   notification_email {
     #acassen@firewall.loc
     #failover@firewall.loc
     #sysadmin@firewall.loc
   }
   notification_email_from Alexandre.Cassen@firewall.loc
   #smtp_server 192.168.200.1
   #smtp_connect_timeout 30
   router_id LVS_DEVEL
}

vrrp_instance VI_1 {
    state MASTER
    interface eth1
    virtual_router_id 51
    priority 200

    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    virtual_ipaddress {
        192.168.56.70
        #192.168.200.17
        #192.168.200.18
    }
}

virtual_server 192.168.56.70 8080 {
    delay_loop 6
    lb_algo rr
    lb_kind DR
    #nat_mask 255.255.255.0
    persistence_timeout 1
    protocol TCP

real_server 192.168.56.200 8080 {
        weight 20
        SSL_GET {
            url {
              path /
              digest ff20ad2481f97b1754ef3e12ecd3a9cc
            }
            url {
              path /mrtg/
              digest 9b3a0c85a887a256d6939da88aabd8cd
            }
            connect_timeout 3
            nb_get_retry 3
            delay_before_retry 3
        }
    }
}


```

## 备

```properties
! Configuration File for keepalived

global_defs {
   notification_email {
     #acassen@firewall.loc
     #failover@firewall.loc
     #sysadmin@firewall.loc
   }
   notification_email_from Alexandre.Cassen@firewall.loc
   #smtp_server 192.168.200.1
   #smtp_connect_timeout 30
   router_id LVS_DEVEL
}

vrrp_instance VI_1 {
    state BACKUP
    interface eth1
    virtual_router_id 51
    priority 100
	nopreempt
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    virtual_ipaddress {
        192.168.56.70
    }
}

virtual_server 192.168.56.70 8080 {
    delay_loop 6
    lb_algo rr
    lb_kind DR
    #nat_mask 255.255.255.0
    persistence_timeout 1
    protocol TCP

real_server 192.168.56.201 8080 {
        weight 20
        SSL_GET {
            url {
              path /
              digest ff20ad2481f97b1754ef3e12ecd3a9cc
            }
            url {
              path /mrtg/
              digest 9b3a0c85a887a256d6939da88aabd8cd
            }
            connect_timeout 3
            nb_get_retry 3
            delay_before_retry 3
        }
    }
}


```

