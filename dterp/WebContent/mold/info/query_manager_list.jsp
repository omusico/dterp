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
<table  class="TABLE_STYLE2" width="100%">
	<tr height=20 class="TR_STYLE1">
		<td  class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook">您正在做的业务是：模具管理--模具信息查询--模具管理示意图<script type="text/javascript" src="/erpv7/javascript/include/nseer_cookie/toolTip.js"></script><script type="text/javascript" src="/erpv7/javascript/include/div/alert.js"></script> <div style="position:absolute;top:25px;width:50px;left:0;"><table><tr></tr></table></div><input type="hidden" id="show-dialog-btn"></div>
		</td>
	</tr>
</table>

<%
String my_condition="";
//String my_condition2="";

//模具规格
String select_type=request.getParameter("select_type");
if(select_type==null){
	my_condition =" and 1=2 ";
}//模具规格
String mold_type_s=request.getParameter("mold_type_s");
if(mold_type_s!=null&&!mold_type_s.trim().equals("")){
	my_condition +=" and mold_type='"+mold_type_s+"' ";
}else{
	mold_type_s="";
}
//拆卸者
String destruction_man=request.getParameter("destruction_man");
if(destruction_man!=null&&!destruction_man.trim().equals("")){
	my_condition +=" and mold_spec like '%"+destruction_man+"%' ";
}else{
	destruction_man="";
}
String strOrderby="";
if(select_type!=null&&!select_type.trim().equals("")){
	if(select_type.equals("0-0")){
		my_condition+=" and mold_location<4  ";
		
		strOrderby="mold_spec,mold_code";
	}
	if(select_type.equals("1-0")){
		my_condition+=" and mold_location=1  and  mold_type=0 ";
		strOrderby="mold_spec,mold_code";
	}
	if(select_type.equals("1-1")){
		my_condition+=" and mold_location=1 and  mold_type=1 ";
		strOrderby="mold_spec,mold_code";
	}
	if(select_type.equals("2")){
		my_condition+=" and mold_location=2  ";
		strOrderby="mold_spec,mold_code";
	}
	if(select_type.equals("3")){
		my_condition+=" and mold_location=3 and mold_machine_number!=0  ";
		strOrderby="mold_machine_number";
		
	}
}else{
	select_type="0-0";
	strOrderby="mold_spec,mold_code";
	//my_condition=" and mold_location=1  and  mold_type=1 ";
	
}

//String end_date=request.getParametr("end_date");
//if(end_date!=null&&!end_date.equals("")){
	//my_condition+=" and 
//}
//模具编号



int i=0;
	String my_sql_search="select * from mold_info where 1=1 "+my_condition+" order by "+strOrderby;
	
	String tablename = "manufacture_apply";
	String realname = (String) session.getAttribute("realeditorc");
	String condition = "check_tag='0' and excel_tag='2'";
	String queue = "order by register_time";
	String validationXml = "../../xml/manufacture/manufacture_apply.xml";
	String nickName = "生产计划";
	String fileName = "query_manager_list.jsp";
	String rowSummary = demo.getLang("erp", "当前等待审核的生产计划总数：");
