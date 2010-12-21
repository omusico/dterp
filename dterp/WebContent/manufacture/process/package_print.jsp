
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
			
%>
<jsp:useBean id="query" scope="page"
	class="include.query.getRecordCount" />
<jsp:useBean id="validata" scope="page" class="validata.ValidataNumber" />
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page" />
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page" />
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page" />
<jsp:useBean id="mask" class="include.operateXML.Reading" />
<jsp:setProperty name="mask" property="file" value="xml/manufacture/manufacture_apply.xml" />
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/manufacture/apply/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css" />
<%
		try {
		
		DealWithString DealWithString = new DealWithString(application);
		String mod = request.getRequestURI();
		demo.setPath(request);
		String handbook = demo.businessComment(mod, "您正在做的业务是：","document_main", "reason", "value");
		String tablename = "manufacture_apply";
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>

<%
String package_pallet=request.getParameter("prt");//需要打印的栈板号


%>

<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		
		
		<td <%=TD_STYLE6%> class="TD_STYLE6">
		  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","打印")%>" onclick="javascript:window.print()">&nbsp;
		  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();">
		</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
	
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2" valign="middle" ><%=package_pallet %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" valign="middle" ><img src="<%=request.getContextPath()%>/barcode?msg=<%=package_pallet%>&type=code39" height="50px" width=200px /></td>
	</tr>
	
</TABLE>

<script type="text/javascript">
function id_link(link){
document.location.href=link;
}


</script>



<%-- <input type="hidden" name="" id="rows_num" value="<%=k%>">--%>
<%
	
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<%@include file="../../include/head_msg.jsp"%>
