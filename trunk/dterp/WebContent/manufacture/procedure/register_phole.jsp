<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijinis) Technology co.LTD/http://www.nseer.com 
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
String sql_all="select id,product_material_plan_id,product_machine,product_produce_location,product_spec_id,product_spec,product_lot_no,product_middle_lot_no,product_status "
+"from product_info where id="+id;
ResultSet rs_all=manufacture_db.executeQuery(sql_all);
String product_produce_location="";//发生场所
String product_spec="";//产品规格
String product_lot_no="";//Lot No(机器号)
String product_status="";//状态
String product_machine="";//机器号
String product_middle_lot_no="";//生产前Lot No日期
String product_spec_id="";//规格id
String product_material_plan_id="";//计划客户查询
if(rs_all.next()){
	if(rs_all.getString("product_produce_location").equals("0")){
		product_produce_location="4分切";
	}else if(rs_all.getString("product_produce_location").equals("1")){
		product_produce_location="8mm切";
	}else if(rs_all.getString("product_produce_location").equals("2")){
		product_produce_location="打孔";
	}
	product_spec_id=rs_all.getString("product_spec_id");
	
	
	product_machine=rs_all.getString("product_machine");
	product_spec=rs_all.getString("product_spec");
	product_material_plan_id=rs_all.getString("product_material_plan_id");
	if(rs_all.getString("product_status").equals("2")){
		product_status="生产中";
	}else if(rs_all.getString("product_status").equals("3")){
		product_status="生产完成";
	}
}
String product_pstatus="";
String sql_package_p="select id,product_machine,product_produce_location,product_spec_id,product_spec,product_lot_no,product_middle_lot_no,product_status,product_pstatus "
	+"from product_info where father_product_id="+id;
ResultSet rs_package_p=manufacture_db.executeQuery(sql_package_p);
if(rs_package_p.next()){
	product_middle_lot_no=rs_package_p.getString("product_middle_lot_no");
	product_middle_lot_no=product_middle_lot_no.replace("-","");//去掉横线
	product_lot_no=rs_package_p.getString("product_lot_no");
	product_pstatus=rs_package_p.getString("product_pstatus");
}


//读取湿度和温度信息
String string_1="";
String string_2="";
String sql_="";
String string_3="";
String string_4="";
String string_5="";
String string_6="";
String string_7="";

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
	sql_="select product_middle_thickness,product_middle_thickness_away,front_10P0_away,front_E_away,back_10P0_away,back_E_away "
		+"from option_spec where customer_id=(select plan_package_client from plan_hole_detail "
		+"where plan_id='"+product_material_plan_id+"' and product_spec_id="+product_spec_id+")";
	ResultSet rs_1=manufacturedb.executeQuery(sql_);
	if(rs_1.next()){
		string_3="("+rs_1.getString("product_middle_thickness")+"mm±"+rs_1.getString("product_middle_thickness_away")+"mm)";
		string_4="(40.00±"+rs_1.getString("front_10P0_away")+"mm)";
		string_5="(1.75±"+rs_1.getString("front_E_away")+"mm)";
		string_6="(40.00±"+rs_1.getString("back_10P0_away")+"mm)";
		string_7="(1.75±"+rs_1.getString("back_E_away")+"mm)";
	}
}






//长度查询
String product_length="";//长度
String sql_length="select product_length from design_file where id="+product_spec_id;
ResultSet rs_length=manufacture_db.executeQuery(sql_length);
if(rs_length.next()){
	product_length=rs_length.getString("product_length");
	
}
//角孔型号尺寸

String mold_style_id="";//角孔型号，模具规格id
String mold_spec="";//模具规格
String mold_size_length="";//角孔长?
String mold_size_width="";//角孔宽?
String mold_code="";//模具号
String mold_hole_count="";
String sql_mold="select mold_spec_id,id,mold_spec,mold_location,mold_machine_number,mold_code,mold_hole_count "
	+"from mold_info where mold_location=3 and mold_machine_number="+product_machine;
