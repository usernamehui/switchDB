DROP TABLE IF EXISTS t_admin;
DROP TABLE IF EXISTS t_admin_account;
DROP TABLE IF EXISTS t_admin_attribute;
DROP TABLE IF EXISTS t_admin_cert;
DROP TABLE IF EXISTS t_admin_auth;
DROP TABLE IF EXISTS t_admin_role;
DROP TABLE IF EXISTS t_role;
DROP TABLE IF EXISTS tb_cube_config;
DROP TABLE IF EXISTS tb_backlog_task;
DROP TABLE IF EXISTS jit_common_crldown_config;
DROP TABLE IF EXISTS jit_common_crldown_url;
DROP TABLE IF EXISTS jit_common_ocsp;
DROP TABLE IF EXISTS jit_common_crlentity;
DROP TABLE IF EXISTS jit_common_cacert;
DROP TABLE IF EXISTS tb_log;
DROP TABLE IF EXISTS tb_log_history;
DROP TABLE IF EXISTS tb_export_task;
DROP TABLE IF EXISTS tb_system_log;
DROP TABLE IF EXISTS tb_system_log_backup;
DROP TABLE IF EXISTS tb_backup;
DROP TABLE IF EXISTS tb_license_privilege;
DROP TABLE IF EXISTS tb_encryptor;

