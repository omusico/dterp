<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.exchange,java.text.*,include.get_name_from_ID.getNameFromID"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%isPrint isPrint=new isPrint(request);%>
<script language="javascript" src="../../javascript/include/div/divViewChange.js"></script>
<script language=javascript src="../../javascript/winopen/winopenm.js"></script>
<script type="text/javascript" src="../../javascript/qcs/crm_deliver/crmDeliver.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script language="javascript" src="../../javascript/include/div/divDisappear.js"></script>
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../dwr/interface/Multi.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<%
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
String dealwith_time=formatter.format(now);
String handler=(String)session.getAttribute("realeditorc");
String handler_id=(String)session.getAttribute("human_IDD");
String qcs_id=request.getParameter("qcs_id");
try{
	String sql = "select id,apply_id,stock_id,stock_name,product_id,product_name,qcs_amount,qcs_time,quality_way,quality_solution,sampling_standard,sampling_amount,accept,reject,qualified,unqualified,register,register_time,qcs_result,attachment1,remark from qcs_crm_deliver where qcs_id='"+qcs_id+"' and check_tag='1'";
	ResultSet rs = qcs_db.executeQuery(sql) ;
    if(rs.next()){
    String id=rs.getString("id");
    String apply_id=rs.getString("apply_id");
    String stock_name=rs.getString("stock_name");
    String stock_id=rs.getString("stock_id");
    String product_id=rs.getString("product_id");
    String product_name=rs.getString("product_name");
    String qcs_amount=rs.getString("qcs_amount");
    String qcs_time=rs.getString("qcs_time");
    String quality_way=rs.getString("quality_way");
    String quality_solution=rs.getString("quality_solution");
    String sampling_standard=rs.getString("sampling_standard");
    String sampling_amount=rs.getString("sampling_amount");
    String accept=rs.getString("accept");
    String reject=rs.getString("reject");
    String qualified=rs.getString("qualified");
    String unqualified=rs.getString("unqualified");
    String register=rs.getString("register");
    String register_time=rs.getString("register_time");
    String qcs_result=rs.getString("qcs_result");
    String attachment1=rs.getString("attachment1");
    String remark=rs.getString("remark");
%>
<%String table_width1="820px";%>
<body onload="locateSelectDiv()">
<form id="crmDeliver_dealwith" METHOD="POST">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8"><%
 sql="select type_name,describe2 from qcs_config_public_char where kind_id='07' and describe1='3' and used_tag='1' order by describe1";
 rs = qcs_db.executeQuery(sql);
 int a=1;
 while(rs.next()){
 String checked="";
 if(a==1){checked="checked";}else{checked="";}
 %><input type="radio" name="dealwith_tag" value="<%=rs.getString("describe2")%>" <%=checked%>><%=demo.getLang("erp",rs.getString("type_name"))%>&nbsp;&nbsp;&nbsp;
 <% a++;}%><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确定")%>" onClick="showFormSubmit('dealwith');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></td>
 </tr>
 </table>
 <div id="nseerGround" class="nseerGround">
 <%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","发货质检单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="qcs_id" name="qcs_id" type="text" width="100%" value="<%=qcs_id%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检申请单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="apply_id" name="apply_id" type="text" width="100%" value="<%=apply_id%>" readonly /></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","产品编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_id" name="product_id" type="text" width="100%" value="<%=product_id%>" readonly /></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","产品名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="product_name" name="product_name" type="text" width="100%" value="<%=product_name%>" readonly /></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检数量")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="qcs_amount" name="qcs_amount" type="text" width="37%" value="<%=qcs_amount%>" readonly /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="qcs_time" name="qcs_time" type="text" width="37%" value="<%=qcs_time%>" readonly/></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检方式")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="quality_way" name="quality_way" type="text" width="37%" value="<%=quality_way%>" readonly /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检方案")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="quality_solution" name="quality_solution" type="text" width="37%" value="<%=quality_solution%>" readonly/></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","抽样标准")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="sampling_standard" name="sampling_standard" type="text" width="37%" value="<%=sampling_standard%>" readonly/></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","抽样数量")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="sampling_amount" name="sampling_amount" type="text" width="37%" value="<%=sampling_amount%>" readonly /></td>
 </tr>
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","允收数")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="accept" name="accept" type="text" width="37%" value="<%=accept%>" readonly /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","拒收数")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="reject" name="reject" type="text" width="37%" value="<%=reject%>"  readonly/></td>
 </tr>
   <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","合格数")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="qualified" name="qualified" type="text" width="37%" value="<%=qualified%>" /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","不合格数")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="unqualified" name="unqualified" type="text" width="37%" value="<%=unqualified%>" /></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","库房")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="stock_name" name="stock_name" type="text" width="37%" value="<%=stock_name%>" readonly/><input id="stock_id" name="stock_id" type="hidden" value="<%=stock_id%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"></td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr>
 <td>
 <div style="overflow:scroll;width:100%;height:200px;">
