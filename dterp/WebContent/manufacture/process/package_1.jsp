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
function checkForm(){

var flag=true;
var package_factory_pallet=mutiValidation.package_factory_pallet.value;
var product_pallet_sf=mutiValidation.product_pallet_sf.value;

var product_spec_ids=document.getElementById("product_spec_id");
   
var index=product_spec_ids.selectedIndex;

var product_spec_id=product_spec_ids.options[index].value;

  
var sft=/^[A-Za-z]{1,2}$/;

	if(product_spec_id=="0"){
		alert("请选择原纸规格!");
		flag=false;
	}/*else if(package_factory_pallet.length==0){
		alert("请输入工厂托盘号!");
		flag=false; 
	}*/else if(product_pallet_sf==""){
		alert("请输入栈板号!");
		flag=false; 
	}
	return flag;
}
</script>
<script language="javascript">
//用户名重复验证
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
             var res=XMLHttpReq.responseXML.getElementsByTagName("res")[0].firstChild.data;
                //document.getElementById("message").innerHTML=res;
            	  
            	if(res!="true"){
                
                mutiValidation.product_pallet_sf.value=res;
                }else{
                mutiValidation.product_pallet_sf.value="";
                }
            } else { //页面不正常
                window.alert("您所请求的页面有异常。");
            }
        }
    }
 // 
function userCheck() {
  var uname = mutiValidation.product_spec_id.value;
  if(uname!="0"){
    sendRequest('../../manufacture_process_ProductPalletServlet?uname='+ uname );
  }else{
  	mutiValidation.product_pallet_sf.value="";
  }
}
function submitForm(){
	if(checkForm()){
	var res=confirm("是否确认当前操作?");
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
			nseer_db manufacture_db = new nseer_db((String) session
					.getAttribute("unit_db_name"));
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
<form id="mutiValidation" method="POST" action="../../manufacture_process_ActionProcess.do" onsubmit="return checkForm()">
<%-- 
<form id="mutiValidation" method="POST" action="package_2.jsp" onsubmit="return checkForm()">
--%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>


 
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	
	<input name="m" type="hidden" value="<%="addpallet" %>">
	<tr <%=TR_STYLE1%> class="TR_STYLE 1">
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="right" style="width: 12%">
		  
		  原纸规格：
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <select id="product_spec_id" name="product_spec_id" style="width: 150" onchange="userCheck()">
		  <option value="0" selected="selected">  </option>
		  <%
		  String sql_2="select id,product_name,type from design_file where CHECK_TAG=1 and type=(select id from design_config_public_char where type_name='纸类型')";
		  ResultSet rs_2=manufacture_db.executeQuery(sql_2);
		  while(rs_2.next()){
		  %>
		  <option value="<%=rs_2.getString("id") %>"><%=rs_2.getString("product_name") %></option>
		  <%  
		  }
		  %>
		  </select>
		</td>
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="right">
		  客户名称：
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <select id="package_custom_id" name="package_custom_id" style="width: 150">
		  <%
		  String sql_3="SELECT id,customer_name,type FROM crm_file where type=(select id from crm_config_public_char where TYPE_NAME='客户') and check_tag=1";
		  ResultSet rs_3=manufacture_db.executeQuery(sql_3);
		  while(rs_3.next()){
		  %>
		  <option value="<%=rs_3.getString("id") %>"><%=rs_3.getString("CUSTOMER_NAME") %></option>
		  <%  
		  }
		  %>
		  </select>
		</td>
		
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="right">
		  模具规格：
		</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" >
		  <select id="mold_spec_id" name="mold_spec_id" style="width: 150">
		  <option value="0">  </option>
		  <%
		  String sql_4="SELECT mold_spec,mold_spec_id FROM mold_info where  mold_type!=3 and mold_location=3 group by mold_spec";
		  ResultSet rs_4=manufacture_db.executeQuery(sql_4);
		  while(rs_4.next()){
		  %>
		  <option value="<%=rs_4.getString("mold_spec_id") %>"><%=rs_4.getString("mold_spec") %></option>
		  <%  
		  }
		  %>
		  </select>
		</td>
		
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="right">
		  工厂托盘号：</td>
		<td >
		  <input type="text" name="package_factory_pallet" id="" value="" style="width: 150">
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE 1">
		<td bordercolorlight=#848284 bordercolordark=#eeeeee class="TD_STYLE8" align="right">
		  栈板号：</td>
		<td >
		  <input type="text" name="product_pallet_sf" id="" value="" style="width: 150">
		</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE6%> class="TD_STYLE6">
		  <input type="button" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","生成栈板号")%>" onclick="submitForm()">
		</td>
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
