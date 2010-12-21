<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.exchange"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<%@page import="org.apache.axis.session.Session"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<head>
<LINK href="../../javascript/table/onlineEditTable.css" type=text/css rel=stylesheet>
<script language="javascript" src="../../javascript/edit/editTable.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>

</head>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%="您正在做的业务是：库存管理--入库申请管理--入库申请查询"%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="POST" action="register_reconfirm.jsp" onSubmit="return doValidate('../../xml/stock/stock_apply_gather.xml','mutiValidation')">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8">
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="javascript:window.print()" value="<%=demo.getLang("erp","打印")%>">
 &nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="javascript:window.history.back()" value="<%=demo.getLang("erp","返回")%>">&nbsp;

 </td>
 </tr>
 </table>
 <%

String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String gather_ID=request.getParameter("gather_ID");
String new_apply="0";
if(gather_ID==null){
new_apply="1";
gather_ID="";
}
%>
<input type="hidden" name="new_apply" value="<%=new_apply%>">
<input name="gather_ID" type="hidden" value="<%=gather_ID%>">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>

<table style="text-align: center" align="center" width="80%">
	<%
		int orderId = Integer.parseInt(request.getParameter("orderId"));
		int proId = Integer.parseInt(request.getParameter("proId"));//入库理由
		if(proId==2){
		String sql ="select product_lot_no from stock_in_apply_detail left join product_info on product_info.id=stock_in_apply_detail.In_Detail_product_id where apply_in_id='"+orderId+"'";
		ResultSet rs = stock_db.executeQuery(sql);
		while(rs.next()){
			String number = rs.getString("product_lot_no");
			number = number.replaceAll("-","");
	%>
	<tr><td>
		<img
			src="<%=request.getContextPath()%>/barcode?msg=*<%=number%>*&type=code39"
			height="50px" width=200px />
	</td></tr>
	<%}}else if(proId==4){
		String sql = "select package_pallet from stock_in_apply_detail left join package_info on package_info.id = stock_in_apply_detail.In_Detail_product_id where apply_in_id='"+orderId+"'";
		ResultSet rs = stock_db.executeQuery(sql);
		while(rs.next()){
	%>
	<tr><td>
		<img
			src="<%=request.getContextPath()%>/barcode?msg=*<%=rs.getString("package_pallet")%>*&type=code39"
			height="50px" width=200px />
	</td></tr>
	<%}} %>
	<%--  
	<tr><td>
	<img
			src="<%=request.getContextPath()%>/barcode?msg=9794994948&type=code39"
			height="50px" width=200px />
	</td></tr>
	
	<tr><td>
	<img
			src="<%=request.getContextPath()%>/barcode?msg=0123456789&type=codabar"
			height="50px" width=200px />
	</td></tr>
	
	<tr><td>
		<img
			src="<%=request.getContextPath()%>/barcode?msg=01234567890540&type=intl2of5"
			height="50px" width=200px />
	</td></tr>
	--%>
</table>
<%stock_db.close(); %>
<%@include file="../include/paper_bottom.html"%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 </form>
 </div>
 <script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>