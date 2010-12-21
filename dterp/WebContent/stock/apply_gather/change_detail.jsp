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
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db_backup1 stock_db1 = new nseer_db_backup1(application);// baseDao通用组件，里面封闭有对数据库操作的方法
nseer_db stock_ttock = new nseer_db((String) session.getAttribute("unit_db_name"));
nseer_db stock_tock = new nseer_db((String) session.getAttribute("unit_db_name"));
%>
<%@include file="../include/head.jsp"%>
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
<%	int id = 0;
id = Integer.parseInt(request.getParameter("id")); %>
<script type="text/javascript">

function removeTr(obj) {
 var sTr = obj.parentNode.parentNode;
 sTr.parentNode.removeChild(sTr);
}
</script>

<script>

function productCheck(){

	var rad = document.getElementById("radio").checked;
	window.location.href="check_list_auditing_radio.jsp?flag="+rad;

}

function changeDetail(avg,proId){
	if(proId==2)
	document.forms[0].action="../../stock_product_registerAction.do?m=changeDetail&id="+avg+"&proId"+proId;
	if(proId==4)
	document.forms[0].action="../../stock_product_registerAction.do?m=change&id="+avg+"&proId"+proId;
}
//删除选中的产品
function delSelect(){
var checkboxs;
var table;
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
 for (var i=0; i<checkboxs.length; i++){
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
//删除选中的产品
function delSelect1(){
var checkboxs;
var table;
table = document.getElementById("tableOnlineEdit");
checkboxs = document.getElementsByName("checkbox1");

var tr = table.getElementsByTagName("tr");
 for (var i=0; i<checkboxs.length; i++){
 if(tr.length==2){
 checkboxs[i].checked = false;
 return;
 }
 if(checkboxs[i].checked==true){
 removeTr(checkboxs[i]);
 i=-1;
 }
 }
}
var openWin=null;
//客户选择
function crmSelect(te)
{
	
	//使用当前时间作为当前行的id
	var myDate = new Date();
	var tag_1=myDate.getFullYear()+myDate.getMonth()+myDate.getDate()+myDate.getHours()+myDate.getMinutes()+myDate.getSeconds()+myDate.getMilliseconds(); 
	
	//获得当前行
	var n_row=te.parentNode.parentNode;
	
	if(n_row.tagName.toLowerCase() =="tr"){
	  n_row.id=tag_1;//修改当前行id
	  
	}
	//打开客户选择页面
 	
if(openWin==null){
	openWin=window.open('newRegister_crm_list1.jsp?tag='+tag_1,"","left=250 top = 100 width = 550 height = 550");
}else{
	openWin.focus();
}
}

function windowOpenCheck1(){
document.getElementById("add").disabled="disabled";
if(openWin==null){
	openWin=window.open("register_product_list_show1.jsp","","left=250 top = 100 width = 550 height = 550");
}else{
	openWin.focus();
}
 	
}
function windowOpenCheck2(){
document.getElementById("add").disabled="disabled";
if(openWin==null){
	openWin=window.open("register_product_list_show2.jsp","","left=250 top = 100 width = 1000 height = 550");
}else{
	openWin.focus();
}
	
}
//失去焦点
function blurCheck(age){ 
	if(isNaN(age.value)){
		alert("您输入的不是数字！");
		age.value="";
		age.focus();
	}else{
		if(age.value.length==0){
		age.value="0.00";
		}
		if(age.value.indexOf('.')>0){
		}else{
		age.value=age.value+".00";
		}
	}
}
//失去焦点长度
function lengCheck(age){
	if(isNaN(age.value)){
		alert("您输入的不是数字！");
		age.value="";
		age.focus();
	}else{
		if(age.value.length==0){
		age.value="0";
		}
	}
}
//表单验证
function checkForm(ag){
	if(ag==2){
		var product_name = document.getElementsByName("product_ID");
		if(product_name.length==1){
			alert("您没有添加产品");return false;
		}else if(product_name.length>=2){
			for(var i=1;i<product_name.length;i++){
				if(product_name[i].value.length==0){
					alert("第"+i+"行请输入LotNo号！");
					return false;
				}
			}
			for(var q=1;q<product_name.length;q++){
			if(product_name[q].value==""){
				alert("第"+q+"行请输入LotNo号！");return false;
			}
			}
			for(var a = 1;a<product_name.length;a++){
			for(var k=a+1;k<product_name.length;k++){
				if(product_name[a].value==product_name[k].value)
				{alert("第"+a+"行与第"+k+"行LotNo号重复，请从新输入！");return false;}
			}
		}
		}
	<% 
		String sqlLotCount = "select product_lot_no from stock_in_apply_detail right join product_info on product_info.id =stock_in_apply_detail.In_Detail_product_id  where apply_in_id!="+id;
		ResultSet rsLotCount=stock_tock.executeQuery(sqlLotCount);
		while(rsLotCount.next()){
			String lotNum = rsLotCount.getString(1);
			%>
			
			for(var i=1;i<product_name.length;i++){
				if(product_name[i].value=="<%=lotNum%>"){
					alert("第"+i+"行LotNo与现在数据重复，请重新输入！");return false;
				}
			}
			
		<%
		}
		%>
		
		
	}else if(ag==4){
		var product_name = document.getElementsByName("product_nameN");
		if(product_name.length==1){
			alert("您没有添加产品");return false;
		}else{
		for(var a = 0;a<product_name.length;a++){
			for(var k=a+1;k<product_name.length;k++){
				if(product_name[a].value==product_name[k].value)
				{alert("栈板号重复，请从新输入！");return false;}
			}
		}
		var adminPerson = document.getElementsByName("cost_priceN");
	for(var i=1;i<adminPerson.length;i++){
		if(adminPerson[i].value=="单击选择客户"){
			alert("第"+i+"行请选择一个用户！");return false;
		}
	}
		}
	}
}
//完成复制功能
function addOrderRow(tab,obj) { 
var detailbody=document.getElementById(tab); 
var row = detailbody.insertRow(); 
//row.className="TR_STYLE1";
row.borderColor="#DEDBD6";
	for(var i=0;i<obj.parentNode.parentNode.childNodes.length;i++){ 
	var cell=row.insertCell();  
	//cell.className="TD_STYLE2";
	cell.innerHTML=obj.parentNode.parentNode.childNodes[i].innerHTML; 
	} 

}
function delApply(orderId,numberId){
	//alert(orderId);alert(numberId);
	if(confirm("是否确认该操作？")){
	window.location.href="../../stock_product_registerAction.do?m=delNum&id="+orderId+"&numberId="+numberId;
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
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%="您正在做的业务是：库存管理--入库申请管理--入库申请变更"%></div></td>
 </tr>
 </table>
 <%

	int proId = Integer.parseInt(request.getParameter("proId"));//入库理由ID
	
	if(stock_db1.conn((String)session.getAttribute("unit_db_name"))){
	
	String sql = "select * from stock_in_apply where id = "+id;
	
	ResultSet rs = stock_db.executeQuery(sql);
	
	if(rs.next()){
	%>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="POST" onsubmit="return checkForm(<%=proId %>)">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8">

<%if(proId==2){ %><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" id="add" onclick="windowOpenCheck1()" value="<%=demo.getLang("erp","添加产品")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="delSelect()" value="<%=demo.getLang("erp","删除产品")%>">&nbsp;
<%}if(proId==4){ %><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" id="add" onclick="windowOpenCheck2()" value="<%=demo.getLang("erp","添加产品")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="delSelect1()" value="<%=demo.getLang("erp","删除产品")%>">&nbsp;<%} %><input type="submit" onclick="changeDetail(<%=id %>,<%=proId %>)"  <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="delApply(<%=id %>,<%=proId %>)" value="<%=demo.getLang("erp","删除")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="javascript:window.history.back()" value="<%=demo.getLang("erp","返回")%>">&nbsp;

 </td>
 </tr>
 </table>
 <%

String rester=(String)session.getAttribute("realeditorc");
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
 <%if(proId==2){ %>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td style="width:6%">&nbsp;</td>
 <td><div id="bian1" style="display: inline;"><%=demo.getLang("erp","&nbsp;编号")%>：QR/DT-YW-06</div>
 </td>
 </tr>
 </table>
<%}else if(proId==4){ %>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td style="width:6%">&nbsp;</td>
 <td><div id="bian1" style="display: inline;"><%=demo.getLang("erp","&nbsp;编号")%>：QR/DT-YW-07</div>
 </td>
 </tr>
 </table>
<%} %>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","入库申请单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 
 
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp","入库申请单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"  style="text-align: left"><%=rs.getString("apply_in_apply_code") %></td>
  </td>
  </tr>
  <tr>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%">经办人：</td><td >
  <input type="text" <%=INPUT_STYLE3%> readonly="readonly"  style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " value="<%=rs.getString("apply_in_apply_operator") %>"></td>
   
   <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%">入库申请理由：</td>
   <%if(proId==2){ %>
   <td><input type="text" readonly="readonly" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " name="gatherer_name"  value="原材料入库" /></td>
  <%}else if(proId==4){ %>
  <td><input type="text" readonly="readonly" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " name="gatherer_name"  value="成品入库" /></td>
  <%} %>
  </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>

<%if(proId==2){ %>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","欠点数")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","欠点内容说明")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="6%">操作</td>
 </tr>
 
 
 <tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox" id=checkLine></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name" type="text" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE5" name="product_ID" type="text" /></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_describe_ok" type="text" value="">
 </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount" onblur="blurCheck(this)" type="text" value=""></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE5" name="amount_unit" onblur="lengCheck(this)" ></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="cost_Weight" onblur="blurCheck(this)" type="text"  value=""></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">
 <input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="fault_number" type="text" value="">
 </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">
 <input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_describeN" type="text" value="">
 </td>
  <td <%=TD_STYLE2%> class="TD_STYLE2">
  <image src="images/bt_orders.gif" alt="复制" hieght="15px"  onclick="addOrderRow('tableOnlineEdit1',this)" /></td>
 </tr>
 
 <%
	sql = "select * from stock_in_apply_detail left join product_info on product_info.id=stock_in_apply_detail.In_Detail_product_id  where apply_in_id='"+rs.getString("id")+"'";
 	ResultSet rs45 = stock_db1.executeQuery(sql);
 	while(rs45.next()){
 %>
<tr <%=TR_STYLE1%> class="TR_STYLE1" >
<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox" id=checkLine></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> value="<%=rs45.getString("In_Detail_spec") %>" class="INPUT_STYLE4" name="product_name" type="text"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input  <%=INPUT_STYLE4%> class="INPUT_STYLE5"  value="<%=rs45.getString("product_lot_no") %>" name="product_ID" type="text"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">
 <input <%=INPUT_STYLE5%> class="INPUT_STYLE5" value="<%=rs45.getString("In_Detail_invoice_no") %>" name="product_describe_ok" type="text">
 </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input value="<%=rs45.getString("In_Detail_length") %>" onblur="blurCheck(this)" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount" type="text"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" onblur="lengCheck(this)" name="amount_unit" value="<%=rs45.getString("In_Detail_width") %>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="cost_Weight" onblur="blurCheck(this)" type="text" value="<%=rs45.getString("In_Detail_weight") %>"></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" value="<%=rs45.getString("In_Detail_fault_number") %>" name="fault_number" type="text"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" value="<%=rs45.getString("In_Detail_fault") %>" name="product_describeN" type="text"></td>
<td <%=TD_STYLE2%> class="TD_STYLE2">
<image src="images/bt_orders.gif" alt="复制" hieght="15px"  onclick="addOrderRow('tableOnlineEdit1',this)" />
</td>
 </tr>
 <% }%>
 </thead>
</table>
<%}else if(proId==4){ %>
 <table <%=TABLE_STYLE5%> class="TABLE_STYLE5" cols=1 id=tableOnlineEdit align="center">
<thead>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","点选")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","原纸规格")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","模具规格")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","栈板号")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","托盘")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","数量（卷）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","净重（kg）")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","客户")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox1" id=checkLine1></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="b_prodcu_name" type="text" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_IDN" type="text" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_nameN" type="text" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_count" type="text" onFocus="this.blur()" ></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unitN" type="text" onblur="lengCheck(this)" onFocus="this.blur()" ></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="cost_cost" type="text"   onblur="blurCheck(this)" ></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">
 <input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="cost_priceN"  type="text" onFocus="this.blur()" >
			<input name="crm_id" type="hidden" />
			<input name="proId" type="hidden" />
 </td>
 </tr>
		<%
					String sql_t = "select * from stock_in_apply_detail left join package_info on stock_in_apply_detail.In_Detail_product_id=package_info.id  where apply_in_id='"+ rs.getString("id") + "'";
					ResultSet rs45 = stock_db1.executeQuery(sql_t);
					while (rs45.next()) {
				String sql14 = "select * from crm_file where id="
						+ rs45.getString("In_Detail_custom_id");
				ResultSet rs14 = stock_ttock.executeQuery(sql14);
				String custem = "";
				if (rs14.next()) {
					custem = rs14.getString("CUSTOMER_NAME");
				}
				String spec = rs45.getString("package_info.mold_spec");

				String hl = rs45.getString("In_Detail_pal");

		%>
		<tr <%=TR_STYLE1%> class="TR_STYLE1">
		 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox1" id=checkLine1></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> value="<%=rs45.getString("package_info.product_spec") %>" class="INPUT_STYLE4" name="b_prodcu_name" type="text" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" value="<%=spec%>" name="product_IDN" type="text" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> value="<%=hl%>" class="INPUT_STYLE4" name="product_nameN" type="text" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> value="<%=rs45.getString("In_Detail_pallect")%>" class="INPUT_STYLE4" name="product_count" type="text" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unitN" onblur="lengthCheck(this)" value="<%=rs45.getString("In_Detail_pallect_count")%>"  onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5"  name="cost_cost" type="text" onblur="blurCheck(this)" value="<%=rs45.getString("In_Detail_weight")%>"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4"  name="cost_priceN" type="text" value="<%=custem%>"  onFocus="this.blur()">
				<input name="crm_id" type="hidden" /> <input name="proId" type="hidden" /></td>
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
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">

 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp","备注")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" style="background-color:#FFFFCC" name="remark"><%=rs.getString("apply_in_apply_remark") %></textarea>
</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">

 <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp","登记人")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align: left"><input type="text" readonly="readonly" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " name="register" value="<%=rs.getString("apply_in_apply_register") %>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp","登记时间")%>：
 <%String loginTime = rs.getString("apply_in_apply_register_time");
 	loginTime=loginTime.substring(0,10);
 %>
 </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align: left"><input name="register_time" type="hidden" value="<%=rs.getString("apply_in_apply_register_time") %>">
 <input type="text" readonly="readonly" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " name="gatherer_name"  value="<%=loginTime %>" />
</td>
 </tr>
 <%if(rs.getString("apply_in_apply_check_status").equals("2")){ %>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">

 <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp","审核人")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align: left"><input type="text" readonly="readonly" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " name="register" value="<%=session.getAttribute("realeditorc")%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align: left">
 <input name="register_time" type="hidden" value="<%="2010-01-10"%>">
  <input type="text" readonly="readonly" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " name="gatherer_name"  value="<%=time.substring(0,10) %>" />
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
	}}
	stock_db1.close();
	stock_db.close();
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