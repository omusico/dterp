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
	import="java.sql.*,include.nseer_cookie.*,java.text.*"
	import="java.util.*" import="java.io.*"
	import="include.nseer_db.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%
			nseer_db crm_db = new nseer_db((String) session.getAttribute("unit_db_name"));
			nseer_db crmdb = new nseer_db((String) session.getAttribute("unit_db_name"));
%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page" />
<jsp:useBean id="OperateXML" class="include.nseer_cookie.OperateXML" scope="page" />
<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：","document_main", "reason", "value");

	
%>
<%@include file="../include/head.jsp"%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script language="javascript" src="../../javascript/ajax/ajax-validation-f.js"></script>

<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/input_control/focus.css">
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css" />
<link rel="stylesheet" type="text/css" href="../../css/include/nseerTree/nseertree.css">
<div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<script type="text/javascript" src="../../javascript/validateFormCommon.js"></script>
<jsp:useBean id="mask" class="include.operateXML.Reading" />
<jsp:setProperty name="mask" property="file" value="xml/crm/crm_file.xml" />
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
             var res=XMLHttpReq.responseXML.getElementsByTagName("res")[0].firstChild.nodeValue;
            
             
             
                //document.getElementById("message").innerHTML=res;
            	  
            	if(res!="true"){
            		var res1=XMLHttpReq.responseXML.getElementsByTagName("res1")[0].firstChild.nodeValue;
	             
		            var res2=XMLHttpReq.responseXML.getElementsByTagName("res2")[0].firstChild.nodeValue;
		             
		            var res3=XMLHttpReq.responseXML.getElementsByTagName("res3")[0].firstChild.nodeValue;
		            
		            var res4=XMLHttpReq.responseXML.getElementsByTagName("res4")[0].firstChild.nodeValue;
		             
		            var res5=XMLHttpReq.responseXML.getElementsByTagName("res5")[0].firstChild.nodeValue;
	                mutiValidation.product_middle_thickness.value=res;
	                mutiValidation.product_middle_thickness_away.value=res1;
	                mutiValidation.front_10P0_away.value=res2;
	                mutiValidation.front_E_away.value=res3;
	                mutiValidation.back_10P0_away.value=res4;
	                mutiValidation.back_E_away.value=res5;
                }else if(res=="true"){
	                mutiValidation.product_middle_thickness.value="0.00";
	                mutiValidation.product_middle_thickness_away.value="0.00";
	                mutiValidation.front_10P0_away.value="0.00";
	                mutiValidation.front_E_away.value="0.00";
	                mutiValidation.back_10P0_away.value="0.00";
	                mutiValidation.back_E_away.value="0.00";
                }
            } else { //页面不正常
                window.alert("您所请求的页面有异常。");
            }
        }
    }
 // 
    function userChange(no) {
  
  if(no.value!="0"){
   sendRequest('../../crm_file_SpecServlet?cid='+ no.value );
  }else if(no.value!="0")
  {
  	mutiValidation.product_middle_thickness.value="0.00";
    mutiValidation.product_middle_thickness_away.value="0.00";
    mutiValidation.front_10P0_away.value="0.00";
    mutiValidation.front_E_away.value="0.00";
    mutiValidation.back_10P0_away.value="0.00";
    mutiValidation.back_E_away.value="0.00";
  }
}

</script>
<script type="text/javascript">

function CheckForm(TheForm){

	var flag=true;
	var reg_float=/^\d+(\.{1}\d+)?$/;
    if(TheForm.customer_id.value == "0")
    {
    	alert("请选择客户！");
		flag=false;
    }
    else if(TheForm.product_middle_thickness.value== "")
    {
    	alert("请输入纸厚度！");
		flag=false;
    }
    else if(TheForm.product_middle_thickness_away.value== "")
    {
    	alert("请输入纸厚度偏差！");
		flag=false;
    }
    else if(TheForm.front_10P0_away.value== "")
    {
    	alert("请输入前样测定10P0值的偏差！");
		flag=false;
    }
    else if(TheForm.front_E_away.value== "")
    {
    	alert("请输入前样测定E值的偏差！");
		flag=false;
    }
    else if(TheForm.back_10P0_away.value== "")
    {
    	alert("请输入后样测定10P0值的偏差！");
		flag=false;
    }
    else if(TheForm.back_E_away.value== "")
    {
    	alert("请输入后样测定E值的偏差！");
		flag=false;
    }
    else if(!reg_float.test(TheForm.product_middle_thickness.value))
    {
    	alert("纸厚度必须为数字！");
		flag=false;
    }
    else if(!reg_float.test(TheForm.product_middle_thickness_away.value))
    {
    	alert("纸厚度偏差必须为数字！");
		flag=false;
    }else if(!reg_float.test(TheForm.front_10P0_away.value))
    {
    	alert("前样测定10P0值必须为数字！");
		flag=false;
    }else if(!reg_float.test(TheForm.front_E_away.value))
    {
    	alert("前样测定E值必须为数字！");
		flag=false;
    }else if(!reg_float.test(TheForm.back_10P0_away.value))
    {
    	alert("后样测定10P0值必须为数字！");
		flag=false;
    }else if(!reg_float.test(TheForm.back_E_away.value))
    {
    	alert("后样测定E值必须为数字！");
		flag=false;
    }
    return flag;
    
}
</script>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" class="x-form" method="post" action="../../crm_file_OptionSpec.do" onSubmit="return CheckForm(this)">
<input name="m" value="option" type="hidden"><%-- 后台方法名 --%> 
<input name="select2" value="" type="hidden"> 
<input name="select3" value="" type="hidden"> 

