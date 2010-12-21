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
<%
try{
nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/qcs/qcs_sample.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<jsp:useBean id="query" scope="page" class="include.query.query_three"/>
<%
String tablename="qcs_sample";
String realname=(String)session.getAttribute("realeditorc");
String condition="excel_tag='2' and gar_tag='0'";
String queue="order by register_time desc";
String validationXml="../../xml/qcs/qcs_sample.xml";
String nickName="样品登记单";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","当前符合条件的样品登记单总数：");
int k=1;
%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs=qcs_db.executeQuery(sql_search);
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
                       {name: '<%=demo.getLang("erp","登记单编号")%>'},
                       {name: '<%=demo.getLang("erp","质检类型")%>'},
                       {name: '<%=demo.getLang("erp","质检申请单编号")%>'},
					   {name: '<%=demo.getLang("erp","取样人")%>'},
                       {name: '<%=demo.getLang("erp","取样时间")%>'},
                       {name: '<%=demo.getLang("erp","审核状态")%>'},
	                   {name: '<%=demo.getLang("erp","处理状态")%>'}
]
nseer_grid.column_width=[50,180,180,180,150,100,80,80];
nseer_grid.auto='<%=demo.getLang("erp","质检类型")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<%
String delete_tag="1";
String dealwith_tag="尚未处理";
String status="";
String check_tag="";
String color="#FF9A31";
String color1="#FF9A31";
if(rs.getString("check_tag").equals("0")){check_tag=demo.getLang("erp","未审核");}
else if(rs.getString("check_tag").equals("1")){
check_tag=demo.getLang("erp","审核通过");
color="3333FF";
}
if(rs.getString("dealwith_tag").equals("1")){
status=demo.getLang("erp","销毁");
delete_tag="0";
color1="3333FF";
}else if(rs.getString("dealwith_tag").equals("2")){
status=demo.getLang("erp","封存");
delete_tag="0";
color1="3333FF";
}else if(rs.getString("dealwith_tag").equals("3")){
status=demo.getLang("erp","检验中");
delete_tag="0";
color1="3333FF";
}
%>
['<%if(!rs.getString("dealwith_tag").equals("0")){%><input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs.getString("id")%>⊙<%=delete_tag%>" style="height:10"><%}%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?sample_id=<%=rs.getString("sample_id")%>")><%=rs.getString("sample_id")%></div>','<%=rs.getString("quality_type")%>','<%=rs.getString("apply_id")%>','<%=exchange.toHtml(rs.getString("sampling_person"))%>','<%=exchange.toHtml(rs.getString("sampling_time"))%>','<span style="color:<%=color%>"><%=status%></span>','<span style="color:<%=color1%>"><%=dealwith_tag%></span>'],
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
<%	
qcs_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>