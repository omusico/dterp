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
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/manufacture/manufacture_manufacture.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
try{
String tablename="manufacture_manufacture";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and excel_tag='2' and manufacture_tag='1'";
String queue="order by register_time desc";
String validationXml="../../xml/manufacture/manufacture_manufacture.xml";
String nickName="生产派工单";
String fileName="queryCost_list.jsp";
String rowSummary=demo.getLang("erp","当前已完成的生产派工单总数：");
int k=1;
%>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs1 = manufacture_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","打印")+"\" onClick=\"javascript:winopen('queryCost_list_print.jsp')\">";
%>
<%@include file="../../include/search_top.jsp"%>
<%
double demand_module_cost_price_sum=0.0d;
double demand_labour_cost_price_sum=0.0d;
double real_module_cost_price_sum=0.0d;
double real_labour_cost_price_sum=0.0d;
while(rs1.next()){
	demand_module_cost_price_sum=rs1.getDouble("module_cost_price_sum");
	demand_labour_cost_price_sum=rs1.getDouble("labour_cost_price_sum");
	real_module_cost_price_sum=rs1.getDouble("real_module_cost_price_sum");
	real_labour_cost_price_sum=rs1.getDouble("real_labour_cost_price_sum");
}
double demand_cost_price_sum=demand_labour_cost_price_sum+demand_module_cost_price_sum;
double real_cost_price_sum=real_labour_cost_price_sum+real_module_cost_price_sum;
rs1 = manufacture_db.executeQuery(sql_search) ;
%>
<!-- <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="2"><%=demo.getLang("erp","设计总成本：")%><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(demand_cost_price_sum)%><%=demo.getLang("erp","元（物料：")%><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(demand_module_cost_price_sum)%><%=demo.getLang("erp","元 工时")%>:<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(demand_labour_cost_price_sum)%><%=demo.getLang("erp","元）。")%></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","实际总成本：")%><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(real_cost_price_sum)%><%=demo.getLang("erp","元（物料：")%><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(real_module_cost_price_sum)%><%=demo.getLang("erp","元 工时:")%><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(real_labour_cost_price_sum)%><%=demo.getLang("erp","元）。")%></td>
 </tr>
</table> -->
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
					   {name: '<%=demo.getLang("erp","派工单编号")%>'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","数量")%>'},
                       {name: '<%=demo.getLang("erp","合格品数量")%>'},
                       {name: '<%=demo.getLang("erp","实际总成本（元）")%>'},
                       {name: '<%=demo.getLang("erp","派工单状态")%>'},
                       {name: '<%=demo.getLang("erp","生产状态")%>'}
]
nseer_grid.column_width=[180,180,180,70,70,160,70,70];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%	
String manufacture_procedure_tag="";
String manufacture_tag="";
String color="#FF9A31";
if(rs1.getString("manufacture_procedure_tag").equals("0")){
manufacture_tag="等待";
}else if(rs1.getString("manufacture_procedure_tag").equals("1")&&rs1.getString("manufacture_tag").equals("0")){
manufacture_tag="执行";
color="mediumseagreen";
}else if(rs1.getString("manufacture_tag").equals("1")){
manufacture_tag="完成";
color="3333FF";
}
if(rs1.getString("manufacture_procedure_tag").equals("0")){
manufacture_procedure_tag="等待";
}else if(rs1.getString("manufacture_procedure_tag").equals("1")){
manufacture_procedure_tag="执行";
}else if(rs1.getString("manufacture_procedure_tag").equals("2")){
manufacture_procedure_tag="完成";
}
String tested_amount="生产中";
if(rs1.getDouble("tested_amount")!=0){
	tested_amount=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs1.getDouble("tested_amount"))+"";
}
%>
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("queryCost.jsp?manufacture_ID=<%=rs1.getString("manufacture_ID")%>")><span style="color:<%=color%>"><%=rs1.getString("manufacture_ID")%></span></div>','<span style="color:<%=color%>"><%=rs1.getString("product_ID")%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs1.getString("product_name"))%></span>','<span style="color:<%=color%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs1.getDouble("amount"))%></span>','<span style="color:<%=color%>"><%=tested_amount%></span>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("real_labour_cost_price_sum")+rs1.getDouble("real_module_cost_price_sum"))%>','<span style="color:<%=color%>"><%=manufacture_tag%></span>','<span style="color:<%=color%>"><%=manufacture_procedure_tag%></span>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
manufacture_db.close();	
}catch(Exception e){e.printStackTrace();}	
%>
<%@include file="../../include/head_msg.jsp"%>