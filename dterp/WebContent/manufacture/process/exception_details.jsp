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
	import="java.io.*" import="include.nseer_db.*,java.text.*"%>
<%
			nseer_db manufacture_db = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<jsp:useBean id="query" scope="page"
	class="include.query.getRecordCount" />
<jsp:useBean id="validata" scope="page" class="validata.ValidataNumber" />
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page" />
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page" />
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page" />
<jsp:useBean id="mask" class="include.operateXML.Reading" />
<jsp:setProperty name="mask" property="file" value="xml/manufacture/manufacture_apply.xml" />
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/manufacture/apply/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css" />
<script type="text/javascript">
function tcpin(id){
	var res=confirm("确认要转换当前产品吗！");
	if(res){
		document.location.href="../../manufacture_process_ActionProcess.do?id="+id+"&m=tcpin";
	}else{
		return;
	}
}
function checkForm(){
	var fact_length=mutiValidation.fact_length.value;
	var product_after_no=mutiValidation.product_after_no.value;
	var flag=true;
	if(product_after_no==""){
		alert("请输入Lot No！");
		flag=false;
		
	}else if(fact_length==""){
		alert("请输入长度！");
		flag=false;
	}
	if(flag){
	  var res=confirm("是否确认该操作!");
	  if(res){
	    mutiValidation.submit();
	  }else{
	    return;
	  }
	}
}
function relati(){
	var fact_lengthA=mutiValidation.fact_lengthA.value;
	var product_after_noA=mutiValidation.product_after_noA.value;
	var fact_lengthB=mutiValidation.fact_lengthB.value;
	var product_after_noB=mutiValidation.product_after_noB.value;
	var flag=true;
	var endNameA = product_after_noA.substring(product_after_noA.length-1);
	var endNameB = product_after_noB.substring(product_after_noB.length-1);
	if(product_after_noA==""){
		alert("请输入Lot No！");
		flag=false;
		
	}else if(fact_lengthA==""){
		alert("请输入长度A！");
		flag=false;
	}else if(product_after_noB==""){
		alert("请输入Lot No！");
		flag=false;
	}else if(fact_lengthB==""){
		alert("请输入长度B！");
		flag=false;
	}else if(endNameA!='A'){
		alert("Lot No(A)必须以英文字母“A”结尾！");
		flag=false;
	}else if(endNameB!='B'){
		alert("Lot No(B)必须以英文字母“B”结尾！");
		flag=false;
	}
	if(flag){
	  var res=confirm("是否确认该操作!");
	  if(res){
	    mutiValidation.submit();
	  }else{
	    return;
	  }
	}
}
</script>