ResultSet rs_mold=manufacture_db.executeQuery(sql_mold);
if(rs_mold.next()){
	mold_style_id=rs_mold.getString("mold_spec_id");
	mold_spec=rs_mold.getString("mold_spec");
	mold_code=rs_mold.getString("mold_code");
	mold_hole_count=rs_mold.getString("mold_hole_count");
}
String no_type="";//分类编号
//根据分类值查找分类编号
String sql_no_type="select no_type,no_value from option_no where no_value='SC03'";

ResultSet rs_no_type=manufacture_db.executeQuery(sql_no_type);
if(rs_no_type.next()){
	no_type=rs_no_type.getString("no_type");
}
%>


<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript'
	src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript"
	src="../../javascript/include/validate/validation-framework.js"></script>
<script language="javascript">
function vaildateForm(){
	var mold_size_length=document.getElementsByName("mold_size_length")[0].value;
	var mold_size_width=document.getElementsByName("mold_size_width")[0].value;
	var product_hole_temperature=document.getElementsByName("product_hole_temperature")[0].value;
	var product_hole_humidity=document.getElementsByName("product_hole_humidity")[0].value;
	var product_hole_operator=document.getElementsByName("product_hole_operator")[0].value;
	
	var product_hole_num=document.getElementsByName("product_hole_num")[0].value;
	var product_hole_time=document.getElementsByName("product_hole_time")[0].value;
	var product_needle_status=document.getElementById("product_needle_status");
	var product_needle_content=document.getElementsByName("product_needle_content")[0].value;
	var prodcut_middle_length=document.getElementsByName("prodcut_middle_length")[0].value;
	var product_middle_width=document.getElementsByName("product_middle_width")[0].value;
	var product_middle_thickness=document.getElementsByName("product_middle_thickness")[0].value;
	var front_10P0=document.getElementsByName("front_10P0")[0].value;
	var front_E=document.getElementsByName("front_E")[0].value;
	var stop_length=document.getElementsByName("stop_length")[0].value;
	var final_particles=document.getElementById("final_particles");
	var final_particles_content=document.getElementsByName("final_particles_content")[0].value;
	var back_10P0=document.getElementsByName("back_10P0")[0].value;
	var back_E=document.getElementsByName("back_E")[0].value;
	var check_error_result=document.getElementsByName("check_error_result")[0].value;
	var check_hole_count=document.getElementsByName("check_hole_count")[0].value;
	var product_final_length=document.getElementsByName("product_final_length")[0].value;
	var mold_hole_count=document.getElementsByName("mold_hole_count")[0].value;
	
	var numP=/^\d+(\.\d+)?$/;
	

	if(mold_size_length.length==0||mold_size_width.length==0){
		alert("请正确输入角孔尺寸！");
			return false;
	}else if(!numP.test(mold_size_length)&&!numP.test(mold_size_width)){
		alert("请正确输入角孔尺寸！");
			return false;
	
	}else if(product_hole_temperature.length==0){
		
		alert("请正确输入气温！");
		return false;
	}else if(!numP.test(product_hole_temperature)){
		alert("请正确输入气温！");
		return false;
	}else if(product_hole_humidity.length==0){
		
		alert("请正确输入湿度！");
		return false;
	}else if(!numP.test(product_hole_humidity)){
		alert("请正确输入湿度！");
		return false;
	}else if(product_hole_operator.length==0){
		alert("请输入操作自检人！");
		return false;
	}else if(product_hole_num.length==0){

		alert("请正确输入当日加工卷数！");
		return false;
		
	}else if(!numP.test(product_hole_num)){
	
		alert("请正确输入当日加工卷数！");
		return false;
		
	}else if(product_hole_time.length==0){
		
		alert("请输入加工时间！");
		return false;
		
	}else if(product_needle_status.checked==false&&!numP.test(product_needle_content)){
		
		alert("请正确输入缺少枚数！");
		return false;
	}else if(prodcut_middle_length.length==0){
		alert("请正确输入生纸带实际长度！");
		return false;
	}else if(!numP.test(prodcut_middle_length)){
		alert("请正确输入生纸带实际长度！");
		return false;
	}else if(product_middle_width.length==0){
		alert("请正确输入纸宽！");
		return false;
	}else if(!numP.test(product_middle_width)){
		alert("请正确输入纸宽！");
		return false;
	}else if(product_middle_thickness.length==0){
		alert("请正确输入纸厚！");
		return false;
	}else if(!numP.test(product_middle_thickness)){
		alert("请正确输入纸厚！");
			return false;
	}else if(front_10P0.length==0){
		
		alert("请正确输入前样10P0！");
		return false;
	}else if(!numP.test(front_10P0)){
		alert("请正确输入前样10P0！");
		return false;
	}else if(front_E.length==0){
		
		alert("请正确输入前样E！");
		return false;
	}else if(!numP.test(front_E)){
		alert("请正确输入前样E！");
			return false;
	}/*else if(stop_length.length==0){
		
		alert("请正确输入停机时加工米数！");
		return false;
	}else if(!numP.test(stop_length)){
		alert("请正确输入停机时加工米数！");
		return false;
	}*/else if(final_particles.checked&&!numP.test(final_particles_content)){
		alert("请正确输入颗粒数！");
		return false;
	}else if(back_10P0.length==0){
		
		alert("请正确输入后样10P0！");
		return false;
	}else if(!numP.test(back_10P0)){
		alert("请正确输入后样10P0！");
		return false;
	}else if(back_E.length==0){
		
		alert("请正确输入后样E！");
		return false;
	}else if(!numP.test(back_E)){
		alert("请正确输入后样E！");
		return false;
	}/*else if(check_error_result.length==0){
		alert("请输入产生瑕疵原因！");
		return false;
	}else if(check_hole_count.length==0){
		
		alert("请正确输入打孔次数！");
		return false;
	}*/else if(product_final_length.length==0){
		
		alert("请正确输入成品实际长度！");
		return false;
	}else if(!numP.test(product_final_length)){
		alert("请正确输入成品实际长度！");
		return false;
	}else if(!numP.test(mold_hole_count)){
		alert("请正确输入累计打孔数量！");
		return false;
	}/*else if(!numP.test(check_hole_count)){
		alert("请正确输入打孔次数！");
		return false;
	}*/
	else{
		return true;
	}
}
function radioB(radio){
//alert(radio.name);
	if(radio.name=="product_needle_status"){
		
		var product_needle_content=document.getElementsByName("product_needle_content");
		
		if(radio.value=="完好"){
			product_needle_content[0].value = "";
			product_needle_content[0].disabled = "disabled";
			product_needle_content[0].className="INPUT_STYLE1";
		}else if(radio.value=="缺少"){
		
			product_needle_content[0].value = "0";
			product_needle_content[0].disabled = false;
			product_needle_content[0].className="INPUT_STYLE5";
		}
	}
	if(radio.name=="final_particles"){
		var final_particles_content=document.getElementsByName("final_particles_content");
		
		if(radio.value=="有"){
			final_particles_content[0].value = "0";
			final_particles_content[0].disabled = false;
			final_particles_content[0].className="INPUT_STYLE5";
		}else if(radio.value=="无"){
			final_particles_content[0].value = "";
			final_particles_content[0].disabled = "disabled";
			final_particles_content[0].className="INPUT_STYLE1";
		}
	}
}

