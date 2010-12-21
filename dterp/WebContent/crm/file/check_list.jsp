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
	import="java.io.*" import="include.nseer_db.*,java.text.*"%>
<%
			nseer_db crm_db = new nseer_db((String) session
			.getAttribute("unit_db_name"));
			nseer_db crm_db1 = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<jsp:useBean id="validata" scope="page" class="validata.ValidataNumber" />
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page" />
<jsp:useBean id="mask" class="include.operateXML.Reading" />
<jsp:setProperty name="mask" property="file"
	value="xml/crm/crm_file.xml" />
<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：",
			"document_main", "reason", "value");
%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page"
	class="include.query.getRecordCount" />
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<script src="../../javascript/table/movetable.js">
</script>
<%
		String first_state="0";//0——第一次加载，1——再次加载
		if(request.getParameter("crm_id")!=null||request.getParameter("crm_name")!= null||request.getParameter("crm_register_time")!= null){
			first_state="1";
		}
		String my_condition="";
		//查询
		if (request.getParameter("crm_id") != null&&request.getParameter("crm_id").length() > 0) {
			my_condition += " and customer_id like '%"+request.getParameter("crm_id")+"%'";
		}
		//查询
		if (request.getParameter("crm_name") != null&&request.getParameter("crm_name").length() > 0) {
			my_condition += " and customer_name like '%"+request.getParameter("crm_name")+"%'";
		}
		//查询
		if (request.getParameter("crm_register_time") != null&&request.getParameter("crm_register_time").length() > 0) {
			my_condition += " and register_time like '%"+request.getParameter("crm_register_time")+"%'";
		}
		//审核未通过的信息
		String my_sql_search = "select * FROM crm_file where C_DEFINE1='0' and check_tag=0 "+ my_condition + " order by id ";
		
		String register_ID = (String) session.getAttribute("human_ID");
		String realname = (String) session.getAttribute("realeditorc");
		String condition = "";
	
		String validationXml = "";
		String nickName = "客户档案";
		String fileName = "check_list.jsp";
		String rowSummary = demo.getLang("erp", "符合条件的客户档案总数：");
		int k = 1;
		
%>
<%@include file="../../include/search_my.jsp"%>
<%--@include file="../../include/search.jsp"--%>
<%
	try{
	ResultSet rs = crm_db1.executeQuery(sql_search);
	
	
%>
<form action="check_list.jsp" method="post" name="search_form" id="search_form">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE6%> class="TD_STYLE6">客户编号：
		<%
		String crm_id="";
		if (request.getParameter("crm_id") != null&&request.getParameter("crm_id").length() > 0) {
			crm_id=request.getParameter("crm_id");
		}
		String crm_name="";
		if (request.getParameter("crm_name") != null&&request.getParameter("crm_name").length() > 0) {
			crm_name=request.getParameter("crm_name");
		}
		String crm_register_time="";
		if (request.getParameter("crm_register_time") != null&&request.getParameter("crm_register_time").length() > 0) {
			crm_register_time=request.getParameter("crm_register_time");
		}
		%>
		  <input type="text" name="crm_id" onfocus="" id="" value="<%=crm_id %>" style="width: 18%">
		  
		  客户名称：
		  <input type="text" name="crm_name" onfocus="" id="" value="<%=crm_name %>" style="width: 18%">
		  登记时间：
		  <input type="text" name="crm_register_time" onFocus="this.blur()" id="date_start" value="<%=crm_register_time %>" style="width: 18%">
		  <input type="submit" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>" >
		</td>
	</tr>
</table>
</form>
<%--@include file="../../include/search_top.jsp"--%>
<div id="nseer_grid_div"></div>
<%if(first_state.equals("0")){rs=null;} %>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","客户编号")%>'},
                       {name: '<%=demo.getLang("erp","客户名称")%>'},
                       {name: '<%=demo.getLang("erp","客户分类")%>'},
					   {name: '<%=demo.getLang("erp","登记时间")%>'},
					   {name: '<%=demo.getLang("erp","审核")%>'}
]
nseer_grid.column_width=[180,240,240,100,60];
nseer_grid.auto='<%=demo.getLang("erp","客户分类")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">

['<%=rs.getString("customer_ID")%>',
'<%=exchange.toHtml(rs.getString("customer_name"))%>',
'<%=exchange.toHtml(rs.getString("chain_name"))%>',
'<%=exchange.toHtml(rs.getString("register_time").substring(0,10))%>',
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("check.jsp?id=<%=rs.getString("id") %>")><%=demo.getLang("erp", "审核")%></div>'],


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
<%--@include file="../../include/search_bottom.jsp"--%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>" />
<%
		crm_db.close();
		crm_db1.close();
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>
<%@include file="../../include/head_msg.jsp"%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