<%
		try {
		
		DealWithString DealWithString = new DealWithString(application);
		String mod = request.getRequestURI();
		demo.setPath(request);
		String handbook = demo.businessComment(mod, "您正在做的业务是：","document_main", "reason", "value");
		String tablename = "manufacture_apply";
		String id=request.getParameter("id");//废弃产品id
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<%
	//差选异常信息的Lot No和规格
	String sql_1="select id,product_lot_no,product_spec,product_type,product_pstatus from product_info where id="+id;
	ResultSet rs_1=manufacture_db.executeQuery(sql_1);
	String lotNoS="";//Lot No
	String specS="";//规格
	String productType="";
	String productPstatus="";
	if(rs_1.next()){
		lotNoS=rs_1.getString("product_lot_no");
		specS=rs_1.getString("product_spec");
		productType=rs_1.getString("product_type");
		productPstatus=rs_1.getString("product_pstatus");
	}
%>

<%--
		ResultSet rs = manufacture_db.executeQuery(sql_search);
		String sql_temp = sql_search.substring(0, sql_search.indexOf("limit"));
		intRowCount = query.count((String) session.getAttribute("unit_db_name"), sql_temp.replace("*","distinct apply_ID"));
		otherButtons = "&nbsp;<input type=\"button\" " + BUTTON_STYLE1
		+ " class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+ demo.getLang("erp", "全选")
		+ "\" name=\"check\" onclick=\"selAll()\">"+ DgButton.getGar(tablename, request);
		String apply_id_control = "";
		int maxPage = (intRowCount + pageSize - 1) / pageSize;
		strPage = strPage.split("⊙")[0] + "⊙" + maxPage;
--%>
<%--@include file="../../include/search_top.jsp"--%>
<form id="mutiValidation" method="POST" action="../../manufacture_process_ActionProcess.do" >

<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE6%> class="TD_STYLE6">
		    <%
			if(!(productType.trim().equals("2")&&productPstatus.trim().equals("正常"))){//11.11添加 8mm切正常切换
			%>
			<input type="button" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","转换为特采品")%>" onClick="tcpin('<%=id %>')">&nbsp;
		    <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","转换")%>" onclick="checkForm()">&nbsp;
			<%	
			}
			%>
		  
		  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();">
		</td>
	</tr>
</table>
<%-- product_info id隐藏域 --%>
<input name="id" type="hidden" value="<%=id %>">
<%-- 转换方法名 --%> 
<input name="m" type="hidden" value="trans"> 
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr style="background-image:url(../../images/line.gif)">
		<td colspan="6">
		<div style="width:100%; height:12; padding:3px;"><%=demo.getLang("erp", "转换前")%></div>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE 1">
		
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" width="16%">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
		<%=demo.getLang("erp", "规格")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%">
		
		<input name="" type="text" value="<%=specS %>" onFocus="this.blur()"> </td>
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" width="16%">
		&nbsp;&nbsp;<%=demo.getLang("erp", "Lot No")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%">
		<input name="" type="text" value="<%=lotNoS %>" onFocus="this.blur()"> </td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="16%">&nbsp;</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE 1">
	<td>
		<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
			<tr <%=TR_STYLE1%> class="TR_STYLE1">
				<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
			</tr>
		</table>
	</td>
	</tr>
	
	<%
	if(productType.trim().equals("2")&&productPstatus.trim().equals("正常")){//11.11添加 8mm切正常切换
	%>
	<tr style="background-image:url(../../images/line.gif)">
		<td colspan="6">
		<div style="width:100%; height:12; padding:3px;"><%=demo.getLang("erp", "转换后")%></div>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE 1">
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="left">
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
		  <%=demo.getLang("erp", "规格(A)")%>：
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <select id="product_after_spec" name="product_after_specA" style="width: 150">
		  <%
		  String sql_2="select id,product_name,type from design_file where type=(select id from design_config_public_char where type_name='纸类型')";
		  ResultSet rs_2=manufacture_db.executeQuery(sql_2);
		  while(rs_2.next()){
		  %>
		  <option value="<%=rs_2.getString("id") %>"><%=rs_2.getString("product_name") %></option>
		  <%  
		  }
		  %>
		  </select>
		</td>
		<td>
		  &nbsp;&nbsp;<%=demo.getLang("erp", "Lot No(A)")%>：
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <input type="text" name="product_after_noA" id="" value="<%=lotNoS %>" style="width: 150">
		</td>
		<td >
		  &nbsp;&nbsp;<%=demo.getLang("erp", "实际长度(A)")%>：</td>
		<td >
		  <input type="text" name="fact_lengthA" id="" value="" style="width: 150">
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE 1">
	<td>
		<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
			<tr <%=TR_STYLE1%> class="TR_STYLE1">
				<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
			</tr>
		</table>
	</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE 1">
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="left">
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
		  <%=demo.getLang("erp", "规格(B)")%>：
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <select id="product_after_spec" name="product_after_specB" style="width: 150">
		  <%
		  rs_2=manufacture_db.executeQuery(sql_2);
		  while(rs_2.next()){
		  %>
		  <option value="<%=rs_2.getString("id") %>"><%=rs_2.getString("product_name") %></option>
		  <%  
		  }
		  %>
		  </select>
		</td>
		<td>
		  &nbsp;&nbsp;<%=demo.getLang("erp", "Lot No(B)")%>：
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <input type="text" name="product_after_noB" id="" value="<%=lotNoS %>" style="width: 150">
		</td>
		<td >
		  &nbsp;&nbsp;<%=demo.getLang("erp", "实际长度(B)")%>：</td>
		<td >
		  <input type="text" name="fact_lengthB" id="" value="" style="width: 150">
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","转换")%>" onClick="relati()" />
		</td>
	</tr>
	<%	
	}else{//非8mm切正常切换
	%>
	<tr style="background-image:url(../../images/line.gif)">
		<td colspan="6">
		<div style="width:100%; height:12; padding:3px;"><%=demo.getLang("erp", "转换后")%></div>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE 1">
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="left">
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
		  <%=demo.getLang("erp", "规格")%>：
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <select id="product_after_spec" name="product_after_spec" style="width: 150">
		  <%
		  String sql_2="select id,product_name,type from design_file where type=(select id from design_config_public_char where type_name='纸类型')";
		  ResultSet rs_2=manufacture_db.executeQuery(sql_2);
		  while(rs_2.next()){
		  %>
		  <option value="<%=rs_2.getString("id") %>"><%=rs_2.getString("product_name") %></option>
		  <%  
		  }
		  %>
		  </select>
		</td>
		<td>
		  &nbsp;&nbsp;<%=demo.getLang("erp", "Lot No")%>：
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <input type="text" name="product_after_no" id="" value="" style="width: 150">
		</td>
		<td >
		  &nbsp;&nbsp;<%=demo.getLang("erp", "实际长度")%>：</td>
		<td >
		  <input type="text" name="fact_length" id="" value="" style="width: 150">
		</td>
	</tr>
	<%
	}
	%>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	
</table>
</form>

<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>


<%-- <input type="hidden" name="" id="rows_num" value="<%=k%>">--%>
<%
	manufacture_db.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<%@include file="../../include/head_msg.jsp"%>
