<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="query" scope="page" class="include.query.query_three"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%nseer_db intrmanufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/intrmanufacture/intrmanufacture_intrmanufacture.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<style media=print> 
.Noprint{display:none;} 
.PageNext{page-break-after: always;} 
</style> 
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String tablename="intrmanufacture_intrmanufacture";
String realname=(String)session.getAttribute("realeditorc");
String queue="order by register_time desc";
String condition="check_tag='2' and excel_tag='2' and intrmanufacture_tag='2'";
String validationXml="../../xml/intrmanufacture/intrmanufacture_intrmanufacture.xml";
String nickName="委外执行单";
String fileName="queryCost_list_print.jsp";
String rowSummary=demo.getLang("erp","符合条件的委外执行单总数：");
%>
<%@include file="../../include/search.jsp"%>
<%
try{
ResultSet rs1 = intrmanufacture_db.executeQuery(sql_search) ;

otherButtons="&nbsp;<OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT><input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","打印")+"\" onclick=\"javascript:window.print()\">&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","页面设置")+"\" onclick=document.all.WebBrowser.ExecWB(8,1)>&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","打印预览")+"\" onclick=document.all.WebBrowser.ExecWB(7,1)>";
%>
<%@include file="../../include/search_top.jsp"%>
<%
String dbase=(String)session.getAttribute("unit_db_name");
double list_price_sum=query.sumTotal(dbase,sql_search,"list_price_sum");
double real_cost_price_sum=query.sumTotal(dbase,sql_search,"demand_cost_price_sum");
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3"> 
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","委外总加工费用：")%><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(real_cost_price_sum)%><%=demo.getLang("erp","元")%></td>
</tr>
</table>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","执行单编号")%>'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
					   {name: '<%=demo.getLang("erp","执行单状态")%>'},
	                   {name: '<%=demo.getLang("erp","数量")%>'},
	     			   {name: '<%=demo.getLang("erp","委外加工费用（元）")%>'}
]
nseer_grid.column_width=[200,200,200,100,70,70];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>">
<%	
String check_tag="";
String stock_gather_tag="";
String pay_tag="";
String gather_tag="";
String invoice_tag="";
String intrmanufacture_tag="等待";
String color="#FF9A31";
if(rs1.getString("check_tag").equals("1")){
check_tag="等待";
}else if(rs1.getString("check_tag").equals("2")){
check_tag="通过";
}else if(rs1.getString("check_tag").equals("9")){
check_tag="未通过";
}
if(rs1.getString("stock_gather_tag").equals("1")){
stock_gather_tag="等待";
}else if(rs1.getString("stock_gather_tag").equals("2")){
stock_gather_tag="执行";
}else if(rs1.getString("stock_gather_tag").equals("3")){
stock_gather_tag="完成";
}
if(rs1.getString("pay_tag").equals("1")){
pay_tag="等待";
}else if(rs1.getString("pay_tag").equals("2")){
pay_tag="执行";
}else if(rs1.getString("pay_tag").equals("3")){
pay_tag="完成";
}
if(rs1.getString("gather_tag").equals("1")){
gather_tag="等待";
}else if(rs1.getString("gather_tag").equals("2")){
gather_tag="执行";
}else if(rs1.getString("gather_tag").equals("3")){
gather_tag="完成";
}
if(rs1.getString("invoice_tag").equals("1")){
invoice_tag="等待";
}else if(rs1.getString("invoice_tag").equals("2")){
invoice_tag="执行";
}else if(rs1.getString("invoice_tag").equals("3")){
invoice_tag="完成";
}
if(rs1.getString("intrmanufacture_tag").equals("1")){
intrmanufacture_tag="执行";
color="mediumseagreen";
}else if(rs1.getString("intrmanufacture_tag").equals("2")){
intrmanufacture_tag="完成";
color="3333FF";
}
%>
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("queryCost.jsp?intrmanufacture_ID=<%=rs1.getString("intrmanufacture_ID")%>")><%=rs1.getString("intrmanufacture_ID")%></div>','<span style="color:<%=color%>"><%=rs1.getString("product_ID")%>','<span style="color:<%=color%>"><%=exchange.toHtml(rs1.getString("product_name"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(intrmanufacture_tag)%></span>','<%=rs1.getDouble("demand_amount")%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("demand_cost_price_sum"))%>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
intrmanufacture_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>