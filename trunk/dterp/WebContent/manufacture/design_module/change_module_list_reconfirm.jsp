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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%counter count=new counter(application);%>
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>

<%
String[] product_namea=request.getParameterValues("product_name") ;
String[] product_IDa=request.getParameterValues("product_ID") ;
String[] typea=request.getParameterValues("type") ;
String[] product_describea=request.getParameterValues("product_describe") ;
String[] amounta=request.getParameterValues("amount") ;
String[] design_balance_amounta=request.getParameterValues("design_balance_amount") ;
String[] using_amounta=request.getParameterValues("using_amount") ;
String[] cost_pricea=request.getParameterValues("cost_price") ;
String[] amount_unita=request.getParameterValues("amount_unit") ;

String[] product_name=new String[product_IDa.length];
String[] product_ID=new String[product_IDa.length] ;
String[] type=new String[product_IDa.length];
String[] product_describe=new String[product_IDa.length] ;
String[] amount=new String[product_IDa.length] ;
String[] design_balance_amount=new String[product_IDa.length] ;
String[] using_amount=new String[product_IDa.length] ;
String[] cost_price=new String[product_IDa.length] ;
String[] amount_unit=new String[product_IDa.length] ;

String[] product_name1=new String[product_IDa.length];
int m=0;
int n=0;
for(int j=0;j<product_IDa.length;j++){
	if(!using_amounta[j].equals("")){	if(Double.parseDouble(design_balance_amounta[j])>=Double.parseDouble(using_amounta[j])){
	product_name[m]=product_namea[j];
	product_ID[m]=product_IDa[j] ;
	type[m]=typea[j];
	product_describe[m]=product_describea[j] ;
	amount[m]=amounta[j] ;
	design_balance_amount[m]=design_balance_amounta[j] ;
	using_amount[m]=using_amounta[j] ;
	cost_price[m]=cost_pricea[j] ;
	amount_unit[m]=amount_unita[j] ;
	m++;
	}else{
	product_name[m]=product_namea[j];
	product_ID[m]=product_IDa[j] ;
	type[m]=typea[j];
	product_describe[m]=product_describea[j] ;
	amount[m]=amounta[j] ;
	design_balance_amount[m]=design_balance_amounta[j] ;
	using_amount[m]=using_amounta[j] ;
	cost_price[m]=cost_pricea[j] ;
	amount_unit[m]=amount_unita[j] ;
	product_name1[n]=product_namea[j];
	m++;
	n++;
	}
	}
}
%>
<script language="javascript" src="../../javascript/input_control/check.js"></script>
<script language="javascript">
var count=0;
function CheckForm(TheForm) {
	trimform(TheForm);
	if(count>0) {
 	return false;
 	}
 	count++;
<%for(int k=1;k<m;k++){%>
	if (TheForm.using_amount<%=k%>.value == ""||!chkfin(TheForm.using_amount<%=k%>.value)) {
	alert(<%=demo.getLang("erp","请正确填写数量！")%>);
	TheForm.using_amount<%=k%>.focus();
		count=count-1;
	return(false);
	}	
<%}%>
	return(true);
}
</script>
<form id="change2" method="POST" action="../../manufacture_design_module_change_module_ok">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
if(n!=0){
	design_db.close();
 %>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","物料：")%><%
for(int k=0;k<n;k++){
%>
<%=exchange.toHtml(product_name1[k])%>,<%
	}
%><%=demo.getLang("erp","使用数量超出可用数量，请返回确认。")%></td> 
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td> 
 </tr>
 </table>
<%
 }else{
	design_db.close();
%>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td> 
 </tr>
 </table>
<%
}
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String design_ID=request.getParameter("design_ID") ;
String module_design_ID=request.getParameter("module_design_ID") ;
String procedure_name=request.getParameter("procedure_name") ;
%>
<input name="module_design_ID" type="hidden" value="<%=module_design_ID%>">
 <div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","工序物料设计单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","设计单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="design_ID" type="hidden" value="<%=design_ID%>"><%=design_ID%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","工序名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="procedure_name" type="hidden" value="<%=exchange.toHtml(procedure_name)%>"><%=exchange.toHtml(procedure_name)%></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" type="text" value="<%=exchange.toHtml(register)%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="register_time" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id=theObjTable>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","物料名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","物料编号")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","描述")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","本工序数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","单位")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","单价（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","小计（元）")%></td>	 
 </tr>
<%
for(int i=0;i<m;i++){
	double subtotal=Double.parseDouble(cost_price[i])*Double.parseDouble(using_amount[i]);
%>

 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i+1%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name<%=i%>" onFocus="this.blur()" type="text" value="<%=exchange.toHtml(product_name[i])%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID<%=i%>" onFocus="this.blur()" type="text" value="<%=product_ID[i]%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="type<%=i%>" type="hidden" value="<%=exchange.toHtml(type[i])%>"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_describe<%=i%>" onFocus="this.blur()" type="hidden" value="<%=product_describe[i]%>"><%=product_describe[i]%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="using_amount<%=i%>" type="text" value="<%=using_amount[i]%>"><input name="amount<%=i%>" type="hidden" value="<%=amount[i]%>">
 <input name="design_balance_amount<%=i%>" type="hidden" value="<%=design_balance_amount[i]%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unit<%=i%>" onFocus="this.blur()" type="text" value="<%=exchange.toHtml(amount_unit[i])%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_price<%=i%>" onFocus="this.blur()" type="text" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(cost_price[i]))%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(subtotal)%></td>
 </tr>
<%
	}
%>
<input name="product_amount" type="hidden" value="<%=m%>">
</table>
<%@include file="../include/paper_bottom.html"%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</div>
 </form>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>