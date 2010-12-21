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
<script language="javascript">
function TwoSubmit(form){
	var flag=true;
    var m=document.getElementById("m");
	if (form.Ref[0].checked){
		var res=confirm("确定删除该信息？");
		if(res){
			m.value="del";
		}else{
			flag=false;
		}
	}else{
		m.value="check";
		
	}
	return flag;
}
</script>
<%
String checker_ID = (String) session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String time = formatter.format(now);

String id=request.getParameter("id");//获取原料表id
String sql_all="select id,product_machine,product_produce_location,product_spec_id,product_spec,product_lot_no,product_middle_lot_no,product_status "
	+"from product_info where id="+id;
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
		
		String sql_mold="select id,mold_spec,mold_location,mold_machine_number,mold_code,mold_hole_count "
			+"from mold_info where mold_location=3 and mold_machine_number="+product_machine;
		ResultSet rs_mold=manufacture_db.executeQuery(sql_mold);
		if(rs_mold.next()){
			mold_style_id=rs_mold.getString("mold_spec");
			mold_code=rs_mold.getString("mold_code");
			mold_hole_count=rs_mold.getString("mold_hole_count");
			
		}
	}
	
%>
<form id="mutiValidation" method="post" action="../../manufacture_procedure_ActionProcedure.do" onsubmit="return TwoSubmit(this)">
<input type="hidden" name="m" id="m" value="" >
<input type="hidden" name="id" value="<%=id %>" >
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8">
		<INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked><%=demo.getLang("erp", "未通过")%>
		<INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind> <%=demo.getLang("erp", "通过")%> 
		<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1">&nbsp;
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
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "天气")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2"  align="left">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=weather %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "气温")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=temperature %>" style="width: 150" onFocus="this.blur()">℃</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "湿度")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2"  align="left">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=humidity %>" style="width: 150" onFocus="this.blur()">%RH</td>
		
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
		while(rs_part.next()){
			String pstatus="";
			String lotnot="";
			String sql_pstatus="select product_pstatus,id,product_lot_no,product_status from product_info where id="+rs_part.getString("id");
			ResultSet rs_pstatus=manufacturedb1.executeQuery(sql_pstatus);
			if(rs_pstatus.next()){
				lotnot=rs_pstatus.getString("product_lot_no");
				if(rs_pstatus.getString("product_status").equals("3")||rs_pstatus.getString("product_status").equals("4")||rs_pstatus.getString("product_status").equals("6")||rs_pstatus.getString("product_status").equals("1")){
				pstatus=rs_pstatus.getString("product_pstatus");
				}
			}
			
			
			sql_info="select * from product_4_info where product_id='"+rs_part.getString("id")+"'";
			
			ResultSet rs_info=manufacturedb1.executeQuery(sql_info);
			if(rs_info.next()){
	%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_spec %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=lotnot %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=product_produce_location %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_status %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=pstatus %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_4_width") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_4_before_thickness") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_4_after_thickness") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_4_fact_length") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_4_date") %>" onFocus="this.blur()"></td>	
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_4_time") %>" onFocus="this.blur()"></td>	
	</tr>
	<%		}
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
			while(rs_exp.next()){
			sql_info="select * from product_4_info where product_id='"+rs_exp.getString("id")+"'";
				
			ResultSet rs_info=manufacturedb1.executeQuery(sql_info);
			if(rs_info.next()){
			if(rs_info.getString("product_4_notedefect_content").equals("")&&rs_info.getString("product_4_workdefect_content").equals("")){
				//无异常
			%>
			<tr <%=TR_STYLE1%> class="TR_STYLE1">
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="无异常" onFocus="this.blur()"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="" onFocus="this.blur()"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="" onFocus="this.blur()"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="" onFocus="this.blur()"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="" onFocus="this.blur()"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="" onFocus="this.blur()"></td>
			</tr>	
			<%		
			}else if((!rs_info.getString("product_4_notedefect_content").equals(""))&&rs_info.getString("product_4_workdefect_content").equals("")){
				//工程内缺陷
			%>
			<tr <%=TR_STYLE1%> class="TR_STYLE1">
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="工程内缺陷" onFocus="this.blur()"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_4_notedefect_start") %>" onFocus="this.blur()"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_4_notedefect_sharp") %>" onFocus="this.blur()"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_4_notedefect_size") %>" onFocus="this.blur()"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_4_notedefect_content")%>" onFocus="this.blur()"></td>
				<%
				String other="";
				if(!rs_info.getString("product_4_notedefect_content_other").equals("null")){
					other=rs_info.getString("product_4_notedefect_content_other");
				}
				%>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=other %>" onFocus="this.blur()"></td>
			</tr>	
			<%	
			}else if(rs_info.getString("product_4_notedefect_content").equals("")&&(!rs_info.getString("product_4_workdefect_content").equals(""))){
				//现票内缺陷
			%>
			<tr <%=TR_STYLE1%> class="TR_STYLE1">
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="现票内缺陷" onFocus="this.blur()"></td>
				
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_4_workdefect_start") %>" onFocus="this.blur()"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_4_workdefect_sharp") %>" onFocus="this.blur()"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_4_workdefect_size") %>" onFocus="this.blur()"></td>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_4_workdefect_content") %>" onFocus="this.blur()"></td>
				<% 
				String other="";
				if(!rs_info.getString("product_4_workdefect_content_other").equals("null")){
					other=rs_info.getString("product_4_workdefect_content_other");
				}
				%>
				<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=other %>" onFocus="this.blur()"></td>
			
			</tr>	
			<%	
			}
			}
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
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=register %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "登录时间")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" width="24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=register_time %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "操作自检人")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" width="24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=operator %>" onFocus="this.blur()"></td>
		
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
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "审核人")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker" type="text" value="<%=checker_ID %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "审核时间")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker_time" type="text" value="<%=time %>" onFocus="this.blur()"></td>
	</tr>
