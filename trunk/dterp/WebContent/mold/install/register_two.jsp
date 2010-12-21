<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*,java.text.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>

<%nseer_db design_db2 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="OperateXML" class="include.nseer_cookie.OperateXML" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
	 %>
 <%@include file="../include/head.jsp"%>
<script>
function closediv(){
	var loaddiv=document.getElementById("loaddiv");
	loaddiv.style.display="none";
}

function preview(){
	document.forms[0].action = "register.jsp";
	document.forms[0].submit();
}
</script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script language="javascript" src="../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>

<script type='text/javascript' src="../../javascript/include/nseer_cookie/toolTip.js"></script>

<script type='text/javascript' src='../../javascript/include/div/divLocate.js'></script>

<body>
 <%--查询 订货单  Id--%>
 <%
    String order_no="";//模具组装编号
 	String sql="select * from option_no where no_value='SC105'";
    ResultSet option_rs= design_db2.executeQuery(sql);
    if(option_rs.next())
    {
    	order_no=option_rs.getString("no_type");
    }
    design_db2.close();
 
 %>
<div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
 <form id="mutiValidation" class="x-form" method="post" action="../../mold_register_install_ok">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div id="loaddiv" style="display:none;border:1px solid red; height:20px;background-color: #FF0033;width:58%;float :left ;" ></div>
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDraft("'mutiValidation','../../design_file_register_draft_ok','../../xml/design/design_file.xml'",request)%>&nbsp;
 
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","上一步")%>" onClick="preview()">&nbsp;
 <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1"></div>
 </td>
 </tr>
<tr>
<td align=left class="TD_STYLE2" width="40%">
组装编号：<%=demo.getLang("erp",order_no)%>
<%--
<input style="width:100%" readonly="readonly" name="" type="text" value="QR/DT-JS-19"   >
 --%>
</td> 
  </tr>
</table>
<table>
<tr>
<td>
&nbsp;
</td>
</tr>
</table>
<%--@include file="../include/paper_top.html"--%>
<%
String stock_time=request.getParameter("stock_time");
%>

<table align=center class="TABLE_STYLE4" width = "100%"> 
<tr  class="TR_STYLE1" >
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","模具规格")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="mold_spec" type="text" value="<%=request.getParameter("mold_spec")%>"  ReadOnly></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","模具编号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="mold_code" type="text" value="<%=request.getParameter("mold_code")%>"  ReadOnly></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","订单号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="purchase_code" type="text" value="<%=request.getParameter("purchase_code")%>"  ReadOnly ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","入库日期")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="stock_time" type="text" value="<%=stock_time%>"   ReadOnly></td>
 <td align=right class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 </tr>
 <tr  class="TR_STYLE1" >
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","机器号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="mold_machine_number" type="text" value="<%=request.getParameter("mold_machine_number")%>"  ReadOnly></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","上模架编号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="top_mold_code" type="text" value="<%=request.getParameter("top_mold_code")%>"  ReadOnly></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","下模架编号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="bottom_mold_code" type="text" width="100%" value="<%=request.getParameter("bottom_mold_code")%>"  ReadOnly></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","导套编号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="lock_code" type="text" width="100%" value="<%=request.getParameter("lock_code")%>"  ReadOnly></td>
 <td align=right class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 </tr>
 <tr  class="TR_STYLE1" >
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","组装者")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="assembler" type="text" value="<%=request.getParameter("assembler")%>"  ReadOnly></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","组装时间")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="assembly_time" type="text" value="<%=request.getParameter("assembly_time")%>"  ReadOnly></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","安装者")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="installer" type="text" value="<%=request.getParameter("installer")%>"  ReadOnly></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","安装时间")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="installation_time" type="text" value="<%=request.getParameter("installation_time")%>"  ReadOnly></td>
 <td align=right class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 </tr>
 <tr  class="TR_STYLE1" >
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","组装编号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="" type="text" value="QR/DT-JS-19"   ReadOnly></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","供货商")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="mold_purchase_supplier" type="text" value="<%=request.getParameter("mold_purchase_supplier")%>"  ReadOnly></td>
 <td align=right class="TD_STYLE8" width="8%" style="display:none"><%=demo.getLang("erp","使用周期")%>：</td>
 <td align=left class="TD_STYLE2" width="12%" style="display:none"><input style="width:100%" name="mold_life" type="text" width="100%" value="<%=request.getParameter("mold_life")%>"  ReadOnly></td>
 <td align=right class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 <td align=right class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 <td style="display:none"><input name="id" value="<%=request.getParameter("id")%>"></td>
 </tr>
