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
			nseer_db manufacturedb1 = new nseer_db((String) session
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

<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript'
	src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript"
	src="../../javascript/include/validate/validation-framework.js"></script>

<%
String checker_ID = "";

String time = "";

String id=request.getParameter("id");//获取原料表id
String sql_all="select id,product_machine,product_produce_location,product_spec_id,product_spec,product_lot_no,product_middle_lot_no,product_status from product_info where id="+id;
ResultSet rs_all=manufacture_db.executeQuery(sql_all);
String product_produce_location="";//发生场所
String product_spec="";//产品规格
String product_lot_no="";//Lot No(机器号)
String product_status="";//状态
String product_machine="";//机器号
String product_middle_lot_no="";//生产前Lot No日期
String product_spec_id="";//规格id
String page_title="";
String no_value="";
if(rs_all.next()){

	if(rs_all.getString("product_produce_location").equals("0")){
		product_produce_location="4分切";
		page_title="4分切产品信息审核";
		no_value="SC07";
	}else if(rs_all.getString("product_produce_location").equals("1")){
		product_produce_location="8mm切";
		page_title="8mm切产品信息审核";
		no_value="SC08";
	}else if(rs_all.getString("product_produce_location").equals("2")){
		product_produce_location="打孔";
		page_title="打孔产品信息审核";
		no_value="SC03";
	}
	product_spec_id=rs_all.getString("product_spec_id");
	product_middle_lot_no=rs_all.getString("product_middle_lot_no");
	product_middle_lot_no=product_middle_lot_no.replace("-","");//去掉横线
	
	product_machine=rs_all.getString("product_machine");
	product_spec=rs_all.getString("product_spec");
	product_lot_no=rs_all.getString("product_lot_no");
	if(rs_all.getString("product_status").equals("2")){
		product_status="生产中";
	}else if(rs_all.getString("product_status").equals("3")){
		product_status="生产完成";
	}else if(rs_all.getString("product_status").equals("1")){
		product_status="生产完成";
	}
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

String no_type="";//分类编号
//根据分类值查找分类编号
String sql_no_type="select no_type,no_value from option_no where no_value='"+no_value+"'";

ResultSet rs_no_type=manufacture_db.executeQuery(sql_no_type);
if(rs_no_type.next()){
	no_type=rs_no_type.getString("no_type");
}
//角孔型号尺寸
	String mold_style_id="";//角孔型号
	String mold_size_length="";//角孔长?
	String mold_size_width="";//角孔宽?
	String mold_code="";//模具号
	String mold_hole_count="";
	if(!product_machine.equals("0")){
		
		String sql_mold="select id,mold_spec,mold_location,mold_machine_number,mold_code,mold_hole_count"
		+" from mold_info where mold_location=3 and mold_machine_number="+product_machine;
		ResultSet rs_mold=manufacture_db.executeQuery(sql_mold);
		if(rs_mold.next()){
			mold_style_id=rs_mold.getString("mold_spec");
			mold_code=rs_mold.getString("mold_code");
			mold_hole_count=rs_mold.getString("mold_hole_count");
			
		}
	}
%>
<form id="mutiValidation" method="post" action="../../manufacture_procedure_ActionProcedure.do" onsubmit="return TwoSubmit(this)">
<input type="hidden" name="m" id="m" value="update" >
<input type="hidden" name="changeId" id="changeId" value="<%=id %>" >
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8">
		<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1">&nbsp;
		<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();">
		</td>
	</tr>
</table>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
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
		<td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp", page_title)%></b></font></td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<%
if(product_produce_location.equals("4分切")){
	//4分切画面
	//得到4分切基本信息
	String sql_details="select id,father_product_id,product_produce_location,product_spec_id,product_spec,product_lot_no,product_status from product_info where father_product_id="+id;
	ResultSet rs_details=manufacture_db.executeQuery(sql_details);
	String weather="";
	String temperature="";
	String humidity="";
	String register="";
	String register_time="";
	String checker="";
	String checker_time="";
	String operator="";
	
	String sql_info="";
	if(rs_details.next()){
		//查出一条信息获取基本信息
		sql_info="select * from product_4_info where product_id='"+rs_details.getString("id")+"'";
		ResultSet rs_info=manufacturedb.executeQuery(sql_info);
		if(rs_info.next()){
			checker_ID=rs_info.getString("product_4_checker");
			time=rs_info.getString("product_4_checker_time");
			weather=rs_info.getString("product_4_weather");
			temperature=rs_info.getString("product_4_temperature");
			humidity=rs_info.getString("product_4_humidity");
			register=rs_info.getString("product_4_register");
			register_time=rs_info.getString("product_4_register_time");
			checker=rs_info.getString("product_4_checker");
			checker_time=rs_info.getString("product_4_checker_time");
			operator=rs_info.getString("product_4_operator");
		}
	}
	
	%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<input name="payer_ID" type="hidden" value="">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "发生场所")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_produce_location %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "产品规格")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_spec %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "Lot No")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="24%">
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
		<%if(weather.equals("晴")){
		%>
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "晴")%>" checked="checked"><%=demo.getLang("erp", "晴")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "雨")%>"><%=demo.getLang("erp", "雨")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "阴")%>"><%=demo.getLang("erp", "阴")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "云")%>"><%=demo.getLang("erp", "云")%>&nbsp;&nbsp;
		<%	
		}else if(weather.equals("雨")){
		%>
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "晴")%>" ><%=demo.getLang("erp", "晴")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "雨")%>" checked="checked"><%=demo.getLang("erp", "雨")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "阴")%>"><%=demo.getLang("erp", "阴")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "云")%>"><%=demo.getLang("erp", "云")%>&nbsp;&nbsp;
		<%	
		}else if(weather.equals("阴")){
		%>
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "晴")%>" ><%=demo.getLang("erp", "晴")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "雨")%>" ><%=demo.getLang("erp", "雨")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "阴")%>" checked="checked"><%=demo.getLang("erp", "阴")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "云")%>"><%=demo.getLang("erp", "云")%>&nbsp;&nbsp;
		<%	
		}else if(weather.equals("云")){
		%>
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "晴")%>" ><%=demo.getLang("erp", "晴")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "雨")%>" ><%=demo.getLang("erp", "雨")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "阴")%>"><%=demo.getLang("erp", "阴")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "云")%>" checked="checked"><%=demo.getLang("erp", "云")%>&nbsp;&nbsp;
		<%	
		}else{
		%>
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "晴")%>" checked="checked"><%=demo.getLang("erp", "晴")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "雨")%>"><%=demo.getLang("erp", "雨")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "阴")%>"><%=demo.getLang("erp", "阴")%>&nbsp;&nbsp;
		<input name="product_4_weather" type="radio" value="<%=demo.getLang("erp", "云")%>"><%=demo.getLang("erp", "云")%>&nbsp;&nbsp;
		<%} %>
		 </td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "气温"+string_1)%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_4_temperature" type="text" value="<%=temperature %>" style="width: 150">℃</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "湿度"+string_2)%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2"  align="left">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_4_humidity" type="text" value="<%=humidity %>" style="width: 135">%RH</td>
		
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

