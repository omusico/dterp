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
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_file.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.query"/>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"> <div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
String tablename="hr_file";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1'";
String queue="order by register_time desc";
String validationXml="../../xml/hr/hr_file.xml";
String nickName="人力资源档案";
String fileName="change_list.jsp";
String rowSummary=demo.getLang("erp","当前可变更的人力资源档案总数：");
String crm_id="";
String crm_name="";
String crm_register_time="";
%>
<% 
try{
	String my_sql_search="select * from hr_file where  1=1 ";
	if(request.getParameter("crm_id")!=null&&request.getParameter("crm_id").length()!=0){
		crm_id=request.getParameter("crm_id");
		my_sql_search+=" and idcard like '%"+request.getParameter("crm_id")+"%'";
	}if(request.getParameter("crm_name")!=null&&request.getParameter("crm_name").length()!=0){
		crm_name=request.getParameter("crm_name");
		my_sql_search+=" and HUMAN_NAME like '%"+request.getParameter("crm_name")+"%'";
	}if(request.getParameter("crm_register_time")!=null&&request.getParameter("crm_register_time").length()!=0){
		crm_register_time=request.getParameter("crm_register_time");
		my_sql_search+=" and REGISTER_TIME like '%"+request.getParameter("crm_register_time")+"%'";
	}if(request.getParameter("plan_typeS")!=null&&request.getParameter("plan_typeS").length()!=0){
		if(request.getParameter("plan_typeS").equals("all")){
		
		}else{
			my_sql_search+=" and check_tag like '%"+request.getParameter("plan_typeS")+"%'";
		}
	}
	my_sql_search+=" order by register_time desc";
	%><%@include file="../../include/search_my.jsp"%><%
ResultSet rs = hr_db.executeQuery(my_sql_search);
%>
<%--
<%@include file="../../include/search_top.jsp"%>
 --%>
 
 <form action="change_list.jsp" method="post" name="search_form" id="search_form">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE6%> class="TD_STYLE6">员工编号：
		  <input type="text" name="crm_id" onfocus="" id="" style="width: 12%" value="<%=crm_id %>">&nbsp;
		  姓名：
		  <input type="text" name="crm_name" onfocus="" id="" value="<%=crm_name %>" style="width: 12%" >&nbsp;
		  登记时间：
		  <input type="text" name="crm_register_time" onfocus="" id="date_start" value="<%=crm_register_time %>" style="width: 12%">&nbsp;
		  审核状态：
		  <select name="plan_typeS" style="width: 12%">
		  <%
		  if (request.getParameter("plan_typeS") != null&&request.getParameter("plan_typeS").length() > 0) {
				if(request.getParameter("plan_typeS").equals("0")){
		  %>
		  <option value="all">------全部------</option>
		  <option value="0" selected="selected">未审核</option>
		  <option value="1">审核通过</option>
		  <option value="2">审核未通过</option>
		  <%}else if(request.getParameter("plan_typeS").equals("1")){ %>
		  <option value="all">------全部------</option>
		  <option value="0">未审核</option>
		  <option value="1" selected="selected">审核通过</option>
		  <option value="2">审核未通过</option>
		  <%
				}else if(request.getParameter("plan_typeS").equals("2")){
		  %>
		  <option value="all">------全部------</option>
		  <option value="0">未审核</option>
		  <option value="1">审核通过</option>
		  <option value="2" selected="selected">审核未通过</option>
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
		  <input type="hidden" name="searchId" value="45"  />&nbsp;&nbsp;
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
                       {name: '<%=demo.getLang("erp","登记时间")%>'},
                       {name: '<%=demo.getLang("erp","职位分类")%>'},
                       {name: '<%=demo.getLang("erp","职位名称")%>'},
                       {name: '<%=demo.getLang("erp","审核状态")%>'},
					   {name: '<%=demo.getLang("erp","变更")%>'}
]
nseer_grid.column_width=[180,130,140,140,140,140,140,200];

nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%if(request.getParameter("searchId")!=null){
	int id = rs.getInt("CHECK_TAG");
	String departStatus = "";
	if(id==0){
		departStatus = "未审核";
	}else if(id==1){
		departStatus = "审核通过";
	}else if(id==2){
		departStatus = "审核未通过";
	}
	
	String timeShow = rs.getString("REGISTER_TIME");
	timeShow = timeShow.substring(0,10);
	if(!rs.getString("idcard").equals("00000")){//admin最大权限
%>
['<%=rs.getString("idcard")%>',
'<%=exchange.toHtml(rs.getString("human_name"))%>',
'<%=exchange.toHtml(rs.getString("chain_name"))%>',
'<%=timeShow%>',
'<%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>',
'<%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%>',
'<%=departStatus%>',
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("change.jsp?human_ID=<%=rs.getString("human_ID")%>")><%=demo.getLang("erp","变更")%></div>'],<%}}%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
hr_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>