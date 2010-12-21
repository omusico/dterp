<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%counter count=new counter(application);%>

<script type="text/javascript">
<!--
function onStockCheck(){

	var stock_id1 = document.getElementById("validator_dup").value;
	if(stock_id1.length==0){
		alert("请输入库房名称！");return false;
	}
	<%String sql1 = "SELECT STOCK_NAME FROM stock_config_public_char where DESCRIBE1='库房'";
	ResultSet rs1 = stock_db.executeQuery(sql1);
	String stock_id ="";
	while(rs1.next()){
		stock_id= rs1.getString("STOCK_NAME");
		%>
		if(stock_id1=="<%=stock_id%>"){
			alert("您输入的号码重复！");return false;
		}
		<%
	}
	%>

}
//-->
</script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="address" class="x-form" method="post" action="../../../stock_config_stock_address_register_ok" onsubmit="return onStockCheck()">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div id="loaddiv" style="display:none;border:1px solid red; height:20px;background-color: #FF0033;width:80%;float :left ;" ></div><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="address.jsp"></div></td>
 </tr>
 </table>
<%
String sql = "SELECT STOCK_ID FROM stock_config_public_char ORDER BY id DESC LIMIT 1 ";
ResultSet rs=stock_db.executeQuery(sql);
String stockNum = "";
int number=0;
if(rs.next()){
	stockNum = rs.getString("STOCK_ID");
}
if(!stockNum.equals("")){
	number=Integer.parseInt(stockNum)+1;

}
%>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","库房编号")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="hidden" name="stock_ID" id="stock_ID" style="width: 30%;" value="<%=number%>"><%=number%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","库房名称")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" id="validator_dup" name="stock_name" width="100%" style="width: 30%" onblur="ajax_validation('address','validator_dup','stock_config_public_char','stock_name','../../../vd',this)"></td>
</tr>

</table> 
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
</div>