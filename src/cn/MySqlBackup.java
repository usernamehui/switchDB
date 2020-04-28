package cn;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.alibaba.fastjson.JSONObject;
import com.mysql.jdbc.StringUtils;

public class MySqlBackup {
	public Database dbConfig;
	public MySqlBackup() {

	}

	public MySqlBackup(Database dbConfig) {
		this.dbConfig = dbConfig;
	}

	public boolean createSqlScript(String filePath) throws Exception {
		try {
			File file = new File(filePath);
			File newFile = new File(file.getPath());
			PrintWriter pwrite = new PrintWriter(new OutputStreamWriter(new FileOutputStream(newFile, false), "UTF8"));

			pwrite.println(AppendMessage.headerMessage(this.dbConfig));
			pwrite.println("SET FOREIGN_KEY_CHECKS=0;\n");
			List<String> tablelists = PublicMethod.getAllTableName(this.dbConfig, "show tables");
			for (String table : tablelists) {
//				if("tb_monitor_history_log".equals(table) || "tb_monitor_history_log_week".equals(table) || "tb_monitor_history_log_month".equals(table)) {
//					continue;
//				}
				if("base64_data".equals(table)) {
					continue;
				}
				if("tb_config_convert".equals(table)) {
					
				}else {
					continue;
				}
				List<Vector<Object>> insertList = getAllDatas(this.dbConfig, table.toString());
				for (int i = 0; i < insertList.size(); i++) {
					Vector<Object> vector = (Vector<Object>) insertList.get(i);
					String tempStr = vector.toString();
					tempStr = tempStr.substring(1, tempStr.length() - 1);
					tempStr = "INSERT INTO `" + table + "`" + " VALUES(" + tempStr + ");";
					pwrite.println(tempStr);
				}
			}
			pwrite.flush();
			pwrite.close();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	public List<Vector<Object>> getAllDatas(Database config, String tableName) throws Exception {
		StringBuilder typeStr = null;
		ResultSet rs = null;
		StringBuilder columnsStr;
		StringBuilder sqlStr;
		List<TableColumn> columnList;
		List<Vector<Object>> list;
		try {
			typeStr = new StringBuilder();
			sqlStr = new StringBuilder();
			columnsStr = new StringBuilder().append("describe ").append(tableName);
			columnList = PublicMethod.getDescribe(config, columnsStr.toString());
			sqlStr.append("SELECT ");
			for (TableColumn bColumn : columnList) {
				String columnsType = bColumn.getColumnsType();
				if (("longblob".equals(columnsType)) || ("blob".equals(columnsType)) || ("tinyblob".equals(columnsType))
						|| ("mediumblob".equals(columnsType)))
					typeStr.append("hex(`" + bColumn.getColumnsFiled() + "`" + ") as " + "`" + bColumn.getColumnsFiled()
							+ "`" + " ,");
				else {
					typeStr.append("`" + bColumn.getColumnsFiled() + "`" + " ,");
				}
			}
			sqlStr.append(typeStr.substring(0, typeStr.length() - 1));
			sqlStr.append(" FROM ").append("`" + tableName + "`;");

			list = new ArrayList<Vector<Object>>();
			rs = PublicMethod.queryResult(config, sqlStr.toString());
			while (rs.next()) {
				Vector<Object> vector = new Vector<Object>();
				for (TableColumn dbColumn : columnList) {
					String columnsType = dbColumn.getColumnsType();
					String columnsFile = dbColumn.getColumnsFiled();
					if (rs.getString(columnsFile) == null) {
						vector.add(rs.getString(columnsFile));
					} else if ("bit".equals(columnsType.substring(0, 3))) {
						vector.add(Integer.valueOf(Integer.valueOf(rs.getString(columnsFile)).intValue()));
					} else if (("bit".equals(columnsType.substring(0, 3)))
							&& (Integer.valueOf(rs.getString(columnsFile)).intValue() == 0)) {
						vector.add("''");
					} else if (("longblob".equals(columnsType)) || ("blob".equals(columnsType))
							|| ("tinyblob".equals(columnsType)) || ("mediumblob".equals(columnsType))) {
						if(!StringUtils.isNullOrEmpty(rs.getString(columnsFile))) 
							vector.add("0x" + rs.getString(columnsFile));
						else
							vector.add("''");
					} else if (("text".equals(columnsType)) || ("longtext".equals(columnsType))
							|| ("tinytext".equals(columnsType)) || ("mediumtext".equals(columnsType))) {
						String tempStr = rs.getString(columnsFile);
						
						if("value".equals(columnsFile) && tempStr.contains("\"ds_tp\":\"mysql\"")) {
							JSONObject dbconfig = JSONObject.parseObject(tempStr);
							dbconfig.put("db_name", dbConfig.getDbName());
							dbconfig.put("db_driver", dbConfig.getDriverClassName());
							dbconfig.put("db_ip", dbConfig.getI0());
							dbconfig.put("db_uname", dbConfig.getUsername());
							dbconfig.put("db_url", dbConfig.getU0());
							dbconfig.put("db_pt", dbConfig.getPt());
							dbconfig.put("db_authmi", dbConfig.getPd());
							tempStr = dbconfig.toString();
						}
						
						tempStr = tempStr.replace("'", "\\'");
						tempStr = tempStr.replace("\"", "\\\"");
						vector.add("'" + tempStr + "'");
					} else {
						vector.add("'" + rs.getString(columnsFile) + "'");
					}
				}
				list.add(vector);
			}
		} catch (Exception e) {
			throw e;
		} finally {
			
		}
		return list;
	}
}