</table>
<%	
}else if(product_produce_location.equals("8mm切")){
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
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_8mm_temperature" type="text" value="<%=weather %>"  onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "气温")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_8mm_temperature" type="text" value="<%=temperature %>" style="width: 80%" onFocus="this.blur()">℃</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "湿度")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2"  align="left">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_8mm_humidity" type="text" value="<%=humidity %>" style="width: 80%" onFocus="this.blur()">%RH</td>
		
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
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_8mm_date %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "加工时间")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_8mm_time %>" onFocus="this.blur()"></td>
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
	while(rs_part.next()){
		String pstatus="";
		String lotnot="";
		String sql_pstatus="select product_pstatus,id,product_status,product_lot_no from product_info where id="+rs_part.getString("id");
		ResultSet rs_pstatus=manufacturedb1.executeQuery(sql_pstatus);
		
		if(rs_pstatus.next()){
			lotnot=rs_pstatus.getString("product_lot_no");
			if(rs_pstatus.getString("product_status").equals("3")){
			pstatus=rs_pstatus.getString("product_pstatus");
			}
		}
		
		
		sql_info="select * from product_8mm_info where product_id='"+rs_part.getString("id")+"'";
		
		ResultSet rs_info=manufacturedb1.executeQuery(sql_info);
		if(rs_info.next()){
	
	
	
	
	
	%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<input name="part_id" type="hidden" value="<%=rs_info.getString("id") %>">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_spec %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=lotnot %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=product_produce_location %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_status %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=pstatus %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_8mm_fact_length") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_8mm_fact_width") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2">
				<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_8mm_paper_exterior") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2">
		<%if(rs_info.getString("product_8mm_paper_exterior_other").equals("null")){
		%>
		<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%="" %>" onFocus="this.blur()">
		<%	
		}else{
		%>
		<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_8mm_paper_exterior_other") %>" onFocus="this.blur()">
		<%	
		} %>
				</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2">
				<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_8mm_volume_exterior") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2">
		<%if(rs_info.getString("product_8mm_volume_exterior_other").equals("null")){
		%>
		<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%="" %>" onFocus="this.blur()">
		<%	
		}else{
		%>
		<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_8mm_volume_exterior_other") %>" onFocus="this.blur()">
		<%	
		} %>
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2">
				<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_8mm_defect") %>" onFocus="this.blur()"></td>
		<%--<td <%=TD_STYLE2%> class="TD_STYLE2">
		<%if(rs_info.getString("product_8mm_defect_other").equals("null")){
		%>
		<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%="" %>" onFocus="this.blur()">
		<%	
		}else{
		%>
		<input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_8mm_defect_other") %>" onFocus="this.blur()">
		<%	
		} %>
		</td>--%>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_8mm_peel") %>" onFocus="this.blur()"></td>
		</tr>
	
	<%}} %>
	
	
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
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="product_8mm_operator" type="text" value="<%=operator %>" onFocus="this.blur()"></td>
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
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "审核人")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker" type="text" value="<%=checker_ID %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "审核时间")%>&nbsp;&nbsp;：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker_time" type="text" value="<%=time %>" onFocus="this.blur()"></td>
	</tr>
