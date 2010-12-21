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
	import="java.sql.*,include.nseer_cookie.*" import="java.util.*"
	import="java.io.*" import="include.nseer_cookie.exchange"
	import="include.nseer_db.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@ taglib uri="/erp" prefix="FCK"%>
<script type="text/javascript" src="/erp/fckeditor.js"></script>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：",
			"document_main", "reason", "value");
%>
<%
			nseer_db manufacture_db = new nseer_db((String) session
			.getAttribute("unit_db_name"));
			nseer_db manufacturedb = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<jsp:useBean id="vt" scope="page" class="validata.ValidataTag" />
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<script type="text/javascript">
function checkForm(){
var flag=true;
return flag;
}


//下拉框函数
function changeSel(ab,k){

if(ab=="1"){
	var defect_no=document.getElementsByName("defect_no"+k);
	var product_4_start=document.getElementsByName("product_4_start"+k);
	var product_4_sharp=document.getElementsByName("product_4_sharp"+k);
	var product_4_size=document.getElementsByName("product_4_size"+k);
	var product_4_content=document.getElementsByName("product_4_content"+k);
	var product_4_content_other=document.getElementsByName("product_4_content_other"+k);
	
	if(defect_no[0].value=="0"){
		product_4_start[0].value = "";
		product_4_start[0].disabled = "disabled";
		product_4_start[0].className="INPUT_STYLE1";
		product_4_sharp[0].value = "";
		product_4_sharp[0].disabled = "disabled";
		product_4_sharp[0].className="INPUT_STYLE1";
		product_4_size[0].value = "";
		product_4_size[0].disabled = "disabled";
		product_4_size[0].className="INPUT_STYLE1";
		product_4_content[0].options[0].selected=true;
		product_4_content_other[0].value = "";
		product_4_content_other[0].disabled = "disabled";
		product_4_content_other[0].className="INPUT_STYLE1";
	}else{
		product_4_start[0].value = "";
		product_4_start[0].disabled = false;
		product_4_start[0].className="INPUT_STYLE5";
		product_4_sharp[0].value = "";
		product_4_sharp[0].disabled = false;
		product_4_sharp[0].className="INPUT_STYLE5";
		product_4_size[0].value = "";
		product_4_size[0].disabled = false;
		product_4_size[0].className="INPUT_STYLE5";
		product_4_content[0].options[0].selected=true;
		
		product_4_content_other[0].value = "";
		product_4_content_other[0].disabled = "disabled";
		product_4_content_other[0].className="INPUT_STYLE1";
	}
}else if(ab=="2"){
	var defect_no=document.getElementsByName("defect_no"+k);
	
	var product_4_content=document.getElementsByName("product_4_content"+k);
	var product_4_content_other=document.getElementsByName("product_4_content_other"+k);
	if(defect_no[0].value!="0"){
		if(product_4_content[0].value=="其他"){
			product_4_content_other[0].value = "";
			product_4_content_other[0].disabled = false;
			product_4_content_other[0].className="INPUT_STYLE5";
		}else{
			product_4_content_other[0].value = "";
			product_4_content_other[0].disabled = "disabled";
			product_4_content_other[0].className="INPUT_STYLE1";
		}
	}else{
		product_4_content_other[0].value = "";
		product_4_content_other[0].disabled = "disabled";
		product_4_content_other[0].className="INPUT_STYLE1";
	}
}
}