</script>
<form id="mutiValidation" method="post" action="../../manufacture_procedure_ActionProcedure.do" onsubmit="return vaildateForm()">
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
		<td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp", "打孔产品信息")%></b></font></td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>   
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" style="width: 10%" ><%=demo.getLang("erp", "发生场所")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" style="width: 24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_produce_location %>" style="width: 80%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" style="width: 10%" ><%=demo.getLang("erp", "产品规格")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" style="width: 24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_spec %>" style="width: 80%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" style="width: 10%"><%=demo.getLang("erp", "长度")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_length %>" style="width: 80%" onFocus="this.blur()"></td>
	</tr>
	<tr>
	<td>
	<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
		<tr <%=TR_STYLE1%> class="TR_STYLE1">
			<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
		</tr>
	</table>
	</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "打孔纸带批次号")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_final_lot_no" type="text" value="<%=product_lot_no %>" style="width: 80%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "状态")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_status %>" style="width: 80%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "机器号")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_machine %>" style="width: 80%" onFocus="this.blur()"></td>
	</tr>
	<tr>
	<td>
	<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
		<tr <%=TR_STYLE1%> class="TR_STYLE1">
			<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
		</tr>
	</table>
	</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "角孔尺寸")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="mold_size_length" type="text" value="" style="width: 50">&nbsp;×
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="mold_size_width" type="text" value="" style="width: 50">mm</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "气温"+string_1)%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_hole_temperature" type="text" value="" style="width: 50">℃</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "湿度"+string_2)%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_hole_humidity" type="text" value="" style="width: 50">%RH</td>
		
	</tr>
	<tr>
	<td>
	<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
		<tr <%=TR_STYLE1%> class="TR_STYLE1">
			<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
		</tr>
	</table>
	</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "角孔型号")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input name="mold_style" type="hidden" value="<%=mold_style_id %>">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="mold_style_spec" type="text" value="<%=mold_spec %>" style="width: 80%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "产品状态")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_pstatus %>" style="width: 80%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "加工日期")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_hole_date" id="product_hole_date" type="text" value="" style="width: 80%" ></td>
	</tr>
	
