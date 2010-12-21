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
<script language="javascript" src="../../javascript/newWindow.js" ></script>
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
		<div class="div_handbook"><%="您正在做的业务是：生产管理--异常信息管理--异常信息登记--商品添加"%></div>
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
//var edit=window.opener;//表单名
//var edit=window.opener;
//表单中需要更新的列
//var names=['product_name','product_ID','product_describe1','product_describe','amount','amount_unit','cost_price'];
//添加商品方法（参数与列名对应）
function addGoodsItem(product_namea, product_IDa, product_describea, amounta, amount_unita, cost_pricea) {
//暂时无用
var  product_name=product_namea.replace(/★/g,"<br>").replace(/☆/g," ");
var  describe=product_describea.replace(/★/g,"<br>").replace(/☆/g," ");
var  amount_unit=amount_unita.replace(/★/g,"<br>").replace(/☆/g," ");
//表单中需要更新的列
var values=[product_name, product_IDa, describe,describe, amounta, amount_unit, cost_pricea];
 if(checkRow(edit,values[0])) {
 addInstanceRow(edit,names,values);
 }
}
function addSpec(strSpec,strLot_no,strId,strEventName)
{
//alert(strEventName);
 var  strSpeca=strSpec.replace(/★/g,"<br>").replace(/☆/g," ");
 var  strLot_noa=strLot_no.replace(/★/g,"<br>").replace(/☆/g," ");
 var  strIda=strId.replace(/★/g,"<br>").replace(/☆/g," ");
 var eventName=strEventName.replace(/★/g,"<br>").replace(/☆/g," ");
 window.opener.document.getElementById("OnlineEdit1").value =strSpeca;
 window.opener.document.getElementById("OnlineEdit2").value =strLot_noa;
 window.opener.document.getElementById("OnlineEdit3").value =strIda;
  window.opener.document.getElementById("eventName").value =eventName;//场所
 this.close();
}

</script>
<%	
	int i =0;
	//String my_sql_search = "SELECT product_spec,product_lot_no,product_id FROM product_info where product_pstatus='0'";
	String my_sql_search="select p1.id,p1.product_lot_no,p1.product_type,p1.product_spec_id,p1.product_spec,p1.product_status,p1.product_pstatus,p1.product_produce_location " 
		+"FROM product_info p1 "
		+"left join event_info as ei "
		+"on p1.id = ei.event_product_id where ei.id is null and (p1.product_status = 2 or p1.product_status = 3) and (p1.product_pstatus ='异常') ";
	if (request.getParameter("specString") != null&&request.getParameter("specString").length() > 0||request.getParameter("noString") != null&&request.getParameter("noString").length() > 0)
	{	
			//my_sql_search +=" having 1=1 ";
	}
	if (request.getParameter("specString") != null&&request.getParameter("specString").length() > 0) 
	{
	my_sql_search += " and (p1.product_spec like'%"+ request.getParameter("specString") + "%' )";
	i =1;
	}
	if (request.getParameter("noString") != null&&request.getParameter("noString").length() > 0) 
	{
		if(i == 1)
			my_sql_search += " and (p1.product_lot_no like'%"+ request.getParameter("noString") + "%') ";
		else
		{
			my_sql_search += " and (p1.product_lot_no like'%"+ request.getParameter("noString") + "%') ";
			i=1;
		}
	}
	my_sql_search+=" group by p1.id,p1.product_lot_no,p1.product_type,p1.product_spec_id,p1.product_spec,p1.product_status,p1.product_pstatus,p1.product_produce_location order by p1.id";
	String s=request.getParameter("sign");
	int t=Integer.parseInt(s);
	String register_ID = (String) session.getAttribute("human_ID");
	String realname = (String) session.getAttribute("realeditorc");
	String rowSummary = demo.getLang("erp", "符合条件的信息总数");

	String tablename = "product_info";
	String condition = "";
	String queue = "";
	String validationXml = "";
	String nickName = "";
	String fileName = "newRegister_product_list.jsp";
	int k = 0;
%>

<%@include file="../../include/search_my.jsp"%>
<%--@include file="../../include/search.jsp"--%>
<%
		try {
		ResultSet rs1 = manufacture_db.executeQuery(my_sql_search);
%>
<%-- 
<%@include file="../../include/search_top.jsp" %>
--%>
<form action="newRegister_product_list.jsp?" method="post" name="search_form" id="search_form">
<table align=center width="99%" border="0">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE6%> class="TD_STYLE6">
		  原纸规格<input type="text" name="specString" onfocus="" id="" value="" style="width: 18%">
		  <input  name="sign"  value="1" type="hidden">
		  产品批次号<input type="text" name="noString" onfocus="" id="" value="" style="width: 18%">&nbsp;
		  <input type="submit" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>" >
		</td>
	</tr>
</table>
</form>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","原纸规格")%>'},
                       {name: '<%=demo.getLang("erp","产品批次号")%>'},
                       {name: '<%=demo.getLang("erp","选择")%>'}
]
nseer_grid.column_width=[280,280,90];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
<%
if(t==1)
{
%>
nseer_grid.data = [

<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 

<%
String plan_typeD="";
if(rs1.getString("p1.product_produce_location").equals("0")){
	plan_typeD="4分切";
}else if(rs1.getString("p1.product_produce_location").equals("1")){
	plan_typeD="8mm切";
}else if(rs1.getString("p1.product_produce_location").equals("2")){
	plan_typeD="打孔";
}else if(rs1.getString("p1.product_produce_location").equals("3")){
	plan_typeD="包装";
}
%>

['<%=rs1.getString("product_spec") %>','<%=rs1.getString("product_lot_no") %>','<div style="text-decoration : underline;color:#3366FF;CURSOR: hand;" onClick=addSpec("<%=exchange.unHtmls(rs1.getString("product_spec")) %>","<%=exchange.unHtmls(rs1.getString("product_lot_no"))%>","<%=exchange.unHtmls(Integer.toString(rs1.getInt("id")))%>","<%=plan_typeD%>")><%=demo.getLang("erp","选择")%></div>'],	

<%k++;%>
</page:pages>

['']];
<%}%>
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
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%--@include file="../../include/search_bottom.jsp"--%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>" />
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<%
	manufacture_db.close();
	}catch (Exception ex) {
		ex.printStackTrace();
	}
%>
<%@include file="../../include/head_msg.jsp"%>