function checkSubmit(TFrom)
{

 ///alert("22");
 //alert(TFrom.product_8mm_temperature.value);
 if(TFrom.product_4_temperature.value=="")
 {
 	alert("请填写气温!");
 	return false;
 }
  if(TFrom.product_4_humidity.value=="")
 {
 	alert("请填写湿度!");
 	return false;
 }
  if(TFrom.product_4_operator.value=="")
 {
 	alert("请填写操作自检人!");
 	return false;
 	
 }
 var txt1 =TFrom.product_4_temperature.value;
     if(txt1.search("^-?\\d+$")!=0){
        alert("气温只能为数字!");
        return false;
    }
 var txt2 =TFrom.product_4_humidity.value;
     if(txt2.search("^-?\\d+$")!=0){
        alert("湿度只能为数字!");
        return false;
    }
    
//验证列表 
 
var table = document.getElementById("tableOnlineEdit");
var tr1 = table.getElementsByTagName("tr").length;



for(var c=1;c<table.getElementsByTagName("tr").length;c++)
{
//alert(document.getElementsByName("product_4_width"+c)[0].value);
if(document.getElementsByName("product_4_width"+c)[0].value=="")
{

alert("请填写分切宽度!");
return false;
}
if(document.getElementsByName("product_4_before_thickness"+c)[0].value=="")
{

alert("请填写切前厚度!");
return false;
}
if(document.getElementsByName("product_4_after_thickness"+c)[0].value=="")
{
alert("请填写切后厚度!");
return false;
}

if(document.getElementsByName("product_4_fact_length"+c)[0].value=="")
{

alert("请填写加工实际长度!");
return false;
}
if(document.getElementsByName("date_start"+c)[0].value=="")
{

alert("请填写加工日期!");
return false;
}
if(document.getElementsByName("product_4_time"+c)[0].value=="")
{

alert("请填写加工时间!");
return false;
}


}
    

 
 return true;
}
</script>
<%--
	String checker = (String) session.getAttribute("realeditorc");
	String checker_ID = (String) session.getAttribute("human_IDD");
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	String time = formatter.format(now);
	String apply_ID = request.getParameter("apply_ID");
	String config_id = request.getParameter("config_id");
	//String sql9 = "select id from manufacture_workflow where object_ID='"+ apply_ID+ "' and check_tag='0' and type_id='03' and config_id<'"+ config_id + "'";
	//ResultSet rs9 = manufacture_db.executeQuery(sql9);
	//if (!rs9.next()) {
		String register_time = "";
		String sql8 = "select * from manufacture_apply where apply_ID='"
		+ apply_ID + "' and check_tag='0' and excel_tag='2'";
		ResultSet rs8 = manufacturedb.executeQuery(sql8);
		if (rs8.next()) {
			try {
		String sql = "select * from manufacture_apply where apply_ID='"
				+ apply_ID + "'";
		ResultSet rs = manufacturedb.executeQuery(sql);
		if (rs.next()) {
			String remark = exchange.unHtml(rs
			.getString("remark"));
			if (rs.getString("register_time").equals(
			"1800-01-01 00:00:00.0")) {
				register_time = "";
			} else {
				register_time = rs.getString("register_time");
			}
--%>
<%
String register_ID = (String) session.getAttribute("human_IDD");
String register = (String) session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat(
		"yyyy-MM-dd HH:mm:ss");
String time = formatter.format(now);

String id=request.getParameter("id");//获取原料表id
String sql_all="select id,product_produce_location,product_spec_id,product_spec,product_lot_no,product_status from product_info where id="+id;
ResultSet rs_all=manufacture_db.executeQuery(sql_all);
String product_produce_location="";//发生场所
String product_spec="";//产品规格
String product_lot_no="";//Lot No
String product_status="";//状态
if(rs_all.next()){
	if(rs_all.getString("product_produce_location").equals("0")){
		product_produce_location="4分切";
	}else if(rs_all.getString("product_produce_location").equals("1")){
		product_produce_location="8mm切";
	}else if(rs_all.getString("product_produce_location").equals("2")){
		product_produce_location="打孔";
	}
	
	product_spec=rs_all.getString("product_spec");
	product_lot_no=rs_all.getString("product_lot_no");
	if(rs_all.getString("product_status").equals("2")){
		product_status="生产中";
	}else if(rs_all.getString("product_status").equals("3")){
		product_status="生产完成";
	}
}
String no_type="";//分类编号
//根据分类值查找分类编号
String sql_no_type="select no_type,no_value from option_no where no_value='SC07'";

ResultSet rs_no_type=manufacture_db.executeQuery(sql_no_type);
if(rs_no_type.next()){
	no_type=rs_no_type.getString("no_type");
}
//读取湿度和温度信息
String string_1="";
String string_2="";
String sql_="";
if(product_produce_location.equals("4分切")){
	sql_="select data_4_1_1,data_4_1_2,data_4_2_1,data_4_2_2 from security_base_data ";
	ResultSet rs_=manufacturedb.executeQuery(sql_);
	if(rs_.next()){
		string_1="("+rs_.getString("data_4_2_1")+"～"+rs_.getString("data_4_2_2")+")";
		string_2="("+rs_.getString("data_4_1_1")+"～"+rs_.getString("data_4_1_2")+")";
	}
}else if(product_produce_location.equals("8mm切")){
	sql_="select data_8_1_1,data_8_1_2,data_8_2_1,data_8_2_2 from security_base_data ";
	ResultSet rs_=manufacturedb.executeQuery(sql_);
	if(rs_.next()){
		string_1="("+rs_.getString("data_8_2_1")+"～"+rs_.getString("data_8_2_2")+")";
		string_2="("+rs_.getString("data_8_1_1")+"～"+rs_.getString("data_8_1_2")+")";
	}
}
else if(product_produce_location.equals("打孔")){
	sql_="select data_hole_1_1,data_hole_1_2,data_hole_2_1,data_hole_2_2 from security_base_data ";
	ResultSet rs_=manufacturedb.executeQuery(sql_);
	if(rs_.next()){
		string_1="("+rs_.getString("data_hole_2_1")+"～"+rs_.getString("data_hole_2_2")+")";
		string_2="("+rs_.getString("data_hole_1_1")+"～"+rs_.getString("data_hole_1_2")+")";
	}
}

%>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script language="javascript">

</script>
<form id="mutiValidation" method="post" action="../../manufacture_procedure_ActionProcedure.do" onsubmit="return checkSubmit(this)">
<input name="product_id" type="hidden" value="<%=id %>"><%-- 原料id隐藏域 --%>
<input name="m" type="hidden" value="<%="add"%>">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1">
		
		<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1">&nbsp;
		<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div>
		</td>
	</tr>
</table>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<div id="nseerGround" class="nseerGround">
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
		<td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp", "4分切产品信息")%></b></font></td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "发生场所")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_produce_location %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "产品规格")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_spec %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "Lot No")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_lot_no %>" onFocus="this.blur()"></td>
		
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
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "天气")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2"  align="left">
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "晴")%>" checked="checked"><%=demo.getLang("erp", "晴")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "雨")%>"><%=demo.getLang("erp", "雨")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "阴")%>"><%=demo.getLang("erp", "阴")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "云")%>"><%=demo.getLang("erp", "云")%>&nbsp;&nbsp; </td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "气温"+string_1)%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_4_temperature" type="text" value="" style="width: 150">℃</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "湿度"+string_2)%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2"  align="left">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_4_humidity" type="text" value="" style="width: 135">%RH</td>
		
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
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "状态")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_status %>" onFocus="this.blur()"></td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>

