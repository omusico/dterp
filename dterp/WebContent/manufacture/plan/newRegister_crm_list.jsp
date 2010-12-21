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
	import="include.nseer_cookie.*" import="include.nseer_db.*,java.text.*"%>
<%
			nseer_db manufacture_db = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<script language="javascript" src="../../javascript/newWindow3.js" ></script>
<jsp:useBean id="query" scope="page" class="include.query.query" />
<jsp:useBean id="validata" scope="page" class="validata.ValidataNumber" />
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page" />
<jsp:useBean id="mask" class="include.operateXML.Reading" />
<jsp:setProperty name="mask" property="file"
	value="xml/design/design_file.xml" />
<%
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：",
			"document_main", "reason", "value");
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%="您正在做的业务是：生产管理--生产计划管理--客户选择"%></div>
		</td>
	</tr>
</table>

<script src="../../javascript/table/movetable.js">
</script>
<script language="javascript" src="../../javascript/edit/editTable.js">
</script>
<script language="javascript">
//var tableEdit=winopener.document.getElementsByTagName("form")[0];
//var edit=tableEdit.getElementsByTagName("TABLE")[0];
var edit=window.opener.tableOnlineEdit1;//表单名
//表单中需要更新的列（名称，id）

//选择客户方法（参数与列名对应）（8mm切使用）
function update_crm(product_describe_oka, product_describea,tag_x) {
  var names=['product_describe_ok','product_describe'];
  //获得操作行id
  var tag_x=document.getElementById("tag_x").value;
  //找到被操作的行
  var tbodyOnlineEdit=edit.getElementsByTagName("TBODY")[0];
  var theadOnlineEdit=edit.getElementsByTagName("THEAD")[0];
  var trOnlineEdits=edit.getElementsByTagName("tr");//得到表格所有行
  var trOnlineEdit;
 
  for(var x=0;x<trOnlineEdits.length;x++){
    if(trOnlineEdits[x].id==tag_x){
   	  trOnlineEdit=trOnlineEdits[x];
    }
  }
  //表单中需要更新的列
  var values=[product_describe_oka, product_describea];
  if(checkRow(edit,values[0])) {
    setInputValue(trOnlineEdit,names[0],values[0]);//显示客户
    setInputValue(trOnlineEdit,names[1],values[1]);//隐藏域存放客户id
  }
}
//选择客户方法（参数与列名对应）（打孔使用）
function update_crm1(amount_unita, plan_package_clienta,tag_x) {
  var names=['amount_unit','plan_package_client'];
  //获得操作行id
  //var tag_x=document.getElementById("tag_x").value;
  //找到被操作的行
  var tbodyOnlineEdit=edit.getElementsByTagName("TBODY")[0];
  var theadOnlineEdit=edit.getElementsByTagName("THEAD")[0];
  var trOnlineEdits=edit.getElementsByTagName("tr");//得到表格所有行
  var trOnlineEdit;
 
  for(var x=0;x<trOnlineEdits.length;x++){
    if(trOnlineEdits[x].id==tag_x){
   	  trOnlineEdit=trOnlineEdits[x];
    }
  }
  //表单中需要更新的列
  var values=[amount_unita, plan_package_clienta];
  if(checkRow(edit,values[0])) {
    setInputValue(trOnlineEdit,names[0],values[0]);//显示客户
    setInputValue(trOnlineEdit,names[1],values[1]);//隐藏域存放客户id
  }
  this.close();
}
</script>
<%	
	String product_type=request.getParameter("p_t");//0-原纸，1-4分切，2-8mm切，3-打孔
	String tag_x=request.getParameter("tag");//行id
	String first_state="0";//0——第一次加载，1——再次加载
	if(request.getParameter("specString")!=null){
		first_state="1";
	}
	
	//条件是产品业务状态是0（0->在库，1->生产中，2->生产完成，3->转换，4->废弃）的该类型原料
	String specString="";
	String my_sql_search = "SELECT id,CHAIN_NAME,customer_name,type,C_DEFINE1 FROM crm_file where type=(select id from crm_config_public_char where TYPE_NAME='客户') and check_tag=1 and C_DEFINE1='0'";
	if (request.getParameter("specString") != null&&request.getParameter("specString").length() > 0) {
		my_sql_search += " and customer_name like'%"+ request.getParameter("specString") + "%' ";
		specString=request.getParameter("specString");
	}
	
	
	
	String register_ID = (String) session.getAttribute("human_ID");
	String realname = (String) session.getAttribute("realeditorc");
	String rowSummary = demo.getLang("erp", "符合条件的信息总数");

	String tablename = "crm_file";
	String condition = "";
	String queue = "";
	String validationXml = "";
	String nickName = "";
	String fileName = "newRegister_crm_list.jsp";
	int k = 0;
