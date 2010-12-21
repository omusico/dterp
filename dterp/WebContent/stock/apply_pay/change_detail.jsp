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
<%@include file="../include/headNew.jsp"%>
<%@page import="org.apache.axis.session.Session"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/input_control/focus1.css">
<% String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<head>
<LINK href="../../javascript/table/onlineEditTable.css" type=text/css rel=stylesheet>
<script language="javascript" src="../../javascript/edit/editTable.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>

<script type="text/javascript">
//生产出库
function delSelect(){
	table = document.getElementById("tableOnlineEdit1");
	checkboxs = document.getElementsByName("checkbox");
 var tr = table.getElementsByTagName("tr");
  //没选择产品给出 相应提示
 var bool=false;
for (var i=0; i<checkboxs.length; i++) 
{
	if(checkboxs[i].checked == true )
 {
 	bool=true
 }
}

if(bool==false)
{
 alert("请选择要删除的产品！");
}
//删除 开始
 for (var i=0; i<checkboxs.length; i++) {
 if(tr.length==1){
 checkboxs[i].checked = false;
 return;
 }
 if(checkboxs[i].checked==true){
 removeTr(checkboxs[i]);
 i=-1;
 }
 }
}
//成品删除
function delSelect1(){
	table = document.getElementById("tableOnlineEdit");
	checkboxs = document.getElementsByName("checkbox1");
 var tr = table.getElementsByTagName("tr");
 for (var i=0; i<checkboxs.length; i++) {
 if(tr.length==1){
 checkboxs[i].checked = false;
 return;
 }
 if(checkboxs[i].checked==true){
 removeTr(checkboxs[i]);
 i=-1;
 }
 }
}
function removeTr(obj) {
 var sTr = obj.parentNode.parentNode;
 sTr.parentNode.removeChild(sTr);
}
</script>

<script>
var openWin=null;
function productCheck(){
document.getElementById("add").disabled="disabled";
if(openWin==null){
	openWin=window.open('register_change_list1.jsp',"","left=250 top = 100 width = 950 height = 550");
}else{
	openWin.focus();
}
	
}
function productCheck1(){
document.getElementById("add").disabled="disabled";
if(openWin==null){
	openWin=window.open('register_change_list2.jsp',"","left=250 top = 100 width = 950 height = 550");
}else{
	openWin.focus();
}
	
}

//更正
function changeDetail(avg){
	document.forms[0].action="../../stock_product_comeoutProAction.do?m=searchDetail&id="+avg;
}
//更正
function change(avg){
	document.forms[0].action="../../stock_product_comeoutProAction.do?m=search&id="+avg;
}
//表单验证
function checkForm(pId){
	if(pId==3){
		var product_name = document.getElementsByName("product_name");
		if(product_name.length==1){
			alert("您没有添加产品！");return false;
		}
		return true;
	}else if(pId==5){
		var product_name = document.getElementsByName("product_name1");
		if(product_name.length==1){
			alert("您没有添加产品！");return false;
		}
		return true;
	}
}
//帐单帐单
function deleteApply(orderId,proId){
	if(confirm("是否确认该操作？")){
	window.location.href="../../stock_product_comeoutProAction.do?m=delNum&id="+orderId+"&proId="+proId;
	}
}
</script>

