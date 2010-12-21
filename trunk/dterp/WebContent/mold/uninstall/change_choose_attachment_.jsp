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
<%nseer_db mold_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String id=request.getParameter("id") ;
String destruction_time=request.getParameter("destruction_time") ;
%>
<%
String sql = "select mold_spec,mold_code,destruction_time from mold_info where id='"+id+"'";
ResultSet rs1 = mold_db1.executeQuery(sql); 
String mold_spec="";
String mold_code="";
if(rs1.next())
{
	mold_spec = rs1.getString("mold_spec");
	mold_code = rs1.getString("mold_code");
	destruction_time = rs1.getString("destruction_time");
}
session.setAttribute("mold_spec",mold_spec);
session.setAttribute("mold_code",mold_code);
session.setAttribute("destruction_time",destruction_time);
mold_db1.close();
%>

<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
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
<div id="nseerGround" class="nseerGround">
<form method="post" class="myform" action="../../mold_register_picture2_ok?id=<%=id%>&destruction_time=<%=destruction_time%>&mold_spec=<%=mold_spec%>&mold_code=<%=mold_code%>" enctype="multipart/form-data" onsubmit="return formCheck()">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="上传">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="完成" onClick=location="change_list.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","拆卸检查照片")%><input type="file" <%=FILE_STYLE1%> class="FILE_STYLE1" name="file1" size="70">
</td>
<td style="display:none">
<input name="id" value="<%=id%>">
<input type="hidden" value="change" name="picType">
</td>
</tr>
 </table>
</form>
</div>