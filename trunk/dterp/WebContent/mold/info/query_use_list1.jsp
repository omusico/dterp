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
	<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
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
		<div class="div_handbook">您正在做的业务是：模具管理--模具信息查询--模具使用情况统计<script type="text/javascript" src="/erpv7/javascript/include/nseer_cookie/toolTip.js"></script><script type="text/javascript" src="/erpv7/javascript/include/div/alert.js"></script> <div style="position:absolute;top:25px;width:50px;left:0;"><table><tr></tr></table></div><input type="hidden" id="show-dialog-btn"></div>
		</td>
	</tr>
</table>

<%
String my_condition="";

//上机时间 开始
String installation_time=request.getParameter("installation_time");
if(installation_time!=null&&!installation_time.trim().equals("")){
	my_condition +=" and a.installation_time >= '"+installation_time+"'";
}else{
	installation_time="";
}

//上机时间 结束
String installation_time_end=request.getParameter("installation_time_end");
if(installation_time_end!=null&&!installation_time_end.trim().equals("")){
	my_condition +=" and a.installation_time <= '"+installation_time_end+"'";
}else{
	installation_time_end="";
}
//模具规格

String mold_spec=request.getParameter("mold_spec");
if(mold_spec==null){
	my_condition+=" and 1=2";
}
if(mold_spec!=null&&!mold_spec.trim().equals("")){
	my_condition +=" and a.mold_spec like '%"+mold_spec+"%'";
}else{
	mold_spec="";
}

//模具编号
String mold_code=request.getParameter("mold_code");
if(mold_code!=null&&!mold_code.trim().equals("")){
	my_condition +=" and a.mold_code like '%"+mold_code+"%'";
}else{
	mold_code="";
}
//机器号
String mold_machine_number=request.getParameter("mold_machine_number");
if(mold_machine_number!=null&&!mold_machine_number.trim().equals("")){
	my_condition +=" and a.mold_machine_number ='"+mold_machine_number+"'";
}else{
	mold_machine_number="";
}




//组装者
String assembler=request.getParameter("assembler");
if(assembler!=null&&!assembler.trim().equals("")){
	my_condition +=" and a.assembler like '%"+assembler+"%'";
}else{
	assembler="";
}

//组装时间 开始
String assembly_time=request.getParameter("assembly_time");
if(assembly_time!=null&&!assembly_time.trim().equals("")){
	my_condition +=" and a.assembly_time >= '"+assembly_time+"'";
}else{
	assembly_time="";
}
//组装时间 结束
String assembly_time_end=request.getParameter("assembly_time_end");
if(assembly_time_end!=null&&!assembly_time_end.trim().equals("")){
	my_condition +=" and a.assembly_time  <= '"+assembly_time_end+"'";
}else{
	assembly_time_end="";
}
//导套号
String lock_code=request.getParameter("lock_code");
if(lock_code!=null&&!lock_code.trim().equals("")){
	my_condition +=" and a.lock_code like '%"+lock_code+"%'";
}else{
	lock_code="";
}

int i=0;
	String my_sql_search="select * from mold_info a left join mold_destruction b on a.id=b.mold_id where a.installation_time!=''  "+my_condition +" order by a.installation_time,a.mold_machine_number ";
	
	String tablename = "manufacture_apply";
	String realname = (String) session.getAttribute("realeditorc");
	String condition = "check_tag='0' and excel_tag='2'";
	String queue = "order by register_time";
	String validationXml = "../../xml/manufacture/manufacture_apply.xml";
	String nickName = "生产计划";
	String fileName = "query_use_list1.jsp";
	String rowSummary = demo.getLang("erp", "当前等待审核的生产计划总数：");
