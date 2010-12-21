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
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stock_db2 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stock_db3 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stock_db4 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stock_db5 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
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

<script>
	function changeProduct(pg){
	var result = pg.value;
		if(result==0){
			document.getElementById("div1").style.display="none";
			document.getElementById("div2").style.display="none";
			document.getElementById("div3").style.display="none";
			document.getElementById("div4").style.display="none";
		}else if(result==1){
			document.getElementById("div1").style.display="block";
			document.getElementById("div2").style.display="none";
			document.getElementById("div3").style.display="none";
			document.getElementById("div4").style.display="none";
		}else if(result==2){
			document.getElementById("div1").style.display="none";
			document.getElementById("div2").style.display="block";
			document.getElementById("div3").style.display="none";
			document.getElementById("div4").style.display="none";
		}else if(result==3){
			document.getElementById("div1").style.display="none";
			document.getElementById("div2").style.display="none";
			document.getElementById("div3").style.display="block";
			document.getElementById("div4").style.display="none";
		}else if(result==4){
			document.getElementById("div1").style.display="none";
			document.getElementById("div2").style.display="none";
			document.getElementById("div3").style.display="none";
			document.getElementById("div4").style.display="block";
		}
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
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%="您正在做的业务是：库存管理--库存管理--包装信息查询 "%></div></td>
 </tr>
 </table>
<%
String product_info_id=request.getParameter("id");
%>
<script type="text/javascript" >
function dissolve(pack_id){
	var res=confirm("是否确认该操作？");
	if(res){
		window.location="../../stock_StockAction.do?m=doUpdate&id="+pack_id;
	}else{
	    return;
	}
	
}
</script>
<%
String sql2="select a.*,CUSTOMER_NAME from package_info a inner join crm_file b on b.id = a.package_custom_id where a.id='"+product_info_id+"'";
ResultSet rs2=stock_db2.executeQuery(sql2);
rs2.next();

String is_dissolve_str=rs2.getString("is_dissolve");
String str1="";
String strValue="解散";
if(is_dissolve_str.equals("1")){
	str1="disabled=\"disabled\"";
	strValue="已解散";
}

%>
<form id="mutiValidation" method="POST" action="" onSubmit="">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input <%=str1 %> value="<%=strValue %>" type="button" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" onclick="dissolve('<%=product_info_id %>')" >&nbsp;<input type="button" <%=SUBMIT_STYLE1%>   class="SUBMIT_STYLE1" onclick="javascript:window.history.back()" value="<%=demo.getLang("erp","返回")%>"></td>
 </tr>
 </table>
 <%

String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String gather_ID=request.getParameter("gather_ID");
String new_apply="0";
String sql_1 = "select count(a.id) from product_info a,package_info b where a.package_id='"+product_info_id+"' and b.id = a.package_id";
ResultSet rs_count = stock_db5.executeQuery(sql_1);
String count_1 = "";
if(rs_count.next()){
	count_1=rs_count.getString(1);
}
String sql="select * from product_info a,package_info b where a.package_id='"+product_info_id+"' and b.id = a.package_id";
ResultSet rs=stock_db.executeQuery(sql);



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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","包装信息")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>

 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","原纸规格")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><input onFocus="this.blur()" name="reason" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" value="<%=rs2.getString("a.product_spec") %>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","模具规格")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><input onFocus="this.blur()" name="reason" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" value="<%=rs2.getString("a.mold_spec") %>"></td>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","客户")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><input onFocus="this.blur()" name="reason" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" value="<%=rs2.getString("CUSTOMER_NAME") %>"></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","栈板号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><input onFocus="this.blur()" name="reason" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" value="<%=rs2.getString("a.package_pallet") %>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","工厂托盘号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><input onFocus="this.blur()" name="reason" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" value="<%=rs2.getString("a.package_factory_pallet") %>"></td>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","数量")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><input onFocus="this.blur()" name="reason" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" value="<%=count_1 %>"></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","重量")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><input onFocus="this.blur()" name="reason" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" value="<%=rs2.getString("a.package_weight") %>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","库位")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><input onFocus="this.blur()" name="reason" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" value="<%=rs2.getString("a.package_stock") %>"></td>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"></td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>



<div id="div1" >

 <table <%=TABLE_STYLE5%> class="TABLE_STYLE5" cols=1 id=tableOnlineEdit1>
<thead>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","原纸规格")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","LOT No.")%></td>
 </tr>
 <% 
 String product_spec="";
String product_lot_no="";				
while(rs.next()){
	product_spec=rs.getString("product_spec");
	product_lot_no=rs.getString("product_lot_no");
%>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_spec %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_lot_no %></td>
 </tr>
<%
}
%>
</thead>
</table>
</div>


<%
stock_db.close();
stock_db2.close();
stock_db3.close();
stock_db4.close();

%>
<%@include file="../include/paper_bottom.html"%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 </form>

 <script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>