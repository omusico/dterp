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
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%="您正在做的业务是：库存管理--入库申请管理--入库申请变更"%></div></td>
 </tr>
 </table>

<script src="../../javascript/table/movetable.js">
</script>
<script language="javascript" src="../../javascript/edit/editTable.js">
</script>
<script language="javascript">
//var tableEdit=winopener.document.getElementsByTagName("form")[0];
//var edit=tableEdit.getElementsByTagName("TABLE")[0];
var edit=window.opener.tableOnlineEdit;
var names=['product_nameN','product_IDN','b_prodcu_name','product_count','amount_unitN','cost_cost','proId','cost_priceN'];
function addGoodsItem(product_namea, product_IDa, product_describea, amounta, amount_unita, cost_pricea,proId,cost_priceN) {

var  product_name=product_namea.replace(/★/g,"<br>").replace(/☆/g," ");
var  describe=product_describea.replace(/★/g,"<br>").replace(/☆/g," ");
var  amount_unit=amount_unita.replace(/★/g,"<br>").replace(/☆/g," ");

var values=[product_describea, product_IDa, product_name, amounta, amount_unita, cost_pricea,proId,cost_priceN];
if(checkRow1(edit,values[0])) {
 addInstanceRow(edit,names,values);
 }
}
function checkRow1(objTable,unique) {
 var tbodyOnlineEdit=objTable.getElementsByTagName("TBODY")[0];
 for (var i=tbodyOnlineEdit.children.length-1; i>=0 ; i-- ){
   var temp=tbodyOnlineEdit.children[i].childNodes[3].childNodes[0].value;
   //alert(unique+":"+temp);
   if(unique==temp) return false;
 }
 return true;
}
</script>
<%
String tablename="design_file";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and type !='1'";
String queue="order by register_time";
String validationXml="../../xml/design/design_file.xml";
String nickName="产品档案";
String fileName="register_product_list_show2.jsp";
String rowSummary=demo.getLang("erp","符合条件的产品档案总数");
%>

<%try{
	String y_paper = "";
	String paper = "";
	String hL = "";
	
String my_sql_search = "select b.*,CUSTOMER_NAME from package_info as b inner join crm_file on crm_file.id = b.package_custom_id where is_dissolve=0 and is_out_stock=0 and package_in_apply_status=0 and stock_id =110";

if(request.getParameter("yuanpaper")!=null&&request.getParameter("yuanpaper").length()!=0){
	my_sql_search+=" and b.product_spec like '%"+request.getParameter("yuanpaper")+"%'";
	y_paper=request.getParameter("yuanpaper");
}
if(request.getParameter("paper")!=null&&request.getParameter("paper").length()!=0){
	my_sql_search+=" and b.mold_spec like '%"+request.getParameter("paper")+"%'";
	paper = request.getParameter("paper");
}
if(request.getParameter("invoice")!=null&&request.getParameter("invoice").length()!=0){
	my_sql_search+=" and b.package_pallet like '%"+request.getParameter("invoice")+"%'";
	hL=request.getParameter("invoice");
}
%>
<%@include file="../../include/search_my.jsp"%>
<%
ResultSet rs1=stock_db.executeQuery(sql_search);
%>
<%-- 
<%@include file="../../include/search_top.jsp" %>
--%>
<form  name="search_form" id="search_form" action="register_product_list_show2.jsp" method="post">
<table width="98%" style="text-align:right;" align="center">
  <tr>
    <td><input type="hidden" name="search" value="45" />
    原纸规格：<input name="yuanpaper" type="text" value="<%=y_paper %>" />
   
	模具规格：<input name="paper" type="text" value="<%=paper %>" />
	
	栈板号：<input name="invoice" type="text" value="<%=hL %>" />

	<input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="delSelect()" value="<%=demo.getLang("erp","查询")%>">
    </td>
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
                       {name: '<%=demo.getLang("erp","模具规格")%>'},
                       {name: '<%=demo.getLang("erp","栈板号")%>'},
                       {name: '<%=demo.getLang("erp","入库")%>'}
]
nseer_grid.column_width=[300,220,250,210];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%if(request.getParameter("search")!=null){
%>

['<%=rs1.getString("b.product_spec")%>',
'<%=rs1.getString("b.mold_spec")%>',
'<%=rs1.getString("b.package_pallet")%>',
'<div style="text-decoration : underline;color:#3366FF;CURSOR: hand;" onclick=addGoodsItem("<%=exchange.unHtmls(exchange.toHtml(rs1.getString("b.product_spec")))%>","<%=rs1.getString("b.mold_spec")%>","<%=rs1.getString("b.package_pallet")%>","1","<%=rs1.getString("b.package_count")%>","","<%=rs1.getString("b.id")%>","<%=rs1.getString("CUSTOMER_NAME")%>")><%=demo.getLang("erp","入库")%></div>'
],<%}%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%if(request.getParameter("searchId")!=null){%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%}else{ %>
<page:updowntag num="0" file="<%=fileName%>"/>
<% }%>
<%stock_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>