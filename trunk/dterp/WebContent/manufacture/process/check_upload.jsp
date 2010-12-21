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
	import="java.io.*" import="com.jspsmart.upload.*"
	import="include.nseer_db.*,java.text.*,include.nseer_cookie.*"
	import="javax.servlet.*,javax.servlet.http.*"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<jsp:useBean id="getFileLength" scope="page" class="include.nseer_cookie.getFileLength" />
<jsp:useBean id="fileread" scope="page" class="manufacture.process.FileRead" />
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
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1" colspan="2">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<div id="nseerGround" class="nseerGround">
<%
		
		
 		try {
 			
 		
 		mySmartUpload.setCharset("UTF-8");
 		mySmartUpload.initialize(pageContext);
 		String file_type = "txt";
 		//long d = getFileLength.getFileLength((String) session.getAttribute("unit_db_name"));
 		//mySmartUpload.setMaxFileSize(d);
 		mySmartUpload.setAllowedFilesList(file_type);
 		try {
 			mySmartUpload.upload();
 			com.jspsmart.upload.SmartFile myFile = mySmartUpload.getFiles().getFile(0);
 			String file_name = myFile.getFileName();
 			ServletContext context = session.getServletContext();
 			String path = request.getContextPath();
// 			获取文件存放文件夹名称
 			String filegroup=file_name.substring(file_name.indexOf("-")+1,file_name.indexOf("."));
 			
 			
 			//获得当前日期
 			java.util.Date now = new java.util.Date();
 			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
 			String time=formatter.format(now);
 			String filePath=path + "/upload_file/manufacture_check_result/"+time+"/"+filegroup+"/" ;//上传文件路径
 			
 			File a=new File(filePath);
 			if(!a.exists()){
 				a.mkdirs();
 			}
 			filePath=filePath+file_name;//
 			myFile.saveAs(filePath);
 			//request.setAttribute("filepath",filePath);
 			//request.setAttribute("m","resultCheck");
 			//request.getRequestDispatcher("../../manufacture_process_ActionProcess.do").forward(request,response);
 			response.sendRedirect("../../manufacture_process_ActionProcess.do?m=resultCheck");
		} catch (Exception ex) {
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1">
		<input type="button"
			<%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; "
			onClick=location="check_list.jsp"></div>
		</td>
	</tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp", "附件类型错误或附件容量太大(最大")%><%=1024 / 1024%>KB)，<%=demo.getLang("erp", "请返回。")%></td>
	</tr>
</table>
<%
	}
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>
</div>
