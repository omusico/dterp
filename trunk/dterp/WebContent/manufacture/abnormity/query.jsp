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
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8">
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></td>
 </tr>
</table>
<%
	String realname = (String) session.getAttribute("realeditorc");
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	String time=formatter.format(now);
	int event_product_id=Integer.parseInt(request.getParameter("event_product_id"));
	String my_sql_search = "SELECT * FROM event_info a left join product_info b on a.event_product_id = b.id where event_product_id='"+event_product_id +"'";	
	ResultSet rs1 = manufacture_db.executeQuery(my_sql_search);
	if(rs1.next())
	{
%>
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
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript'
	src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript"
	src="../../javascript/include/validate/validation-framework.js"></script>
<script language="javascript">
function TwoSubmit(form){
if (form.Ref[0].checked){
form.action = "check_delete.jsp?event_product_id=<%=exchange.unHtmls(Integer.toString(rs1.getInt("event_product_id")))%>";
}
else{
form.action = "check_ok.jsp?event_product_id=<%=exchange.unHtmls(Integer.toString(rs1.getInt("event_product_id")))%>";
}
}
</script>
<form id="mutiValidation" method="post" >

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
		<td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp", "异常信息记录")%></b></font></td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<input name="payer_ID" type="hidden" value="">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "产品批次号")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs1.getString("product_lot_no")%>" )" style="width: 100%" ReadOnly>
		</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "规格")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs1.getString("product_spec")%>" ReadOnly></td>
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "发生场所")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs1.getString("event_place")%>" ReadOnly></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "事件名")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs1.getString("event_name")%>" ReadOnly></td>
		
		
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<input name="payer_ID" type="hidden" value="">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "累计卷数")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs1.getString("event_count")%>" ReadOnly></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "异常卷数")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="dengjiren" type="text" value="<%=rs1.getString("event_exception_count")%>" ReadOnly></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "附样件数")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="dengjiren" type="text" value="<%=rs1.getString("event_attach_count")%>" ReadOnly></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "发生时间")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="event_take_time" type="text" value="<%=rs1.getString("event_take_time")%>" ReadOnly></td>
	</tr>
</table>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5"><input type="hidden" value="<%=rs1.getString("id")%>" name="even_Id"></td>
	</tr>
</table>



<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
  <tr>
    <td width="10%" align="right" style="vertical-align:top;">操作人异常描述：</td>
    <td>
  		  <textarea class="TEXTAREA_STYLE1" name="operator_ex" style="width:100%" rows="4" ReadOnly><%=rs1.getString("operator_ex")%></textarea>
  		  
  	</td> 
  </tr>
    <tr>
    <td width="10%" align="right" style="vertical-align:top;">机修师异常描述：</td>
    <td>
  		  <textarea class="TEXTAREA_STYLE1" name="repair_ex" style="width:100%" rows="4" ReadOnly><%=rs1.getString("repair_ex")%></textarea>
  	</td> 
  </tr>
      <tr>
    <td width="10%" align="right" style="vertical-align:top;">品管异常描述：</td>
    <td>
  		  <textarea class="TEXTAREA_STYLE1" name="quality_ex" style="width:100%" rows="4" ReadOnly><%=rs1.getString("quality_ex")%></textarea>
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
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "制定人")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" readonly="readonly" value="<%=rs1.getString("event_designer")%>"></td>
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "制定时间")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs1.getString("event_design_time")%>" ReadOnly></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "当班负责人")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs1.getString("event_operater")%>" ReadOnly></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%">&nbsp;</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">&nbsp;</td>
	</tr>
</table>  
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "审核人")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" readonly="readonly" value="<%=realname%>" ReadOnly></td>
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "审核时间")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" readonly="readonly" value="<%=time%>" ReadOnly></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%">&nbsp;</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">&nbsp;</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%">&nbsp;</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">&nbsp;</td>
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
	}
		manufacturedb.close();

	
	manufacture_db.close();
%>
