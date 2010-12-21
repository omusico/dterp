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

<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stockdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String id=request.getParameter("id");
String type_id=request.getParameter("type_id");
String sql1="select count(id) from stock_config_workflow where type_id='"+type_id+"'";
ResultSet rs1 = stock_db.executeQuery(sql1);
int count=0;
if(rs1.next()){
	count=rs1.getInt("count(id)");
}
String pay_ID_group="";
String sql = "select pay_ID from stock_pay where pay_pre_tag='1' and pay_tag!='2' order by register_time" ;
	ResultSet rs = stockdb.executeQuery(sql) ;
	while(rs.next()){
		String sql4="select pay_check_tag,pay_tag,pay_ID from stock_pre_paying where pay_ID='"+rs.getString("pay_ID")+"'";
		ResultSet rs4 = stock_db.executeQuery(sql4) ;
		while(rs4.next()){
			if((rs4.getString("pay_check_tag").equals("1")||rs4.getString("pay_check_tag").equals("9"))&&rs4.getString("pay_tag").equals("0")){
				pay_ID_group+=","+rs4.getString("pay_ID");
			}
		}
	}
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%
if(count==1&&!pay_ID_group.equals("")){
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="pay.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","尚有等待审核或需重新登记的出库单，最后一个审核流程不能删除，请返回！")%></td>
 </tr>
 </table> 
 <%}else{%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确认")%>" onClick=location="../../../stock_config_workflow_pay_delete_ok?id=<%=id%>&type_id=<%=type_id%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onclick=location="pay.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","您确认要删除这个审核流程吗？")%></td>
 </tr>
 </table>
<%}
stock_db.close();
stockdb.close();
%>
</div>