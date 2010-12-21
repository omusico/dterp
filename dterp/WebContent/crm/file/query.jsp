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
	import="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.exchange,java.text.*,include.nseer_cookie.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
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
<jsp:useBean id="vt" scope="page" class="validata.ValidataTag" />
<%
			nseer_db crm_db = new nseer_db((String) session
			.getAttribute("unit_db_name"));
			nseer_db crmdb = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/input_control/focus.css">
<script language="javascript"
	src="../../javascript/ajax/ajax-validation-f.js"></script>
<link rel="stylesheet" type="text/css"
	href="../../css/include/nseer_cookie/xml-css.css" />
<link href="../../css/include/nseerTree/nseertree.css" rel="stylesheet"
	type="text/css">
<%
		try {
		String checker_ID = (String) session.getAttribute("human_IDD");
		String checker = (String) session.getAttribute("realeditorc");
		java.util.Date now = new java.util.Date();
		SimpleDateFormat formatter = new SimpleDateFormat(
		"yyyy-MM-dd HH:mm:ss");
		String time = formatter.format(now);
		String register_time = "";
		String customer_ID = request.getParameter("customer_ID");
		String config_id = request.getParameter("config_id");
		String id=request.getParameter("id");//客户表id
		
		try {
			String sqll = "select * from crm_file where id='"
			+ id + "'";
			ResultSet rss = crmdb.executeQuery(sqll);
			
			if (rss.next()) {
				//客户类型
				String type_name="";
				String sql_type="select * from crm_config_public_char where kind='客户类型' and id="+rss.getString("type")+" order by type_ID";
				ResultSet rs_type=crm_db.executeQuery(sql_type);
				if(rs_type.next()){
				type_name=rs_type.getString("type_name");	
				}


%>
<script language="javascript">
function TwoSubmit(form){
if (form.Ref[0].checked){
form.action = "check_delete_reconfirm.jsp?config_id=<%=config_id%>&customer_ID=<%=customer_ID%>";
}else{
form.action = "../../crm_file_check_ok?config_id=<%=config_id%>&customer_ID=<%=customer_ID%>";
}
}
function changeRadio(){
	var demand=document.getElementById("demand");
	if (form.Ref[0].checked){
		demand.disabled=disabled;
	}else{
		demand.disabled=false;
	}
}
</script>
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
		<div <%=DIV_STYLE1%> class="DIV_STYLE1">
		
		<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div>
		</td>
	</tr>
</table>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
	<tr style="background-image:url(../../images/line.gif)">
		<td colspan="4">
		<div style="width:100%; height:12; padding:3px;"><%=demo.getLang("erp", "客户详细信息")%></div>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "客户编号")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" colspan="3" width="13%">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rss.getString("customer_id") %>" style="width: 45%" onFocus="this.blur()">
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "客户名称")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rss.getString("customer_name") %>" style="width: 45%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "地址")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rss.getString("customer_address") %>" style="width:80%" onFocus="this.blur()"></td>
	</tr>
	
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "客户分类")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rss.getString("chain_name") %>" style="width: 45%" onFocus="this.blur()">
		</td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "客户类型")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=type_name %>" style="width: 45%" onFocus="this.blur()"></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "客户缩写")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rss.getString("customer_sf") %>" style="width: 45%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%">&nbsp;</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "联系人1")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rss.getString("contact_person1") %>" style="width: 45%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "联系人2")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rss.getString("contact_person2") %>" style="width: 45%" onFocus="this.blur()"></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "电话1")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rss.getString("CUSTOMER_TEL1") %>" style="width: 45%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "电话2")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rss.getString("CUSTOMER_TEL2") %>" style="width: 45%" onFocus="this.blur()"></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "传真")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rss.getString("CUSTOMER_FAX") %>" style="width: 45%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "邮政编码")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rss.getString("CUSTOMER_POSTCODE") %>" style="width: 45%" onFocus="this.blur()"></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "登记人")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rss.getString("REGISTER") %>" style="width: 45%" onFocus="this.blur()"></td>
		
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "登记时间")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rss.getString("REGISTER_TIME").substring(0,10) %>" style="width: 45%" onFocus="this.blur()"></td>
	</tr>
	<%if(rss.getString("check_tag").equals("1")){
	%>	
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "审核人")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rss.getString("checker") %>" style="width: 45%" onFocus="this.blur()"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "审核时间")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rss.getString("check_time").substring(0,10) %>" style="width: 45%" onFocus="this.blur()"></td>
	</tr>
	<%
	}
	if(rss.getString("check_tag").equals("2")){
	%>
	<tr style="background-image:url(../../images/line.gif)">
		<td colspan="4">
		<div style="width:100%; height:12; padding:3px;"><%=demo.getLang("erp", "未通过原由")%></div>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><%=demo.getLang("erp", "未通过原由")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2"  colspan="3"><textarea readonly="readonly"
			<%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="demand" id="demand"><%=rss.getString("demand") %></textarea>
		</td>
	</tr>
	<%	
		
	} %>
	
