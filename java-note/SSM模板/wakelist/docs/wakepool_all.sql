SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS  `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS  `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS  `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

insert into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values
('1','Can add log entry','1','add_logentry'),
('2','Can change log entry','1','change_logentry'),
('3','Can delete log entry','1','delete_logentry'),
('4','Can add group','2','add_group'),
('5','Can change group','2','change_group'),
('6','Can delete group','2','delete_group'),
('7','Can add permission','3','add_permission'),
('8','Can change permission','3','change_permission'),
('9','Can delete permission','3','delete_permission'),
('10','Can add user','4','add_user'),
('11','Can change user','4','change_user'),
('12','Can delete user','4','delete_user'),
('13','Can add content type','5','add_contenttype'),
('14','Can change content type','5','change_contenttype'),
('15','Can delete content type','5','delete_contenttype'),
('16','Can add session','6','add_session'),
('17','Can change session','6','change_session'),
('18','Can delete session','6','delete_session');
DROP TABLE IF EXISTS  `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS  `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS  `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS  `cmf_users`;
CREATE TABLE `cmf_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) NOT NULL DEFAULT '' COMMENT '用户名',
  `user_pass` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码；sp_password加密',
  `user_tt` int(11) NOT NULL,
  `url` varchar(200) DEFAULT '-',
  `user_nicename` varchar(50) NOT NULL DEFAULT '' COMMENT '用户美名',
  `serial` int(11) DEFAULT NULL,
  `channel` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '激活状态',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户表';

insert into `cmf_users`(`id`,`user_login`,`user_pass`,`user_tt`,`url`,`user_nicename`,`serial`,`channel`,`status`) values
('1','admin','96e79218965eb72c92a549dd5a330112','0','','admin','0','0','1');
DROP TABLE IF EXISTS  `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS  `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

insert into `django_content_type`(`id`,`app_label`,`model`) values
('1','admin','logentry'),
('2','auth','group'),
('3','auth','permission'),
('4','auth','user'),
('5','contenttypes','contenttype'),
('6','sessions','session');
DROP TABLE IF EXISTS  `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

insert into `django_migrations`(`id`,`app`,`name`,`applied`) values
('1','contenttypes','0001_initial','2018-08-23 06:02:22'),
('2','auth','0001_initial','2018-08-23 06:02:24'),
('3','admin','0001_initial','2018-08-23 06:02:25'),
('4','admin','0002_logentry_remove_auto_add','2018-08-23 06:02:25'),
('5','contenttypes','0002_remove_content_type_name','2018-08-23 06:02:25'),
('6','auth','0002_alter_permission_name_max_length','2018-08-23 06:02:26'),
('7','auth','0003_alter_user_email_max_length','2018-08-23 06:02:26'),
('8','auth','0004_alter_user_username_opts','2018-08-23 06:02:26'),
('9','auth','0005_alter_user_last_login_null','2018-08-23 06:02:27'),
('10','auth','0006_require_contenttypes_0002','2018-08-23 06:02:27'),
('11','auth','0007_alter_validators_add_error_messages','2018-08-23 06:02:27'),
('12','auth','0008_alter_user_username_max_length','2018-08-23 06:02:27'),
('13','sessions','0001_initial','2018-08-23 06:02:29');
DROP TABLE IF EXISTS  `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS  `mod_channel`;
CREATE TABLE `mod_channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `img_url` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'icon',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

