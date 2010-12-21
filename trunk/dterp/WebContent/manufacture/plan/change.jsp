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
	import="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%
counter count = new counter(application);
%>
<%
			//nseer_db stock_db = new nseer_db((String) session
			//.getAttribute("unit_db_name"));
%>
<%
			//nseer_db stockdb = new nseer_db((String) session
			//.getAttribute("unit_db_name")); modify by wangshaolin
%>
<jsp:useBean id="vt" scope="page" class="validata.ValidataTag" />
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
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<%
	int i = 1;
	String changer = (String) session.getAttribute("realeditorc");
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	String time = formatter.format(now);
	String register_time = "";
	String design_ID = request.getParameter("design_ID");
	String chain_ID = "";
	String id=request.getParameter("id");
	%>
	<%--
	if (vt.validata((String) session.getAttribute("unit_db_name"),"stock_cell", "design_ID", design_ID, "check_tag").equals("1")) {
		try {
			String sqll = "select * from stock_cell where design_ID='"+ design_ID + "'";
			ResultSet rs = stock_db.executeQuery(sqll);
			if (rs.next()) {
				String cell_describe = exchange.unHtml(rs.getString("cell_describe"));
				chain_ID = rs.getString("chain_ID");
	--%>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
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
<form id="mutiValidation" method="POST"
	action="../../stock_cell_change_ok"
	onSubmit="return doValidate('../../xml/stock/stock_cell.xml','mutiValidation')">
	<input name="id" type="hidden" value="<%=id%>">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8"><%-- 添加产品参数：1-4分切，2-8mm切，3-打孔 --%>
		  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="winopen('newRegister_product_list.jsp?type=2')" value="<%=demo.getLang("erp","添加产品")%>">&nbsp;
		  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="delSelect()" value="<%=demo.getLang("erp","删除产品")%>">&nbsp;
		  <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;
		  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></td>
	</tr>
</table>
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
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
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "制定人")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="admin"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "班次")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		<select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="banci" id="" >
  			<option value="<%=demo.getLang("erp","早")%>"><%=demo.getLang("erp","早")%></option>
  		</select></td>  
		<%-- 生产理由 --%>
		<input name="reason" type="hidden" value="新发生">
		<%-- 供货时间 --%>
		<input name="demand_gather_time" type="hidden" value="<%=time%>">
		<%-- 登记时间 --%>	
		<input name="register_time" type="hidden" value="<%=time%>">
	</tr>
	
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<%//用于存放纸张信息 %>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5" cols=1 id=tableOnlineEdit style="width: 94%">   
	<thead>
		<tr <%=TR_STYLE2%> class="TR_STYLE2">
			<td <%=TD_STYLE2%> class="TD_STYLE2" style="width: 5%"><%=demo.getLang("erp", "点选")%></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "原纸品名")%>
			</td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "库存数量")%>
			</td>
			<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "数量（本）")%>
			</td>
		</tr>
		<tr height=20>
			<td align="center" class="TD_STYLE2" ><input type="checkbox" name="checkbox" id=checkLine></td>
			<td align="center" class="TD_STYLE2" ><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" style="text-align: center" name="" type="text" value="HOCTO 95L" onFocus="this.blur()"></td>
			<td align="center" class="TD_STYLE2" ><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" style="text-align: center" name="" type="text" value="20"></td>
			<td align="center" class="TD_STYLE2" ><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" style="text-align: center" name="" type="text" value="3"></td>
		</tr>
		<tr height=20>
			<td align="center" class="TD_STYLE2" ><input type="checkbox" name="checkbox" id=checkLine></td>
			<td align="center" class="TD_STYLE2" ><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" style="text-align: center" name="" type="text" value="HOCTO 96L" onFocus="this.blur()"></td>
			<td align="center" class="TD_STYLE2" ><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" style="text-align: center" name="" type="text" value="10"></td>
			<td align="center" class="TD_STYLE2" ><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" style="text-align: center" name="" type="text" value="1"></td>
		</tr>
		<tr style="display:none">
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			  <input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox" id=checkLine></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			  <input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" onFocus="this.blur()"></td>
			<td <%=TD_STYLE2%> class="TD_STYLE2">
			  <input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" type="text" onFocus="this.blur()"></td>
			<input name="type" type="hidden" onFocus="this.blur()">
		</tr>
	</thead>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "登记人")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%">
		  <input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="dengjiren" type="text" value="admin"></td>
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "登记时间")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_time" onfocus="" id="date_start" value="2010-5-30"></td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark">这里是备注</textarea>
		</td>
	</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>"
	value="<%=session.getAttribute(Globals.TOKEN_KEY)%>"></form>
</div>
<%--
		}
		} catch (Exception ex) {
			out.println("error" + ex);
		}
	} else {
		stockdb.close();
		stock_db.close();
--%>
<%-- 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button"
			<%=BUTTON_STYLE1%> class="BUTTON_STYLE1"
			value="<%=demo.getLang("erp","返回")%>" onClick=location="change_list.jsp"></div>
		</td>
	</tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp", "该记录已变更，请返回！")%></td>
	</tr>
</table>
</div>
--%>
<%
//}
%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
