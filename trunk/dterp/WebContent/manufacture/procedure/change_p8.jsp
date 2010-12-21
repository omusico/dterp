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

<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript'
	src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript"
	src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript">
//下拉框函数
function changeSel(ab,k){

if(ab=="1"){
	var tempoption=document.getElementsByName("product_8mm_paper_exterior"+k);
	var tempother=document.getElementsByName("product_8mm_paper_exterior_other"+k);
	if(tempoption[0].value=="其他"){
		tempother[0].value = "";
		tempother[0].disabled = false;
		tempother[0].className="INPUT_STYLE5";
	}else{
		tempother[0].value = "";
		tempother[0].disabled = "disabled";
		tempother[0].className="INPUT_STYLE1";
	}
}else if(ab=="2"){
	var tempoption=document.getElementsByName("product_8mm_defect"+k);
	var tempother=document.getElementsByName("product_8mm_defect_other"+k);
	if(tempoption[0].value=="其他"){
		tempother[0].value = "";
		tempother[0].disabled = false;
		tempother[0].className="INPUT_STYLE5";
	}else{
		tempother[0].value = "";
		tempother[0].disabled = "disabled";
		tempother[0].className="INPUT_STYLE1";
	}
	
}else if(ab=="3"){
	var tempoption=document.getElementsByName("product_8mm_volume_exterior"+k);
	var tempother=document.getElementsByName("product_8mm_volume_exterior_other"+k);
	if(tempoption[0].value=="其他"){
		tempother[0].value = "";
		tempother[0].disabled = false;
		tempother[0].className="INPUT_STYLE5";
	}else{
		tempother[0].value = "";
		tempother[0].disabled = "disabled";
		tempother[0].className="INPUT_STYLE1";
	}
}
}
function checkSubmit(TForm)
{
 var txt1 =TForm.product_8mm_temperature.value;
  var txt2 =TForm.product_8mm_humidity.value;
 if(TForm.product_8mm_temperature.value=="")
 {
 	alert("请填写气温!");
 	return false;
 }else if(TForm.product_8mm_humidity.value=="")
 {
 	alert("请填写湿度!");
 	return false;
 }else if(TForm.product_8mm_humidity.value=="")
 {
 	alert("请填写湿度!");
 	return false;
 }else if(TForm.product_8mm_humidity.value=="")
 {
 	alert("请填写湿度!");
 	return false;
 }else if(TForm.product_8mm_date.value==""){
 	alert("请填写发行日!");
 	return false;
 }else if(TForm.product_8mm_time.value==""){
 	alert("请填写加工时间!");
 	return false;
 }else if(TForm.product_8mm_operator.value=="")
 {
 	alert("请填写操作自检人!");
 	return false;
 }else if(txt1.search("^-?\\d+$")!=0){
        alert("气温只能为数字!");
        return false;
 }else if(txt2.search("^-?\\d+$")!=0){
        alert("湿度只能为数字!");
        return false;
 }
 
 return true;
}
</script>
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
<form id="mutiValidation" method="post" action="../../manufacture_procedure_ActionProcedure.do" onsubmit="return checkSubmit(this)">
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
if(product_produce_location.equals("8mm切")){
	//得到8mm切生产信息
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
	String product_8mm_date="";
	String product_8mm_time="";
	if(rs_details.next()){
		//查出一条信息获取基本信息
		sql_info="select * from product_8mm_info where product_id='"+rs_details.getString("id")+"'";
		ResultSet rs_info=manufacturedb.executeQuery(sql_info);
		if(rs_info.next()){
			checker_ID=rs_info.getString("product_8mm_checker");
			time=rs_info.getString("product_8mm_checker_time");
			weather=rs_info.getString("product_8mm_weather");
			temperature=rs_info.getString("product_8mm_temperature");
			humidity=rs_info.getString("product_8mm_humidity");
			register=rs_info.getString("product_8mm_register");
			register_time=rs_info.getString("product_8mm_register_time");
			checker=rs_info.getString("product_8mm_checker");
			checker_time=rs_info.getString("product_8mm_checker_time");
			operator=rs_info.getString("product_8mm_operator");
			product_8mm_date=rs_info.getString("product_8mm_paper_date");
			product_8mm_time=rs_info.getString("product_8mm_paper_time");
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
		<input name="product_8mm_weather" type="radio" value="<%=demo.getLang("erp", "晴")%>" <%if(weather.equals("晴")){%>checked="checked"<%} %> ><%=demo.getLang("erp", "晴")%>&nbsp;&nbsp;
		<input name="product_8mm_weather" type="radio" value="<%=demo.getLang("erp", "雨")%>" <%if(weather.equals("雨")){%>checked="checked"<%} %> ><%=demo.getLang("erp", "雨")%>&nbsp;&nbsp;
		<input name="product_8mm_weather" type="radio" value="<%=demo.getLang("erp", "阴")%>" <%if(weather.equals("阴")){%>checked="checked"<%} %> ><%=demo.getLang("erp", "阴")%>&nbsp;&nbsp;
		<input name="product_8mm_weather" type="radio" value="<%=demo.getLang("erp", "云")%>" <%if(weather.equals("云")){%>checked="checked"<%} %> ><%=demo.getLang("erp", "云")%>&nbsp;&nbsp;
		
		</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "气温"+string_1)%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_8mm_temperature" type="text" value="<%=temperature %>" style="width: 80%" >℃</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "湿度"+string_2)%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2"  align="left">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_8mm_humidity" type="text" value="<%=humidity %>" style="width: 80%" >%RH</td>
		
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
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "加工日期")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="date_start1" name="product_8mm_date" type="text" value="<%=product_8mm_date %>" onkeydown="return false" ></td>
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "加工时间")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_8mm_time" type="text" value="<%=product_8mm_time %>" ></td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
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
		
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "实际长度")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "实际宽度")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "纸带外观")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "其他")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "卷曲外观")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "其他")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "缺陷检出")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "废边剥离")%></td>
		
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
		String sql_pstatus="select product_pstatus,id,product_status,product_lot_no from product_info where id="+rs_part.getString("id");
		ResultSet rs_pstatus=manufacturedb1.executeQuery(sql_pstatus);
		
		if(rs_pstatus.next()){
			lotnot=rs_pstatus.getString("product_lot_no");
//			9.21 lixiaodong 加入废弃品和转换品
			if(rs_pstatus.getString("product_status").equals("3")||rs_pstatus.getString("product_status").equals("4")||rs_pstatus.getString("product_status").equals("6")){
				pstatus=rs_pstatus.getString("product_pstatus");
			}
		}
		
		
		sql_info="select * from product_8mm_info where product_id='"+rs_part.getString("id")+"'";
		
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
		<td <%=TD_STYLE2%> class="TD_STYLE2">
		<input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_8mm_fact_length<%=k %>" type="text" value="<%=rs_info.getString("product_8mm_fact_length") %>">
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2">
		<input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_8mm_fact_width<%=k %>" type="text" value="<%=rs_info.getString("product_8mm_fact_width") %>">
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2">
		<%
		String temp_product_8mm_paper_exterior=rs_info.getString("product_8mm_paper_exterior");
		%>
				<select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="product_8mm_paper_exterior<%=k %>" id="" onchange="changeSel('1','<%=k %>')" >
			<option value="<%=demo.getLang("erp","走纸正常(N01~10)")%>" <%if(temp_product_8mm_paper_exterior.equals("走纸正常(N01~10)")){%>selected="selected"<%} %> ><%=demo.getLang("erp","走纸正常(N01~10)")%></option>
			<option value="<%=demo.getLang("erp","切口不平整(手指触摸、不良时确认刀具)")%>" <%if(temp_product_8mm_paper_exterior.equals("切口不平整(手指触摸、不良时确认刀具)")){%>selected="selected"<%} %> ><%=demo.getLang("erp","切口不平整(手指触摸、不良时确认刀具)")%></option>
			<option value="<%=demo.getLang("erp","纸屑结块")%>" <%if(temp_product_8mm_paper_exterior.equals("纸屑结块")){%>selected="selected"<%} %> ><%=demo.getLang("erp","纸屑结块")%></option>
			<option value="<%=demo.getLang("erp","蛇形弯曲")%>" <%if(temp_product_8mm_paper_exterior.equals("蛇形弯曲")){%>selected="selected"<%} %> ><%=demo.getLang("erp","蛇形弯曲")%></option>
			<option value="<%=demo.getLang("erp","其他")%>" <%if(temp_product_8mm_paper_exterior.equals("其他")){%>selected="selected"<%} %> ><%=demo.getLang("erp","其他")%></option>
		  		</select>
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2">
		<%if(temp_product_8mm_paper_exterior.equals("其他")){
		%>
		<input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_8mm_paper_exterior_other<%=k %>" type="text" value="<%=rs_info.getString("product_8mm_paper_exterior_other") %>" >
		
		<%	
		}else{
		%>
		<input <%=INPUT_STYLE5%> class="INPUT_STYLE1" name="product_8mm_paper_exterior_other<%=k %>" type="text" value="" >
		<%	
		} %>
				</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2">
		<%
		String temp_product_8mm_volume_exterior=rs_info.getString("product_8mm_volume_exterior");
		%>
			<select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="product_8mm_volume_exterior<%=k %>" id="" onchange="changeSel('3','<%=k %>')">
			<option value="<%=demo.getLang("erp","OK")%>" <%if(temp_product_8mm_volume_exterior.equals("OK")){%>selected="selected"<%} %> ><%=demo.getLang("erp","OK")%></option>
			<option value="<%=demo.getLang("erp","端面凹凸大于3mm")%>" <%if(temp_product_8mm_volume_exterior.equals("端面凹凸大于3mm")){%>selected="selected"<%} %> ><%=demo.getLang("erp","端面凹凸大于3mm")%></option>
			<option value="<%=demo.getLang("erp","卷乱重叠")%>" <%if(temp_product_8mm_volume_exterior.equals("卷乱重叠")){%>selected="selected"<%} %> ><%=demo.getLang("erp","卷乱重叠")%></option>
			<option value="<%=demo.getLang("erp","纸带突出纸管")%>" <%if(temp_product_8mm_volume_exterior.equals("纸带突出纸管")){%>selected="selected"<%} %> ><%=demo.getLang("erp","纸带突出纸管")%></option>
			<option value="<%=demo.getLang("erp","端面无划伤、污渍")%>" <%if(temp_product_8mm_volume_exterior.equals("端面无划伤、污渍")){%>selected="selected"<%} %> ><%=demo.getLang("erp","端面无划伤、污渍")%></option>
			<option value="<%=demo.getLang("erp","其他")%>" <%if(temp_product_8mm_volume_exterior.equals("其他")){%>selected="selected"<%} %> ><%=demo.getLang("erp","其他")%></option>
	  		</select>
				</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2">
		
		<%if(temp_product_8mm_volume_exterior.equals("其他")){
		%>
		<input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_8mm_volume_exterior_other<%=k %>" type="text" value="<%=rs_info.getString("product_8mm_volume_exterior_other") %>">
		
		<%	
		}else{
		%>
		<input <%=INPUT_STYLE5%> class="INPUT_STYLE1" name="product_8mm_volume_exterior_other<%=k %>" type="text" value="">
		<%	
		} %>
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2">
			<%
		String temp_product_8mm_defect=rs_info.getString("product_8mm_defect");
		%>
				<select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="product_8mm_defect<%=k %>" id="" onchange="changeSel('2','<%=k %>')">
	<option value="<%=demo.getLang("erp","OK")%>" <%if(temp_product_8mm_defect.equals("OK")){%>selected="selected"<%} %> ><%=demo.getLang("erp","OK")%></option>
	<option value="<%=demo.getLang("erp","皱纹")%>" <%if(temp_product_8mm_defect.equals("皱纹")){%>selected="selected"<%} %> ><%=demo.getLang("erp","皱纹")%></option>
	<option value="<%=demo.getLang("erp","凹陷")%>" <%if(temp_product_8mm_defect.equals("凹陷")){%>selected="selected"<%} %> ><%=demo.getLang("erp","凹陷")%></option>
	<option value="<%=demo.getLang("erp","划伤")%>" <%if(temp_product_8mm_defect.equals("划伤")){%>selected="selected"<%} %> ><%=demo.getLang("erp","划伤")%></option>
	<%--<option value="<%=demo.getLang("erp","其他")%>" <%if(temp_product_8mm_defect.equals("其他")){%>selected="selected"<%} %> ><%=demo.getLang("erp","其他")%></option>--%>
	<option value="<%=demo.getLang("erp","纸屑")%>" <%if(temp_product_8mm_defect.equals("纸屑")){%>selected="selected"<%} %> ><%=demo.getLang("erp","纸屑")%></option>
	<option value="<%=demo.getLang("erp","污点")%>" <%if(temp_product_8mm_defect.equals("污点")){%>selected="selected"<%} %> ><%=demo.getLang("erp","污点")%></option>
	<option value="<%=demo.getLang("erp","虫")%>" <%if(temp_product_8mm_defect.equals("虫")){%>selected="selected"<%} %> ><%=demo.getLang("erp","虫")%></option>
		  		</select>
		
		</td>
		
		<td <%=TD_STYLE2%> class="TD_STYLE2">
		<%
		String temp_product_8mm_peel=rs_info.getString("product_8mm_peel");
		%>
			<input name="product_8mm_defect_other<%=k %>" type="hidden" value="">
			<select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="product_8mm_peel<%=k %>" id="" >
				<option value="<%=demo.getLang("erp","无")%>" <%if(temp_product_8mm_peel.equals("无")){%>selected="selected"<%} %> ><%=demo.getLang("erp","无")%></option>
				<option value="<%=demo.getLang("erp","有")%>" <%if(temp_product_8mm_peel.equals("有")){%>selected="selected"<%} %> ><%=demo.getLang("erp","有")%></option>
			</select>
		</td>
	</tr>
	
	<%}
		k++;} %>
	
	
	<%--
	}
	--%>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>


<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">  
		<input name="payer_ID" type="hidden" value="">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "登录人")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_8mm_register" type="text" value="<%=register %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "登录时间")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_8mm_register_time" type="text" value="<%=register_time %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "操作自检人")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_8mm_operator" type="text" value="<%=operator %>" ></td>
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
	manufacturedb1.close();
	manufacture_db.close();
%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start1", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start1", singleClick : true, step : 1});

</script>
