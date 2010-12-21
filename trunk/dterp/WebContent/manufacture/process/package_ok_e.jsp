<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="java.text.*"%>
<%@include file="../include/head.jsp"%>
<%@page import="include.nseer_db.nseer_db"%>
<jsp:useBean id="fileread" scope="page" class="manufacture.process.FileRead" />
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
	
	 
	 nseer_db package_db = new nseer_db((String) session.getAttribute("unit_db_name"));
	 String filePath=request.getParameter("filePath");
	 Map<Integer, String> filerows=new HashMap<Integer, String>();
		filerows=fileread.readF2(filePath);//获得有效地每一行内容
		int row_m=Integer.parseInt(filerows.get(0));
		String package_pallet=filerows.get(filerows.size()-1);//栈板号
		String dis_1="";//原纸规格
		String dis_2="";//显示lot no 
		String notEx="";
								
	 %>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","以下产品未进行临时入库操作或者不存在！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
  <div <%=DIV_STYLE1%> class="DIV_STYLE1"> 
  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick=location="package_4.jsp"></div></td>
 </tr>
 </table>
  <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <%
for(int x=4;x<filerows.size()-1;x++){
	
	
	String sql_3="select REPLACE(product_lot_no,'-','') as lotNo,product_lot_no,product_pstatus,product_spec,id,stock_id from product_info where REPLACE(product_lot_no,'-','')='"+filerows.get(x)+"' and stock_id!='107' and stock_id!='108'";
	ResultSet rs_x=package_db.executeQuery(sql_3);
	if(rs_x.next()){
		
		dis_1=rs_x.getString("product_lot_no");    
		dis_2=rs_x.getString("product_spec");
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
		
	}else{
		notEx=filerows.get(x);
	%>
		<tr <%=TR_STYLE1%> class="TR_STYLE 1">
			<td>&nbsp;</td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			  <%=notEx %>
			</td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" >
			  &nbsp;
			</td>
			<td>&nbsp;</td>
			
		</tr>
	<%		
		
	}
%>
	
<%
}
%>
</table>
</div>