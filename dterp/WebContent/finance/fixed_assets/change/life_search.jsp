<%/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
*/%><%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*,include.get_name_from_ID.*"%><%
String search="";
String sql="";
ResultSet rs=null;
nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));
try{
String keyword=request.getParameter("keyword");
String tag=request.getParameter("tag");
	if(tag.equals("0")){
	 sql="select file_id from finance_fa_file where file_id like '"+keyword+"%'";
	 rs=finance_db.executeQuery(sql);
while(rs.next()){
	search+=rs.getString("file_id")+"\n";
}
search=!search.equals("")?search:"179206725";
out.print(search);

}else{
	sql="select file_name,start_time,specification,lifecycle from finance_fa_file where file_id='"+keyword+"'";
	rs=finance_db.executeQuery(sql);
if(rs.next()){
    int year =(int)Math.floor(Integer.parseInt(rs.getString("lifecycle"))/12);
    int month =Integer.parseInt(rs.getString("lifecycle"))%12;
	search=rs.getString("file_name")+"⊙"+rs.getString("start_time")+"⊙"+rs.getString("specification")+"⊙"+year+"⊙"+month;
	}
 	search=!search.equals("")?search:"179206725";
 out.print(search);
}
finance_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>