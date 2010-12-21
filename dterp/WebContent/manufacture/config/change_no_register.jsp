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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：",
			"document_main", "reason", "value");
	String register = (String) session.getAttribute("realeditorc");
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	String time = formatter.format(now);
%>


<script type="text/javascript" src="../../../dwr/engine.js"></script>
<script type="text/javascript" src="../../../dwr/util.js"></script>
<script type="text/javascript" src="../../../dwr/interface/Multi.js"></script>
<script type="text/javascript"
	src="../../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript"
	src="../../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>
<script type="text/javascript"
	src="../../../javascript/include/validate/validation-framework.js"></script>
<script language="javascript"
	src="../../../javascript/ajax/ajax-validation.js"></script>
<script type="text/javascript">
function checkForm(){
	var flag=true;
	if(addForm.no_name.value==""){
		alert("编号名称不能为空");
		flag=false;
	}else if(addForm.no_value.value==""){
		alert("编号值不能为空");
		flag=false;
	}else if(addForm.no_type.value==""){
		alert("编号内容不能为空");
		flag=false;
	}
	return flag;
}
</script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<div id="nseerGround" class="nseerGround">
<form id="" class="x-form" method="post" name="addForm" action="../../security_data_SecurityData.do" onsubmit=" return checkForm()">
<input type="hidden" name="m" value="add_no"><%-- action中方法 --%>
<input type="hidden" name="register" value="<%=register %>"><%--  --%>
<input type="hidden" name="register_time" value="<%=time %>"><%--  --%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1">
		<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;
		<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="change_no.jsp"></div>
		</td>
	</tr>
</table>
<%
nseer_db crm_db = new nseer_db((String) session.getAttribute("unit_db_name"));
String m_id="";
String sql="show table status where name= 'option_no'";

ResultSet rs=crm_db.executeQuery(sql);

if(rs.next()){
	m_id=rs.getString("Auto_increment");
}else{
	m_id="";
}
crm_db.close();
int idint=1;
if(m_id!=null){
	if(!m_id.equals("")){
		idint=Integer.parseInt(m_id);
		
	}
}

%>
<table <%=TABLE_STYLE7%> class="TABLE_STYLE7" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp", "编号ID")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" 
		value="<%=idint %>"  onFocus="this.blur()"></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp", "编号名称")%>&nbsp;</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%">
		<input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="no_name" ></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp", "编号值")%>&nbsp;</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%">
		<input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="no_value" ></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp", "编号内容")%>&nbsp;</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%">
		<input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="no_type" ></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp", "说明")%>&nbsp;</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%">
		<input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="description" ></td>
	</tr>
	
</table>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>"
	value="<%=session.getAttribute(Globals.TOKEN_KEY)%>"></form>
</div>


