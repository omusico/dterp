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
<jsp:useBean id="query" scope="page" class="include.query.query_three"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/qcs/qcs_item.xml"/>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 
<%
String tablename="qcs_item";
String realname=(String)session.getAttribute("realeditorc");
String condition="excel_tag='2' and gar_tag='0'";
String queue="order by register_time";
String validationXml="../../xml/qcs/qcs_item.xml";
String nickName="质检项目";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的质检项目总数：");
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%@include file="../../include/search.jsp"%>
<%nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%try{
ResultSet rs=qcs_db.executeQuery(sql_search);
int k=1;
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">"+DgButton.getGar(tablename,request);
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
					   {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","项目编号")%>'},
                       {name: '<%=demo.getLang("erp","项目名称")%>'},
                       {name: '<%=demo.getLang("erp","制定人")%>'},
                       {name: '<%=demo.getLang("erp","分析方法")%>'},
					   {name: '<%=demo.getLang("erp","首选质检依据")%>'},
                       {name: '<%=demo.getLang("erp","质检方法")%>'},
                       {name: '<%=demo.getLang("erp","质检设备")%>'},
					   {name: '<%=demo.getLang("erp","抽样标准")%>'},
					   {name: '<%=demo.getLang("erp","审核状态")%>'}
]
nseer_grid.column_width=[40,180,100,100,100,70,70,90,200,70];
nseer_grid.auto='<%=demo.getLang("erp","项目名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<%	
String check_tag="";
String execute_tag="";
String fund_pre_tag="";
String color="#FF9A31";
if(rs.getString("check_tag").equals("9")){
check_tag="审核未通过";
color="red";
}else if(rs.getString("check_tag").equals("0")){
check_tag="等待审核";
}else if(rs.getString("check_tag").equals("1")){
check_tag="审核通过";
color="3333FF";
}
%>
['<%if(rs.getString("check_tag").equals("1")){%><input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs.getString("id")%>⊙<%=rs.getString("used_tag")%>" style="height:10"><%}%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?item_id=<%=rs.getString("item_id")%>")><%=rs.getString("item_id")%></div>','<%=exchange.toHtml(rs.getString("item_name"))%>','<%=exchange.toHtml(rs.getString("designer"))%>','<%=exchange.toHtml(rs.getString("analyse_method"))%>','<%=exchange.toHtml(rs.getString("default_basis"))%>','<%=exchange.toHtml(rs.getString("quality_method"))%>','<%=exchange.toHtml(rs.getString("quality_equipment"))%>','<%=exchange.toHtml(rs.getString("sampling_standard"))%>','<span style="color:<%=color%>"><%=check_tag%></span>'],
<%k++;%>
</page:pages>
['']];
nseer_grid.init();
</script>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%qcs_db.close();}catch(Exception ex){}%>