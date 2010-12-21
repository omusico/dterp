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
<%
nseer_db mold_db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db mold_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db mold_db2 = new nseer_db((String)session.getAttribute("unit_db_name"));
%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="OperateXML" class="include.nseer_cookie.OperateXML" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
	 %>
 <%@include file="../include/head.jsp"%>
<script type="text/javascript">
function openS()
{
open("newRegister_product_list.jsp","","height=600,width=680,toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=yes");
}
function closediv(){
	var loaddiv=document.getElementById("loaddiv");
	loaddiv.style.display="none";
}
</script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script language="javascript" src="../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<link rel="stylesheet" type="text/css" href="../../css/include/nseerTree/nseertree.css">
<script type='text/javascript' src="../../javascript/include/nseer_cookie/toolTip.js"></script>
<script type='text/javascript' src='../../javascript/include/div/divLocate.js'></script>

<body>
<%
int id=Integer.parseInt(request.getParameter("id"));
try
{
String sql1 = "SELECT * FROM mold_info left join mold_purchase_order on mold_info.mold_purchase_id=mold_purchase_order.id where mold_info.id='"+id+"'";
ResultSet rs1 = mold_db.executeQuery(sql1); 
if(rs1.next())
{
String time="";
String operator=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
time=formatter.format(now);
%>
<script language="javascript">
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
<div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="post" onSubmit="return TwoSubmit(this)">
 <%--查询 订货单  Id--%>
 <%
    String order_no="";//模具组装编号
 	String sql6="select * from option_no where no_value='SC105'";
    ResultSet option_rs= mold_db2.executeQuery(sql6);
    if(option_rs.next())
    {
    	order_no=option_rs.getString("no_type");
    }
    mold_db2.close();
 
 %>
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
<tr>
<td align=left class="TD_STYLE2" width="40%">
组装编号：<%=demo.getLang("erp",order_no)%>
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
<%--入库时间 --%>
<%
	String stock_time=rs1.getString("stock_time");
         stock_time=stock_time.substring(0,10);
%>
<table align=center class="TABLE_STYLE4" width = "100%"> 
<tr  class="TR_STYLE1" >
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","模具规格")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" name="mold_spec" type="text" value="<%=rs1.getString("mold_spec")%>"   ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","模具编号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" name="mold_code" type="text" value="<%=rs1.getString("mold_code")%>"  ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","订单号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" name="purchase_code" type="text" value="<%=rs1.getString("purchase_code")%>"   ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","入库日期")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly"t name="stock_time" type="text" value="<%=stock_time%>"   ></td>
 <td align=right class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 </tr>
 <tr  class="TR_STYLE1" >
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","机器号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" name="mold_machine_number" type="text" value="<%=rs1.getString("mold_machine_number")%>"  ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","上模架编号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" name="top_mold_code" type="text" value="<%=rs1.getString("top_mold_code")%>"  ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","下模架编号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" name="bottom_mold_code" type="text" width="100%" value="<%=rs1.getString("bottom_mold_code")%>"  ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","导套编号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" name="lock_code" type="text" width="100%" value="<%=rs1.getString("lock_code")%>"  ></td>
 <td align=right class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 </tr>
 <tr  class="TR_STYLE1" >
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","组装者")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" name="assembler" type="text" value="<%=rs1.getString("assembler")%>"  ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","组装时间")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" name="assembly_time" type="text" value="<%=rs1.getString("assembly_time")%>"  ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","安装者")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" name="installer" type="text" value="<%=rs1.getString("installer")%>"  ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","安装时间")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" name="installation_time" type="text" value="<%=rs1.getString("installation_time")%>"  ></td>
 <td align=right class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 </tr>
 <tr  class="TR_STYLE1" >
<%
String sql2="SELECT * FROM crm_file where id='"+rs1.getString("mold_purchase_supplier_id")+"'";
ResultSet rs2 = mold_db1.executeQuery(sql2);

String customer_Name="";
if(rs2.next())
{
	customer_Name=rs2.getString("CUSTOMER_NAME");
}

%>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","供应商")%>：</td>
 <td align=left class="TD_STYLE2" width="12%" colspan="3"><input style="width:100%" readonly="readonly" name="mold_purchase_supplier" type="text" value="<%=customer_Name%>"  ></td>
 <td align=right class="TD_STYLE8" width="8%" style="display:none"><%=demo.getLang("erp","使用周期1")%>：</td>
 <td align=left class="TD_STYLE2" width="12%" style="display:none"><input style="width:100%" readonly="readonly" name="mold_life" type="text" width="100%" value="<%=rs1.getString("mold_life")%>"  ></td>
 <td align=right class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 <td align=right class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 </tr>
</table>

<%
sql2="SELECT * FROM mold_assembly_installation where mold_id='"+rs1.getString("id")+"'";
rs2 = mold_db1.executeQuery(sql2); 
if(rs2.next())
{
	
	%>

<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable >
<tr style="background-image:url(../../images/line.gif)" style="width:" style="display:none"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","组装检查信息")%></div></td></tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="14%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","1：模具台编号记录与实物编号相符")%></td>
  <td <%=TD_STYLE21%> class="TD_STYLE2" width="6%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("assembly_item1")%></td>
</tr>
<td <%=TD_STYLE4%> class="TD_STYLE1" width="14%" style="vertical-align:middle; text-align:left;display:none" ><%=demo.getLang("erp","2：上、下模用酒精清洗")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="6%" style="vertical-align:middle; text-align:center;display:none"><%=rs2.getString("assembly_item2")%></td>
<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="14%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","3：滚珠轴清洗、加润滑油")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="6%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("assembly_item3")%></td>
</tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="14%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","4：上模试装插入上模槽、前后无晃动")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="6%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("assembly_item4")%></td>
</tr>
<td <%=TD_STYLE4%> class="TD_STYLE1" width="14%" style="vertical-align:middle; text-align:left;display:none"><%=demo.getLang("erp","5：纸带顶紧滑块、纸粉清理")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="6%" style="vertical-align:middle; text-align:center;display:none"><%=rs2.getString("assembly_item5")%></td>
<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="14%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","6：纸带顶紧滑块弹簧张力设定(g):")%>
<%if(rs2.getString("assembly_item6_content").equals("1")) {%>
  200(H40)
  <%} %>
