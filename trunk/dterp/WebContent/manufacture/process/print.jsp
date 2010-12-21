<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*,include.nseer_cookie.*" import="java.util.*"
	import="java.io.*"
	import="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.exchange,java.text.*"%>
<%@include file="../include/head.jsp"%>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
</script>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：","document_main", "reason", "value");

	nseer_db manufacture_db = new nseer_db((String) session.getAttribute("unit_db_name"));
	nseer_db manufacture_db1 = new nseer_db((String) session.getAttribute("unit_db_name"));
	nseer_db manufacture_db2 = new nseer_db((String) session.getAttribute("unit_db_name"));
	String id=request.getParameter("id");//信息id
	String product_spe="";
	String product_lot_no="";
	String sql_1="select id,product_spec,product_lot_no from product_info where id="+id;
	ResultSet rs_1=manufacture_db.executeQuery(sql_1);
	if(rs_1.next()){
		product_spe=rs_1.getString("product_spec");
		product_lot_no=rs_1.getString("product_lot_no");
	}
	
%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>


<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE8"  style="width: 40%">
			&nbsp;&nbsp;规格：
			<input type="text" name="" value="<%=product_spe %>" style="width: 25%">&nbsp;
			Lot No：<input type="text" name="" value="<%=product_lot_no %>" style="width: 25%"></td>
		<td <%=TD_STYLE6%> style="text-align: right">
		  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","全部打印")%>" onclick=id_link("print_details.jsp?all=<%=id%>&id=<%=id %>")>&nbsp;
		  &nbsp;
		  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();">
		</td>
	</tr>
</table>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>




<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5" style="width: 90%">
	<tr <%=TR_STYLE2%> class="TR_STYLE2" style="text-align: center;">
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "产品Lot No")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "打印")%>
		</td>
		
	</tr>	
<%		

	
	String sql_x = "select id,product_lot_no from product_info where product_status!='4' and product_status!='6' and father_product_id="+id;
	ResultSet rs_x=manufacture_db.executeQuery(sql_x);
	while(rs_x.next()){
	
%>
	
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs_x.getString("product_lot_no") %>&nbsp;</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		<div style="text-decoration : underline;color:#3366FF" onclick=id_link('print_details.jsp?part=<%=rs_x.getString("product_lot_no") %>&id=<%=id %>')><%=demo.getLang("erp", "打印")%></div>
		</td>
	</tr>
	<%
	}
		
	%>
</table>


<% 
manufacture_db.close();
manufacture_db1.close();
manufacture_db2.close();

%>
<%--
		}
		manufacture_db.close();
	} catch (Exception ex) {
		out.println("error" + ex);
	}
--%>
