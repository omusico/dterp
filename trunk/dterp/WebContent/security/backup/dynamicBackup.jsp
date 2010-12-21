<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*,include.data_backup.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="priceAlarm" class="x-form" method="POST" action="dynamicBackup_change.jsp">
<%
String path=application.getRealPath("/");
String filename=path+"WEB-INF/dynamic_backup.xml";
Solid so=new Solid(filename);
String status=so.getValue((String)session.getAttribute("unit_db_name"));
nseer_db_backup db=new nseer_db_backup(application);
String ip=db.getIp();
if(status!=null&&ip!=null){
	String status1=status;
if(status.equals("1")){
status=demo.getLang("erp","是")+"&nbsp;&nbsp;"+demo.getLang("erp","从数据源地址：")+ip;
}else if(status.equals("2")){
status=demo.getLang("erp","切换状态");
}else{
status=demo.getLang("erp","否");
}
if(status1.equals("2")){
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","是否启用实时备份：")%><%=status%></td>
</tr>
 </table>
<%}else{%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3"></td>
	<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value= "<%=demo.getLang("erp","设置")%>"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","是否启用实时备份：")%><%=status%></td>
	<td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 </tr>
 </table>
<%}}else{
status=demo.getLang("erp","尚未设置");
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3"></td>
	<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value= "<%=demo.getLang("erp","设置")%>"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","是否启用实时备份：")%><%=status%></td>
	<td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 </tr>
 </table>
<%}
%>
</form>
 </div>