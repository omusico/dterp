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
 	function openSearch(ag,av,audOrder){
 		window.location.href="search_detail.jsp?id="+ag+"&proId="+av+"&audOrder=CK"+audOrder;
 	}
 	function openSearch1(ag,av,audOrder){
 		window.location.href="search_detail1.jsp?id="+ag+"&proId="+av+"&audOrder=CS"+audOrder;
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
String txtPagerNumber="";
String txtPerson="";
String txtTime="";
String txtLoginPager="";
String txtLoginTime="";
try{
String register_ID=(String)session.getAttribute("human_IDD");
int workflow_amount=0;
String sql="select count(id) from design_config_workflow where type_id='03'";
ResultSet rs1=design_db.executeQuery(sql);
if(rs1.next()){
	workflow_amount=rs1.getInt("count(id)");
}
String my_sql_search = "select * from stock_out inner join stock_out_apply on stock_out_apply.id = stock_out.stock_out_apply_id inner join hr_file on hr_file.idcard=stock_out.stock_out_operator_id where 1=1 ";

if(request.getParameter("txtPager")!=null&&request.getParameter("txtPager").length()!=0){
	txtPager=request.getParameter("txtPager");
	my_sql_search+=" and stock_out.stock_out_id like '%"+request.getParameter("txtPager")+"%'";;
}if(request.getParameter("txtPagerNumber")!=null&&request.getParameter("txtPagerNumber").length()!=0){
	txtPagerNumber=request.getParameter("txtPagerNumber");
	my_sql_search+=" and stock_out_apply.apply_out_id like '%"+request.getParameter("txtPagerNumber")+"%'";
}if(request.getParameter("txtPerson")!=null&&request.getParameter("txtPerson").length()!=0){
	txtPerson=request.getParameter("txtPerson");
	my_sql_search+=" and hr_file.HUMAN_NAME like '%"+request.getParameter("txtPerson")+"%'";
}if(request.getParameter("txtTime")!=null&&request.getParameter("txtTime").length()!=0){
	txtTime=request.getParameter("txtTime");
	my_sql_search+="and stock_out_time like '%"+request.getParameter("txtTime")+"%'";
}if(request.getParameter("txtLoginPager")!=null&&request.getParameter("txtLoginPager").length()!=0){
	txtLoginPager=request.getParameter("txtLoginPager");
	my_sql_search+="and  stock_out_checker like '%"+request.getParameter("txtLoginPager")+"%'";
}if(request.getParameter("txtLoginTime")!=null&&request.getParameter("txtLoginTime").length()!=0){
	txtLoginTime=request.getParameter("txtLoginTime");
	my_sql_search+="and stock_out_check_time like '%"+request.getParameter("txtLoginTime")+"%'";
}
	my_sql_search+=" order by stock_out_time desc";
%>
<%@include file="../../include/search_my.jsp"%>
<%
rs1 = design_db.executeQuery(sql_search) ;
%>
<form  name="search_form" id="search_form" action="query_list.jsp" method="post">
<table width="100%" style="text-align: right;">
  <tr>
  	
  	<td>
    	出库单号：<input type="text" name="txtPager"  value="<%=txtPager %>"/>
    </td>
    <td>
    	出库申请单号：<input type="text" name="txtPagerNumber"  value="<%=txtPagerNumber %>"/>
    </td>
     <td>
    	出库人：<input type="text" name="txtPerson"  value="<%=txtPerson %>"/>
    </td>
     <td>
    	出库时间：
    		<input type="text" name="txtTime" onkeydown="javascript:this.value='';" onkeyup="javascript:this.value='';" id="date_start" value="<%=txtTime %>"/>
    </td>
    <td>
    	&nbsp;
    </td>
  </tr>
  <tr>
  	<td>
    	审核人：<input type="text" name="txtLoginPager"  value="<%=txtLoginPager %>"/>
    </td>
     <td>
    	审核时间：<input type="text" name="txtLoginTime" onkeydown="javascript:this.value='';" onkeyup="javascript:this.value='';" id="date_end" value="<%=txtLoginTime %>"/>
    </td>
     <td>
    	&nbsp;
    </td>
   <td>
    	&nbsp;
    </td>
    <td>
    	<input type="hidden" name="searchId" value="45"  />
    	<input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>">
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
					   {name: '<%=demo.getLang("erp","出库单号")%>'},
					   {name: '<%=demo.getLang("erp","出库申请单号")%>'},
					   {name: '<%=demo.getLang("erp","出库理由")%>'},
					   {name: '<%=demo.getLang("erp","经办人")%>'},
					   {name: '<%=demo.getLang("erp","出库时间")%>'},
					   {name: '<%=demo.getLang("erp","审核人")%>'},
                       {name: '<%=demo.getLang("erp","审核时间")%>'},
                       {name: '<%=demo.getLang("erp","总件数")%>'},
                       {name: '<%=demo.getLang("erp","审核状态")%>'},
                       {name: '<%=demo.getLang("erp","出库状态")%>'}
]
nseer_grid.column_width=[105,102,102,100,100,100,100,100,100,320];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%
String sql_1= "SELECT * FROM stock_config_public_char where id="+rs1.getInt("stock_out_reason_id");
String id ="";
String rk = "";
String sh = "已出库";
ResultSet rsr = stock_db1.executeQuery(sql_1);
if(rsr.next()){
	id = rsr.getString("STOCK_NAME");
}
if(rs1.getString("stock_out_check_status").equals("0")){
	rk = "未审核";
}else{
	rk = "已审核";
}
if(request.getParameter("searchId")!=null){
	String outTime = rs1.getString("stock_out_time");
	outTime = outTime.substring(0,10);
	
	String CK = rs1.getString("stock_out_apply.apply_out_id");
	CK = CK.substring(2,CK.length());
	String CS = rs1.getString("stock_out_id");
	CS = CS.substring(2,CS.length());
%>
['<div style="text-decoration : underline;color:#3366FF;font-size:14px" onclick="openSearch1(<%=rs1.getString("id")%>,<%=rs1.getString("stock_out_reason_id")%>,<%=CK%>)"><%=rs1.getString("stock_out_id")%></div>',
'<div style="text-decoration : underline;color:#3366FF;font-size:14px" onclick="openSearch(<%=rs1.getString("stock_out.stock_out_apply_id")%>,<%=rs1.getString("stock_out_reason_id")%>,<%=CS%>)"><%=rs1.getString("stock_out_apply.apply_out_id")%></div>','<%=id%>','<%=rs1.getString("hr_file.human_name")%>','<%=exchange.toHtml(outTime)%>','<%=rs1.getString("stock_out_checker")%>','<%=rs1.getString("stock_out_check_time")%>','<%=exchange.toHtml(rs1.getString("stock_out_count"))%>',
'<%=rk%>',
'<%=sh%>'
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

