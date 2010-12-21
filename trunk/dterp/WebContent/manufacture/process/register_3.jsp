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
<jsp:useBean id="UpLoadUrl" scope="page" class="com.common.UpLoadUrl" />
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
		<div class="div_handbook"><%="您正在做的业务是：生产管理--产品包装--产品包装" 
%></div>
		</td>
	</tr>
</table>
<div id="nseerGround" class="nseerGround">
<%
		
		String id=request.getParameter("id");
 		try {
 			
 		
 		mySmartUpload.setCharset("UTF-8");
 		mySmartUpload.initialize(pageContext);
 		String file_type = "txt";
 		//long d = getFileLength.getFileLength((String) session.getAttribute("unit_db_name"));
 		//mySmartUpload.setMaxFileSize(d);
 		mySmartUpload.setAllowedFilesList(file_type);
 		try {
 			nseer_db_backup hr_db = new nseer_db_backup(application);
 			mySmartUpload.upload();
 		
 			com.jspsmart.upload.SmartFile myFile = mySmartUpload.getFiles().getFile(0);
 			String file_name = myFile.getFileName();
 			ServletContext context = session.getServletContext();
 			String path = request.getContextPath();
// 			获取文件存放文件夹名称
 			String filegroup=file_name.substring(file_name.indexOf("-")+1,file_name.indexOf("."));
 			
			String suffName = file_name.substring(file_name.indexOf(".")-1,file_name.indexOf("."));//判断类型
 			
 			if(!suffName.equals("I")){
 				 %>
				 <script type="text/javascript">window.location.href="register_error.jsp";</script>
				 <%
				 return;
 			}
 			
 			//获得当前日期
 			java.util.Date now = new java.util.Date();
 			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
 			String time=formatter.format(now);
 			String filePath=UpLoadUrl.getUploadUrl()+path+ "/upload_file/manufacture_result/"+time+"/"+filegroup+"/" ;//上传文件路径
 			
 			File a=new File(filePath);
 			if(!a.exists()){
 				a.mkdirs();
 			}
 			filePath=filePath+file_name;//
 			myFile.saveAs(filePath);
 			if (hr_db.conn((String) session.getAttribute("unit_db_name"))) {
 			//计划id
 			
 			String plan_id="";//计划编号
 			String sql_1="select plan_id from product_plan where id="+id;
 			ResultSet rs_1=hr_db.executeQuery(sql_1);
 			if(rs_1.next()){
 				plan_id=rs_1.getString("plan_id");
 			}
 			//得到上传文件的信息
			Map<Integer, String> filerows=new HashMap<Integer, String>();
			filerows=fileread.readF2(filePath);//获得有效地每一行内容
			//上传文件错误跳转
			if((!filerows.get(3).toLowerCase().equals("stat3"))&&(!filerows.get(3).toLowerCase().equals("stat2"))&&(!filerows.get(3).toLowerCase().equals("stat1")))
			{
%>
				<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
					<tr <%=TR_STYLE1%> class="TR_STYLE1">
						<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp", "上传文件错误，请返回。")%></td>
						<td <%=TD_STYLE3%> class="TD_STYLE3">
						<div <%=DIV_STYLE1%> class="DIV_STYLE1">
						<input type="button" 
						    <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " 
						    onClick=location= "register_list.jsp"></div>
						</td>
					</tr>
				</table>
<%				
				
				
				
			
			}else{
			//可加入产品是否在计划中的判断
			
			//带'-'的lotno号
			String product_lot_no="";
			//打孔和4、8切的文件格式区别
			if(filerows.get(3).toLowerCase().equals("stat3")){
				sql_1="select REPLACE(product_lot_no,'-','') as lotNo,product_lot_no,id from product_info where REPLACE(product_lot_no,'-','')='"+filerows.get(5)+"'";
			}else{
				sql_1="select REPLACE(product_lot_no,'-','') as lotNo,product_lot_no,id from product_info where REPLACE(product_lot_no,'-','')='"+filerows.get(4)+"'";
			}
			rs_1=hr_db.executeQuery(sql_1);
			if(rs_1.next()){
				product_lot_no=rs_1.getString("product_lot_no");
			}
			//产品规格
			String product_info_id="";
			String product_spec="";
			sql_1="select id,product_spec from product_info where product_lot_no='"+product_lot_no+"'";
			rs_1=hr_db.executeQuery(sql_1);
			if(rs_1.next()){
				product_spec=rs_1.getString("product_spec");
				product_info_id=rs_1.getString("id");
			}
			
 %>
<form id="mutiValidation" method="POST" action="../../manufacture_process_ActionProcess.do" >
<input name="filePath" type="hidden" value="<%=filePath %>"><%-- 上传文件全路径隐藏域 --%>
<input name="m" type="hidden" value="<%="add"%>">
<input name="product_info_id" type="hidden" value="<%=product_info_id %>"><%-- 原料id隐藏域 --%>
<input name="id" type="hidden" value="<%=id %>"><%-- 计划id隐藏域 --%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE8" align="center" style="width: 40%">
		生产计划编号&nbsp;&nbsp;：
		
		<input type="text" name="plan_id" value="<%=plan_id %>" style="width: 25%" onFocus="this.blur()" />&nbsp;</td>
		<td <%=TD_STYLE6%> class="TD_STYLE6">是否开始生产？&nbsp;
		  <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" onclick=>&nbsp;
		  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();">
		</td>
	</tr>
</table>

</form>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	
	
	<tr <%=TR_STYLE1%> class="TR_STYLE 1">
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="left" style="width: 25%">
		  规格：<%=product_spec %>
		  
		</td>
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="left" style="width: 25%">
		  Lot No：<%=product_lot_no %>
		  
		</td>
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="left" style="width: 25%">
		  调度：调度
		</td>
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="left" style="width: 25%">
		  &nbsp;
		</td>
	</tr>
</table>


<%
			}

			hr_db.close(); // add by wangshaolin 2010 11 16 
 			} else {
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp", "数据库连接故障，请返回。")%></td>
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1">
		<input type="button" 
		    <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " 
		    onClick=location= "register_list.jsp"></div>
		</td>
	</tr>
</table>

<%
		}
		} catch (Exception ex) {
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp", "附件类型错误或附件容量太大(最大")%><%=1024 / 1024%>KB)，<%=demo.getLang("erp", "请返回。")%></td>
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1">
		<input type="button"
			<%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; "
			onClick=location="register_list.jsp"></div>
		</td>
	</tr>
</table>

<%
	}
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>
</div>
