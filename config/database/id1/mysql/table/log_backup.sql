DROP TABLE IF EXISTS `tb_asymmetric_decrypt_log_backup`;
CREATE TABLE `tb_asymmetric_decrypt_log_backup` (
  `backup_id` int not null AUTO_INCREMENT,
  `id` bigint(20) default null,
  `error_id` bigint(20) DEFAULT NULL,
  `create_time` bigint(20) NOT NULL COMMENT '存储使用年月日小时分秒毫秒共17位数字',
  `client_ip` varchar(36) DEFAULT NULL COMMENT 'Client API调用者的IP地址',
  `symmetric_algorithm` varchar(128) DEFAULT NULL COMMENT '对称加密算法',
  `asymmetric_algorithm` varchar(256) DEFAULT NULL COMMENT '非对称加密算法',
  `asymmetric_cert_subject` varchar(8000) DEFAULT NULL COMMENT '解密信封业务证书主题',
  `status` varchar(24) NOT NULL COMMENT '解密信封业务状态。成功为success；失败为错误码',
  `accessed_time` bigint(20) NOT NULL COMMENT '接受业务请求的时间.',
  `finished_time` bigint(20) NOT NULL COMMENT '完成业务处理，处理结束的时间',
  `session_id` varchar(128) DEFAULT NULL COMMENT 'session id,用于关联一组请求，目前暂不实现.\r\n            会话标识。例如：当使用长连接时，Sessionid对应于一个长连接，统计时可以观察长连接的所做的业务',
  `decryption_certificate` longblob COMMENT '解密证书',
  `asymmetric_data` longblob COMMENT '信封结果',
  `error_desc` varchar(512) DEFAULT NULL COMMENT '错误描述',
  `time_consuming` int(20) DEFAULT NULL,
  PRIMARY KEY (`backup_id`)
);


DROP TABLE IF EXISTS `tb_asymmetric_encrypt_log_backup`;
CREATE TABLE `tb_asymmetric_encrypt_log_backup` (
  `backup_id` int not null AUTO_INCREMENT,
  `id` bigint(20) default null,
  `error_id` bigint(20) DEFAULT NULL,
  `create_time` bigint(20) NOT NULL COMMENT '存储使用年月日小时分秒毫秒共17位数字',
  `client_ip` varchar(36) DEFAULT NULL COMMENT 'Client API调用者的IP地址',
  `symmetric_algorithm` varchar(128) DEFAULT NULL COMMENT '对称加密算法',
  `asymmetric_algorithm` varchar(256) DEFAULT NULL COMMENT '非对称加密算法',
  `asymmetric_cert_subject` varchar(8000) DEFAULT NULL COMMENT '信封业务证书主题',
  `status` varchar(24) NOT NULL COMMENT '制作信封业务状态。成功为success；失败为错误码',
  `accessed_time` bigint(20) NOT NULL COMMENT '接受业务请求的时间.',
  `finished_time` bigint(20) NOT NULL COMMENT '完成业务处理，处理结束的时间',
  `session_id` varchar(128) DEFAULT NULL COMMENT 'Session id,用于关联一组请求，目前暂不实现.\r\n            会话标识。例如：当使用长连接时，Sessionid对应于一个长连接，统计时可以观察长连接的所做的业务',
  `encryption_certificate` longblob COMMENT '加密证书',
  `asymmetric_data` longblob COMMENT '信封结果',
  `error_desc` varchar(512) DEFAULT NULL COMMENT '错误描述',
  `time_consuming` int(20) DEFAULT NULL,
  PRIMARY KEY (`backup_id`)
);


