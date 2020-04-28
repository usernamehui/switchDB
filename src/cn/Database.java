package cn;

import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.StringUtils;


public class Database {
    private String dbId;
    private String dbScriptPath;
    private String desc;
    private String audit = "false";
    private String isDefault = "true";
    private String isEncrypt = "false";
    private String isInner = "true";
    private String type;
    private String i0;
    private String pt;
    private String dbName;
    private String username;
    private String pd;
    private String u0;
    private String driverClassName;
    private String manuUrl;
    //临时属性用于记录密码是否修改
    private String pwdFlag = "false";

    private String dialect;
    //数据库类型
    private List<String> typeList = new ArrayList<String> ();
    
    //数据库描述
    private String descStr;

    public String getIsEncrypt() {
        return isEncrypt;
    }

    public void setIsEncrypt(String isEncrypt) {
        this.isEncrypt = isEncrypt;
    }

    public String getDbId() {
        return dbId;
    }

    public void setDbId(String dbId) {
        this.dbId = dbId;
    }

    public String getDbScriptPath() {
        return dbScriptPath;
    }

    public void setDbScriptPath(String dbScriptPath) {
        this.dbScriptPath = dbScriptPath;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getAudit() {
        return audit;
    }

    public void setAudit(String audit) {
        this.audit = audit;
    }

    public String getIsDefault() {
        return isDefault;
    }

    public void setIsDefault(String isDefault) {
        this.isDefault = isDefault;
    }

    public String getIsInner() {
        return isInner;
    }

    public void setIsInner(String isInner) {
        this.isInner = isInner;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getI0() {
        if( !StringUtils.isNullOrEmpty( i0 ) ){
            return i0;
        }
        
    	if( StringUtils.isNullOrEmpty( u0 ) ){
            return i0;
        }
        
        if ("hsql".equalsIgnoreCase(type)
        		|| "sqlserver".equalsIgnoreCase(type)
        		|| "db2".equalsIgnoreCase(type)
        		|| "mysql".equalsIgnoreCase(type)
        		) {
            return u0.substring( u0.indexOf( "//" ) + 2  ,  u0.lastIndexOf(":") );

        } else if ("oracle".equalsIgnoreCase(type)) {
        	return u0.substring( u0.indexOf( ":@" ) + 2  ,  u0.lastIndexOf(":") );
        }
        	
        return i0;
    }

    public void setI0(String i0) {
        this.i0 = i0.trim();
    }

    
    public String getPt() {
        if( !StringUtils.isNullOrEmpty( pt ) ){
            return pt;
        }
        if( StringUtils.isNullOrEmpty( u0 ) ){
            return pt;
        }
        
        if ("hsql".equalsIgnoreCase(type)
        		|| "db2".equalsIgnoreCase(type)
        		|| "mysql".equalsIgnoreCase(type)
        		) {
        	return u0.substring( u0.lastIndexOf(":")+1,u0.lastIndexOf( "/" ) );
        } else if ("sqlserver".equalsIgnoreCase(type)) {
            return u0.substring( u0.lastIndexOf(":")+1,u0.indexOf( ";" ) ); 
        } else if ("oracle".equalsIgnoreCase(type)) {
            String str = u0.substring(u0.indexOf( ":@" ) + 2);
            return str.substring( str.indexOf(":")+1,str.lastIndexOf( ":" ) ); 
        } 
        	
        return pt;
    }

    public void setPt(String pt) {
        this.pt = pt.trim();
    }

    public String getDbName() {
        if( !StringUtils.isNullOrEmpty( dbName ) ){
            return dbName;
        }
        if( StringUtils.isNullOrEmpty( u0 ) ){
            return dbName;
        }
        
        if ("hsql".equalsIgnoreCase(type)
        		|| "db2".equalsIgnoreCase(type)
        		|| "mysql".equalsIgnoreCase(type)
        		) {
        	return u0.substring( u0.lastIndexOf( "/" )  +  1 );   
        } else if ("sqlserver".equalsIgnoreCase(type)) {
        	String str = u0.substring(u0.indexOf("databaseName=") + 13);
        	if (str.indexOf("=") != -1) {
        		return str.substring( 0,str.indexOf(";")  );  
        	} else {
        		return str;
        	} 
        } else if ("oracle".equalsIgnoreCase(type)) {
            return u0.substring( u0.lastIndexOf( ":" )  +  1 );
        } 

        return dbName;
    }

    public void setDbName(String dbName) {
        this.dbName = dbName.trim();
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username.trim();
    }

    
    public String getPd() {
        return pd;
    }

    public void setPd(String pd) {
        this.pd = pd;
    }

    
    public String getU0() {
        if ("true".equalsIgnoreCase(manuUrl) && u0 != null && !"".equals(u0)) {
            return u0;
        }
        if ("hsql".equalsIgnoreCase(type)) {
            u0 = "jdbc:hsqldb:hsql://" + i0 + ":" + pt + "/" + dbName;
        } else if ("sqlserver".equalsIgnoreCase(type)) {
            u0 = "jdbc:sqlserver://" + i0 + ":" + pt + ";databaseName="
                    + dbName + ";SelectMethod=Cursor";
        } else if ("oracle".equalsIgnoreCase(type)) {
            u0 = "jdbc:oracle:thin:@" + i0 + ":" + pt + ":" + dbName;
        } else if ("db2".equalsIgnoreCase(type)) {
            u0 = "jdbc:db2://" + i0 + ":" + pt + "/" + dbName;
        } else if ("mysql".equalsIgnoreCase(type)) {
            u0 = "jdbc:mysql://" + i0 + ":" + pt + "/" + dbName;
        }
        
        return u0;
    }

    public void setU0(String u0) {
        this.u0 = u0.trim();
    }

    public String getDriverClassName() {
        return driverClassName;
    }

    public void setDriverClassName(String driverClassName) {
        this.driverClassName = driverClassName;
    }

    public String getManuUrl() {
        return manuUrl;
    }

    public void setManuUrl(String manuUrl) {
        this.manuUrl = manuUrl;
    }

    
    public String getPwdFlag() {
        return pwdFlag;
    }

    public void setPwdFlag(String pwdFlag) {
        this.pwdFlag = pwdFlag;
    }

    public String getDialect() {
        return dialect;
    }

    public void setDialect(String dialect) {
        this.dialect = dialect;
    }

	public List<String> getTypeList() {
		return typeList;
	}

	public void setTypeList(List<String> typeList) {
		this.typeList = typeList;
	}

	public String getDescStr() {
		return descStr;
	}

	public void setDescStr(String descStr) {
		this.descStr = descStr;
	}

}
