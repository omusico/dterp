
<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>

<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_gather.xml"/>
<script>
function registerCheck(){
	
	document.getElementById("t1").style.display = "none";
	document.getElementById("t2").style.display = "block";
}
</script>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%="您正在做的业务是：生产管理--生产过程管理--产品临时入库"%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
 <div id="t1">
 <div style="text-align: right">
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="registerCheck()" value="<%=demo.getLang("erp","确定")%>">
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="javascript:window.history.back();" value="<%=demo.getLang("erp","返回")%>">
<br/>
</div>
  <%
  nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));
String depart = request.getAttribute("inst").toString();
  List<String> list = (List)request.getAttribute("listDepart");
 //如果是成品入库则显示成品信息
 if(depart.equals("inst6")||depart.equals("inst7")){
	 //从文件流中读出的数据依次和数据库中的成品对比，如果栈板号有相同的，则显示到页面
	 for(int i=0;i<list.size();i++){	
		 String sql = "select REPLACE(product_lot_no,'-','') as lotNo,product_temp_pallet,product_lot_no,product_spec,product_stock  from product_info where replace(product_lot_no,'-','')='"+list.get(i)+"'";
		 ResultSet rsDocument = design_db.executeQuery(sql);
	 while(rsDocument.next()){
	 %>
	 <br />
	&nbsp;&nbsp;&nbsp;&nbsp;原纸规格：<%=rsDocument.getString("product_spec") %> &nbsp;&nbsp;LotNo：<%=rsDocument.getString("product_lot_no") %> &nbsp;&nbsp;
	<br />
	 <%
	 }
	 }
 }else if(depart.equals("inst5")||depart.equals("inst3")||depart.equals("inst4")||depart.equals("inst8")||depart.equals("inst9")||depart.equals("inst11")){
 for(int i=0;i<list.size();i++){	
	 String sql = "select REPLACE(product_lot_no,'-','') as lotNo,product_lot_no,product_spec,product_stock from product_info where replace(product_lot_no,'-','')='"+list.get(i)+"'";
	 ResultSet rsDocument = design_db.executeQuery(sql);
 while(rsDocument.next()){
 %>
 <br />
&nbsp;&nbsp;&nbsp;&nbsp;原纸规格：<%=rsDocument.getString("product_spec") %>&nbsp;&nbsp;LotNo：<%=rsDocument.getString("product_lot_no") %>&nbsp;&nbsp;
<br />
 <%
 }
 }
 design_db.close();
 }else if(depart.equals("inst10")){
	 for(int i=0;i<list.size();i++){
	 String sql = "select product_spec,package_pallet from package_info where package_pallet='"+list.get(i)+"'";
	 ResultSet rsDocument = design_db.executeQuery(sql);
	 while(rsDocument.next()){
		 %>
		  <br />
&nbsp;&nbsp;&nbsp;&nbsp;原纸规格：<%=rsDocument.getString("product_spec") %>&nbsp;&nbsp;栈板号：<%=rsDocument.getString("package_pallet") %>&nbsp;&nbsp;
<br />
		 <%
	 }
	 }
	 design_db.close();
 }
 %>
 </div>
 
 
<div id="t2" style="display: none;">
<form name="" id="" action="" method="post">

<div style="text-align: right">

&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="javascript:window.history.back();" value="<%=demo.getLang("erp","返回")%>">
<br/>
</div>
<table width="80%" style="text-align: center;">
<tr>
<td>
读取文件：<%=request.getAttribute("fileName") %><br />
 入库完成<br />
</td>
</tr>
</table>
</form>

</div>
<%@include file="../../include/head_msg.jsp"%>
