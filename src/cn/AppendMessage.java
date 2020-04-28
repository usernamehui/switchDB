package cn;

public class AppendMessage
{
  public static String headerMessage(Database config)
    throws Exception
  {
    StringBuilder strBuilder = null;
    try {
      strBuilder = new StringBuilder();
      strBuilder.append("");
    } catch (Exception e) {
      throw e;
    }
    return strBuilder.toString();
  }

  public static String tableHeaderMessage(String tableName)
    throws Exception
  {
    StringBuilder strBuilder = null;
    try {
      strBuilder = new StringBuilder();
      strBuilder.append("-- ----------------------------\n")
        .append("-- Create Table " + tableName + "\n")
        .append("-- ----------------------------");
    } catch (Exception e) {
      throw e;
    }
    return strBuilder.toString();
  }

  public static String insertHeaderMessage()
    throws Exception
  {
    StringBuilder strBuilder = null;
    try {
      strBuilder = new StringBuilder();
      strBuilder.append("-- ----------------------------\n")
        .append("-- Create Datas  \n")
        .append("-- ----------------------------");
    } catch (Exception e) {
      throw e;
    }
    return strBuilder.toString();
  }
}