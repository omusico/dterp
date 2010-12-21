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
			String register_ID = (String) session.getAttribute("human_ID");
			String realname = (String) session.getAttribute("realeditorc");
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
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript'
	src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript"
	src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript"
	src="../../javascript/input_control/Check.js"></script>
		
<script language="javascript">
function CheckForm(TheForm){

  //检查是否整数
    var txt =TheForm.event_count.value;

    var reg  =/(^\d+$)|(^\d+.\d+$)/g 
	if(!reg.test(txt)) 
	{ 
        alert("累计卷数格式错误！");
        return false;
    }
     //检查是否整数
    var txt =TheForm.event_exception_count.value;
     if(txt.search("^-?\\d+$")!=0 && txt!=''){
        alert("异常卷数格式错误！");
        return false;
    }
     //检查是否整数
    var txt =TheForm.event_attach_count.value;
     if(txt.search("^-?\\d+$")!=0 && txt!=''){
        alert("附样件数格式错误！");
        return false;
    }

    if(TheForm.event_place.value == "")
    {
    	alert("请填写事件名！");
		return(false);
    }
    else if(TheForm.OnlineEdit1.value== "")
    {
    	alert("请选择产品批次号！");
		return(false);
    }
    else if(TheForm.OnlineEdit2.value== "")
    {
    	alert("请选择产品批次号！");
		return(false);
    }else if(TheForm.event_name.value== "")
    {
    	alert("请选择产品批次号！");
		return(false);
    }
    else if(TheForm.event_operater.value== "")
    {
    	alert("请填写负责人！");
		return(false);
    }
     else if(TheForm.event_take_time.value== "")
    {
    	alert("请填写发生日期！");
		return(false);
    }
  
    return(ture);
}
var openWin=null;
function productCheck(){

document.getElementById("add").disabled="disabled";
if(openWin==null){
	window.open('newRegister_product_list.jsp?sign=0','','height=600,width=680,top =0,left=0,toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=yes')
}else{
	openWin.focus();
}
}


</script>
<%
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String time=formatter.format(now);
%>
<form name="mutiValidation" id="mutiValidation" method="post" action="register_ok.jsp" onSubmit="return CheckForm(this)">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1">
		
		<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1">
		</div>
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
		<td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp", "异常信息记录")%></b></font></td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" name="tableOnlineEdit1">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "产品批次号")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="OnlineEdit2" name="OnlineEdit2" type="text" style="width: 80%" ReadOnly> 
		<img src="../../images/finance/search.gif" id="add" onclick="productCheck()" style="width: 12%" ></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "规格")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="OnlineEdit1" name="OnlineEdit1" type="text" ReadOnly> 
		<input id="OnlineEdit3" name="OnlineEdit3" type="hidden" value="">
		</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "发生场所")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="event_name" type="text" id="eventName" ReadOnly>
		<%-- 
		<select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="event_place" id="banci" >
  			<option value="<%=demo.getLang("erp","4分切")%>"><%=demo.getLang("erp","4分切")%></option>
  			<option value="<%=demo.getLang("erp","8mm切")%>"><%=demo.getLang("erp","8mm切")%></option>
  			<option value="<%=demo.getLang("erp","打孔")%>"><%=demo.getLang("erp","打孔")%></option>
  		</select>
  		--%>
  		</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "事件名")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="event_place" type="text" id="event_place"></td>
		<input name="sign" type="hidden" value="0">
		<input name="payer_ID" type="hidden" value="">
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<input name="payer_ID" type="hidden" value="">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "累计卷数")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="event_count" type="text" value=""></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "异常卷数")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="event_exception_count" type="text" value="" id="event_exception_count"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "附样件数")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="event_attach_count" type="text" value="" id="event_attach_count"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "发生日期")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="event_take_time" type="text" value="" id="event_take_time" onkeypress="event.returnValue=false;"></td>
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
  <tr>
    <td width="10%" align="right" style="vertical-align:top;">操作人异常描述：</td>
    <td>
  		  <textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="operator_ex" style="width:100%;background-color:#FFFFCC" ></textarea>
  		  
  	</td> 
  </tr>
    <tr>
    <td width="10%" align="right" style="vertical-align:top;">机修师异常描述：</td>
    <td>
  		  <textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="repair_ex" style="background-color:#FFFFCC" rows="4"></textarea>
  	</td> 
  </tr>
      <tr>
    <td width="10%" align="right" style="vertical-align:top;" style="display:none">品管异常描述：</td>
    <td style="display:none">
  		  <textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="quality_ex" style="width:100%" rows="4" style="background-color:#FFFFCC"></textarea>
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
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="event_designer" type="text" readonly="readonly" value="<%=realname%>"></td>
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "制定时间")%>&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="event_design_time" type="text" value="<%=time%>" ReadOnly></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "当班负责人")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="event_operater" type="text" value="" id="event_operater"></td>
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
		//}
		manufacturedb.close();

	
	manufacture_db.close();
%>
<script type="text/javascript">
document.body.onunload=function(){
	if(openWin!=null){
		openWin.close();
	}
}
</script>

<script type="text/javascript">
Calendar.setup ({inputField : "event_take_time", ifFormat : "%Y-%m-%d", showsTime : false, button : "event_take_time", singleClick : true, step : 1});
</script>