DROP TABLE IF EXISTS `tb_envelop_decrypt_log_backup`;
CREATE TABLE `tb_envelop_decrypt_log_backup` (
  `backup_id` int not null AUTO_INCREMENT,
  `id` bigint(20) default null,
  `error_id` bigint(20) DEFAULT NULL COMMENT '错误序号和错误表中的序列号对应',
  `create_time` bigint(20) NOT NULL COMMENT '存储使用年月日小时分秒毫秒共17位数字',
  `client_ip` varchar(36) DEFAULT NULL COMMENT 'client api调用者的ip地址',
  `symmetric_algorithm` varchar(128) DEFAULT NULL COMMENT '对称加密算法',
  `asymmetric_algorithm` varchar(256) DEFAULT NULL COMMENT '非对称加密算法',
  `envelopdec_cert_subject` varchar(8000) DEFAULT NULL COMMENT '解密信封业务证书主题',
  `status` varchar(24) NOT NULL COMMENT '解密信封业务状态。成功为success；失败为错误码',
  `accessed_time` bigint(20) NOT NULL COMMENT '接受业务请求的时间.',
  `finished_time` bigint(20) NOT NULL COMMENT '完成业务处理，处理结束的时间',
  `session_id` varchar(128) DEFAULT NULL COMMENT 'session id,用于关联一组请求，目前暂不实现.\r\n            会话标识。例如：当使用长连接时，sessionid对应于一个长连接，统计时可以观察长连接的所做的业务',
  `decryption_certificate` longblob COMMENT '解密证书',
  `envelop_data` longblob COMMENT '信封结果',
  `error_desc` varchar(512) DEFAULT NULL COMMENT '错误描述',
  `time_consuming` int(20) DEFAULT NULL COMMENT '做业务耗时',
  PRIMARY KEY (`backup_id`)
);


DROP TABLE IF EXISTS `tb_envelop_encrypt_log_backup`;
CREATE TABLE `tb_envelop_encrypt_log_backup` (
  `backup_id` int not null AUTO_INCREMENT,
  `id` bigint(20) default null,
  `error_id` bigint(20) DEFAULT NULL COMMENT '错误序号和错误表中的序列号对应',
  `create_time` bigint(20) NOT NULL COMMENT '存储使用年月日小时分秒毫秒共17位数字',
  `client_ip` varchar(36) DEFAULT NULL COMMENT 'client api调用者的ip地址',
  `symmetric_algorithm` varchar(128) DEFAULT NULL COMMENT '对称加密算法',
  `asymmetric_algorithm` varchar(256) DEFAULT NULL COMMENT '非对称加密算法',
  `envelopenc_cert_subject` varchar(8000) DEFAULT NULL COMMENT '信封业务证书主题',
  `status` varchar(24) NOT NULL COMMENT '制作信封业务状态。成功为success；失败为错误码',
  `accessed_time` bigint(20) NOT NULL COMMENT '接受业务请求的时间.',
  `finished_time` bigint(20) NOT NULL COMMENT '完成业务处理，处理结束的时间',
  `session_id` varchar(128) DEFAULT NULL COMMENT 'session id,用于关联一组请求，目前暂不实现.\r\n            会话标识。例如：当使用长连接时，sessionid对应于一个长连接，统计时可以观察长连接的所做的业务',
  `encryption_certificate` longblob COMMENT '加密证书',
  `envelop_data` longblob COMMENT '信封结果',
  `error_desc` varchar(512) DEFAULT NULL COMMENT '错误描述',
  `time_consuming` int(20) DEFAULT NULL COMMENT '做业务耗时',
  PRIMARY KEY (`backup_id`)
);


