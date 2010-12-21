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
	import="java.sql.*" import="java.util.*" import="java.io.*"
	import="include.nseer_db.*,include.nseerdb.*,java.text.*,include.nseer_cookie.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<%
			nseer_db design_db = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<%
			nseer_db designdb = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<%
			nseer_db typedb = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：",
			"document_main", "reason", "value");
%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page"
	class="include.query.getRecordCount" />
<jsp:useBean id="vt" scope="page" class="validata.ValidataTag" />
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/input_control/focus.css">
<link rel="stylesheet" type="text/css"
	href="../../css/include/nseerTree/nseertree.css" />
<link rel="stylesheet" type="text/css"
	href="../../css/include/nseer_cookie/xml-css.css" />
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
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
                window.alert(res);
                mutiValidation.product_name.value="";
                }
            } else { //页面不正常
                window.alert("您所请求的页面有异常。");
            }
        }
    }
 // 
    function userCheck() {
  var uname = mutiValidation.product_name.value;
   sendRequest('../../design_file_LoginServlet?uname='+ uname );
  
}

</script>
<script type="text/javascript">
function  checkRegister()
{
	 if(checkIsNull()&&checkLong())
	 {
	  return true;
	 }
	   return false;
}

function checkIsNull()
{
	
	var name=document.getElementById("product_name").value;
	var type=document.getElementById("kind_chain").value;
	var desingUse=document.getElementById("type").value;//1——纸类型2——模具
	var chanpin_length=document.getElementById("product_length").value; //产品长度
	var product_pallet_sf=document.getElementById("product_pallet_sf").value; //栈板号标示


	if(name=="")
	{
		alert("产品名称不能为空");
		return false;
	}
	if(type=="")
	{
		alert("产品分类不能为空");
		return false;
	}
	 if(chanpin_length==""&&desingUse==1){
	    alert("产品长度不能为空");
		return false;
	}
	 
	
		return true;   
}


function checkLong()
{

var flag=true;
//var reg=/^[waste_amount]+[0-9A-Za-z]+$/;
if(document.getElementById("text1").value!=""){
var reg_float=/^\d+(\.{1}\d+)?$/;
	if(reg_float.test(document.getElementById("text1").value)==false){
		alert("产品长度只能为数字");
		return false;
}	
}
return true;
}
//手动提交表单删除
function delInfo(){
	var res=confirm("是否确认删除该信息？");
	if(res){
		mutiValidation.action="../../design_file_del_ok";
		mutiValidation.submit();
	}else{
	return;
	}
}
function select()
{
	if(document.getElementById("type").value=="1")
	{
		document.getElementById("hid1").style.display="inline";
		document.getElementById("hid2").style.display="inline";
		document.getElementById("text1").disabled = false;
		document.getElementById("text1").className="INPUT_STYLE5";
		document.getElementById("text2").value = "";
		document.getElementById("text2").disabled = "disabled";
		document.getElementById("text2").className="INPUT_STYLE1";
		document.getElementById("text3").value = "";
		document.getElementById("text3").disabled = "disabled";
		document.getElementById("text3").className="INPUT_STYLE1";
		document.getElementById("text4").value = "";
		document.getElementById("text4").disabled = "disabled";
		document.getElementById("text4").className="INPUT_STYLE1";
		document.getElementById("text5").value = "";
		document.getElementById("text5").disabled = "disabled";
		document.getElementById("text5").className="INPUT_STYLE1";
		document.getElementById("text6").value = "";
		document.getElementById("text6").disabled = "disabled";
		document.getElementById("text6").className="INPUT_STYLE1";
		
		
		document.getElementById("text1").disabled = false;
		document.getElementById("text8").className="INPUT_STYLE5";
		
	}
	else if(document.getElementById("type").value=="2")
	{
		document.getElementById("hid1").style.display="none";
		document.getElementById("hid2").style.display="none";
		document.getElementById("text2").disabled = false;
		document.getElementById("text2").className="INPUT_STYLE5";
		document.getElementById("text3").disabled = false;
		document.getElementById("text3").className="INPUT_STYLE5";
		document.getElementById("text4").disabled = false;
		document.getElementById("text4").className="INPUT_STYLE5";
		document.getElementById("text5").disabled = false;
		document.getElementById("text5").className="INPUT_STYLE5";
		document.getElementById("text6").disabled = false;
		document.getElementById("text6").className="INPUT_STYLE5";
		document.getElementById("text1").value = "";
		document.getElementById("text1").disabled = "disabled";
		document.getElementById("text1").className="INPUT_STYLE1";
		
		document.getElementById("text8").value = "";
		document.getElementById("text8").disabled = "disabled";
		document.getElementById("text8").className="INPUT_STYLE1";
	}
}
</script>
<body onload="select()">
<%
	String id = request.getParameter("id");
	String product_ID = request.getParameter("product_ID");
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" class="x-form" method="post"
	action="../../design_file_change_ok?id=<%=id%>"
	onSubmit="return checkRegister()">
	<input name="id"
	value="<%=id %>" type="hidden">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1">
		<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;
		<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","删除")%>" onclick="delInfo()">&nbsp;
		<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div>
		</td>
	</tr>
