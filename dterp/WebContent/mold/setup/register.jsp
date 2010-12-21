<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*,java.text.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db mold_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="OperateXML" class="include.nseer_cookie.OperateXML" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
	 %>
 <%@include file="../include/head.jsp"%>
<script type="text/javascript">
var openWin=null;
function openS()
{
document.getElementById("add").disabled="disabled";
if(openWin==null){
	openWin=winopen("newRegister_product_list.jsp","","height=600,width=680,toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=yes");
}else{
	openWin.focus();
}

}
function closediv(){
	var loaddiv=document.getElementById("loaddiv");
	loaddiv.style.display="none";
}
function CheckForm(TheForm){
    if(TheForm.mold_spec.value == ""||TheForm.mold_code.value == ""||TheForm.purchase_code.value == ""||TheForm.stock_time.value == ""||TheForm.mold_purchase_supplier.value == "")
    {
    	alert("请选择模具！");
		return(false); 
    }
    else if(TheForm.mold_machine_number.value== "")
    {
    	alert("机器号不能为空！");
		return(false);
    }
    else if(TheForm.top_mold_code.value== "")
    {
    	alert("上模架编号不能为空");
		return(false);
    }
    else if(TheForm.bottom_mold_code.value== "")
    {
    	alert("下模架编号不能为空");
		return(false);
    }
else if(TheForm.lock_code.value== "")
    {
    	alert("导套编号不能为空");
		return(false);
    }
else if(TheForm.assembler.value== "")
    {
    	//alert("组装者不能为空");
		//return(false);
    }
else if(TheForm.assembly_time.value== "")
    {
    	//alert("组装时间不能为空");
		//return(false);
    }
else if(TheForm.installer.value== "")
    {
    	alert("安装者不能为空");
		return(false);
    }
else if(TheForm.installation_time.value== "")
    {
    	alert("安装时间不能为空");
		return(false);
    }
    return(true);
}
</script>
<script language="javascript">
//计划NO重复验证
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
     	//window.alert(XMLHttpReq.status);
         if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息
             var res=XMLHttpReq.responseXML.getElementsByTagName("res")[0].firstChild.data;
                //document.getElementById("message").innerHTML=res;
            	  
            	if(res!="true"){
                window.alert(res);
                mutiValidation.mold_machine_number.value="";
                }
            } else { //页面不正常
                window.alert("您所请求的页面有异常。");
            }
        }
    }
 // 身份验证函数
function userCheck() {
  var uname = mutiValidation.mold_machine_number.value;
	if(uname.length>0){
   sendRequest('../../mold_ValidateMachine?uname='+ uname );
   }
  
}

</script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>

<script language="javascript" src="../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type='text/javascript' src="../../javascript/include/nseer_cookie/toolTip.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type='text/javascript' src='../../javascript/include/div/divLocate.js'></script>

<body>

<div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
 <form id="mutiValidation" class="x-form" method="post" action="../../register_setup_ok" onSubmit="return CheckForm(this)">
 <%--查询 订货单  Id--%>
 <%
    String order_no="";//模具组装编号
 	String sql="select * from option_no where no_value='SC105'";
    ResultSet option_rs= mold_db.executeQuery(sql);
    if(option_rs.next())
    {
    	order_no=option_rs.getString("no_type");
    }
 
 %>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div id="loaddiv" style="display:none;border:1px solid red; height:20px;background-color: #FF0033;width:58%;float :left ;" ></div>
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDraft("'mutiValidation','../../design_file_register_draft_ok','../../xml/design/design_file.xml'",request)%>&nbsp;
 &nbsp;&nbsp;&nbsp;&nbsp;
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" id="add" onclick="openS()" value="<%=demo.getLang("erp","选择模具")%>">&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1">&nbsp;</div>
 </td>
 <tr> 
<tr>
<td align=left  width="40%">
组装编号：<%=demo.getLang("erp",order_no)%>
<%--
<input style="width:100%" readonly="readonly" name="" type="text" value="QR/DT-JS-19"   >
 --%>
</td> 
  </tr>
</table>
<table>
<tr>
<td>
&nbsp;
</td>
</tr>
</table>


