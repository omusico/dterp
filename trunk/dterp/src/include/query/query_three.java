/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.query;

import java.sql.*;
import include.nseer_db.nseer_db;

public class query_three {
	//查询条件信息
  private String dbase="";
  private String tableName="";
  private String timea="";
  private String timeb="";
  private String idNumber="";
  private String keyword="";
  private String fieldName="";
  private String fieldName1="";
  private String fieldName2="";
  private String[] fieldName3=new String[1000];

  private String realname="";
  private String condition="";
  private String queue="";
  private String tagq="";

  private String sql="";
  private String sql1="";
  private String sql2="";
  private String sql3="";
  private String sql4="";
  private String sql5="";
  private String sql6="";
  private String sql7="";
  private nseer_db dba;
  private nseer_db dbb;
  private ResultSet rs=null;
  private ResultSet rs1=null;
  private ResultSet rs2=null;
  private ResultSet rs3=null;
  private ResultSet rs4=null;
  private ResultSet rs5=null;
  private ResultSet rs6=null;
  private ResultSet rs7=null;
  private double tradeTotal=0.0d;
  private int intValue=0;
  private double doubleValue=0.0d;

	public ResultSet queryDB(String dbase,String tName,String uTimea,String uTimeb,String uIdNumber,String uKeyword,String fName1,String fName2,String[] fName3,String uCondition,String uQueue) {
		this.dbase=dbase;
		this.tableName=tName;
		this.timea=uTimea;
		this.timeb=uTimeb;
		this.idNumber=uIdNumber;
		this.keyword=uKeyword;

		this.fieldName1=fName1;
		this.fieldName2=fName2;
		this.fieldName3=fName3;

		this.condition=uCondition;
		this.queue=uQueue;
		//nseerdb dbb=new nseerdb("security");
		//nseerdb db=new nseerdb(dbase);
		dba=new nseer_db(dbase);
		try{
		/*sql7="select * from user where realname='"+realname+"'";
		rs7=dbb.executeQuery(sql7);
		if(rs7.next()){
		tagq=rs7.getString("tagq");
		area1=rs7.getString("first_kind_name");
		area2=rs7.getString("second_kind_name");
		area3=rs7.getString("third_kind_name");
	}
				try {
						if(!dbb.closeConn());
						} catch (Exception ex) {}
		if(tagq.equals("1")) sales=realname;
		if(tagq.equals("2")) {
			marketarea=area1;
			trade=area2;
			fieldValue5=area3;
		}
		sql7="select * from "+tableName+"";
		ResultSet rs7=db.executeQuery(sql7);
		ResultSetMetaData rsmd = rs7.getMetaData();
		int number = rsmd.getColumnCount();*/
		if(!timea.equals("")&&timea.length()<=10) timea=timea.substring(0,10)+" 00:00:00";
		if(!timeb.equals("")&&timeb.length()<=10) timeb=timeb.substring(0,10)+" 23:59:59";
		if(timea.equals("")&&timeb.equals("")&&idNumber.equals("")&&keyword.equals("")){
			sql="select * from "+tableName+" where "+condition+" "+queue+"";
		}
		else if(!idNumber.equals("")&&keyword.equals("")&&timea.equals("")&&timeb.equals("")){
			sql="select * from "+tableName+" where "+fieldName2+"='"+idNumber+"' and "+condition+" "+queue+"";
		}else if(idNumber.equals("")&&keyword.equals("")&&!timea.equals("")&&timeb.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+condition+" "+queue+"";
		}else if(idNumber.equals("")&&keyword.equals("")&&timea.equals("")&&!timeb.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+condition+" "+queue+"";
		}else if(idNumber.equals("")&&!keyword.equals("")&&timea.equals("")&&timeb.equals("")){
			String key="";
			int m=0;
			for(int i=0;i<fieldName3.length-1;i++){
				key=key+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
				m++;
			}
			key=key+fieldName3[m]+" like "+"'%"+keyword+"%'";
					sql="select * from "+tableName+" where ("+key+") and "+condition+" "+queue+"";
		}else if(idNumber.equals("")&&keyword.equals("")&&!timea.equals("")&&!timeb.equals("")){
					sql="select * from "+tableName+" where ("+fieldName1+"<='"+timeb+"' and "+fieldName1+">='"+timea+"') and "+condition+" "+queue+"";
		}else if(!idNumber.equals("")&&keyword.equals("")&&!timea.equals("")&&timeb.equals("")){
					sql="select * from "+tableName+" where ("+fieldName2+"='"+idNumber+"' and "+fieldName1+">='"+timea+"') and "+condition+" "+queue+"";
		}else if(!idNumber.equals("")&&keyword.equals("")&&timea.equals("")&&!timeb.equals("")){
					sql="select * from "+tableName+" where ("+fieldName2+"='"+idNumber+"' and "+fieldName1+"<='"+timeb+"') and "+condition+" "+queue+"";
		}else if(!idNumber.equals("")&&!keyword.equals("")&&timea.equals("")&&timeb.equals("")){
			String key="";
						int m=0;
						for(int i=0;i<fieldName3.length-1;i++){
							key=key+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
							m++;
						}
			key=key+fieldName3[m]+" like "+"'%"+keyword+"%'";
					sql="select * from "+tableName+" where "+fieldName2+"='"+idNumber+"' and ("+key+") and "+condition+" "+queue+"";
		}else if(idNumber.equals("")&&!keyword.equals("")&&!timea.equals("")&&timeb.equals("")){
			String key="";
									int m=0;
									for(int i=0;i<fieldName3.length-1;i++){
										key=key+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
										m++;
									}
			key=key+fieldName3[m]+" like "+"'%"+keyword+"%'";
					sql="select * from "+tableName+" where ("+key+") and "+fieldName1+">='"+timea+"' and "+condition+" "+queue+"";
		}else if(idNumber.equals("")&&!keyword.equals("")&&timea.equals("")&&!timeb.equals("")){
			String key="";
									int m=0;
									for(int i=0;i<fieldName3.length-1;i++){
										key=key+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
										m++;
									}
			key=key+fieldName3[m]+" like "+"'%"+keyword+"%'";
					sql="select * from "+tableName+" where ("+key+") and "+fieldName1+"<='"+timeb+"' and "+condition+" "+queue+"";
		}else if(!idNumber.equals("")&&!keyword.equals("")&&!timea.equals("")&&timeb.equals("")){
			String key="";
									int m=0;
									for(int i=0;i<fieldName3.length-1;i++){
										key=key+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
										m++;
									}
			key=key+fieldName3[m]+" like "+"'%"+keyword+"%'";
					sql="select * from "+tableName+" where ("+key+") and "+fieldName1+">='"+timea+"' and "+fieldName2+"='"+idNumber+"' and "+condition+" "+queue+"";
		}else if(!idNumber.equals("")&&!keyword.equals("")&&timea.equals("")&&!timeb.equals("")){
			String key="";
									int m=0;
									for(int i=0;i<fieldName3.length-1;i++){
										key=key+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
										m++;
									}
			key=key+fieldName3[m]+" like "+"'%"+keyword+"%'";
					sql="select * from "+tableName+" where ("+key+") and "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+idNumber+"' and "+condition+" "+queue+"";
		}else if(idNumber.equals("")&&!keyword.equals("")&&!timea.equals("")&&!timeb.equals("")){
			String key="";
									int m=0;
									for(int i=0;i<fieldName3.length-1;i++){
										key=key+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
										m++;
									}
			key=key+fieldName3[m]+" like "+"'%"+keyword+"%'";
					sql="select * from "+tableName+" where ("+key+") and "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+condition+" "+queue+"";
		}else if(!idNumber.equals("")&&keyword.equals("")&&!timea.equals("")&&!timeb.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName1+">='"+timea+"' and "+fieldName2+"='"+idNumber+"' and "+condition+" "+queue+"";
		}else if(!idNumber.equals("")&&!keyword.equals("")&&!timea.equals("")&&!timeb.equals("")){
			String key="";
									int m=0;
									for(int i=0;i<fieldName3.length-1;i++){
										key=key+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
										m++;
									}
			key=key+fieldName3[m]+" like "+"'%"+keyword+"%'";
					sql="select * from "+tableName+" where ("+key+") and "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+idNumber+"' and "+condition+" "+queue+"";
		}
		
			rs=dba.executeQuery(sql);

		}catch (Exception ex) {
			ex.printStackTrace();
		}

		return rs;
		}