</head>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%="您正在做的业务是：库存管理--出库申请管理--出库申请变更"%></div></td>
 </tr>
 </table>
  <%
	nseer_db stock_db1 = new nseer_db((String) session.getAttribute("unit_db_name"));
	nseer_db stock_ttock = new nseer_db((String) session.getAttribute("unit_db_name"));
	int id = 0;
	id = Integer.parseInt(request.getParameter("order_id"));
	int proId = Integer.parseInt(request.getParameter("proId"));//原料入库类型

	String sql = "select * from stock_out_apply where id = " + id;

	ResultSet rs = stock_db.executeQuery(sql);

	if (rs.next()) {
%>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="POST" onsubmit="return checkForm(<%=proId %>)" action="register_reconfirm.jsp">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8">
 <%if(proId==3){ %>
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" id="add" onclick="productCheck()" value="<%=demo.getLang("erp","添加产品")%>">&nbsp;
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="delSelect()" value="<%=demo.getLang("erp","删除产品")%>">&nbsp;
 <input type="submit" <%=BUTTON_STYLE1%> onclick="changeDetail(<%=id %>)" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="deleteApply(<%=id %>,<%=proId %>)" value="<%=demo.getLang("erp","删除")%>">
 <%} if(proId==5){ %>
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" id="add" onclick="productCheck1()" value="<%=demo.getLang("erp","添加产品")%>">&nbsp;
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="delSelect1()" value="<%=demo.getLang("erp","删除产品")%>">
 <input type="submit" <%=BUTTON_STYLE1%> onclick="change(<%=id %>)" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交")%>"><%} %>&nbsp;
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="javascript:window.history.back()" value="<%=demo.getLang("erp","返回")%>">&nbsp;
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
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","出库申请单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp","出库申请单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align:left"><input type="text" readonly="readonly" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="gatherer_name" value="<%=rs.getString("apply_out_id") %>"></td>
  </td>
  </tr>
  <tr>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%">出库人：</td><td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align:left"><input type="text" readonly="readonly" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="gatherer_name" value="<%=rs.getString("apply_out_operator") %>"></td>
  <%
		if (proId == 3) {
		%>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="11%">出库申请理由：</td>
		<td><input type="text" <%=INPUT_STYLE3%> readonly="readonly"
			class="INPUT_STYLE3" name="gatherer_name" value="生产出库" /></td>
		<%
		}
		%>
		<%
		if (proId == 5) {
		%>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="11%">出库理由：</td>
		<td><input type="text" <%=INPUT_STYLE3%> readonly="readonly"
			class="INPUT_STYLE3" name="gatherer_name" value="成品出库" /></td>
		<%
		}
		%>
  </tr>
	
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>

<%if(proId==3){ %>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" cols=1 id=tableOnlineEdit1 style="text-align: center">
<thead>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","点选")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","原纸规格")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","LOT No.")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","Invoice No.")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","宽度（mm）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","长度（m）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","重量（kgs）")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","库位")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox" id=checkLine></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name" type="text" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID" type="text" onFocus="this.blur()" /></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_describe_ok" type="text" onFocus="this.blur()" ></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount" type="text"  onFocus="this.blur()" ></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unit" type="text" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_price" type="text" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">
 <input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="depot1" type="text"  onFocus="this.blur()">
 <input type="hidden" name="productId" />
 </td>
 </tr>
 <%
				String sql_t = "select * from stock_out_apply_detail inner join product_info on product_info.id = stock_out_apply_detail.Out_Detail_product_id  where apply_out_id='"
				+ rs.getString("id") + "'";
				ResultSet rs45 = stock_db1.executeQuery(sql_t);
				while (rs45.next()) {
	%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox" id=checkLine></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> value="<%=rs45.getString("out_Detail_spec") %>" class="INPUT_STYLE4" name="product_name" type="text" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" value="<%=rs45.getString("product_info.product_lot_no") %>" name="product_ID" type="text" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> value="<%=rs45.getString("out_Detail_invoice_no")%>" class="INPUT_STYLE4" name="product_describe_ok" type="text" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> value="<%=rs45.getString("out_Detail_width") %>" class="INPUT_STYLE4" name="amount" type="text" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unit" value="<%=rs45.getString("out_Detail_length") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_price" type="text" onFocus="this.blur()" value="<%=rs45.getString("out_Detail_weight") %>"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> value="<%=rs45.getString("product_info.product_stock") %>" class="INPUT_STYLE4" name="depot1" type="text" onFocus="this.blur()"></td>
</tr>
<%
	}
	%>
</thead>
</table>
<%} %>

