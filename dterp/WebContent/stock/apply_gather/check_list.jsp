<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db stock_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>

<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript">
<!--
	function onkeyCheck(age){
		age.value="";
	}
//-->
</script>
<jsp:setProperty name="mask" property="file" value="xml/design/design_module.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>

<%
String tablename="design_module";
String realname=(String)session.getAttribute("realeditorc");
String condition="";
String queue="";
String validationXml=".";
String nickName="产品物料组成设计";
String fileName="check_list.jsp";
String rowSummary=demo.getLang("erp","当前可变更的设计单总数：");
%>

<%
try{
String register_ID=(String)session.getAttribute("human_IDD");
int workflow_amount=0;
String txtPager="";
String txtPerson="";
String txtLoginPerson="";
String txtTime="";
String my_sql_search="select * from stock_in_apply where apply_in_apply_check_status=0 ";
if(request.getParameter("txtPager")!=null&&request.getParameter("txtPager").length()!=0){
	txtPager=request.getParameter("txtPager");
	my_sql_search+=" and apply_in_apply_code like '%"+request.getParameter("txtPager")+"%'";
}if(request.getParameter("txtPerson")!=null&&request.getParameter("txtPerson").length()!=0){
	txtPerson=request.getParameter("txtPerson");
	my_sql_search+=" and apply_in_apply_operator like  '%"+request.getParameter("txtPerson")+"%'";
}if(request.getParameter("txtLoginPerson")!=null&&request.getParameter("txtLoginPerson").length()!=0){
	txtLoginPerson=request.getParameter("txtLoginPerson");
	my_sql_search+=" and apply_in_apply_register like '%"+request.getParameter("txtLoginPerson")+"%'";
}if(request.getParameter("txtTime")!=null&&request.getParameter("txtTime").length()!=0){
	txtTime=request.getParameter("txtTime");
	my_sql_search+="and apply_in_apply_register_time like '%"+request.getParameter("txtTime")+"%'";
}
	my_sql_search+="  order by apply_in_apply_register_time desc";
%>
<%@include file="../../include/search_my.jsp"%>

 <form  name="search_form" id="search_form" action="check_list.jsp" method="post">
<table width="100%" style="text-align: right;" align="center">
  <tr>
  	<td>
    	入库申请单编号：<input type="text" name="txtPager" value="<%=txtPager %>" />
    </td>
     <td>
    	经办人：<input type="text" name="txtPerson"  value="<%=txtPerson %>"/>
    </td>
     <td>
    	登记人：<input type="text" name="txtLoginPerson" value="<%=txtLoginPerson %>" />
    </td>
     <td>
    	登记时间：
    	<input type="text" name="txtTime" onkeydown="javascript:this.value='';" onkeyup="javascript:this.value='';" id="date_start" value="<%=txtTime %>" />
    </td>
    <td>
    	<input type="hidden" name="searchId" value="45"  />
    	<input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>">
    </td>
  </tr>
</table>
</form>

<script>
	//跳转入帐详细审核页面，传送入库单ID
	function onAuditing(ag,productId){
		window.location.href="auditing.jsp?order_id="+ag+"&proId="+productId;
	}
</script>
<%		ResultSet rs1 = design_db.executeQuery(sql_search); %>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
					   {name: '<%=demo.getLang("erp","入库申请单编号")%>'},
                       {name: '<%=demo.getLang("erp","入库申请理由")%>'},
                       {name: '<%=demo.getLang("erp","经办人")%>'},
                       {name: '<%=demo.getLang("erp","登记人")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'},
                       {name: '<%=demo.getLang("erp","总件数")%>'},
                       {name: '<%=demo.getLang("erp","审核")%>'}
]
nseer_grid.column_width=[165,155,135,135,155,105,325];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%
String sql_1= "SELECT * FROM stock_config_public_char where id="+rs1.getInt("apply_in_apply_reason_id");
String id ="";
ResultSet rsr = stock_db1.executeQuery(sql_1);
if(rsr.next()){
	id = rsr.getString("STOCK_NAME");
}
if(request.getParameter("searchId")!=null){
	String loginTime = rs1.getString("apply_in_apply_register_time");
	loginTime = loginTime.substring(0,10);
%>
['<%=rs1.getString("apply_in_apply_code")%>',
'<%=id%>','<%=rs1.getString("apply_in_apply_operator")%>','<%=rs1.getString("apply_in_apply_register")%>','<%=exchange.toHtml(loginTime)%>','<%=exchange.toHtml(rs1.getString("apply_in_apply_count"))%>',
'<div style="text-decoration : underline;color:#3366FF" onclick="onAuditing(<%=rs1.getString("id")%>,<%=rs1.getString("apply_in_apply_reason_id")%>)">审核</div>'
],<%}%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%if(request.getParameter("searchId")!=null){%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%}else{ %>
<page:updowntag num="0" file="<%=fileName%>"/>
<% }%>
<%design_db.close();
stock_db1.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
