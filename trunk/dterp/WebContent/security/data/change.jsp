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
	import="java.sql.*" import="java.util.*" import="java.io.*"
	import="include.nseer_db.*,include.nseerdb.*,java.text.*,include.nseer_cookie.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：",
			"document_main", "reason", "value");
		nseer_db hr_db = new nseer_db((String) session
		.getAttribute("unit_db_name"));
		nseer_db hrdb = new nseer_db((String) session
		.getAttribute("unit_db_name"));
%>
<jsp:useBean id="vt" scope="page" class="validata.ValidataTag" />
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script language="javascript"
	src="../../javascript/ajax/ajax-validation-f.js"></script>
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/input_control/focus.css">
<script type="text/javascript"
	src="../../javascript/include/validate/validation-framework.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript'
	src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type=text/javascript>
function validateForm(){
var reg=/^\d+$/;
// var reg_float=/^\d+(\.{1}\d+)?$/;
// 四分切湿度
var data_4_1_1=document.getElementsByName("data_4_1_1")[0];
if(data_4_1_1.value==""){
	alert("四分切湿度1不能为空");
	data_4_1_1.focus();
	return false;
}
if(!reg.test(data_4_1_1.value)){
		alert("四分切湿度1度输入有误");
		data_4_1_1.focus();
		return false;
}

var data_4_1_2=document.getElementsByName("data_4_1_2")[0];
if(data_4_1_2.value==""){
	alert("四分切湿度2不能为空");
	data_4_1_2.focus();
	return false;
}
if(!reg.test(data_4_1_2.value)){
		alert("四分切湿度2输入有误");
		data_4_1_2.focus();
		return false;
}


// 四分切温度
var data_4_2_1=document.getElementsByName("data_4_2_1")[0];
if(data_4_2_1.value==""){
	alert("四分切温度1不能为空");
	data_4_2_1.focus();
	return false;
}
if(!reg.test(data_4_2_1.value)){
		alert("四分切温度1度输入有误");
		data_4_2_1.focus();
		return false;
}

var data_4_2_2=document.getElementsByName("data_4_2_2")[0];
if(data_4_2_2.value==""){
	alert("四分切温度2不能为空");
	data_4_2_2.focus();
	return false;
}
if(!reg.test(data_4_2_2.value)){
		alert("四分切温度2输入有误");
		data_4_2_2.focus();
		return false;
}




var data_8_1_1=document.getElementsByName("data_8_1_1")[0];
if(data_8_1_1.value==""){
	alert("8mm切湿度1不能为空");
	data_8_1_1.focus();
	return false;
}
if(!reg.test(data_8_1_1.value)){
		alert("8mm切湿度1输入有误");
		data_8_1_1.focus();
		return false;
}

var data_8_1_2=document.getElementsByName("data_8_1_2")[0];
if(data_8_1_2.value==""){
	alert("8mm切湿度2不能为空");
	data_8_1_2.focus();
	return false;
}
if(!reg.test(data_8_1_2.value)){
		alert("8mm切湿度2输入有误");
		data_8_1_2.focus();
		return false;
}



var data_8_2_1=document.getElementsByName("data_8_2_1")[0];
if(data_8_2_1.value==""){
	alert("8mm切温度1不能为空");
	data_8_2_1.focus();
	return false;
}
if(!reg.test(data_8_2_1.value)){
		alert("8mm切温度1输入有误");
		data_8_2_1.focus();
		return false;
}

var data_8_2_2=document.getElementsByName("data_8_2_2")[0];
if(data_8_2_2.value==""){
	alert("8mm切温度2不能为空");
	data_8_2_2.focus();
	return false;
}
if(!reg.test(data_8_2_2.value)){
		alert("8mm切温度2输入有误");
		data_8_2_2.focus();
		return false;
}




var data_hole_1_1=document.getElementsByName("data_hole_1_1")[0];
if(data_hole_1_1.value==""){
	alert("打孔湿度1不能为空");
	data_hole_1_1.focus();
	return false;
}
if(!reg.test(data_hole_1_1.value)){
		alert("打孔湿度1输入有误");
		data_hole_1_1.focus();
		return false;
}


var data_hole_1_2=document.getElementsByName("data_hole_1_2")[0];
if(data_hole_1_2.value==""){
	alert("打孔湿度2不能为空");
	data_hole_1_2.focus();
	return false;
}
if(!reg.test(data_hole_1_2.value)){
		alert("打孔湿度2输入有误");
		data_hole_1_2.focus();
		return false;
}


var data_hole_2_1=document.getElementsByName("data_hole_2_1")[0];
if(data_hole_2_1.value==""){
	alert("打孔温度1不能为空");
	data_hole_2_1.focus();
	return false;
}
if(!reg.test(data_hole_2_1.value)){
		alert("打孔温度1输入有误");
		data_hole_2_1.focus();
		return false;
}

var data_hole_2_2=document.getElementsByName("data_hole_2_2")[0];
if(data_hole_2_2.value==""){
	alert("打孔温度2不能为空");
	data_hole_2_2.focus();
	return false;
}
if(!reg.test(data_hole_2_2.value)){
		alert("打孔温度2输入有误");
		data_hole_2_2.focus();
		return false;
}

return true;
}

