<%/*
*this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
*/%><%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*,include.get_name_from_ID.*"%>
<%
String search="";
nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));
try{
String chain_id=request.getParameter("chain_id");

String sql="select currency from finance_config_file_kind where chain_id='"+chain_id+"'";
ResultSet rs=finance_db.executeQuery(sql);
if(rs.next()){
 sql="select currency_name,currency_rate from finance_config_currency where currency_id='"+rs.getString("currency").split("/")[0]+"'";
 rs=finance_db.executeQuery(sql);
if(rs.next()){
	search=rs.getString("currency_name")+"⊙"+rs.getString("currency_rate");
}
}
search=!search.equals("")?search:"179206725";
out.print(search);
finance_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>
