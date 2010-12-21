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
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db crm_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/crm/crm_order.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String register_ID=(String)session.getAttribute("human_IDD");
String tablename="crm_order";
String realname=(String)session.getAttribute("realeditorc");
String condition="invoice_tag='2' and invoice_check_tag='1'";
String queue="order by check_time";
String validationXml="../../xml/crm/crm_order.xml";
String nickName="销售订单";
String fileName="check_list.jsp";
String rowSummary=demo.getLang("erp","当前等待发票信息登记审核的订单总数");
%>
<%@include file="../../include/search.jsp"%>
<%
try{
int workflow_amount=0;
String sql="select count(id) from crm_config_workflow where type_id='06'";
ResultSet rs=crm_db.executeQuery(sql);
if(rs.next()){
	workflow_amount=rs.getInt("count(id)");
}
rs = crm_db.executeQuery(sql_search) ;
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
                       {name: '<%=demo.getLang("erp","订单编号")%>'},
                       {name: '<%=demo.getLang("erp","客户名称")%>'},
                       {name: '<%=demo.getLang("erp","电话")%>'},
                       {name: '<%=demo.getLang("erp","预提货时间")%>'},
					   {name: '<%=demo.getLang("erp","销售人")%>'},
                       {name: '<%=demo.getLang("erp","销售总额")%>'},
	<%
for(int i=1;i<workflow_amount;i++){
		String title="流程"+i;
%>
					   {name: '<%=demo.getLang("erp",title)%>'},
<%
}
	String title="流程"+workflow_amount;
%> 
                           {name: '<%=demo.getLang("erp",title)%>'}
]
nseer_grid.column_width=[180,200,100,100,70,100,
<%
for(int i=1;i<workflow_amount;i++){
%>					   70,
<%
}
%> 
                           70
	];
nseer_grid.auto='<%=demo.getLang("erp","客户名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
String demand_pay_time="";
demand_pay_time=rs.getString("demand_pay_time");
String sql1="select id from crm_workflow where object_ID='"+rs.getString("order_ID")+"' and check_tag='0' and which_time='"+rs.getString("which_time")+"'";
ResultSet rs2=crm_db1.executeQuery(sql1);
if(rs2.next()){
	sql1="select check_tag,describe1,config_id,which_time from crm_workflow where object_ID='"+rs.getString("order_ID")+"' and which_time='"+rs.getString("which_time")+"' order by id";
	rs2=crm_db1.executeQuery(sql1);
%>
	
['<%=rs.getString("order_ID")%>','<%=exchange.toHtml(rs.getString("customer_name"))%>','<%=exchange.toHtml(rs.getString("demand_contact_person_tel"))%>','<%=exchange.toHtml(demand_pay_time)%>','<%=exchange.toHtml(rs.getString("sales_name"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("sale_price_sum"))%>'
<%
for(int i=1;i<=workflow_amount;i++){
	String status="";
	if(rs2.next()){
			if(rs2.getString("check_tag").equals("0")){
			status="无权限";
			}else if(rs2.getString("check_tag").equals("1")){
			status="通过";
			}else if(rs2.getString("check_tag").equals("9")){
			status="未通过";
			}
			if(rs2.getString("check_tag").equals("0")&&rs2.getString("describe1").indexOf(register_ID)!=-1){
%>
,'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("check.jsp?order_ID=<%=rs.getString("order_ID")%>&config_id=<%=rs2.getString("config_id")%>&which_time=<%=rs.getString("which_time")%>")><%=demo.getLang("erp","审核")%></div>'<%}else{%>,'<%=demo.getLang("erp",status)%>'<%}}else{%>,''<%}}%>],
<%
}
%>
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
crm_db.close();
crm_db1.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>