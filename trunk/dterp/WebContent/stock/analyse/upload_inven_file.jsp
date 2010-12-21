
<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stockdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
	<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">

<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_gather.xml"/>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request); 
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<script type="text/javascript">
<!--
function readCheck(){
	
	window.location.href="result_getStaticReport.jsp";

}
//-->

</script>
<script type="text/javascript">
 function validateForm(){
 	var inven_date=document.getElementById("inven_time");
 	if(inven_date.value==""){
 		alert("盘点日期不能为空");
 		return false;
 	}
 	var inven_file=document.getElementById("inven_file");
 	if(inven_file.value==""){
 		alert("盘点文件不能为空");
 		return false;
 	}
 	var file_type=inven_file.value.substr(inven_file.value.lastIndexOf(".")).toLowerCase(); 
 	
 	if(file_type!=".txt"){
 		alert("请上传txt文件");
 		inven_file.select(); 
		document.execCommand("delete");
		return false;
 	}
 	var str=inven_file.value.charAt(inven_file.value.lastIndexOf(".")-1);
 	if(str!="N"){
 		alert("文件格式不正确，文件名必须以N字母结尾");
 		inven_file.select(); 
		document.execCommand("delete");
 	}
 	return true;
 }
 </script>
	<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
<form name="" id="" action="../../upload_inven_file" onsubmit="return validateForm()"  method="post" enctype="multipart/form-data">
<table width="100%"><tr>
<td>

&nbsp;&nbsp;&nbsp;&nbsp;
盘点日期：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="text" id="inven_time" name="inven_time"    <%=BUTTON_STYLE1%>  class="BUTTON_STYLE1" /> 
&nbsp;&nbsp;&nbsp;&nbsp;
盘点文件：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="file" name="inven_file" style="width: 400px;" id="inven_file"  <%=BUTTON_STYLE1%>  class="BUTTON_STYLE1" /> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td align="right">
<input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","上传")%>">
</td></tr></table>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
</form>
<script type="text/javascript">
Calendar.setup ({inputField : "inven_time", ifFormat : "%Y-%m-%d", showsTime : false, button : "inven_time", singleClick : true, step : 1});
</script>
<%@include file="../../include/head_msg.jsp"%>


 
