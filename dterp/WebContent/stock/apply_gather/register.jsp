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

<link rel="stylesheet" type="text/css" media="all" href="../../javascript/input_control/focus1.css">
	
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<style type="">
	#tableOnlineEdit1{ text-align: center;}
</style>
<script>


//功能：判断是成品还是原料进行跳转不同的页面
var openWin=null;
function productCheck(){
document.getElementById("add").disabled="disabled";
 
if(openWin==null){
var d = document.getElementById("reason").value;
if(d=="4"){
 	openWin=window.open("register_product_list.jsp","","left=250 top = 100 width = 1000 height = 550");
 }else if(d=="2"){
 	openWin=window.open("register_product_list1.jsp","","left=250 top = 100 width = 550 height = 550");
 }
}else{
	openWin.focus();
}
}
function Check(v){
if(openWin!=null){
openWin.close();
}
var un = v.value;
	if(un=="2"){
		document.getElementById("div1").style.display="block";
		document.getElementById("div2").style.display="none";
		window.location.href="register.jsp";
	}else if(un=="4"){
		document.getElementById("bian1").innerHTML="&nbsp;编号：QR/DT-YW-07";
		document.getElementById("div1").style.display="none";
		document.getElementById("div2").style.display="block";
		document.forms[0].action="../../stock_product_registerAction.do?m=addSuccess";  
	}
}
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
	openWin=window.open('newRegister_crm_list.jsp?tag='+tag_1,"","left=250 top = 100 width = 550 height = 550");
}else{
	openWin.focus();
}
 	
}

//删除选中的产品
function delSelect(){
var checkboxs;
var table;
if(document.getElementById("div1").style.display=="none"){
	table = document.getElementById("tableOnlineEdit");
	checkboxs = document.getElementsByName("checkbox1");
}else{
	table = document.getElementById("tableOnlineEdit1");
	checkboxs = document.getElementsByName("checkbox");
}
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
function removeTr(obj){
 var sTr = obj.parentNode.parentNode;
 sTr.parentNode.removeChild(sTr);
}

//完成复制功能
function addOrderRow(tab,obj) { 
var detailbody=document.getElementById(tab); 
var row = detailbody.insertRow(); 
row.className="TR_STYLE1";
row.borderColor="#DEDBD6";
	for(var i=0;i<obj.parentNode.parentNode.childNodes.length;i++){ 
	var cell=row.insertCell();  
	cell.className="TD_STYLE2";
	cell.innerHTML=obj.parentNode.parentNode.childNodes[i].innerHTML; 
	} 

}
//表单验证 
function checkForm(){
	var lcomOutName = document.getElementById("gatherer_name").value;//出库人
	var loginName = document.getElementById("loginName").value;//登记人
	var loginTime = document.getElementById("date_sta").value;//登记时间
	if(lcomOutName.length==0){
		alert("经办人不能为空！");
		return false;
	}
	var audting = document.getElementById("selectLogin").value;//出库理由
	if(audting==2){
		var product_name = document.getElementsByName("product_ID");
		if(product_name.length==1){
			alert("您没有添加产品！");
			return false;
		}else if(product_name.length>=2){
		for(var q=1;q<product_name.length;q++){
			if(product_name[q].value==""){
				alert("第"+q+"行，请输入LotNo号！");return false;
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
		//从数据库读取LOTNO与读取数据进行对比
		String sql = "select product_lot_no from product_info";
		ResultSet rs=stock_db.executeQuery(sql);
		while(rs.next()){
			String lotNo = rs.getString("product_lot_no");
			%>
			for(var a = 1;a<product_name.length;a++){
				if(product_name[a].value=="<%=lotNo%>"){
					alert("第"+a+"行LotNo号已录入，请从新输入！");return false;
				}
			}
			<%
		}
		%>
	}else if(audting==4){
	var product_name = document.getElementsByName("product_name1");
		if(product_name.length==1){
			alert("您没有添加产品！");
			return false;
		}
	var adminPerson = document.getElementsByName("admin1");
	for(var i=1;i<adminPerson.length;i++){
		if(adminPerson[i].value=="单击选择客户"){
			alert("第"+i+"行请选择一个用户！");return false;
		}
	}
	}
	if(loginName.length==0){
		alert("登记人不能为空！");
		return false;
	} 
	if(loginTime.length==0){
		alert("登记时间不能为空！");
		return false;
	}
	return true;
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
</script> 
</head>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="POST" action="../../stock_product_registerAction.do?m=addYuan" onsubmit="return checkForm()">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="button" <%=BUTTON_STYLE1%> id="add" class="BUTTON_STYLE1" onclick="productCheck()" value="<%=demo.getLang("erp","添加产品")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="delSelect()" value="<%=demo.getLang("erp","删除产品")%>">&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>"></td>
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
 <td style="width:4%">&nbsp;</td>
 <td><div id="bian1" style="display: inline;"><%=demo.getLang("erp","&nbsp;编号")%>：QR/DT-YW-06</div>
 </td>
 </tr>
 </table>
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
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","经办人")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align: left">
 <input name="gatherer_name" id="gatherer_name" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " />
 </td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","入库申请理由")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align: left"><select id="selectLogin" name="reason" onchange="Check(this)" style="width:150px">
  <%
  String sql5 = "select * from stock_config_public_char where describe1='出入库理由' and id=2 or id=4 order by id" ;
	 ResultSet rs5 = stock_db.executeQuery(sql5) ;
while(rs5.next()){%>
		<option value="<%=exchange.toHtml(rs5.getString("id"))%>"><%=exchange.toHtml(rs5.getString("stock_name"))%></option>
<%
}
stock_db.close();
%>

  </select></td>
  </tr>
	
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>

<div id="div1"  style="display: block;">
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" cols=1 id=tableOnlineEdit1>
<thead  id="detailItemBody">
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
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="cost_price" type="text" onblur="blurCheck(this)"  value=""></td>
  <td <%=TD_STYLE2%> class="TD_STYLE2">
 <input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="fault_number" type="text" value="">
 </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">
 <input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_describe" type="text" value="">
 </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><image src="images/bt_orders.gif" alt="复制" hieght="15px"  onclick="addOrderRow('tableOnlineEdit1',this)" /></td>
 </tr>
</thead>
</table>
</div>

<div id="div2" style="display: none;">
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
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name1" type="text" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID1" type="text" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_describe_ok" type="text" onFocus="this.blur()"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="tuoPan1" type="text" onFocus="this.blur()" ></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="count1" type="text" onblur="lengCheck(this)" onFocus="this.blur()" ></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="weight1" type="text"  onblur="blurCheck(this)" ></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">
 <input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="admin1" type="text" onFocus="this.blur()" >
			<input name="proId" type="hidden" />
 </td>
 </tr>
</thead>
</table>
</div>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE4%> class="TABLE_STYLE4"  bordercolor=#25CB0E bordercolorlight=#000000 bordercolordark=#000000 border=0 cellspacing=1 cellpadding=1 align=center >
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","备注")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%" valign=top bgcolor=#ffffff bordercolor=#000000 >
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark" style="background-color:#FFFFCC" ></textarea>
</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记人")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align: left"><input readonly="readonly" type="text" id="loginName" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " name="register" value="<%=exchange.toHtml(register)%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align: left">
 <input type="text" readonly="readonly" id="date_sta" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " value="<%=exchange.toHtml(time.substring(0,10))%>" name="register">
</td>
 </tr>
 </table>
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