<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5" id="tableOnlineEdit">
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "规格")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "Lot No")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "发生场所")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "生产状态")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "产品状态")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "分切宽度")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "切前厚度")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "切后厚度")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "加工实际长度")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "加工日期")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "加工时间")%></td>
	</tr>
	<%--
				String sqll = "select * from manufacture_apply where apply_ID='"
				+ apply_ID + "'";
				ResultSet rs1 = manufacture_db.executeQuery(sqll);
				while (rs1.next()) {
	--%>
	<%
	String sql_every="select id,product_pstatus,product_produce_location,product_spec_id,product_spec,product_lot_no,product_status from product_info where father_product_id="+id;
	ResultSet rs_every=manufacture_db.executeQuery(sql_every);
	int k=1;
	String product_produce_location_s="";//发生场所
	String product_spec_s="";//产品规格
	String product_lot_no_s="";//Lot No
	String product_status_s="";//状态
	String status_s="";//产品状态
	while(rs_every.next()){
		
		
		product_spec_s=rs_every.getString("product_spec");
		product_lot_no_s=rs_every.getString("product_lot_no");
		if(rs_every.getString("product_status").equals("2")){
			product_status_s="生产中";
		}else if(rs_every.getString("product_status").equals("3")){
			product_status_s="生产完成";
			status_s=rs_every.getString("product_pstatus");
			
		}else if(rs_every.getString("product_status").equals("1")){
			product_status_s="生产完成";
			status_s=rs_every.getString("product_pstatus");
		
		}
		
		
	%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<input name="part_id<%=k %>" type="hidden" value="<%=rs_every.getString("id") %>">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_spec_s %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_lot_no_s %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=product_produce_location %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_status_s %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=status_s %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_width<%=k %>" type="text" value=""></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_before_thickness<%=k %>" type="text" value=""></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_after_thickness<%=k %>" type="text" value=""></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_fact_length<%=k %>" type="text" value=""></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" id="date_start<%=k %>" name="product_4_date<%=k %>" type="text" value=""></td>	
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_time<%=k %>" type="text" value=""></td>	
	</tr>
	<%
	k++;
	}
	
	%>
	<%--
	}
	--%>
	
