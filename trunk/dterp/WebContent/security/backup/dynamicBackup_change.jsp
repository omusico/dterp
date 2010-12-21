<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*,include.data_backup.*" import ="include.nseer_db.*,java.text.*"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%String file_length=request.getParameter("file_length");%>

<form id="mutiValidation" class="x-form" method="post" action="../../security_backup_dynamicBackup_change_ok">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="dynamicBackup.jsp"></td>
 </tr>
 </table>
<%
String path=application.getRealPath("/");
String filename=path+"WEB-INF/dynamic_backup.xml";
Solid so=new Solid(filename);
String status=so.getValue((String)session.getAttribute("unit_db_name"));
nseer_db_backup db=new nseer_db_backup(application);
String ip=db.getIp();
if(status.equals("1")){
%>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","是否启用实时备份：")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" name="status" value='0'><%=demo.getLang("erp","否")%><input type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" name="status" value='1' checked><%=demo.getLang("erp","是")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","从数据源地址：")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="ds" style="width:30%" value="<%=exchange.toHtml(ip)%>"></td>
</tr>
</table>
<%}else{%>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","是否启用实时备份：")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" name="status" value='0' checked><%=demo.getLang("erp","否")%><input type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" name="status" value='1'><%=demo.getLang("erp","是")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","从数据源地址：")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="ds" style="width:30%"></td>
</tr>
</table>
<%}%>
</div>
</form>