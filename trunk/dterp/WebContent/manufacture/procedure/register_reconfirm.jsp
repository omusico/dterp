<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%counter count=new counter(application);%>
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>

<%
String manufacture_ID=request.getParameter("manufacture_ID");
String product_ID=request.getParameter("product_ID");
String product_name=request.getParameter("product_name");
String product_describe=request.getParameter("product_describe");
String amount=request.getParameter("amount");
String pay_ID_group=request.getParameter("pay_ID_group");
String choice_group=request.getParameter("choice_group");
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String remark=request.getParameter("remark");
int i=1;
String design_ID="";
String sql5="select * from manufacture_design_procedure where product_ID='"+product_ID+"' and check_tag='1' and design_module_tag='2'";
ResultSet rs5=manufacture_db.executeQuery(sql5);
if(rs5.next()){
	design_ID=rs5.getString("design_ID");
%>
<form id="register1" method="POST" action="../../manufacture_procedure_register_ok">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td> 
 </tr>
 </table>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","派工单编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="86.5%" colspan="3"><input type="hidden" name="manufacture_ID" value="<%=manufacture_ID%>"><%=manufacture_ID%></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","工单制定人")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="designer" type="text" style="width: 50%; " value="<%=exchange.toHtml(designer)%>"></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","出库单编号集合")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%"><input name="choice_group" type="hidden" style="width: 50%; " value="<%=choice_group%>"><input name="pay_ID_group" type="hidden" style="width: 50%; " value="<%=pay_ID_group%>"><%=pay_ID_group%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="register" type="text" style="width: 50%; " value="<%=exchange.toHtml(register)%>"></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%"><input name="register_time" type="hidden" style="width: 50%; " onfocus="setday(this)" value="<%=exchange.toHtml(register_time)%>">&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品编号")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%"><input name="product_ID" type="hidden" value="<%=product_ID%>"><%=product_ID%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%"><input name="product_name" type="hidden" value="<%=exchange.toHtml(product_name)%>"><%=exchange.toHtml(product_name)%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","描述")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%"><input name="product_describe" type="hidden" value="<%=exchange.toHtml(product_describe)%>"><%=exchange.toHtml(product_describe)%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","数量")%> </td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%"><input name="amount" type="hidden" value="<%=amount%>"><%=amount%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE1%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","备注")%> &nbsp; </td>
<td colspan="3" <%=TD_STYLE2%> class="TD_STYLE2" width="86.5%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
</td>
 </tr>
</table>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="5%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","工序名称")%> </td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","工序编号")%> </td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","描述")%> </td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","工时数(小时)")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","单位工时成本（元）")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","工时成本小计（元）")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","查看物料")%> </td>
 </tr>
<%
String sql6="select * from manufacture_design_procedure_details where design_ID='"+design_ID+"' order by details_number";
ResultSet rs6=manufacture_db.executeQuery(sql6);
while(rs6.next()){
	double labour_hour_amount=rs6.getDouble("labour_hour_amount")*Double.parseDouble(amount);
	double subtotal=rs6.getDouble("cost_price")*labour_hour_amount;
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="procedure_name" type="hidden" width="100%" value="<%=exchange.toHtml(rs6.getString("procedure_name"))%>"><%=exchange.toHtml(rs6.getString("procedure_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="procedure_ID" type="hidden" width="100%" value="<%=rs6.getString("procedure_ID")%>"><%=rs6.getString("procedure_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="procedure_describe" type="hidden" width="100%" value="<%=exchange.toHtml(rs6.getString("procedure_describe"))%>"><input name="amount_unit" type="hidden" width="100%" value="<%=exchange.toHtml(rs6.getString("amount_unit"))%>"><%=exchange.toHtml(rs6.getString("procedure_describe"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="labour_hour_amount" type="hidden" width="100%" value="<%=labour_hour_amount%>"><%=labour_hour_amount%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="cost_price" type="hidden" width="100%" value="<%=rs6.getDouble("cost_price")%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="subtotal" type="hidden" width="100%" value="<%=subtotal%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(subtotal)%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="register_module_details.jsp?design_ID=<%=rs6.getString("design_ID")%>&&procedure_name=<%=toUtf8String.utf8String(exchange.toURL(rs6.getString("procedure_name")))%>&&amount=<%=amount%>" target="_blank"><%=demo.getLang("erp","查看物料")%></a></td>
 </tr>
<%
	i++;
	}
	manufacture_db.close();
%>
<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="design_ID" type="hidden" width="100%" value="<%=design_ID%>">
</table>
 </form>
 <%
}else{
	manufacture_db.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1">sorry!<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td> 
 </tr>
 </table>
<%
}
%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
 