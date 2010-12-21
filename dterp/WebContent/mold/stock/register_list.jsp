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
<%nseer_db mold_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db mold_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/purchase/purchase_apply.xml"/>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script language="javascript" src="../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
	 <%
	 String mold_spec="";
	 String purchase_code="";
	 String mold_code="";
	 %>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>

<%


int i=0;
String first_state="0";//0——第一次加载，1——再次加载

if(request.getParameter("mold_spec")!=null||request.getParameter("mold_code")!= null||request.getParameter("purchase_code")!= null){
	first_state="1";
}
String my_sql_search ="SELECT * FROM mold_purchase_order where purchase_check_type=1";
if(request.getParameter("mold_spec") != null&&request.getParameter("mold_spec").length() > 0||request.getParameter("mold_code") != null&&request.getParameter("mold_code").length() > 0||request.getParameter("purchase_code") != null&&request.getParameter("purchase_code").length() > 0)
{
	my_sql_search +=" having";
}
if(request.getParameter("mold_spec") != null&&request.getParameter("mold_spec").length() > 0)
{
	mold_spec=request.getParameter("mold_spec");
	my_sql_search += " purchase_code like'%"+ request.getParameter("mold_spec") + "%' ";//purchase_code
	i =1;
}
if(request.getParameter("purchase_code") != null&&request.getParameter("purchase_code").length() > 0)
{
	if(i == 1)
	{
		purchase_code=request.getParameter("purchase_code");
		my_sql_search += " and purchase_register_time like'%"+ request.getParameter("purchase_code") + "%' ";
	}
	else
	{
		purchase_code=request.getParameter("purchase_code");
		my_sql_search += " purchase_register_time like'%"+ request.getParameter("purchase_code") + "%' ";
		i=1;
	}
}
if(request.getParameter("mold_code") != null&&request.getParameter("mold_code").length() > 0)
{
	if(i == 1)
	{
		mold_code=request.getParameter("mold_code");
		my_sql_search += " and purchase_operater like'%"+ request.getParameter("mold_code") + "%' ";		
	}	
	else
	{
		mold_code=request.getParameter("mold_code");
		my_sql_search += " purchase_operater like'%"+ request.getParameter("mold_code") + "%' ";
		i=1;
	}
}
my_sql_search+=" order by  purchase_register_time desc ";


//String my_sql_search = "SELECT * FROM mold_purchase_order WHERE EXISTS (SELECT * FROM mold_info WHERE mold_info.mold_purchase_id = mold_purchase_order.id AND mold_info.mold_life_status IS NULL and mold_purchase_order.purchase_check_type=1)";
//if(request.getParameter("keyword") != null&&request.getParameter("keyword").length() > 0)
//{
//	my_sql_search +=" having purchase_code like'%"+request.getParameter("keyword")+"%' or purchase_register_time like'%"+request.getParameter("keyword")+"%' or purchase_operater like'%"+request.getParameter("keyword")+"%' or purchase_count like'%"+request.getParameter("keyword")+"%' or purchase_register like'%"+request.getParameter("keyword")+"%'";
//}
String register_ID=(String)session.getAttribute("human_IDD");
String tablename="purchase_apply";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='0'";
String queue="order by register_time";
String validationXml="../../xml/purchase/purchase_apply.xml";
String nickName="采购计划";
String fileName="register_list.jsp";
String rowSummary=demo.getLang("erp","当前等待审核的采购计划总数");

int k=0;
%>
 <form action="register_list.jsp" method="post" name="search_form" id="search_form">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE6%> class="TD_STYLE6">
		  采购订单号：<input type="text" name="mold_spec" onfocus="" id="" value="<%=mold_spec %>" style="width: 150">
		  登记时间：<input type="text" name="purchase_code"  value="<%=purchase_code %>" style="width: 150" id="date_start" onkeypress="event.returnValue=false;">
		  经办人：<input type="text" name="mold_code" onfocus="" id="" value="<%=mold_code %>" style="width: 150"> 
		  <input type="submit" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>">
		</td>
	</tr>
</table>
</form>
<%@include file="../../include/search_my.jsp"%>
<%
try{
ResultSet rs1 = mold_db.executeQuery(my_sql_search); 	
int workflow_amount=0;
%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","采购订单号")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'},
                       {name: '<%=demo.getLang("erp","经办人")%>'},
                       {name: '<%=demo.getLang("erp","总件数")%>'},
                       {name: '<%=demo.getLang("erp","登记人")%>'},
                       {name: '<%=demo.getLang("erp","入库管理")%>'}
]
nseer_grid.column_width=[200,150,100,50,100,165];
nseer_grid.auto='<%=demo.getLang("erp","入库管理")%>';
nseer_grid.data = [
<%if(first_state=="0"){rs1=null;}%>
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>">
<%--
//String sql="SELECT * FROM mold_info left join mold_purchase_order on mold_info.mold_purchase_id=mold_purchase_order.id where mold_info.mold_purchase_id='"+rs1.getInt("id")+"'";
//ResultSet rs2 = mold_db1.executeQuery(sql);
//while(rs2.next())
//{
	
--%>

['<%=rs1.getString("purchase_code")%>','<%=rs1.getString("purchase_register_time")%>','<%=rs1.getString("purchase_operater")%>','<%=rs1.getString("purchase_count")%>','<%=rs1.getString("purchase_register")%>','<a href="#" style="text-decoration:none;"><div style="text-decoration : underline;color:#3366FF" onclick=id_link("register.jsp?id=<%=exchange.unHtmls(Integer.toString(rs1.getInt("id")))%>")><%=demo.getLang("erp","入库")%></div></a>'],

<%

%>
<%k++;%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%	
}catch(Exception ex)
{
	mold_db.close();
	mold_db1.close();
	ex.printStackTrace();
}finally
{
	mold_db.close();
	mold_db1.close();
}
%>
<%@include file="../../include/head_msg.jsp"%>
 <script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>