</table>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>

<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
			
			<tr <%=TR_STYLE2%> class="TR_STYLE2">
				<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "缺陷区分")%></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "离卷起始位")%></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "形状")%></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "大小")%></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "缺陷内容")%></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "其他")%></td>
				
			</tr>
			<%for(int i=1;i<5;i++){
				%>
			<tr <%=TR_STYLE1%> class="TR_STYLE1">
				<td <%=TD_STYLE2%> class="TD_STYLE2"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="defect_no<%=i %>" id="" onchange="changeSel('1','<%=i %>')">
					<option value="<%=demo.getLang("erp","0")%>"><%=demo.getLang("erp","无缺陷")%></option><%-- 0——无缺陷 --%>
		  			<option value="<%=demo.getLang("erp","1")%>"><%=demo.getLang("erp","工程内缺陷")%></option><%-- 1——工程内缺陷 --%>
		  			<option value="<%=demo.getLang("erp","2")%>"><%=demo.getLang("erp","现票内缺陷")%></option><%-- 2——现票内缺陷 --%>
		  		</select></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE1" name="product_4_start<%=i %>" type="text" value=""></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE1" name="product_4_sharp<%=i %>" type="text" value=""></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE1" name="product_4_size<%=i %>" type="text" value=""></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2">
				<select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="product_4_content<%=i %>" id="" onchange="changeSel('2','<%=i %>')">
		  			<option value="<%=demo.getLang("erp","皱纹")%>"><%=demo.getLang("erp","A皱纹")%></option>
		  			<option value="<%=demo.getLang("erp","凹陷")%>"><%=demo.getLang("erp","B凹陷")%></option>
		  			<option value="<%=demo.getLang("erp","划伤")%>"><%=demo.getLang("erp","C划伤")%></option>
		  			<option value="<%=demo.getLang("erp","卷取不齐")%>"><%=demo.getLang("erp","D卷取不齐")%></option>
		  			<option value="<%=demo.getLang("erp","纸屑")%>"><%=demo.getLang("erp","E纸屑")%></option>
		  			<option value="<%=demo.getLang("erp","(拆开包装纸后)外观检查内容")%>"><%=demo.getLang("erp","F(拆开包装纸后)外观检查内容")%></option>
		  			<option value="<%=demo.getLang("erp","污点")%>"><%=demo.getLang("erp","G污点")%></option>
		  			<option value="<%=demo.getLang("erp","其他")%>"><%=demo.getLang("erp","H其他")%></option>
		  		</select></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE1" name="product_4_content_other<%=i %>" type="text" value=""></td>
			</tr>	
				<%
			} %>
			
		</TABLE>
		</td>
		
	</tr>
</table>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "登录人")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_4_register" type="text" value="<%=register %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "登录时间")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_4_register_time" type="text" value="<%=time.substring(0,10) %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "操作自检人")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_4_operator" type="text" value="" ></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%">&nbsp;</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" width="16%">&nbsp;</td>
	</tr>
</table>

<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>"
	value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form> 
<%--
		}
		manufacture_db.close();
			} catch (Exception ex) {
		out.println("error" + ex);
			}
		} else {
			manufacture_db.close();
--%>
<%--
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button"
			<%=BUTTON_STYLE1%> class="BUTTON_STYLE1"
			value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div>
		</td>
	</tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp", "该记录已审核，请返回！")%></td>
	</tr>
</table>
</div>
 --%>

<%
		//}
		manufacturedb.close();

	
	manufacture_db.close();
%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start1", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start1", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_start2", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start2", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_start3", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start3", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_start4", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start4", singleClick : true, step : 1});
</script>