</table>
<table style="display:none">
<tr>
<!-- 
<td><input name="mold_spec" value="<%=request.getParameter("mold_spec")%>"></td>
<td><input name="mold_code" value="<%=request.getParameter("mold_code")%>"></td>
<td><input name="purchase_code" value="<%=request.getParameter("purchase_code")%>"></td>
<td><input name="stock_time" value="<%=request.getParameter("stock_time")%>"></td>
<td><input name="mold_machine_number" value="<%=request.getParameter("mold_machine_number")%>"></td>
<td><input name="top_mold_code" value="<%=request.getParameter("top_mold_code")%>"></td>
<td><input name="bottom_mold_code" value="<%=request.getParameter("bottom_mold_code")%>"></td>
<td><input name="lock_code" value="<%=request.getParameter("lock_code")%>"></td>
<td><input name="assembler" value="<%=request.getParameter("assembler")%>"></td>
<td><input name="assembly_time" value="<%=request.getParameter("assembly_time")%>"></td>
<td><input name="installer" value="<%=request.getParameter("installer")%>"></td>
<td><input name="installation_time" value="<%=request.getParameter("installation_time")%>"></td>
<td><input name="mold_purchase_supplier" value="<%=request.getParameter("mold_purchase_supplier")%>"></td>
<td><input name="mold_life" value="<%=request.getParameter("mold_life")%>"></td>
 -->
<td><input name="1" value="<%=request.getParameter("1")%>"></td>
<td><input name="2" value="<%=request.getParameter("2")%>"></td>
<td><input name="3" value="<%=request.getParameter("3")%>"></td>
<td><input name="4" value="<%=request.getParameter("4")%>"></td>
<td><input name="5" value="<%=request.getParameter("5")%>"></td>
<td><input name="type_6" value="<%=request.getParameter("type_6")%>"></td>
<td><input name="6" value="<%=request.getParameter("6")%>"></td>
<td><input name="7" value="<%=request.getParameter("7")%>"></td>
<td><input name="8" value="<%=request.getParameter("8")%>"></td>
<td><input name="9" value="<%=request.getParameter("9")%>"></td>
<td><input name="10" value="<%=request.getParameter("10")%>"></td>
<td><input name="11" value="<%=request.getParameter("11")%>"></td>
<td><input name="12" value="<%=request.getParameter("12")%>"></td>
<td><input name="13" value="<%=request.getParameter("13")%>"></td>
<td><input name="14" value="<%=request.getParameter("14")%>"></td>
<td><input name="15" value="<%=request.getParameter("15")%>"></td>
</tr>
</table>
<%
String s16="";
if(request.getParameter("16")!=null){
	s16=request.getParameter("16");
}
String s17="";
if(request.getParameter("17")!=null){
	s17=request.getParameter("17");
}
String s18="";
if(request.getParameter("18")!=null){
	s18=request.getParameter("18");
}
String s19="";
if(request.getParameter("19")!=null){
	s19=request.getParameter("19");
}
String s20="";
if(request.getParameter("20")!=null){
	s20=request.getParameter("20");
}
String s21="";
if(request.getParameter("21")!=null){
	s21=request.getParameter("21");
}
String s22="";
if(request.getParameter("22")!=null){
	s22=request.getParameter("22");
}
String time="";
String operator=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
time=formatter.format(now);
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
String file1=path+"xml/design/design_file.xml";
List returnList=OperateXML.returnList(file1,"name","mutiValidation","name","name","required","n");
%>

