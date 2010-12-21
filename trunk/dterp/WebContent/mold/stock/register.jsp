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
			nseer_db mold_db = new nseer_db((String) session.getAttribute("unit_db_name"));
			nseer_db mold_db1 = new nseer_db((String) session.getAttribute("unit_db_name"));
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

<%
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String time=formatter.format(now);
String id =(String)request.getParameter("id");


if(id==null||id.equals(""))
{
	id=(String)session.getAttribute("moldId");

	
}else
{
	session.setAttribute("moldId",id);
}

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
%>
<script language="javascript">
function id_link(link){
document.location.href=link;
}
function TwoSubmit(form){
if (form.Ref[0].checked){
form.action = "check_delete.jsp?id=<%=exchange.unHtmls(Integer.toString(rs.getInt("mold_purchase_order.id")))%>";
}
else{
form.action = "check_ok.jsp?id=<%=exchange.unHtmls(Integer.toString(rs.getInt("mold_purchase_order.id")))%>";
}
}
</script>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"> <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register_list.jsp"></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","模具入库")%></b></font></td>
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
 <td align=left class="TD_STYLE2" width="20%"><input name="purchase_operater" type="text" value="<%=rs.getString("purchase_operater")%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>
	 
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","采购时间")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input name="purchase_time" type="text" value="<%=rs.getString("purchase_time")%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>

</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","供应商")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input name="purchase_supplier_id" type="text"
<% 
String sql2="SELECT CUSTOMER_NAME FROM crm_file where id='"+purchase_supplier_id+"'";
ResultSet rs2 = mold_db.executeQuery(sql2); 
String customer_Name="";
if(rs2.next())
{
	customer_Name=rs2.getString("CUSTOMER_NAME");
}

%>
  value="<%=customer_Name%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>
	 
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","订单号")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input name="purchase_id" type="text" value="<%=purchase_code%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>

</tr>
<% 
String sql1="SELECT * FROM mold_purchase_order_detail left join design_file on mold_purchase_order_detail.mold_spec_id=design_file.id where mold_purchase_order_detail.mold_purchase_id='"+id+"'";
ResultSet rs1 = mold_db.executeQuery(sql1); 
%>
</table>
<table id=tableOnlineEdit <%=TABLE_STYLE5%> class="TABLE_STYLE5" style="width: 94%" border="0">
<thead>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td style="display:none"><%=demo.getLang("erp","点选")%> </td>
 <td  class="TD_STYLE2" width="15%" align=center rowspan=2><%=demo.getLang("erp","模具规格")%> </td>
 <td  class="TD_STYLE2" width="10%" align=center rowspan=2> <%=demo.getLang("erp","新制编号")%> </td>
 <td  class="TD_STYLE2" colspan="2" align=center><%=demo.getLang("erp","品名和规格")%> </td>
 <td  class="TD_STYLE2" width="15%" align=center rowspan=2><%=demo.getLang("erp","加工项目")%></td>
 <td  class="TD_STYLE2" colspan="3" align=center><%=demo.getLang("erp","图纸号")%> </td>
 <td  class="TD_STYLE2" width="7%" align=center rowspan=2><%=demo.getLang("erp","入库状态")%></td>
 <td  class="TD_STYLE2" width="3%" align=center rowspan=2><%=demo.getLang("erp","入库")%> </td>
 </tr>
 
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td style="display:none"></td>
 <td class="TD_STYLE2" width="10%" align=center><%=demo.getLang("erp","上模")%></td>
 <td class="TD_STYLE2" width="10%" align=center><%=demo.getLang("erp","下模")%></td>
 <td class="TD_STYLE2" width="10%" align=center><%=demo.getLang("erp","上模")%></td>
 <td class="TD_STYLE2" width="10%" align=center><%=demo.getLang("erp","下模")%></td>
 <td class="TD_STYLE2" width="10%" align=center><%=demo.getLang("erp","衬铁")%></td>
 </tr>
<%  
while(rs1.next())
{
	String idd=rs1.getString("mold_id");
%>
<tr>
 <td style="display:none"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox1" id=checkLine1></td>
 <td  style="display:none"><input name="id"></td>
 <td width="15%" align=center><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name" type="text" value="<%=rs1.getString("mold_spec")%>" onFocus="this.blur()"></td>
 <td width="10%" align=center><input  <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ida" type="text" value="<%=rs1.getString("mold_code")%>"></td>
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
 <% String sql3="SELECT * FROM mold_info where mold_purchase_id='"+id+"' and mold_spec_id='"+ rs1.getString("mold_spec_id")+"' and id='"+idd+"'";
	ResultSet rs3 = mold_db1.executeQuery(sql3); 
    rs3.next();
%>
 <td width="7%" align=center><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="drawing_lron"
 
 <%
 if(rs3.getString("mold_life_status").equals(""))
	 {%>
  value="未入库" 
  <%} %>
   <%
 if(!rs3.getString("mold_life_status").equals(""))
	 {%>
  value="已入库" 
  <%} %>
  type="text" onFocus="this.blur()"></td>
  
 <td width="3%" align=center>
 <%
 if(rs3.getString("mold_life_status").equals(""))
	 {%>
	 <a href="#" style="text-decoration:none;">
	 <%
	   String testid=rs3.getString("id");
	 %>
 <div style="text-decoration : underline;color:#3366FF" onClick=id_link("register_query.jsp?id=<%=exchange.unHtmls(Integer.toString(rs3.getInt("id")))%>")><%=demo.getLang("erp","入库")%></div></a>
 <%} %>
   <%
 if(!rs3.getString("mold_life_status").equals(""))
	 {%>
 <input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="drawing_lron" value="入库" type="text" onFocus="this.blur()"></td>
 <%} %>
 </tr>
 <%}%>
 
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
 <td align=left class="TD_STYLE2" width="20%"><input type="text" value="<%=purchase_register%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input type="text" value="<%=purchase_register_time%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>

 </tr>
</table>
<%	
mold_db.close();
mold_db1.close();
}
}
catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 <script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>