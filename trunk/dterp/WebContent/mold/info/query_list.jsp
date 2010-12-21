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
	import="java.sql.*,include.nseer_cookie.*" import="java.util.*"
	import="java.io.*" import="include.nseer_cookie.exchange"
	import="include.nseer_db.*,java.text.*"%>
<%
			nseer_db mold_db = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<%
			nseer_db mold_db1 = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page" />
<jsp:useBean id="mask" class="include.operateXML.Reading" />
<jsp:setProperty name="mask" property="file"
	value="xml/manufacture/manufacture_apply.xml" />
<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：",
			"document_main", "reason", "value");
%>
<jsp:useBean id="validata" scope="page" class="validata.ValidataNumber" />
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page"
	class="include.query.getRecordCount" />
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<%
int i=0;
	String my_sql_search="select * from mold_info";
	if(request.getParameter("mold_spec") != null&&request.getParameter("mold_spec").length() > 0||request.getParameter("mold_code") != null&&request.getParameter("mold_code").length() > 0||request.getParameter("mold_location") != null&&request.getParameter("mold_location").length() > 0)
	{
		my_sql_search +=" having";
	}
	if(request.getParameter("mold_spec") != null&&request.getParameter("mold_spec").length() > 0)
	{
		my_sql_search += " mold_spec like'%"+ request.getParameter("mold_spec") + "%' ";
		i =1;
	}
	if(request.getParameter("mold_code") != null&&request.getParameter("mold_code").length() > 0)
	{
		if(i == 1)
			my_sql_search += " and mold_code like'%"+ request.getParameter("mold_code") + "%' ";
		else
		{
			my_sql_search += " mold_code like'%"+ request.getParameter("mold_code") + "%' ";
			i=1;
		}
	}
	if(request.getParameter("mold_location") != null&&request.getParameter("mold_location").length() > 0)
	{
		if(i == 1)
			my_sql_search += " and mold_location like'%"+ request.getParameter("mold_location") + "%' ";
		else
		{
			my_sql_search += " mold_location like'%"+ request.getParameter("mold_location") + "%' ";
			i=1;
		}
	}
	String tablename = "manufacture_apply";
	String realname = (String) session.getAttribute("realeditorc");
	String condition = "check_tag='0' and excel_tag='2'";
	String queue = "order by register_time";
	String validationXml = "../../xml/manufacture/manufacture_apply.xml";
	String nickName = "生产计划";
	String fileName = "check_list.jsp";
	String rowSummary = demo.getLang("erp", "当前等待审核的生产计划总数：");
int k=0;
%>
<%@include file="../../include/search_my.jsp"%>
<%
try{
ResultSet rs1 = mold_db.executeQuery(sql_search); 	
int workflow_amount=0;
%>
<form action="query_list.jsp" method="post" name="search_form" id="search_form">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE6%> class="TD_STYLE6">
		  模具规格：<input type="text" name="mold_spec" onfocus="" id="" value="" style="width: 150">
		  模具编号：<input type="text" name="mold_code" onfocus="" id="" value="" style="width: 150">
		  状态：<select style="width:100" name="mold_location">
  				<option value ="">全部</option>
  				<option value ="1">已发单</option>
  				<option value="2">入库</option>
  				<option value="3">生产中</option>
  				<option value="4">已拆卸</option>
  				<option value="5">报废</option>
				</select>

		  <input type="submit" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>" >
		</td>
	</tr>
</table>
</form>
<br />
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","模具规格")%>'},
                       {name: '<%=demo.getLang("erp","模具编号")%>'},
                       {name: '<%=demo.getLang("erp","状态")%>'}
]
nseer_grid.column_width=[300,350,520];
nseer_grid.auto='<%=demo.getLang("erp","备注")%>';
nseer_grid.data = [

<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%--
if(apply_id_control.indexOf(rs.getString("apply_id"))==-1){
apply_id_control+=rs.getString("apply_id");
String sql1="select id from manufacture_workflow where object_ID='"+rs.getString("apply_ID")+"' and check_tag='0'";
ResultSet rs2=manufacture_db1.executeQuery(sql1);
if(rs2.next()){
	sql1="select check_tag,describe1,config_id from manufacture_workflow where object_ID='"+rs.getString("apply_ID")+"' order by id";
	rs2=manufacture_db1.executeQuery(sql1);
	 <td <%=TD_STYLE2%> class="TD_STYLE2">1608R</td>
--%>
	['<%=rs1.getString("mold_spec")%>','<%=rs1.getString("mold_code")%>',
	<%if(rs1.getInt("mold_location")==1){
	if(rs1.getInt("mold_type")==0){%>
	'已发单(新品)',
	<%}if(rs1.getInt("mold_type")==1){%>
	'已发单(研磨品)',
	<%}if(rs1.getInt("mold_type")==2){%>
	'已发单(报废)',
	<%}}if(rs1.getInt("mold_location")==2){%>
	'入库',
	<%}if(rs1.getInt("mold_location")==3){%>
	'生产中',
	<%}if(rs1.getInt("mold_location")==4){%>
	'已拆卸',
	<%}if(rs1.getInt("mold_location")==5){%>
	'报废',
	<%}%>
	''],
<%--
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("check.jsp?apply_ID=<%=rs.getString("apply_ID")%>&config_id=<%=rs2.getString("config_id")%>")><%=demo.getLang("erp","审核")%></div>'

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
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>" />
<%
		mold_db.close();
		mold_db1.close();
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>
<%@include file="../../include/head_msg.jsp"%>

