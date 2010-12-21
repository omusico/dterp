<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java" import="java.sql.*" import="java.util.*"
	import="java.io.*"
	import="include.nseer_db.*,include.nseerdb.*,java.text.*,include.nseer_cookie.*"%>
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
<%
			nseer_db design_db = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<%
			nseer_db designdb = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<jsp:useBean id="vt" scope="page" class="validata.ValidataTag" />

<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/input_control/focus.css">
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<link rel="stylesheet" type="text/css"
	href="../../css/include/nseer_cookie/xml-css.css" />
<link href="../../css/include/nseerTree/nseertree.css" rel="stylesheet"
	type="text/css">
<%
	String checker_ID = (String) session.getAttribute("human_IDD");
	String checker = (String) session.getAttribute("realeditorc");
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	String time = formatter.format(now);
	String register_time = "";
	String id = request.getParameter("id");
	//String id=Integer.toString((rs4.getInt("id")));
	String product_ID = request.getParameter("product_ID");
	String config_id = request.getParameter("config_id");

	try {
		String sqll = "select * from design_file where id=" + id;
		ResultSet rss = designdb.executeQuery(sqll);
		while (rss.next()) {
			String provider_group = exchange.unHtml(rss
			.getString("provider_group"));
			String product_describe = exchange.unHtml(rss
			.getString("product_describe"));
			if (rss.getString("register_time").equals(
			"1800-01-01 00:00:00.0")) {
		register_time = "";
			} else {
		register_time = rss.getString("register_time");
			}
%>
<script language="javascript">
function TwoSubmit(form){
if (form.Ref[0].checked){
var res=confirm("是否确认该操作？");
	if(res){
		form.action = "../../design_file_check_delete_ok.jsp?config_id=<%=config_id%>";
	}else{
		return;
	}
}else{
form.action = "../../design_file_check_ok?config_id=<%=config_id%>&product_ID=<%=product_ID%>";
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
<form id="mutiValidation" class="x-form" method="post"
	onSubmit="return doValidate('../../xml/design/design_file.xml','mutiValidation')&&TwoSubmit(this)">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1"><input
			type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"
			value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div>
		</td>
	</tr>
</table>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
	<tr style="background-image:url(../../images/line.gif)">
		<td colspan="4">
		<div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp", "产品信息查询")%></div>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "档案编号")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="86.5%" colspan="3">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="product_ID"
			type="text" value="<%=rss.getString("product_ID") %>"
			onFocus="this.blur()"></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "产品名称")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="product_name" type="text" style="width:80%" value="<%=rss.getString("product_name") %>" onFocus="this.blur()">
		</td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "产品简称")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="product_nick" type="text" style="width:49%" value="<%=rss.getString("product_nick") %>" onFocus="this.blur()">
		<input type="hidden" name="oldKind_chain" value="<%=rss.getString("chain_id")%> <%=exchange.toHtml(rss.getString("chain_name"))%>">
		</td>
	</tr>
	

	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "产品分类")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="fileKind_chain" type="text" style="width:49%" value="<%=rss.getString("chain_name") %>" onFocus="this.blur()">
		</td>
		<%
		String type_name="";
		String sql_t_name="select id,type_name from design_config_public_char where id="+rss.getString("type");
		ResultSet rs_t_name=design_db.executeQuery(sql_t_name);
		if(rs_t_name.next()){
			type_name=rs_t_name.getString("type_name");
		}
		%>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "用途类型")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="type" type="text" style="width:49%" value="<%=type_name %>" onFocus="this.blur()">
		</td>
	</tr>
	<%
				java.util.Date now2 = new java.util.Date();
				SimpleDateFormat formatter2 = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
				now2 = formatter2.parse(rss.getString("register_time"));
				String reg_time = formatter2.format(now2);
	%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "产品长度")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
		<%
		String product_length="";
		if(rss.getString("product_length")!=null){
			if(!rss.getString("product_length").equals("0")){
				product_length=rss.getString("product_length");
			}
		}
		%>
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="type" type="text" style="width:49%" value="<%=product_length %>" onFocus="this.blur()">
		</td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "栈板号标示")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
		<%
		String product_pallet_sf="";
		if(rss.getString("product_pallet_sf")!=null){
			product_pallet_sf=rss.getString("product_pallet_sf");
		}
		%>
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="type" type="text" style="width:49%" value="<%=product_pallet_sf %>" onFocus="this.blur()">
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "品名和规格上模")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
		<%
		String spec_top="";
		if(!rss.getString("spec_top").equals("null")){
			spec_top=rss.getString("spec_top");
		}
		%>
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="spec_top" type="text" style="width:49%" value="<%=spec_top %>" onFocus="this.blur()">
		</td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "品名和规格下模")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
		<%
		String spec_bottom="";
		if(!rss.getString("spec_bottom").equals("null")){
			spec_bottom=rss.getString("spec_bottom");
		}
		%>
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="spec_bottom" type="text" style="width:49%" value="<%=spec_bottom %>" onFocus="this.blur()">
		</td>
	</tr>

	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "图纸号上模")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
		<%
		String drawing_top="";
		if(!rss.getString("drawing_top").equals("null")){
			drawing_top=rss.getString("drawing_top");
		}
		%>
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="drawing_top" type="text" style="width:49%" value="<%=drawing_top %>" onFocus="this.blur()">
		</td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "图纸号下模")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
		<%
		String drawing_bottom="";
		if(!rss.getString("drawing_bottom").equals("null")){
			drawing_bottom=rss.getString("drawing_bottom");
		}
		%>
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="drawing_bottom" type="text" style="width:49%" value="<%=drawing_bottom %>" onFocus="this.blur()">
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "图纸号衬铁")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
		<%
		String drawing_lron="";
		if(!rss.getString("drawing_lron").equals("null")){
			drawing_lron=rss.getString("drawing_lron");
		}
		%>
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="drawing_lron" type="text" style="width:49%" value="<%=drawing_lron %>" onFocus="this.blur()">
		</td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "备注")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
			<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="c_define2" type="text" style="width:49%" value="<%=rss.getString("c_define2") %>" onFocus="this.blur()">
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "登记人")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" style="width:49%" value="<%=exchange.toHtml(rss.getString("REGISTER"))%>" onFocus="this.blur()">
		</td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "登记时间")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" style="width:49%" value="<%=exchange.toHtml(rss.getString("REGISTER_TIME").substring(0,10))%>" onFocus="this.blur()">
		</td>
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
			<%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="demand" id="demand"><%=rss.getString("remark") %></textarea>
		</td>
	</tr>
	<%	
		
	} %>


	<!-- 供应商集合  -->
	<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
		<td <%=TD_STYLE4%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp", "供应商集合")%>
		&nbsp;</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><textarea
			<%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="provider_group"><%=provider_group%></textarea>
		</td>
		<td <%=TD_STYLE4%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp", "产品描述")%>
		&nbsp;</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><textarea
			<%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="product_describe"><%=product_describe%></textarea>
		</td>
	</tr>
	<!-- 市场单价  -->
	<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp", "市场单价(元)")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="list_price"
			style="width:49%"
			value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rss.getDouble("list_price"))%>"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp", "计划成本单价")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="cost_price"
			style="width:49%"
			value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rss.getDouble("cost_price"))%>"></td>
	</tr>
	<!-- 产品经理  -->
	<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "产品经理")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" id="select4" name="select4"
			type="text" style="width:49%"
			onfocus="loadAjaxDiv('select4','kind_chain',event);this.blur();"
			value="<%=rss.getString("responsible_person_ID")%>/<%=exchange.toHtml(rss.getString("responsible_person_name"))%>"
			readonly /></td>

		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "登记人")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="register"
			style="width:49%"
			value="<%=exchange.toHtml(rss.getString("register"))%>"></td>
	</tr>
	<!-- shuilv  -->
	<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "税率")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" name="shuilv" type="text"
			style="width:49%" value="1.00" /></td>

		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%">&nbsp;</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">&nbsp;</td>
	</tr>

	<input type="hidden" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
		name="checker_ID" style="width:49%" value="<%=checker_ID%>">
	<jsp:useBean id="mask" class="include.operateXML.Reading" />
	<jsp:setProperty name="mask" property="file"
		value="xml/design/design_file.xml" />
	<%
				ResultSet rs = rss;
				String nickName = "产品档案";
	%>
	<%@include file="../../include/cDefineMouC.jsp"%>