<%--@include file="../include/paper_top.html"--%>
<table align=center class="TABLE_STYLE4" width = "100%" border="0"> 
<tr  class="TR_STYLE1" >
 <td align=right  width="8%">模具规格：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%"   readonly="readonly" id="mold_spec" name="mold_spec" type="text" 
 <%if(request.getParameter("mold_spec")==null) {%>
 	value="" 
 	<%}if(request.getParameter("mold_spec")!=null) {%>
 	value="<%=request.getParameter("mold_spec")%>"
 	<%} %>
 	  ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","模具编号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" id="mold_code" name="mold_code" type="text" 
 <%if(request.getParameter("mold_code")==null) {%>
 	value="" 
 	<%}if(request.getParameter("mold_code")!=null) {%>
 	value="<%=request.getParameter("mold_code")%>" 
 	<%} %> ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","订单号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" id="purchase_code" name="purchase_code" type="text" 
 <%if(request.getParameter("purchase_code")==null) {%>
 	value="" 
 	<%}if(request.getParameter("purchase_code")!=null) {%>
 value="<%=request.getParameter("purchase_code")%>" 
 <%} %>  ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","入库日期")%>：</td>
  <%--入库日期 --%>
 <%
	String stock_time="";
 	if(request.getParameter("stock_time")!=null)
 	{
 		stock_time=request.getParameter("stock_time");
 		stock_time=stock_time.substring(0,10);
 	}
 	
 	
 %>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" id="stock_time" name="stock_time" type="text" value="<%=stock_time %>"></td>

 <td align=right class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 </tr>
  <tr  class="TR_STYLE1" >
 <td align=right  width="8%">机器号：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" id="mold_machine_number" name="mold_machine_number" type="text" onblur="userCheck()" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"
 <%if(request.getParameter("mold_machine_number")==null) {%>
 	value="" 
 	<%}if(request.getParameter("mold_machine_number")!=null) {%>
 value="<%=request.getParameter("mold_machine_number")%>" 
 <%} %>
 ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","上模架编号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="top_mold_code" type="text" ReadOnly id="top_mold_code"
 <%if(request.getParameter("top_mold_code")==null) {%>
 	value="" 
 	<%}if(request.getParameter("top_mold_code")!=null) {%>
 value="<%=request.getParameter("top_mold_code")%>" 
 <%} %> ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","下模架编号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="bottom_mold_code" type="text" ReadOnly id="bottom_mold_code"
 <%if(request.getParameter("bottom_mold_code")==null) {%>
 	value="" 
 	<%}if(request.getParameter("bottom_mold_code")!=null) {%>
  value="<%=request.getParameter("bottom_mold_code")%>" 
  <%} %> ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","导套编号")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="lock_code" type="text"  ReadOnly id="lock_code"
 <%if(request.getParameter("lock_code")==null) {%>
 	value="" 
 	<%}if(request.getParameter("lock_code")!=null) {%>
 value="<%=request.getParameter("lock_code")%>" 
 <%} %> ></td>

  </tr>
 <tr  class="TR_STYLE1" >
 
    <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","组装者")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="assembler" type="text" ReadOnly
 <%if(request.getParameter("assembler")==null) {%>
 	value="" 
 	<%}if(request.getParameter("assembler")!=null) {%>
 value="<%=request.getParameter("assembler")%>" 
 <%} %> ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","组装时间")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="assembly_time" type="text" id="date_end" onkeypress="event.returnValue=false;" ReadOnly
 <%if(request.getParameter("assembly_time")==null) {%>
 	value="" 
 	<%}if(request.getParameter("assembly_time")!=null) {%>
 value="<%=request.getParameter("assembly_time")%>" 
 <%} %> ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","安装者")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="installer" type="text" 
 <%if(request.getParameter("installer")==null) {%>
 	value="" 
 	<%}if(request.getParameter("installer")!=null) {%>
 value="<%=request.getParameter("installer")%>" 
 <%} %> ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","安装时间")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" name="installation_time" type="text" id="date_start" onkeypress="event.returnValue=false;"
 <%if(request.getParameter("installation_time")==null) {%>
 	value="" 
 	<%}if(request.getParameter("installation_time")!=null) {%>
 value="<%=request.getParameter("installation_time")%>" 
 <%} %> ></td>
 <td align=left class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 </tr>
 
 <tr  class="TR_STYLE1" >
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","供应商")%>：</td>
 <td align=left class="TD_STYLE2" width="12%" colspan="3"><input style="width:100%" readonly="readonly" id="mold_purchase_supplier" name="mold_purchase_supplier" type="text" 
 <%if(request.getParameter("mold_purchase_supplier")==null) {%>
 	value="" 
 	<%}if(request.getParameter("mold_purchase_supplier")!=null) {%>
 value="<%=request.getParameter("mold_purchase_supplier")%>" 
 <%} %> ></td>
 <td align=left class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
  <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 </tr>
 <tr  class="TR_STYLE1" >
 	 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
  <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 <td align=right class="TD_STYLE8" width="8%" style="display:none"><%=demo.getLang("erp","使用周期")%>：</td>
 <td align=left class="TD_STYLE2" width="12%" style="display:none"><input style="width:100%" name="mold_life" type="text" value=""
 <%if(request.getParameter("mold_life")==null) {%>
 	value="" 
 	<%}if(request.getParameter("mold_life")!=null) {%>
 value="<%=request.getParameter("mold_life")%>" 
 <%} %> ></td>
 <td align=left class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 <td align=left class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 <td style="display:none"><input id="id" name="id" value="<%=request.getParameter("id")%>"></td>
 </tr>
