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
<script type="text/javascript">
//表单验证
function validateForm(){

	var fileName=mutiValidation.file1.value;
	if(fileName.length==0){
		alert("请选择上传文件！");
		return false;
	}else{
	var sufferName = fileName.substring(fileName.indexOf(".")-1,fileName.indexOf("."));
	
	if(sufferName!="K"&&sufferName!="k"){
		alert("您上传的类型不是有效文件，请核对后重新上传！");
		return false;
	}else{
		return true;
	}
	}
	
}
</script>	
<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：","document_main", "reason", "value");
	

%>

<script language="javascript" src="../../javascript/winopen/winopen.js"></script>

<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%="您正在做的业务是：生产管理--产品包装--产品包装" %></div>
		</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>

<form ENCTYPE="multipart/form-data" method="post" name="mutiValidation" action="../../manufacture_process_CheckResult" onsubmit="return validateForm()">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="right" style="width: 10%">
	读取文件：
	</td>
	<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE8" align="left" style="width: 40%">
		<input type="file" <%=FILE_STYLE1%> contenteditable="false" class="FILE_STYLE1" name="file1" id="file1" style="width: 100%">
	</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8">
		
			<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","读取文件信息")%>" >&nbsp;
		</td>
	</tr>
</table>
</form>


<%--
		}
		manufacture_db.close();
	} catch (Exception ex) {
		out.println("error" + ex);
	}
--%>
