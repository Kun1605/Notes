-- -----------------------------------------------------------------------------
-- App Platform Data DB
-- APP 应用数据结构说明
-- -----------------------------------------------------------------------------
set character_set_client=utf8,character_set_connection=utf8,character_set_results=utf8;
CREATE DATABASE IF NOT EXISTS thl_templates DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
USE thl_templates;

-- -----------------------------------------------------------------------------
-- 1.1、平台系统菜单信息表
-- 管理平台系统启动时，将加载的系统菜单注解信息持久化到菜单信息表，包括名称、
-- 包名、排序等信息，并为每个条目生成唯一id（数据库自增），用于导航树生成、用户或角色授权时使用。
-- 如果有新增菜单，当系统重新加载后，菜单信息都会更新（id保持不变），以包名作为唯一标识。
-- 当数据库中的菜单已不在加载的菜单中时，则系统自动将数据库中的记录标记为“舍弃”，管理员即可
-- 在管理系统中将其删除
-- 创建时间：2016年03月14日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS menu_info (
  id              BIGINT NOT NULL AUTO_INCREMENT COMMENT '条目id',
  parent_id       BIGINT NOT NULL COMMENT '上级id',
  code            VARCHAR(128) NOT NULL COMMENT '条目编码，可用于本地化时使用',
  value           VARCHAR(128) NOT NULL COMMENT '条目名称，如果系统支持本地化，则以code字段为准',
  order_number    INT NOT NULL COMMENT '同级显示顺序',
  pkg_name        VARCHAR(255) NOT NULL COMMENT '包名',
  path            VARCHAR(255) NOT NULL COMMENT '访问路径',
  enable          TINYINT NOT NULL COMMENT '是否启用，true－启用，false－停用，默认为启用，如果停用，则下级递归停用',
  discard         TINYINT NOT NULL COMMENT '是否舍弃，true－舍弃，false－未舍弃，如果舍弃，可在管理后台删除',
  PRIMARY KEY(id),
  UNIQUE(pkg_name),
  INDEX(parent_id),
  INDEX(enable)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '菜单信息表';

-- -----------------------------------------------------------------------------
-- 1.2、平台系统模块信息表
-- 管理平台系统启动时，将加载的系统模块注解信息持久化到模块信息表，包括模块名称、包名、
-- 路径、排序等信息，并为每个条目生成唯一id（数据库自增），用于导航树生成、用户或角色授权时使用。
-- 如果有新增模块，当系统重新加载后，模块信息都会更新（id保持不变），以包名作为唯一标识。
-- 当数据库中的模块已不在加载的模块中时，则系统自动将数据库中的记录标记为“舍弃”，管理员即可
-- 在管理系统中将其删除
-- 创建时间：2016年03月14日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS module_info (
  id              BIGINT NOT NULL AUTO_INCREMENT COMMENT '条目id',
  parent_id       BIGINT NOT NULL COMMENT '上级id',
  code            VARCHAR(128) NOT NULL COMMENT '条目编码，可用于本地化时使用',
  value           VARCHAR(128) NOT NULL COMMENT '条目名称，如果系统支持本地化，则以code字段为准',
  order_number    INT NOT NULL COMMENT '同级显示顺序',
  pkg_name        VARCHAR(255) NOT NULL COMMENT '包名和类名',
  path            VARCHAR(255) NOT NULL COMMENT '访问路径',
  enable          TINYINT NOT NULL COMMENT '是否启用，true－启用，false－停用，默认为启用，如果停用，则下级递归停用',
  inlet_uri       VARCHAR(255) NOT NULL COMMENT '模块入口地址',
  discard         TINYINT NOT NULL COMMENT '是否舍弃，true－舍弃，false－未舍弃，如果舍弃，可在管理后台删除',
  PRIMARY KEY(id),
  UNIQUE(pkg_name),
  INDEX(parent_id),
  INDEX(enable)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '模块信息表';

-- -----------------------------------------------------------------------------
-- 1.3、平台系统命令信息表
-- 管理平台系统启动时，将加载的系统模块命令注解信息持久化到命令信息表，包括命令名、
-- 命令访问路径等信息，并为每个条目生成唯一id（数据库自增），用于导航树生成、用户或角色授权时使用。
-- 如果有新增模块命令，当系统重新加载后，命令信息都会更新（id保持不变），以访问路径作为唯一标识。
-- 当数据库中的命令已不在加载的命令中时，则系统自动将数据库中的记录标记为“舍弃”，管理员即可
-- 在管理系统中将其删除
-- 创建时间：2016年03月14日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS command_info (
  id              BIGINT NOT NULL AUTO_INCREMENT COMMENT '条目id',
  parent_id       BIGINT NOT NULL COMMENT '上级id',
  code            VARCHAR(128) NOT NULL COMMENT '条目编码，可用于本地化时使用',
  value           VARCHAR(128) NOT NULL COMMENT '条目名称，如果系统支持本地化，则以code字段为准',
  order_number    INT NOT NULL COMMENT '同级显示顺序',
  pkg_name        VARCHAR(255) NOT NULL COMMENT '包名和方法名',
  path            VARCHAR(255) NOT NULL COMMENT '访问路径',
  enable          TINYINT NOT NULL COMMENT '是否启用，true－启用，false－停用，默认为启用',
  inlet           TINYINT NOT NULL COMMENT '是否是模块入口',
  discard         TINYINT NOT NULL COMMENT '是否舍弃，true－舍弃，false－未舍弃，如果舍弃，可在管理后台删除',
  PRIMARY KEY(id),
  UNIQUE(path),
  INDEX(parent_id),
  INDEX(enable)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '命令信息表';

-- -----------------------------------------------------------------------------
-- 1.4、平台用户信息表 manage_user
-- 保存平台用户信息，包括用户id、用户名、密码、电话号、邮箱地址以及微信号等信息。
-- 创建时间：2016年03月14日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS manage_user (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户id',
  username VARCHAR(128) NOT NULL COMMENT '系统用户名（邮箱）',
  password VARCHAR(128) NOT NULL COMMENT '登录密码',
  name VARCHAR(128) NOT NULL COMMENT '姓名',
  phone VARCHAR(32) NOT NULL COMMENT '电话',
  email VARCHAR(128) NOT NULL COMMENT '业务邮箱，默认与用户名邮箱相同',
  openid VARCHAR(128) NOT NULL COMMENT '微信公众号对应的openid，需关注公司内部微信公众号',
  memo VARCHAR(255) NOT NULL COMMENT '备注',
  send_email INT NOT NULL DEFAULT 1 COMMENT '是否发送系统邮件：0-不发送，1-发送',
  status INT NOT NULL DEFAULT 1 COMMENT '锁定状态：0-停用，1-启用',
  create_date BIGINT NOT NULL COMMENT '创建时间',
  last_visit_date BIGINT NOT NULL COMMENT '最后访问时间',
  PRIMARY KEY (id),
  UNIQUE(username),
  INDEX(name),
  INDEX(phone),
  INDEX(status),
  INDEX(openid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '平台用户信息表';

-- -----------------------------------------------------------------------------
-- 1.4.1、平台角色信息表 manage_role
-- 保存URP角色信息，包括角色id、角色名、角色描述等信息。
-- 创建时间：2016年03月14日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS manage_role (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '角色id',
  name VARCHAR(128) NOT NULL COMMENT '角色名',
  memo VARCHAR(255) NOT NULL COMMENT '备注',
  status INT NOT NULL DEFAULT 1 COMMENT '0-停用，1-启用',
  manager INT NOT NULL DEFAULT 0 COMMENT '是否是管理层,0-否，1-是',
  PRIMARY KEY (id),
  UNIQUE(name),
  INDEX(status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '平台角色信息表';

-- -----------------------------------------------------------------------------
-- 1.4.2、平台用户角色信息表 user_role
-- 保存平台用户、角色关联关系。
-- 创建时间：2016年03月14日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS user_role (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '记录id',
  user_id BIGINT NOT NULL COMMENT '系统用户id',
  role_id BIGINT NOT NULL COMMENT '角色id',
  PRIMARY KEY (id),
  INDEX(user_id),
  INDEX(role_id),
  UNIQUE(user_id, role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '平台用户角色信息表';

-- -----------------------------------------------------------------------------
-- 1.4.3、平台用户权限信息表 user_privilege
-- 平台用户权限信息表，保存平台用户菜单、模块、命令权限关联关系，包括用户id、类型、权限条目id等。
-- 创建时间：2016年03月14日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS user_privilege (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '记录id',
  user_id BIGINT NOT NULL COMMENT '系统用户id',
  item_id BIGINT NOT NULL COMMENT '条目id',
  item_type INT NOT NULL DEFAULT 1 COMMENT '条目类型，0-菜单，1-模块，2-命令',
  PRIMARY KEY (id),
  INDEX(item_id),
  INDEX(user_id),
  INDEX(item_type),
  UNIQUE(user_id, item_id, item_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '平台用户权限信息表';

-- -----------------------------------------------------------------------------
-- 1.4.4、平台角色权限信息表 manage_role_privilege
-- 平台角色权限信息表，保存平台角色菜单、模块、命令权限关联关系，包括角色id、类型、权限条目id等。
-- 创建时间：2016年03月14日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS role_privilege (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '记录id',
  role_id BIGINT NOT NULL COMMENT '系统角色id',
  item_id BIGINT NOT NULL COMMENT '条目id',
  item_type INT NOT NULL DEFAULT 1 COMMENT '条目类型，0-菜单，1-模块，2-命令',
  PRIMARY KEY (id),
  INDEX(item_id),
  INDEX(role_id),
  INDEX(item_type),
  UNIQUE(role_id, item_id, item_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '平台角色权限信息表';

-- -----------------------------------------------------------------------------
-- 1.5、部门信息表 department_info
-- 保存部门信息，包括部门id、部门名称、部门描述等信息。
-- 创建时间：2017年04月13日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS department_info (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '部门id',
  department_name VARCHAR(128) NOT NULL COMMENT '部门名称',
  department_memo VARCHAR(255) NOT NULL COMMENT '部门备注',
  status INT NOT NULL DEFAULT 1 COMMENT '0-停用，1-启用',
  create_time BIGINT NOT NULL COMMENT '创建时间',
  PRIMARY KEY (id),
  UNIQUE(department_name),
  INDEX(status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '部门信息表';

-- -----------------------------------------------------------------------------
-- 1.5.1、部门用户关系表 department_user
-- 保存部门与用户关联信息，包括部门id、用户id等信息。
-- 创建时间：2017年04月13日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS department_user (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '记录id',
  department_id BIGINT NOT NULL COMMENT '部门id',
  user_id BIGINT NOT NULL COMMENT '用户id',
  user_position INT NOT NULL DEFAULT 0 COMMENT '职位,1-负责人,2-普通',
  assign_time BIGINT NOT NULL COMMENT '指派时间',
  PRIMARY KEY (id),
  UNIQUE(user_id,department_id),
  INDEX(department_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '部门用户关系表';

-- -----------------------------------------------------------------------------
-- 1.6、业务组信息表 group_info
-- 保存业务组信息，包括所属部门id、业务组id、业务组名称、业务组描述等信息。
-- 创建时间：2016年08月13日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS group_info (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '业务组id',
  department_id BIGINT NOT NULL COMMENT '所属部门id',
  group_name VARCHAR(128) NOT NULL COMMENT '业务组名',
  group_memo VARCHAR(255) NOT NULL COMMENT '备注',
  status INT NOT NULL DEFAULT 1 COMMENT '0-停用，1-启用',
  create_time BIGINT NOT NULL COMMENT '创建时间',
  PRIMARY KEY (id),
  UNIQUE(department_id,group_name),
  INDEX(status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '业务组信息表';

-- -----------------------------------------------------------------------------
-- 1.6.1、业务组用户关系表 group_user
-- 保存业务组与用户关联信息，包括业务组id、用户id等信息。
-- 创建时间：2016年08月13日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS group_user (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '记录id',
  group_id BIGINT NOT NULL COMMENT '业务组id',
  user_id BIGINT NOT NULL COMMENT '用户id',
  user_position INT NOT NULL DEFAULT 0 COMMENT '职位,1-负责人,1-普通',
  assign_time BIGINT NOT NULL COMMENT '指派时间',
  PRIMARY KEY (id),
  UNIQUE(user_id),
  INDEX(group_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '业务组用户关系表';

-- -----------------------------------------------------------------------------
-- 1.7、用户操作日志表
-- 创建时间：2016年10月24日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS command_log (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '记录id',
  user_id BIGINT NOT NULL COMMENT '用户id',
  name VARCHAR(128) NOT NULL COMMENT '姓名',
  command_id BIGINT NOT NULL COMMENT '命令id',
  command_name VARCHAR(128) NOT NULL COMMENT '命令名称',
  module_name VARCHAR(128) NOT NULL COMMENT '模块名称',
  request_path VARCHAR(256) NOT NULL COMMENT '请求路径',
  parameters VARCHAR(1024) NOT NULL COMMENT '请求参数',
  user_ip VARCHAR(16) NOT NULL COMMENT '用户IP',
  result_successs INT NOT NULL COMMENT '操作是否成功,0为失败，1为成功',
  result_message VARCHAR(128) NOT NULL COMMENT '操作提示信息',
  action_time BIGINT NOT NULL COMMENT '操作时间',
  PRIMARY KEY (id),
  INDEX(action_time),
  INDEX(name),
  INDEX(command_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '用户操作日志表';

-- -----------------------------------------------------------------------------
-- 1.8、系统错误日志表 system_message
-- 保存系统运行期间输出的错误、警告等信息。
-- 创建时间：2016年04月18日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS system_message (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '记录id',
  title VARCHAR(255) NOT NULL COMMENT '消息标题',
  message LONGTEXT NOT NULL COMMENT '消息内容',
  message_level INT NOT NULL DEFAULT 1 COMMENT '消息级别，0-调试，1-普通，2-警告，3-错误',
  message_module VARCHAR(255) NOT NULL COMMENT '消息所在模块（类）',
  message_line VARCHAR(64) NOT NULL COMMENT '消息所在位置',
  message_time BIGINT COMMENT '消息时间',
  PRIMARY KEY (id),
  INDEX(message_level),
  INDEX(message_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '系统错误日志表';

-- -----------------------------------------------------------------------------
-- 1.9、通知类型表
-- 保存系统通知类型类型信息
-- 创建时间：2016年09月27日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS notice_type (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '记录id',
  code VARCHAR(32) NOT NULL COMMENT '类型编码',
  description VARCHAR(64) NOT NULL COMMENT '类型描述',
  PRIMARY KEY (id),
  UNIQUE(code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '通知类型表';

-- -----------------------------------------------------------------------------
-- 1.10、系统通知配置表
-- 通知类型从系统通知类型表获取
-- 创建时间：2016年09月27日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS system_notice_config (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '记录id',
  user_id BIGINT NOT NULL COMMENT '用户id',
  notice_type INT NOT NULL COMMENT '通知类型',
  receive_email INT NOT NULL COMMENT '是否邮箱接收',
  receive_wechat INT NOT NUll COMMENT '是否微信接收',
  PRIMARY KEY (id),
  UNIQUE(user_id,notice_type),
  INDEX(notice_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '系统通知配置表';

-- -----------------------------------------------------------------------------
-- 1.11、系统通知记录表
-- 系统通知记录
-- 创建时间：2016年09月27日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS system_notice_log (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '记录id',
  user_id BIGINT NOT NULL COMMENT '用户id',
  notice_type INT NOT NULL COMMENT '通知类型',
  send_mode INT NOT NULL COMMENT '发送方式',
  send_content VARCHAR(1024) NOT NULL COMMENT '发送内容',
  notice_time BIGINT NOT NULL COMMENT '通知时间',
  PRIMARY KEY (id),
  INDEX(notice_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT '系统通知记录表';

-- -----------------------------------------------------------------------------
-- 1.7、应用api请求日志表
-- 创建时间：2017年10月31日
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS api_log (
  id BIGINT NOT NULL AUTO_INCREMENT COMMENT '记录id',
  business_uid VARCHAR(24) NOT NULL COMMENT '商户id',
  path VARCHAR(256) NOT NULL COMMENT '请求路径',
  action_time BIGINT NOT NULL COMMENT '请求时间',
  res_code  INT NOT NULL COMMENT '返回结果code',
  PRIMARY KEY (id),
  INDEX (business_uid),
  INDEX(action_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_bin COMMENT 'api请求日志表';