<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db intrmanufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%
int i;
int intRowCount;
String sqll = "select * from intrmanufacture_config_public_char where kind='联络理由' order by type_ID" ;
ResultSet rs=intrmanufacture_db.executeQuery(sqll) ;
rs.next();
rs.last();
intRowCount=rs.getRow();
intrmanufacture_db.close();
String[] check=new String[intRowCount];
for(i=1;i<=intRowCount;i++){
String del=request.getParameter(""+i+"");
check[i-1]=del;
session.setAttribute("del",check);
}
response.sendRedirect("reason_delete_reconfirm.jsp");
%>