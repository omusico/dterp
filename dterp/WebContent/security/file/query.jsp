<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*,include.nseer_cookie.*"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_file.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<script language="javascript" src="../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/calendar/calendar-win2k-cold-1.css">
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/input_control/focus.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css"
	href="../../css/include/nseerTree/nseertree.css" />
<link rel="stylesheet" type="text/css"
	href="../../css/include/nseer_cookie/xml-css.css" />
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"> <div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%
String human_ID=request.getParameter("human_ID");
try{
	String sql = "select * from hr_file where human_ID='"+human_ID+"'" ;
	ResultSet rs = hr_db.executeQuery(sql) ;
	if(rs.next()){
		String major_change_time=rs.getString("change_time");
		if(major_change_time.equals("1800-01-01 00:00:00.0")){
			major_change_time=rs.getString("register_time");
		}
		String lately_change_time=rs.getString("change_time");
		if(lately_change_time.equals("1800-01-01 00:00:00.0")){
			lately_change_time="没有变更";
		}
		String birthday=rs.getString("birthday");
		if(birthday.equals("1800-01-01")){
			birthday="";
		}
%>
<style>
body {
	font-family: Arial,"宋体";
	font-size:9pt;
}
td { font-size:12px;;
}
.mousehand{
	cursor:hand;
}
	

table.TabBarLevel1 td{
 border:0px solid #CCCCCC;
 height:20px;
 background-color:#66ccff;
}


table.TabBarLevel1 td.Selected{
 border-bottom-width:0px;
 background-color:orange;
}
table.TabBarLevel1 td.Black{
 border-left-width:0px;
 border-top-width:0px;
 border-right-width:0px;
 background-color:#eeeeee;
}

table.Content{
 border-left:1px solid #CCCCCC;
 border-right:1px solid #CCCCCC;
 border-bottom:1px solid #CCCCCC;
}
</style>
<body>
<%-- 
<body onload="changeTab('nseer0')">
--%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td style="text-align: right;">
&nbsp;
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"> 
 </td>
 </tr>
</table>
<%@include file="../../include/cDefineMouT.jsp"%>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1">
 <tr style="background-image:url(../../images/line.gif)">
		<td colspan="4">
		<div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp", "用户信息")%></div>
		</td>
	</tr>
 <tr>
 <td <%=TD_STYLE4%> class="TD_STYLE1" ><%=demo.getLang("erp", "员工编码")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2"  >
		<input type="hidden" name="idcard" value="<%=rs.getString("idcard")%>">
		
<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rs.getString("idcard")%>" style="width: 45%" onFocus="this.blur()">
		</td>
 
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "性别")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
			<input type="hidden" name="sex" value="<%=rs.getString("sex")%>">
		    
		    <input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rs.getString("sex")%>" style="width: 45%" onFocus="this.blur()">
		    </td>
	</tr>
	<tr>
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><%=demo.getLang("erp", "姓名")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
			<input type="hidden" name="human_name" value="<%=rs.getString("human_name")%>">
			
			<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=exchange.toHtml(rs.getString("human_name"))%>" style="width: 45%" onFocus="this.blur()">
			</td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><span align="left" class="style16"><%=demo.getLang("erp", "职位分类")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
			<input type="hidden" name="select4" value="<%=rs.getString("human_major_first_kind_id")%>">
			
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rs.getString("human_major_first_kind_name")%>" style="width: 45%" onFocus="this.blur()">
		    </td>
	</tr>
	<tr>
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><%=demo.getLang("erp", "电话")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
			<input type="hidden" name="human_tel" value="<%=rs.getString("human_tel")%>">
		    
		    <input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rs.getString("human_tel")%>" style="width: 28%" onFocus="this.blur()">
		    -<input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_home_tel" style="width:14%" onFocus="this.blur()" value="<%=rs.getString("human_home_tel")%>">
			
		    </td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" >
		    <span align="left" class="style16"><%=demo.getLang("erp", "职位名称")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
			<input type="hidden" name="select5" value="<%=rs.getString("human_major_second_kind_id")%>">
		    
		 <input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rs.getString("human_major_second_kind_name") %>" style="width: 45%" onFocus="this.blur()">
		</select></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><%=demo.getLang("erp", "手机")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
		    <input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1"  name="human_cellphone" style="width:45%" onFocus="this.blur()" value="<%=rs.getString("human_cellphone")%>">
			
		</td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><%=demo.getLang("erp", "EMAIL")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2"  ><input
			 <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" style="width:45%" name="human_email" onFocus="this.blur()" value="<%=rs.getString("human_email")%>"></td>
	</tr>    
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "部门")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">
			<input type="hidden" name="oldKind_chain" value="<%=rs.getString("chain_id")%> <%=exchange.toHtml(rs.getString("chain_name"))%>">
			<input type="hidden" name="kind_chain" value="<%=rs.getString("chain_id")%> <%=exchange.toHtml(rs.getString("chain_name"))%>">
			<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rs.getString("chain_id")%> <%=exchange.toHtml(rs.getString("chain_name"))%>" style="width: 45%" onFocus="this.blur()">
		    </td>
		
	</tr>
	<div id="hiddenfield" style="display: block">
	<tr style="background-image:url(../../images/line.gif)">
		<td colspan="4">
		<div style="width:100%; height:12; padding:3px;"><%=demo.getLang("erp", "未通过原由")%></div>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1" >
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><%=demo.getLang("erp", "未通过原由")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2"  colspan="3"><textarea
			<%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" readonly="readonly" name="demand" id="demand"><%=rs.getString("C_DEFINE12") %></textarea>
		</td>
	</tr>
	</div>
<%
String nickName="人力资源档案";%>
<%@include file="../../include/cDefineMouQ.jsp"%>
 </table>
  </div>
<div id="nseer4" style="display:none">
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE7">
<%@include file="../../include/cDefineMouQ.jsp"%>
 </table>
</div>
<%
}else{
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该员工档案尚不存在，请返回。")%></td>
 </tr>
</table>
<%
	 }
hr_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>
</div>