	public int intValue() {
		try{
					intValue=0;
					dbb=new nseer_db(dbase);
					sql1 = sql;
					rs1=dbb.executeQuery(sql1);
					if(rs1.last()){
					intValue=rs1.getRow();
					}
						dbb.close();
		}
				catch (Exception ex){
					ex.printStackTrace();
				}
		return intValue;
	}


	public double sumTotal(String fName) {
					this.fieldName=fName;
				try{
					dbb=new nseer_db(dbase);
					sql2 = sql;
					rs2=dbb.executeQuery(sql2);
					tradeTotal=0;
					while(rs2.next()){
					tradeTotal += rs2.getDouble(fieldName);
					}
					dbb.close();
	}
				catch (Exception ex){
					ex.printStackTrace();
				}
		return tradeTotal;
	}
	public double sumTotal(String dbase,String sqla,String fName) {
		int tradeTotal_a=0;
	try{
		dbb=new nseer_db(dbase);
		String sql2 = sqla.split("limit")[0];
		ResultSet rs2=dbb.executeQuery(sql2);
		while(rs2.next()){
			tradeTotal_a += rs2.getDouble(fName);
		}
		dbb.close();
	}
	catch (Exception ex){
		ex.printStackTrace();
	}
return tradeTotal_a;
}

	public void close() {
	dba.close();
	}

}