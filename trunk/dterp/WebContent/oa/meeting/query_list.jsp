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
<%nseer_db oa_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="available" class="stock.getBalanceAmount" scope="request"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/oa/oa_meeting.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
</table>
<%
String tablename="oa_meeting";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag!='4'";
String queue="order by register_time desc";
String validationXml="../../xml/oa/oa_meeting.xml";
String nickName="会议";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的会议总数：");
%>
<%@include file="../../include/search.jsp"%>
<%try{
ResultSet rs=oa_db.executeQuery(sql_search);
%>

<%@include file="../../include/search_top.jsp"%>
<%
String status="";
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
                       {name: '<%=demo.getLang("erp","会议主题")%>'},
                       {name: '<%=demo.getLang("erp","会议类型")%>'},
                       {name: '<%=demo.getLang("erp","开始时间")%>'},
					   {name: '<%=demo.getLang("erp","结束时间")%>'},
					   {name: '<%=demo.getLang("erp","会议地点")%>'},
					   {name: '<%=demo.getLang("erp","会议状态")%>'}
]
nseer_grid.column_width=[200,100,140,140,70,70];
nseer_grid.auto='<%=demo.getLang("erp","会议地点")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<%	
	switch(rs.getInt("check_tag")){
	case 0:
		status="未通知";
	break;
	case 1:
		status="已通知";
	break;
	case 2:
		status="已整理纪要";
	break;
	case 3:
		status="已处理纪要";
	break;
}
%>	['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?meeting_ID=<%=rs.getString("meeting_ID")%>")><%=exchange.toHtml(rs.getString("subject"))%></div>','<%=exchange.toHtml(rs.getString("type"))%>','<%=exchange.toHtml(rs.getString("begin_time"))%>','<%=exchange.toHtml(rs.getString("end_time"))%>','<%=exchange.toHtml(rs.getString("place"))%>','<%=exchange.toHtml(status)%>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%oa_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>