</table>

<%
String time="";
String operator=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
time=formatter.format(now);
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
String file1=path+"xml/design/design_file.xml";
List returnList=OperateXML.returnList(file1,"name","mutiValidation","name","name","required","n");
%>

<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr style="background-image:url(../../images/line.gif)" style="width:"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","安装检查信息")%></div></td></tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","1：空气流量的设定")%></td>
  <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><input type="radio" name="16" value="OK" checked>OK &nbsp;<input type="radio" name="16" value="NG" >NG 
 </td>
</tr>
<td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","2：毛羽烧温度设定")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><input type="radio" name="17" value="OK" checked>OK &nbsp;<input type="radio" name="17" value="NG">NG </td>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","3：摇杆间隙确认")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><input type="radio" name="18" value="OK" checked>OK &nbsp;<input type="radio" name="18" value="NG">NG </td>
</tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","4：上、下死点位置调整")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><input type="radio" name="19" value="OK" checked>OK &nbsp;<input type="radio" name="19" value="NG" >NG </td>
</tr>
<td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","5：模具处微调仪确认")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><input type="radio" name="20" value="OK" checked>OK &nbsp;<input type="radio" name="20" value="NG" >NG </td>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","6：圆孔感应器确认")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><input type="radio" name="21" value="OK" checked>OK &nbsp;<input type="radio" name="21" value="NG">NG </td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","7：纸带压块确认")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" style="vertical-align:middle; text-align:center;"><input type="radio" name="22" value="OK" checked>OK &nbsp;<input type="radio" name="22" value="NG">NG </td>
</tr>

<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/design/design_file.xml"/>
<%String nickName="产品档案";%>
<%@include file="../../include/cDefineMou.jsp"%>

</table>
<table align=center class="TABLE_STYLE4" width = "100%" border="0"> 
<tr  class="TR_STYLE1" >
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","登记人")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" value="<%=operator %>" name="operator" type="text" ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td align=left class="TD_STYLE2" width="12%"><input style="width:100%" readonly="readonly" name="mold_ai_regist_time" type="text" 
 <%if(request.getParameter("mold_ai_regist_time")==null) {%>
 	value="<%=time %>" 
 	<%}if(request.getParameter("mold_ai_regist_time")!=null) {%>
 value="<%=request.getParameter("mold_ai_regist_time")%>" 
 <%} %> ></td>
 <td align=left class="TD_STYLE8" width="8%">&nbsp;</td>
 <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
  <td align=left class="TD_STYLE2" width="12%">&nbsp;</td>
 </tr>
 
 <tr  class="TR_STYLE1" >
 
 </tr>
</table>
<%--@include file="../include/paper_bottom.html"--%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
</div>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
<script type="text/javascript">
document.body.onunload=function(){
	if(openWin!=null){
		openWin.close();
	}
}
</script>
<%mold_db.close(); %>
