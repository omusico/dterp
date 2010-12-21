<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.exchange"%>
<%@ page import="include.anti_repeat_submit.Globals"%>

<%@include file="../include/head.jsp"%>
<%@page import="org.apache.axis.session.Session"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<head>
<LINK href="../../javascript/table/onlineEditTable.css" type=text/css rel=stylesheet>
<script language="javascript" src="../../javascript/edit/editTable.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>

<script type="text/javascript">
var openWin=null;
function openS()
{
document.getElementById("add").disabled="disabled";
if(openWin==null){
	openWin=winopen("register_list.jsp","","height=600,width=680,toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=yes");
}else{
	openWin.focus();
}

}
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
function CheckForm(TheForm){
    if(TheForm.mold_spec.value == ""||TheForm.mold_code.value == "")
    {
    	alert("请选择模具！");
		return(false);
    }
    else if(TheForm.exception_content.value== "")
    {
    	alert("请填入异常信息！");
		return(false);
    }
    return(ture);
}
</script>


</head>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="POST" action="../../mold_register_exception_ok" onSubmit="return CheckForm(this)">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8">&nbsp;&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" id="add" onclick="openS()"  value="<%=demo.getLang("erp","选择模具")%>">&nbsp;<input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交")%>"></td>
 </tr>
 </table>
 <script>
 function lookCheck(){
 
 	window.location.href="query_list_look.jsp";
 
 }
 </script>
 <%

String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String time=formatter.format(now);
String gather_ID=request.getParameter("gather_ID");
String new_apply="0";
if(gather_ID==null){
new_apply="1";
gather_ID="";
}
%>
<input type="hidden" name="new_apply" value="<%=new_apply%>">
<input name="gather_ID" type="hidden" value="<%=gather_ID%>">
<%@include file="../include/paper_top.html"%>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","模具异常申请单")%></b></font></td>
 </tr>
 </table>
 <br />

 <table align="center" width="100%"  border="0">
  <tr >
    <td width="9%" align=right>模具规格：</td>
    <td width="26%"><input readonly="readonly" id="mold_spec" name="mold_spec" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 50%"></td>
    <td width="9%" align=right>模具编号：</td>
    <td width="26%"><input readonly="readonly" id="mold_code" name="mold_code" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 50% "></td>
    <td width="9%" align=right>入库时间：</td>
    <td width="26%"><input readonly="readonly" id="stoct_time" name="stoct_time" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 60% "></td>
  </tr>

<tr >
    <td width="9%" align=right>组装者：</td>
    <td width="26%"><input readonly="readonly" id="zu" name="mold_spec" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 50%"></td>
    <td width="9%" align=right>组装时间：</td>
    <td width="26%"><input readonly="readonly" id="zuTime" name="mold_code" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 50% "></td>
    <td width="9%" align=right>安装者：</td>
    <td width="26%"><input readonly="readonly" id="an" name="stoct_time" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 60% "></td>
</tr>
<tr >
    <td width="9%" align=right>安装时间：</td>
    <td width="26%"><input readonly="readonly" id="anTime" name="mold_spec" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 50%"></td>
    <td width="9%" align=right >&nbsp;</td>
    <td width="26%">&nbsp;</td>
    <td width="9%" align=right>&nbsp;</td>
    <td width="26%">&nbsp;</td>
</tr>

<tr >
    <td width="9%" align=right >&nbsp;</td>
    <td width="21%">&nbsp;</td>
    <td width="9%" align=right >&nbsp;</td>
    <td width="21%">&nbsp;</td>
    <td width="9%" align=right>&nbsp;</td>
    <td width="21%">&nbsp;</td>
</tr>

  </table>
  <table  width="100%"  border="0">
  <tr>
    <td width="9%" align="right" style="vertical-align:top;">异常信息：</td>
    
    <td>
  		
  		  <textarea class="TEXTAREA_STYLE1" name="exception_content" style="width:90%" rows="10"></textarea>
		
  		  </td> 
  </tr>
</table>
<table align="center" width="100%"  border="0">
<tr><td>&nbsp;&nbsp;</td></tr>
  <tr>
   <td width="9%" align=right>登记人：</td>
   <td width="41%"><input readonly="readonly" name="exception_register" value="<%=register%>" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; width : 50%"></td>
    <td width="10%" align=right>登记时间：</td>
    <td width="40%"><input readonly="readonly" name="exception_regist_time" value="<%=time%>" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 50% " ></td>
  <td style="display:none"><input id="id" name="id"></td>
  </tr>
</table>

<%@include file="../include/paper_bottom.html"%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 </form>
 </div>
 <script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
<script type="text/javascript">
document.body.onunload=function(){
	if(openWin!=null){
		openWin.close();
	}
}
</script>