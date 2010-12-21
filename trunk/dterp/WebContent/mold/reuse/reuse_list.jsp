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
<%nseer_db mold_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db mold_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<script type="text/javascript">

function reuse(id)
{
var res=confirm("是否确认该操作？");
	if(res)
	{
		document.location.href="../../mold_reuse_ActionReuse.do?m=reuse&id="+id;
	}else
	{
		return false;
	}
	
}
</script>
<jsp:setProperty name="mask" property="file" value="xml/purchase/purchase_apply.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%

int i=0;
String mold_spec="";
String mold_code="";
String mold_machine_number="";
String assembler="";
String first_state="0";//0——第一次加载，1——再次加载
if(request.getParameter("mold_spec")!=null||request.getParameter("mold_code")!= null||request.getParameter("mold_machine_number")!= null){
	first_state="1";
}
String my_sql_search="SELECT * FROM mold_info where mold_life_status=6";
if(request.getParameter("mold_spec") != null&&request.getParameter("mold_spec").length() > 0||request.getParameter("mold_code") != null&&request.getParameter("mold_code").length() > 0||request.getParameter("mold_machine_number") != null&&request.getParameter("mold_machine_number").length() > 0||request.getParameter("assembler") != null&&request.getParameter("assembler").length() > 0)
{
	my_sql_search +=" having 1=1";
}
if(request.getParameter("mold_spec") != null&&request.getParameter("mold_spec").length() > 0)
{
	mold_spec=request.getParameter("mold_spec");
	my_sql_search += " and mold_spec like'%"+ request.getParameter("mold_spec") + "%' ";
	i =1;
}
if(request.getParameter("mold_code") != null&&request.getParameter("mold_code").length() > 0)
{
	if(i == 1)
	{
		mold_code=request.getParameter("mold_code");
		my_sql_search += " and mold_code like'%"+ request.getParameter("mold_code") + "%' ";
	}	
	else
	{
		mold_code=request.getParameter("mold_code");
		my_sql_search += " and mold_code like'%"+ request.getParameter("mold_code") + "%' ";
		i=1;
	}
}
if(request.getParameter("mold_machine_number") != null&&request.getParameter("mold_machine_number").length() > 0)
{
	if(i == 1)
	{
		mold_machine_number=request.getParameter("mold_machine_number");
		my_sql_search += " and mold_machine_number like'%"+ request.getParameter("mold_machine_number") + "%' ";
	}
	else
	{
		mold_machine_number=request.getParameter("mold_machine_number");
		my_sql_search += " and mold_machine_number like'%"+ request.getParameter("mold_machine_number") + "%' ";
		i=1;
	}
}
if(request.getParameter("assembler") != null&&request.getParameter("assembler").length() > 0)
{
	if(i == 1)
	{
		assembler=request.getParameter("assembler");
		my_sql_search += " and destruction_man like'%"+ request.getParameter("assembler") + "%' ";
	}
	else
	{
		assembler=request.getParameter("assembler");
		my_sql_search += " and destruction_man like'%"+ request.getParameter("assembler") + "%' ";
		i=1;
	}
}

String register_ID=(String)session.getAttribute("human_IDD");
String tablename="purchase_apply";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='0' and excel_tag='2'";
String queue="order by register_time";
String validationXml="../../xml/purchase/purchase_apply.xml";
String nickName="采购计划";
String fileName="reuse_list.jsp";
String rowSummary=demo.getLang("erp","当前等待审核的采购计划总数");
int k=0;
%>
<%@include file="../../include/search_my.jsp"%>
<%
try{
ResultSet rs1 = mold_db.executeQuery(sql_search); 	
int workflow_amount=0;
%>
<form action="reuse_list.jsp" method="post" name="search_form" id="search_form">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE6%> class="TD_STYLE6">
		  模具规格：<input type="text" name="mold_spec" onfocus="" id="" value="<%=mold_spec %>" style="width: 150">
		  模具编号：<input type="text" name="mold_code" onfocus="" id="" value="<%=mold_code %>" style="width: 150">
		  机器号：<input type="text" name=mold_machine_number onfocus="" id="" value="<%=mold_machine_number %>" style="width: 150">
		  拆卸者：<input type="text" name="assembler" onfocus="" id="" value="<%=assembler %>" style="width: 150">
		  <input type="submit" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>" >
		</td>
	</tr>
</table>
</form>
<div id="nseer_grid_div"></div>

<%-- --%>
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
                       {name: '<%=demo.getLang("erp","机器号")%>'},
                       {name: '<%=demo.getLang("erp","拆卸者")%>'},
                       {name: '<%=demo.getLang("erp","拆卸时间")%>'},
                       {name: '<%=demo.getLang("erp","再使用")%>'},
                       {name: '<%=demo.getLang("erp","&nbsp;")%>'}
]
nseer_grid.column_width=[200,100,100,100,150,150,150];
nseer_grid.auto='<%=demo.getLang("erp","&nbsp;")%>';
nseer_grid.data = [
<%if(first_state=="0"){rs1=null;}%>
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 

['<%=rs1.getString("mold_spec")%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?id=<%=rs1.getString("id")%>")><%=rs1.getString("mold_code")%></div>','<%=rs1.getString("mold_machine_number")%>','<%=rs1.getString("destruction_man")%>','<%=rs1.getString("destruction_time")%>','<div style="text-decoration : underline;color:#3366FF" onclick=reuse(<%=rs1.getString("id")%>)>再安装</div>'],

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
