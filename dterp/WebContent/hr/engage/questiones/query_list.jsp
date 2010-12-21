<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="query" scope="page" class="include.query.query_three"/>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_questiones.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
String tablename="hr_questiones";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='0' and excel_tag='2'";
String queue="order by register_time desc";
String validationXml="../../../xml/hr/hr_questiones.xml";
String nickName="试题";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的试题总数：");
%>
<%@include file="../../../include/search.jsp"%>
 <%
 try{
ResultSet rs= hr_db.executeQuery(sql_search);
%>
<%@include file="../../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","题干")%>'},
                       {name: '<%=demo.getLang("erp","试题I级分类")%>'},
                       {name: '<%=demo.getLang("erp","试题II级分类")%>'},
                       {name: '<%=demo.getLang("erp","登记人")%>'},
                       {name: '<%=demo.getLang("erp","登记日期")%>'},
					   {name: '<%=demo.getLang("erp","出处")%>'},
					   {name: '<%=demo.getLang("erp","正确答案")%>'}
]
nseer_grid.column_width=[200,100,100,100,160,100,100];
nseer_grid.auto='<%=demo.getLang("erp","题干")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?id=<%=rs.getString("id")%>")><%=rs.getString("content")%></div>','<%=exchange.toHtml(rs.getString("first_kind_name"))%>','<%=exchange.toHtml(rs.getString("second_kind_name"))%>','<%=exchange.toHtml(rs.getString("register"))%>','<%=exchange.toHtml(rs.getString("register_time"))%>','<%=exchange.toHtml(rs.getString("derivation"))%>','<%=exchange.toHtml(rs.getString("correctkey"))%>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../../include/search_bottom.jsp"%>
<%@include file="../../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
hr_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>