<table <%=TABLE_STYLE5%> style="width:200%;border-collapse: collapse;border: 1px solid;" id="bill_body">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="item" name="item"><%=demo.getLang("erp","质检项目")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="default_basis" name="default_basis"><%=demo.getLang("erp","首选质检依据")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="ready_basis" name="ready_basis"><%=demo.getLang("erp","备选质检依据")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="quality_method" name="quality_method"><%=demo.getLang("erp","质检方法")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="analyse_method" name="analyse_method"><%=demo.getLang("erp","分析方法")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="standard_value" name="standard_value"><%=demo.getLang("erp","标准值")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="standard_max" name="standard_max"><%=demo.getLang("erp","标准上限")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="standard_min" name="standard_min"><%=demo.getLang("erp","标准下限")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="quality_value" name="quality_value"><%=demo.getLang("erp","质检值")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="sampling_amount_d" name="sampling_amount_d"><%=demo.getLang("erp","抽样数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="qualified_d" name="qualified_d"><%=demo.getLang("erp","合格数")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="unqualified_d" name="unqualified_d"><%=demo.getLang("erp","不合格数")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="quality_result" name="quality_result"><%=demo.getLang("erp","质检结果")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%" id="unqualified_reason" name="unqualified_reason"><%=demo.getLang("erp","不合格原因")%></td>
 </tr>
</table>
<script>
<%
sql="select * from qcs_crm_deliver_details where qcs_id='"+qcs_id+"' order by details_number";
rs=qcs_db.executeQuery(sql);
int i=1;
while(rs.next()){
%>
	addRow('bill_body');
	var table_obj=document.getElementById('bill_body');
	document.getElementById(table_obj.rows[0].cells[0].id+'<%=i%>').value='<%=rs.getString("item")%>';
   	document.getElementById(table_obj.rows[0].cells[1].id+'<%=i%>').value='<%=rs.getString("default_basis")%>';
    document.getElementById(table_obj.rows[0].cells[2].id+'<%=i%>').value='<%=rs.getString("ready_basis")%>';
    document.getElementById(table_obj.rows[0].cells[3].id+'<%=i%>').value='<%=rs.getString("quality_method")%>';
    document.getElementById(table_obj.rows[0].cells[4].id+'<%=i%>').value='<%=rs.getString("analyse_method")%>';
    document.getElementById(table_obj.rows[0].cells[5].id+'<%=i%>').value='<%=rs.getString("standard_value")%>';
    document.getElementById(table_obj.rows[0].cells[6].id+'<%=i%>').value='<%=rs.getString("standard_max")%>';
    document.getElementById(table_obj.rows[0].cells[7].id+'<%=i%>').value='<%=rs.getString("standard_min")%>';    
    document.getElementById(table_obj.rows[0].cells[8].id+'<%=i%>').value='<%=rs.getString("quality_value")%>';
    document.getElementById(table_obj.rows[0].cells[9].id+'<%=i%>').value='<%=rs.getString("sampling_amount_d")%>';
    document.getElementById(table_obj.rows[0].cells[10].id+'<%=i%>').value='<%=rs.getString("qualified_d")%>';
    document.getElementById(table_obj.rows[0].cells[11].id+'<%=i%>').value='<%=rs.getString("unqualified_d")%>';
    document.getElementById(table_obj.rows[0].cells[12].id+'<%=i%>').value='<%=rs.getString("quality_result")%>';
    document.getElementById(table_obj.rows[0].cells[13].id+'<%=i%>').value='<%=rs.getString("unqualified_reason")%>';
<%
i++;
}
%>
</script>
</div>
</td>
</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","质检结果")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="qcs_result" name="qcs_result" type="text" width="37%" onclick="loadAjaxDiv('qcs_result','14');this.blur();" value="<%=qcs_result%>" readonly/><div class="select_div_l" id="qcs_result_div"  onclick="loadAjaxDiv('qcs_result','14')"></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="register" name="register" type="text" width="37%" value="<%=register%>" readonly /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记时间")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="register_time" name="register_time" type="text" width="37%" value="<%=register_time%>" readonly /></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","处理人")%>&nbsp;&nbsp;：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="handler" name="handler" type="text" width="37%" value="<%=handler%>" readonly /><input id="handler_id" name="handler_id" type="hidden" value="<%=handler_id%>" readonly /></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","处理时间")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" id="dealwith_time" name="dealwith_time" type="text" width="37%" value="<%=dealwith_time%>" readonly /></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","备注")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark" /><%=remark%></textarea></td>
</tr>
 <%=isPrint.hasOrNot3d(attachment1,"附件&nbsp;&nbsp;&nbsp;","1",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,FILE_STYLE1,id,"qcs_crm_deliver")%>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
</form>
<script type="text/javascript">
Calendar.setup ({inputField : "qcs_time", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
<%
}
	qcs_db.close();
}catch (Exception ex){
//out.println("error"+ex);
}
%>
