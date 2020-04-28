use gateway;
-- 创建印章表
DROP TABLE IF EXISTS `tb_seal`;
CREATE TABLE IF NOT EXISTS `tb_seal` (
  `id` VARCHAR(50) NOT NULL COMMENT '主键id',
  `seal_id` VARCHAR(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '印章标识',
  `seal_name` VARCHAR(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '印章名称',
  `seal_type` CHAR(2) DEFAULT '0' COMMENT '印章类型,0-公章 1-公章(法人章) 2-公章(合同章) 3-公章(党章) 4-公章(财务章) 5-公章(工会章) 6-个人章',
  `seal_picture_name` VARCHAR(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '印章图片名称',
  `seal_picture` LONGBLOB COMMENT '印章图片',
  `cert_primarykey_id` VARCHAR(50) NOT NULL COMMENT '业务证书配置id',
  `seal_certid` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '制章证书标识',
  `seal_width` BIGINT(20) DEFAULT NULL COMMENT '印章宽度',
  `seal_heigh` BIGINT(20) DEFAULT NULL COMMENT '印章高度',
  `seal_start_time` VARCHAR(20) NOT NULL COMMENT '印章有效期始',
  `seal_end_time` VARCHAR(20) NOT NULL COMMENT '印章有效期末',
  `create_time` VARCHAR(20) NOT NULL COMMENT '记录插入时间',
  `modify_time` VARCHAR(20) NOT NULL COMMENT '修改时间',
  `status` CHAR(2) DEFAULT '01' COMMENT '状态, 01-正常, 02-停用，03-销毁',
  `operator` VARCHAR(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '操作人',
  PRIMARY KEY (`id`),
  KEY `seal_name` (`seal_name`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
-- 创建印模表
DROP TABLE IF EXISTS `tb_seal_impression`;
CREATE TABLE IF NOT EXISTS `tb_seal_impression` (
  `id` VARCHAR(50) COLLATE utf8_bin NOT NULL COMMENT '印模id',
  `imName` VARCHAR(200) COLLATE utf8_bin DEFAULT NULL,
  `imType` CHAR(2) COLLATE utf8_bin DEFAULT NULL COMMENT '0-公章 1-公章(法人章) 2-公章(合同章) 3-公章(党章) 4-公章(财务章) 5-公章(工会章) 6-个人章',
  `imApprover` VARCHAR(200) COLLATE utf8_bin DEFAULT NULL,
  `imApplicatn` VARCHAR(200) COLLATE utf8_bin DEFAULT NULL,
  `imCreateTime` VARCHAR(20) COLLATE utf8_bin DEFAULT NULL COMMENT '申请时间',
  `imState` CHAR(2) COLLATE utf8_bin DEFAULT NULL COMMENT '//印模状态 0 审核中 1 通过 2 拒绝 3 已制章',
  `imMakePersion` VARCHAR(200) COLLATE utf8_bin DEFAULT NULL,
  `imApprovalTime` VARCHAR(20) COLLATE utf8_bin DEFAULT NULL COMMENT '审批时间',
  `imApprovalOpinion` LONGTEXT COLLATE utf8_bin COMMENT '审批意见',
  `imFileName` VARCHAR(200) COLLATE utf8_bin DEFAULT NULL,
  `imFile` LONGBLOB COMMENT '图片路径',
  `imWidth` INT(4) DEFAULT NULL COMMENT '图片宽度',
  `imHeight` INT(4) DEFAULT NULL COMMENT '图片高度',
  `imReason` LONGTEXT COLLATE utf8_bin COMMENT '申请原因',
  PRIMARY KEY (`id`),
  KEY `imState` (`imState`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- 创建模板表
DROP TABLE IF EXISTS `tb_seal_template`;
CREATE TABLE IF NOT EXISTS `tb_seal_template` (
  `id` VARCHAR(50) NOT NULL COMMENT '主键id',
  `name` VARCHAR(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '模板名称',
  `type` CHAR(2) DEFAULT '01' COMMENT '模板类型,01-普通章模板, 02-骑缝章模板',
  `page_number` VARCHAR(200) DEFAULT NULL COMMENT '签章页码',
  `position` CHAR(2) DEFAULT '06' COMMENT '签章位置,01-上骑缝, 02-下骑缝，03-左骑缝，04-右骑缝，05-左下角，06-右下角',
  `create_time` VARCHAR(20) NOT NULL COMMENT '创建时间',
  `modify_time` VARCHAR(20) NOT NULL COMMENT '修改时间',
  `operator` VARCHAR(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '操作人',
  PRIMARY KEY (`id`),
  KEY `seal_name` (`name`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
-- 创建中间表
DROP TABLE IF EXISTS `tb_seal_bind_template`;
CREATE TABLE IF NOT EXISTS `tb_seal_bind_template` (
  `sealid` VARCHAR(255) DEFAULT NULL COMMENT '印章id',
  `tempId` VARCHAR(255) DEFAULT NULL COMMENT '模板id',
  `id` INT(4) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `createTime` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;

-- 修改字段长度
ALTER TABLE tb_seal_impression MODIFY COLUMN imName VARCHAR(200);
ALTER TABLE tb_seal_impression MODIFY COLUMN imApprover VARCHAR(200);
ALTER TABLE tb_seal_impression MODIFY COLUMN imApplicatn VARCHAR(200);
ALTER TABLE tb_seal_impression MODIFY COLUMN imMakePersion VARCHAR(200);
ALTER TABLE tb_seal_impression MODIFY COLUMN imFileName VARCHAR(200);