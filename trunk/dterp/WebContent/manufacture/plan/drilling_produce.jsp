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
//客户选择
var openWin3;
function crmSelect(te)
{
	
	
	//打开客户选择页面
	if(openWin3==null){
	var p_t= document.getElementById("product_type").value;
	//使用当前时间随机生成当前行的id
	var myDate = new Date();
	
	var tag_1=myDate.getHours()+"_"+myDate.getMinutes()+"_"+myDate.getSeconds()+"_"+myDate.getMilliseconds();
	 
	
	//获得当前行
	var n_row=te.parentNode.parentNode;
	
	if(n_row.tagName.toLowerCase() =="tr"){
	  n_row.id=tag_1;//修改当前行id
	  
	}
	openWin3=winopen("newRegister_crm_list.jsp?p_t="+p_t+"&tag="+tag_1,"","left=250 top = 100 width = 1000 height = 550");
	}else{
	openWin3.focus();
	}
 	
}
//模具选择
var openWin2;
function moldSelect(te)
{
	
	
	//打开模具选择页面
if(openWin2==null){
	//使用当前时间随机生成当前行的id
	var myDate = new Date();
	var tag_1=myDate.getHours()+"_"+myDate.getMinutes()+"_"+myDate.getSeconds()+"_"+myDate.getMilliseconds();
	
	//获得当前行
	var n_row=te.parentNode.parentNode;
	
	if(n_row.tagName.toLowerCase() =="tr"){
	  n_row.id=tag_1;//修改当前行id
	  
	}
	winopen("newRegister_mold_list.jsp?tag="+tag_1,"","left=250 top = 100 width = 1000 height = 550");
}else{
	
	openWin2.focus();
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
//相同纸类型的不同模具类型判断
function validateMold(){
	var product_spec_ids=document.getElementsByName("product_spec_id");//
	//alert(product_spec_ids.length);  
	var mold_ids=document.getElementsByName("mold_id");//
	var pms = new Array();
	for(var i=0;i<product_spec_ids.length;i++ ){
		pms[i]=product_spec_ids[i].value+"_"+mold_ids[i].value;//构成“纸类型id_模具类型id”数组
		//alert(pms[i]);
	}
	var flag=true;
	if(pms.length>1){
		for(var o=0;o<pms.length;o++ ){
			var pms_now=pms[o];
			
			for(var y=o+1;y<pms.length;y++){
				//alert(pms_now+"   "+pms[y]);
				if(pms_now==pms[y]){//存在相同的组合，跳出循环
					flag=false;
					//alert(flag);
					break;
				}
			}
			if(!flag){
			break;
			}
		}
	}
	return flag;
}


//表单验证
function validateForm(){

//验证
var objTable=document.getElementById("tableOnlineEdit1");
 var tbodyOnlineEdit=objTable.getElementsByTagName("TBODY")[0];
 for (var i=tbodyOnlineEdit.children.length-1; i>=0 ; i-- ){
   var temp=tbodyOnlineEdit.children[i].childNodes[4].childNodes[0].value;
   //alert(temp);
   //alert(unique+":"+temp);
   if(temp=="选择模具类型"||temp=="")
   {
   		alert("请选择模具类型"); 
   		return false;
   }
   var temp1=tbodyOnlineEdit.children[i].childNodes[7].childNodes[0].value;
   if(temp1=="选择客户")
   {
   		alert("请选择客户"); 
   		return false;
   }
   
   
}
	if(!validateMold()){
	   alert("相同的纸规格不可以使用相同的模具类型"); 
	   return false;
   }
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
var nums=document.getElementsByName("product_describe2");
var reg_int=/^\d+$/;
for(var i=0;i<nums.length;i++){
	
	if(!reg_int.test(nums[i].value))
	{
		
		alert("计划设备数量必须是大于0的数字！");
		flag=false;
		break;
		
	}
}
var nums_1=document.getElementsByName("amount");

for(var i=0;i<nums_1.length;i++){
	
	if(!reg_int.test(nums_1[i].value))
	{
		alert("生产数量必须是大于0的数字！");
		flag=false;
		break;
	}
}

var crms=document.getElementsByName("plan_package_client");
for(var i=0;i<crms.length;i++){

	if(crms[i].value=="0"){
		alert("请选择客户！");
		flag=false;
		break;
	}
}
var molds=document.getElementsByName("mold_id");
for(var i=0;i<molds.length;i++){
	if(molds[i].value=="0"){
		alert("请选择模具！");
		flag=false;
	}
}
}
return flag;
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
<form id="mutiValidation" method="POST" action="../../manufacture_plan_ActionPlan.do" onsubmit="return validateForm()">
<table width="100%" cellpadding="0" cellspacing="0">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8">
		<%-- 添加产品参数：1-4分切，2-8mm切，3-打孔 --%>
		<input type="hidden" name="product_type" value="3"> 
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
	String sql_no_type="select no_type,no_value from option_no where no_value='SC04'";
	
	ResultSet rs_no_type=stock_db.executeQuery(sql_no_type);
	if(rs_no_type.next()){
		no_type=rs_no_type.getString("no_type");
	}
%> 
<%-- 生产计划类型 1-4分切生产计划，2-8mm切，3-打孔--%>
<input type="hidden" name="plan_type" value="3">
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
		<td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp", "打孔生产计划")%></b></font></td>
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
			<%--
				String sql5 = "select * from stock_config_public_char where describe1='出入库理由' and id=2 or id=4 order by id";
				ResultSet rs5 = stock_db.executeQuery(sql5);
				while (rs5.next()) {
			--%>
			<option value="<%=exchange.toHtml("1")%>"><%=exchange.toHtml("早")%></option>
			<option value="<%=exchange.toHtml("2")%>"><%=exchange.toHtml("中")%></option>
			<option value="<%=exchange.toHtml("3")%>"><%=exchange.toHtml("夜")%></option>
			<%--
				}
				stock_db.close();
			--%>

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
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "原料数量（卷）")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp", "模具类型")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "计划设备数")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "生产数量（卷）")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "客户")%></td>
		</tr>
		<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox" id=checkLine></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<%-- 显示原纸规格 --%>
			<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name" type="text" onFocus="this.blur()"></td>
			<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_spec_id" type="hidden" >
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<%-- 显示原料数量？？？ --%>
			<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_price" type="text" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<%-- 输入模具类型 --%>
			<input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_ID" type="text" onclick="moldSelect(this)">
			<input name="mold_id" type="hidden" ></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<%-- 输入计划设备数 --%>
			<input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_describe2" type="text" value="1">
			<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_describe" type="hidden" >
			</td>
			<%-- 输入生产数量 --%>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount" type="text" value="1"></td>
			<%-- 输入客户 --%>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount_unit" onclick="crmSelect(this)">
			<input name="plan_package_client" type="hidden">
			</td>
			<%-- 
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="cost_price" type="text" value="1"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="" type="text" value="21"></td>
			--%>
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
		  <input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="plan_register" style="width: 150" value="<%=exchange.toHtml(register)%>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "登记时间")%>：</td>
		<td align=left class="TD_STYLE2" width="40%">
		  <input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="plan_register_time" style="width: 150" id="" value="<%=exchange.toHtml(time.substring(0,10))%>" onFocus="this.blur()">
		</td>
	</tr>
</table>
<%
stock_db.close();
%>
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