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
			nseer_db manufacture_db = new nseer_db((String) session
			.getAttribute("unit_db_name"));
%>
<jsp:useBean id="query" scope="page"
	class="include.query.getRecordCount" />
<jsp:useBean id="validata" scope="page" class="validata.ValidataNumber" />
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page" />
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page" />
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page" />
<jsp:useBean id="mask" class="include.operateXML.Reading" />
<jsp:setProperty name="mask" property="file" value="xml/manufacture/manufacture_apply.xml" />
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/manufacture/apply/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css" />
<%
		try {
		
		DealWithString DealWithString = new DealWithString(application);
		String mod = request.getRequestURI();
		demo.setPath(request);
		String handbook = demo.businessComment(mod, "您正在做的业务是：",
		"document_main", "reason", "value");
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<%	
String first_state="0";//0——第一次加载，1——再次加载
if(request.getParameter("product_no")!=null||request.getParameter("keyword")!=null||request.getParameter("product_name")!= null||request.getParameter("register_name")!= null){
	first_state="1";
}
	int i =0;
	String my_sql_search = "SELECT * FROM event_info a left join product_info b on event_product_id =b.id where (a.event_checker is null OR a.event_checker = '')";	
	if(request.getParameter("keyword") != null&&request.getParameter("keyword").length() > 0)
	{
		my_sql_search +=" having 1=1";
	}
	String register_name="";
	if(request.getParameter("register_name") != null&&request.getParameter("register_name").length() > 0)
	{
		
		register_name=request.getParameter("register_name");
		my_sql_search += " and event_name like'%"+ request.getParameter("register_name") + "%' ";
		i =1;
	}
	if(request.getParameter("keyword") != null&&request.getParameter("keyword").length() > 0)
	{
		if(i == 1)
			my_sql_search += " and event_place like'%"+ request.getParameter("keyword") + "%' ";
		else
		{
			my_sql_search += " and event_place like'%"+ request.getParameter("keyword") + "%' ";
			i=1;
		}
	}
	String product_name="";
	if(request.getParameter("product_name") != null&&request.getParameter("product_name").length() > 0)
	{
		product_name=request.getParameter("product_name");
		if(i == 1) 
			my_sql_search += " and product_spec like'%"+ request.getParameter("product_name") + "%' ";
		else
		{
			my_sql_search += " and product_spec like'%"+ request.getParameter("product_name") + "%' ";
			i=1;
		}
	}
	String product_no="";
	if(request.getParameter("product_no") != null&&request.getParameter("product_no").length() > 0)
	{
		product_no=request.getParameter("product_no");
		if(i == 1)
			my_sql_search += " and product_lot_no like'%"+ request.getParameter("product_no") + "%' ";
		else
		{
			my_sql_search += " and product_lot_no like'%"+ request.getParameter("product_no") + "%' ";
			i=1;
		}
	}
	String register_ID = (String) session.getAttribute("human_ID");
	String realname = (String) session.getAttribute("realeditorc");
	String rowSummary = demo.getLang("erp", "符合条件的信息总数");
	String tablename = "product_info";
	String condition = "";
	String queue = "";
	String validationXml = "";
	String nickName = "";
	String fileName = "check_list.jsp";
	int k = 0;
%>

<%@include file="../../include/search_my.jsp"%>

<%		ResultSet rs1 = manufacture_db.executeQuery(sql_search); %>
		<!--  String sql_temp = sql_search.substring(0, sql_search.indexOf("limit"));
		intRowCount = query.count((String) session.getAttribute("unit_db_name"), sql_temp.replace("*","distinct apply_ID"));
		otherButtons = "&nbsp;<input type=\"button\" " + BUTTON_STYLE1
		+ " class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+ demo.getLang("erp", "全选")
		+ "\" name=\"check\" onclick=\"selAll()\">"+ DgButton.getGar(tablename, request);
		String apply_id_control = "";
		int maxPage = (intRowCount + pageSize - 1) / pageSize;
		strPage = strPage.split("⊙")[0] + "⊙" + maxPage;
		-->
<form action="check_list.jsp" method="post" name="search_form" id="search_form">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE6%> class="TD_STYLE6">
		
		事件名：<input type="text" name="register_name" onfocus="" id="date_start" value="<%=register_name %>" style="width: 150">&nbsp;
		发生场所：
		  <select id="" name="keyword" style="width: 160">
		  <%
		  if (request.getParameter("keyword") != null&&request.getParameter("keyword").length() > 0) {
				if(request.getParameter("keyword").equals("")){
		  %>
		  <option value="" selected="selected">全部</option>
		  <option value="4分切">4分切</option>
		  <option value="8mm切">8mm切</option>
		  <option value="打孔">打孔</option>
		  <%
				}else if(request.getParameter("keyword").equals("4分切")){
			%>
			<option value="" >全部</option>
		  <option value="4分切" selected="selected">4分切</option>
		  <option value="8mm切">8mm切</option>
		  <option value="打孔">打孔</option>
			<%	
				}else if(request.getParameter("keyword").equals("4分切")){
					%>
					<option value="" >全部</option>
				  <option value="4分切" selected="selected">4分切</option>
				  <option value="8mm切">8mm切</option>
				  <option value="打孔">打孔</option>
					<%	
				}else if(request.getParameter("keyword").equals("8mm切")){
					%>
					<option value="" >全部</option>
				  <option value="4分切" >4分切</option>
				  <option value="8mm切" selected="selected">8mm切</option>
				  <option value="打孔">打孔</option>
					<%	
				}else if(request.getParameter("keyword").equals("打孔")){
					%>
					<option value="" >全部</option>
				  <option value="4分切" >4分切</option>
				  <option value="8mm切">8mm切</option>
				  <option value="打孔" selected="selected">打孔</option>
					<%	
						}else{
							
			%>
			<option value="" selected="selected">全部</option>
		  <option value="4分切">4分切</option>
		  <option value="8mm切">8mm切</option>
		  <option value="打孔">打孔</option>
			<%			
						}
		  }else{
		%>
		<option value="" selected="selected">全部</option>
		  <option value="4分切">4分切</option>
		  <option value="8mm切">8mm切</option>
		  <option value="打孔">打孔</option>
		<%	  
		  }
				  %>
		  </select>&nbsp;
		  规格：<input type="text" name="product_name" onfocus="" id="date_start" value="<%=product_name %>" style="width: 150">&nbsp;
		  产品批次号：<input type="text" name="product_no" onfocus="" id="date_start" value="<%=product_no %>" style="width: 150">
		  &nbsp;<input type="submit" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>" >
		</td>
	</tr>
</table>
</form>
<div id="nseer_grid_div"></div>
<%if(first_state.equals("0")){rs1=null;} %>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}

