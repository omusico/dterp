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
function addSpec(strSpec,strLot_no,id,stoct_time,zu,zuTime,an,anTime)
{

 var  strSpeca=strSpec.replace(/★/g,"<br>").replace(/☆/g," ");
 var  strLot_noa=strLot_no.replace(/★/g,"<br>").replace(/☆/g," ");
 var ida=id.replace(/★/g,"<br>").replace(/☆/g," ");
 window.opener.document.getElementById("mold_spec").value =strSpeca;
 window.opener.document.getElementById("mold_code").value =strLot_noa;
 window.opener.document.getElementById("id").value =ida;
 window.opener.document.getElementById("stoct_time").value =stoct_time;
 
  window.opener.document.getElementById("zu").value =zu;
   window.opener.document.getElementById("zuTime").value =zuTime;
    window.opener.document.getElementById("an").value =an;
     window.opener.document.getElementById("anTime").value =anTime;
 this.close();
}

</script>
<%	
String mold_spec="";
String mold_code="";
int i = 0;
	String my_sql_search = "select * from mold_purchase_order_detail a,mold_purchase_order b,mold_info c where a.mold_purchase_id=b.id and b.purchase_check_type=1 and (a.mold_id not in (select mold_id from mold_exception)) and a.mold_id=c.id";
if(request.getParameter("mold_spec") != null&&request.getParameter("mold_spec").length() > 0||request.getParameter("mold_code") != null&&request.getParameter("mold_code").length() > 0)
{
	my_sql_search +=" having";
}
if(request.getParameter("mold_spec") != null&&request.getParameter("mold_spec").length() > 0)
{
	 mold_spec=request.getParameter("mold_spec");
	my_sql_search += " mold_spec like'%"+ request.getParameter("mold_spec") + "%' ";
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
		my_sql_search += " mold_code like'%"+ request.getParameter("mold_code") + "%' ";
		i=1;
	}
}	
if(request.getParameter("keyword") != null&&request.getParameter("keyword").length() > 0)
{
	my_sql_search +=" having CUSTOMER_NAME like'%"+request.getParameter("keyword")+"%'";
}
	String register_ID = (String) session.getAttribute("human_ID");
	String realname = (String) session.getAttribute("realeditorc");
	String rowSummary = demo.getLang("erp", "符合条件的信息总数");

	String tablename = "product_info";
	String condition = "";
	String queue = "";
	String validationXml = "";
	String nickName = "";
	String fileName = "newRegister_product_list1.jsp";
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
<form action="register_list.jsp" method="post" name="search_form" id="search_form">
<table align=center width="99%" border="0">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE6%> class="TD_STYLE6">		
		  模具规格<input type="text" name="mold_spec" value="<%=mold_spec %>" style="width: 18%">&nbsp;
		  模具编号<input type="text" name="mold_code" value="<%=mold_code %>" style="width: 18%">
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
                       {name: '<%=demo.getLang("erp","采购订单号")%>'},
                       {name: '<%=demo.getLang("erp","模具规格")%>'},
                       {name: '<%=demo.getLang("erp","模具编号")%>'},
                       {name: '<%=demo.getLang("erp","选择")%>'},
                       {name: '<%=demo.getLang("erp","&nbsp;")%>'}
]
nseer_grid.column_width=[200,100,100,120,100];
nseer_grid.auto='<%=demo.getLang("erp","&nbsp;")%>';
nseer_grid.data = [

<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 

['<%=rs1.getString("purchase_code") %>','<%=rs1.getString("mold_spec") %>','<%=rs1.getString("mold_code") %>',
'<div style="text-decoration : underline;color:#3366FF;CURSOR: hand;" onClick=addSpec("<%=exchange.unHtmls(rs1.getString("mold_spec")) %>","<%=exchange.unHtmls(rs1.getString("mold_code")) %>","<%=exchange.unHtmls(Integer.toString(rs1.getInt("mold_id")))%>","<%=rs1.getString("stock_time")%>","<%=rs1.getString("assembler")%>","<%=rs1.getString("assembly_time")%>","<%=rs1.getString("installer")%>","<%=rs1.getString("installation_time")%>")><%=demo.getLang("erp","选择")%></div>'],	

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
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%--@include file="../../include/search_bottom.jsp"--%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>" />
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<%
	mold_db.close();
	}catch (Exception ex) {
		ex.printStackTrace();
	}
%>
<%@include file="../../include/head_msg.jsp"%>