DROP TABLE IF EXISTS `tb_symmetric_decrypt_log_backup`;
CREATE TABLE `tb_symmetric_decrypt_log_backup` (
  `backup_id` int not null AUTO_INCREMENT,
  `id` bigint(20) default null,
  `error_id` bigint(20) DEFAULT NULL COMMENT '错误序号和错误表中的序列号对应',
  `create_time` bigint(20) NOT NULL COMMENT '存储使用年月日小时分秒毫秒共17位数字',
  `client_ip` varchar(36) DEFAULT NULL COMMENT 'client api调用者的ip地址',
  `symmetric_algorithm` varchar(128) DEFAULT NULL COMMENT '对称加密算法',
  `key_length` int(11) DEFAULT NULL COMMENT '密钥长度（字节）',
  `key_no` varchar(512) DEFAULT NULL COMMENT '密钥编号',
  `encrypt_mode` varchar(128) DEFAULT NULL COMMENT '加密方式',
  `symmetric_key` varchar(128) DEFAULT NULL COMMENT '密钥',
  `key_mode` varchar(128) DEFAULT NULL COMMENT '获取密钥方式（内置、外传）',
  `status` varchar(24) NOT NULL COMMENT '解对称密钥业务状态。成功为success；失败为错误码',
  `accessed_time` bigint(20) NOT NULL COMMENT '接受业务请求的时间.',
  `finished_time` bigint(20) NOT NULL COMMENT '完成业务处理，处理结束的时间',
  `session_id` varchar(128) DEFAULT NULL COMMENT 'session id,用于关联一组请求，目前暂不实现.\r\n            会话标识。例如：当使用长连接时，sessionid对应于一个长连接，统计时可以观察长连接的所做的业务',
  `symmetric_encrypt_data` longblob COMMENT '对称加密结果',
  `error_desc` varchar(512) DEFAULT NULL COMMENT '错误描述',
  `time_consuming` int(20) DEFAULT NULL COMMENT '做业务耗时',
  PRIMARY KEY (`backup_id`)
);


DROP TABLE IF EXISTS `tb_symmetric_encrypt_log_backup`;
CREATE TABLE `tb_symmetric_encrypt_log_backup` (
  `backup_id` int not null AUTO_INCREMENT,
  `id` bigint(20) default null,
  `error_id` bigint(20) DEFAULT NULL COMMENT '错误序号和错误表中的序列号对应',
  `create_time` bigint(20) NOT NULL COMMENT '存储使用年月日小时分秒毫秒共17位数字',
  `client_ip` varchar(36) DEFAULT NULL COMMENT 'client api调用者的ip地址',
  `symmetric_algorithm` varchar(128) DEFAULT NULL COMMENT '对称加密算法',
  `key_length` int(11) DEFAULT NULL COMMENT '密钥长度（字节）',
  `key_no` varchar(512) DEFAULT NULL COMMENT '密钥编号',
  `encrypt_mode` varchar(128) DEFAULT NULL COMMENT '加密方式',
  `symmetric_key` varchar(128) DEFAULT NULL COMMENT '密钥',
  `key_mode` varchar(128) DEFAULT NULL COMMENT '获取密钥方式（内置、外传）',
  `status` varchar(24) NOT NULL COMMENT '生成对称密钥业务状态。成功为success；失败为错误码',
  `accessed_time` bigint(20) NOT NULL COMMENT '接受业务请求的时间.',
  `finished_time` bigint(20) NOT NULL COMMENT '完成业务处理，处理结束的时间',
  `session_id` varchar(128) DEFAULT NULL COMMENT 'session id,用于关联一组请求，目前暂不实现.\r\n            会话标识。例如：当使用长连接时，sessionid对应于一个长连接，统计时可以观察长连接的所做的业务',
  `symmetric_encrypt_data` longblob COMMENT '对称加密结果',
  `error_desc` varchar(512) DEFAULT NULL COMMENT '错误描述',
  `time_consuming` int(20) DEFAULT NULL COMMENT '做业务耗时',
  PRIMARY KEY (`backup_id`)
);


DROP TABLE IF EXISTS `tb_querycert_log_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_querycert_log_backup` (
  `backup_id` int not null AUTO_INCREMENT,
  `ID` bigint(20) default null,
  `CERT_ID` varchar(255) DEFAULT NULL COMMENT '证书标识',
  `CERT_SUBJECT` varchar(512) DEFAULT NULL COMMENT '证书主题',
  `CERT_ISSUED_SUBJECT` varchar(512) DEFAULT NULL COMMENT '颁发者主题',
  `CERT_SN` varchar(50) DEFAULT NULL COMMENT '证书序列号',
  `CERT_STATE` varchar(50) DEFAULT NULL COMMENT '证书用途',
  `STATUS` varchar(24) DEFAULT NULL COMMENT '状态',
  `ERROR_ID` bigint(20) DEFAULT NULL COMMENT '错误ID',
  `ERROR_DESC` varchar(512) DEFAULT NULL COMMENT '错误描述',
  `ACCESSED_TIME` bigint(20) NOT NULL COMMENT '接受业务请求的时间.',
  `FINISHED_TIME` bigint(20) NOT NULL COMMENT '完成业务处理，处理结束的时间',
  `TIME_CONSUMING` int(20) DEFAULT NULL COMMENT '耗时时间',
  `CLIENT_IP` varchar(36) DEFAULT NULL COMMENT 'Client API调用者的IP地址',
  `CREATE_TIME` bigint(20) NOT NULL COMMENT '存储使用年月日小时分秒毫秒共17位数字',
  PRIMARY KEY (`backup_id`)
);


