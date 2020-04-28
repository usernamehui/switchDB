package cn;

import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import cn.Database;

public class PublicMethod
{
  private static Connection conn = null;
  private static Statement stmt = null;
  private static ResultSet rs = null;

  public static Connection getConnection(Database config)
    throws Exception
  {
	  try {
          Class.forName(config.getDriverClassName());
          conn = (Connection) DriverManager.getConnection(config.getU0(), config.getUsername(), config.getPd());
      } catch (Exception e) {
          throw new Exception( "F0600008" );
      }
    return conn;
  }

  public static ResultSet queryResult(Database config, String sqlStr)
    throws Exception
  {
    try
    {
      conn = getConnection(config);
      stmt = conn.createStatement();
      rs = stmt.executeQuery(sqlStr);
    } catch (Exception e) {
      throw e;
    }
    return rs;
  }

  public static List<String> getAllTableName(Database config, String sqlStr)
    throws Exception
  {
    List<String> list = null;
    try {
      list = new ArrayList<String>();
      rs = queryResult(config, sqlStr);
      while (rs.next())
        list.add(rs.getString(1));
    }
    catch (Exception e) {
      throw e;
    } finally {
      closeAll(conn, stmt, rs);
    }
    return list;
  }

  public static List<String> getAllColumns(Database config, String sqlStr)
    throws Exception
  {
    List<String> list = null;
    try {
      list = new ArrayList<String>();
      rs = queryResult(config, sqlStr);
      while (rs.next())
        list.add(rs.getString(2));
    }
    catch (Exception e) {
      throw e;
    } finally {
      closeAll(conn, stmt, rs);
    }
    return list;
  }

  public static List<TableColumn> getDescribe(Database dbConfig, String sqlStr)
    throws Exception
  {
    List<TableColumn> list = null;
    try {
      list = new ArrayList<TableColumn>();
      rs = queryResult(dbConfig, sqlStr);
      while (rs.next()) {
        TableColumn dbColumns = new TableColumn();
        dbColumns.setColumnsFiled(rs.getString(1));
        dbColumns.setColumnsType(rs.getString(2));
        dbColumns.setColumnsNull(rs.getString(3));
        dbColumns.setColumnsKey(rs.getString(4));
        dbColumns.setColumnsDefault(rs.getString(5));
        dbColumns.setColumnsExtra(rs.getString(6));
        list.add(dbColumns);
      }
    } catch (Exception e) {
      throw e;
    } finally {
      closeAll(conn, stmt, rs);
    }
    return list;
  }

  @SuppressWarnings("resource")
public static List<String> loadSqlScript(String filePath)
    throws Exception
  {
    List<String> sqlList = null;
    InputStreamReader inReader = null;
    StringBuffer sqlStr = null;
    try {
      sqlList = new ArrayList<String>();
      sqlStr = new StringBuffer();
      inReader = new InputStreamReader(new FileInputStream(filePath), "utf8");
      char[] buff = new char[1024];
      int byteRead = 0;
      while ((byteRead = inReader.read(buff)) != -1) {
        sqlStr.append(new String(buff, 0, byteRead));
      }

      String[] sqlStrArr = sqlStr.toString().split("(;\\s*\\r\\n)|(;\\s*\\n)");
      for (String str : sqlStrArr) {
        String sql = str.replaceAll("--.*", "").trim();
        if (!sql.equals(""))
          sqlList.add(sql);
      }
    }
    catch (Exception ex) {
      throw ex;
    }
    return sqlList;
  }

  public String trim(String obj)
    throws Exception
  {
    Matcher matcher = null;
    Pattern pattern = null;
    try {
      pattern = Pattern.compile("\\s*\n");
      matcher = pattern.matcher(obj.toString());
    } catch (Exception e) {
      throw e;
    }
    return matcher.replaceAll("");
  }
  
  public static void closeAll(Connection conn, Statement stmt, ResultSet rs)
	    throws Exception
	  {
	    try
	    {
	      if (conn != null) {
	        conn.close();
	      }
	      if (stmt != null) {
	        stmt.close();
	      }
	      if (rs != null)
	        rs.close();
	    }
	    catch (Exception e) {
	      throw e;
	    }
	  }
}