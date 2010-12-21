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
<%nseer_db fund_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../../dwr/engine.js"></script>
<script type="text/javascript" src="../../../dwr/util.js"></script>
<script type="text/javascript" src="../../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../../dwr/interface/validateV7.js"></script>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="currencyTypeRegister" class="x-form" method="POST" action="../../../fund_config_fund_currencyType_register_ok"onSubmit="return doValidate('../../../xml/fund/fund_config_fund_currency.xml','currencyTypeRegister')">
  <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value=<%=demo.getLang("erp","提交")%>>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","返回")%> onClick=location="currencyType.jsp"></td>
 </tr>
 </table>
<%
String code="001";
try{
	String sql="select * from fund_config_fund_currency order by currency_ID desc";
	ResultSet rs=fund_db.executeQuery(sql);
	if(rs.next()){
	int code1=Integer.parseInt(rs.getString("currency_ID"));
	code1+=1;
	if(code1<10){
		code="00"+code1;
	}else if(code1>=10&&code1<100){
		code="0"+code1;
		}else{
			code=code1+"";
	}
 }
 fund_db.close();
}
catch (Exception ex) {
		out.println("error"+ex);
	}
%>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","货币编号")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input type="hidden" name="currency_ID" width="100%" style="width: 30%;" value="<%=code%>"><%=code%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","货币名称")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="currency_name" width="100%" style="width: 30%;"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","单位")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="personal_unit" width="100%" style="width: 30%"></td>
</tr>
</table> 
</form>
</div>