var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");

nseer_grid.columns =[
					   
                      {name: '<%=demo.getLang("erp","产品批次号")%>'},
                       {name: '<%=demo.getLang("erp","发生时间")%>'},
                      {name: '<%=demo.getLang("erp","发生场所")%>'},
                      {name: '<%=demo.getLang("erp","事件名")%>'},
                       {name: '<%=demo.getLang("erp","规格")%>'},  
                       {name: '<%=demo.getLang("erp","审核")%>'},
                      {name: '<%=demo.getLang("erp","&nbsp;")%>'}
]
nseer_grid.column_width=[150,150,150,150,125,100,100];
nseer_grid.auto='<%=demo.getLang("erp","&nbsp;")%>';
nseer_grid.data = [

<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 

['<%=rs1.getString("product_lot_no")%>','<%=rs1.getString("event_take_time")%>','<%=rs1.getString("event_place")%>','<%=rs1.getString("event_name")%>','<%=rs1.getString("product_spec")%>'
<%
if(true)
{
%>
,'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("check.jsp?event_product_id=<%=exchange.unHtmls(Integer.toString(rs1.getInt("event_product_id")))%>")><%=demo.getLang("erp","审核")%></div>'<%}else{%>,''<%}%>],	

<%k++;%>
</page:pages>

['']];
<%--
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
--%>
<%--
if(apply_id_control.indexOf(rs.getString("apply_id"))==-1){
apply_id_control+=rs.getString("apply_id");
String check_tag="1";
String manufacture_tag="";
String color="#FF9A31";
if(rs.getString("check_tag").equals("0")){
manufacture_tag="等待";
}else if(rs.getString("check_tag").equals("9")){
manufacture_tag="未通过";
color="#FF0000";
}else if(rs.getString("check_tag").equals("1")){
manufacture_tag="通过";
check_tag="0";
color="3333FF";
}
--%>
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>" />
<%-- <input type="hidden" name="" id="rows_num" value="<%=k%>">--%>
<%
	manufacture_db.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<%@include file="../../include/head_msg.jsp"%>
