<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseer_cookie.exchange,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db document_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>

<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" class="x-form" method="POST" action="register_batch.jsp">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register_list.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","请输入批量配置数量")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="80%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="batch_amount" style="width: 20%;"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","请选择配置语言种类")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="80%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="type" style="width: 20%;">
		<option value="">&nbsp;</option>
<%
String sql2 = "select type_name from document_config_public_char where kind='语言类型' order by type_ID";
ResultSet rs2 = document_db.executeQuery(sql2) ;
while(rs2.next()){
%>
 <option value="<%=exchange.toHtml(rs2.getString("type_name"))%>"><%=exchange.toHtml(rs2.getString("type_name"))%></option>
<%}%>
</select></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","请选择组名")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="80%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="group_name" style="width: 20%;">
<%
sql2 = "select distinct tablename from document_multilanguage order by tablename";
rs2 = document_db.executeQuery(sql2) ;
while(rs2.next()){
%>
 <option value="<%=exchange.toHtml(rs2.getString("tablename"))%>"><%=exchange.toHtml(rs2.getString("tablename"))%></option>
<%}%>
</select></td>
</tr>
</table>
</form>
<%
document_db.close();
%>
 </div>