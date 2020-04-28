package cn;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;

public class DBmigration  {

    private String OPERATION_TABLES = "table";
    private String OPERATION_INDEXS = "index";
    private String OPERATION_VIEWS = "view";
    private String OPERATION_PROCEDURES = "procedure";
    private String OPERATION_BACK = "back";
    private String OPERATION_TRIGGERS = "trigger";

    private String TABLESKP = "CVS";
    private String CHARSET = "UTF-8";

    private String dbScriptPath;
    private String driverClassName;
    private String url;
    private String username;
    private String password;
    Connection conn = null;
    Statement stmt = null;

    /**
     * @param step 1.在新数据库创建数据库、表结构、函数等等  3.导入备份数据到新数据库
     * @author: ZhangPengHui
     * @date  : 2019年8月15日 下午3:21:25
     */
    public boolean init(Database info,int step) throws Exception {

        return initdb(info,step);

    }
    public boolean initdb(Database info,int step) throws Exception {

        dbScriptPath = info.getDbScriptPath();
        driverClassName = info.getDriverClassName();
        url = info.getU0();
        username = info.getUsername();
        password = info.getPd();

        try {
        	if(step == 1) {
        		createDatabase(info.getDbName());
        		url = url + "/" + info.getDbName();
        		createDataSource();
        		createTable();
        		createProcedure();
        		createView();
        		createTrigger();
        		createIndex();
        	}
        	if(step == 3) {
        		createDataSource();
	            importData();
        	}
            
        } catch(Exception e){
        	System.out.println(e+"创建数据库表结构或导入数据失败");
        	return false;
        }finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    throw new Exception( "F0600013" );
                }
            }
        }

        return true;
    }
    public void createDataSource() throws Exception {

        try {
            Class.forName(driverClassName);
            conn = (Connection) DriverManager.getConnection(url, username, password);
        } catch (Exception e) {
            throw new Exception( "F0600008" );
        }

    }

    public void createDatabase(String databaseName) throws Exception {
    	 try {
             Class.forName(driverClassName);
             conn = (Connection) DriverManager.getConnection(url, username, password);
         } catch (Exception e) {
             throw new Exception( "F0600008" );
         }
    	stmt = conn.createStatement();
		try {
			stmt.executeUpdate("DROP DATABASE " + databaseName);
		}catch(SQLException sql) {
		}
		try {
			stmt.executeUpdate("CREATE DATABASE " + databaseName);
		}catch(Exception e) {
		}finally {
			 if (stmt != null) {
                 try {
                     stmt.close();
                 } catch (Exception e) {
                     throw new Exception( "F0600008" );
                 }
             }
			 if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    throw new Exception( "F0600013" );
                }
            }
		}
    }
    
    public void createTable() throws Exception {
        File[] files = getFiles(OPERATION_TABLES);
        for (int i = 0; i < files.length; i++) {
            new SQLGenerator(files[i], conn.createStatement()).generator();
        }
    }

    protected File[] getFiles(String type) throws Exception {
        String fileName = dbScriptPath + type;
        File file = new File(fileName);
        if( null == file || !file.exists() || !file.isDirectory() )
            return new File[]{};
        File[] result = file.listFiles(new FileFilter() {

                public boolean accept(File pathname) {

                    boolean returnboolean = pathname.isFile()
                            && (pathname.getName().indexOf(TABLESKP) < 0);

                    return returnboolean;
                }
        });
        Arrays.sort(result);
        return result;
    }

    protected int createProcedure() throws Exception {

        int failure = 0;
        try {
            File[] files = getFiles(OPERATION_PROCEDURES);
            BufferedReader reader = null;
            for (int i = 0; i < files.length; i++) {
                File file = files[i];
                try {
                    reader = new BufferedReader(new InputStreamReader(
                            new FileInputStream(file),
                            CHARSET));
                    StringBuilder sb = new StringBuilder();
                    String buffer = null;
                    while ((buffer = reader.readLine()) != null) {
                        sb.append(buffer + "\n");
                    }
                    String content = sb.toString();
                    if (!isBlank(content)) {
                        Statement stmt =conn.createStatement();
                        stmt.addBatch(sb.toString());
                        int[] r = stmt.executeBatch();
                    }
                } catch (Exception ex) {
                    throw new Exception("F060000E");
                } finally {
                    if (reader != null) {
                        try{
                            reader.close();
                        }catch (Exception e){
                            throw new Exception( "F0600008" );
                        }
                    }
                }
            }
        } catch (IOException e) {
            throw new Exception("F060000D");
        }

        return failure;
    }

    protected void importData() throws Exception{
        try {
            File[] files = getFiles(OPERATION_BACK);
            for (int i = 0; i < files.length; i++) {
                new SQLGenerator(files[i], conn.createStatement()).generator();
            }
        } catch (IOException e) {
            throw new Exception("F0600005");
        }
    }

    protected void createView() throws Exception {
        try {
            File[] files = getFiles(OPERATION_VIEWS);
            for (int i = 0; i < files.length; i++) {
                new SQLGenerator(files[i], conn.createStatement()).generator();
            }
        } catch (IOException e) {
            throw new Exception("F060000B");
        }

    }

    protected int createTrigger() throws Exception {

        int failure = 0;
        try {
            File[] files = getFiles(OPERATION_TRIGGERS);
            BufferedReader reader = null;
            for (int i = 0; i < files.length; i++) {
                File file = files[i];
                try {
                    reader = new BufferedReader(new InputStreamReader(
                            new FileInputStream(file),CHARSET));
                    StringBuilder sb = new StringBuilder();
                    String buffer = null;
                    while ((buffer = reader.readLine()) != null) {
                        sb.append(buffer
                                + "\n");
                    }
                    String content = sb.toString();
                    if (!isBlank(content)) {
                        Statement stmt = conn.createStatement();
                        stmt.addBatch(content);
                        stmt.executeBatch();
                    }
                } catch (Exception ex) {
                    throw new Exception("F060000F");
                } finally {
                    if(reader!=null){
                        try{
                            reader.close();
                        }catch (Exception e){
                            throw new Exception( "F0600008" );
                        }
                    }
                }
            }
        } catch (IOException e) {
            throw new Exception("F060000F");
        }

        return failure;
    }

    protected int createIndex()throws Exception {

        int failure = 0;
        try {
            File[] files = getFiles(OPERATION_INDEXS);
            for (int i = 0; i < files.length; i++) {
                new SQLGenerator(files[i], conn.createStatement()).generator();
            }
        } catch (IOException e) {
            throw new Exception("F060000C");
        }

        return failure;
    }

    private class SQLGenerator {
        private File sqlFile;
        private Statement stmt;
        private String CHARSET = "UTF-8";
        private String SQLSKIP1 = "--";
        private String SQLSKIP2 = "#";
        private String SQLSKIP3 = "/*";

        public SQLGenerator(File sqlFile, Statement stmt) {
            this.sqlFile = sqlFile;
            this.stmt = stmt;
        }

        public void generator() throws Exception {
            StringBuilder sb = new StringBuilder();
            String line = null;
            BufferedReader reader = null;
            try {
                reader = new BufferedReader(new InputStreamReader(
                        new FileInputStream(sqlFile), CHARSET));
                while ((line = reader.readLine()) != null) {
                    String tmp = line.trim();
                    if (!tmp.startsWith(SQLSKIP1) && !tmp.startsWith(SQLSKIP2) && !tmp.startsWith(SQLSKIP3) && !"".equals(tmp)) {  //$NON-NLS-2$
                        if (tmp.endsWith(";")) {
                            sb.append(tmp);
                            try {
                                stmt.addBatch(sb.substring(0, sb.length() - 1));
                            } catch (Exception daex) {
                                throw new Exception( "F0600006" );
                            }
                            sb.delete(0, sb.length());
                        } else {
                            sb.append(line + "\n");
                        }
                    }
                }
                try {
                	int[] r = stmt.executeBatch();
                }catch(Exception e) {
                	System.out.println(e);
                }
            } catch (Exception e) {
                throw new Exception("F0600005");
            } finally {
                if (stmt != null) {
                    try {
                        stmt.close();
                    } catch (Exception e) {
                        throw new Exception( "F0600008" );
                    }
                }
                if (reader != null) {
                    try {
                        reader.close();
                    } catch (Exception e) {
                        throw new Exception( "F0600008" );
                    }
                }
            }
        }
    }

    public static boolean isBlank(String str) {
        int strLen;
        if (str != null && (strLen = str.length()) != 0) {
            for (int i = 0; i < strLen; ++i) {
                if (!Character.isWhitespace(str.charAt(i))) {
                    return false;
                }
            }

            return true;
        } else {
            return true;
        }
    }
}