<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		
		<td <%=TD_STYLE3%> class="TD_STYLE3" width="35%">客户名称：
		<select <%=SELECT_STYLE5%> class="SELECT_STYLE5" name="customer_id" style="width:45%" onchange="userChange(this)">
		<option value="0" selected="selected"><%=demo.getLang("erp", "---请选择客户---")%></option>
			<%
				//显示客户下拉框
					String sql4 = "SELECT id,customer_name,type,C_DEFINE1 FROM crm_file where type=(select id from crm_config_public_char where TYPE_NAME='客户') and check_tag=1 and C_DEFINE1='0'";
					ResultSet rs4 = crm_db.executeQuery(sql4);
					while (rs4.next()) {
						
			%>
		<option value="<%=rs4.getString("id") %>"><%=rs4.getString("customer_name")%></option>
			<%
					}
			%>
		</select></td>
		
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1">
		<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>"> 
		</div>
		</td>
	</tr>
</table>
<%
		try {
		String time = "";
		String sales_ID = (String) session.getAttribute("human_IDD");
		//当前用户
		String operator = (String) session.getAttribute("realeditorc");
		java.util.Date now = new java.util.Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//当前时间
		time = formatter.format(now);
		
		try {
			
%>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
	<tr style="background-image:url(../../images/line.gif)">
		<td colspan="2">
		<div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp", "生纸带检查")%></div>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "纸厚度")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
		<input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_middle_thickness" style="width:12%" value="<%=0 %>">mm&nbsp;±
		<input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_middle_thickness_away" style="width:12%" value="<%=0 %>">mm
		</td> 
	</tr>
	<tr style="background-image:url(../../images/line.gif)">
		<td colspan="2">
		<div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp", "前样测定")%></div>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "10P0值")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
		<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" style="width:12%" value="40.00" onFocus="this.blur()">&nbsp;&nbsp;&nbsp;±
		<input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="front_10P0_away" style="width:12%" value="<%=0 %>">mm
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "E值")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
		<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" style="width:12%" value="1.75" onFocus="this.blur()">&nbsp;&nbsp;&nbsp;±
		<input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="front_E_away" style="width:12%" value="<%=0 %>">mm
		</td>
	</tr>
	<tr style="background-image:url(../../images/line.gif)">
		<td colspan="2">
		<div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp", "后样测定")%></div>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "10P0值")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
		<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" style="width:12%" value="40.00" onFocus="this.blur()">&nbsp;&nbsp;&nbsp;±
		<input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="back_10P0_away" style="width:12%" value="<%=0 %>">mm
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "E值")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
		<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" style="width:12%" value="1.75" onFocus="this.blur()">&nbsp;&nbsp;&nbsp;±
		<input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="back_E_away" style="width:12%" value="<%=0 %>">mm
		</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>	
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "登记人")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="register"
			style="width:45%" value="<%=exchange.toHtml(operator)%>"
			onFocus="this.blur()"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "登记时间")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
			name="register_time" style="width:45%"
			value="<%=exchange.toHtml(time.substring(0,10))%>"
			onFocus="this.blur()"></td>
	</tr>
	
	
	<%
	String nickName = "客户档案";
	%>
	<%@include file="../../include/cDefineMou.jsp"%>

</table>
<%				
			
			crmdb.close();
			crm_db.close();
		} catch (Exception ex) {
			out.println("error" + ex);
		}

	} catch (Exception ex) {
		ex.printStackTrace();
	}
%> 
<%
 String uname = (String) session.getAttribute("realeditorc");
%> 
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>"> 
<input type="hidden" name="hidden_name" value="<%=uname%>">
</form>
</div>
<script type='text/javascript'
	src='../../javascript/include/div/alert.js'></script>
<script type="text/javascript"
	src="../../javascript/include/nseer_cookie/importJs.js"></script>
<script type="text/javascript"
	src="../../javascript/crm/file/treeBusiness.js"></script>
<script type="text/javascript"
	src="../../javascript/crm/file/register.js"></script>
<script type="text/javascript"
	src="../../javascript/include/div/divLocate.js"></script>
<script type="text/javascript"
	src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<script type="text/javascript"
	src="../../javascript/include/nseer_cookie/toolTip.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/NseerTreeDB.js"></script>
<script type="text/javascript" src="../../dwr/interface/Multi.js"></script>
<script type="text/javascript"
	src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../dwr/interface/kindCounter.js"></script>
<script type="text/javascript"
	src="../../javascript/include/nseerTree/nseertree.js"></script>
<script type="text/javascript"
	src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript"
	src="../../javascript/include/covers/cover.js"></script>
<script type="text/javascript"
	src="../../javascript/include/div/divViewChange.js"></script>