CREATE TABLE t_admin (
  ADMIN_ID varchar(32) NOT NULL COMMENT '主键id',
  NAME varchar(50) DEFAULT NULL COMMENT '姓名',
  PHONE varchar(20) DEFAULT NULL COMMENT '手机号',
  EMAIL varchar(50) DEFAULT NULL COMMENT '邮箱',
  STATUS varchar(1) NOT NULL DEFAULT '0' COMMENT '管理员状态   0：启用     1：停用',
  CREATE_OPERATOR varchar(32) DEFAULT NULL COMMENT '创建人id',
  CREATE_TIME bigint(20) DEFAULT NULL COMMENT '创建时间',
  LAST_OPERATOR varchar(32) DEFAULT NULL COMMENT '最后操作人id',
  LAST_TIME bigint(20) DEFAULT NULL COMMENT '最后操作时间',
  PRIMARY KEY (ADMIN_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE t_admin_account (
  ACCOUNT_ID VARCHAR(32) NOT NULL COMMENT '主键ID',
  ADMIN_ID VARCHAR(32) DEFAULT NULL COMMENT '管理员ID',
  ACCOUNT VARCHAR(50) DEFAULT NULL COMMENT '账号',
  PASSWORD VARCHAR(50) DEFAULT NULL COMMENT '密码',
  PASSWORDSTATUS VARCHAR(1) DEFAULT NULL COMMENT '密码修改状态  0：未修改 1：已修改',
  CREATE_OPERATOR VARCHAR(32) DEFAULT NULL COMMENT '录入人ID',
  CREATE_TIME bigint(20) DEFAULT NULL COMMENT '录入时间',
  LAST_OPERATOR varchar(255) DEFAULT NULL COMMENT '修改人ID',
  LAST_TIME bigint(20) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (ACCOUNT_ID)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
alter table t_admin_account add unique(ACCOUNT);

CREATE TABLE t_admin_attribute (
  attribute_id varchar(50) NOT NULL,
  admin_id varchar(50) DEFAULT NULL,
  name varchar(100) DEFAULT NULL,
  value varchar(1000) DEFAULT NULL,
  create_operator varchar(512) DEFAULT NULL,
  create_time bigint(20) DEFAULT NULL,
  last_operator varchar(512) DEFAULT NULL,
  last_time bigint(20) DEFAULT NULL,
  PRIMARY KEY (attribute_id),
  KEY fk_admin_attribute (admin_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE t_admin_cert (
  CERT_ID varchar(32) NOT NULL COMMENT '主键id',
  ADMIN_ID varchar(32) DEFAULT NULL COMMENT '管理员id',
  CERTENTITY longtext COMMENT '证书base64编码',
  SUBJECT varchar(255) DEFAULT NULL COMMENT '证书主题',
  ISSUER varchar(255) DEFAULT NULL COMMENT '证书颁发者',
  CERT_IDENTIFIER varchar(255) DEFAULT NULL,
  CREATE_OPERATOR varchar(32) DEFAULT NULL COMMENT '录入人id',
  CREATE_TIME bigint(20) DEFAULT NULL COMMENT '录入时间',
  LAST_OPERATOR varchar(32) DEFAULT NULL COMMENT '修改人id',
  LAST_TIME bigint(20) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (CERT_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
alter table t_admin_cert add unique(CERT_IDENTIFIER);

CREATE TABLE t_admin_auth (
  AUTH_ID varchar(32) NOT NULL COMMENT '主键id',
  ADMIN_ID varchar(32) DEFAULT NULL COMMENT '管理员id',
  PASSWORD varchar(64) DEFAULT NULL COMMENT '增强密码',
  STATUS int(2) DEFAULT '0' COMMENT '密码修改状态  0：未修改 1：已修改',
  PRIMARY KEY (AUTH_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE t_admin_role (
  ID varchar(32) NOT NULL COMMENT '主键id',
  ADMIN_ID varchar(32) DEFAULT NULL COMMENT '系统管理员id',
  ROLENAME varchar(32) DEFAULT NULL COMMENT '角色id',
  CREATE_OPERATOR varchar(32) DEFAULT NULL,
  CREATE_TIME bigint(20) DEFAULT NULL,
  LAST_OPERATOR varchar(32) DEFAULT NULL,
  LAST_TIME bigint(20) DEFAULT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE t_role (
  ROLE_ID varchar(32) NOT NULL COMMENT '主键id',
  NAME varchar(20) DEFAULT NULL COMMENT '角色名称',
  DESCRIPTION varchar(100) DEFAULT NULL COMMENT '角色描述',
  DISPLAY longblob,
  EDITOR longblob,
  DEFAULTROLE longblob,
  CREATE_OPERATOR varchar(32) DEFAULT NULL COMMENT '创建人',
  CREATE_TIME bigint(20) DEFAULT NULL COMMENT '创建时间',
  LAST_OPERATOR varchar(32) DEFAULT NULL,
  LAST_TIME bigint(20) DEFAULT NULL,
  PRIMARY KEY (ROLE_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_cube_config (
  ID int(11) NOT NULL AUTO_INCREMENT,
  SERVICE_ID varchar(64) DEFAULT NULL,
  NAME varchar(100) DEFAULT NULL,
  VALUE longtext,
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE tb_backlog_task (
  TASKID varchar(32) NOT NULL COMMENT '任务主键id',
  TASKNAME varchar(30) DEFAULT NULL COMMENT '任务名称',
  TABLENAME varchar(30) DEFAULT NULL COMMENT '日志表-名称',
  TASKSTATUS varchar(1) DEFAULT NULL COMMENT '任务执行状态    0：执行中   1：闲置',
  TASKRESULT varchar(1) DEFAULT NULL COMMENT '任务上次执行结果   0：成功   1：失败',
  ERRORMSG text COMMENT '发生异常时的错误信息',
  STARTTIME datetime DEFAULT NULL COMMENT '（上次）开始执行时间',
  ENDTIME datetime DEFAULT NULL COMMENT '执行（上次）结束时间',
  NEXTFIRETIME datetime DEFAULT NULL COMMENT '任务下次执行时间',
  LOCALFILEDOWNLOADPATH varchar(500) DEFAULT NULL COMMENT '手动归档操作-本地归档类型-归档文件下载路径',
  CREATETIME datetime DEFAULT NULL COMMENT '任务创建时间',
  OPERATETIME datetime DEFAULT NULL COMMENT '任务操作时间',
  PRIMARY KEY (TASKID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE jit_common_cacert (
  id varchar(50) NOT NULL,
  name varchar(512) NOT NULL,
  rootcerttype varchar(30) NOT NULL,
  issuer varchar(512) NOT NULL,
  subject varchar(512) NOT NULL,
  notbefore datetime DEFAULT NULL,
  notafter datetime DEFAULT NULL,
  validity int(11) NOT NULL,
  superid varchar(50) NOT NULL,
  certverifydepth int(11) NOT NULL,
  checktype int(11) NOT NULL,
  subjectkeyidentifier varchar(100) DEFAULT NULL,
  certentity longblob,
  createby varchar(512) DEFAULT NULL,
  createtime datetime DEFAULT NULL,
  lastmodifytime datetime DEFAULT NULL,
  lastmodifyby varchar(512) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE jit_common_crldown_config (
  id varchar(50) NOT NULL,
  updatepolicy int(11) NOT NULL,
  updatetimetype char(1) DEFAULT NULL,
  timeinterval int(11) DEFAULT NULL,
  crlnexttime timestamp ,
  crltimeafter int(11),
  createby varchar(512) DEFAULT NULL,
  createtime timestamp,
  lastmodifytime timestamp,
  lastmodifyby varchar(512) DEFAULT NULL,
  ca_id varchar(50) NOT NULL,
  PRIMARY KEY (id),
  KEY ca_id (ca_id),
  CONSTRAINT jit_common_crldown_config_ibfk_1 FOREIGN KEY (ca_id) REFERENCES jit_common_cacert (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE jit_common_crlentity (
  id varchar(50) NOT NULL,
  crlfile longblob NOT NULL,
  issuer varchar(512) NOT NULL,
  startdate datetime NOT NULL,
  nextupdatedate datetime NOT NULL,
  signalgorithm varchar(50) NOT NULL,
  authoritykeyidentifier varchar(64) DEFAULT NULL,
  crlnumber int(11) DEFAULT NULL,
  crluniqueidentifier varchar(64) DEFAULT NULL,
  crltype int(11) NOT NULL,
  cacertid varchar(50) NOT NULL,
  downloadurl varchar(2048) DEFAULT NULL,
  downloadtype char(4) NOT NULL,
  createby varchar(512) DEFAULT NULL,
  createtime datetime DEFAULT NULL,
  lastmodifytime datetime DEFAULT NULL,
  lastmodifyby varchar(512) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
alter table jit_common_crlentity add unique(cacertid,crluniqueidentifier);

CREATE TABLE jit_common_crldown_url (
  id varchar(50) NOT NULL,
  downloadtype char(4) NOT NULL,
  ldapuserdn varchar(512) DEFAULT NULL,
  ldappassword varchar(64) DEFAULT NULL,
  url varchar(2048) NOT NULL,
  crltype int(11) NOT NULL,
  cacertid varchar(50) NOT NULL,
  createby varchar(512) DEFAULT NULL,
  createtime datetime DEFAULT NULL,
  lastmodifytime datetime DEFAULT NULL,
  lastmodifyby varchar(512) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY cacertid (cacertid),
  CONSTRAINT jit_common_crldown_url_ibfk_1 FOREIGN KEY (cacertid) REFERENCES jit_common_cacert (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE jit_common_ocsp (
  id varchar(50) NOT NULL,
  principaltype varchar(10) NOT NULL,
  principalurl varchar(2048) NOT NULL,
  subordinatetype varchar(10) DEFAULT NULL,
  subordinateurl varchar(2048) DEFAULT NULL,
  createby varchar(512) DEFAULT NULL,
  createtime timestamp ,
  lastmodifytime timestamp ,
  lastmodifyby varchar(512) DEFAULT NULL,
  ca_id varchar(50) NOT NULL,
  PRIMARY KEY (id),
  KEY ca_id (ca_id),
  CONSTRAINT jit_common_ocsp_ibfk_1 FOREIGN KEY (ca_id) REFERENCES jit_common_cacert (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tb_log (
  log_id int(11) NOT NULL AUTO_INCREMENT,
  operator varchar(200) DEFAULT NULL,
  operator_ip varchar(50) DEFAULT NULL,
  create_time bigint(20) DEFAULT NULL COMMENT '存储使用年月日小时分秒毫秒 共17位数字',
  operat_content varchar(1000) DEFAULT NULL,
  operat_result varchar(1000) DEFAULT NULL,
  operat_data varchar(1000) DEFAULT NULL,
  server_sign varchar(2000) DEFAULT NULL,
  result varchar(50) DEFAULT NULL,
  client_sign longtext,
  PRIMARY KEY (log_id),
  KEY create_time (create_time)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

CREATE TABLE tb_log_history (
  log_id int(11) NOT NULL AUTO_INCREMENT,
  operator varchar(200) DEFAULT NULL,
  operator_ip varchar(50) DEFAULT NULL,
  create_time bigint(20) DEFAULT NULL COMMENT '存储使用年月日小时分秒毫秒 共17位数字',
  operat_content varchar(1000) DEFAULT NULL,
  operat_result varchar(1000) DEFAULT NULL,
  operat_data varchar(1000) DEFAULT NULL,
  server_sign varchar(2000) DEFAULT NULL,
  result varchar(50) DEFAULT NULL,
  client_sign longtext,
  PRIMARY KEY (log_id),
  KEY create_time (create_time)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

CREATE TABLE tb_export_task (
  TASKID varchar(32) DEFAULT NULL COMMENT '主键id',
  TASKNAME varchar(30) DEFAULT NULL COMMENT '任务名称',
  TASKSTATUS varchar(1) DEFAULT NULL COMMENT '任务执行状态    0：执行中   1：闲置',
  TASKRESULT varchar(1) DEFAULT NULL COMMENT '任务上次执行结果   0：成功   1：失败',
  LOGTYPE varchar(32) DEFAULT NULL COMMENT '日志配置ID',
  STARTTIME datetime DEFAULT NULL COMMENT '（上次）开始执行时间',
  ENDTIME datetime DEFAULT NULL COMMENT '执行（上次）结束时间',
  ZIPFILEDOWNLOADPATH varchar(500) DEFAULT NULL COMMENT 'zip文件下载路径',
  ERRORINFO text COMMENT '错误信息',
  CREATETIME datetime DEFAULT NULL COMMENT '任务创建时间',
  OPERATETIME datetime DEFAULT NULL COMMENT '任务操作时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table  tb_system_log (
  log_id int not null auto_increment,
  create_time bigint(20) default null,
  operat_content varchar(100) default null,
  operat_data varchar(1000) default null,
  operat_result varchar(50) default null,
  primary key  (log_id),
  key create_time (create_time)
);
create table  tb_system_log_backup (
  backup_id int not null AUTO_INCREMENT,
  log_id int default null,
  create_time bigint(20) default null,
  operat_content varchar(100) default null,
  operat_data varchar(1000) default null,
  operat_result varchar(50) default null,
  primary key  (backup_id),
  key create_time (create_time)
);
create table tb_backup (
  backupId varchar(32) NOT NULL COMMENT '主键ID',
  backupName varchar(255) DEFAULT NULL COMMENT '备份名称',
  backupStatus char(1) DEFAULT NULL COMMENT '备份结果  0:成功  1:失败',
  backupTime datetime DEFAULT NULL COMMENT '备份时间',
  backupFileSize varchar(30) DEFAULT NULL COMMENT '备份文件大小',
  backupLocation char(1) DEFAULT NULL COMMENT '备份位置  0:本地  1:ftp',
  backupType char(1) DEFAULT NULL COMMENT '备份类型  0:手动  1:上传',
  PRIMARY KEY (backupId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table tb_license_privilege(
	id 			int not null auto_increment,
	code        varchar(50) comment '编码',
	type        char(2) comment '1.license 2.软件版 3.加密机 4.管理员查看权限',
	menu_id     varchar(100) comment '菜单表ID 或 页面元素ID',
	menu_type   char(2) comment '1.菜单表ID 2.页面元素ID 3.通用开关',
	open_status varchar(5) comment '1.true(开启) 2.false(屏蔽)',
	comment varchar(200) comment '备注',
	primary key(id)
)ENGINE=INNODB DEFAULT CHARSET=UTF8;

CREATE TABLE `tb_encryptor`  (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设置主键自增',
  `NAME` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `MANUFACTURER` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '厂商',
  `IP` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'IP地址',
  `PORT` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '端口号',
  `USER` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '用户名',
  `PW` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '密码',
  `CREATE_USER` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人员',
  `CREATE_TIME` bigint(20) NOT NULL COMMENT '创建时间',
  `UPDATE_USER` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人员',
  `UPDATE_TIME` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  `STATUS` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '1.开启 0.停用',
  `REMARK` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
   PRIMARY KEY (`ID`) USING BTREE
)  ENGINE=INNODB DEFAULT CHARSET=UTF8;