insert into `mod_channel`(`id`,`channel`,`img_url`) values
('1','mu2','-'),
('2','zw01','-'),
('3','sohu','-'),
('4','shouyou','-'),
('5','bird004','-'),
('6','bird001','-'),
('7','bird002','-'),
('8','bird003','-'),
('9','luoge','-'),
('10','lyrqa1008','-'),
('11','lishi1','-'),
('12','default','-'),
('13','mdht','-'),
('14','sohu3','-'),
('15','cgm03','-'),
('16','youluo01','-'),
('17','luoge01','-'),
('18','test','-'),
('19','kly01','-'),
('20','cj02','-'),
('21','testhd','-'),
('22','jcl02','-');
DROP TABLE IF EXISTS  `mod_product`;
CREATE TABLE `mod_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `p_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '包名',
  `channel` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '渠道',
  `deeplink` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'deeplink',
  `url` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'url',
  `starttime` datetime NOT NULL COMMENT '投放有效期',
  `status` tinyint(4) NOT NULL COMMENT '激活状态',
  `endtime` datetime DEFAULT NULL,
  `priority` tinyint(4) DEFAULT '0' COMMENT '优先级',
  `imgurl` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` tinyint(4) DEFAULT '0' COMMENT '广告类型',
  `pid` int(11) NOT NULL,
  `code` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '淘口令',
  `msg` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '广告文案',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=916 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

insert into `mod_product`(`id`,`p_name`,`channel`,`deeplink`,`url`,`starttime`,`status`,`endtime`,`priority`,`imgurl`,`type`,`pid`,`code`,`msg`) values
('903','com.taobao.taobao','test','tbopen://m.taobao.com/tbopen/index.html?source=auto&action=ali.open.nav&module=h5&bootImage=0&h5Url=https%3A%2F%2Fs.click.taobao.com%2Ft%3Fe%3Dm%253D2%2526s%253DP6kgx14dEq4cQipKwQzePCperVdZeJviK7Vc7tFgwiFRAdhuF14FMataR7sHtuee5x%252BIUlGKNpUsMV71iRjhYWzzD9sEkQhNs6%252Bz%252BA9bxuz%252Bd96p6EqZ5ZwIqRHwxvj3MfKrdHtGywGOywGtw1KzNs7ebxIp7nyFQBRB1XJCO28%252B9Dpg8On9lST8IooNW8Sza6XX9QIZVDvGDmntuH4VtA%253D%253D&spm=2014.ugdhh.3302364485.1154&bc_fl_src=growth_dhh_3302364485_1154&materialid=1154','https://s.click.taobao.com/t?e=m%3D2%26s%3DP6kgx14dEq4cQipKwQzePCperVdZeJviK7Vc7tFgwiFRAdhuF14FMataR7sHtuee5x%2BIUlGKNpUsMV71iRjhYWzzD9sEkQhNs6%2Bz%2BA9bxuz%2Bd96p6EqZ5ZwIqRHwxvj3MfKrdHtGywGOywGtw1KzNs7ebxIp7nyFQBRB1XJCO28%2B9Dpg8On9lST8IooNW8Sza6XX9QIZVDvGDmntuH4VtA%3D%3D&spm=2014.ugdhh.3302364485.1154&bc_fl_src=growth_dhh_3302364485_1154','2018-07-19 00:00:00','1','2018-08-31 00:00:00','0',null,'1','1154','€c9FhbboaNBo€',null),
('906','com.taobao.taobao','jcl02','tbopen://m.taobao.com/tbopen/index.html?source=auto&action=ali.open.nav&module=h5&bootImage=0&h5Url=https%3A%2F%2Fs.click.taobao.com%2FsjaqZNw&spm=2014.ugdhh.3302364485.1201-729&bc_fl_src=growth_dhh_3302364485_1201-729&materialid=1201','','2018-07-19 00:00:00','1','2018-08-31 00:00:00','0',null,'1','1155','',null),
('907','com.ss.android.ugc.live','test','snssdk1112://item?id=6580645166334348551&push_id=80*00007&gd_label=click_schema_hs4','','2018-08-06 00:00:00','1','2018-08-08 00:00:00','0',null,'0','1100','',null),
('908','com.taobao.taobao','cj02','tbopen://m.taobao.com/tbopen/index.html?source=auto&action=ali.open.nav&module=h5&bootImage=0&h5Url=http%3A%2F%2Fs.click.taobao.com%2Ft%3Fe%3Dm%253D2%2526s%253DNfVwqnTHurRw4vFB6t2Z2iperVdZeJvipRe%252F8jaAHciLme4nz7IQD00cnxdP4uM66g%252Bn2P61JT37%252Bk46yyCXGvzFYQYlrEiXQ%252Fw7AsQZ7jspyQVKJHiTtOTEWJdP8jmRxIUU7SFfPVE3rODJ1i9aALWOELdnGdZVof9rR5Kdp5dOoalmDDOHzcYOae24fhW0&spm=2014.ugdhh.3302364485.1187-672&bc_fl_src=growth_dhh_3302364485_1187-672&materialid=1187','','2018-08-01 00:00:00','1','2018-08-17 00:00:00','1',null,'0','1187','€Gq3NbYeX2Dp€',null),
('909','com.taobao.taobao','cj02','tbopen://m.taobao.com/tbopen/index.html?source=auto&action=ali.open.nav&module=h5&bootImage=0&h5Url=http%3A%2F%2Fs.click.taobao.com%2Ft%3Fspm%3D0.0.0.0.0_0.0.0.0%26e%3Dm%253D2%2526s%253D2d40ytZJ5rUcQipKwQzePCperVdZeJviK7Vc7tFgwiFRAdhuF14FMZ1N9LqlZ8q32XPP23XswEPiCpeCUkeJc8tA8Qks8BYBXdZXtfxfyx18isIqg9litAZn%252By0keumoG6FOBjhgmzh%252BPGXoAieI2pJcxXijM%252BwnUUEsvgbQNwdwlre08HRZzQ%253D%253D%26pid%3Dmm_26632655_45614004_12422300179&spm=2014.ugdhh.3302364485.1188&bc_fl_src=growth_dhh_3302364485_1188&materialid=1188','','2018-08-02 00:00:00','1','2018-08-17 00:00:00','1',null,'0','1188','€NgYsbYecu2d€',null),
('910','com.ss.android.article.video','test','snssdk32://home/news?gd_label=click_schema_hs4','-','2018-08-06 00:00:00','0','2018-08-07 00:00:00','0',null,'0','1101','-',null),
('911','com.ss.android.ugc.aweme','test','snssdk1128://detail?id=6577585110185413895&gd_label=click_schema_hs4','-','2018-08-06 00:00:00','0','2018-08-07 00:00:00','0',null,'0','1102','-',null),
('912','com.ss.android.article.news','test','snssdk143://detail?groupid=6584002300946153987&gd_label=click_schema_hs4','-','2018-08-06 00:00:00','1','2018-08-07 00:00:00','0',null,'0','1103','-',null),
('913','com.baidu.searchbox','test','baiduboxapp://utils?action=sendIntent&minver=7.4&params=%7B%22intent%22%3A%22intent%3A%23Intent%3Baction%3Dcom.baidu.searchbox.action.HOME%3BS.targetCommand%3D%257B%2522mode%2522%253A%25220%2522%252C%2522intent%2522%253A%2522intent%253A%2523Intent%253BB.bdsb_append_param%253Dtrue%253BS.bdsb_light_start_url%253Dhttps%25253a%25252f%25252fmr.mbd.baidu.com%25252f7i54l37%25253ff%25253dcp%253Bend%2522%252C%2522class%2522%253A%2522com.baidu.searchbox.xsearch.UserSubscribeCenterActivity%2522%252C%2522min_v%2522%253A%252216787968%2522%257D%3Bend%22%7D&needlog=1&logargs=%7B%22source%22%3A%221021285d%22%2C%22from%22%3A%22openbox%22%2C%22page%22%3A%22other%22%2C%22type%22%3A%22%22%2C%22value%22%3A%22url%22%2C%22channel%22%3A%22%22%7D','-','2018-08-07 00:00:00','1','2018-08-23 00:00:00','0',null,'0','1000','-',null),
('914','com.UCMobile','test','uclink://www.uc.cn/cc77796ca7c25dff9607d31b29effc07?action=open_url&src_pkg=mandong1&src_ch=mandong1&url=http%3a%2f%2fm.uczzd.cn%2fwebapp%2fwebview%2farticle%2fnews.html%3fapp%3duc-iflow%26aid%3d14334608928038940639%26cid%3d100%26zzd_from%3duc-iflow%26uc_param_str%3ddndseiwifrvesvntgipf%26recoid%3d%26readId%3d%26rd_type%3dreco%26previewdl%3d1%26cmtdebug%3d1','-','2018-08-08 00:00:00','1','2018-08-09 00:00:00','0',null,'0','1104','-',null),
('915','com.autonavi.minimap','test','amapuri://webview/amaponline?url=https://cache.amap.com/activity/2018summerTri/index.html?gd_from=csmandong1','-','2018-08-15 00:00:00','1','2018-08-31 00:00:00','0',null,'1','1105','-',null);
DROP TABLE IF EXISTS  `mod_time`;
CREATE TABLE `mod_time` (
  `id` int(11) NOT NULL,
  `shour` tinyint(4) DEFAULT NULL COMMENT '起始小时：0-23',
  `sminute` tinyint(4) DEFAULT NULL COMMENT '起始分钟：0-60',
  `ehour` tinyint(4) DEFAULT NULL COMMENT '终止小时：0-23',
  `eminute` tinyint(4) DEFAULT NULL COMMENT '终止分钟：0-60',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

insert into `mod_time`(`id`,`shour`,`sminute`,`ehour`,`eminute`) values
('0','8','0','23','59');
DROP TABLE IF EXISTS  `mod_title`;
CREATE TABLE `mod_title` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msg` varchar(200) COLLATE utf8_unicode_ci NOT NULL COMMENT '推广文案',
  `pid` int(11) NOT NULL COMMENT '产品id',
  `status` int(11) NOT NULL COMMENT '激活状态',
  `imgurl` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

insert into `mod_title`(`id`,`msg`,`pid`,`status`,`imgurl`) values
('93','淘宝测试','903','1','http://girlsimg.oss-cn-beijing.aliyuncs.com/taoad/toutiao-060801.jpg'),
('94','','906','1',''),
('95','火山','907','1',''),
('96','优选好货，爆款特卖！','908','1','http://girlsimg.oss-cn-beijing.aliyuncs.com/taoad/1187.png'),
('97','第二件0.1元！地道鲜选，吃遍云南！','909','1','http://girlsimg.oss-cn-beijing.aliyuncs.com/taoad/1188.png'),
('98','请输入该产品文案','907','1',''),
('99','西瓜','910','1','-'),
('100','抖音','911','1','-'),
('101','今日头条','912','1','-'),
('102','手机百度','913','1','1'),
('103','UC浏览器','2147483647','1','-'),
('104','UC浏览器','914','1','-'),
('105','高德地图','915','1','-');
SET FOREIGN_KEY_CHECKS = 1;

