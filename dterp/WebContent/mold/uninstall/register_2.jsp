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
	import="java.io.*"
	import="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.exchange,java.text.*"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：","document_main", "reason", "value");

			nseer_db manufacture_db = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
</script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%--
	String register_time = "";
	String apply_ID = request.getParameter("apply_ID");
	try {
		String sql = "select * from manufacture_apply where apply_ID='"+ apply_ID + "'";
		ResultSet rs = manufacture_db.executeQuery(sql);
		if (rs.next()) {
			String check_time = rs.getString("check_time");
			String checker = rs.getString("checker");
			String remark = rs.getString("remark");
			if (rs.getString("register_time").equals("1800-01-01 00:00:00.0")) {
				register_time = "";
			} else {
				register_time = rs.getString("register_time");
			}
			String check_tag = "";
			String color1 = "#FF9A31";
			String color = "#FF9A31";
			if (rs.getString("check_tag").equals("0")) {
				check_tag = "等待";
			} else if (rs.getString("check_tag").equals("1")) {
				check_tag = "通过";
				color1 = "3333FF";
				color = "3333FF";
			} else if (rs.getString("check_tag").equals("9")) {
				check_tag = "未通过";
				color1 = "red";
				color = "red";
			}
--%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" align="left">
		<%=demo.getLang("erp", "读取文件")%><input type="file" <%=FILE_STYLE1%> class="FILE_STYLE1" name="file1">
		</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8">
		
		<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","读取文件信息")%>" onclick=id_link("check.jsp")>&nbsp;
		</td>
	</tr>
</table>

<%--
		}
		manufacture_db.close();
	} catch (Exception ex) {
		out.println("error" + ex);
	}
--%>
