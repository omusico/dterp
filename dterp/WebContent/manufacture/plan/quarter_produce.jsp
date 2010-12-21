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
	import="java.sql.*" import="java.util.*" import="java.io.*"
	import="include.nseer_db.*,java.text.*,include.nseer_cookie.exchange"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%
			nseer_db stock_db = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<%@include file="../include/head.jsp"%>
<%@page import="org.apache.axis.session.Session"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<%
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：",
			"document_main", "reason", "value");
%>
<head>
<LINK href="../../javascript/table/onlineEditTable.css" type=text/css
	rel=stylesheet>
<script language="javascript" src="../../javascript/edit/editTable.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenn.js"></script>
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<style type="">
	#tableOnlineEdit1{ text-align: center;}
</style>

<script>

function Check(v){
var un = v.value;
	if(un=="2"){
		document.getElementById("div1").style.display="block";
		  document.getElementById("div2").style.display="none";
	}else if(un=="4"){
		 
		   document.getElementById("div1").style.display="none";
		  document.getElementById("div2").style.display="block";
	}
}
//功能：判断是成品还是原料进行跳转不同的页面
var openWin=null;
function productCheck(){
document.getElementById("add").disabled="disabled";
 var d = document.getElementById("reason").value;
 var p_t= document.getElementById("product_type").value;

if(openWin==null){
	winopen("newRegister_product_list.jsp?p_t="+p_t,"","left=250 top = 100 width = 1000 height = 550");
}else{
	openWin.focus();
}
}
//删除选中的产品
function delSelect(){
var checkboxs = document.getElementsByName("checkbox");
var table;
//alert(document.getElementById("div1").style.display);
if(document.getElementById("div1").style.display=="none"){
	table = document.getElementById("tableOnlineEdit");
}else{
	table = document.getElementById("tableOnlineEdit1");
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
//字符串去空格
String.prototype.Trim = function()
{
return this.replace(/(^\s*)|(\s*$)/g, "");
}

String.prototype.LTrim = function()
{
return this.replace(/(^\s*)/g, "");
}

String.prototype.RTrim = function()
{
return this.replace(/(\s*$)/g, "");
}
//表单验证
function checkForm(){

var flag=true;

var plan_maker=document.getElementById("plan_maker").value;

var plan_id=document.getElementById("plan_id").value;
var names=document.getElementsByName("product_name");
var plan_make_time=document.getElementById("plan_make_time").value;
if(plan_maker.Trim()==""){
	alert("请输入制定人！");
	flag=false;
}else if(plan_id.Trim()==""){
	alert("请输入NO号！");
	flag=false;
}else if(plan_make_time.Trim()==""){
	alert("请选择制订日期！");
	flag=false;
}else if(names.length==1){
	alert("请选择添加商品！");
	flag=false;
}else{
	//原纸数量输入验证 
	var nums=document.getElementsByName("product_describe_ok");
	var m_nums=document.getElementsByName("product_ID");
	var reg_int=/^[1-9]\d*$/;
	for(var i=0;i<nums.length;i++){
		if(!reg_int.test(nums[i].value))
		{
			alert("原纸数量必须是大于0的数字！");
			flag=false;
			break;
		}  
	}
}
return flag;
}
</script>
<script language="javascript">
//计划NO重复验证
 var XMLHttpReq = false;
  //创建XMLHttpRequest对象       
    function createXMLHttpRequest() {
  if(window.XMLHttpRequest) { //Mozilla 浏览器
   XMLHttpReq = new XMLHttpRequest();
  }
  else if (window.ActiveXObject) { // IE浏览器
   XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
  }
 }
 //发送请求函数
 function sendRequest(url) {
  createXMLHttpRequest();
  XMLHttpReq.open("GET", url, true);
  XMLHttpReq.onreadystatechange = processResponse;//指定响应函数
  XMLHttpReq.send(null);  // 发送请求
 }
 // 处理返回信息函数
    function processResponse() {
     //document.getElementById("message").innerHTML="<image src="">";
     if (XMLHttpReq.readyState == 4) { // 判断对象状态
     	//window.alert(XMLHttpReq.status);
         if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息
             var res=XMLHttpReq.responseXML.getElementsByTagName("res")[0].firstChild.data;
                //document.getElementById("message").innerHTML=res;
            	  
            	if(res!="true"){
                window.alert(res);
                mutiValidation.plan_id.value="";
                }
            } else { //页面不正常
                window.alert("您所请求的页面有异常。");
            }
        }
    }
 // 身份验证函数
function userCheck() {
  var uname = mutiValidation.plan_id.value;
	if(uname.length>0){
   sendRequest('../../manufacture_plan_ValidatePlanNo?uname='+ uname );
   }
  
}

</script> 
</head>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript'
	src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript"
	src="../../javascript/include/validate/validation-framework.js"></script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="POST" action="../../manufacture_plan_ActionPlan.do" onsubmit="return checkForm()">
<table width="100%" cellpadding="0" cellspacing="0">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td style="text-align: right;">
		<%-- 添加产品参数：1-4分切，2-8mm切，3-打孔 --%>
		<input type="hidden" name="product_type" value="1"> &nbsp;&nbsp;
		<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" id="add" onclick="productCheck()" value="<%=demo.getLang("erp","添加产品")%>">&nbsp;
		<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="delSelect()" value="<%=demo.getLang("erp","删除产品")%>">&nbsp;
		<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>"></td>
	</tr>
	<tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
</table>
<%
	String register = (String) session.getAttribute("realeditorc");
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	String time = formatter.format(now);
	String gather_ID = request.getParameter("gather_ID");
	String new_apply = "0";
	if (gather_ID == null) {
		new_apply = "1";
		gather_ID = "";
	}
	String no_type="";//分类编号
	//根据分类值查找分类编号
	String sql_no_type="select no_type,no_value from option_no where no_value='SC05'";
	
	ResultSet rs_no_type=stock_db.executeQuery(sql_no_type);
	if(rs_no_type.next()){
		no_type=rs_no_type.getString("no_type");
	}
	
	
%>
<%-- 生产计划类型 1-4分切生产计划，2-8mm切，3-打孔--%>
<input type="hidden" name="plan_type" value="1">
<input type="hidden" name="m" value="add"><%-- action中方法 --%>
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<input type="hidden" name="plan_no" value="<%=no_type %>">
	<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "编号")%>：</td>
	<td align=left class="TD_STYLE2" width="40%">
	  <%=demo.getLang("erp",no_type)%></td>
	<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%">&nbsp;</td>
	<td align=left class="TD_STYLE2" width="40%">&nbsp;</td>
		
