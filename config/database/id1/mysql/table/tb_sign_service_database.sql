-- MySQL dump 10.13  Distrib 5.1.71, for redhat-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: vgateway
-- ------------------------------------------------------
-- Server version	5.1.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `tb_sign_app`;
DROP TABLE IF EXISTS `tb_sign_app_grant`;
DROP TABLE IF EXISTS `tb_sign_business_cert_grant`;
DROP TABLE IF EXISTS `tb_sign_business_cert`;
DROP TABLE IF EXISTS `tb_sign_business_history`;
DROP TABLE IF EXISTS `tb_sign_business_institution`;
DROP TABLE IF EXISTS `tb_tsa_data`;
DROP TABLE IF EXISTS `tb_config_convert`;
DROP TABLE IF EXISTS `tb_organization_dictionary`;
DROP TABLE IF EXISTS `tb_sign_encrypt`;
DROP TABLE IF EXISTS `tb_event_msg`;
DROP TABLE IF EXISTS `tb_event_subscriber`;
DROP TABLE IF EXISTS `sys_menu`;
DROP TABLE IF EXISTS `tb_traffic_statistics`;
DROP TABLE IF EXISTS `tb_error_log`;
DROP TABLE IF EXISTS `tb_business_staticstic`;
DROP TABLE IF EXISTS `tb_sign_role_resource`;
DROP TABLE IF EXISTS `tb_sign_gms_strategy`;


