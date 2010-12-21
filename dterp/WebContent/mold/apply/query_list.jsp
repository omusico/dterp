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
<%nseer_db purchase_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db purchase_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/purchase/purchase_apply.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%

String first_state="0";//0——第一次加载，1——再次加载

if(request.getParameter("mold_Id")!=null||request.getParameter("mold_time")!= null||request.getParameter("mold_author")!= null){
	first_state="1";
}

//声明 查询条件
String orderId=request.getParameter("mold_Id");
String dateTime=request.getParameter("mold_time");
String author=request.getParameter("mold_author");

//采购订单号
if(orderId== null||orderId.length() <=0)
{
	orderId="";
}
//时间
if(dateTime== null||dateTime.length() <= 0)
{
	dateTime="";
}
//经办人
if(author== null||author.length() <= 0)
{
	author="";
}

String orderIdSql=" and purchase_code like'%"+orderId+"%'";
String dateTimeSql=" and purchase_register_time like'%"+dateTime+"%'";
String authorSql=" and purchase_operater like'%"+author+"%'";

%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<form action="query_list.jsp" method="post" name="search_form" id="search_form">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE6%> class="TD_STYLE6">
		  采购订单号：<input type="text" name="mold_Id" onfocus="" id="" style="width: 150" value="<%=orderId %>">
		  登记时间：<input type="text" name="mold_time" onfocus="" id="date_start" value="<%=dateTime %>" style="width: 150">
		 经办人：<input type="text" name="mold_author" onfocus="" id=""  style="width: 150" value="<%=author %>">
		   审核状态：
		  <select name="plan_typeS" style="width: 12%">
		  <%
		  if (request.getParameter("plan_typeS") != null&&request.getParameter("plan_typeS").length() > 0) {
				if(request.getParameter("plan_typeS").equals("1")){
		  %>
		  <option value="all">--------全部--------</option>
		  <option value="0">未审核</option>
		  <option value="1" selected="selected">审核通过</option>
		  <option value="2">审核未通过</option>

		  <%
				}else if(request.getParameter("plan_typeS").equals("2")){
		  %>
		  <option value="all">--------全部--------</option>
		  <option value="0">未审核</option>
		  <option value="1">审核通过</option>
		  <option value="2" selected="selected">审核未通过</option>
	
		  <%		
				}else if(request.getParameter("plan_typeS").equals("0")){
		  %>
		  <option value="all">------全部------</option>
		  <option value="0"  selected="selected">未审核</option>
		  <option value="1">审核通过</option>
		  <option value="2">审核未通过</option>
		 
		  <%			
				}else if(request.getParameter("plan_typeS").equals("all")){
		  %>
		  <option value="all" selected="selected">------全部------</option>
		  <option value="0">未审核</option>
		  <option value="1">审核通过</option>
		  <option value="2">审核未通过</option>
		 
		  <%			
				}
		  }else{
		  %>
		  <option value="all" selected="selected">------全部------</option>
		  <option value="0">未审核</option>
		  <option value="1">审核通过</option>
		  <option value="2">审核未通过</option>
		 
		  <%	
		  }
		  %>
		  
		  </select>
		 <input type="submit" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>" >
		</td>
	</tr>
</table>
</form>
<%



String my_sql_search = "SELECT * FROM mold_purchase_order where 1=1 ";


//条件查询

//采购订单号
if(orderId!= null&&orderId.length() > 0)
{
	my_sql_search+=orderIdSql;
}
//时间
if(dateTime!= null&&dateTime.length() > 0)
{
	my_sql_search+=dateTimeSql;
}
//经办人
if(author!= null&&author.length() > 0)
{
	my_sql_search+=authorSql;
}
// 采购订单号 and 时间
if(orderId!= null&&orderId.length() > 0 && dateTime!= null&&dateTime.length() > 0)
{
	my_sql_search+=orderIdSql+dateTimeSql;
}
//采购订单号 and 经办人
if(orderId!= null&&orderId.length() > 0 && author!= null&&author.length() > 0)
{
	my_sql_search+=orderIdSql+authorSql;
}
//采购订单号 and 经办人 and 时间
if(orderId!= null&&orderId.length() > 0 && author!= null&&author.length() > 0 && dateTime!= null&&dateTime.length() > 0)
{
	my_sql_search+=orderIdSql+authorSql+dateTimeSql;
}

//查询状态
if (request.getParameter("plan_typeS") != null&&request.getParameter("plan_typeS").length() > 0) {
	if(!request.getParameter("plan_typeS").equals("all")){
		my_sql_search += " and purchase_check_type="+request.getParameter("plan_typeS");
	}
}
my_sql_search+=" order by purchase_register_time desc,purchase_code desc";


//
String register_ID=(String)session.getAttribute("human_IDD");
String tablename="purchase_apply";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='0' and excel_tag='2'";
String queue="order by register_time";
String validationXml="../../xml/purchase/purchase_apply.xml";
String nickName="采购计划";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","当前等待审核的采购计划总数");
int k = 0;
%>
<%@include file="../../include/search_my.jsp"%>
<%
try{
ResultSet rs1 = purchase_db.executeQuery(sql_search); 
int workflow_amount=0;
%>
<%if(first_state.equals("0")){rs1=null;} %>
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
	                   {name: '<%=demo.getLang("erp","审核状态")%>'},
                       {name: '<%=demo.getLang("erp","查询")%>'}
]
nseer_grid.column_width=[200,150,100,200,100,100,100];
nseer_grid.auto='<%=demo.getLang("erp","查询")%>';
nseer_grid.data = [

<page:pages rs="<%=rs1%>" strPage="<%=strPage%>">

<%--
if(apply_id_control.indexOf(rs.getString("apply_id"))==-1){
apply_id_control+=rs.getString("apply_id");
String register_time="";
if(rs.getString("register_time").equals("1800-01-01 00:00:00.0")){
register_time="";
}else{
register_time=rs.getString("register_time");
}
String sql1="select id from purchase_workflow where object_ID='"+rs.getString("apply_ID")+"' and check_tag='0'";
ResultSet rs2=purchase_db1.executeQuery(sql1);
if(rs2.next()){
	sql1="select check_tag,describe1,config_id from purchase_workflow where object_ID='"+rs.getString("apply_ID")+"' order by id";
	rs2=purchase_db1.executeQuery(sql1);
--%>
<%
String status="";
if(rs1.getString("purchase_check_type").equals("0")){
	status="未审核";
}else if(rs1.getString("purchase_check_type").equals("1")){
	status="审核通过";
}else if(rs1.getString("purchase_check_type").equals("2")){
	status="审核未通过";
}
%>

['<%=rs1.getString("purchase_code")%>','<%=rs1.getString("purchase_register_time")%>','<%=rs1.getString("purchase_operater")%>','<%=rs1.getString("purchase_count")%>','<%=rs1.getString("purchase_register")%>','<%=status%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?id=<%=exchange.unHtmls(Integer.toString(rs1.getInt("id")))%>")><%=demo.getLang("erp","查询")%></div>'],
<%--
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
--%>
<%--
,'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("check.jsp?apply_ID=<%=rs.getString("apply_ID")%>&config_ID=<%=rs2.getString("config_ID")%>")><%=demo.getLang("erp","审核")%></div>'<%}else{%>,'<%=demo.getLang("erp",status)%>'<%}}else{%>,''<%}}%>],
<%}}
</page:pages>
--%>
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
purchase_db.close();
purchase_db1.close();
}
catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>