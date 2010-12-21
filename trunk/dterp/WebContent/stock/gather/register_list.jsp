
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
	import="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%
			nseer_db stock_db = new nseer_db((String) session
			.getAttribute("unit_db_name"));
			nseer_db stockdb = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<jsp:useBean id="validata" scope="page" class="validata.ValidataNumber" />
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page" />
<jsp:useBean id="mask" class="include.operateXML.Reading" />
<jsp:setProperty name="mask" property="file"
	value="xml/stock/stock_gather.xml" />
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：",
			"document_main", "reason", "value");
%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount" />
<script type="text/javascript">
function formCheck(){
var fileName = document.getElementById("fileNameC").value;

if(fileName!=""){
var sufferName = fileName.substring(fileName.indexOf(".")-1,fileName.indexOf("."));
	if(sufferName!="A"){
		alert("您上传的类型不是有效文件，请核对后重新上传！");
		return false;
	}else{
		return true;
	}
}else{
alert("请选择上传文件！");
return false;
}

}

</script>

<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3"></td>
	</tr>
</table>
<form name="" id="" action="register_ok.jsp" method="post" onsubmit="return formCheck()"   enctype="multipart/form-data" >
<table width="100%">
	<tr>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;
		读取文件&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
			name="fileNameC" id="fileNameC" onkeypress="return false;" contenteditable="false" type="file" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" size="70" />
		</td>
		<td align="right"><input type="submit" <%=BUTTON_STYLE1%>
			class="BUTTON_STYLE1"
			value="<%=demo.getLang("erp","读取文件信息")%>"></td>
	</tr>
</table>
</form>
<%@include file="../../include/head_msg.jsp"%>


