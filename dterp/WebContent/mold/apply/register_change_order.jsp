<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%counter count=new counter(application);%>
<jsp:useBean id="getAmount" class="stock.getBalanceAmount" scope="request"/>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<form id="check" method="POST" action="../../purchase_apply_register_change_pay_ok">

<%
String pay_ID=request.getParameter("pay_ID") ;
try{
String sql="select * from stock_pay where pay_ID='"+pay_ID+"'";
ResultSet rs=stock_db.executeQuery(sql);
while(rs.next()){
%>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","出库单编号")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="7"><input name="pay_ID" type="hidden" value="<%=pay_ID%>"><%=pay_ID%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","出库理由")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="3"><input name="reason" type="hidden" value="<%=exchange.toHtml(rs.getString("reason"))%>"><%=exchange.toHtml(rs.getString("reason"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","出库详细理由")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="3"><input name="reasonexact" type="hidden" width="100%" value="<%=exchange.toHtml(rs.getString("reasonexact"))%>"><%=exchange.toHtml(rs.getString("reasonexact"))%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","应出库总件数")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="3"><%=rs.getDouble("demand_amount")%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","已出库总件数")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="3"><%=rs.getDouble("paid_amount")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","应出库总成本")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="3"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("cost_price_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","已出库总成本")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="3"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("paid_cost_price_sum"))%>&nbsp;</td>
 </tr>
</table>
<%}%>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="5%"><%=demo.getLang("erp","序号")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品名称")%> </td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品编号")%> </td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="9%"><%=demo.getLang("erp","应出库件数")%> </td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","拟采购数量")%> </td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","库存数量")%></td>
 </tr>
<%
	int i=1;
String sql6="select * from stock_pay_details where pay_ID='"+pay_ID+"' order by details_number";
ResultSet rs6=stock_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("details_number")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("product_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("product_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getDouble("amount")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="apply_purchase_amount<%=i%>" value="<%=rs6.getDouble("apply_purchase_amount")%>">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=getAmount.balanceAmount((String)session.getAttribute("unit_db_name"),rs6.getString("product_ID"))%>&nbsp;</td>
 </tr>
<%
	i++;
	}
	stock_db.close();
%>
<input name="product_amount" type="hidden" value="<%=i-1%>">	
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 </table>
 </form>
<%
}
catch (Exception ex){
out.println("error"+ex);
}
%>
 
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>