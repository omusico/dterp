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

<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>

<%nseer_db security_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_file.xml"/>

<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<script src="../../javascript/table/movetable.js"></script>

<%
String tablename="hr_file";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and license_tag='0'";
String queue="order by register_time";
String validationXml="../../xml/hr/hr_file.xml";
String nickName="人力资源档案";
String fileName="register_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的人力资源档案总数：");
String txtPager="";
String txtPerson="";
String my_sql_search="select * from hr_file where  check_tag='1' and license_tag='0' ";
if(request.getParameter("txtPager")!=null&&request.getParameter("txtPager").length()!=0){
	txtPager=request.getParameter("txtPager");
	my_sql_search+=" and idcard like '%"+request.getParameter("txtPager")+"%'";
}if(request.getParameter("txtPerson")!=null&&request.getParameter("txtPerson").length()!=0){
	txtPerson=request.getParameter("txtPerson");
	my_sql_search+=" and human_name like '%"+request.getParameter("txtPerson")+"%'";
}
my_sql_search+="order by register_time desc";
%>
<form  name="search_form" id="search_form" action="register_list.jsp" method="post">
<table width="100%" style="text-align: right;" align="center">
  <tr>
  	<td width="40%">&nbsp;</td>
  	<td style="text-align: right;">
    	员工编号：<input type="text" name="txtPager" value="<%=txtPager %>" />
    
    	姓名：<input type="text" name="txtPerson" value="<%=txtPerson %>" />
    	<input type="hidden" name="searchId" value="45"  />
    	</td><td style="text-align: right;width: 6%">
    	<input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>">
    </td>
  </tr>
</table>
</form>

<%@include file="../../include/search_my.jsp"%>
<%
ResultSet rs = security_db.executeQuery(my_sql_search) ;
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
					   {name: '<%=demo.getLang("erp","员工编号")%>'},
                       {name: '<%=demo.getLang("erp","姓名")%>'},
                       {name: '<%=demo.getLang("erp","部门")%>'},
					   {name: '<%=demo.getLang("erp","发放")%>'}
]
nseer_grid.column_width=[280,200,170,470];
nseer_grid.auto='<%=demo.getLang("erp","部门")%>';
nseer_grid.data = [

<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<%if(request.getParameter("txtPager")!=null){%>
['<div style="text-decoration : underline;color:#3366FF;font-size:14px" onclick=id_link("query.jsp?human_ID=<%=rs.getString("idcard")%>")><%=rs.getString("idcard")%></div>','<%=exchange.toHtml(rs.getString("human_name"))%>','<%=exchange.toHtml(rs.getString("chain_name"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("register_choose.jsp?human_ID=<%=rs.getString("human_ID")%>&&human_name=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("human_name")))%>")><%=demo.getLang("erp","发放")%></div>'],
<%}%>
</page:pages>

['']];

nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
security_db.close();
%>
<%@include file="../../include/head_msg.jsp"%>