<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*,include.nseer_cookie.*" import="java.util.*"
	import="java.io.*" import="include.nseer_db.*,java.text.*"%>
<%
			nseer_db manufacture_db = new nseer_db((String) session.getAttribute("unit_db_name"));
%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：",
			"document_main", "reason", "value");
%>
<%
	//String config_id=request.getParameter("config_id");
	//String apply_ID=request.getParameter("apply_ID");
	//String designer=request.getParameter("designer") ;
	//String register=request.getParameter("register") ;
	//String register_time=request.getParameter("register_time") ;
	//String checker=request.getParameter("checker") ;
	//String check_time=request.getParameter("check_time") ;
	//String remark = request.getParameter("remark");
	String id = request.getParameter("id");
%>
<form id="register1" class="x-form" method="POST" action="../../manufacture_plan_ActionPlan.do">
<%-- 
<input name="config_id" type="hidden" value="<%=config_id%>"> 
<input name="apply_ID" type="hidden" value="<%=apply_ID%>"> 
<input name="designer" type="hidden" value="<%=exchange.toHtml(designer)%>">
<input name="register" type="hidden" value="<%=exchange.toHtml(register)%>"> 
<input name="register_time" type="hidden" value="<%=exchange.toHtml(register_time)%>"> 
<input name="check_time" type="hidden" value="<%=exchange.toHtml(check_time)%>"> 
<input name="checker" type="hidden" value="<%=exchange.toHtml(checker)%>"> 
<input name="remark" type="hidden" value="<%=remark%>">
--%>
<input name="id" type="hidden" value="<%=id%>">
<input name="m" type="hidden" value="delete">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1">
		<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1">&nbsp;
		<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location=
			"check.jsp?id=<%=id%>"></div>
		</td>
	</tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp", "该生产计划未通过审核，您确认吗？请选择处理：")%></td>
		<td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
	</tr>
	<%--
		int i = 1;
		String sql6 = "select config_id from manufacture_workflow where object_ID='"
				+ apply_ID
				+ "' and type_id='03' and config_id<'"
				+ config_id + "' order by id";
		ResultSet rs6 = manufacture_db.executeQuery(sql6);
		while (rs6.next()) {
			String choice = "从流程" + i + "开始重新审核";
			i++;
	--%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<INPUT name="choice" type="radio" checked="checked" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value="<%=id%>"><%=demo.getLang("erp", "删除")%></td>
	</tr>
	
	<%
		//}
		manufacture_db.close();
	%>
	<%-- 
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3"><INPUT name="choice"
			type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=""><%=demo.getLang("erp", "转入草稿箱")%></td>
	</tr>
	--%>
</table>
</div>
</form>

