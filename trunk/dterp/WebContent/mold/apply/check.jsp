<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseer_cookie.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<%
			nseer_db mold_db = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="getThreeKinds" class="include.get_three_kinds.getThreeKinds" scope="page"/>
<head>
<LINK href="../../javascript/table/onlineEditTable.css" type=text/css rel=stylesheet>
<script language="javascript" src="../../javascript/edit/editTable.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<%
String apply_ID=request.getParameter("apply_ID");
%>

</head>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<!-- 控制 未通过理由 显示隐藏 -->
<script>
function changeRadio(vl){
	var demand=document.getElementById("demand");
	if (vl.value=="cop"){
		demand.disabled="";
		demand.value="";
		demand.className="MOLD_INPUT_STYLE_COP";
	}else if(vl.value=="Ind"){
		demand.disabled="disabled";
		demand.value="";
		//demand.style="width:100%;";
		demand.className="MOLD_INPUT_STYLE_IND";
	}
}

</script>

<%
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String time=formatter.format(now);
int id =Integer.parseInt(request.getParameter("id"));
try
{
String sql="SELECT * FROM mold_purchase_order_detail left join mold_purchase_order on mold_purchase_order_detail.mold_purchase_id=mold_purchase_order.id where mold_purchase_order.id='"+id+"'";
ResultSet rs = mold_db.executeQuery(sql); 
int k=0;
if(rs.next())
{
	String purchase_register=rs.getString("purchase_register");
	String purchase_register_time=rs.getString("purchase_register_time");
	String purchase_code=rs.getString("purchase_code");
	int purchase_supplier_id=rs.getInt("purchase_supplier_id");
	String remark=rs.getString("order_remark");
%>
<script language="javascript">
function TwoSubmit(form){

var res=confirm("是否确认该操作？");
if(res)
{
if (form.Ref[0].checked){
  form.action = "check_delete.jsp?id=<%=exchange.unHtmls(Integer.toString(rs.getInt("mold_purchase_order.id")))%>";
  }else
  {
  form.action = "check_ok.jsp?id=<%=exchange.unHtmls(Integer.toString(rs.getInt("mold_purchase_order.id")))%>";
  }
}else
{
return false; 
} 
}               

</script>
<form id="mutiValidation" method="post" onSubmit="return TwoSubmit(this)">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1">
		<INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked onclick="changeRadio(this)"><%=demo.getLang("erp", "未通过")%>
		<INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind onclick="changeRadio(this)"> <%=demo.getLang("erp", "通过")%> 
		<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1">&nbsp;
		<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div>
		</td>
	</tr>
</table>
<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","模具采购登记")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","经办人")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input readonly="readonly" name="purchase_operater" type="text" value="<%=rs.getString("purchase_operater")%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>
	 
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","采购时间")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input readonly="readonly" name="purchase_time" type="text" value="<%=rs.getString("purchase_time")%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>

</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","供货商")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input readonly="readonly" name="purchase_supplier_id" type="text"
<% 
String sql2="SELECT CUSTOMER_NAME FROM crm_file where id='"+purchase_supplier_id+"'";
ResultSet rs2 = mold_db.executeQuery(sql2); 
rs2.next();
%>
  value="<%=rs2.getString("CUSTOMER_NAME")%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>
	 
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","订单号")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input readonly="readonly" name="purchase_id" type="text" value="<%=purchase_code%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>

</tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","备注")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input readonly="readonly" name="remark" type="text" value="<%=remark%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " />
 <td align=right class="TD_STYLE8" width="4%"></td>
 <td align=left class="TD_STYLE2" width="20%"></td>

</tr>
<% 
String sql1="SELECT * FROM mold_purchase_order_detail left join design_file on mold_purchase_order_detail.mold_spec_id=design_file.id where mold_purchase_order_detail.mold_purchase_id='"+id+"'";
ResultSet rs1 = mold_db.executeQuery(sql1); 
%>
</table>
<table id=tableOnlineEdit <%=TABLE_STYLE5%> class="TABLE_STYLE5" style="width: 94%" border="0">
<thead>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td  class="TD_STYLE2" width="5%" align=center rowspan=2 style="display:none"><%=demo.getLang("erp","点选")%> </td>
 <td  class="TD_STYLE2" width="15%" align=center rowspan=2><%=demo.getLang("erp","模具规格")%> </td>
 <td  class="TD_STYLE2" width="15%" align=center rowspan=2> <%=demo.getLang("erp","新制编号")%> </td>
 <td  class="TD_STYLE2" colspan="2" align=center><%=demo.getLang("erp","品名和规格")%> </td>
 <td  class="TD_STYLE2" width="15%" align=center rowspan=2><%=demo.getLang("erp","加工项目")%></td>
 <td  class="TD_STYLE2" colspan="3" align=center><%=demo.getLang("erp","图纸号")%> </td>
 </tr>
 
 <tr <%=TR_STYLE2%> class="TR_STYLE2">

 <td class="TD_STYLE2" width="10%" align=center><%=demo.getLang("erp","上模")%></td>
 <td class="TD_STYLE2" width="10%" align=center><%=demo.getLang("erp","下模")%></td>

 <td class="TD_STYLE2" width="10%" align=center><%=demo.getLang("erp","上模")%></td>
 <td class="TD_STYLE2" width="10%" align=center><%=demo.getLang("erp","下模")%></td>
 <td class="TD_STYLE2" width="10%" align=center><%=demo.getLang("erp","衬铁")%></td>
 </tr>
<%  
while(rs1.next())
{
%>
<tr>
 <td width="5%" align=center style="display:none"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox1" id=checkLine1></td>
 <td  style="display:none"><input name="id"></td>
 <td width="15%" align=center><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name" type="text" value="<%=rs1.getString("mold_spec")%>" onFocus="this.blur()"></td>
 <td width="15%" align=center><input  <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ida" type="text" value="<%=rs1.getString("mold_code")%>"></td>
 <td width="10%" align=center><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="spec_top" type="text" value="<%=rs1.getString("spec_top")%>" onFocus="this.blur()"></td>
 <td width="10%" align=center><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="spec_bottom" type="text" value="<%=rs1.getString("spec_bottom")%>" onFocus="this.blur()"></td>
 <td width="15%" align=center>
 <input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="spec_bottom" type="text" 
 <% 
 if(rs1.getInt("mold_type")==0)
 {%>
 value="新品"
 <%} %> 
 <%
 if(rs1.getInt("mold_type")==1)
 {%>
 value="研磨品"
 <%} %> 
 <%
 if(rs1.getInt("mold_type")==2)
 {%>
 value="报废"
 <%} %> 
 onFocus="this.blur()">
</td>
 <td width="10%" align=center><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="drawing_top" value="<%=rs1.getString("drawing_top")%>" type="text" onFocus="this.blur()"></td>
 <td width="10%" align=center><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="drawing_bottom" value="<%=rs1.getString("drawing_bottom")%>" type="text" onFocus="this.blur()"></td>
 <td width="10%" align=center><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="drawing_lron" value="<%=rs1.getString("drawing_lron")%>" type="text" onFocus="this.blur()"></td>
 </tr>
 <%} %>
 
</thead>
</thead>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","登记人")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input readonly="readonly" type="text" value="<%=purchase_register%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>
	 
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input readonly="readonly" type="text" value="<%=purchase_register_time%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>
 
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","审核人")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input readonly="readonly" type="text" value="<%=register%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>
	 
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input readonly="readonly" type="text" value="<%=time%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>
 
 </tr>
</table>
<!-- 未通过原由 -->
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
   <tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="4%"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%"></textarea>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="6%"><%=demo.getLang("erp", "异常原由")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%"><textarea <%=TEXTAREA_STYLE1%> class="MOLD_INPUT_STYLE_COP"  name="demand"></textarea>
		</td>
	</tr>
</table>


<%	
mold_db.close();
}
}
catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 </form>
 <script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>