<%if(proId==5){ %>

<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" cols=1 id=tableOnlineEdit
	style="text-align: center">
	<thead>
		<tr <%=TR_STYLE2%> class="TR_STYLE2">
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","点选")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "原纸规格")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp", "规格")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "栈板号")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp", "托盘")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp", "数量（卷）")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp", "净重（kgs）")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "客户")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "库位")%></td>
		</tr>
		<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
		 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox1" id=checkLine1></td>
		 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name1" type="text" onFocus="this.blur()"></td>
		 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID1" type="text" onFocus="this.blur()"></td>
		 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_describe_ok1" type="text"></td>
		 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount1" type="text"></td>
		 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unit1" onFocus="this.blur()"></td>
		 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_price1" type="text" onFocus="this.blur()"></td>
		 <td <%=TD_STYLE2%> class="TD_STYLE2">
		 <input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_person1" type="text" onFocus="this.blur()" >
		  <input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_personId" type="hidden" onFocus="this.blur()" >
		  <input type="hidden" name="proId" />
		 </td>
		 <td <%=TD_STYLE2%> class="TD_STYLE2">
		 <input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_dopet1" type="text" onFocus="this.blur()" >
		 </td>
	 </tr>
		<%
					String sql_t = "select * from stock_out_apply_detail inner join package_info on package_info.id = stock_out_apply_detail.Out_Detail_product_id  where apply_out_id='"+ rs.getString("id") + "'";
					ResultSet rs45 = stock_db1.executeQuery(sql_t);
					while (rs45.next()) {
				String sql14 = "select CUSTOMER_NAME from crm_file where id="
						+ rs45.getString("out_Detail_custom_id");
				ResultSet rs14 = stock_ttock.executeQuery(sql14);
				String custem = "";
				if (rs14.next()) {
					custem = rs14.getString("CUSTOMER_NAME");
				}
		%>
		<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox1" id=checkLine1></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> value="<%=rs45.getString("package_info.product_spec") %>" class="INPUT_STYLE4" name="product_name1" type="text" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" value="<%=rs45.getString("package_info.mold_spec") %>" name="product_ID1" type="text" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> value="<%=rs45.getString("package_info.package_pallet")%>" class="INPUT_STYLE4" name="product_describe_ok1" type="text" onFocus="this.blur()"></span><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" value="" name="product_describe" type="hidden" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> value="<%=rs45.getString("out_Detail_pallect")%>" class="INPUT_STYLE4" name="amount1" type="text" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unit1" value="<%=rs45.getString("out_Detail_pallect_count")%>" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_price1" type="text" onFocus="this.blur()" value="<%=rs45.getString("out_Detail_weight")%>"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_person1" type="text" onFocus="this.blur()" value="<%=custem%>"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_dopet1" type="text" onFocus="this.blur()" value="<%=rs45.getString("package_info.package_stock")%>"></td>
		</tr>
		<%
		}
		%>
	</thead>
</table>
<%} %>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE4%> class="TABLE_STYLE4">

 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp","备注")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark" style="background-color:#FFFFCC" ><%=rs.getString("apply_out_remark") %></textarea>
</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
String loginTime = rs.getString("apply_out_register_time");
loginTime = loginTime.substring(0,10);
%>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp","登记人")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align:left"><input type="text" readonly="readonly" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=rs.getString("apply_out_register")%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align:left">
 <input type="text" <%=INPUT_STYLE3%> readonly="readonly" class="INPUT_STYLE3" name="gatherer_name"  value="<%=loginTime%>" />
</td>
 </tr>
 <%if(rs.getString("apply_out_check_status").equals("2")){ %>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">

 <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp","审核人")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align:left"><input type="text" <%=INPUT_STYLE3%> readonly="readonly" class="INPUT_STYLE3" name="register" value="<%=rs.getString("apply_out_checker")%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align:left">
 <input name="register_time" type="hidden" value="<%=exchange.toHtml(time)%>">
  <input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="gatherer_name" readonly="readonly" value="<%=rs.getString("apply_out_check_time") %>" />
 </td>
 </tr>
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp","未通过理由")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark1" readonly="readonly"><%=rs.getString("autding_remark") %></textarea>
</td>
 </tr>
<%} %>
 </table>
  <%
	}
	stock_db1.close();
	stock_db.close();
	stock_ttock.close();
%>
<%@include file="../include/paper_bottom.html"%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 </form>
 </div>
 <script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
<script type="text/javascript">
document.body.onunload=function(){
	if(openWin!=null){
		openWin.close();
	}
}
</script>