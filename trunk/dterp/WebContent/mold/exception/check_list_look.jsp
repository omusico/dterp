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
<%nseer_db mold_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
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
<script language="javascript">
function openS()
{
open("query_picture.jsp?id=<%=Integer.parseInt(request.getParameter("mold_id"))%>","","height=600,width=680,toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=yes");
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
<form id="mutiValidation" method="post" onSubmit="return TwoSubmit(this)">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1">
		<INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked><%=demo.getLang("erp", "未通过")%>
		<INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind> <%=demo.getLang("erp", "通过")%> 
		<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1">&nbsp;
		<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();">
		<input type="button" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","查看不良照片")%>"  onclick="openS()">
		</div>
		</td>
	</tr>
</table>

 <script>
 function lookCheck(){
 
 	window.location.href="query_list_look.jsp";
 
 }
 </script>
 <%
 int id=Integer.parseInt(request.getParameter("id"));
 try{
String sql1="SELECT * FROM mold_exception left join mold_info on mold_exception.mold_id=mold_info.id where mold_exception.id='"+id+"'";
ResultSet rs1 = mold_db.executeQuery(sql1); 
if(rs1.next())
{
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
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","模具异常申请单")%></b></font></td>
  <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>

 </tr>
 </table>
 <br />

 <table align="center" width="100%"  border="0">
  <tr >
    <td width="9%" align=right>模具规格：</td>
    <td width="26%"><input readonly="readonly" id="mold_spec" value="<%=rs1.getString("mold_spec")%>" name="mold_spec" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 50%"></td>
    <td width="10%" align=right>模具编号：</td>
    <td width="26%"><input readonly="readonly" id="mold_code" value="<%=rs1.getString("mold_code")%>" name="mold_code" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 50% "></td>
     <td width="9%" align=right>入库时间：</td>
    <td width="26%"><input readonly="readonly" id="stoct_time" name="stoct_time" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 60% " value="<%=rs1.getString("stock_time")%>"></td>
  </tr>
   <tr >
    <td width="9%" align=right>组装者：</td>
    <td width="26%"><input readonly="readonly" id="zu" name="mold_spec" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 50%" value="<%=rs1.getString("assembler")%>"></td>
    <td width="9%" align=right>组装时间：</td>
    <td width="26%"><input readonly="readonly" id="zuTime" name="mold_code" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 50% " value="<%=rs1.getString("assembly_time")%>"></td>
    <td width="9%" align=right>安装者：</td>
    <td width="26%"><input readonly="readonly" id="an" name="stoct_time" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 60% " value="<%=rs1.getString("installer")%>"></td>
</tr>
<tr >
    <td width="9%" align=right>安装时间：</td>
    <td width="26%"><input readonly="readonly" id="anTime" name="mold_spec" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 50%" value="<%=rs1.getString("installation_time")%>"></td>
    <td width="9%" align=right >&nbsp;</td>
    <td width="26%">&nbsp;</td>
    <td width="9%" align=right>&nbsp;</td>
    <td width="26%">&nbsp;</td>
</tr>
  </table>
<table align="center" width="100%"  border="0">
  <tr><td>&nbsp;&nbsp;</td></tr>
	<tr>
    <td width="9%" align="right" style="vertical-align:top;" >异常信息：</td>
    <td colspan="3">
  		    <textarea class="TEXTAREA_STYLE1" name="exception_content" style="width:90%" rows="10"><%=rs1.getString("exception_content")%></textarea>
  		  </td>
  </tr>
  

  
  <%
  String register_time=rs1.getString("exception_regist_time");

  if(register_time.length()>10)
  {
  	register_time=register_time.substring(0,10);
  }
  	
  %>
  <tr>
   <td width="9%" align=right>登记人：</td>
   <td width="41%"><input readonly="readonly" name="exception_register" value="<%=rs1.getString("exception_register")%>" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; width : 50%"></td>
    <td width="10%" align=right>登记时间：</td>
    <td width="40%"><input readonly="readonly" name="exception_regist_time" value="<%=register_time%>" type="text" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 50% " ></td>
  <td style="display:none"></td>
  </tr>
   <tr><td>&nbsp;&nbsp;</td></tr>
   <tr>
   <td width="9%" align=right>审核人：</td>
   <td width="41%"><input readonly="readonly" name="exception_checker" type="text" value="<%=register %>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; width : 50%"></td>
    <td width="10%" align=right>审核时间：</td>
    <td width="40%"><input readonly="readonly" name="exception_check_time" type="text" value="<%=time %>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000;width : 50% " ></td>
  <td style="display:none"></td>
  </tr>
  <tr><td>&nbsp;&nbsp;</td></tr>

  </table>

<script type="text/javascript">
 function TwoSubmit(form){
 var res=confirm("是否确认该操作？");
if(res)
{
if (form.Ref[0].checked){
form.action = "check_delete.jsp?id=<%=exchange.unHtmls(Integer.toString(rs1.getInt("mold_exception.id")))%>";
}
else{
form.action = "check_ok.jsp?id=<%=exchange.unHtmls(Integer.toString(rs1.getInt("mold_exception.id")))%>";
}
}else
{
	return false;
}
}
</script>
<%	
mold_db.close();
}
}
catch(Exception ex){ex.printStackTrace();}
%>

<%@include file="../include/paper_bottom.html"%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 </form>
 </div>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>