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
		<div class="div_handbook">您正在做的业务是：模具管理--模具信息查询--模具每日更换情况表<script type="text/javascript" src="/erpv7/javascript/include/nseer_cookie/toolTip.js"></script><script type="text/javascript" src="/erpv7/javascript/include/div/alert.js"></script> <div style="position:absolute;top:25px;width:50px;left:0;"><table><tr></tr></table></div><input type="hidden" id="show-dialog-btn"></div>
		</td>
	</tr>
</table>

<%
String my_condition="";



//日期
String installation_time=request.getParameter("installation_time");
if(installation_time!=null&&!installation_time.trim().equals("")){
	my_condition +=" and b.installation_time >= '"+installation_time+"'";
}else{
	installation_time="";
}
//日期 结束
String installation_time_end=request.getParameter("installation_time_end");
if(installation_time_end!=null&&!installation_time_end.trim().equals("")){
	my_condition +=" and b.installation_time <= '"+installation_time_end+"'";
}else{
	installation_time_end="";
}
// 机器号
String mold_machine_number=request.getParameter("mold_machine_number");
if(mold_machine_number!=null&&!mold_machine_number.trim().equals("")){
	my_condition +=" and a.mold_machine_number = '"+mold_machine_number+"'";
}else{
	mold_machine_number="";
}
//模具号
String mold_code=request.getParameter("mold_code");
if(mold_code!=null&&!mold_code.trim().equals("")){
	my_condition +=" and a.mold_code like '%"+mold_code+"%'";
}else{
	mold_code="";
}
//新模具号
String new_mold_code=request.getParameter("new_mold_code");
if(new_mold_code!=null&&!new_mold_code.trim().equals("")){
	my_condition +=" and b.mold_code like '%"+new_mold_code+"%'";
}else{
	new_mold_code="";
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

//新模具规格
String new_mold_spec=request.getParameter("new_mold_spec");
if(new_mold_spec!=null&&!new_mold_spec.trim().equals("")){
	my_condition +=" and b.mold_spec like '%"+new_mold_spec+"%'";
}else{
	new_mold_spec="";
}

//导套号
//String lock_code=request.getParameter("lock_code");
//if(lock_code!=null&&!lock_code.trim().equals("")){
	//my_condition +=" and b.lock_code like '%"+lock_code+"%'";
//}else{
	//lock_code="";
//}

//组装者
String assembler=request.getParameter("assembler");
if(assembler!=null&&!assembler.trim().equals("")){
	my_condition +=" and a.installer like '%"+assembler+"%'";
}else{
	assembler="";
}

//组装时间
String assembly_time=request.getParameter("assembly_time");
if(assembly_time!=null&&!assembly_time.trim().equals("")){
	my_condition +=" and a.installation_time >= '"+assembly_time+"'";
}else{
	assembly_time="";
}

//组装时间 结束
String assembly_time_end=request.getParameter("assembly_time_end");
if(assembly_time_end!=null&&!assembly_time_end.trim().equals("")){
	my_condition +=" and b.assembly_time <= '"+assembly_time_end+"'";
}else{
	assembly_time_end="";
}

//拆卸者
String destruction_man=request.getParameter("destruction_man");
if(destruction_man!=null&&!destruction_man.trim().equals("")){
	my_condition +=" and a.destruction_man like '%"+destruction_man+"%'";
}else{
	destruction_man="";
}
//卸载时间
//String destruction_time=request.getParameter("destruction_time");
//if(destruction_time!=null&&!destruction_time.trim().equals("")){
	//my_condition +=" and a.destruction_time >= '"+destruction_time+"'";
//}else{
	//destruction_time="";
//} 

//卸载时间 结束
String destruction_time_end=request.getParameter("destruction_time_end");
if(destruction_time_end!=null&&!destruction_time_end.trim().equals("")){
	my_condition +=" and a.destruction_time <='"+destruction_time_end+"'";
}else{
	destruction_time_end="";
}  
int i=0;
	//String my_sql_search="select  * from mold_info a,(select d.id, d.mold_spec,d.lock_code,d.product_spec,d.installation_time,d.mold_code,d.mold_machine_number,d.assembler,d.assembly_time  from mold_info d left join mold_destruction c on c.mold_id=d.id ) as b where a.destruction_time=b.installation_time and a.mold_machine_number !=0 and a.mold_machine_number=b.mold_machine_number and a.id!=b.id "+my_condition+" order by a.destruction_time ";
	String my_sql_search="select  * from (select d.*,c.mold_id,c.destruction_remark,c.destruction_item1_content from mold_info  d left join mold_destruction c on c.mold_id=d.id) as a ,mold_info  as b where a.destruction_time=b.installation_time and a.mold_machine_number !=0 and a.mold_machine_number=b.mold_machine_number and a.id!=b.id "+my_condition+" order by a.destruction_time,a.mold_machine_number ";
	String tablename = "manufacture_apply";
	String realname = (String) session.getAttribute("realeditorc");
	String condition = "check_tag='0' and excel_tag='2'";
	String queue = "order by register_time";
	String validationXml = "../../xml/manufacture/manufacture_apply.xml";
	String nickName = "生产计划";
	String fileName = "query_change_list.jsp";  
	String rowSummary = demo.getLang("erp", "当前等待审核的生产计划总数：");
int k=0;
%>
<%@include file="../../include/search_my.jsp"%>
<%
try{
ResultSet rs1 = mold_db.executeQuery(sql_search); 	
int workflow_amount=0;
%>
<form action="query_change_list.jsp" method="post" name="search_form" id="search_form">
<table >
	<tr >
		<td width="20px;">
		&nbsp;
		</td>
		<td align="right" >
		机器号：
		</td>
		<td>
		<input type="text" name="mold_machine_number" maxlength="6" onfocus="" id="mold_machine_number" value="<%=mold_machine_number %>" style="width: 70">
		</td>
		<td >
		<!--  导套号<input type="text" name="lock_code" maxlength="10" onfocus="" id="" value="" style="width: 80">-->
		</td>
		<td  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	
		<td  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		
		<td  >&nbsp;</td>
		<td align="right" >
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期：
		</td>
		<td><input type="text" name="installation_time" maxlength="12" onfocus="" id="installation_time" value="<%=installation_time %>" style="width: 100">&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;
		<input type="text" name="installation_time_end" maxlength="12" onfocus="" id="installation_time_end" value="<%=installation_time_end %>" style="width: 100">
		</td>
		<td >&nbsp;</td>
	</tr>
	<tr>
			<td width="20px;">
		&nbsp;
		</td>
		<td align="right">
		模具号：
		</td>
		<td>
		<input type="text" name="mold_code" maxlength="6" onfocus="" id="" value="<%=mold_code %>" style="width: 70">
		</td>
		<td align="right">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;规格：
		</td>
		<td>
		<input type="text" name="mold_spec" maxlength="10" onfocus="" id="" value="<%=mold_spec %>" style="width: 100">
		</td>
		<td  align="right">
	     拆卸者：
	     </td>
		<td>
		<input type="text" name="destruction_man" maxlength="12" onfocus="" id="" value="<%=destruction_man %>" style="width: 100">
		</td>
		<td  align="right">
		
		</td>
		<td>
	
		</td>	
		
	</tr>
	<tr>
			<td width="20px;">
		&nbsp;
		</td>
		<td  align="right">
		新模具号：
		</td>
		<td>
		<input type="text" name="new_mold_code" maxlength="6" onfocus="" id="" value="<%=new_mold_code %>" style="width: 70">
		</td>
		<td align="right">
		新规格：
		</td>
		<td>
		<input type="text" name="new_mold_spec" maxlength="10" onfocus="" id="" value="<%=new_mold_spec %>" style="width: 100">
		</td>  
		<td align="right">
		安装者：
		</td>
		<td>
		<input type="text" name="assembler" maxlength="12" onfocus="" id="" value="<%=assembler %>" style="width: 100"> 
		</td>
		<td align="right">
		安装时间：
		</td>
		<td>
		<input type="text" name="assembly_time" maxlength="12" onfocus="" id="date_start" value="<%=assembly_time %>" style="width: 100">&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;
		<input type="text" name="assembly_time_end" maxlength="12" onfocus="" id="date_start_end" value="<%=assembly_time_end %>" style="width: 100">
		</td>
			
		<td align="center">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>" >
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
                      {name: '<%=demo.getLang("erp","日期")%>'},
                            {name: '<%=demo.getLang("erp","机器号")%>'},
                       {name: '<%=demo.getLang("erp","模具号")%>'},
                  
     
                        {name: '<%=demo.getLang("erp","规格")%>'},
                         {name: '<%=demo.getLang("erp"," 导套号")%>'},
                          {name: '<%=demo.getLang("erp","累卷")%>'},
                             {name: '<%=demo.getLang("erp","拆卸者")%>'},
                    {name: '<%=demo.getLang("erp","安装者")%>'},
                                  {name: '<%=demo.getLang("erp","安装时间")%>'},
                                {name: '<%=demo.getLang("erp","更换原因")%>'},
                     
                       {name: '<%=demo.getLang("erp","新模具号")%>'},
                       {name: '<%=demo.getLang("erp","新规格")%>'},
                        {name: '<%=demo.getLang("erp","新导套号")%>'}
                 
                         
]
nseer_grid.column_width=[120,100,100,100,100,100,100,100,100,100,100,100];
nseer_grid.auto='<%=demo.getLang("erp","更换原因")%>';
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
['<%=rs1.getString("a.destruction_time")%>',
'<%=rs1.getString("a.mold_machine_number")%>',
'<%=rs1.getString("a.mold_code")%>',
'<%=rs1.getString("a.product_spec").replaceAll("HOCTO ","")%><%=rs1.getString("a.mold_spec")%>',
'<%=rs1.getString("a.lock_code")%>',
'<%=rs1.getString("a.destruction_item1_content")!=null?rs1.getString("a.destruction_item1_content"):""%>',
'<%=rs1.getString("a.destruction_man")%>',
'<%=rs1.getString("a.installer")%>', //安装者
'<%=rs1.getString("a.installation_time")%>',//安装者时间

'<%=rs1.getString("a.destruction_remark")!=null?rs1.getString("a.destruction_remark"):""%>',
'<%=rs1.getString("b.mold_code")%>',

'<%=rs1.getString("b.product_spec").replaceAll("HOCTO ","")%><%=rs1.getString("b.mold_spec")%>',
'<%=rs1.getString("b.lock_code")%>'


],
 
<%k++;%>
</page:pages>
['']];
nseer_grid.init();  
function init_div(){
	var height=document.getElementById("nseergrid").style.height;
	
	document.getElementById("nseergrid").style.height=parseInt(height)-60;
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
Calendar.setup ({inputField : "installation_time", ifFormat : "%Y-%m-%d", showsTime : false, button : "installation_time", singleClick : true, step : 1});
Calendar.setup ({inputField : "installation_time_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "installation_time_end", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "destruction_time", ifFormat : "%Y-%m-%d", showsTime : false, button : "destruction_time", singleClick : true, step : 1});
Calendar.setup ({inputField : "destruction_time_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "destruction_time_end", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_start_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start_end", singleClick : true, step : 1});

</script>
  