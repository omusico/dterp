<%/*
*this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
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
String keyword=request.getParameter("keyword");

String sql="select corr_stock_tag,cash_tag,bank_tag,currency_tag,chain_id,chain_name from finance_config_file_kind where (nick_name like '"+keyword+"%' or file_id like '"+keyword+"%') and parent_category_id!='-1' and details_tag='0' order by file_id";
ResultSet rs=finance_db.executeQuery(sql);
while(rs.next()){	search+=rs.getString("corr_stock_tag")+"@#$"+rs.getString("cash_tag")+"@#$"+rs.getString("bank_tag")+"@#$"+rs.getString("chain_id")+" "+rs.getString("chain_name")+"@#$"+rs.getString("currency_tag")+"~~~";
}
search=!search.equals("")?search.substring(0,search.length()-3):"0";
out.print(search);
finance_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>
