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
	import="java.io.*" import="include.nseer_cookie.exchange"
	import="include.nseer_db.*,java.text.*"%>
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
String human_ID = request.getParameter("human_ID");
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<div id="nseerGround" class="nseerGround">
<form method="post"
	action="../../hr_file_change_ok?human_ID=<%=human_ID%>"
	ENCTYPE="multipart/form-data">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td><div>用户信息变更成功，请点击完成</div></td>
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1">
			<%-- 
			<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","上传照片")%> ">&nbsp;
			<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","上传附件")%>" onClick=location="change_choose_attachment.jsp?human_ID=<%=human_ID%>">&nbsp;
			--%>
			<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","完成")%> " onClick=location="change_list.jsp"></div>
		</td>
	</tr>
</table>
<%-- 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp",
									"如需变更照片，请选择上传照片(*.jpg、*.gif文件)")%><input
			type="file" <%=FILE_STYLE1%> class="FILE_STYLE1" <%=FILE_STYLE1%>
			class="FILE_STYLE1" name="file1" width="100%"></td>
	</tr>
</table>
--%>
</form>
</div>