</script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<%
	String changer = (String) session.getAttribute("realeditorc");
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	String time = formatter.format(now);
		try {
			String sqll = "select * from security_base_data";
			ResultSet rss = hrdb.executeQuery(sqll);
			String data_4_1_1="0";
			String data_4_1_2="0";
			String data_4_2_1="0";
			String data_4_2_2="0";
			String data_8_1_1="0";
			String data_8_1_2="0";
			String data_8_2_1="0";
			String data_8_2_2="0";
			String data_hole_1_1="0";
			String data_hole_1_2="0";
			String data_hole_2_1="0";
			String data_hole_2_2="0";
			if (rss.next()) {
				 data_4_1_1=rss.getString("data_4_1_1");
				 data_4_1_2=rss.getString("data_4_1_2");
				 data_4_2_1=rss.getString("data_4_2_1");
				 data_4_2_2=rss.getString("data_4_2_2");
				 data_8_1_1=rss.getString("data_8_1_1");
				 data_8_1_2=rss.getString("data_8_1_2");
				 data_8_2_1=rss.getString("data_8_2_1");
				 data_8_2_2=rss.getString("data_8_2_2");
				 data_hole_1_1=rss.getString("data_hole_1_1");
				 data_hole_1_2=rss.getString("data_hole_1_2");
				 data_hole_2_1=rss.getString("data_hole_2_1");
				 data_hole_2_2=rss.getString("data_hole_2_2");
			}
%>
<div id="nseerGround" class="nseerGround">
<form class="x-form" name="myform" onsubmit="return validateForm();" id="mutiValidation" method="POST"
	action="../../security_data_SecurityData.do?m=doUpdate">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		
		<div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit"
			<%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1"
			value="<%=demo.getLang("erp","提交")%>" name="B1">
		</td>
	</tr>
</table>
<div style="position:absolute;">
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
	<tr style="background-image:url(../../images/line.gif)">
		<div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp", "四分切基本信息")%></div>
		</td>
	</tr>

	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="4%"><%=demo.getLang("erp", "湿度")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="data_4_1_1" style="width:25%"
			value="<%=data_4_1_1%>">&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;<input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="data_4_1_2" style="width:25%"
			value="<%=data_4_1_2%>"</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="4%"><%=demo.getLang("erp", "温度")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="data_4_2_1" style="width:25%"
			value="<%=data_4_2_1%>">&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;<input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="data_4_2_2" style="width:25%"
			value="<%=data_4_2_2%>"></td>
	</tr>
	</table>
	<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
	<tr style="background-image:url(../../images/line.gif)">
		<div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp", "8mm切基本信息")%></div>
		</td>
	</tr>

	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="4%"><%=demo.getLang("erp", "湿度")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="data_8_1_1" style="width:25%"
			value="<%=data_8_1_1%>">&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;<input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="data_8_1_2" style="width:25%"
			value="<%=data_8_1_2%>"></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="4%"><%=demo.getLang("erp", "温度")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="data_8_2_1" style="width:25%"
			value="<%=data_8_2_1%>">&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;<input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="data_8_2_2" style="width:25%"
			value="<%=data_8_2_2%>"></td>
	</tr>
	</table>
	<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
	<tr style="background-image:url(../../images/line.gif)">
		<div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp", "打孔基本信息")%></div>
		</td>
	</tr>

	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="4%"><%=demo.getLang("erp", "湿度")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1"  type="text" name="data_hole_1_1" style="width:25%"
			value="<%=data_hole_1_1%>">&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;<input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="data_hole_1_2" style="width:25%"
			value="<%=data_hole_1_2%>"></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="4%"><%=demo.getLang("erp", "温度")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="data_hole_2_1" style="width:25%"
			value="<%=data_hole_2_1%>">&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;<input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="data_hole_2_2" style="width:25%"
			value="<%=data_hole_2_2%>"></td>
	</tr>
	</table>
	
	
	<jsp:useBean id="mask" class="include.operateXML.Reading" />
	<jsp:setProperty name="mask" property="file" value="xml/hr/hr_file.xml" />
	<input name="lately_change_time" type="hidden" value="">
	<input name="file_change_amount" type="hidden" value="">

</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>"
	value="<%=session.getAttribute(Globals.TOKEN_KEY)%>"></form>
<%
			
			hrdb.close();
			hr_db.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
%>