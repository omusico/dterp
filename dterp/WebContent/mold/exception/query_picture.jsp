<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*" import="com.common.*"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%nseer_db mold_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
try{
ServletContext context = session.getServletContext();
String path = request.getContextPath();
String sql = "select * from mold_info where id='"+request.getParameter("id")+"'";
ResultSet rs = mold_db.executeQuery(sql); 
String mold_spec="" ;
String mold_code="" ;
String stock_time="" ;
if(rs.next())
{
	mold_spec=rs.getString("mold_spec") ;
	mold_code=rs.getString("mold_code") ;
	String stock_timea=rs.getString("stock_time") ; //时间能为空
	stock_time=stock_timea.substring(0, 10);   
}
String sql1 = "select * from mold_exception_pic where mold_id='"+request.getParameter("id")+"'";
ResultSet rs1 = mold_db.executeQuery(sql1); 

while(rs1.next())
{
	//String project=System.getProperty("user.dir");
	//project=project.substring(0,1);
	//path=project+":"+path;
    String url=UpLoadUrl.getHttpUrl(request);

%>

<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align=center class="TD_STYLE3"><img src="<%=url%>/upload_file/mold_exception_picture/exception_pictures_<%=mold_code%>_<%=stock_time%>/<%=rs1.getString("pic_path")%>"></td>
 </tr>
</table>
<%}
mold_db.close();
}catch(Exception ex){ex.printStackTrace();}%>