<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr style="background-image:url(../../images/line.gif)" style="width:"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","安装检查信息")%></div></td></tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","1、空气流量的设定")%></td>
  <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><input type="radio" name="16" value="OK"
  <%if(!s16.equals("NG")) {%>
  checked=ture
  <%} %>
  >OK &nbsp;<input type="radio" name="16" value="NG"
    <%if(s16.equals("NG")) {%>
  checked=ture
  <%} %>
  >NG 
 </td>
</tr>
<td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","2、毛羽烧温度设定")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><input type="radio" name="17" value="OK" 
  <%if(!s17.equals("NG")) {%>
  checked=ture
  <%} %>
  >OK &nbsp;<input type="radio" name="17" value="NG"
    <%if(s17.equals("NG")) {%>
  checked=ture
  <%} %>
  >NG </td>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","3、摇杆间隙确认")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><input type="radio" name="18" value="OK" 
  <%if(!s18.equals("NG")) {%>
  checked=ture
  <%} %>
  >OK &nbsp;<input type="radio" name="18" value="NG"
    <%if(s18.equals("NG")) {%>
  checked=ture
  <%} %>
  >NG </td>
</tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","4、上、下死点位置调整")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><input type="radio" name="19" value="OK" 
   <%if(!s19.equals("NG")) {%>
  checked=ture
  <%} %>
  >OK &nbsp;<input type="radio" name="19" value="NG"
    <%if(s19.equals("NG")) {%>
  checked=ture
  <%} %>
  >NG </td>
</tr>
<td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","5、模具处微调仪确认")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><input type="radio" name="20" value="OK" 
  <%if(!s20.equals("NG")) {%>
  checked=ture
  <%} %>
  >OK &nbsp;<input type="radio" name="20" value="NG"
    <%if(s20.equals("NG")) {%>
  checked=ture
  <%} %>
  >NG </td>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","6、圆孔感应器确认")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><input type="radio" name="21" value="OK" 
   <%if(!s21.equals("NG")) {%>
  checked=ture
  <%} %>
  >OK &nbsp;<input type="radio" name="21" value="NG"
    <%if(s21.equals("NG")) {%>
  checked=ture
  <%} %>
  >NG </td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","7、纸带压块确认")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><input type="radio" name="22" value="OK" 
   <%if(!s22.equals("NG")) {%>
  checked=ture
  <%} %>
  >OK &nbsp;<input type="radio" name="22" value="NG"
    <%if(s22.equals("NG")) {%>
  checked=ture
  <%} %>
  >NG </td>
</tr>

<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/design/design_file.xml"/>
<%String nickName="产品档案";%>
<%@include file="../../include/cDefineMou.jsp"%>

</table>
<table align=center class="TABLE_STYLE4" width = "100%" border="0"> 
<tr  class="TR_STYLE1" >
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","登记人")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" value="<%=operator %>" name="mold_ai_register" type="text" readonly
 <%if(request.getParameter("mold_ai_register")==null) {%>
 	value="" 
 	<%}if(request.getParameter("mold_ai_register")!=null) {%>
 value="<%=request.getParameter("mold_ai_register")%>" 
 <%} %> ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" value<%=time %> name="mold_ai_regist_time" type="text" readonly
 <%if(request.getParameter("mold_ai_regist_time")==null) {%>
 	value="" 
 	<%}if(request.getParameter("mold_ai_regist_time")!=null) {%>
 value="<%=request.getParameter("mold_ai_regist_time")%>" 
 <%} %> ></td>
 <td align=right class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 <td align=right class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 <td align=right class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 </tr>
</table>
<%--@include file="../include/paper_bottom.html"--%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
</div>
<%design_db2.close(); %>
