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
	String filePath=request.getParameter("path");//获得文件路径
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
<form id="mutiValidation" method="POST" action="../../manufacture_process_ActionProcess.do">
<input name="m" type="hidden" value="addspecial">
<input name="path" type="hidden" value="<%=filePath %>">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		
		<td <%=TD_STYLE6%> class="TD_STYLE6">
		  <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认异常信息")%>" >
		  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp">
		</td>
	</tr>
</table>
</form>   
<%
		nseer_db_backup hr_db = new nseer_db_backup(application);

 		try {
 			
 		String human_ID = request.getParameter("human_ID");
 		
 		try {
 			
 			
 			if (hr_db.conn((String) session.getAttribute("unit_db_name"))) {
 		
 			
 			//得到上传文件的信息
			Map<Integer, String> filerows=new HashMap<Integer, String>();
			filerows=fileread.readF2(filePath);//获得有效地每一行内容
			int row_m=Integer.parseInt(filerows.get(0));
			String product_lot_no="";
			String product_pstatus="";
			String product_spec="";
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE 1">
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  规格
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  Lot No
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  当前产品状态
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  修改后产品状态
		</td>
	</tr>
<%			
			String after_product_pstatus="";
			for(int x=4;x<=filerows.size();x=x+2){
				if(filerows.get(x)==null){
					continue;
				}if(filerows.get(x).trim().equals("")||filerows.get(x).trim().equals("null")) {
					continue;
				}else{
					String sql_3="select REPLACE(product_lot_no,'-','') as lotNo,product_lot_no,product_pstatus,product_spec,id from product_info where REPLACE(product_lot_no,'-','')='"+filerows.get(x)+"'";
					ResultSet rs_x=hr_db.executeQuery(sql_3);
					if(rs_x.next()){
						product_lot_no=rs_x.getString("product_lot_no");
						product_spec=rs_x.getString("product_spec");
						if(rs_x.getString("product_pstatus").equals("异常")){
							product_pstatus="生产异常";
							after_product_pstatus="生产正常";
							
						}else{
							product_pstatus="生产正常";
							after_product_pstatus="生产异常";
						}
					}
%>
	<tr <%=TR_STYLE1%> class="TR_STYLE 1">
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <%=product_spec %>
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <%=product_lot_no %>
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <%=product_pstatus %>
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <%=after_product_pstatus %>
		</td>
	</tr>
<%				
				
				}
			}
			
 %>
</table>




<%
hr_db.close();
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
	} catch (Exception ex) {
		ex.printStackTrace();
	}
	hr_db.close();
%>
</div>
