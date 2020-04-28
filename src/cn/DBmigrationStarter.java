package cn;

public class DBmigrationStarter {

	public static void main(String[] args) {
		String dbScriptPath = "config/database/id1/mysql/";
		String dbDriverClass = "com.mysql.jdbc.Driver";
		String backSqlFlolder = dbScriptPath;
		String backSqlFile = backSqlFlolder + "back/vgateway_back.sql";
		
		Database infoNew = new Database();
    	infoNew.setDbName("vgateway");
    	infoNew.setDriverClassName(dbDriverClass);
    	infoNew.setDbScriptPath(dbScriptPath);
    	infoNew.setI0("172.16.7.233");
    	infoNew.setUsername("root");
    	infoNew.setPd("");
    	infoNew.setU0("jdbc:mysql://127.0.0.1:3306");
    	
    	Database infoOld = new Database();
    	infoOld.setDbName("gateway");
    	infoOld.setDriverClassName(dbDriverClass);
    	infoOld.setDbScriptPath(dbScriptPath);
    	infoOld.setI0("172.16.7.233");
    	infoOld.setUsername("root");
    	infoOld.setPd("");
    	infoOld.setU0("jdbc:mysql://127.0.0.1:3306/gateway");
		
		 try {
	        	//1.在新数据库创建数据库、表结构、函数等等
			 	//boolean init = new DBmigration().init(infoNew, 1);

	            //2.备份当前数据库的数据
			 	boolean createSqlScript = new MySqlBackup(infoOld).createSqlScript(backSqlFile);
			 	
	            //3.导入备份数据到新数据库
//			 	infoNew.setDbScriptPath(backSqlFlolder);
//			 	infoNew.setU0(infoNew.getU0() + "/" + infoNew.getDbName());
//			 	boolean imports = new DBmigration().init(infoNew, 3);
//	            System.out.println("执行完成");
//	            if(init && createSqlScript && imports) {
//	            	System.out.println("执行成功");
//	            }
			 	//4.测试新数据库数据是否正常
			 	
	            //5.修改各项目数据库配置文件为新数据库地址
	            
	            //6.重启服务
	            
	        } catch(Exception e){
	           System.out.println(e);
	        }
	}
}
