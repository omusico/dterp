<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.exchange,java.text.*"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language="javascript" src="../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<div id="nseerGround" class="nseerGround">
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<style media=print> 
.Noprint{display:none;} 
.PageNext{page-break-after: always;} 
</style> 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
String human_ID=request.getParameter("human_ID");
try{
	String sql = "select * from hr_file where human_ID='"+human_ID+"'" ;
	ResultSet rs = hr_db.executeQuery(sql) ;
	if(rs.next()){
		String major_change_time=rs.getString("change_time");
		if(major_change_time.equals("1800-01-01 00:00:00.0")){
			major_change_time=rs.getString("register_time");
		}
		String lately_change_time=rs.getString("change_time");
		if(lately_change_time.equals("1800-01-01 00:00:00.0")){
			lately_change_time="没有变更";
		}
		String birthday=rs.getString("birthday");
		if(birthday.equals("1800-01-01")){
			birthday="";
		}
%>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">

 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td class="Noprint">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT>
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印")%> onclick="javascript:window.print()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","页面设置")%> onclick=document.all.WebBrowser.ExecWB(8,1)>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印预览")%> onclick=document.all.WebBrowser.ExecWB(7,1)> 
 </td>
 </tr>
</table>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1">
<tr>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "部门")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
			<input type="hidden" name="oldKind_chain" value="<%=rs.getString("chain_id")%> <%=exchange.toHtml(rs.getString("chain_name"))%>">
			<input type="hidden" name="kind_chain" value="<%=rs.getString("chain_id")%> <%=exchange.toHtml(rs.getString("chain_name"))%>">
		    <%=rs.getString("chain_id")%> <%=exchange.toHtml(rs.getString("chain_name"))%></td>
			
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "性别")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
			<input type="hidden" name="sex" value="<%=rs.getString("sex")%>">
		    <%=rs.getString("sex")%></td>
	</tr>
	<tr>
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><%=demo.getLang("erp", "姓名")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
			<input type="hidden" name="human_name" value="<%=rs.getString("human_name")%>">
			<%=exchange.toHtml(rs.getString("human_name"))%></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><span align="left" class="style16"><%=demo.getLang("erp", "职位分类")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
			<input type="hidden" name="select4" value="<%=rs.getString("human_major_first_kind_id")%>">
			<%=rs.getString("human_major_first_kind_name")%>
		    </td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><%=demo.getLang("erp", "电话")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
			<input type="hidden" name="human_tel" value="<%=rs.getString("human_tel")%>">
		    <%=rs.getString("human_tel")%></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" >
		    <span align="left" class="style16"><%=demo.getLang("erp", "职位名称")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
			<input type="hidden" name="select5" value="<%=rs.getString("human_major_second_kind_id")%>">
		    <%=rs.getString("human_major_second_kind_name") %>
		</select></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><%=demo.getLang("erp", "EMAIL")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2"  colspan="3">
		<input type="hidden" name="human_email" value="<%=rs.getString("human_email")%>">
		<%=rs.getString("human_email")%></td>
	</tr>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_file.xml"/>
<%
String nickName="人力资源档案";%>
<%@include file="../../include/cDefineMouQ.jsp"%>
 </table>
<%
}else{
%>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该员工档案尚不存在，请返回。")%></td>
 </tr>
</table>
<%
	 }
hr_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>
</div>