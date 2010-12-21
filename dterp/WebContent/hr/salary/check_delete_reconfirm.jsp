<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="com.jspsmart.upload.*" import ="include.nseer_db.*,java.text.*"%>

<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));
	String salary_id=request.getParameter("salary_id");
	String config_id=request.getParameter("config_id");
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
</table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" class="x-form" method="POST" action="../../hr_salary_check_delete_human_details_ok">
<input type="hidden" name="salary_id" value="<%=salary_id%>">
<input type="hidden" name="config_id" value="<%=config_id%>">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="10">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>"> 
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check.jsp?salary_id=<%=salary_id%>&&config_id=<%=config_id%>"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="10"><%=demo.getLang("erp","该薪酬单未通过审核，您确认吗？请选择处理：")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="10"></td>
 </tr> 
<%
int i=1;
String sql6="select config_id from hr_workflow where object_ID='"+salary_id+"' and config_id<'"+config_id+"' order by id";
ResultSet rs6=hr_db.executeQuery(sql6);
while(rs6.next()){
	String choice="从流程"+i+"开始重新审核";
	i++;
	%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><INPUT name="choice" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value="<%=rs6.getString("config_id")%>"><%=demo.getLang("erp",choice)%></td>
 </tr>
<%
}
hr_db.close();
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><INPUT name="choice" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=""><%=demo.getLang("erp","转入草稿箱")%></td>
 </tr>
 </table>
 </form>
</div>