--
-- Table structure for table `tb_sign_app`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sign_app` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设置主键自增',
  `APPID` varchar(250) NOT NULL COMMENT '应用标识',
  `NAME` varchar(250) NOT NULL COMMENT '应用名称',
  `CREATE_USER` varchar(250) DEFAULT NULL COMMENT '创建人员',
  `CREATE_TIME` bigint(20) NOT NULL COMMENT '创建时间',
  `UPDATE_USER` varchar(250) DEFAULT NULL COMMENT '修改人员',
  `UPDATE_TIME` bigint(20) DEFAULT NULL COMMENT '修改时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `TB_SIGN_APP` (`APPID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tb_sign_app_grant`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sign_app_grant` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设置主键自增',
  `APPID` bigint(20) NOT NULL COMMENT '应用ID',
  `CERTID` varchar(50) NOT NULL COMMENT '证书ID',
  `CREATE_USER` varchar(250) DEFAULT NULL COMMENT '创建人员',
  `CREATE_TIME` bigint(20) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `TB_SIGN_APP_GRANT` (`APPID`,`CERTID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tb_sign_business_cert`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sign_business_cert` (
  `id` varchar(50) NOT NULL COMMENT '业务证书配置id',
  `certid` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '证书标识',
  `alias` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '证书别名，为兼容之前版本增加的字段',
  `sn` varchar(50) DEFAULT NULL COMMENT '证书序列号',
  `subject` varchar(512) DEFAULT NULL COMMENT '证书主题',
  `issued_subject` varchar(512) DEFAULT NULL COMMENT '颁发者主题',
  `private_key` longtext COMMENT '私钥',
  `public_key` longtext NOT NULL COMMENT '公钥',
  `cert` longtext COMMENT '证书实体',
  `encrypt_alg` varchar(30) DEFAULT NULL COMMENT '加密算法',
  `key_type` varchar(30) DEFAULT NULL,
  `digest_alg` varchar(30) DEFAULT NULL COMMENT '摘要算法',
  `not_after` bigint(20) DEFAULT NULL COMMENT '证书过期时间',
  `not_before` bigint(20) DEFAULT NULL COMMENT '证书生效时间',
  `create_time` bigint(20) NOT NULL COMMENT '记录插入时间',
  `last_modify_time` bigint(20) COMMENT '最后一次修改时间',
  `cert_source` char(2) DEFAULT '0' COMMENT '证书来源, 0代表手动上传, 1代表自动下载',
  `contains_private_key` char(2) NOT NULL DEFAULT '0' COMMENT '是否包含私钥, 0代表不包含, 1代表包含',
  `contains_public_cert` char(2) NOT NULL DEFAULT '0' COMMENT '是否包含公钥证书, 0代表不包含, 1代表包含',
  `sign_state` char(2) NOT NULL DEFAULT '0' COMMENT '是否具备签名功能, 0代表不是, 1代表是',
  `verify_state` char(2) NOT NULL DEFAULT '0' COMMENT '是否具备验签名功能, 0代表不是, 1代表是',
  `encrypt_state` char(2) NOT NULL DEFAULT '0' COMMENT '是否具备加密功能, 0代表不是, 1代表是',
  `decrypt_state` char(2) NOT NULL DEFAULT '0' COMMENT '是否具备解密功能, 0代表不是, 1代表是',
  `default_cert` char(2) NOT NULL DEFAULT '0' COMMENT '是否默认证书, 0代表不是, 1代表是',
  `cert_state` char(2) DEFAULT NULL COMMENT '证书状态, 0代表审核中, 1代表使用中,2代表已作废',
  `do_timestamp_state` char(2) NOT NULL DEFAULT '0' COMMENT '是否具备打时间戳功能, 0代表不是, 1代表是',
  `verify_timestamp_state` char(2) NOT NULL DEFAULT '0' COMMENT '是否具备验时间戳功能, 0代表不是, 1代表是',
  PRIMARY KEY (`id`),
  KEY `certid` (`certid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tb_sign_business_cert_grant`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sign_business_cert_grant` (
  `id` varchar(50) NOT NULL,
  `cert_id` varchar(50) NOT NULL,
  `sn` varchar(50) DEFAULT NULL,
  `subject` varchar(512) DEFAULT NULL,
  `issued_subject` varchar(512) DEFAULT NULL,
  `public_key` longtext,
  `cert` longtext,
  `not_after` varchar(50) DEFAULT NULL,
  `not_before` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cert_id` (`cert_id`) USING BTREE,
  CONSTRAINT `tb_sign_business_cert_grant_ibfk_1` FOREIGN KEY (`cert_id`) REFERENCES `tb_sign_business_cert` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tb_sign_business_history`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sign_business_history` (
  `id` varchar(50) NOT NULL COMMENT '业务证书配置id',
  `certid` varchar(255) DEFAULT NULL,
  `alias` varchar(512) DEFAULT NULL,
  `sn` varchar(50) DEFAULT NULL COMMENT '证书序列号',
  `subject` varchar(512) DEFAULT NULL COMMENT '证书主题',
  `issued_subject` varchar(512) DEFAULT '' COMMENT '颁发者主题',
  `private_key` longtext COMMENT '私钥',
  `public_key` longtext NOT NULL COMMENT '公钥',
  `cert` longtext COMMENT '证书实体',
  `encrypt_alg` varchar(30) DEFAULT NULL COMMENT '加密算法',
  `key_type` varchar(30) DEFAULT NULL,
  `digest_alg` varchar(30) DEFAULT NULL COMMENT '摘要算法',
  `not_after` bigint(20) DEFAULT NULL COMMENT '证书过期时间',
  `not_before` bigint(20) DEFAULT NULL COMMENT '证书生效时间',
  `create_time` bigint(20) NOT NULL COMMENT '记录插入时间',
  `last_modify_time` bigint(20) NOT NULL COMMENT '最后一次修改时间',
  `cert_source` char(2) DEFAULT NULL COMMENT '证书来源, 0代表手动上传, 1代表自动下载',
  `contains_private_key` char(2) NOT NULL DEFAULT '0' COMMENT '是否包含私钥, 0代表不包含, 1代表包含',
  `contains_public_cert` char(2) NOT NULL DEFAULT '0' COMMENT '是否包含公钥证书, 0代表不包含, 1代表包含',
  `sign_state` char(2) NOT NULL DEFAULT '0' COMMENT '是否具备签名功能, 0代表不是, 1代表是',
  `verify_state` char(2) NOT NULL DEFAULT '0' COMMENT '是否具备验签名功能, 0代表不是, 1代表是',
  `encrypt_state` char(2) NOT NULL DEFAULT '0' COMMENT '是否具备加密功能, 0代表不是, 1代表是',
  `decrypt_state` char(2) NOT NULL DEFAULT '0' COMMENT '是否具备解密功能, 0代表不是, 1代表是',
  `default_cert` char(2) NOT NULL DEFAULT '0' COMMENT '是否默认证书, 0代表不是, 1代表是',
  `do_timestamp_state` char(2) NOT NULL DEFAULT '0' COMMENT '是否具备打时间戳功能, 0代表不是, 1代表是',
  `verify_timestamp_state` char(2) NOT NULL DEFAULT '0' COMMENT '是否具备验时间戳功能, 0代表不是, 1代表是',
  `cert_state` char(2) DEFAULT NULL COMMENT '证书状态, 0代表审核中, 1代表使用中,2代表已作废',
  `institution_name` varchar(512) DEFAULT NULL COMMENT '机构名称',
  `key_id` varchar(50) DEFAULT NULL COMMENT '业务证书id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tb_sign_business_institution`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sign_business_institution` (
  `id` varchar(64) NOT NULL DEFAULT '',
  `certid` varchar(64) DEFAULT '',
  `institution_name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tb_tsa_data`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_tsa_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tsa_id` bigint(20) NOT NULL COMMENT '时间戳数据流水id',
  `source_data` longblob NOT NULL COMMENT '对原文做的摘要值',
  `digest_algorithm` varchar(10) NOT NULL COMMENT '摘要算法',
  `hash_data` varchar(256) DEFAULT NULL COMMENT '摘要值',
  `sign_algorithm` varchar(128) NOT NULL COMMENT '签名算法',
  `sign_cert_subject` varchar(256) NOT NULL,
  `sign_certificate` longblob NOT NULL COMMENT '证书',
  `tsa_type` varchar(10) NOT NULL COMMENT '时间戳标准类型',
  `tsa_data` longblob NOT NULL COMMENT '时间戳数据',
  `create_time` bigint(20) NOT NULL COMMENT '做时间戳业务的时间',
  `accessed_time` bigint(20) NOT NULL COMMENT '接受业务请求的时间.',
  `finished_time` bigint(20) NOT NULL COMMENT '完成业务处理，处理结束的时间',
  PRIMARY KEY (`id`),
  KEY `tsa_id_index` (`tsa_id`),
  KEY `index_tsa_data` (`create_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tb_config_convert`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_config_convert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `configtype` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `configid` varchar(4000) COLLATE utf8_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tb_organization_dictionary`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_organization_dictionary` (
  `organizationname` varchar(150) DEFAULT NULL,
  `organizationcode` varchar(36) DEFAULT NULL,
  `parentnode` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tb_sign_encrypt`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sign_encrypt` (
  `id` varchar(50) NOT NULL COMMENT '密钥配置id',
  `name` varchar(64) NOT NULL COMMENT '密钥名称',
  `algorithm` varchar(64) NOT NULL COMMENT '密钥算法',
  `length` int(20) NOT NULL COMMENT '密钥长度',
  `count` int(20) NOT NULL COMMENT '密钥数量',
  `remark` varchar(512) NOT NULL COMMENT '密钥备注',
  `keytype` longblob NOT NULL COMMENT '密钥',
  `keyuse` varchar(10) NOT NULL COMMENT '密钥用途',
  `createtime` bigint(20) DEFAULT NULL COMMENT '密钥创建时间',
  `number` longblob COMMENT '密钥编号',
  `fillstyle` varchar(10) DEFAULT NULL COMMENT '密钥加密方式',
  `importtype` varchar(10) DEFAULT NULL COMMENT '版本密钥状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tb_event_msg`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_event_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eventkey` varchar(50) NOT NULL,
  `subscriberid` varchar(128) NOT NULL,
  `data` longtext,
  `time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2676 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tb_event_subscriber`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_event_subscriber` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eventkey` varchar(50) NOT NULL,
  `subscriberid` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `sys_menu`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu` (
  `ID` bigint(20) NOT NULL COMMENT '设置主键自增',
  `MENUID` int(11) NOT NULL COMMENT '菜单或者按钮id',
  `PARENTID` int(11) NOT NULL COMMENT '父节点ID',
  `NAME` varchar(250) NOT NULL COMMENT '菜单名称',
  `URL` varchar(250) NOT NULL COMMENT '路径',
  `PERMS` varchar(250) DEFAULT NULL COMMENT '授权',
  `DOMID` int(11) DEFAULT NULL,
  `TYPE` varchar(250) NOT NULL COMMENT '1一级菜单；2二级菜单；3按钮',
  `ICON` varchar(250) NOT NULL COMMENT '图标',
  `ORDERNUM` varchar(250) DEFAULT NULL COMMENT '排序',
  `OPEN` varchar(250) DEFAULT NULL,
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tb_traffic_statistics`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_traffic_statistics` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设置主键自增',
  `URL` varchar(220) NOT NULL COMMENT '路径',
  `COUNT` bigint(20) DEFAULT '0' COMMENT '计数',
  `FLAG` int(11) DEFAULT '0' COMMENT '0为统计；1为不统计',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `TB_TRAFFIC_STATISTICS` (`URL`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

CREATE TABLE `tb_error_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` bigint(20) DEFAULT NULL COMMENT '存储使用年月日小时分秒毫秒 共17位数字',
  `error_id` bigint(20) DEFAULT NULL COMMENT '错误ID',
  `error_code` varchar(50) DEFAULT NULL,
  `error_content` longblob,
  `server_sign` varchar(2000) DEFAULT NULL,
  `result` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `create_time_index` (`create_time`),
  KEY `errror_id_index` (`error_id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

CREATE TABLE `tb_business_staticstic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `businesstype` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `success` int(11) DEFAULT NULL,
  `failed` int(11) DEFAULT NULL,
  `serialnum` int(11) DEFAULT NULL,
  `deviceid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `totalsuccess` int(11) DEFAULT NULL,
  `totalfailed` int(11) DEFAULT NULL,
  `createdate` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `successTimeUsetotalCount` bigint DEFAULT 0 comment '耗时成功总数',
  `failureTimeUsetotalCount` bigint DEFAULT 0 comment '耗时失败总数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24558087 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `tb_sign_role_resource` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设置主键自增',
  `ROLE_NAME` varchar(250) NOT NULL COMMENT '角色名称',
  `MENU_ID` varchar(250) NOT NULL COMMENT '菜单ID',
  `REMARK` varchar(250)  COMMENT '备注',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

CREATE TABLE `tb_sign_gms_strategy` (
  `strategy_id` varchar(50) NOT NULL,
  `strategy_name` varchar(50) DEFAULT NULL,
  `issuetime` bigint(20) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `iplist` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`strategy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