<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
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
		ResultSet rs_part=manufacturedb.executeQuery(sql_details);
		int k=1;
		while(rs_part.next()){
			String pstatus="";
			String lotnot="";
			String sql_pstatus="select product_pstatus,id,product_lot_no,product_status from product_info where id="+rs_part.getString("id");
			ResultSet rs_pstatus=manufacturedb1.executeQuery(sql_pstatus);
			if(rs_pstatus.next()){
				lotnot=rs_pstatus.getString("product_lot_no");
				//9.21 lixiaodong 加入废弃品和转换品
				if(rs_pstatus.getString("product_status").equals("3")||rs_pstatus.getString("product_status").equals("4")||rs_pstatus.getString("product_status").equals("6")||rs_pstatus.getString("product_status").equals("1")){
				pstatus=rs_pstatus.getString("product_pstatus");
				}
			}
			
			
			sql_info="select * from product_4_info where product_id='"+rs_part.getString("id")+"'";
			
			ResultSet rs_info=manufacturedb1.executeQuery(sql_info);
			if(rs_info.next()){
	%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<input name="part_id<%=k %>" type="hidden" value="<%=rs_part.getString("id") %>">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_spec %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=lotnot %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=product_produce_location %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_status %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=pstatus %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_width<%=k %>" type="text" value="<%=rs_info.getString("product_4_width") %>"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_before_thickness<%=k %>" type="text" value="<%=rs_info.getString("product_4_before_thickness") %>"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_after_thickness<%=k %>" type="text" value="<%=rs_info.getString("product_4_after_thickness") %>"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_fact_length<%=k %>" type="text" value="<%=rs_info.getString("product_4_fact_length") %>"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" id="date_start<%=k %>" name="product_4_date<%=k %>" type="text" value="<%=rs_info.getString("product_4_date") %>"></td>	
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_time<%=k %>" type="text" value="<%=rs_info.getString("product_4_time") %>" >
		
		
		
	</tr>
	<%		}
		k++;
		}
		
	%>
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
			<%
			
			
			
			ResultSet rs_exp=manufacturedb.executeQuery(sql_details);
			int i=1;
			while(rs_exp.next()){
			sql_info="select * from product_4_info where product_id='"+rs_exp.getString("id")+"'";
				
			ResultSet rs_info=manufacturedb1.executeQuery(sql_info);
			if(rs_info.next()){
			if(rs_info.getString("product_4_notedefect_content").equals("")&&rs_info.getString("product_4_workdefect_content").equals("")){
				//无异常
			%>
			<tr <%=TR_STYLE1%> class="TR_STYLE1">
				<td <%=TD_STYLE2%> class="TD_STYLE2"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="defect_no<%=i %>" id="" onchange="changeSel('1','<%=i %>')">
					<option value="<%=demo.getLang("erp","0")%>" selected="selected"><%=demo.getLang("erp","无缺陷")%></option><%-- 0——无缺陷 --%>
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
			}else if((!rs_info.getString("product_4_notedefect_content").equals(""))&&rs_info.getString("product_4_workdefect_content").equals("")){
				//工程内缺陷
			%>
			<tr <%=TR_STYLE1%> class="TR_STYLE1">
				<td <%=TD_STYLE2%> class="TD_STYLE2"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="defect_no<%=i %>" id="" onchange="changeSel('1','<%=i %>')">
					<option value="<%=demo.getLang("erp","0")%>" ><%=demo.getLang("erp","无缺陷")%></option><%-- 0——无缺陷 --%>
		  			<option value="<%=demo.getLang("erp","1")%>" selected="selected"><%=demo.getLang("erp","工程内缺陷")%></option><%-- 1——工程内缺陷 --%>
		  			<option value="<%=demo.getLang("erp","2")%>"><%=demo.getLang("erp","现票内缺陷")%></option><%-- 2——现票内缺陷 --%>
		  		</select></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_start<%=i %>" type="text" value="<%=rs_info.getString("product_4_notedefect_start") %>"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_sharp<%=i %>" type="text" value="<%=rs_info.getString("product_4_notedefect_sharp") %>"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_size<%=i %>" type="text" value="<%=rs_info.getString("product_4_notedefect_size") %>"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2">
				<select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="product_4_content<%=i %>" id="" onchange="changeSel('2','<%=i %>')">
					<%
					String temp_product_4_content=rs_info.getString("product_4_notedefect_content");
					
					%>
		  			<option value="<%=demo.getLang("erp","皱纹")%>" <%if(temp_product_4_content.equals("皱纹")){%>selected="selected"<%} %> ><%=demo.getLang("erp","A皱纹")%></option>
		  			<option value="<%=demo.getLang("erp","凹陷")%>" <%if(temp_product_4_content.equals("凹陷")){%>selected="selected"<%} %> ><%=demo.getLang("erp","B凹陷")%></option>
		  			<option value="<%=demo.getLang("erp","划伤")%>" <%if(temp_product_4_content.equals("划伤")){%>selected="selected"<%} %> ><%=demo.getLang("erp","C划伤")%></option>
		  			<option value="<%=demo.getLang("erp","卷取不齐")%>" <%if(temp_product_4_content.equals("卷取不齐")){%>selected="selected"<%} %> ><%=demo.getLang("erp","D卷取不齐")%></option>
		  			<option value="<%=demo.getLang("erp","纸屑")%>" <%if(temp_product_4_content.equals("纸屑")){%>selected="selected"<%} %> ><%=demo.getLang("erp","E纸屑")%></option>
		  			<option value="<%=demo.getLang("erp","(拆开包装纸后)外观检查内容")%>" <%if(temp_product_4_content.equals("(拆开包装纸后)外观检查内容")){%>selected="selected"<%} %> ><%=demo.getLang("erp","F(拆开包装纸后)外观检查内容")%></option>
		  			<option value="<%=demo.getLang("erp","污点")%>" <%if(temp_product_4_content.equals("污点")){%>selected="selected"<%} %> ><%=demo.getLang("erp","G污点")%></option>
		  			<option value="<%=demo.getLang("erp","其他")%>" <%if(temp_product_4_content.equals("其他")){%>selected="selected"<%} %> ><%=demo.getLang("erp","H其他")%></option>
		  		</select></td>
		  		<%
				String other="";
				if(!rs_info.getString("product_4_notedefect_content_other").equals("null")){
					other=rs_info.getString("product_4_notedefect_content_other");
				}
				if(temp_product_4_content.equals("其他")){
				
				%>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_content_other<%=i %>" type="text" value="<%=other %>"></td>
				<%	
				}else{
				%>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE1" name="product_4_content_other<%=i %>" type="text" value=""></td>
				<%	
				}
				%>
				
				
			</tr>
			<%	
			}else if(rs_info.getString("product_4_notedefect_content").equals("")&&(!rs_info.getString("product_4_workdefect_content").equals(""))){
				//现票内缺陷
			%>
			<tr <%=TR_STYLE1%> class="TR_STYLE1">
				<td <%=TD_STYLE2%> class="TD_STYLE2"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="defect_no<%=i %>" id="" onchange="changeSel('1','<%=i %>')">
					<option value="<%=demo.getLang("erp","0")%>" ><%=demo.getLang("erp","无缺陷")%></option><%-- 0——无缺陷 --%>
		  			<option value="<%=demo.getLang("erp","1")%>" ><%=demo.getLang("erp","工程内缺陷")%></option><%-- 1——工程内缺陷 --%>
		  			<option value="<%=demo.getLang("erp","2")%>" selected="selected"><%=demo.getLang("erp","现票内缺陷")%></option><%-- 2——现票内缺陷 --%>
		  		</select></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_start<%=i %>" type="text" value="<%=rs_info.getString("product_4_workdefect_start") %>"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_sharp<%=i %>" type="text" value="<%=rs_info.getString("product_4_workdefect_sharp") %>"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_size<%=i %>" type="text" value="<%=rs_info.getString("product_4_workdefect_size") %>"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2">
				<select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="product_4_content<%=i %>" id="" onchange="changeSel('2','<%=i %>')">
					<%
					String temp_product_4_content=rs_info.getString("product_4_workdefect_content");
					
					%>
		  			<option value="<%=demo.getLang("erp","皱纹")%>" <%if(temp_product_4_content.equals("皱纹")){%>selected="selected"<%} %> ><%=demo.getLang("erp","A皱纹")%></option>
		  			<option value="<%=demo.getLang("erp","凹陷")%>" <%if(temp_product_4_content.equals("凹陷")){%>selected="selected"<%} %> ><%=demo.getLang("erp","B凹陷")%></option>
		  			<option value="<%=demo.getLang("erp","划伤")%>" <%if(temp_product_4_content.equals("划伤")){%>selected="selected"<%} %> ><%=demo.getLang("erp","C划伤")%></option>
		  			<option value="<%=demo.getLang("erp","卷取不齐")%>" <%if(temp_product_4_content.equals("卷取不齐")){%>selected="selected"<%} %> ><%=demo.getLang("erp","D卷取不齐")%></option>
		  			<option value="<%=demo.getLang("erp","纸屑")%>" <%if(temp_product_4_content.equals("纸屑")){%>selected="selected"<%} %> ><%=demo.getLang("erp","E纸屑")%></option>
		  			<option value="<%=demo.getLang("erp","(拆开包装纸后)外观检查内容")%>" <%if(temp_product_4_content.equals("(拆开包装纸后)外观检查内容")){%>selected="selected"<%} %> ><%=demo.getLang("erp","F(拆开包装纸后)外观检查内容")%></option>
		  			<option value="<%=demo.getLang("erp","污点")%>" <%if(temp_product_4_content.equals("污点")){%>selected="selected"<%} %> ><%=demo.getLang("erp","G污点")%></option>
		  			<option value="<%=demo.getLang("erp","其他")%>" <%if(temp_product_4_content.equals("其他")){%>selected="selected"<%} %> ><%=demo.getLang("erp","H其他")%></option>
		  		</select></td>
		  		<%
				String other="";
				if(!rs_info.getString("product_4_workdefect_content_other").equals("null")){
					other=rs_info.getString("product_4_workdefect_content_other");
				}
				if(temp_product_4_content.equals("其他")){
				
				%>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_4_content_other<%=i %>" type="text" value="<%=other %>"></td>
				<%	
				}else{
				%>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE1" name="product_4_content_other<%=i %>" type="text" value=""></td>
				<%	
				}
				%>
				
				
			</tr>
			
			<%	
			}
			}
			i++;
			}
		    %>
			
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
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" width="24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_4_register" type="text" value="<%=register %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "登录时间")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" width="24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_4_register_time" type="text" value="<%=register_time %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "操作自检人")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" width="24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_4_operator" type="text" value="<%=operator %>" ></td>
		
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
	
</table>
<%	
}
%>


<%@include file="../include/paper_bottom.html"%>
</form>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
	

<%
		//}
	manufacturedb.close();
	manufacturedb1.close();
	manufacture_db.close();
%>
