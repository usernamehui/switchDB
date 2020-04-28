package com;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Test {

	public static void main(String[] args) throws Exception {
		
		try {
			String sqlPath = null;
			String sqlFileName = "vgateway.sql";
			String[] runtimeExec;
			Process exec ;
			int succ = 0;
			if(!File.separator.equals("\\")) {
				sqlPath = "/home/mysqldump/"+sqlFileName;
				runtimeExec = new String[]{"/bin/sh", "-c", "mysqldump -h localhost -u root -R vgateway > "+sqlPath};
				exec = Runtime.getRuntime().exec(runtimeExec);
				InputStream inputStream = exec.getInputStream();
				BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
				String pid = bufferedReader.readLine();
				
				InputStream errinputStream = exec.getErrorStream();
				BufferedReader errbufferedReader = new BufferedReader(new InputStreamReader(errinputStream));
				String errpid = errbufferedReader.readLine();
				
				int waitFor = exec.waitFor();
				File sqlFile = new File(sqlPath);
				//判断是否备份成功
				if(waitFor == 0 && sqlFile != null && sqlFile.length() > 0) {
					System.out.println(sqlFile.length());
					System.out.println("执行成功！");
					succ = 1;
				}
			}else {
				sqlPath = "E:\\"+sqlFileName;
				runtimeExec = new String[]{"cmd /k E:\\Dev\\mysql-5.6.43-winx64\\bin\\mysqldump -h localhost -u root -R vgateway >"+sqlPath};
				exec = Runtime.getRuntime().exec(runtimeExec[0]);
				Thread.sleep(1000);
				File sqlFile = new File(sqlPath);
				//判断是否备份成功
				if(sqlFile.exists() && sqlFile.length() > 0) {
					System.out.println(sqlFile.length());
					System.out.println("执行成功！");
					succ = 1;
				}
			}
			if(succ==1) {
				//创建目标数据库
				Class.forName("com.mysql.jdbc.Driver");
				Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306","root","");
				Statement statement = connection.createStatement();
				//删除数据库
				try {
					int executeUpdate = statement.executeUpdate("drop DATABASE gateway");
				}catch(SQLException sql) {
				}
				//创建新的数据库
				int createDB = statement.executeUpdate("CREATE DATABASE gateway");
				if(createDB == 1) {
					System.out.println("创建数据库成功");
					//读取sql文件
					createGenner(new File(sqlPath), statement);
				}
				
			}
			
		}catch(Exception e) {
			System.out.println(e);
		}
	}

	
	public  static String getRootPath() {
		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		if (classLoader == null) {
			classLoader = ClassLoader.getSystemClassLoader();
		}
		String classPath = System.getProperty("user.dir");
		int index = classPath.indexOf("/target");
		if (index != -1) {
			classPath = classPath.substring(0, index);
		}
		if (classPath.indexOf("/bin") != -1) classPath = classPath.replace("/bin/", "/");
		return classPath;
	}
	
	 protected static int createGenner(File file,Statement stmt) throws Exception {

	        int failure = 0;
	        try {
	            BufferedReader reader = null;
	                try {
	                	Class.forName("com.mysql.jdbc.Driver");
	    				Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/gateway","root","");
	    				stmt = connection.createStatement();
	                	
	                	String line = null;
	                	String CHARSET = "UTF-8";
	                	String SQLSKIP1 = "--";
	                	String SQLSKIP2 = "#";
	                	String SQLSKIP3 = "/*";
	                	String SQLSKIP4 = "DELIMITER";
	                    reader = new BufferedReader(new InputStreamReader(new FileInputStream(file),CHARSET));
	                    StringBuilder sb = new StringBuilder();
	                    StringBuilder producesb = new StringBuilder();
	                    int produce = 0;
	                    while ((line = reader.readLine()) != null) {
	                        String tmp = line.trim();
	                        if (!tmp.startsWith(SQLSKIP1) && !tmp.startsWith(SQLSKIP2)
							&& !tmp.startsWith(SQLSKIP3) /* && !tmp.startsWith(SQLSKIP4) */ && !"".equals(tmp)) {  
		                    	//函数、存储过程
	                        	if(tmp.contains("DELIMITER")) {
		                    		produce++;
		                    	}else if(produce % 2 != 0) {
		                    		producesb.append(tmp + "\n");
		                    	}
		                    	if(produce != 0 && produce % 2 == 0) {
		                    		String string = producesb.toString();
		                    		stmt.addBatch(string);
		                    		producesb.delete(0, producesb.length());
		                    	}
		                    	System.out.println();
	                        	////创建表、插入数据 语句
	                        	if (tmp.endsWith(";") && produce == 0) {
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
	                    int[] r = stmt.executeBatch();
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
	        } catch (IOException e) {
	            throw new Exception("F060000D");
	        }

	        return failure;
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
