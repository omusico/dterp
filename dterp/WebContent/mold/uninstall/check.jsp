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
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
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

			nseer_db mold_db = new nseer_db((String) session
			.getAttribute("unit_db_name"));
int id=Integer.parseInt(request.getParameter("id"));
try
{
String sql1="SELECT * FROM mold_info left join mold_destruction on mold_info.id=mold_destruction.mold_id where mold_info.id='"+id+"'";
ResultSet rs1 = mold_db.executeQuery(sql1); 
if(rs1.next())
{
String time="";
String operator=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
time=formatter.format(now);
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
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript'
	src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript"
	src="../../javascript/include/validate/validation-framework.js"></script>
<script language="javascript">
function openS()
{
open("query_picture.jsp?id=<%=exchange.unHtmls(Integer.toString(rs1.getInt("mold_info.id")))%>","","height=600,width=680,toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=yes");
}
function TwoSubmit(form){
var res=confirm("是否确认该操作？");
if(res)
{
if (form.Ref[0].checked){
form.action = "check_delete.jsp?id=<%=exchange.unHtmls(Integer.toString(rs1.getInt("mold_info.id")))%>";
}
else{
form.action = "check_ok.jsp?id=<%=exchange.unHtmls(Integer.toString(rs1.getInt("mold_info.id")))%>";
}
}else
{
	return false;
}
}
</script>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="post" onSubmit="return TwoSubmit(this)">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1">
		<INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked><%=demo.getLang("erp", "未通过")%>
		<INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind> <%=demo.getLang("erp", "通过")%> 
		<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1">&nbsp;
		<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div>
		</td>
	</tr>
</table>

<%--@include file="../include/paper_top.html"--%>

  <br />
 <table align="center" width="100%"  border="0">
  <tr>
    <td width="10%" align=right>模具规格：</td>
    <td class="TD_STYLE2" width="26%"><input readonly="readonly" value="<%=rs1.getString("mold_spec")%>" id="mold_spec" name="mold_spec" type="text"   ></td>
    <td width="10%" align=right>模具号：</td>
    <td  class="TD_STYLE2" width="26%"><input readonly="readonly" value="<%=rs1.getString("mold_code")%>" id="mold_code" name="mold_code" type="text"   ></td>
    <td width="10%" align=right>机器号：</td>
    <td class="TD_STYLE2" width="26%"><input readonly="readonly" value="<%=rs1.getString("mold_machine_number")%>" id="mold_machine_number" name="mold_machine_number" type="text"   ></td>
    
  </tr>
  <tr>
    <td width="10%" align=right>拆卸者：</td>
    <td  class="TD_STYLE2" width="26%"><input readonly="readonly" value="<%=rs1.getString("destruction_man")%>" name="destruction_man"  type="text"   ></td>
	<td width="10%" align=right>拆卸时间：</td>
    <td class="TD_STYLE2" width="26%"><input readonly="readonly" value="<%=rs1.getString("destruction_time")%>" name="destruction_time" type="text"  onkeypress="event.returnValue=false;" ></td>
    <td width="10%" align=right>品管追溯至卷数：</td>
    <td class="TD_STYLE2" width="26%"><input name="spool_num"  type="text" readonly="readonly" value="<%=rs1.getString("spool_num")%>"></td> 
  </tr>
   <tr style="display:none">
    <td width="10%" align=right>使用周期：</td>
    <td  class="TD_STYLE2" width="26%"><input name="mold_life"  type="text" readonly="readonly" value="<%=rs1.getString("mold_life_ul")%>"></td>  
	<td width="10%" align=right>&nbsp;</td>
    <td class="TD_STYLE2" width="26%">&nbsp;</td>
    <td width="10%" align=right>&nbsp;</td>
    <td class="TD_STYLE2" width="26%">&nbsp;</td> 
  </tr>

  </table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td style="display:none"><input id="id" name="id"></td>
		<td align=right><input type="botton" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","查看拆卸照片")%>" onclick="openS()" ReadOnly style="width:80px;height:22px;" ></td>
	</tr>
</table>

<TABLE <%=TABLE_STYLE1%> class="TABLE_STYLE1">
<tr style="background-image:url(../../images/line.gif)" style="width:"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","拆卸信息")%></div></td></tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="50%" style="vertical-align:middle; text-align:left;">1：累计：<%=rs1.getString("destruction_item1_content")%>卷时拆下、纸屑检出用模具无损伤确认</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="50%" style="vertical-align:middle; text-align:center;"><%=rs1.getString("destruction_item1")%></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="50%" style="vertical-align:middle; text-align:left;">2：打孔全程黑胶带纸粉检查无异常（累卷位置：<%=rs1.getString("destruction_item2_content")%>）</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="50%" style="vertical-align:middle; text-align:center;"><%=rs1.getString("destruction_item2")%></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="50%" style="vertical-align:middle; text-align:left;">3：导套磨损。变形（明显时图片资料说明）</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="50%" style="vertical-align:middle; text-align:center;"><%=rs1.getString("destruction_item3")%></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="50%" style="vertical-align:middle; text-align:left;">4：纸带顶紧滑块弹簧张力测定：进纸-弹簧：<%=rs1.getString("destruction_item3_content")%>g  出纸-弹簧：<%=rs1.getString("destruction_item4_content")%>g</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="50%" style="vertical-align:middle; text-align:center;"><%=rs1.getString("destruction_item4")%></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="50%" style="vertical-align:middle; text-align:left;">5：显微镜中观察：上模边角磨损（发现异常磨损时图片资料说明）</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="50%" style="vertical-align:middle; text-align:center;"><%=rs1.getString("destruction_item5")%></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="50%" style="vertical-align:middle; text-align:left;">6：显微镜中观察：下模边角磨损（发现异常磨损时图片资料说明）</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="50%" style="vertical-align:middle; text-align:center;"><%=rs1.getString("destruction_item6")%></td>
	</tr>
	

</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table align="center" border="0" width="100%">
  <tr>
    <td width="10%" align="right" style="vertical-align:top;">备注：</td>
    <td width="90%" align="left">
  		  <textarea name="destruction_remark"  rows="4" style="width:95%" ReadOnly><%=rs1.getString("destruction_remark") %></textarea>
  	</td>
  </tr>
</table>
<!-- 登记时间  -->
<%
	String stock_time=rs1.getString("mold_destruction_regist_time");
stock_time=stock_time.substring(0,10);

%>
<table align="center" width="100%"  border="0">
  <tr>
    <td width="10%" align=right>登记人：</td>
    <td class="TD_STYLE2" width="40%"><input readonly="readonly" value="<%=rs1.getString("mold_destruction_register")%>" name="mold_destruction_register" value="<%=operator %>" type="text"   ></td>
    <td width="10%" align=right>登记时间&nbsp;&nbsp;：</td>
    <td  class="TD_STYLE2" width="40%"><input readonly="readonly" value="<%=stock_time%>" name="mold_destruction_regist_time"  type="text"   ></td>
  </tr>
  </table>
  <table align="center" width="100%"  border="0">
  <tr>
    <td width="10%" align=right>审核人：</td>
    <td class="TD_STYLE2" width="40%"><input readonly="readonly" name="mold_destruction_checker" value="<%=operator %>" type="text"   ></td>
    <td width="10%" align=right>审核时间&nbsp;&nbsp;：</td>
    <td  class="TD_STYLE2" width="40%"><input readonly="readonly" name="mold_destruction_check_time" value=<%=time %> type="text"   ></td>
  </tr>
  </table>
<%	
mold_db.close();
}
}
catch(Exception ex){ex.printStackTrace();}
%>
<%--@include file="../include/paper_bottom.html"--%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>"value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
</div>