</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp", "4分切生产计划")%></b></font></td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "制定人")%>：</td>
		<td align=left class="TD_STYLE2" width="40%">
		<input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="plan_maker" style="width: 150"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "加工日期")%>：</td>
		<td align=left class="TD_STYLE2" width="40%">
		<input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="date_start" name="plan_make_time" style="width: 150">
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td>
		<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
			<tr <%=TR_STYLE1%> class="TR_STYLE1">
				<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "NO.")%>：</td>
		<td align=left class="TD_STYLE2" width="40%">
		  <input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="plan_id" style="width: 150" ></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "班次")%>：</td>
		<td align=left class="TD_STYLE2" width="40%">
		  <input type="hidden" name="reason" value="2"><%-- productCheck方法使用的参数 --%>
		  <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="plan_class" style="width: 150">
			<option value="<%=exchange.toHtml("1")%>"><%=exchange.toHtml("早")%></option>
			<option value="<%=exchange.toHtml("2")%>"><%=exchange.toHtml("中")%></option>
			<option value="<%=exchange.toHtml("3")%>"><%=exchange.toHtml("夜")%></option>
		</select></td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>

<div id="div1" style="display: block;">
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" cols=1 id=tableOnlineEdit1
	style="text-align: center">
	<thead>
		<tr <%=TR_STYLE2%> class="TR_STYLE2" style="text-align: center;">
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp", "点选")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "原纸规格")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp", "库存数量（本）")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "计划数量（本）")%></td>
		</tr>
		<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox" id=checkLine></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<%-- 显示原纸规格 --%>
			<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name" type="text" onFocus="this.blur()">
			
			</td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<%-- 显示库存数量 --%>
			<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID" type="text" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<%-- 输入原纸数量 --%>
			<input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_describe_ok" type="text" value="1">
			<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_describe" type="hidden" >
			</td>
			<%-- 
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount" type="text" value="21"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE5" name="amount_unit"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="cost_price" type="text" value="1"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="" type="text" value="21"></td>
			--%>
			<input name="product_spec_id" type="hidden" value="">
		</tr>
	</thead>
</table>
</div>

<div id="div2" style="display: none;">
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" cols=1 id=tableOnlineEdit align="center">
	<thead>
		<tr <%=TR_STYLE2%> class="TR_STYLE2">
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp", "点选")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "原纸规格")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp", "库存数量")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "原纸数量（本）")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp", "托盘")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp", "数量（卷）")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp", "净重（kg）")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "客户")%></td>
		</tr>
		<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox1" id=checkLine1></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name1" type="text" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID1" type="text" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<span name="product_describe_ok" style="width:120px;background:#ffffff"></span>
			<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_describe2" type="hidden" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount1" type="text" value="21"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unit1" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_price1" type="text" onFocus="this.blur()" value="1"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"></td>
		</tr>
	</thead>
</table>
</div>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<TABLE <%=TABLE_STYLE4%> class="TABLE_STYLE4">

	
	
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%"><textarea
			<%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="plan_remark"></textarea>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "登记人")%>&nbsp;&nbsp;：</td>
		<td align=left class="TD_STYLE2" width="40%">
		  <input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" style="width: 150" name="plan_register" value="<%=exchange.toHtml(register)%>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "登记时间")%>：</td>
		<td align=left class="TD_STYLE2" width="40%">
		  <input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" style="width: 150;" name="plan_register_time" id="" value="<%=exchange.toHtml(time.substring(0,10))%>" onFocus="this.blur()">
		</td>
	</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>"
	value="<%=session.getAttribute(Globals.TOKEN_KEY)%>"></form>
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