<%if(rs2.getString("assembly_item6_content").equals("2")) {%>
  300(H58/H60)
  <%} %>
<%if(rs2.getString("assembly_item6_content").equals("3")) {%>
  350(H75)
  <%} %>
<%if(rs2.getString("assembly_item6_content").equals("4")) {%>
  400(H95)
  <%} %>
 </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="6%" style="vertical-align:middle; text-align:center;">
 <%=rs2.getString("assembly_item6")%></td>
 
 </td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","7：纸带顶紧轴轮、纸粉清理并检查轴轮转动")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="9%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("assembly_item7")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","8：园针检查无锈迹、针头无变形、光洁度无异常")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="9%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("assembly_item8")%></td>
</tr><tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","9：导套安装后，检查对应规格厚度的纸带能穿过纸带通道")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="9%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("assembly_item9")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","10：导套固定螺丝固定适宜，表面无磨损、变形")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="9%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("assembly_item10")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","11：拆开纸屑检出器，清洗、检查并确认运转无异常")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="9%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("assembly_item11")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","12：模具上机安装前，机上纸屑检出模具无损伤确认")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="9%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("assembly_item12")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","13：集尘器压板组装前确认有无变形")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="9%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("assembly_item13")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","14：集尘器组装于下模台时，集尘器顶面于下模台面保持一平面")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="9%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("assembly_item14")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","15：检查纸带导轨侧板有无损伤")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="9%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("assembly_item15")%></td>
</tr>
<tr style="background-image:url(../../images/line.gif)" style="width:"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","安装检查信息")%></div></td></tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","1：空气流量的设定")%></td>
  <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("installation_item1")%> 
 </td>
</tr>
<td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","2：毛羽烧温度设定")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("installation_item2")%> </td>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","3：摇杆间隙确认")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("installation_item3")%> </td>
</tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","4：上、下死点位置调整")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("installation_item4")%> </td>
</tr>
<td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","5：模具处微调仪确认")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("installation_item5")%> </td>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","6：圆孔感应器确认")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("installation_item6")%> </td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","7：纸带压块确认")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><%=rs2.getString("installation_item7")%> </td>
</tr>

<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/design/design_file.xml"/>
<%String nickName="产品档案";%>
<%@include file="../../include/cDefineMou.jsp"%>

</table>
<table align=center class="TABLE_STYLE4" width = "100%" border="0"> 
<tr  class="TR_STYLE1" >
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","登记人")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" value="<%=rs2.getString("mold_installation_register")%> " name="mold_purchase_supplier" type="text"  ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" value="<%=rs2.getString("mold_installation_regist_time")%> " name="mold_ai_regist_time" type="text"  ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","审核人")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" value="<%=operator%> " name="mold_purchase_supplier" type="text"  ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" value="<%=time%> " name="mold_ai_regist_time" type="text"  ></td>
 <td align=right class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 </tr>
</table>
<%} %>
<%	
mold_db.close();
mold_db1.close();
mold_db2.close();
}
}
catch(Exception ex){ex.printStackTrace();}
%>
<%--@include file="../include/paper_bottom.html"--%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
</div>