int k=0;
%>
<%@include file="../../include/search_my.jsp"%>
<%
try{
ResultSet rs1 = mold_db.executeQuery(sql_search); 	
int workflow_amount=0;
%>
<form action="query_manager_list.jsp" method="post" name="search_form" id="search_form">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	    <td <%=TD_STYLE6%> class="TD_STYLE6">
	    模具规格：
	    <input type="text" name="destruction_man" onfocus="" id="" value="<%=destruction_man %>" style="width: 100">
	   &nbsp;&nbsp;
	    模具状态类型：<select name="mold_type_s" id="mold_type_s" >
	    <%
	    if(mold_type_s.equals("")){
	    %>
	    <option value="" selected="selected">全部</option>
	    <option value="0">新品</option>
		<option value="1">研磨品</option>
	    <%	
	    }else if(mold_type_s.equals("0")){
	    %>
	    <option value="" >全部</option>
	    <option value="0" selected="selected">新品</option>
		<option value="1">研磨品</option>
	    <%
	    }else if(mold_type_s.equals("1")){
	    %>
	    <option value="" >全部</option>
	    <option value="0" >新品</option>
		<option value="1" selected="selected">研磨品</option>
	    <%
	    }else{
	    %>
	    <option value="" selected="selected">全部</option>
	    <option value="0" >新品</option>
		<option value="1" >研磨品</option>
	    <%
	    }
	    %>
		</select> 
	    &nbsp;&nbsp;
		查看类型：<select name="select_type" id="select_type">
		<%
		if(select_type.equals("0-0")){
		%>
		<option value="0-0" selected="selected">全部</option>
	  	<option value="1-0">已发单(新品)</option>
	  	<option value="1-1">已发单(研磨品)</option>
	  	<option value="2">库存</option>
	  	<option value="3">正在使用</option>
		<%	
		}else if(select_type.equals("1-0")){
		%>
		<option value="0-0">全部</option>
	  	<option value="1-0" selected="selected">已发单(新品)</option>
	  	<option value="1-1">已发单(研磨品)</option>
	  	<option value="2">库存</option>
	  	<option value="3">正在使用</option>
		<%		
		}else if(select_type.equals("1-1")){
		%>
		<option value="0-0">全部</option>
	  	<option value="1-0">已发单(新品)</option>
	  	<option value="1-1" selected="selected">已发单(研磨品)</option>
	  	<option value="2">库存</option>
	  	<option value="3">正在使用</option>
		<%	
		}else if(select_type.equals("2")){
		%>
		<option value="0-0">全部</option>
	  	<option value="1-0">已发单(新品)</option>
	  	<option value="1-1">已发单(研磨品)</option>
	  	<option value="2" selected="selected">库存</option>
	  	<option value="3">正在使用</option>
		<%	
		}else if(select_type.equals("3")){
		%>
		<option value="0-0">全部</option>
	  	<option value="1-0">已发单(新品)</option>
	  	<option value="1-1">已发单(研磨品)</option>
	  	<option value="2">库存</option>
	  	<option value="3" selected="selected">正在使用</option>
		<%	
		}else{
		%>
		<option value="0-0" selected="selected">全部</option>
	  	<option value="1-0">已发单(新品)</option>
	  	<option value="1-1">已发单(研磨品)</option>
	  	<option value="2">库存</option>
	  	<option value="3">正在使用</option>
		<%	
		}
		%>
		  	
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
<% 
if(select_type.equals("3")){
%>

nseer_grid.columns =[
 	{name: '<%=demo.getLang("erp","机器号")%>'},{name: '<%=demo.getLang("erp","规格")%>'},{name: '<%=demo.getLang("erp","模具")%>'},{name: '<%=demo.getLang("erp","组装者")%>'}, {name: '<%=demo.getLang("erp","类型")%>'},
                              {name: '<%=demo.getLang("erp","状态")%>'}]
nseer_grid.column_width=[190,190,190,190,190,200];
nseer_grid.auto='<%=demo.getLang("erp","机号")%>';
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
<%
	String type="";
	String location="";
	String mold_type=rs1.getString("mold_type");
	String mold_location=rs1.getString("mold_location");
	if(mold_type.equals("0")){
		type="新品";
	}
	if(mold_type.equals("1")){
		type="研磨品";
	}
	if(mold_location.equals("1")){
		location="已发单";
	}
	if(mold_location.equals("2")){
		location="库存";
	}
	if(mold_location.equals("3")){
		location="正在使用";
	}
	
%>
['<%=rs1.getString("mold_machine_number")%>',
'<%=rs1.getString("mold_spec")%>',
'<%=rs1.getString("mold_code")%>',
'<%=rs1.getString("assembler")%>',
'<%=type%>',
'<%=location%>'],
<%--
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("check.jsp?apply_ID=<%=rs.getString("apply_ID")%>&config_id=<%=rs2.getString("config_id")%>")><%=demo.getLang("erp","审核")%></div>'

</page:pages> 
--%> 
<%k++;%> 
</page:pages>
['']];

<%
}else{
%>


nseer_grid.columns =[
                      {name: '<%=demo.getLang("erp","规格")%>'},
                            {name: '<%=demo.getLang("erp","模具")%>'},
                             {name: '<%=demo.getLang("erp","类型")%>'},
                              {name: '<%=demo.getLang("erp","状态")%>'}
                       
]
nseer_grid.column_width=[250,300,300,300];
nseer_grid.auto='<%=demo.getLang("erp","规格")%>';
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
<%
	String type="";
	String location="";
	String mold_type=rs1.getString("mold_type");
	String mold_location=rs1.getString("mold_location");
	if(mold_type.equals("0")){
		type="新品";
	}
	if(mold_type.equals("1")){
		type="研磨品";
	}
	if(mold_location.equals("1")){
		location="已发单";
	}
	if(mold_location.equals("2")){
		location="库存";
	}
	if(mold_location.equals("3")){
		location="正在使用";
	}
	
%>
['<%=rs1.getString("mold_spec")%>',
'<%=rs1.getString("mold_code")%>',
'<%=type%>','<%=location%>'],
<%--
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("check.jsp?apply_ID=<%=rs.getString("apply_ID")%>&config_id=<%=rs2.getString("config_id")%>")><%=demo.getLang("erp","审核")%></div>'

</page:pages> 
--%> 
<%k++;%> 
</page:pages>
['']];

<%
}
%>
nseer_grid.init();

function init_select(select_id,init_value){
	var select=document.getElementById(select_id);
	var options=select.options;
	
	for(var i=0;i<options.length;i++){
	
		if(options[i].value==init_value){
		
			options[i].selected=true;
			break;
		}
		
	}
}
 
init_select("select_type","<%=select_type%>");
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

