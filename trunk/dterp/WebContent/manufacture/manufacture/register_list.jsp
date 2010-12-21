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
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/manufacture/manufacture_apply.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
try{
String tablename="manufacture_apply";
String realname=(String)session.getAttribute("realeditorc");
String condition0="check_tag='1' and excel_tag='2' and manufacture_tag='0' and type!='委外部件'";
String queue="order by check_time";
String validationXml="../../xml/manufacture/manufacture_apply.xml";
String nickName="生产计划";
String fileName="register_list.jsp";
String rowSummary=demo.getLang("erp","当前等待派工的生产计划明细总数：");
String condition1="check_tag='1' and excel_tag='2' and manufacture_tag='0' and type!='委外部件'";
%>
<%@include file="../../include/search_a.jsp"%>
<%
String condition=condition1;
%>
<%@include file="../../include/search_bn.jsp"%>
<%
int intRowCount1 = query.count((String)session.getAttribute("unit_db_name"),sql_search.replace("*","distinct apply_ID"));
%>
<%
condition=condition0;
%>
<%@include file="../../include/search_b.jsp"%>
<%
ResultSet rs = manufacture_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"submit\" "+SUBMIT_STYLE1+" class=\"SUBMIT_STYLE1\" value=\""+demo.getLang("erp","生成派工单")+"\">";
%>
<form method="post" action="register.jsp">
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
					   {name: '<%=demo.getLang("erp","点选")%>'},
                       {name: '<%=demo.getLang("erp","计划单编号")%>'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
	                   {name: '<%=demo.getLang("erp","数量")%>'},
	                   {name: '<%=demo.getLang("erp","出库单编号集合")%>'},
	                   {name: '<%=demo.getLang("erp","审核时间")%>'}
]
nseer_grid.column_width=[40,180,180,180,100,180,160];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
String check_time="";
if(rs.getString("check_time").equals("1800-01-01 00:00:00.0")){
check_time="";
}else{
check_time=rs.getString("check_time");
}
%>
	['<input type="checkbox" name="choice" value=<%=rs.getString("id")%>>','<%=rs.getString("apply_ID")%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../../design/file/query.jsp?product_ID=<%=rs.getString("product_ID")%>")><%=rs.getString("product_ID")%></div>','<%=exchange.toHtml(rs.getString("product_name"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs.getDouble("amount"))%>','<%=rs.getString("pay_ID_group")%>','<%=exchange.toHtml(check_time)%>'
	],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
 </form>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
manufacture_db.close();
}catch(Exception e){e.printStackTrace();}	
%> 
<%@include file="../../include/head_msg.jsp"%>