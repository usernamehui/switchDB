DROP TABLE IF EXISTS tb_warning;

CREATE TABLE tb_warning (
  id int(11) NOT NULL AUTO_INCREMENT,
  type varchar(10) NOT NULL COMMENT '监控项',
  strategy varchar(10) NOT NULL COMMENT '监控类型 :duration(周期预警)、extreme(个数预警)、threshold(一次性预警)',
  extreme int(11) DEFAULT 0 COMMENT '阈值预警点数',
  duration int(11) DEFAULT 0 COMMENT '周期预警时间(秒)',
  value double NOT NULL COMMENT '预警阈值',
  noteStatus int(2) DEFAULT 0 COMMENT '通知状态',
  noteTemplate int(11) COMMENT '通知模板',
  noteDefault int(2) DEFAULT 1 COMMENT '是否使用默认通知',
  noteType varchar(50) COMMENT '默认通知: 0(短信)、1(邮箱)、2(界面)',
  noteStrategy int(3) DEFAULT 6 COMMENT '通知策略：通知次数(次/天)',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS tb_note_template;

CREATE TABLE tb_note_template (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(20) NOT NULL COMMENT '模板名称',
  theme varchar(100) NOT NULL COMMENT '模板主题',
  content varchar(512) NOT NULL COMMENT '模板内容',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--insert into tb_note_template (name, theme, content, createtime) values ('监控预警模板', '监控预警通知', '尊敬的${receivers}，您好！${host}服务器产生${modle}：${warninfo}。', '1544059396');


DROP TABLE IF EXISTS tb_warning_log;

CREATE TABLE tb_warning_log (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(64) NOT NULL COMMENT '预警类型',
  host varchar(32) NOT NULL COMMENT '主机',
  message varchar(128) DEFAULT '' COMMENT '日志信息',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  noteResult varchar(32) DEFAULT '' COMMENT '通知结果: 错误码',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS tb_note_type;

CREATE TABLE tb_note_type (
  id int(11) NOT NULL AUTO_INCREMENT,
  type int(2) NOT NULL COMMENT '通知类型：0(短信)、1(邮箱)、2(界面)',
  name varchar(32) NOT NULL COMMENT '名称',
  status int(2) DEFAULT 0 COMMENT '通知状态: 0(停用)、1(启用)',
  customType varchar(10) NOT NULL COMMENT '类型: sms(短信)、email(邮件)、cpu、memory、disk、network(自定义)',
  strategyTime varchar(16) DEFAULT '' COMMENT '发送时间策略',
  value longtext COMMENT '配置内容',
  PRIMARY KEY (id),
  UNIQUE KEY value (customType, type) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--insert into tb_note_type (type, name, customType) values (0, 'SMS', 'sms');
--insert into tb_note_type (type, name, customType) values (1, 'Email', 'email');


DROP TABLE IF EXISTS tb_monitor_history_log;

CREATE TABLE tb_monitor_history_log (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '预警类型',
  name varchar(16) NOT NULL COMMENT '类型实例',
  value double DEFAULT 0 COMMENT '监控值',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS tb_monitor_history_log_week;
CREATE TABLE tb_monitor_history_log_week (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '预警类型',
  name varchar(16) NOT NULL COMMENT '类型实例',
  value double DEFAULT 0 COMMENT '监控值',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS tb_monitor_history_log_month;
CREATE TABLE tb_monitor_history_log_month (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '预警类型',
  name varchar(16) NOT NULL COMMENT '类型实例',
  value double DEFAULT 0 COMMENT '监控值',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS tb_sign_monitor_history_day;
CREATE TABLE tb_sign_monitor_history_day (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_sign_monitor_history_week;
CREATE TABLE tb_sign_monitor_history_week (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_sign_monitor_history_month;
CREATE TABLE tb_sign_monitor_history_month (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_vsign_monitor_history_day;
CREATE TABLE tb_vsign_monitor_history_day (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_vsign_monitor_history_week;
CREATE TABLE tb_vsign_monitor_history_week (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_vsign_monitor_history_month;
CREATE TABLE tb_vsign_monitor_history_month (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_envelope_monitor_history_day;
CREATE TABLE tb_envelope_monitor_history_day (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_envelope_monitor_history_week;
CREATE TABLE tb_envelope_monitor_history_week (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_envelope_monitor_history_month;
CREATE TABLE tb_envelope_monitor_history_month (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_venvelope_monitor_history_day;
CREATE TABLE tb_venvelope_monitor_history_day (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_venvelope_monitor_history_week;
CREATE TABLE tb_venvelope_monitor_history_week (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_venvelope_monitor_history_month;
CREATE TABLE tb_venvelope_monitor_history_month (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_symencrypt_monitor_history_day;
CREATE TABLE tb_symencrypt_monitor_history_day (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_symencrypt_monitor_history_week;
CREATE TABLE tb_symencrypt_monitor_history_week (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_symencrypt_monitor_history_month;
CREATE TABLE tb_symencrypt_monitor_history_month (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_symdecrypt_monitor_history_day;
CREATE TABLE tb_symdecrypt_monitor_history_day (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_symdecrypt_monitor_history_week;
CREATE TABLE tb_symdecrypt_monitor_history_week (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_symdecrypt_monitor_history_month;
CREATE TABLE tb_symdecrypt_monitor_history_month (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_asymencrypt_monitor_history_day;
CREATE TABLE tb_asymencrypt_monitor_history_day (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_asymencrypt_monitor_history_week;
CREATE TABLE tb_asymencrypt_monitor_history_week (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_asymencrypt_monitor_history_month;
CREATE TABLE tb_asymencrypt_monitor_history_month (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_asymdecrypt_monitor_history_day;
CREATE TABLE tb_asymdecrypt_monitor_history_day (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_asymdecrypt_monitor_history_week;
CREATE TABLE tb_asymdecrypt_monitor_history_week (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_asymdecrypt_monitor_history_month;
CREATE TABLE tb_asymdecrypt_monitor_history_month (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_tsa_monitor_history_day;
CREATE TABLE tb_tsa_monitor_history_day (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_tsa_monitor_history_week;
CREATE TABLE tb_tsa_monitor_history_week (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_tsa_monitor_history_month;
CREATE TABLE tb_tsa_monitor_history_month (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_vtsa_monitor_history_day;
CREATE TABLE tb_vtsa_monitor_history_day (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_vtsa_monitor_history_week;
CREATE TABLE tb_vtsa_monitor_history_week (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_vtsa_monitor_history_month;
CREATE TABLE tb_vtsa_monitor_history_month (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_querycert_monitor_history_day;
CREATE TABLE tb_querycert_monitor_history_day (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_querycert_monitor_history_week;
CREATE TABLE tb_querycert_monitor_history_week (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS tb_querycert_monitor_history_month;
CREATE TABLE tb_querycert_monitor_history_month (
  id int(11) NOT NULL AUTO_INCREMENT,
  host varchar(32) NOT NULL COMMENT '主机',
  type varchar(16) NOT NULL COMMENT '业务类型',
  app varchar(16) NOT NULL COMMENT '应用',
  cert varchar(256) NOT NULL COMMENT '证书',
  successNum double DEFAULT 0 COMMENT '成功',
  failedNum double DEFAULT 0 COMMENT '失败',
  successTotal double DEFAULT 0 COMMENT '成功总数',
  failedTotal double DEFAULT 0 COMMENT '失败总数',
  createtime bigint(20) DEFAULT NULL COMMENT '记录时间',
  time bigint(20) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;