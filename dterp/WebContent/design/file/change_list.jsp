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
		if(request.getParameter("product_id")!=null||request.getParameter("product_name")!= null){
			first_state="1";
		}
		String my_condition="";
		//查询
		if (request.getParameter("product_id") != null&&request.getParameter("product_id").length() > 0) {
			my_condition += " and product_ID like '%"+request.getParameter("product_id")+"%'";
		}
		//查询
		if (request.getParameter("product_name") != null&&request.getParameter("product_name").length() > 0) {
			my_condition += " and product_name like '%"+request.getParameter("product_name")+"%'";
		}
		//查询
		if (request.getParameter("type") != null&&request.getParameter("type").length() > 0) {
			if(!request.getParameter("type").equals("0")){
				my_condition += " and type="+request.getParameter("type");
			}
		}
//		查询
		if (request.getParameter("plan_typeS") != null&&request.getParameter("plan_typeS").length() > 0) {
			if(!request.getParameter("plan_typeS").equals("all")){
				my_condition += " and check_tag="+request.getParameter("plan_typeS");
			}
		}
		//审核未通过的信息
		String my_sql_search = "select check_tag,id,product_ID,product_name,type,chain_name from design_file where C_DEFINE1='0' "+my_condition+" order by id desc";
		
		String register_ID = (String) session.getAttribute("human_ID");
		String realname = (String) session.getAttribute("realeditorc");
		String condition = "";
	
		String validationXml = "";
		String nickName = "产品档案";
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
<form action="change_list.jsp" method="post" name="search_form" id="search_form">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<%
	String product_id="";
	if (request.getParameter("product_id") != null&&request.getParameter("product_id").length() > 0) {
		product_id=request.getParameter("product_id");
	}
	String product_name="";
	if (request.getParameter("product_name") != null&&request.getParameter("product_name").length() > 0) {
		product_name=request.getParameter("product_name");
	}
	%>
		<td <%=TD_STYLE6%> class="TD_STYLE6">产品编号：
		  <input type="text" name="product_id" onfocus="" id="" value="<%=product_id %>" style="width: 12%">&nbsp;
		  产品名称：
		  <input type="text" name="product_name" onfocus="" id="" value="<%=product_name %>" style="width: 12%">&nbsp;
		  用途类型：
		  <select name="type" style="width: 12%">
		  <%
		  if (request.getParameter("type") != null&&request.getParameter("type").length() > 0) {
				if(request.getParameter("type").equals("0")){
		  %>
		  <option value="0" selected="selected">-----------全部-----------</option>
		  <option value="1">纸类型</option>
		  <option value="2">模具</option>
		  

		  <%
				}else if(request.getParameter("type").equals("1")){
		  %>
		  <option value="0">-----------全部-----------</option>
		  <option value="1" selected="selected">纸类型</option>
		  <option value="2">模具</option>
		  <%		
				}else if(request.getParameter("type").equals("2")){
		  %>
		  <option value="0" selected="selected">-----------全部-----------</option>
		  <option value="1">纸类型</option>
		  <option value="2" selected="selected">模具</option>
		  <%			
				} 
		  }else{
		  %>
		  <option value="0" selected="selected">-----------全部-----------</option>
		  <option value="1">纸类型</option>
		  <option value="2">模具</option>
		  <%	
		  }
		  %>
		  </select>&nbsp;
		  审核状态：
		  <select name="plan_typeS" style="width: 12%">
		  <%
		  if (request.getParameter("plan_typeS") != null&&request.getParameter("plan_typeS").length() > 0) {
				if(request.getParameter("plan_typeS").equals("0")){
		  %>
		  <option value="all">-----------全部-----------</option>
		  <option value="0" selected="selected">未审核</option>
		  <option value="1">审核通过</option>
		  <option value="2">审核未通过</option>
		  <%
				}else if(request.getParameter("plan_typeS").equals("1")){
		  %>
		  <option value="all">-----------全部-----------</option>
		  <option value="0">未审核</option>
		  <option value="1" selected="selected">审核通过</option>
		  <option value="2" >审核未通过</option>
		  <%			
				}else if(request.getParameter("plan_typeS").equals("2")){
		  %>
		  <option value="all">-----------全部-----------</option>
		  <option value="0">未审核</option>
		  <option value="1">审核通过</option>
		  <option value="2" selected="selected">审核未通过</option>
		  <%			
				}else if(request.getParameter("plan_typeS").equals("all")){
		  %>
					  <option value="all" selected="selected">-----------全部-----------</option>
					  <option value="0">未审核</option>
					  <option value="1">审核通过</option>
					  <option value="2">审核未通过</option>
		  <%				
				}
		  }else{
		  %>
		  <option value="all" selected="selected">-----------全部-----------</option>
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
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","用途类型")%>'},
                       {name: '<%=demo.getLang("erp","产品分类")%>'},
					   {name: '<%=demo.getLang("erp","档案状态")%>'},
					   {name: '<%=demo.getLang("erp","更改")%>'}
]
nseer_grid.column_width=[180,180,100,180,80,60];
nseer_grid.auto='<%=demo.getLang("erp","产品分类")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<%
String type_name="";
String sql_t_name="select id,type_name from design_config_public_char where id="+rs.getString("type");
ResultSet rs_t_name=crm_db.executeQuery(sql_t_name);
if(rs_t_name.next()){
	type_name=rs_t_name.getString("type_name");
}
String status="";
if(rs.getString("check_tag").equals("0")){
	status="未审核";
}else if(rs.getString("check_tag").equals("1")){
	status="审核通过";
}else if(rs.getString("check_tag").equals("2")){
	status="审核未通过";
}
%>
[
'<%=rs.getString("product_ID")%>',
'<%=exchange.toHtml(rs.getString("product_name"))%>',
'<%=type_name%>',
'<%=exchange.toHtml(rs.getString("chain_name"))%>',
'<%=status%>',
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("change.jsp?id=<%=rs.getString("id") %>")><%=demo.getLang("erp", "更改")%></div>'],
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