%>

<%@include file="../../include/search_my.jsp"%>
<%--@include file="../../include/search.jsp"--%>
<%
		try {
		ResultSet rs1 = manufacture_db.executeQuery(sql_search);
%>
<%-- 
<%@include file="../../include/search_top.jsp" %>
--%>
<form action="newRegister_crm_list.jsp" method="post" name="search_form" id="search_form">
<table width="98%" style="text-align: right;" align="center">
	<tr>
		<td> 客户名称： <input type="text" size="40" name="specString" value="<%=specString %>"/>
		<input type="hidden" name="p_t" value="<%=product_type%>"><%-- 打开页面类型隐藏域 --%> 
		<input type="hidden" name="tag" id="tag_x" value="<%=tag_x%>"><%-- 操作行id隐藏域 --%> 
		<input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>"></td>
	</tr>
</table>
</form>
<div id="nseer_grid_div"></div>
<%	if(first_state.equals("0")){rs1=null;} 
	if(product_type.equals("2")){ //8mm切客户画面%>
<script type="text/javascript">

var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","客户名称")%>'},
                       {name: '<%=demo.getLang("erp","客户分类")%>'},
                       {name: '<%=demo.getLang("erp","选择")%>'}
]
nseer_grid.column_width=[120,120,60];
nseer_grid.auto='<%=demo.getLang("erp","客户分类")%>';
nseer_grid.data = [

<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 

['<%=rs1.getString("customer_name") %>','<%=rs1.getString("CHAIN_NAME") %>','<div style="text-decoration : underline;color:#3366FF;CURSOR: hand;" onclick=update_crm("<%=exchange.unHtmls(rs1.getString("customer_name"))%>","<%=exchange.unHtmls(rs1.getString("id"))%>","<%=tag_x%>")><%=demo.getLang("erp","选择")%></div>'],
	
<%k++;%>
</page:pages>

['']];
nseer_grid.init();
function init_div(){
	var height=document.getElementById("nseergrid").style.height;
	
	document.getElementById("nseergrid").style.height=parseInt(height)-40;
	document.getElementById("nseer_grid_div").style.left=10;
	document.getElementById("nseer_grid_nseer_xbar").style.top = nseer_grid.int(document.getElementById("nseergrid").style.height) - (nseer_grid.scroll_w - 1);
}
init_div();
var isIE=document.all?true:false;
if(isIE){
	    	window.attachEvent('onresize', init_div);
}else if(!isIE){
		    window.addEventListener('resize',init_div, false);
}
</script>
<%}else if(product_type.equals("3")){//打孔客户页面
	%>
<script type="text/javascript">

var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","客户名称")%>'},
                       {name: '<%=demo.getLang("erp","客户分类")%>'},
                       {name: '<%=demo.getLang("erp","选择")%>'}
]
nseer_grid.column_width=[120,120,60];
nseer_grid.auto='<%=demo.getLang("erp","客户分类")%>';
nseer_grid.data = [

<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 

['<%=rs1.getString("customer_name") %>','<%=rs1.getString("CHAIN_NAME") %>','<div style="text-decoration : underline;color:#3366FF;CURSOR: hand;" onclick=update_crm1("<%=exchange.unHtmls(rs1.getString("customer_name"))%>","<%=exchange.unHtmls(rs1.getString("id"))%>","<%=tag_x%>")><%=demo.getLang("erp","选择")%></div>'],
	
<%k++;%>
</page:pages>

['']];
nseer_grid.init();
function init_div(){
	var height=document.getElementById("nseergrid").style.height;
	
	document.getElementById("nseergrid").style.height=parseInt(height)-40;
	document.getElementById("nseer_grid_div").style.left=10;
	document.getElementById("nseer_grid_nseer_xbar").style.top = nseer_grid.int(document.getElementById("nseergrid").style.height) - (nseer_grid.scroll_w - 1);
}
init_div();
var isIE=document.all?true:false;
if(isIE){
	    	window.attachEvent('onresize', init_div);
}else if(!isIE){
		    window.addEventListener('resize',init_div, false);
}
</script>
	<%
}%>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%--@include file="../../include/search_bottom.jsp"--%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>" />
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<%
	manufacture_db.close();
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>
<%@include file="../../include/head_msg.jsp"%>
