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
			nseer_db hr_db = new nseer_db((String) session.getAttribute("unit_db_name"));
			nseer_db hr_db1 = new nseer_db((String) session.getAttribute("unit_db_name"));
%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page" />
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page" />
<jsp:useBean id="mask" class="include.operateXML.Reading" />
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_file.xml" />
<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：","document_main", "reason", "value");
%>
<jsp:useBean id="validata" scope="page" class="validata.ValidataNumber" />
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount" />
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<%
	String tablename = "hr_file";
	String realname = (String) session.getAttribute("realeditorc");
	String condition = "check_tag='0' and excel_tag!='0'";
	String queue = "order by register_time";
	String validationXml = "../../xml/hr/hr_file.xml";
	String nickName = "人力资源档案";
	String fileName = "check_list.jsp";
	String rowSummary = demo.getLang("erp", "当前等待审核的人力资源档案总数");
	String my_sql_search="select * from hr_file where  check_tag='0'";
	String crm_id="";
	String crm_name="";
	String crm_register_time="";
	if(request.getParameter("crm_id")!=null&&request.getParameter("crm_id").length()!=0){
		crm_id=request.getParameter("crm_id");
		my_sql_search+=" and idcard like'%"+request.getParameter("crm_id")+"%'";
	}else if(request.getParameter("crm_name")!=null&&request.getParameter("crm_name").length()!=0){
		crm_name=request.getParameter("crm_name");
		my_sql_search+=" and HUMAN_NAME like '%"+request.getParameter("crm_name")+"%'";
	}else if(request.getParameter("crm_register_time")!=null&&request.getParameter("crm_register_time").length()!=0){
		crm_register_time=request.getParameter("crm_register_time");
		my_sql_search+=" and REGISTER_TIME like '%"+request.getParameter("crm_register_time")+"%'";
	}
	my_sql_search+=" order by REGISTER_TIME desc";
%>
<%@include file="../../include/search_my.jsp"%>
<%
		try {
		String register_ID = (String) session.getAttribute("human_IDD");
		int workflow_amount = 0;
		String sql = "select count(id) from hr_config_workflow where type_id='01'";
		ResultSet rs = hr_db.executeQuery(sql);
		if (rs.next()) {
			workflow_amount = rs.getInt("count(id)");
		}
		rs = hr_db.executeQuery(my_sql_search);
%>
<%--
<%@include file="../../include/search_top.jsp"%>
--%>
<form action="check_list.jsp" method="post" name="search_form" id="search_form">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td width="20%">&nbsp;</td>
		<td style="text-align: right;">员工编号：
		  <input type="text" name="crm_id" style="width: 18%" value="<%=crm_id %>" />
		  姓名：
		  <input type="text" name="crm_name" style="width: 18%" value="<%=crm_name %>" />
		  登记时间：
		  <input type="hidden" name="searchId" value="45"  />
		  <input type="text" name="crm_register_time"  id="date_start" style="width: 18%" value="<%=crm_register_time %>" />
		  </td><td style="text-align: right;" width="6%">
		  <input type="submit" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>" >
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
                       {name: '<%=demo.getLang("erp","员工编号")%>'},
                       {name: '<%=demo.getLang("erp","姓名")%>'},
                       {name: '<%=demo.getLang("erp","部门")%>'},
                       {name: '<%=demo.getLang("erp","职位分类")%>'},
					   {name: '<%=demo.getLang("erp","职位名称")%>'},
					   {name: '<%=demo.getLang("erp","登记时间")%>'},
					   {name: '<%=demo.getLang("erp","审核")%>'}

]
nseer_grid.column_width=[240,240,160,160,160,160,210];
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
String sql1="select id from hr_workflow where object_ID='"+rs.getString("human_ID")+"' and check_tag='0' and type_id='01'";
ResultSet rs2=hr_db1.executeQuery(sql1);
if(rs2.next()){
	sql1="select check_tag,describe1,config_id from hr_workflow where object_ID='"+rs.getString("human_ID")+"' and type_id='01' order by id";
	rs2=hr_db1.executeQuery(sql1);
	if(request.getParameter("searchId")!=null){
		String timeShow = rs.getString("REGISTER_TIME");
		timeShow = timeShow.substring(0,10);
		
%>
['<%=rs.getString("idcard")%>',
'<%=exchange.toHtml(rs.getString("human_name"))%>',
'<%=exchange.toHtml(rs.getString("chain_name"))%>',
'<%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>',
'<%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%>',
'<%=timeShow%>'
<%
for(int i=1;i<=workflow_amount;i++){
	String status="";
	if(rs2.next()){
%>
	,'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("check.jsp?human_id=<%=rs.getString("human_id")%>&config_id=<%=rs2.getString("config_id")%>")><%=demo.getLang("erp","审核")%></div>'<%}else{%>,''<%}}%>],<%}%>
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
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>" />
<%
		hr_db.close();
		hr_db1.close();
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>