</table>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>"
	value="<%=session.getAttribute(Globals.TOKEN_KEY)%>"></form>
<%
		design_db.close();
		}
		designdb.close();
	} catch (Exception ex) {
		out.println("error" + ex);
	}

	
%>



<%

%>
</div>

<script type='text/javascript' src='../../dwr/engine.js'></script> <script
	type='text/javascript' src='../../dwr/util.js'></script> <script
	type='text/javascript' src='../../dwr/interface/NseerTreeDB.js'></script>
<script type='text/javascript'
	src="../../javascript/include/nseerTree/nseertree.js"></script> <script
	type='text/javascript'
	src="../../javascript/design/file/treeBusiness.js"></script> <script
	type="text/javascript"
	src="../../javascript/design/file/responsible.js"></script> <script
	type='text/javascript' src='../../dwr/interface/Multi.js'></script> <script
	type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../dwr/interface/kindCounter.js'></script>
<script type="text/javascript"
	src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript"
	src="../../javascript/design/file/register.js"></script> <script
	type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<script type='text/javascript'
	src='../../javascript/include/div/divViewChange.js'></script> <script
	type='text/javascript' src='../../javascript/include/div/divLocate.js'></script><!-- 实现放大镜加AJAX的JS  -->
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
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
 Nseer_tree1.setTableName('design_config_file_kind');
 Nseer_tree1.setModuleName('../../xml/design/file');
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","全部分类")%>',false,'1',[]);
initMyTree(Nseer_tree1);
createButton('../../xml/design/file','design_config_file_kind','treeButton');

}
</script>