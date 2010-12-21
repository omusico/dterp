

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
String mold_spec="";
String mold_code="";
String my_sql_search="SELECT * FROM mold_exception left join mold_info on mold_exception.mold_id=mold_info.id where 1=1 ";

if(request.getParameter("mold_spec") != null&&request.getParameter("mold_spec").length() > 0)
{
	mold_spec=request.getParameter("mold_spec");
		my_sql_search += " and  mold_spec like'%"+ request.getParameter("mold_spec") + "%' ";
}
if(request.getParameter("mold_code") != null&&request.getParameter("mold_code").length() > 0)
{
	mold_code=request.getParameter("mold_code");
		my_sql_search += " and mold_code like'%"+ request.getParameter("mold_code") + "%' ";
}	
if(request.getParameter("plan_typeS")!=null&&request.getParameter("plan_typeS").length()!=0){
	if(request.getParameter("plan_typeS").equals("all")){
	
	}else{
		my_sql_search += " and mold_status ='"+ request.getParameter("plan_typeS") + "' ";
	}
}
		my_sql_search+=" order by exception_regist_time desc";
		
String tablename = "manufacture_apply";
	String realname = (String) session.getAttribute("realeditorc");
	String condition = "check_tag='0' and excel_tag='2'";
	String queue = "order by register_time";
	String validationXml = "../../xml/manufacture/manufacture_apply.xml";
	String nickName = "生产计划";
	String fileName = "query_list.jsp";
	String rowSummary = demo.getLang("erp", "当前等待审核的生产计划总数：");
	int k=0;
%>
<%@include file="../../include/search_my.jsp"%>
<script>
	function queryCheck(){
	
		window.location.href="query_list_look.jsp";
	
	}
</script>
<% 
		try {
		ResultSet rs1 = mold_db.executeQuery(sql_search); 		
		int workflow_amount = 0;
		%>
		<%--
		String sql = "select count(id) from manufacture_config_workflow where type_id='03'";
		ResultSet rs = manufacture_db.executeQuery(sql);
		if (rs.next()) {
			workflow_amount = rs.getInt("count(id)");
		}
		String sql_temp = sql_search.substring(0, sql_search
		.indexOf("limit"));
		intRowCount = query.count((String) session
		.getAttribute("unit_db_name"), sql_temp.replace("*",
		"distinct apply_ID"));
		String apply_id_control = "";
		int maxPage = (intRowCount + pageSize - 1) / pageSize;
		strPage = strPage.split("⊙")[0] + "⊙" + maxPage;
		rs = manufacture_db.executeQuery(sql_search);
--%>

<%-- 
<%@include file="../../include/search_top.jsp"%>
--%>
<form action="query_list.jsp" method="post" name="search_form" id="search_form">
<table width="100%" border="0" style=" text-align: right;">
  <tr>
    <td>模具规格：&nbsp;<input name="mold_spec" type="text" size="25" value="<%=mold_spec %>">&nbsp;
    模具号：&nbsp;<input name="mold_code" type="text" size="25" value="<%=mold_code %>">&nbsp;
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
    <input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>"></td>
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
                       {name: '<%=demo.getLang("erp","模具规格")%>'},
                       {name: '<%=demo.getLang("erp","模具编号")%>'},
                       {name: '<%=demo.getLang("erp","登记人")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'},
                        {name: '<%=demo.getLang("erp","档案状态")%>'},
                       {name: '<%=demo.getLang("erp","查看")%>'},
                       {name: '<%=demo.getLang("erp","&nbsp;")%>'}
]
nseer_grid.column_width=[200,100,100,150,145,100,100];
nseer_grid.auto='<%=demo.getLang("erp","&nbsp;")%>';
nseer_grid.data = [

<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%
String status = "";
if(rs1.getString("mold_status").equals("0")){
	status = "未审核";
}else if(rs1.getString("mold_status").equals("1")){
	status = "审核通过";
}else if(rs1.getString("mold_status").equals("2")){
	status = "审核未通过";
}

%>
<%--
if(apply_id_control.indexOf(rs.getString("apply_id"))==-1){
apply_id_control+=rs.getString("apply_id");
String sql1="select id from manufacture_workflow where object_ID='"+rs.getString("apply_ID")+"' and check_tag='0'";
ResultSet rs2=manufacture_db1.executeQuery(sql1);
if(rs2.next()){
	sql1="select check_tag,describe1,config_id from manufacture_workflow where object_ID='"+rs.getString("apply_ID")+"' order by id";
	rs2=manufacture_db1.executeQuery(sql1);
--%><%if(request.getParameter("mold_spec") != null){%>
	['<%=rs1.getString("mold_spec")%>','<%=rs1.getString("mold_code")%>',
	'<%=rs1.getString("exception_register")%>',
	'<%=rs1.getString("exception_regist_time")%>','<%=status%>','<div style="text-decoration : underline;color:#3366FF;" onclick=id_link("query_list_look.jsp?id=<%=rs1.getString("mold_exception.id")%>&mold_id=<%=rs1.getString("mold_id")%>")>查看</div>'],<%}%>
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