</table>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td <%=TD_STYLE2%> class="TD_STYLE2" rowspan="2" colspan="2"><%=demo.getLang("erp", "当日加工卷数及加工时间")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "粉尘清理")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "去尘器")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2"><%=demo.getLang("erp", "模具确认")%></td>
	</tr>
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "按照\"设备清理指示图\"进行")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "确认方针状态")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "模具号")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "累计打孔数")%></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="text-align: right" name="product_hole_num" type="text" value=""></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_hole_time" type="text" value=""></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2">
			<input name="product_dust_clean" type="radio" value="已清理" checked="checked">已清理&nbsp;
			<input name="product_dust_clean" type="radio" value="疏漏">疏漏</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input name="product_needle_status" type="radio" value="完好" checked="checked" onselect="radioB(this)" onclick="radioB(this)">完好&nbsp;
		<input id="product_needle_status" name="product_needle_status" type="radio" value="缺少" onselect="radioB(this)" onclick="radioB(this)">
			缺<input <%=INPUT_STYLE5%> class="INPUT_STYLE1" name="product_needle_content" type="text" value=""style="width: 36%" disabled="disabled">枚</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=mold_code %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="text-align: right" name="mold_hole_count" type="text" value=""></td>
	</tr>   
</table>
<br>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="6"><%=demo.getLang("erp", "生纸带检查")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3"><%=demo.getLang("erp", "前样测定")%></td>
	</tr>
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td <%=TD_STYLE2%> class="TD_STYLE2" style="width: 160"><%=demo.getLang("erp", "生纸带批次号")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "生纸带实际长度(m)")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "纸宽(mm)")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "纸厚(mm)"+string_3)%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "纸表面正反面确认")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "外观检查")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "2m前样:圆孔")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "2m前样:角孔")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "10P0(mm)"+string_4)%></td>
		
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE1" name="product_middle_lot_no" type="text" value="<%=product_middle_lot_no %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="text-align: right" name="prodcut_middle_length" type="text" value=""></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="text-align: right" name="product_middle_width" type="text" value=""></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="text-align: right" name="product_middle_thickness" type="text" value=""></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input name="product_surface" type="radio" value="OK" checked="checked">OK&nbsp;<input name="product_surface" type="radio" value="NG">NG</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input name="product_exterior" type="radio" value="OK" checked="checked">OK&nbsp;<input name="product_exterior" type="radio" value="NG">NG</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input name="2front_circle" type="radio" value="OK" checked="checked">OK&nbsp;<input name="2front_circle" type="radio" value="NG">NG</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input name="2front_square" type="radio" value="OK" checked="checked">OK&nbsp;<input name="2front_square" type="radio" value="NG">NG</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="text-align: right" name="front_10P0" type="text" value=""></td>
	</tr>