</table>

<%
	String changer = (String) session.getAttribute("realeditorc");
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	String time = formatter.format(now);
	String register_time = "";
	int k = 1;
	try {
		String sqll = "select * from design_file where id=" + id;
		ResultSet rss = designdb.executeQuery(sqll);
		while (rss.next()) {
			String provider_group = exchange.unHtml(rss
			.getString("provider_group"));
			String product_describe = exchange.unHtml(rss
			.getString("product_describe"));
			if (rss.getString("register_time").equals(
			"1800-01-01 00:00:00.0")) {
		register_time = "";
			} else {
		register_time = rss.getString("register_time");
			}
%>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
	<tr style="background-image:url(../../images/line.gif)">
		<td colspan="4">
		<div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp", "产品信息修改")%></div>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "档案编号")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="86.5%" colspan="3"><input
			name="product_ID" type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
			value="<%=rss.getString("product_ID")%>" onFocus="this.blur()"></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "产品名称")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><input
			name="product_name" type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
			value="<%=exchange.toHtml(rss.getString("product_name"))%>" onFocus="this.blur()" id="product_name"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "产品简称")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="product_nick" type="text" value="<%=rss.getString("product_nick")%>" style="width: 45%" onFocus="this.blur()">
		</td>
	</tr>
	<input type="hidden" name="oldKind_chain"
		value="<%=rss.getString("chain_id")%> <%=exchange.toHtml(rss.getString("chain_name"))%>">

	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp", "产品分类")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
		<input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" id="kind_chain" name="fileKind_chain" style="width:80%" onFocus="showKind('nseer1',this,showTree)" 
			onkeyup="search_suggest(this.id)" autocomplete="off" value="<%=rss.getString("chain_id")%> <%=exchange.toHtml(rss.getString("chain_name"))%>" onchange="clear_human()"> 
		<input id="kind_chain_table" type="hidden" value="design_config_file_kind"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "用途类型")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">
		<select <%=SELECT_STYLE5%> class="SELECT_STYLE5" id="type" name="type" style="width:50%" onchange="select()">
			<%
						// String sqltest="select * from design_config_public_char where kind='产品用途' order by type_ID" ;
						
					String sql4 = "";
					sql4 = "select * from design_config_public_char where kind='产品用途' order by id";
					ResultSet rs4 = typedb.executeQuery(sql4);
					while (rs4.next()) {
					if (rs4.getString("id").equals( rss.getString("type"))) {
			%>
			<option value="<%=exchange.toHtml(Integer.toString((rs4.getInt("id"))))%>" selected><%=exchange.toHtml(rs4.getString("type_name"))%></option>
			<%
			} else {
			%>
			<option value="<%=exchange.toHtml(Integer.toString((rs4.getInt("id"))))%>"><%=exchange.toHtml(rs4.getString("type_name"))%></option>
			<%
			}
					}
			%>

		</select></td>
	</tr>

	<%
				java.util.Date now2 = new java.util.Date();
				SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				now2 = formatter2.parse(rss.getString("register_time"));
				String reg_time = formatter2.format(now2);
	%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><div id="hid1"><font color=red>*</font></div><%=demo.getLang("erp", "产品长度")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%">
		<input id="text1" type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="width:80%"
			<%
 if(rss.getInt("product_length")==0)
 {
 %> value=""
			<%} 
 else
 {%>
			value="<%=exchange.toHtml(Integer.toString(rss.getInt("product_length")))%>"
			<% }%> name="product_length"> 
		</td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><div id="hid2"></div><%=demo.getLang("erp", "栈板号标示")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			id="text8" type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="width:80%"
			name="product_pallet_sf" value="<%=rss.getString("product_pallet_sf") %>"></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "品名和规格上模")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
		<input id="text2" type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="width:80%" name="spec_top"
			<%
 if(rss.getString("spec_top").equals("null"))
 {
 %> value=""
			<%} 
 else
 {%> value="<%=rss.getString("spec_top")%>" <% }%>></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "品名和规格下模")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
		<input id="text3" type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="width:80%" name="spec_bottom"
			<%
 if(rss.getString("spec_bottom").equals("null"))
 {
 %>
			value="" <%} 
 else
 {%> value="<%=rss.getString("spec_bottom")%>"
			<% }%>></td>
	</tr>

	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "图纸号上模")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
		<input id="text4" type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="width:80%" name="drawing_top"
			<%
 if(rss.getString("drawing_top").equals("null"))
 {
 %>
			value="" <%} 
 else
 {%> value="<%=rss.getString("drawing_top")%>"
			<% }%>></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "图纸号下模")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
		<input id="text5" type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="drawing_bottom" style="width:80%"
			<%
 if(rss.getString("drawing_bottom").equals("null"))
 {
 %>
			value="" <%} 
 else
 {%>
			value="<%=rss.getString("drawing_bottom")%>" <% }%>></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "图纸号衬铁")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
		<input id="text6" type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" style="width:80%" name="drawing_lron"
			<%
 if(rss.getString("drawing_lron").equals("null"))
 {
 %>
			value="" <%} 
 else
 {%> value="<%=rss.getString("drawing_lron")%>"
			<% }%>></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "备注")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
			<input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="c_define2" type="text" style="width:49%" value="<%=rss.getString("c_define2") %>" >
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "登记人")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="18%">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=changer %>" style="width: 45%" onFocus="this.blur()">
		</td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "登记时间")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="18%">
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=time.substring(0,10) %>" style="width: 45%" onFocus="this.blur()">
		</td>
	</tr>
	<%
	
	if(rss.getString("check_tag").equals("2")){
	%>
	<tr style="background-image:url(../../images/line.gif)">
		<td colspan="4">
		<div style="width:100%; height:12; padding:3px;"><%=demo.getLang("erp", "未通过原由")%></div>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><%=demo.getLang("erp", "未通过原由")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2"  colspan="3"><textarea readonly="readonly"
			<%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="demand" id="demand"><%=rss.getString("remark") %></textarea>
		</td>
	</tr>
	<%	
		
	} %>

	<!-- 以下不需要 -->
	<!-- 市场单价、计划成本单价 -->
	<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "市场单价(元)")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			name="list_price" type="hidden"
			value="<%=rss.getString("list_price")%>"><%=new java.text.DecimalFormat((String) application
									.getAttribute("nseerPrecision")).format(rss
									.getDouble("list_price"))%></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "计划成本单价")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			name="cost_price" type="hidden"
			value="<%=rss.getString("cost_price")%>"><%=new java.text.DecimalFormat((String) application
									.getAttribute("nseerPrecision")).format(rss
									.getDouble("cost_price"))%></td>
	</tr>
	<%
				String[] attachment_name1 = DealWithString.divide(rss
				.getString("attachment_name"), 20);
	%>
	<!-- 供应商集合、产品描述 -->
	<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
		<td <%=TD_STYLE4%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp", "供应商集合")%>
		&nbsp;</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><textarea
			<%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="provider_group"><%=provider_group%></textarea>
		</td>
		<td <%=TD_STYLE4%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp", "产品描述")%>
		&nbsp;</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><textarea
			<%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="product_describe"><%=product_describe%></textarea>
		</td>
	</tr>
	<!-- 产品经理、变更人 -->
	<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "产品经理")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" id="select4" name="select4"
			type="text" style="width:49%"
			onfocus="loadAjaxDiv('select4','kind_chain',event);this.blur();"
			value="<%=rss.getString("responsible_person_ID")%>/<%=exchange.toHtml(rss.getString("responsible_person_name"))%>"
			readonly /></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "变更人")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			name="changer" type="hidden" value="<%=exchange.toHtml(changer)%>"><%=exchange.toHtml(changer)%></td>
	</tr>
	<!-- 变更人编号、变更时间 -->
	<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "变更人编号")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="changer_ID"
			style="width:49%"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "变更时间")%>&nbsp;</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			name="change_time" type="hidden" width="100%"
			value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
	</tr>
	<!-- 计量单位、计量值 -->
	<tr <%=TR_STYLE1%> class="TR_STYLE1" style="display:none">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "计量单位")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
			name="personal_unit" style="width:49%"
			value="<%=exchange.toHtml(rss.getString("personal_unit"))%>"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "计量值")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input
			type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"
			name="personal_value" style="width:49%"
			value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rss.getDouble("personal_value"))%>"></td>
	</tr>



	<jsp:useBean id="mask" class="include.operateXML.Reading" />
	<jsp:setProperty name="mask" property="file"
		value="xml/design/design_file.xml" />
	<%
				ResultSet rs = rss;
				String nickName = "产品档案";
	%>
	<%@include file="../../include/cDefineMouC.jsp"%>
	<input name="lately_change_time" type="hidden" width="100%"
		value="<%=rss.getString("change_time")%>">
	<input name="file_change_amount" type="hidden" width="100%"
		value="<%=rss.getString("file_change_amount")%>">
