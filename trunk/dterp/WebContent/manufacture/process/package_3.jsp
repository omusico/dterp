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
<%-- 
<input name="filePath" type="hidden" value="<%=filePath %>">
<input name="m" type="hidden" value="<%="add" %>">
<input name="product_info_id" type="hidden" value="<%=product_info_id %>">
<input name="id" type="hidden" value="<%=id %>">
--%>
<form id="mutiValidation" method="POST" action="../../manufacture_process_ActionProcess.do" onsubmit="return checkForm()">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		
		<td <%=TD_STYLE6%> class="TD_STYLE6">
		  <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认包装")%>" >
		  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="package_4.jsp">
		</td>
	</tr>
</table>
<%
		

 		try {
 		nseer_db_backup hr_db = new nseer_db_backup(application);
 		String human_ID = request.getParameter("human_ID");
 		String filePath=request.getParameter("path");//获得文件路径
 		try {
 			if (hr_db.conn((String) session.getAttribute("unit_db_name"))) {
 		
 			
 			//得到上传文件的信息
			Map<Integer, String> filerows=new HashMap<Integer, String>();
			filerows=fileread.readF2(filePath);//获得有效地每一行内容
			int row_m=Integer.parseInt(filerows.get(0));
			String package_pallet=filerows.get(filerows.size()-1);//栈板号
			//查询纸规格，客户名称，栈板号
			
			String product_spec="";
			String package_factory_pallet="";
			String package_custom_id="";
		
			String sql_q="select product_spec,package_factory_pallet,package_pallet,package_custom_id from package_info where package_pallet='"+package_pallet+"'";
			ResultSet rs_q=hr_db.executeQuery(sql_q);
			if(rs_q.next()){
				product_spec=rs_q.getString("product_spec");
				package_factory_pallet=rs_q.getString("package_factory_pallet");
				package_custom_id=rs_q.getString("package_custom_id");
			}
			//客户名称
			String package_custom="";
			String sql_crm="SELECT id,customer_name,type FROM crm_file where id="+package_custom_id;
			ResultSet rs_crm=hr_db.executeQuery(sql_crm);
			if(rs_crm.next()){
				package_custom=rs_crm.getString("customer_name");
			}
			
%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	
	
	<tr <%=TR_STYLE1%> class="TR_STYLE 1">
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="right">
		  &nbsp;&nbsp;
		  原纸规格：
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <input type="text" name="" id="" value="<%=product_spec %>" style="width: 100%">
		</td>
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="right">
		  &nbsp;&nbsp;客户名称：
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <input type="text" name="" id="" value="<%=package_custom %>" style="width: 100%">
		</td>
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="right">
		  &nbsp;&nbsp;工厂托盘号：</td>
		<td >
		  <input type="text" name="" id="" value="<%=package_factory_pallet %>" style="width: 100%">
		</td>
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="right">
		  &nbsp;&nbsp;
		  栈板号：
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <input type="text" name="" id="" value="<%=package_pallet %>" style="width: 100%">
		</td>
	</tr>
</table>
<input name="m" type="hidden" value="addpackage">
<input name="path" type="hidden" value="<%=filePath %>">
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE 1">
	<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="right" style="width: 30%">&nbsp;</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  原纸规格
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  Lot No
		</td>
	<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="right" style="width: 30%">&nbsp;</td>
		
	</tr>
<%			
	String dis_1="";//原纸规格
	String dis_2="";//显示lot no 
			for(int x=4;x<filerows.size()-1;x++){
				
			
				String sql_3="select REPLACE(product_lot_no,'-','') as lotNo,product_lot_no,product_pstatus,product_spec,id from product_info where REPLACE(product_lot_no,'-','')='"+filerows.get(x)+"'";
				ResultSet rs_x=hr_db.executeQuery(sql_3);
				if(rs_x.next()){
					dis_1=rs_x.getString("product_lot_no");
					dis_2=rs_x.getString("product_spec");
					
				}
%>
	<tr <%=TR_STYLE1%> class="TR_STYLE 1">
		<td>&nbsp;</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2">
		  <%=dis_2 %>
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <%=dis_1 %>
		</td>
		<td>&nbsp;</td>
		
	</tr>
<%				
				
			}
			
			
 %>
</table>
</form>



<%
} else {
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1">
		<input type="button" 
		    <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " 
		    onClick=location= "register.jsp"></div>
		</td>
	</tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp", "数据库连接故障，请返回。")%></td>
	</tr>
</table>
<%
		}
		} catch (Exception ex) {
			
		}
		hr_db.close();
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>
</div>
