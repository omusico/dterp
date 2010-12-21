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
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db stock_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
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
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%="您正在做的业务是：库存管理--出库申请管理--出库申请变更"%></div></td>
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
var names=['product_name1','product_ID1','product_describe_ok1','amount1','amount_unit1','cost_price1','cost_person','cost_dopet','cost_personId','proId'];
function addGoodsItem(product_namea, product_IDa, product_describea, amounta, amount_unita, cost_pricea,cost_person,cost_dopet,cost_personId,proId) {

var  product_name=product_namea.replace(/★/g,"<br>").replace(/☆/g," ");
var  describe=product_describea.replace(/★/g,"<br>").replace(/☆/g," ");
var  amount_unit=amount_unita.replace(/★/g,"<br>").replace(/☆/g," ");

var values=[product_name, product_IDa, product_describea,amounta, amount_unita, cost_pricea, cost_person,cost_dopet,cost_personId,proId];

if(checkRow(edit,values[0])) {
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
String fileName="register_product_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的产品档案总数");
%>
<%-- 
<%@include file="../../include/search.jsp"%>
--%>
<%try{
	String y_paper = "";
	String hL = "";
	String paper = "";
	String count = "";
	String weight = "";
	String person = "";
	String my_sql_search = "select * from package_info inner join stock_in_detail on stock_in_detail.In_Detail_product_id=package_info.id inner join stock_in on stock_in.id = stock_in_detail.stock_in_id left join crm_file on stock_in_detail.In_Detail_custom_id=crm_file.id where package_stock!='' and is_dissolve=0 and is_out_stock=0 and stock_in_check_status=1 and package_info.package_out_apply_status=0";
	if(request.getParameter("yuanPaper")!=null&&request.getParameter("trans").length()!=0){
		y_paper=request.getParameter("yuanPaper");
		my_sql_search+=" and  product_spec like '%"+request.getParameter("yuanPaper")+"%'";
	}
	if(request.getParameter("trans")!=null&&request.getParameter("trans").length()!=0){
		hL=request.getParameter("trans");
		my_sql_search+=" and  package_pallet like '%"+request.getParameter("trans")+"%'";	
	}
	if(request.getParameter("spec")!=null&&request.getParameter("spec").length()!=0){
		paper=request.getParameter("spec");
		my_sql_search+=" and mold_spec  like '%"+request.getParameter("spec")+"%'";
	}
	if(request.getParameter("count")!=null&&request.getParameter("count").length()!=0){
		count=request.getParameter("count");
		my_sql_search+=" and  package_count like '%"+request.getParameter("count")+"%'";
	}
	if(request.getParameter("weight")!=null&&request.getParameter("weight").length()!=0){
		weight=request.getParameter("weight");
		my_sql_search+=" and In_Detail_weight  like '%"+request.getParameter("weight")+"%'";
	}
	if(request.getParameter("person")!=null&&request.getParameter("person").length()!=0){
		person=request.getParameter("person");
		my_sql_search+=" and crm_file.CUSTOMER_NAME  like '%"+request.getParameter("person")+"%'";
	}
	%>
	<%@include file="../../include/search_my.jsp"%>
	<%
ResultSet rs1=stock_db.executeQuery(sql_search);
%>
<form  name="search_form" id="search_form" action="register_product_list.jsp" method="post">
<table width="98%" align="center">
  <tr>
    <td width="24%">原纸规格：<input type="text" name="yuanPaper" value="<%=y_paper %>" /></td>
    <td width="26%">栈板号&nbsp;&nbsp;：<input type="text" name="trans" value="<%=hL %>" /></td>
    <td width="24%">模具规格：<input type="text" name="spec" value="<%=paper %>" /></td>
    <td width="26%"><input type="hidden" name="search" value="45" /></td>
  </tr>
  <tr>
    <td>数量(卷)：<input type="text" name="count" value="<%=count %>" /></td>
    <td>净重(kg)：<input type="text" name="weight" value="<%=weight %>" /></td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;客户：<input type="text" name="person" value="<%=person %>" /></td>
   <td align="right">
    <input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>">
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
                       {name: '<%=demo.getLang("erp","数量(卷)")%>'},
                       {name: '<%=demo.getLang("erp","净重(kg)")%>'},
                       {name: '<%=demo.getLang("erp","客户")%>'},
                       {name: '<%=demo.getLang("erp","库位")%>'},
                       {name: '<%=demo.getLang("erp","出库")%>'}
]
nseer_grid.column_width=[150,120,120,110,110,110,110,100];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%
if(request.getParameter("search")!=null){
%>
['<%=rs1.getString("product_spec")%>',
'<%=exchange.toHtml(rs1.getString("mold_spec"))%>',
'<%=exchange.toHtml(rs1.getString("package_pallet"))%>',
'<%=exchange.toHtml(rs1.getString("package_count"))%>',
'<%=exchange.toHtml(rs1.getString("In_Detail_weight"))%>',
'<%=exchange.toHtml(rs1.getString("crm_file.CUSTOMER_NAME"))%>', 
'<%=rs1.getString("package_info.package_stock")%>',
'<div style="text-decoration : underline;color:#3366FF;CURSOR: hand;" onclick=addGoodsItem("<%=exchange.unHtmls(rs1.getString("product_spec"))%>","<%=exchange.unHtmls(rs1.getString("mold_spec"))%>","<%=rs1.getString("package_pallet")%>","1","<%=rs1.getString("package_count")%>","<%=rs1.getString("In_Detail_weight")%>","<%=rs1.getString("crm_file.CUSTOMER_NAME")%>","<%=rs1.getString("package_info.package_stock")%>","<%=rs1.getString("package_custom_id")%>","<%=rs1.getString("package_info.id")%>")><%=demo.getLang("erp","出库")%></div>'
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
<%if(request.getParameter("search")!=null){%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%}else{ %>
<page:updowntag num="0" file="<%=fileName%>"/>
<% }%>
<%stock_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>