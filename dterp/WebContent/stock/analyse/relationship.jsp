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
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount" />
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
function checkForm(){

var flag=true;
var scene_pallet=mutiValidation.scene_pallet.value;
if(scene_pallet==''){
  alert("请输入现场托盘号!");
  flag=false;
}
if(flag){
	mutiValidation.submit();
}
}
</script>
<script language="javascript">
 var XMLHttpReq = false;
  //创建XMLHttpRequest对象       
    function createXMLHttpRequest() {
  if(window.XMLHttpRequest) { //Mozilla 浏览器
   XMLHttpReq = new XMLHttpRequest();
  }
  else if (window.ActiveXObject) { // IE浏览器
   XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
  }
 }
 //发送请求函数
 function sendRequest(url) {
  createXMLHttpRequest();
  XMLHttpReq.open("GET", url, true);
  XMLHttpReq.onreadystatechange = processResponse;//指定响应函数
  XMLHttpReq.send(null);  // 发送请求
 }
 // 处理返回信息函数
    function processResponse() {
     //document.getElementById("message").innerHTML="<image src="">";
     if (XMLHttpReq.readyState == 4) { // 判断对象状态
         if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息
         //alert(XMLHttpReq.responseXML.getElementsByTagName("res")[0].innerHTML);
             var res=XMLHttpReq.responseXML.getElementsByTagName("res")[0].firstChild.data;
                //document.getElementById("message").innerHTML=res;
            	  
            	if(res!="true"){
			mutiValidation.scene_pallet.value=res;
                }else{
            mutiValidation.scene_pallet.value="";    
                }
            } else { //页面不正常
                window.alert("您所请求的页面有异常。");
            }
        }
    }
function userCheck() {
  var uname = mutiValidation.product_temp_pallet.value;
  if(uname!="0"){
    sendRequest('../../stock_analyse_stockrelationship?uname='+ uname );
  }else{
  	mutiValidation.scene_pallet.value="";
  }
}

</script>
<%
		try {
		
		DealWithString DealWithString = new DealWithString(application);
		String mod = request.getRequestURI();
		demo.setPath(request);
		String handbook = demo.businessComment(mod, "您正在做的业务是：","document_main", "reason", "value");
		
		
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<form id="mutiValidation" method="POST" action="../../stock_analyse_ActionAnalyse.do">
<input name="m" value="relation" type="hidden" /> 
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE6%> class="TD_STYLE6">
		  <input type="button" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","关联托盘号")%>" onclick="checkForm()">
		</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>


 
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	
	<input name="m" type="hidden" value="<%="addpallet" %>">
	<tr <%=TR_STYLE1%> class="TR_STYLE 1">
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="right" style="width: 20%">
		  
		  临时托盘号：
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <select id="product_temp_pallet" name="product_temp_pallet" style="width: 150" onchange="userCheck()">
		  <option value="0" selected="selected">  </option>
		  <%
		  String sql_2="select product_temp_pallet,count(product_temp_pallet),scene_pallet from product_info where product_temp_pallet!='' group by product_temp_pallet";
		  ResultSet rs_2=manufacture_db.executeQuery(sql_2);
		  while(rs_2.next()){
		  %>
		  <option value="<%=rs_2.getString("product_temp_pallet") %>"><%=rs_2.getString("product_temp_pallet") %></option>
		  <%  
		  }
		  %>
		  </select>
		</td>
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="right">
		  现场托盘号：
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <input type="text" name="scene_pallet" id="" value="" style="width: 150">
		</td>
		
		
	</tr>
	
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
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
