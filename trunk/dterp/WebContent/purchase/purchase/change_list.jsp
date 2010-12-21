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
<%nseer_db purchase_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/purchase/purchase_details.xml"/>
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
String tablename="purchase_details";
String register_ID=(String)session.getAttribute("human_IDD");
String realname=(String)session.getAttribute("realeditorc");
String condition="qcs_dealwith_tag='2' and change_tag='0'";
String queue="order by purchase_id";
String validationXml="../../xml/purchase/purchase_details.xml";
String nickName="采购执行单明细";
String fileName="change_list.jsp";
String rowSummary=demo.getLang("erp","当前等待结算变更的采购执行单总数");
int k=1;
%>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs= purchase_db.executeQuery(sql_search) ;
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
                       {name: '<%=demo.getLang("erp","采购执行单编号")%>'},
                       {name: '<%=demo.getLang("erp","供应商编号")%>'},
                       {name: '<%=demo.getLang("erp","供应商名称")%>'},
                       {name: '<%=demo.getLang("erp","数量")%>'},
	                   {name: '<%=demo.getLang("erp","变更")%>'}
]
nseer_grid.column_width=[180,180,200,100,70];
nseer_grid.auto='<%=demo.getLang("erp","供应商名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
['<%=rs.getString("purchase_ID")%>','<%=rs.getString("provider_id")%>','<%=exchange.toHtml(rs.getString("provider_name"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs.getDouble("demand_amount"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("change.jsp?purchase_id=<%=rs.getString("purchase_id")%>&&provider_id=<%=rs.getString("provider_id")%>")><%=demo.getLang("erp","变更")%></div>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
purchase_db.close();
%>
<%@include file="../../include/head_msg.jsp"%>