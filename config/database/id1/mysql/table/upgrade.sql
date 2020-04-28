
DROP TABLE IF EXISTS tb_upgrade_package;

CREATE TABLE tb_upgrade_package (
  id int(11) NOT NULL AUTO_INCREMENT,
  updateId varchar(64) NOT NULL COMMENT '升级包ID',
  updateVersion varchar(32) NOT NULL COMMENT '升级包版本',
  updateName varchar(64) NOT NULL COMMENT '升级包名称',
  updateFile longtext COMMENT '升级包信息文件内容',
  updateStatus int(2) DEFAULT 0 COMMENT '升级包状态(0: 未下载, 1: 已下载, 2: 已升级)',
  productSize int(16) DEFAULT 0 COMMENT '升级包大小(单位B)',
  PRIMARY KEY (id),
  UNIQUE KEY value (updateId) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