</table>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>"
	value="<%=session.getAttribute(Globals.TOKEN_KEY)%>"></form>
</div>

<%
		design_db.close();
		}
		designdb.close();
		typedb.close();
	} catch (Exception ex) {
		out.println("error" + ex);
	}
%>



<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/NseerTreeDB.js'></script>
<script type='text/javascript'
	src="../../javascript/include/nseerTree/nseertree.js"></script>
<script type='text/javascript'
	src="../../javascript/design/file/treeBusiness.js"></script>
<script type="text/javascript"
	src="../../javascript/design/file/responsible.js"></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript'
	src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../dwr/interface/kindCounter.js'></script>
<script type="text/javascript"
	src="../../javascript/include/validate/validation-framework.js"></script>
<script type='text/javascript'
	src='../../javascript/include/covers/cover.js'></script>
<script type='text/javascript'
	src='../../javascript/include/div/divViewChange.js'></script>
<script type='text/javascript'
	src='../../javascript/include/div/divLocate.js'></script>
<!-- 实现放大镜加AJAX的JS  -->

<div id="nseer1" nseerDef="dragAble"
	style="position:absolute;left:300px;top:100px;display:none;width:450px;height:300px;overflow:hidden;z-index:1;background:#E8E8E8;">
<iframe src="javascript:false"
	style="position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe>
<TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
	<TBODY>
		<TR>
			<TD width="1%" height="1%"><IMG src="../../images/bg_0ltop.gif"></TD>
			<TD width="100%" background="../../images/bg_01.gif"></TD>
			<TD width="1%" height="1%"><IMG src="../../images/bg_0rtop.gif"></TD>
		</TR>
		<TR>
			<TD background="../../images/bg_03.gif"></TD>
			<TD>
			<div class="cssDiv1">
			<div class="cssDiv2"><%=demo.getLang("erp", "上海慧索计算机科技ERP")%></div>
			</div>
			<div class="cssDiv3" onclick="n_D.closeDiv('hidden')"
				onmouseover="n_D.mmcMouseStyle(this);"></div>
			<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"
				onmouseover="n_D.mmcMouseStyle(this);"></div>
			<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(40)"
				onmouseover="n_D.mmcMouseStyle(this);"></div>
			<div id='nseer1_0'
				style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;">
			</div>
			</TD>
			<TD background="../../images/bg_04.gif"></TD>
		</TR>
		<TR>
			<TD width="1%" height="1%"><IMG
				src="../../images/bg_0lbottom.gif"></TD>
			<TD background="../../images/bg_02.gif"></TD>
			<TD width="1%" height="1%"><IMG
				src="../../images/bg_0rbottom.gif"></TD>
		</TR>
	</TBODY>
</TABLE>
</div>
</body>
<script>
var Nseer_tree1;
function showTree(){
 if(Nseer_tree1=='undefined'||typeof(Nseer_tree1)=='object'){return;}
 Nseer_tree1 = new Tree('Nseer_tree1');
  Nseer_tree1.setParent('nseer1_0');
 Nseer_tree1.setImagesPath('../../images/');
 Nseer_tree1.setTableName('design_config_file_kind');
 Nseer_tree1.setModuleName('../../xml/design/file');
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","全部分类")%>',false,'1',[]);
initMyTree(Nseer_tree1);
createButton('../../xml/design/file','design_config_file_kind','treeButton');

}
</script>