<%--
	<!-- 没用 -->
	<tr <%=TR_STYLE1%> style="display:none">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "销售人员编号")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="sales_ID"
			style="width:49%" value="<%=rss.getString("sales_ID")%>"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "登记人")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="register"
			style="width:49%"
			value="<%=exchange.toHtml(rss.getString("register"))%>"></td>
		<td><select <%=SELECT_STYLE1%> class="SELECT_STYLE1"
			name="gather_sum_limit" style="width:49%">
			<%
							String sql6 = "select * from crm_config_public_double where kind='欠款' order by type_ID";
							ResultSet rs6 = crm_db.executeQuery(sql6);
							while (rs6.next()) {
						if (rs6.getDouble("type_value") == rss
								.getDouble("gather_sum_limit")) {
			%>
			<option value="<%=rs6.getDouble("type_value")%>" selected><%=new java.text.DecimalFormat(
																(String) application
																		.getAttribute("nseerAmountPrecision"))
																.format(rs6
																		.getDouble("type_value"))%></option>
			<%
			} else {
			%>
			<option value="<%=rs6.getDouble("type_value")%>"><%=new java.text.DecimalFormat(
																(String) application
																		.getAttribute("nseerAmountPrecision"))
																.format(rs6
																		.getDouble("type_value"))%></option>
			<%
							}
							}
			%>
		</select></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><textarea
			<%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="invoice_info"><%=invoice_info%></textarea>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><textarea
			<%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="demand"><%=demand%></textarea>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><textarea
			<%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
		</td>
	</tr>
	<!--回款期限、联络期限  -->
	<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "回款期限")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select
			<%=SELECT_STYLE1%> class="SELECT_STYLE1" name="gather_period_limit"
			style="width:49%">
			<%
							String sql7 = "select * from crm_config_public_double where kind='回款' order by type_ID";
							ResultSet rs7 = crm_db.executeQuery(sql7);
							while (rs7.next()) {
						if (rs7.getDouble("type_value") == rss
								.getDouble("gather_period_limit")) {
			%>
			<option value="<%=rs7.getDouble("type_value")%>" selected><%=new java.text.DecimalFormat(
																(String) application
																		.getAttribute("nseerAmountPrecision"))
																.format(rs7
																		.getDouble("type_value"))%></option>
			<%
			} else {
			%>
			<option value="<%=rs7.getDouble("type_value")%>"><%=new java.text.DecimalFormat(
																(String) application
																		.getAttribute("nseerAmountPrecision"))
																.format(rs7
																		.getDouble("type_value"))%></option>
			<%
							}
							}
			%>

		</select></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "联络期限")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><select
			<%=SELECT_STYLE1%> class="SELECT_STYLE1" name="contact_period_limit"
			style="width:49%">
			<%
							String sql8 = "select * from crm_config_public_double where kind='联络' order by type_ID";
							ResultSet rs8 = crm_db.executeQuery(sql8);
							while (rs8.next()) {
						if (rs8.getDouble("type_value") == rss
								.getDouble("contact_period_limit")) {
			%>
			<option value="<%=rs8.getDouble("type_value")%>" selected><%=new java.text.DecimalFormat(
																(String) application
																		.getAttribute("nseerAmountPrecision"))
																.format(rs8
																		.getDouble("type_value"))%></option>
			<%
			} else {
			%>
			<option value="<%=rs8.getDouble("type_value")%>"><%=new java.text.DecimalFormat(
																(String) application
																		.getAttribute("nseerAmountPrecision"))
																.format(rs8
																		.getDouble("type_value"))%></option>
			<%
							}
							}
			%>

		</select>
	</tr>


	<jsp:useBean id="mask" class="include.operateXML.Reading" />
	<jsp:setProperty name="mask" property="file"
		value="xml/crm/crm_file.xml" />
	<%
					ResultSet rs = rss;
					String nickName = "客户档案";
	%>
	<%@include file="../../include/cDefineMouC.jsp"%>
	<input type="hidden" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
		name="checker_ID" style="width:49%" value="<%=checker_ID%>">
		--%>
