<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="getFileLength" scope="page" class="include.nseer_cookie.getFileLength"/>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String id=request.getParameter("id") ;
String mold_spec=request.getParameter("mold_spec") ;
String mold_code=request.getParameter("mold_code") ;
String stock_time=request.getParameter("stock_time") ;

%>
<script type="text/javascript">

	function formCheck(){
	var fileName = document.getElementById("file1").value;
	if(fileName!=""){
	var sufferName = fileName.substring(fileName.indexOf(".")+1);
 
	if(sufferName.toLowerCase()=="jpg"||sufferName.toLowerCase()=="gif"){
		return true;
	}else{
		alert("您上传的类型不是有效文件，请核对后重新上传！");
		return false;
	}
	}else{
	alert("请选择上传文件！");
	return false;
	}
	
	}
	

</script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<form method="post" class="x-form" action="../../mold_register_picture_ok?id=<%=id%>&mold_spec=<%=mold_spec%>&mold_code=<%=mold_code%>&stock_time=<%=stock_time%>" ENCTYPE="multipart/form-data" onsubmit="return formCheck()">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="上传">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="完成" onClick=location="register.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","入库检查不良照片")%><input type="file" <%=FILE_STYLE1%> class="FILE_STYLE1" name="file1" size="70"></td>
</tr>
 </table>
</form>
</div>