</table>
<br>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2"><%=demo.getLang("erp", "前样测定")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2"><%=demo.getLang("erp", "中途停机")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "停机  检查")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "纸屑  吸附")%></td>
	</tr>
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "E"+string_5)%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "确定角孔灼烧程度")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "角孔灼烧程度、折痕、污渍、损伤")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "停机时已经加工米数")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "加工终了时，纸带状态")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "加工终了(确认颗粒数)")%></td>
		
		
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2" style="width: 55"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="text-align: right" name="front_E" type="text" value=""></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input name="front_burn" type="radio" value="OK" checked="checked">OK&nbsp;<input name="front_burn" type="radio" value="NG">NG</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input name="stop_damage" type="radio" value="OK" checked="checked">OK&nbsp;<input name="stop_damage" type="radio" value="NG">NG</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="text-align: right" name="stop_length" type="text" value=""></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input name="final_status" type="radio" value="OK" checked="checked">OK&nbsp;<input name="final_status" type="radio" value="NG">NG</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input id="final_particles" name="final_particles" type="radio" value="有" onselect="radioB(this)" onclick="radioB(this)">有&nbsp;（
		<input <%=INPUT_STYLE5%> class="INPUT_STYLE1" name="final_particles_content" type="text" value="" style="width: 36%" disabled="disabled">粒
		）<input name="final_particles" type="radio" value="无" onselect="radioB(this)" onclick="radioB(this)" checked="checked">无</td>
	</tr>
</table>

<br>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="5"><%=demo.getLang("erp", "后样测定")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="4"><%=demo.getLang("erp", "成品检查")%></td>
	</tr>
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "2米后样:圆孔")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "2米后样:角孔")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "10P0(mm)"+string_6)%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "E"+string_7)%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "确定角孔灼烧程度")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "外观整体确认：损伤，污渍")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "表层、双侧面卷纸确认:纸屑吸附")%></td>
		
		
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input name="2back_circle" type="radio" value="OK" checked="checked">OK&nbsp;<input name="2back_circle" type="radio" value="NG">NG</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input name="2back_square" type="radio" value="OK" checked="checked">OK&nbsp;<input name="2back_square" type="radio" value="NG">NG</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="text-align: right" name="back_10P0" type="text" value=""></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" style="width: 55"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="text-align: right" name="back_E" type="text" value=""></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input name="back_burn" type="radio" value="OK" checked="checked">OK&nbsp;<input name="back_burn" type="radio" value="NG">NG</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input name="check_surface" type="radio" value="OK" checked="checked">OK&nbsp;<input name="check_surface" type="radio" value="NG">NG</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input name="check_exterior" type="radio" value="OK" checked="checked">OK&nbsp;<input name="check_exterior" type="radio" value="NG">NG</td>
	</tr>
</table>
<br>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td bordercolor=#DEDBD6 class="TD_STYLE2" colspan="6" align="center"><%=demo.getLang("erp", "成品检查")%></td>
		
	</tr>
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "表层卷纸确认：打孔重复")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "双侧面确认：平整度、纸管位")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "产生瑕疵的原因")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "打孔次数")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "成品实际长度")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "机长判定")%></td>
		
		
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input name="check_hole_repeat" type="radio" value="有">有&nbsp;<input name="check_hole_repeat" type="radio" value="无" checked="checked">无</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input name="check_flatness" type="radio" value="OK" checked="checked">OK&nbsp;<input name="check_flatness" type="radio" value="NG">NG</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="check_error_result" type="text" value=""></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="text-align: right" name="check_hole_count" type="text" value=""></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="text-align: right" name="product_final_length" type="text" value=""></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input name="check_result" type="radio" value="合格" checked="checked">合格&nbsp;<input name="check_result" type="radio" value="不合格">不合格</td>
		
	</tr>
</table>
<br>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" style="width: 9%"><%=demo.getLang("erp", "登录人")%>：</td>
		<td <%=TD_STYLE2%>  style="width: 24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_hole_register" type="text" value="<%=register %>" style="width: 80%"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" style="width: 9%"><%=demo.getLang("erp", "登录时间")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" style="width: 24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_hole_register_time" type="text" value="<%=time.substring(0,10) %>" style="width: 80%"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" style="width: 9%"><%=demo.getLang("erp", "操作自检人")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_hole_operator" type="text" value="" style="width: 80%"></td>
	</tr>
	
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>"
	value="<%=session.getAttribute(Globals.TOKEN_KEY)%>"></form>
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

Calendar.setup ({inputField : "product_hole_date", ifFormat : "%Y-%m-%d", showsTime : false, button : "product_hole_date", singleClick : true, step : 1});
</script>