DROP TABLE IF EXISTS `tb_sign_business_log_backup`;
CREATE TABLE `tb_sign_business_log_backup` (
  `backup_id` int not null AUTO_INCREMENT,
  `id` bigint(20) default null,
  `error_id` bigint(20) DEFAULT NULL COMMENT '错误序号和错误表中的序列号对应',
  `create_time` bigint(20) NOT NULL COMMENT '存储使用年月日小时分秒毫秒 共17位数字',
  `client_ip` varchar(36) DEFAULT NULL COMMENT 'client api调用者的ip地址',
  `digest_algorithm` varchar(32) DEFAULT NULL COMMENT '摘要算法标识',
  `digest_data` varchar(256) DEFAULT NULL COMMENT '签名原文摘要值',
  `sign_algorithm` varchar(128) DEFAULT NULL COMMENT '签名算法标识',
  `sign_cert_subject` varchar(8000) DEFAULT NULL COMMENT '签名证书主题',
  `status` varchar(24) NOT NULL COMMENT '签名状态。成功为success；失败为错误码',
  `accessed_time` bigint(20) NOT NULL COMMENT '接受业务请求的时间.',
  `finished_time` bigint(20) NOT NULL COMMENT '完成业务处理，处理结束的时间',
  `session_id` varchar(128) DEFAULT NULL COMMENT 'session id,用于关联一组请求，目前暂不实现.\r\n            会话标识。例如：当使用长连接时，sessionid对应于一个长连接，统计时可以观察长连接的所做的业务',
  `sign_certificate` longblob COMMENT '签名证书',
  `signed_data` longblob COMMENT '签名结果',
  `signed_data_type` varchar(64) DEFAULT NULL COMMENT '签名结果数据类型，如：p7',
  `plain_data` longblob COMMENT '原文',
  `plain_type` varchar(64) DEFAULT NULL COMMENT '原文类型。0 为普通原文；1 为摘要原文',
  `error_desc` varchar(512) DEFAULT NULL COMMENT '错误描述',
  `time_consuming` int(20) DEFAULT NULL COMMENT '做业务耗时',
  PRIMARY KEY (`backup_id`)
);


DROP TABLE IF EXISTS `tb_verify_business_log_backup`;
CREATE TABLE `tb_verify_business_log_backup` (
  `backup_id` int not null AUTO_INCREMENT,
  `id` bigint(20) default null,
  `error_id` bigint(20) DEFAULT NULL COMMENT '错误日志',
  `create_time` bigint(20) DEFAULT NULL COMMENT '存储使用年月日小时分秒毫秒 共17位数字',
  `client_ip` varchar(36) NOT NULL COMMENT 'client api调用者的ip地址',
  `digest_algorithm` varchar(32) DEFAULT NULL COMMENT '摘要算法',
  `digest_data` varchar(256) DEFAULT NULL COMMENT '原文摘要结果',
  `sign_algorithm` varchar(128) DEFAULT NULL COMMENT '签名算法',
  `sign_cert_subject` varchar(8000) DEFAULT NULL COMMENT '签名证书主题',
  `status` varchar(24) NOT NULL COMMENT '验签状态',
  `accessed_time` bigint(20) NOT NULL COMMENT '接受业务请求的时间.',
  `finished_time` bigint(20) NOT NULL COMMENT '完成业务处理，处理结束的时间',
  `session_id` varchar(128) NOT NULL COMMENT 'session id,用于关联一组请求，目前暂不实现.\r\n            会话标识。例如：当使用长连接时，sessionid对应于一个长连接，统计时可以观察长连接的所做的业务',
  `sign_certificate` longblob COMMENT '签名证书',
  `signed_data` longblob COMMENT '签名结果',
  `signed_data_type` varchar(64) DEFAULT NULL COMMENT '签名结果数据类型，如：p7',
  `plain_data` longblob COMMENT '原文',
  `plain_type` varchar(64) DEFAULT NULL COMMENT '原文类型。0 为普通原文；1 为摘要原文',
  `error_desc` varchar(512) DEFAULT NULL COMMENT '错误描述',
  `time_consuming` int(20) DEFAULT NULL COMMENT '做业务耗时',
  PRIMARY KEY (`backup_id`)
);