int k=0;
%>
<%@include file="../../include/search_my.jsp"%>
<%
try{
ResultSet rs1 = mold_db.executeQuery(sql_search); 	
int workflow_amount=0;
%>
<form action="query_use_list1.jsp" method="post" name="search_form" id="search_form">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE6%> class="TD_STYLE6">
		  上机时间：<input type="text" name="installation_time" onkeydown="return false" id="installation_time" value="<%=installation_time %>" style="width: 150">
&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;<input type="text" name="installation_time_end" onkeydown="return false" id="installation_time_end" value="<%=installation_time_end %>" style="width: 150">
		 		</td><td <%=TD_STYLE6%> class="TD_STYLE6">
		模具规格：<input type="text" name="mold_spec" onfocus="" id="" value="<%=mold_spec %>" style="width: 150">
		  </td><td <%=TD_STYLE6%> class="TD_STYLE6">
		    模具编号：<input type="text" name="mold_code" onfocus="" id="" value="<%=mold_code %>" style="width: 150">
		   </td><td <%=TD_STYLE6%> class="TD_STYLE6">
		     机器号：<input type="text" name="mold_machine_number" onfocus="" id="" value="<%=mold_machine_number %>" style="width: 150">
	</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE6%> class="TD_STYLE6">
		   组装时间：<input type="text" name="assembly_time" onkeydown="return false" id="date_start1" value="<%=assembly_time %>" style="width: 150">
&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;<input type="text" name="assembly_time_end" onkeydown="return false" id="date_start1_end" value="<%=assembly_time_end %>" style="width: 150">
		   </td>
		<td <%=TD_STYLE6%> class="TD_STYLE6">
		  组装者：<input type="text" name="assembler" onfocus="" id="" value="<%=assembler %>" style="width: 150">
		  </td><td <%=TD_STYLE6%> class="TD_STYLE6">
		  导套号：<input type="text" name="lock_code" onfocus="" id="" value="<%=lock_code %>" style="width: 150">
		 	</td><td <%=TD_STYLE6%> class="TD_STYLE6">
		  
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
                      {name: '<%=demo.getLang("erp","上机日期")%>'},
                            {name: '<%=demo.getLang("erp","模具规格")%>'},
                       {name: '<%=demo.getLang("erp","模具编号")%>'},
                  
     
                        {name: '<%=demo.getLang("erp","机器号")%>'},
                          {name: '<%=demo.getLang("erp","累卷")%>'},
                           {name: '<%=demo.getLang("erp","组装者")%>'},
                             {name: '<%=demo.getLang("erp","组装时间")%>'},
                             
                                {name: '<%=demo.getLang("erp","导套号")%>'},
                     
                       {name: '<%=demo.getLang("erp","备注")%>'}
]
nseer_grid.column_width=[120,100,100,100,100,100,100,100,100];
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
['<%=rs1.getString("installation_time")%>',
'<%=rs1.getString("mold_spec")%>',
'<%=rs1.getString("mold_code")%>',

'<%=rs1.getString("mold_machine_number")%>',
'<%=rs1.getString("b.destruction_item1_content")!=null?rs1.getString("b.destruction_item1_content"):""%>',

'<%=rs1.getString("assembler")%>',
'<%=rs1.getString("assembly_time")%>',
'<%=rs1.getString("lock_code")%>',

'<%=rs1.getString("b.destruction_remark")!=null?rs1.getString("b.destruction_remark"):""%>'],
<%--
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("check.jsp?apply_ID=<%=rs.getString("apply_ID")%>&config_id=<%=rs2.getString("config_id")%>")><%=demo.getLang("erp","审核")%></div>'

</page:pages>
--%> 
<%k++;%>
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
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>" />
<%
		mold_db.close();
		mold_db1.close();
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>
<%@include file="../../include/head_msg.jsp"%>
<script type="text/javascript">

Calendar.setup ({inputField : "installation_time_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "installation_time_end", singleClick : true, step : 1});

Calendar.setup ({inputField : "installation_time", ifFormat : "%Y-%m-%d", showsTime : false, button : "installation_time", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_start1", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start1", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_start1_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start1_end", singleClick : true, step : 1});

</script>
