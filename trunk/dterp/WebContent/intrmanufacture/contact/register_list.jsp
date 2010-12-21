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
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/intrmanufacture/intrmanufacture_file.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%nseer_db intrmanufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
String tablename="intrmanufacture_file";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1'";
String queue="order by remind_contact_tag desc,lately_contact_time";
String validationXml="../../xml/intrmanufacture/intrmanufacture_file.xml";
String nickName="委外厂商档案";
String fileName="register_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的委外厂商档案总数：");
%>
<%@include file="../../include/search.jsp"%>
<% 
try{
ResultSet rs= intrmanufacture_db.executeQuery(sql_search) ;
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
function id_link1(provider_ID,provider_name,contact_person1,provider_tel1){
var link1='register_getpara.jsp?provider_ID='+provider_ID+'&&provider_name='+provider_name+'&&contact_person1='+contact_person1+'&&provider_tel1='+provider_tel1;
document.location.href=link1;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","委外厂商编号")%>'},
                       {name: '<%=demo.getLang("erp","委外厂商名称")%>'},
                       {name: '<%=demo.getLang("erp","优质级别")%>'},
	                   {name: '<%=demo.getLang("erp","产品分类")%>'},
	     			   {name: '<%=demo.getLang("erp","负责人")%>'},
	                   {name: '<%=demo.getLang("erp","登记")%>'}
]
nseer_grid.column_width=[200,100,100,100,100,70];
nseer_grid.auto='<%=demo.getLang("erp","委外厂商名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../file/query.jsp?provider_ID=<%=rs.getString("provider_ID")%>")><%=rs.getString("provider_ID")%></div>','<%=exchange.toHtml(rs.getString("provider_name"))%>','<%=exchange.toHtml(rs.getString("provider_class"))%>','<%=exchange.toHtml(rs.getString("chain_name"))%>','<%=exchange.toHtml(rs.getString("intrmanufacturer"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link1("<%=rs.getString("provider_ID")%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("provider_name")))%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("contact_person1")))%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("provider_tel1")))%>")><%=demo.getLang("erp","登记")%></div>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
intrmanufacture_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>