DROP TABLE IF EXISTS `tb_tsa_apply_service_log_backup`;
CREATE TABLE `tb_tsa_apply_service_log_backup` (
  `backup_id` int not null AUTO_INCREMENT,
  `id` bigint(20) default null,
  `tsa_id` bigint(20) DEFAULT NULL COMMENT '时间戳数据id',
  `apply_state` varchar(32) NOT NULL,
  `client_ip` varchar(36) DEFAULT NULL,
  `sign_algorithm` varchar(128) DEFAULT NULL COMMENT '签名算法',
  `sign_cert_subject` varchar(256) DEFAULT NULL,
  `sign_certificate` longblob COMMENT '证书',
  `create_time` bigint(20) NOT NULL COMMENT '申请时间戳业务时间',
  `error_id` bigint(20) DEFAULT NULL COMMENT '错误序号和错误表中的序列号对应',
  `tsa_type` varchar(10) DEFAULT NULL COMMENT '时间戳标准类型',
  `issuser` varchar(256) DEFAULT NULL,
  `sn` varchar(16) DEFAULT NULL,
  `source_data` longblob COMMENT '原文',
  `tsa_data` longblob COMMENT '时间戳数据',
  `accessed_time` bigint(20) NOT NULL COMMENT '接受业务请求的时间.',
  `finished_time` bigint(20) NOT NULL COMMENT '完成业务处理，处理结束的时间',
  `error_desc` varchar(512) DEFAULT NULL COMMENT '错误描述',
  `time_consuming` int(20) DEFAULT NULL COMMENT '做业务耗时',
  PRIMARY KEY (`backup_id`)
);

DROP TABLE IF EXISTS `tb_tsa_verify_service_log_backup`;
CREATE TABLE `tb_tsa_verify_service_log_backup` (
  `backup_id` int not null AUTO_INCREMENT,
  `id` bigint(20) default null,
  `tsa_id` bigint(20) DEFAULT NULL COMMENT '时间戳数据id',
  `apply_state` varchar(32) NOT NULL,
  `client_ip` varchar(15) DEFAULT NULL,
  `sign_algorithm` varchar(128) DEFAULT NULL COMMENT '签名算法',
  `sign_cert_subject` varchar(256) DEFAULT NULL,
  `sign_certificate` longblob COMMENT '证书',
  `create_time` bigint(20) DEFAULT NULL COMMENT '申请时间戳业务时间',
  `error_id` bigint(20) DEFAULT NULL,
  `tsa_type` varchar(10) DEFAULT NULL COMMENT '时间戳标准类型',
  `issuser` varchar(256) DEFAULT NULL,
  `sn` varchar(16) DEFAULT NULL,
  `source_data` longblob COMMENT '原文',
  `tsa_data` longblob COMMENT '时间戳数据',
  `accessed_time` bigint(20) NOT NULL COMMENT '接受业务请求的时间.',
  `finished_time` bigint(20) NOT NULL COMMENT '完成业务处理，处理结束的时间',
  `error_desc` varchar(512) DEFAULT NULL COMMENT '错误描述',
  `time_consuming` int(20) DEFAULT NULL COMMENT '做业务耗时',
  PRIMARY KEY (`backup_id`)
);