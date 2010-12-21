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
 <script>
 	function openSearch(ag,productId){
 		window.location.href="change_detail.jsp?order_id="+ag+"&proId="+productId;
 	}
 </script>
<%
String tablename="design_module";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and excel_tag='2'";
String queue="order by register_time";
String validationXml="../../xml/design/design_module.xml";
String nickName="产品物料组成设计";
String fileName="change_list.jsp";
String rowSummary=demo.getLang("erp","当前可变更的设计单总数：");
%>
<%
String txtPager="";
String txtPerson="";
String txtLoginPerson="";
String txtTime="";
try{
String register_ID=(String)session.getAttribute("human_IDD");
int workflow_amount=0;
String sql="select count(id) from design_config_workflow where type_id='03'";
ResultSet rs1=design_db.executeQuery(sql);
if(rs1.next()){
	workflow_amount=rs1.getInt("count(id)");
}
String my_sql_search = "select * from stock_out_apply where apply_out_check_status!=1 ";
if(request.getParameter("txtPager")!=null&&request.getParameter("txtPager").length()!=0){
	txtPager=request.getParameter("txtPager");
	my_sql_search+=" and apply_out_id like '%"+request.getParameter("txtPager")+"%'";;
}if(request.getParameter("txtPerson")!=null&&request.getParameter("txtPerson").length()!=0){
	txtPerson=request.getParameter("txtPerson");
	my_sql_search+=" and apply_out_operator like '%"+request.getParameter("txtPerson")+"%'";
}if(request.getParameter("txtLoginPerson")!=null&&request.getParameter("txtLoginPerson").length()!=0){
	txtLoginPerson=request.getParameter("txtLoginPerson");
	my_sql_search+=" and apply_out_register like '%"+request.getParameter("txtLoginPerson")+"%'";
}if(request.getParameter("txtTime")!=null&&request.getParameter("txtTime").length()!=0){
	txtTime=request.getParameter("txtTime");
	my_sql_search+="and apply_out_register_time like '%"+request.getParameter("txtTime")+"%'";
}if(request.getParameter("plan_typeS")!=null&&request.getParameter("plan_typeS").length()!=0){
	if(request.getParameter("plan_typeS").equals("all")){
		
	}else{
		my_sql_search+=" and apply_out_check_status = '"+request.getParameter("plan_typeS")+"'";
	}
}
	my_sql_search+=" order by apply_out_register_time desc";
%>
<%@include file="../../include/search_my.jsp"%>
<form  name="search_form" id="search_form" action="change_list.jsp" method="post">
<table width="100%" style="text-align: right;" align="center">
  <tr>
  	<td>
    	出库申请单编号：<input type="text" name="txtPager" size="13" value="<%=txtPager %>"/>

    	经办人：<input type="text" name="txtPerson" size="13" value="<%=txtPerson %>"/>

    	登记人：<input type="text" name="txtLoginPerson" size="13" value="<%=txtLoginPerson %>"/>

    	登记时间：<input type="text" name="txtTime" onkeydown="javascript:this.value='';" onkeyup="javascript:this.value='';" id="date_start" size="13" value="<%=txtTime %>"/>
    	审核状态：
		  <select name="plan_typeS" style="width: 12%">
		  <%
		  if (request.getParameter("plan_typeS") != null&&request.getParameter("plan_typeS").length() > 0) {
				if(request.getParameter("plan_typeS").equals("1")){
		  %>
		  <option value="all">--------全部--------</option>
		  <option value="0">未审核</option>

		  <option value="2">审核未通过</option>

		  <%
				}else if(request.getParameter("plan_typeS").equals("2")){
		  %>
		  <option value="all">--------全部--------</option>
		  <option value="0">未审核</option>

		  <option value="2" selected="selected">审核未通过</option>
	
		  <%		
				}else if(request.getParameter("plan_typeS").equals("0")){
		  %>
		  <option value="all">------全部------</option>
		  <option value="0"  selected="selected">未审核</option>

		  <option value="2">审核未通过</option>
		 
		  <%			
				}else if(request.getParameter("plan_typeS").equals("all")){
		  %>
		  <option value="all" selected="selected">------全部------</option>
		  <option value="0">未审核</option>

		  <option value="2">审核未通过</option>
		 
		  <%			
				}
		  }else{
		  %>
		  <option value="all" selected="selected">------全部------</option>
		  <option value="0">未审核</option>

		  <option value="2">审核未通过</option>
		 
		  <%	
		  }
		  %>
		  
		  </select>
    </td>
    <td>
    	<input type="hidden" name="searchId" value="45"  />
    	<input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>">
    </td>
  </tr>
</table>
</form>
<%
rs1 = design_db.executeQuery(sql_search) ;
%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
					   {name: '<%=demo.getLang("erp","出库申请单编号")%>'},
                       {name: '<%=demo.getLang("erp","出库申请理由")%>'},
                       {name: '<%=demo.getLang("erp","经办人")%>'},
                       {name: '<%=demo.getLang("erp","登记人")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'},
                       {name: '<%=demo.getLang("erp","总件数")%>'},
                       {name: '<%=demo.getLang("erp","审核状态")%>'},
                       {name: '<%=demo.getLang("erp","执行状态")%>'},
                       {name: '<%=demo.getLang("erp","更改")%>'}
]
nseer_grid.column_width=[125,125,125,125,125,120,120,120,200];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%
String sql_1= "SELECT * FROM stock_config_public_char where id="+rs1.getInt("apply_out_reason_id");
String id ="";
String rk = "";
String sh = "";
ResultSet rsr = stock_db1.executeQuery(sql_1);
if(rsr.next()){
	id = rsr.getString("STOCK_NAME");
}
if(rs1.getString("apply_out_check_status").equals("0")){
	sh = "未审核";
}else if(rs1.getString("apply_out_check_status").equals("2")){
	sh = "审核未通过";
}

if(rs1.getString("apply_out_check_status").equals("0")){
	rk = "未执行";
}else{
	rk = "已执行";
}
if(request.getParameter("searchId")!=null){
	String outTime = rs1.getString("apply_out_register_time");
	outTime = outTime.substring(0,10);
%>
['<%=rs1.getString("apply_out_id")%>',
'<%=id%>','<%=rs1.getString("apply_out_operator")%>','<%=rs1.getString("apply_out_register")%>','<%=exchange.toHtml(outTime)%>','<%=exchange.toHtml(rs1.getString("apply_out_count"))%>',
'<%=sh%>',
'<%=rk%>',
'<div style="text-decoration : underline;color:#3366FF;" onclick="openSearch(<%=rs1.getString("id")%>,<%=rs1.getString("apply_out_reason_id")%>)">更改</div>'
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
