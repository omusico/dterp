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
<%
String tablename="design_module";
String realname=(String)session.getAttribute("realeditorc");
String condition="";
String queue="";
String validationXml=".";
String nickName="产品物料组成设计";
String fileName="check_list.jsp";
String rowSummary=demo.getLang("erp","当前可变更的设计单总数：");
%>

<%
String txtPager="";
String txtPerson="";
String txtTime="";
try{
String register_ID=(String)session.getAttribute("human_IDD");
int workflow_amount=0;
String my_sql_search="select * from stock_in inner join stock_config_public_char on stock_config_public_char.id = stock_in.stock_in_reason_id inner join hr_file on stock_in.stock_in_operator_id=hr_file.idcard where stock_in_check_status=0";
if(request.getParameter("txtPager")!=null&&request.getParameter("txtPager").length()!=0){
	txtPager=request.getParameter("txtPager");
	my_sql_search+=" and stock_in_code like '%"+request.getParameter("txtPager")+"%'";;
}if(request.getParameter("txtPerson")!=null&&request.getParameter("txtPerson").length()!=0){
	txtPerson=request.getParameter("txtPerson");
	my_sql_search+=" and hr_file.HUMAN_NAME like '%"+request.getParameter("txtPerson")+"%'";
}if(request.getParameter("txtTime")!=null&&request.getParameter("txtTime").length()!=0){
	txtTime=request.getParameter("txtTime");
	my_sql_search+="and stock_in_time like '%"+request.getParameter("txtTime")+"%'";
}
	my_sql_search+=" order by stock_in_time desc";
%>
<%@include file="../../include/search_my.jsp"%>
<form  name="search_form" id="search_form" action="check_list.jsp" method="post">
<table width="100%" style="text-align: right;" align="center">
  <tr>
  	<td width="25%">&nbsp;</td>
  	<td>
    	入库单编号：<input type="text" name="txtPager"  value="<%=txtPager %>"/>
    </td>
     <td>
    	入库人：<input type="text" name="txtPerson"  value="<%=txtPerson %>"/>
    </td>
     <td>
    	入库时间:<input type="text" name="txtTime" onkeydown="javascript:this.value='';" onkeyup="javascript:this.value='';" id="date_start" value="<%=txtTime %>"/>
    </td>
    <td>
    	<input type="hidden" name="searchId" value="45"  />
    	<input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>">
    </td>
  </tr>
</table>
</form>
<script>
	//跳转入帐详细审核页面，传送入库单ID
	function onAuditing(ag,productId){
		window.location.href="auditing.jsp?order_id="+ag+"&proId="+productId;
	}
</script>

<%		ResultSet rs1 = design_db.executeQuery(sql_search); %>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
					   {name: '<%=demo.getLang("erp","入库单编号")%>'},
                       {name: '<%=demo.getLang("erp","入库理由")%>'},
             
                       {name: '<%=demo.getLang("erp","入库人")%>'},
                       {name: '<%=demo.getLang("erp","入库时间")%>'},
                       {name: '<%=demo.getLang("erp","总件数")%>'},
                       {name: '<%=demo.getLang("erp","入库状态")%>'},
                       {name: '<%=demo.getLang("erp","审核")%>'}
]
nseer_grid.column_width=[170,170,170,170,170,170,175,105];
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%if(request.getParameter("searchId")!=null){
	String joinTime = rs1.getString("stock_in.stock_in_time");
	joinTime = joinTime.substring(0,10);
%>
['<%=rs1.getString("stock_in.stock_in_code")%>',
'<%=rs1.getString("stock_config_public_char.STOCK_NAME")%>','<%=rs1.getString("hr_file.HUMAN_NAME")%>','<%=joinTime%>','<%=rs1.getString("stock_in.stock_in_count")%>','完成',
'<div style="text-decoration : underline;color:#3366FF" onclick="onAuditing(<%=rs1.getString("stock_in.id")%>,<%=rs1.getString("stock_in.stock_in_reason_id")%>)">审核</div>'
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
