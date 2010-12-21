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
			nseer_db mold_db = new nseer_db((String) session
			.getAttribute("unit_db_name"));
nseer_db mold_db1 = new nseer_db((String) session
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
		<div class="div_handbook"><%="您正在做的业务是：模具管理--模具拆卸管理--模具拆卸登记--选择模具"%></div>
		</td>
	</tr>
</table>

<script src="../../javascript/table/movetable.js">
</script>
<script language="javascript" src="../../javascript/edit/editTable.js">
</script>

<%	
String mold_spec="";
String mold_code="";
String mold_machine_number="";

int i = 0;
	String my_sql_search = "SELECT * FROM mold_info left join mold_purchase_order on mold_info.mold_purchase_id=mold_purchase_order.id "+
	"where mold_info.mold_life_status='8'";
if(request.getParameter("mold_spec") != null&&request.getParameter("mold_spec").length() > 0||request.getParameter("mold_code") != null&&request.getParameter("mold_code").length() > 0)
{
	my_sql_search +=" having 1=1 ";
}
if(request.getParameter("mold_spec") != null&&request.getParameter("mold_spec").length() > 0)
{
	mold_spec=request.getParameter("mold_spec");
	my_sql_search += " and mold_spec like'%"+ request.getParameter("mold_spec") + "%' ";
	i =1;
}
if(request.getParameter("mold_code") != null&&request.getParameter("mold_code").length() > 0)
{
	if(i == 1)
	{
		mold_code=request.getParameter("mold_code");
		my_sql_search += " and mold_code like'%"+ request.getParameter("mold_code") + "%' ";
	}
	else
	{
		mold_code=request.getParameter("mold_code");
		my_sql_search += " and mold_code like'%"+ request.getParameter("mold_code") + "%' ";
		i=1;
	}
}	
if(request.getParameter("mold_machine_number") != null&&request.getParameter("mold_machine_number").length() > 0)
{
	if(i == 1)
	{
		mold_machine_number=request.getParameter("mold_machine_number");
		my_sql_search += " and mold_machine_number like'%"+ request.getParameter("mold_machine_number") + "%' ";
	}
	else
	{
		mold_machine_number=request.getParameter("mold_machine_number");
		my_sql_search += " and mold_machine_number like'%"+ request.getParameter("mold_machine_number") + "%' ";
		i=1;
	}
}
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
String keyword2=request.getParameter("mold_spec");
			
			ResultSet rs1 =null;
			if(keyword2!=null){
				rs1=mold_db.executeQuery(sql_search);

			}else{
				intRowCount=0;
			}
		//ResultSet rs1 = mold_db.executeQuery(sql_search);
%>
<%-- 
<%@include file="../../include/search_top.jsp" %>
--%>
<form action="newRegister_product_list.jsp" method="post" name="search_form" id="search_form">
<table align=center width="99%" border="0">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE6%> class="TD_STYLE6">		
		  模具规格<input type="text" name="mold_spec" value="<%=mold_spec %>" style="width: 18%">&nbsp;
		  模具编号<input type="text" name="mold_code" value="<%=mold_code %>" style="width: 18%">&nbsp;
		  机器号<input type="text" name="mold_machine_number" value="<%=mold_machine_number %>" style="width: 18%">
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
                       {name: '<%=demo.getLang("erp","模具规格")%>'},
                       {name: '<%=demo.getLang("erp","模具编号")%>'},
                       {name: '<%=demo.getLang("erp","机器号")%>'},
                       {name: '<%=demo.getLang("erp","选择")%>'}
]
nseer_grid.column_width=[200,200,130,120];
nseer_grid.auto='<%=demo.getLang("erp","备注")%>';
nseer_grid.data = [

<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 

<%
String sql="select * from crm_file where id='"+rs1.getString("mold_purchase_supplier_id")+"'";
 ResultSet rs2 = mold_db1.executeQuery(sql);
 if(rs2.next())
 {
 %>
['<%=rs1.getString("mold_spec") %>','<%=rs1.getString("mold_code") %>','<%=rs1.getString("mold_machine_number")%>',
'<div style="text-decoration : underline;color:#3366FF;CURSOR: hand;" onClick=addSpec("<%=exchange.unHtmls(rs1.getString("mold_spec")) %>","<%=exchange.unHtmls(rs1.getString("mold_code")) %>","<%=exchange.unHtmls(Integer.toString(rs1.getInt("mold_info.id")))%>","<%=exchange.unHtmls(rs1.getString("mold_machine_number")) %>")><%=demo.getLang("erp","选择")%></div>'],	

<%}k++;%>
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
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%--@include file="../../include/search_bottom.jsp"--%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>" />
<input type="hidden" name="" id="rows_num" value="<%=k%>">
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
function addSpec(strSpec,strLot_no,id,stock_time)
{
 var  strSpeca=strSpec.replace(/★/g,"<br>").replace(/☆/g," ");
 var  strLot_noa=strLot_no.replace(/★/g,"<br>").replace(/☆/g," ");
 var ida=id.replace(/★/g,"<br>").replace(/☆/g," ");
 var stock_timea=stock_time.replace(/★/g,"<br>").replace(/☆/g," ");

 window.opener.document.getElementById("mold_spec").value =strSpeca;
 window.opener.document.getElementById("mold_code").value =strLot_noa;
 window.opener.document.getElementById("id").value =ida;
 window.opener.document.getElementById("mold_machine_number").value =stock_timea;
 this.close();
}

</script>
<%
	mold_db.close();
mold_db1.close();
	}catch (Exception ex) {
		ex.printStackTrace();
	}
%>

<%@include file="../../include/head_msg.jsp"%>