</table>

<input type="hidden" name="<%=Globals.TOKEN_KEY%>"
	value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</div>
<%
			}
			crmdb.close();
			crm_db.close();
		} catch (Exception ex) {
			out.println("error" + ex);
		}
			
		
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/NseerTreeDB.js"></script>
<script type="text/javascript"
	src="../../javascript/include/nseerTree/nseertree.js"></script>
<script type="text/javascript"
	src="../../javascript/crm/file/treeBusiness.js"></script>
<script type="text/javascript" src="../../dwr/interface/Multi.js"></script>
<script type="text/javascript"
	src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../dwr/interface/kindCounter.js"></script>
<script type="text/javascript"
	src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript"
	src="../../javascript/include/covers/cover.js"></script>
<script type="text/javascript"
	src="../../javascript/include/div/divViewChange.js"></script>
<script type="text/javascript"
	src="../../javascript/include/div/divLocate.js"></script>
<!-- 实现放大镜加AJAX的JS  -->
<div id="nseer1" nseerDef="dragAble"
	style="position:absolute;left:300px;top:100px;display:none;width:450px;height:300px;overflow:hidden;z-index:1;background:#E8E8E8;">
<iframe src="javascript:false"
	style="position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe>
<TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
	<TBODY>
		<TR>
			<TD width="1%" height="1%"><IMG src="../../images/bg_0ltop.gif"></TD>
			<TD width="100%" background="../../images/bg_01.gif"></TD>
			<TD width="1%" height="1%"><IMG src="../../images/bg_0rtop.gif"></TD>
		</TR>
		<TR>
			<TD background="../../images/bg_03.gif"></TD>
			<TD>
			<div class="cssDiv1">
			<div class="cssDiv2"><%=demo.getLang("erp", "上海慧索计算机科技ERP")%></div>
			</div>
			<div class="cssDiv3" onclick="n_D.closeDiv('hidden')"
				onmouseover="n_D.mmcMouseStyle(this);"></div>
			<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"
				onmouseover="n_D.mmcMouseStyle(this);"></div>
			<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(40)"
				onmouseover="n_D.mmcMouseStyle(this);"></div>
			<div id="nseer1_0"
				style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;">
			</div>
			</TD>
			<TD background="../../images/bg_04.gif"></TD>
		</TR>
		<TR>
			<TD width="1%" height="1%"><IMG
				src="../../images/bg_0lbottom.gif"></TD>
			<TD background="../../images/bg_02.gif"></TD>
			<TD width="1%" height="1%"><IMG
				src="../../images/bg_0rbottom.gif"></TD>
		</TR>
	</TBODY>
</TABLE>
</div>
<script>
var Nseer_tree1;
function showTree(){
 if(Nseer_tree1=='undefined'||typeof(Nseer_tree1)=='object'){return;}
 Nseer_tree1 = new Tree('Nseer_tree1');
 Nseer_tree1.setParent('nseer1_0');
 Nseer_tree1.setImagesPath('../../images/');
 Nseer_tree1.setTableName('crm_config_file_kind');
 Nseer_tree1.setModuleName('../../xml/crm/file');
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","全部分类")%>',false,'1',[]);
initMyTree(Nseer_tree1);
createButton('../../xml/crm/file','crm_config_file_kind','treeButton');
}
</script>
