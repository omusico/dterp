<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stock_b = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../javascript/newWindow.js" ></script>
<jsp:useBean id="query" scope="page" class="include.query.query"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/design/design_file.xml"/>
<% String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>

<script src="../../javascript/table/movetable.js">
</script>
<script language="javascript" src="../../javascript/edit/editTable.js">
</script>


<script language="javascript">
//var tableEdit=winopener.document.getElementsByTagName("form")[0];
//var edit=tableEdit.getElementsByTagName("TABLE")[0];
var edit=window.opener.tableOnlineEdit1;
var names=['product_name','product_ID','product_describe_ok','amount','amount_unit','cost_price','depot1','productId'];
function addGoodsItem(product_namea, product_IDa, product_describea, amounta, amount_unita, cost_pricea,depot1,productId) {

var  product_name=product_namea.replace(/★/g,"<br>").replace(/☆/g," ");
var  describe=product_describea.replace(/★/g,"<br>").replace(/☆/g," ");
var  amount_unit=amount_unita.replace(/★/g,"<br>").replace(/☆/g," ");

var values=[product_name, product_IDa, product_describea, amounta, amount_unita, cost_pricea,depot1,productId];
if(checkRo(edit,values[1])) {
 addInstanceRow(edit,names,values);
 }
}
</script>

<%
String tablename="design_file";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and type!='服务型产品'";
String queue="order by register_time";
String validationXml="../../xml/design/design_file.xml";
String nickName="产品档案";
String fileName="register_product_list1.jsp";
String rowSummary=demo.getLang("erp","符合条件的产品档案总数");
%>
<%-- 
<%@include file="../../include/search.jsp"%>
--%>
<%try{
String y_paper = ""; String lotNo = ""; String invoice = ""; String with = ""; String length= ""; String weight = "";
String my_sql_search = "SELECT * FROM product_info LEFT JOIN product_base_info ON product_info.id = product_base_info.product_id  left join stock_in_detail on stock_in_detail.In_Detail_product_id=product_info.id left join stock_in on stock_in.id = stock_in_detail.stock_in_id WHERE product_type=0 and product_status=1 and product_stock!='' and stock_in.stock_in_check_status=1 and product_info.product_out_apply_status=0";
if(request.getParameter("yuanPaper")!=null&&request.getParameter("yuanPaper").length()!=0){
	y_paper = request.getParameter("yuanPaper");
	my_sql_search+=" and product_spec like '%"+request.getParameter("yuanPaper")+"%'";
}
if(request.getParameter("LotNo")!=null&&request.getParameter("LotNo").length()!=0){
	lotNo=request.getParameter("LotNo");
	my_sql_search+=" and product_info.product_lot_no like '%"+request.getParameter("LotNo")+"%'";
}
if(request.getParameter("invoiceNo")!=null&&request.getParameter("invoiceNo").length()!=0){
	invoice=request.getParameter("invoiceNo");
	my_sql_search+=" and product_base_invoice_no like '%"+request.getParameter("invoiceNo")+"%'";
}
if(request.getParameter("width")!=null&&request.getParameter("width").length()!=0){
	with = request.getParameter("width");
	my_sql_search+=" and product_base_width like '%"+request.getParameter("width")+"%'";	
}
if(request.getParameter("length")!=null&&request.getParameter("length").length()!=0){
	length=request.getParameter("length");
	my_sql_search+=" and product_base_length like '%"+request.getParameter("length")+"%'";
}
if(request.getParameter("weight")!=null&&request.getParameter("weight").length()!=0){
	weight=request.getParameter("weight");
	my_sql_search+=" and product_base_weight like '%"+request.getParameter("weight")+"%'";
}
//出库时间未实现
%>
<%@include file="../../include/search_my.jsp"%>
<%

ResultSet rs1=stock_db.executeQuery(sql_search);
%>
<form  name="search_form" id="search_form" action="register_product_list1.jsp" method="post">
<table width="98%" align="center">
  <tr>
    <td width="24%">原纸规格：<input type="text" name="yuanPaper" value="<%=y_paper %>" /></td>
    <td width="24%"> LOT No.：<input type="text" name="LotNo" value="<%=lotNo %>" /></td>
    <td width="26%">Invoice No.：<input type="text" name="invoiceNo" value="<%=invoice %>" /></td>
    <td width="26%"><input type="hidden" name="txtSearch" value="45" /></td>
  </tr>
  <tr>
    <td width="24%">宽度(mm)：<input type="text" name="width" value="<%=with %>" /></td>
    <td width="24%">长度(m)：<input type="text" name="length" value="<%=length %>" /></td>
    <td width="26%">重量(kgs)&nbsp;&nbsp;：<input type="text" name="weight" value="<%=weight %>" /></td>
    <td width="26%" align="right"><input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>"></td>
  </tr>
</table>
</form>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","原纸规格")%>'},
                       {name: '<%=demo.getLang("erp","LOT No.")%>'},
                       {name: '<%=demo.getLang("erp","Invoice No.")%>'},
                       {name: '<%=demo.getLang("erp","宽度(mm)")%>'},
                       {name: '<%=demo.getLang("erp","长度(m)")%>'},
                       {name: '<%=demo.getLang("erp","重量(kgs)")%>'},
                       {name: '<%=demo.getLang("erp","库位")%>'},
                       {name: '<%=demo.getLang("erp","出库")%>'}
]
nseer_grid.column_width=[150,120,120,110,110,110,110,100];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%
if(request.getParameter("txtSearch")!=null){
//String length = rs1.getString("product_base_length");
//length = length.substring(0,length.length()-3);
%>

['<%=rs1.getString("product_spec")%>',
'<%=rs1.getString("product_info.product_lot_no")%>',
'<%=rs1.getString("product_base_invoice_no")%>',

'<%=rs1.getString("product_base_width")%>',
'<%=rs1.getString("product_base_length")%>',
'<%=rs1.getString("product_base_weight")%>',
'<%=rs1.getString("product_info.product_stock")%>',
	'<div style="text-decoration : underline;color:#3366FF;CURSOR: hand;" onclick=addGoodsItem("<%=exchange.unHtmls(rs1.getString("product_spec"))%>","<%=exchange.unHtmls(rs1.getString("product_info.product_lot_no"))%>","<%=rs1.getString("product_base_invoice_no")%>","<%=rs1.getString("product_base_width")%>","<%=rs1.getString("product_base_length")%>","<%=rs1.getString("product_base_weight")%>","<%=rs1.getString("product_info.product_stock")%>","<%=rs1.getString("product_info.id")%>")><%=demo.getLang("erp","出库")%></div>'
],<%}%>
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
<%--
<%@include file="../../include/search_bottom.jsp"%>
--%>
<%if(request.getParameter("txtSearch")!=null){%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%}else{ %>
<page:updowntag num="0" file="<%=fileName%>"/>
<% }%>
<%stock_db.close();stock_b.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>