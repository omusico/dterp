<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db purchase_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/purchase/purchase_purchase.xml"/>
<% 
try{
	String tablename="purchase_purchase";
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table> 
<script src="../../javascript/table/movetable.js"></script>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/purchase/purchase/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<%
String condition="";
String register_ID=(String)session.getAttribute("human_IDD");
String realname=(String)session.getAttribute("realeditorc");
String condition0="excel_tag='2' and gar_tag='0'";
String queue="order by register_time desc";
String validationXml="../../xml/purchase/purchase_purchase.xml";
String nickName="采购计划";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的采购执行单总数");
int k=1;
String apply_ID="";
String condition1="(check_tag='1' or check_tag='9') and excel_tag='2' and gar_tag='0'";
String condition2="check_tag='2' and excel_tag='2' and purchase_tag='2' and gar_tag='0'";
String condition3="check_tag='2' and excel_tag='2' and purchase_tag='1' and gar_tag='0'";
%>
<%@include file="../../include/search_a.jsp"%>
<%
condition=condition1;
%>
<%@include file="../../include/search_bn.jsp"%>
<%
int intRowCount1 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition=condition2;
%>
<%@include file="../../include/search_bn.jsp"%>
<%
int intRowCount2 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition=condition3;
%>
<%@include file="../../include/search_bn.jsp"%>
<%
int intRowCount3 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition=condition0;
%>
<%@include file="../../include/search_b.jsp"%>
<%
ResultSet rs1 = purchase_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","强制完成")+"\" onclick=\"showCompulsion(document.getElementById('rows_num').value,'"+tablename+"');\">"+DgButton.getGar(tablename,request);
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
					   {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","执行单编号")%>'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","执行单状态")%>'},
	                   {name: '<%=demo.getLang("erp","审核状态")%>'},
	                   {name: '<%=demo.getLang("erp","入库状态")%>'},
	                   {name: '<%=demo.getLang("erp","发票状态")%>'},
	                   {name: '<%=demo.getLang("erp","质检状态")%>'}
]
nseer_grid.column_width=[40,180,180,100,70,70,70,70,70];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>">
<%	
String check_tag="";
String stock_gather_tag="";
String gather_tag="";
String invoice_tag="";
String purchase_tag=demo.getLang("erp","等待");
String color="#FF9A31";
if(rs1.getString("check_tag").equals("1")){
check_tag=demo.getLang("erp","等待");
}else if(rs1.getString("check_tag").equals("2")){
check_tag=demo.getLang("erp","通过");
}else if(rs1.getString("check_tag").equals("9")){
check_tag=demo.getLang("erp","未通过");
}
if(rs1.getString("stock_gather_tag").equals("1")){
stock_gather_tag=demo.getLang("erp","等待");
}else if(rs1.getString("stock_gather_tag").equals("2")){
stock_gather_tag=demo.getLang("erp","执行");
}else if(rs1.getString("stock_gather_tag").equals("3")){
stock_gather_tag=demo.getLang("erp","完成");
}
if(rs1.getString("gather_tag").equals("1")){
gather_tag=demo.getLang("erp","等待");
}else if(rs1.getString("gather_tag").equals("2")){
gather_tag=demo.getLang("erp","执行");
}else if(rs1.getString("gather_tag").equals("3")){
gather_tag=demo.getLang("erp","完成");
}
if(rs1.getString("invoice_tag").equals("1")){
invoice_tag=demo.getLang("erp","等待");
}else if(rs1.getString("invoice_tag").equals("2")){
invoice_tag=demo.getLang("erp","执行");
}else if(rs1.getString("invoice_tag").equals("3")){
invoice_tag=demo.getLang("erp","完成");
}
if(rs1.getString("purchase_tag").equals("1")){
purchase_tag=demo.getLang("erp","执行");
color="mediumseagreen";
}else if(rs1.getString("purchase_tag").equals("2")){
purchase_tag=demo.getLang("erp","完成");
color="3333FF";
}
%>
['<input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs1.getString("id")%>⊙<%=rs1.getString("purchase_tag")%>" style="height:10">','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?purchase_ID=<%=rs1.getString("purchase_ID")%>")><%=rs1.getString("purchase_ID")%></div>','<span style="color:<%=color%>"><%=rs1.getString("product_ID")%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs1.getString("product_name"))%></span>','<span style="color:<%=color%>"><%=purchase_tag%></span>','<%=check_tag%>','<%=stock_gather_tag%>','<%=invoice_tag%>','<%=gather_tag%>'],
<% k++;%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<%
purchase_db.close();	
}catch(Exception e){e.printStackTrace();}	
%>
<%@include file="../../include/head_msg.jsp"%>