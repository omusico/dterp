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
<%nseer_db stock_db2 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
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
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>

<script type="text/javascript">
function delSelect(){
 var checkboxs = document.getElementsByName("checkbox");
 var table = document.getElementById("tableOnlineEdit");
 var tr = table.getElementsByTagName("tr");
 for (var i=0; i<checkboxs.length; i++) {
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
function removeTr(obj) {
 var sTr = obj.parentNode.parentNode;
 sTr.parentNode.removeChild(sTr);
}
</script>

<script>

function productCheck(ag,aud){
	
	var rad = document.getElementById("radio").checked;
	//window.location.href="check_list_auditing_radio.jsp?flag="+rad;
	var rss = confirm("是否确认该操作？");
	if(rss){
		if(rad){
			document.forms[0].action="../../stock_product_comeinDepartAction.do?m=noAudting&id="+ag+"&sake="+aud;
		}else{
			document.forms[0].action="../../stock_product_comeinDepartAction.do?m=audting&id="+ag+"&sake="+aud;
		}
	}else{
		return false;
	}
}

function delSelect(){
	window.location.href="check_list.jsp";	
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
		<div class="div_handbook"><%="您正在做的业务是：库存管理--入库管理--入库登记审核"%></div>
		</td>
	</tr>
</table>

<%
	nseer_db stock_db1 = new nseer_db((String) session.getAttribute("unit_db_name"));
	nseer_db stock_ttock = new nseer_db((String) session.getAttribute("unit_db_name"));
	int id = 0;
	id = Integer.parseInt(request.getParameter("order_id"));
	int proId = Integer.parseInt(request.getParameter("proId"));//原料入库类型

	String sql = "select * from stock_in inner join stock_in_apply on stock_in_apply.id = stock_in.stock_in_apply_id inner join hr_file on hr_file.idcard= stock_in.stock_in_operator_id where stock_in.id = " + id;

	ResultSet rs = stock_db.executeQuery(sql);

	if (rs.next()) {
%>

<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="POST" onsubmit="return productCheck(<%=id %>,<%=proId %>)">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8"><input type="radio"
			id="radio" name="radio" checked /> 未通过 &nbsp; <input type="radio"
			name="radio" /> 通过&nbsp; <input type="submit" <%=BUTTON_STYLE1%>
			class="BUTTON_STYLE1"
			value="<%=demo.getLang("erp","确定")%>"> &nbsp;<input
			type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"
			onclick="window.history.back()" value="<%=demo.getLang("erp","返回")%>">&nbsp;
	<input type="hidden" name="id" value="<%=id %>" />
		</td>
	</tr>
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
%> <input type="hidden" name="new_apply" value="<%=new_apply%>">
<input name="gather_ID" type="hidden" value="<%=gather_ID%>"> <%@include
	file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp", "入库审核")%></b></font></td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp", "入库单号")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align: left"><input readonly="readonly"
			type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; "
			name="gatherer_name" value="<%=rs.getString("stock_in.stock_in_code") %>"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="11%">入库申请单号：</td>
		<td style="text-align: left"><input type="text" readonly="readonly" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " name="gatherer_name" value="<%=rs.getString("stock_in_apply.apply_in_apply_code") %>" /></td>
	</tr>
	<tr>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="11%">入库人：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align: left"><input readonly="readonly"
			type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; "
			name="gatherer_name" value="<%=rs.getString("hr_file.human_name") %>"></td>
		<%
		if (proId == 2) {
		%>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="11%">入库理由：</td>
		<td><input type="text" readonly="readonly" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " name="gatherer_name" value="原材料入库" /></td>
		<%
		}
		%>
		<%
		if (proId == 4) {
		%>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="11%">入库理由：</td>
		<td><input type="text" readonly="readonly" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " name="gatherer_name" value="成品入库" /></td>
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

<%
if (proId == 2) {
%>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" cols=1 id=tableOnlineEdit1
	style="text-align: center">

	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "原纸规格")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp", "LOT No.")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "Invoice No.")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp", "宽度（mm）")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp", "长度（m）")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp", "重量（kgs）")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","入库时间")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","库位")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","入库状态")%></td>
	</tr>
	<%
				String sql_t = "select * from stock_in_detail inner join product_info on stock_in_detail.In_Detail_product_id=product_info.id where stock_in_id='"
				+ rs.getString("stock_in.id") + "'";
				ResultSet rs45 = stock_db1.executeQuery(sql_t);
				while (rs45.next()) {
					String loginTime = rs.getString("stock_in_time");
					loginTime = loginTime.substring(0,10);
	%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%>
			value="<%=rs45.getString("In_Detail_spec") %>" class="INPUT_STYLE4"
			name="product_name" type="text" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%>
			class="INPUT_STYLE4" value="<%=rs45.getString("product_lot_no") %>"
			name="product_ID" type="text" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2">
		<input <%=INPUT_STYLE4%>
			value="<%=rs45.getString("In_Detail_invoice_no")%>" class="INPUT_STYLE4"
			name="product_name" type="text" onFocus="this.blur()">
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%>
			value="<%=rs45.getString("In_Detail_length")%>" class="INPUT_STYLE4"
			name="product_name" type="text" onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text"
			<%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unit"
			value="<%=rs45.getString("In_Detail_width") %>"
			onFocus="this.blur()"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%>
			class="INPUT_STYLE4" name="cost_price" type="text"
			onFocus="this.blur()"
			value="<%=rs45.getString("In_Detail_weight")%>"></td>
		
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> value="<%=loginTime%>" class="INPUT_STYLE4" name="product_name" type="text" onFocus="this.blur()"></td>
 
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_price" type="text"  onFocus="this.blur()" value="<%=rs45.getString("product_stock") %>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> value="已入库" class="INPUT_STYLE4" name="product_name" type="text" onFocus="this.blur()"></td>

	</tr>
	<%
	}
	%>
</table>
<%
}
%> <%
 if (proId == 4) {
 %>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" cols=1 id=tableOnlineEdit1
	style="text-align: center">
	<thead>
		<tr <%=TR_STYLE2%> class="TR_STYLE2">
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp", "原纸规格")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp", "模具规格")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp", "栈板号")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp", "托盘")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp", "数量（卷）")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp", "净重（kgs）")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp", "客户")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","入库时间")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","库位")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","入库状态")%></td>
		</tr>
		<%
					String sql_t = "select * from stock_in_detail inner join package_info on stock_in_detail.In_Detail_product_id=package_info.id where stock_in_id='"+ rs.getString("stock_in.id") + "'";
					ResultSet rs45 = stock_db1.executeQuery(sql_t);
					while (rs45.next()) {
				String sql14 = "select CUSTOMER_NAME from crm_file where id="
						+ rs45.getString("In_Detail_custom_id");
				ResultSet rs14 = stock_ttock.executeQuery(sql14);
				String custem = "";
				if (rs14.next()) {
					custem = rs14.getString("CUSTOMER_NAME");
				}
				String loginTime = rs.getString("stock_in_time");
				loginTime = loginTime.substring(0,10);
		%>
		<tr <%=TR_STYLE1%> class="TR_STYLE1">
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%>
				value="<%=rs45.getString("product_spec") %>" class="INPUT_STYLE4"
				name="product_name" type="text" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%>
				class="INPUT_STYLE4"
				value="<%=rs45.getString("mold_spec") %>" name="product_ID"
				type="text" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%>
				value="<%=rs45.getString("package_pallet")%> " class="INPUT_STYLE4"
				name="b_prodcu_name" type="text" onFocus="this.blur()"></span><input
				<%=INPUT_STYLE4%> class="INPUT_STYLE4" value=""
				name="product_describe" type="hidden" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%>
				value="<%=rs45.getString("In_Detail_pallet")%>" class="INPUT_STYLE4"
				name="product_name" type="text" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text"
				<%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unit"
				value="<%=rs45.getString("In_Detail_pallet_count")%>"
				onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%>
				class="INPUT_STYLE4" name="cost_price" type="text"
				onFocus="this.blur()"
				value="<%=rs45.getString("In_Detail_weight")%>"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%>
				class="INPUT_STYLE4" name="cost_price" type="text"
				onFocus="this.blur()" value="<%=custem%>"></td>
			
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> value="<%=loginTime %>" class="INPUT_STYLE4" name="product_name" type="text" onFocus="this.blur()"></td>


 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="cost_price" type="text"  onFocus="this.blur()" value="<%=rs45.getString("package_stock") %>"></td>

 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> value="已入库" class="INPUT_STYLE4" name="product_name" type="text" onFocus="this.blur()"></td>

		</tr>
		<%
		}
		%>
	</thead>
</table>
<%
}
%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">

	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp", "总件数")%>：</td>
		<td  width="40%"><%=rs.getString("stock_in_count")%></td>
	</tr>
	<%-- 
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp", "备注")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%">
		<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" readonly="readonly" name="remark"><%=rs.getString("stock_in_remark") %></textarea>
		</td>
	</tr>
	--%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">

		<td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp", "审核人")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align: left"><input type="text" readonly="readonly" value="<%=session.getAttribute("realeditorc") %>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " name="registerPerson"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp", "审核时间")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%" style="text-align: left"><input type="text" readonly="readonly" value="<%=time.substring(0,10) %>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " name="registerTime" /></td>
	</tr>
</table>
</form>
<%
	}
	stock_db1.close();
	stock_db.close();
	stock_ttock.close();
%> <%@include file="../include/paper_bottom.html"%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>"
	value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</div>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