</table> 
	<%
	
	
}else if(product_produce_location.equals("打孔")){
	//得到打孔生产信息
	String product_length="";//长度
	String sql_length="select product_length from design_file where id="+product_spec_id;
	ResultSet rs_length=manufacture_db.executeQuery(sql_length);
	if(rs_length.next()){
		product_length=rs_length.getString("product_length");
		
	}
	
	String sql_details="select product_pstatus,id,father_product_id,product_produce_location,product_spec_id,product_spec,product_lot_no,product_status from product_info where father_product_id="+id;
	ResultSet rs_details=manufacture_db.executeQuery(sql_details);
	String sql_info="";
	
	if(rs_details.next()){
		//查出一条信息获取基本信息
		sql_info="select * from product_hole_info where product_id='"+rs_details.getString("id")+"'";
		ResultSet rs_info=manufacturedb.executeQuery(sql_info);
		if(rs_info.next()){
			
		
	
	%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" style="width: 9%" align="left"><%=demo.getLang("erp", "发生场所")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" style="width: 24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_produce_location %>" style="width: 80%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" style="width: 9%"><%=demo.getLang("erp", "产品规格")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" style="width: 24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_spec %>" style="width: 80%" onFocus="this.blur()"></td>

		<td <%=TD_STYLE1%> class="TD_STYLE8" style="width: 9%"><%=demo.getLang("erp", "长度")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_length %>" style="width: 80%" onFocus="this.blur()">m</td>
		
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
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs_info.getString("product_final_lot_no") %>" style="width: 80%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "状态")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=product_status %>" onFocus="this.blur()" style="width: 80%" onFocus="this.blur()"></td>
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
		
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs_info.getString("mold_size_length") %>" style="width:50" onFocus="this.blur()">×
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs_info.getString("mold_size_width") %>" style="width:50" onFocus="this.blur()">mm</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "气温")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs_info.getString("product_hole_temperature") %>" style="width:50" onFocus="this.blur()">℃</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "湿度")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs_info.getString("product_hole_humidity") %>" style="width:50" onFocus="this.blur()">%RH</td>
		
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
	<%
	String mold_spec="";
	String sql_mold_spec="select mold_spec_id,id,mold_spec "
		+"from mold_info where mold_location=3 and mold_spec_id="+rs_info.getString("mold_style_id");
	ResultSet rs_moldspec=manufacturedb1.executeQuery(sql_mold_spec);
	if(rs_moldspec.next()){
		mold_spec=rs_moldspec.getString("mold_spec");
	}
	%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "角孔型号")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=mold_spec %>" style="width: 80%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "产品状态")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs_details.getString("product_pstatus") %>" style="width: 80%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "加工日期")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" type="text" value="<%=rs_info.getString("product_hole_date") %>" style="width: 80%" onFocus="this.blur()" ></td>
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
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_hole_num") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_hole_time") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_dust_clean") %>" onFocus="this.blur()"></td>
		<%
		String product_needle_status=rs_info.getString("product_needle_status");
		if(product_needle_status.equals("缺少")){
			product_needle_status="缺"+rs_info.getString("product_needle_content")+"枚";
		}
		%>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=product_needle_status %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=mold_code %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs_info.getString("mold_hole_count") %></td>
	</tr>   
</table>
<br>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="6"><%=demo.getLang("erp", "生纸带检查")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3"><%=demo.getLang("erp", "前样测定")%></td>
	</tr>
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "生纸带批次号")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "生纸带实际长度(m)")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "纸宽(mm)")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "纸厚(mm)")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "纸表面正反面确认")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "外观检查")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "2m前样:圆孔")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "2m前样:角孔")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "10P0(mm)")%></td>
		
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_middle_lot_no") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("prodcut_middle_length") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_middle_width") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_middle_thickness") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_surface") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_exterior") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("2front_circle") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("2front_square") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("front_10P0") %>" onFocus="this.blur()"></td>
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
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "E")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "确定角孔灼烧程度")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "角孔灼烧程度、折痕、污渍、损伤")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "停机时已经加工米数")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "加工终了时，纸带状态")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "加工终了(确认颗粒数)")%></td>
		
		
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("front_E") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("front_burn") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("stop_damage") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("stop_length") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("final_status") %>" onFocus="this.blur()"></td>
		<%
		String final_particles=rs_info.getString("final_particles");
		if(final_particles.equals("有")){
			final_particles="有"+rs_info.getString("final_particles_content")+"粒";
		}
		%>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=final_particles %>" onFocus="this.blur()"></td>
	</tr>
</table>

<br>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="5"><%=demo.getLang("erp", "后样测定")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2"><%=demo.getLang("erp", "成品检查")%></td>
	</tr>
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "2米后样:圆孔")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "2米后样:角孔")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "10P0(mm)")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "E")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "确定角孔灼烧程度")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "外观整体确认：损伤，污渍")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "表层、双侧面卷纸确认:纸屑吸附")%></td>
		
		
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("2back_circle") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("2back_square") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("back_10P0") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("back_E") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("back_burn") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("check_surface") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("check_exterior") %>" onFocus="this.blur()"></td>
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
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("check_hole_repeat") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("check_flatness") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("check_error_result") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("check_hole_count") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("product_final_length") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" value="<%=rs_info.getString("check_result") %>" onFocus="this.blur()"></td>
		
	</tr>
</table>
<br>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" style="width: 9%"><%=demo.getLang("erp", "登录人")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" style="width: 24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs_info.getString("product_hole_register") %>" style="width: 80%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" style="width: 9%"><%=demo.getLang("erp", "登录时间")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" style="width: 24%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs_info.getString("product_hole_register_time") %>" style="width: 80%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" style="width: 9%"><%=demo.getLang("erp", "操作自检人")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff  align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs_info.getString("product_hole_operator") %>" style="width: 80%" onFocus="this.blur()"></td>
		
		
		
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
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "审核人")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker" type="text" value="<%=checker_ID %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" ><%=demo.getLang("erp", "审核时间")%>：</td>
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE2" align="left" >
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker_time" type="text" value="<%=time %>" onFocus="this.blur()"></td>
	</tr>
	
</table>	
	<%
		}
	}
}
%>


<%@include file="../include/paper_bottom.html"%>
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
	manufacturedb1.close();
	manufacture_db.close();
%>
