<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" import="java.util.*" import="java.io.*"
	import="include.nseer_db.*,include.nseerdb.*,java.text.*,include.nseer_cookie.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：",
			"document_main", "reason", "value");
		nseer_db hr_db = new nseer_db((String) session.getAttribute("unit_db_name"));
		nseer_db hrdb = new nseer_db((String) session.getAttribute("unit_db_name"));
		String human_ID = request.getParameter("human_ID");
%>
<jsp:useBean id="vt" scope="page" class="validata.ValidataTag" />
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script language="javascript"
	src="../../javascript/ajax/ajax-validation-f.js"></script>
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/input_control/focus.css">
<script type="text/javascript"
	src="../../javascript/include/validate/validation-framework.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript'
	src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
 
<script type="text/javascript">
<!--
 var onecount2;
 //职位id 1，second_kind_ID/second_kind_name 2，first_kind_ID/first_kind_name 3
 subcat2 = new Array();
 <% int k=0;
 String sql8="select * from hr_config_major_second_kind where second_kind_name!='' order by first_kind_ID,second_kind_ID";
 ResultSet rs8=hr_db.executeQuery(sql8); 
 while(rs8.next()) {%> 
 subcat2[<%=k++%>] = new 
 Array("<%=rs8.getString("id")%>","<%=rs8.getString("second_kind_ID")%>/<%=rs8.getString("second_kind_name")%>","<%=rs8.getString("first_kind_ID")%>/<%=rs8.getString("first_kind_name")%>");
 <%
	 }
 %> 
  onecount2=<%=k%>;//职位数量 
 function changelocation2(locationid){
  mutiValidation.select5.length = 0;  
  var locid=locationid;
  var k;
  //mutiValidation.select5.options[mutiValidation.select5.length]=new Option("",""); 
  for (k=0;k < onecount2; k++)
  {
 		 if(locid==""||locid==null){mutiValidation.select5.options[mutiValidation.select5.length]=
 			 new Option(subcat2[k][1],subcat2[k][1]);}//如果select1为空，则select5选择全部值
  else if (subcat2[k][2] == locid)
  { 
   mutiValidation.select5.options[mutiValidation.select5.length] = new Option(subcat2[k][1], 
 subcat2[k][1]);
  } 
  } 
 }
//-->
//表单提交
function validateFormPerson()
{
	var personNumber = document.getElementById("idcard").value;//员工编号
	var personName = document.getElementById("validator_dup").value;//姓名
	var personPhone = document.getElementById("human_tel").value;//电话
	var personJiGou = document.getElementById("kind_chain").value;//部门

	var personZhiFen = document.getElementById("select4").value;//职位分类
	var personZhiMing = document.getElementById("select5").value;//职位名称
	var personEmail = document.getElementById("human_email").value;//EMALL
	var human_home_tel=document.getElementById("human_home_tel").value;//分机
	var human_cellphone=document.getElementById("human_cellphone").value;//手机
	var a=/^1[3,5,8]{1}[0-9]{1}[0-9]{8}$/;

		
		
	
	

	if(personName.length==0){
		alert("姓名不能为空！");
		return false;
	}else if(personPhone.length==0&&human_cellphone.length==0){
		alert("请输入电话号码或手机号码！");
		return false;
	}else if(human_cellphone.length>0&&!a.test(human_cellphone)){
		alert("手机号码格式不正确！");
		return false;
	}else if(personJiGou.length==0){
		alert("部门不能为空！");
		return false;
	}else if(personZhiFen.length==0){
		alert("职位分类不能为空！");
		return false;
	}else if(personZhiMing.length==0){
		alert("职位名称不能这空！");
		return false;
	}else if(personEmail.length==0){
		alert("EMALL不能为空！");
		return false;
	}else if(!(personEmail.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1)){
		alert("电子邮件格式不正确！");
		return false;
	}else if(personPhone.length>0){
		if(validateCommonTel(mutiValidation.human_tel)){
			alert("电话号码格式不正确！");
			return false;
		}
	}else{
		return true;
	}
}
</script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<%
	String changer = (String) session.getAttribute("realeditorc");
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	String time = formatter.format(now);

		try {
			String sqll = "select * from hr_file where human_ID='"
			+ human_ID + "'";
			ResultSet rss = hrdb.executeQuery(sqll);
			while (rss.next()) {
		String history_records = exchange.unHtml(rss
				.getString("history_records"));
		String family_membership = exchange.unHtml(rss
				.getString("family_membership"));
		String remark = exchange
				.unHtml(rss.getString("remark"));
		String check_tag = exchange
		.unHtml(rss.getString("check_tag"));
		String birthday = rss.getString("birthday");
		if (birthday.equals("1800-01-01"))
			birthday = "";
%>
<div id="nseerGround" class="nseerGround">
<form class="x-form" id="mutiValidation" method="POST"
	action="../../hr_file_change_picture"
	onSubmit="return validateFormPerson()">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit"
			<%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1"
			value="<%=demo.getLang("erp","提交")%>" name="B1"> <input
			type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"
			value="<%=demo.getLang("erp","返回")%>" onClick="history.back()">
		</td>
	</tr>
</table>
<div style="position:absolute;">
<%-- 
<div style="display:block; position:absolute; z-index:10;right:30px; top:43px;">
<a href="javascript:winopen('query_picture.jsp?picture=<%=exchange.toHtml(rss.getString("picture"))%>')">
<img src="../human_pictures/<%=exchange.toHtml(rss.getString("picture"))%>" width="120" height="145"></a></div>
--%>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
	<tr style="background-image:url(../../images/line.gif)">
		<td colspan="5">
		<div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp", "用户信息")%></div>
		</td>
	</tr>
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_address" type="hidden" style="width:80%" value="<%=exchange.toHtml(rss.getString("human_address"))%>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_title_class" type="hidden" style="width:80%" value="<%=rss.getString("human_title_class")%>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_postcode" type="hidden" style="width:80%" value="<%=exchange.toHtml(rss.getString("human_postcode"))%>">
	
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="age" type="hidden" style="width:80%" value="<%=exchange.toHtml(rss.getString("age"))%>">
	<!--  <input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="idcard" type="hidden" style="width:80%" value="<%=exchange.toHtml(rss.getString("idcard"))%>"> -->
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="salary_standard" type="hidden" style="width:80%" value="<%=rss.getString("salary_standard_ID")%>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="nationality" type="hidden" style="width:80%" value="<%=rss.getString("nationality") %>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="birthplace" type="hidden" style="width:80%" value="<%=exchange.toHtml(rss.getString("birthplace"))%>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="birthday" type="hidden" style="width:80%" value="<%=exchange.toHtml(birthday)%>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="race" type="hidden" style="width:80%" value="<%=rss.getString("race") %>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="religion" type="hidden" style="width:80%" value="<%=rss.getString("religion") %>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="party" type="hidden" style="width:80%" value="<%=rss.getString("party") %>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="SIN" type="hidden" style="width:80%" value="<%=rss.getString("educated_degree") %>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="educated_degree" type="hidden" style="width:80%" value="<%=rss.getString("educated_degree") %>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="educated_years" type="hidden" style="width:80%" value="<%=rss.getString("educated_years") %>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="educated_major" type="hidden" style="width:80%" value="<%=rss.getString("educated_major") %>">

	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_bank" type="hidden" style="width:80%" value="<%=exchange.toHtml(rss.getString("human_bank"))%>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_account" type="hidden" style="width:80%" value="<%=exchange.toHtml(rss.getString("human_account"))%>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="register" type="hidden" style="width:80%" value="<%=exchange.toHtml(rss.getString("register"))%>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="hobby" type="hidden" style="width:80%" value="<%=rss.getString("hobby") %>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="speciality" type="hidden" style="width:80%" value="<%=rss.getString("speciality") %>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="register_time" type="hidden" style="width:80%" value="<%=exchange.toHtml(time)%>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="history_records" type="hidden" style="width:80%" value="<%=history_records%>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="family_membership" type="hidden" style="width:80%" value="<%=family_membership%>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="remark" type="hidden" style="width:80%" value="<%=remark%>">
	<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="check_tag" type="hidden" style="width:80%" value="<%=check_tag%>">
	<input name="change_time" type="hidden" value="<%=exchange.toHtml(time)%>">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "档案编号")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
		<input name="human_ID" type="hidden" value="<%=rss.getString("human_ID")%>">
		
		<input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="" type="text" value="<%=rss.getString("human_ID")%>" style="width: 49%" onFocus="this.blur()">
		&nbsp;</td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><font color=red>*</font><%=demo.getLang("erp", "部门")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
			<input <%=INPUT_STYLE5%> class="INPUT_STYLE5" id="kind_chain" name="kind_chain"
		    onFocus="showKind('nseer1',this,showTree)" onkeyup="search_suggest(this.id)" autocomplete="off" type="text" value="<%=rss.getString("chain_id")%> <%=exchange.toHtml(rss.getString("chain_name"))%>" style="width: 49%">
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE4%> class="TD_STYLE1" ><font color=red>*</font><%=demo.getLang("erp", "员工编号")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" ><input  onFocus="this.blur()"
			 <%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" id="idcard" name="idcard"
			style="width:49%"
			value="<%=exchange.toHtml(rss.getString("idcard"))%>"></td>
		
			<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "性别")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select
			 <%=INPUT_STYLE5%> class="INPUT_STYLE5" id="sex" name="sex" style="width:49%">
			<%String sex1 = rss.getString("sex"); %>
			<option <%=sex1.equals("男")?"selected":"" %>>男</option>
			<option <%=sex1.equals("女")?"selected":"" %>>女</option>
		</select></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp", "姓名")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input id="validator_dup"
			 <%=INPUT_STYLE5%> class="INPUT_STYLE5" type="text" name="human_name"
			style="width:49%"
			value="<%=exchange.toHtml(rss.getString("human_name"))%>"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><font color=red>*</font><%=demo.getLang("erp", "职位分类")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
		 <select  <%=INPUT_STYLE5%> class="INPUT_STYLE5" id="select4" name="select4" style="width:49%"
			onChange="changelocation2(mutiValidation.select4.options[mutiValidation.select4.selectedIndex].value)">
			<%
				String zf = rss.getString("human_major_first_kind_name");
				String sql4 = "select * from hr_config_major_first_kind order by first_kind_ID";
				ResultSet rs4 = hr_db.executeQuery(sql4);
				while (rs4.next()) {
					String fzf = exchange.toHtml(rs4.getString("first_kind_name"));
			%>
			<option <%=zf.equals(fzf)?"selected":"" %>
				value="<%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%>"><%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%></option>
			<%
			}
			%>
		    </select>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><%=demo.getLang("erp", "电话")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" ><input id="human_tel"
			 <%=INPUT_STYLE5%> class="INPUT_STYLE5" type="text" name="human_tel" style="width:30%"
			value="<%=exchange.toHtml(rss.getString("human_tel"))%>">
			-<input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" id="human_home_tel" name="human_home_tel" value="<%=exchange.toHtml(rss.getString("human_home_tel"))%>"
			style="width:16%" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
			
			</td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><font color=red>*</font><%=demo.getLang("erp", "职位名称")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
		<select  <%=INPUT_STYLE5%> class="INPUT_STYLE5" onchange="chcekValue(this)" id="select5" name="select5" style="width:49%">
			<script language="JavaScript">
			//if (mutiValidation.select1.value){ 如果select1没做出选择时，想让select2的值为空，则加上这个条件
			  changelocation2(mutiValidation.select4.value)
		    //}
            </script>
		</select>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><%=demo.getLang("erp", "手机")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" >
		    <input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" id="human_cellphone" name="human_cellphone" style="width:49%" value="<%=exchange.toHtml(rss.getString("human_cellphone"))%>">
			<font color=red>*</font>电话或者手机必须填一个。
		</td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><font color=red>*</font><%=demo.getLang("erp", "EMAIL")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2"  ><input
			 <%=INPUT_STYLE5%> class="INPUT_STYLE5" type="text" style="width:49%" id="human_email" name="human_email" value="<%=exchange.toHtml(rss.getString("human_email"))%>"></td>
	</tr>
	
	<div id="hiddenfield" style="display: block">
	<tr style="background-image:url(../../images/line.gif)">
		<td colspan="4">
		<div style="width:100%; height:12; padding:3px;"><%=demo.getLang("erp", "未通过原由")%></div>
		</td>
	</tr>
	<tr class="TR_STYLE1" >
		<td <%=TD_STYLE4%> class="TD_STYLE1" ><%=demo.getLang("erp", "未通过原由")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2"  colspan="3"><textarea
			<%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" readonly="readonly" name="demand" id="demand"><%=rss.getString("C_DEFINE12") %></textarea>
		</td>
	</tr>
	</div>		

	<%--
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp", "姓名")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_name"
			style="width:49%"
			value="<%=exchange.toHtml(rss.getString("human_name"))%>"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "性别")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select
			<%=SELECT_STYLE1%> class="SELECT_STYLE1" name="sex" style="width:49%">
			<%
			if (rss.getString("sex").equals("男")) {
			%>
			<option selected>男</option>
			<option>女</option>
			<%
			} else {
			%>
			<option>男</option>
			<option selected>女</option>
			<%
			}
			%>
		</select></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp", "机构")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rss.getString("chain_id")%>&nbsp;<%=exchange.toHtml(rss.getString("chain_name"))%></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "职位分类")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange
												.toHtml(rss
														.getString("human_major_first_kind_name"))%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "职位名称")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange
												.toHtml(rss
														.getString("human_major_second_kind_name"))%></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "职称")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select
			<%=SELECT_STYLE1%> class="SELECT_STYLE1" name="human_title_class"
			style="width:49%">
			<%
					String sql5 = "select * from hr_config_public_char where kind='职称' order by id";
					ResultSet rs5 = hr_db.executeQuery(sql5);
					while (rs5.next()) {
						if (rs5.getString("type_name").equals(
						rss.getString("human_title_class"))) {
			%>
			<option value="<%=exchange.toHtml(rs5.getString("type_name"))%>"
				selected><%=exchange.toHtml(rs5
												.getString("type_name"))%></option>
			<%
			} else {
			%>
			<option value="<%=exchange.toHtml(rs5.getString("type_name"))%>"><%=exchange.toHtml(rs5
												.getString("type_name"))%></option>
			<%
					}
					}
			%>
		</select></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp", "EMAIL")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_email"
			style="width:49%"
			value="<%=exchange.toHtml(rss.getString("human_email"))%>">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "薪酬标准")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select
			<%=SELECT_STYLE1%> class="SELECT_STYLE1" name="salary_standard"
			style="width:49%">
			<option value="未定义/未定义/0"><%=demo.getLang("erp", "未定义/0")%></option>
			<%
					String sql7 = "select * from hr_salary_standard order by standard_ID";
					ResultSet rs7 = hr_db.executeQuery(sql7);
					while (rs7.next()) {
						if (rs7.getString("standard_ID").equals(
						rss.getString("salary_standard_ID"))) {
			%>
			<option
				value="<%=rs7.getString("standard_ID")%>/<%=exchange.toHtml(rs7.getString("standard_name"))%>/<%=rs7.getString("salary_sum")%>"
				selected><%=exchange.toHtml(rs7
												.getString("standard_name"))%>/<%=rs7.getString("salary_sum")%></option>
			<%
			} else {
			%>
			<option
				value="<%=rs7.getString("standard_ID")%>/<%=exchange.toHtml(rs7.getString("standard_name"))%>/<%=rs7.getString("salary_sum")%>"><%=exchange.toHtml(rs7
												.getString("standard_name"))%>/<%=rs7.getString("salary_sum")%></option>
			<%
					}
					}
			%>
		</select>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><font color=red>*</font><%=demo.getLang("erp", "电话")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_tel"
			style="width:49%"
			value="<%=exchange.toHtml(rss.getString("human_tel"))%>"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "手机")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text"
			name="human_cellphone" style="width:49%"
			value="<%=exchange.toHtml(rss.getString("human_cellphone"))%>">
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "年龄")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="age"
			style="width:49%" value="<%=exchange.toHtml(rss.getString("age"))%>"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "身份证号码")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="idcard"
			style="width:49%"
			value="<%=exchange.toHtml(rss.getString("idcard"))%>"></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "住址")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text"
			name="human_address" style="width:49%"
			value="<%=exchange.toHtml(rss.getString("human_address"))%>"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "邮编")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text"
			name="human_postcode" style="width:49%"
			value="<%=exchange.toHtml(rss.getString("human_postcode"))%>">
	</tr>
	<tr style="background-image:url(../../images/line.gif)">
		<td colspan="5">
		<div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp", "辅助信息")%></div>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "国籍")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select
			<%=SELECT_STYLE1%> class="SELECT_STYLE1" name="nationality"
			style="width:49%">
			<%
					String sql18 = "select * from hr_config_public_char where kind='国籍' order by id";
					ResultSet rs18 = hr_db.executeQuery(sql18);
					while (rs18.next()) {
						if (rs18.getString("type_name").equals(
						rss.getString("nationality"))) {
			%>
			<option value="<%=exchange.toHtml(rs18.getString("type_name"))%>"
				selected><%=exchange.toHtml(rs18
												.getString("type_name"))%></option>
			<%
			} else {
			%>
			<option value="<%=exchange.toHtml(rs18.getString("type_name"))%>"><%=exchange.toHtml(rs18
												.getString("type_name"))%></option>
			<%
					}
					}
			%>

		</select></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "出生地")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="birthplace"
			style="width:49%"
			value="<%=exchange.toHtml(rss.getString("birthplace"))%>"></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "生日")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="birthday"
			style="width:49%" value="<%=exchange.toHtml(birthday)%>"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "民族")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select
			<%=SELECT_STYLE1%> class="SELECT_STYLE1" name="race"
			style="width:49%">
			<%
					String sql9 = "select * from hr_config_public_char where kind='民族' order by id";
					ResultSet rs9 = hr_db.executeQuery(sql9);
					while (rs9.next()) {
						if (rs9.getString("type_name").equals(
						rss.getString("race"))) {
			%>
			<option value="<%=exchange.toHtml(rs9.getString("type_name"))%>"
				selected><%=exchange.toHtml(rs9
												.getString("type_name"))%></option>
			<%
			} else {
			%>
			<option value="<%=exchange.toHtml(rs9.getString("type_name"))%>"><%=exchange.toHtml(rs9
												.getString("type_name"))%></option>
			<%
					}
					}
			%>

		</select></td>

	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "宗教信仰")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select
			<%=SELECT_STYLE1%> class="SELECT_STYLE1" name="religion"
			style="width:49%">
			<%
					String sql10 = "select * from hr_config_public_char where kind='宗教信仰' order by id";
					ResultSet rs10 = hr_db.executeQuery(sql10);
					while (rs10.next()) {
						if (rs10.getString("type_name").equals(
						rss.getString("religion"))) {
			%>
			<option value="<%=exchange.toHtml(rs10.getString("type_name"))%>"
				selected><%=exchange.toHtml(rs10
												.getString("type_name"))%></option>
			<%
			} else {
			%>
			<option value="<%=exchange.toHtml(rs10.getString("type_name"))%>"><%=exchange.toHtml(rs10
												.getString("type_name"))%></option>
			<%
					}
					}
			%>

		</select></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "政治面貌")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select
			<%=SELECT_STYLE1%> class="SELECT_STYLE1" name="party"
			style="width:49%">
			<%
					String sql11 = "select * from hr_config_public_char where kind='政治面貌' order by id";
					ResultSet rs11 = hr_db.executeQuery(sql11);
					while (rs11.next()) {
						if (rs11.getString("type_name").equals(
						rss.getString("party"))) {
			%>
			<option value="<%=exchange.toHtml(rs11.getString("type_name"))%>"
				selected><%=exchange.toHtml(rs11
												.getString("type_name"))%></option>
			<%
			} else {
			%>
			<option value="<%=exchange.toHtml(rs11.getString("type_name"))%>"><%=exchange.toHtml(rs11
												.getString("type_name"))%></option>
			<%
					}
					}
			%>
		</select></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "社会保障号码")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="SIN"
			style="width:49%" value="<%=exchange.toHtml(rss.getString("SIN"))%>"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "学历")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select
			<%=SELECT_STYLE1%> class="SELECT_STYLE1" name="educated_degree"
			style="width:49%">
			<%
					String sql12 = "select * from hr_config_public_char where kind='学历' order by id";
					ResultSet rs12 = hr_db.executeQuery(sql12);
					while (rs12.next()) {
						if (rs12.getString("type_name").equals(
						rss.getString("educated_degree"))) {
			%>
			<option value="<%=exchange.toHtml(rs12.getString("type_name"))%>"
				selected><%=exchange.toHtml(rs12
												.getString("type_name"))%></option>
			<%
			} else {
			%>
			<option value="<%=exchange.toHtml(rs12.getString("type_name"))%>"><%=exchange.toHtml(rs12
												.getString("type_name"))%></option>
			<%
					}
					}
			%>

		</select></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "教育年限")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select
			<%=SELECT_STYLE1%> class="SELECT_STYLE1" name="educated_years"
			style="width:49%">
			<%
					String sql13 = "select * from hr_config_public_char where kind='教育年限' order by id";
					ResultSet rs13 = hr_db.executeQuery(sql13);
					while (rs13.next()) {
						if (rs13.getString("type_name").equals(
						rss.getString("educated_years"))) {
			%>
			<option value="<%=exchange.toHtml(rs13.getString("type_name"))%>"
				selected><%=exchange.toHtml(rs13
												.getString("type_name"))%></option>
			<%
			} else {
			%>
			<option value="<%=exchange.toHtml(rs13.getString("type_name"))%>"><%=exchange.toHtml(rs13
												.getString("type_name"))%></option>
			<%
					}
					}
			%>

		</select></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "学历专业")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select
			<%=SELECT_STYLE1%> class="SELECT_STYLE1" name="educated_major"
			style="width:49%">
			<%
					String sql14 = "select * from hr_config_public_char where kind='学历专业' order by id";
					ResultSet rs14 = hr_db.executeQuery(sql14);
					while (rs14.next()) {
						if (rs14.getString("type_name").equals(
						rss.getString("educated_major"))) {
			%>
			<option value="<%=exchange.toHtml(rs14.getString("type_name"))%>"
				selected><%=exchange.toHtml(rs14
												.getString("type_name"))%></option>
			<%
			} else {
			%>
			<option value="<%=exchange.toHtml(rs14.getString("type_name"))%>"><%=exchange.toHtml(rs14
												.getString("type_name"))%></option>
			<%
					}
					}
			%>

		</select></td>

	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "QQ")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text"
			name="human_home_tel" style="width:49%"
			value="<%=exchange.toHtml(rss.getString("human_home_tel"))%>"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "开户行")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="human_bank"
			style="width:49%"
			value="<%=exchange.toHtml(rss.getString("human_bank"))%>"></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "账号")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text"
			name="human_account" style="width:49%"
			value="<%=exchange.toHtml(rss.getString("human_account"))%>"></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "变更人")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			<%=INPUT_STYLE1%> class="INPUT_STYLE1" type="text" name="changer"
			style="width:49%" value="<%=exchange.toHtml(changer)%>"></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "变更时间")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><input
			name="change_time" style="width:49%" type="hidden"
			value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "特长")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select
			<%=SELECT_STYLE1%> class="SELECT_STYLE1" name="speciality"
			style="width:49%">
			<%
					String sql15 = "select * from hr_config_public_char where kind='特长' order by id";
					ResultSet rs15 = hr_db.executeQuery(sql15);
					while (rs15.next()) {
						if (rs15.getString("type_name").equals(
						rss.getString("speciality"))) {
			%>
			<option value="<%=exchange.toHtml(rs15.getString("type_name"))%>"
				selected><%=exchange.toHtml(rs15
												.getString("type_name"))%></option>
			<%
			} else {
			%>
			<option value="<%=exchange.toHtml(rs15.getString("type_name"))%>"><%=exchange.toHtml(rs15
												.getString("type_name"))%></option>
			<%
					}
					}
			%>

		</select></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "爱好")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><select
			<%=SELECT_STYLE1%> class="SELECT_STYLE1" name="hobby"
			style="width:49%">
			<%
					String sql16 = "select * from hr_config_public_char where kind='爱好' order by id";
					ResultSet rs16 = hr_db.executeQuery(sql16);
					while (rs16.next()) {
						if (rs16.getString("type_name").equals(
						rss.getString("hobby"))) {
			%>
			<option value="<%=exchange.toHtml(rs16.getString("type_name"))%>"
				selected><%=exchange.toHtml(rs16
												.getString("type_name"))%></option>
			<%
			} else {
			%>
			<option value="<%=exchange.toHtml(rs16.getString("type_name"))%>"><%=exchange.toHtml(rs16
												.getString("type_name"))%></option>
			<%
					}
					}
			%>

		</select></td>
		<%
						String[] attachment_name1 = DealWithString.divide(rss
						.getString("attachment_name"), 20);
		%>
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp", "档案附件")%>
		</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><a
			href="javascript:winopenm('query_attachment.jsp?id=<%=rss.getString("id")%>&tablename=hr_file&fieldname=attachment_name')">
		<%=exchange.toHtml(attachment_name1[1])%></a>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE7" height="65" width="11%"><%=demo.getLang("erp", "个人履历")%>
		&nbsp;</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><textarea
			<%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="history_records"><%=history_records%></textarea>
		</td>
		<td <%=TD_STYLE4%> class="TD_STYLE7" height="65" width="11%"><%=demo.getLang("erp", "家庭关系信息")%>
		&nbsp;</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><textarea
			<%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="family_membership"><%=family_membership%></textarea>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE4%> class="TD_STYLE7" height="65" width="11%"><%=demo.getLang("erp", "备注")%>
		&nbsp;</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><textarea
			<%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
		</td>
		<td <%=TD_STYLE4%> class="TD_STYLE7" width="11%" height="65">&nbsp;</td>
		<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">&nbsp;</td>
	</tr>
	--%>
	<jsp:useBean id="mask" class="include.operateXML.Reading" />
	<jsp:setProperty name="mask" property="file" value="xml/hr/hr_file.xml" />
	<%
			ResultSet rs = rss;
			String nickName = "人力资源档案";
	%>
	<%@include file="../../include/cDefineMouC.jsp"%>
	<input name="lately_change_time" type="hidden"
		value="<%=exchange.toHtml(rss.getString("change_time"))%>">
	<input name="file_change_amount" type="hidden"
		value="<%=rss.getString("file_change_amount")%>">
</table>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>"
	value="<%=session.getAttribute(Globals.TOKEN_KEY)%>"></form>
<%
			}
			hrdb.close();
			hr_db.close();
		} catch (Exception ex) {
			out.println("error" + ex);
		}

%> 

<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script></div>
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script language="javascript"
	src="../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css"
	href="../../css/include/nseerTree/nseertree.css" />
<link rel="stylesheet" type="text/css"
	href="../../css/include/nseer_cookie/xml-css.css" />
<link rel="stylesheet" type="text/css" media="all"
	href="../../javascript/input_control/focus.css">
 <script type="text/javascript" src="../../javascript/validateFormCommon.js"></script>
<script type='text/javascript'
	src='../../javascript/include/div/alert.js'></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/NseerTreeDB.js'></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type='text/javascript'
	src="../../javascript/include/nseerTree/nseertree.js"></script>
<script type='text/javascript'
	src='../../javascript/include/div/divViewChange.js'></script>
<script type="text/javascript"
	src="../../javascript/include/validate/validation-framework.js"></script>
<script type='text/javascript'
	src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript'
	src='../../javascript/include/covers/cover.js'></script>
<script type='text/javascript' src='../../dwr/interface/kindCounter.js'></script>
<script type="text/javascript"
	src="../../javascript/include/validate/validation-framework.js"></script>
<script type='text/javascript'
	src="../../javascript/include/nseer_cookie/toolTip.js"></script>
<script type='text/javascript'
	src="../../javascript/hr/file/treeBusiness.js"></script>
<script type="text/javascript"
	src="../../javascript/hr/file/register.js"></script>
<script type="text/javascript"
	src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<script type='text/javascript'
	src='../../javascript/include/div/divLocate.js'></script>
	<!-- 实现放大镜加AJAX的JS  -->
<div id="nseer1" nseerDef="dragAble"
	style="position:absolute;left:300px;top:100px;display:none;width:450px;height:300px;overflow:hidden;z-index:1;background:#E8E8E8;">
<iframe src="javascript:false"
	style="position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe>
<TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
	<TBODY>
		<TR>
			<TD width="1%" height="1%"><IMG src="../../images/bg_0ltop.gif"></TD>
			<TD width="100%" background="../../images/bg_01.gif"></TD>
			<TD width="1%" height="1%"><IMG src="../../images/bg_0rtop.gif"></TD>
		</TR>
		<TR>
			<TD background="../../images/bg_03.gif"></TD>
			<TD>
			<div class="cssDiv1">
			<div class="cssDiv2"><%=demo.getLang("erp", "上海慧索计算机科技ERP")%></div>
			</div>
			<div class="cssDiv3" onclick="n_D.closeDiv('hidden')"
				onmouseover="n_D.mmcMouseStyle(this);"></div>
			<div id="expand" class="cssDiv4" onclick="n_D.maxDiv()"
				onmouseover="n_D.mmcMouseStyle(this);"></div>
			<div id="collapse" class="cssDiv5" onclick="n_D.minDiv(40)"
				onmouseover="n_D.mmcMouseStyle(this);"></div>
			<div id="nseer1_0"
				style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;">
			</div>
			</TD>
			<TD background="../../images/bg_04.gif"></TD>
		</TR>
		<TR>
			<TD width="1%" height="1%"><IMG
				src="../../images/bg_0lbottom.gif"></TD>
			<TD background="../../images/bg_02.gif"></TD>
			<TD width="1%" height="1%"><IMG
				src="../../images/bg_0rbottom.gif"></TD>
		</TR>
	</TBODY>
</TABLE>
</div>
<script>
var Nseer_tree1;
function showTree(){
 if(Nseer_tree1=='undefined'||typeof(Nseer_tree1)=='object'){return;}
 Nseer_tree1 = new Tree('Nseer_tree1');
 Nseer_tree1.setParent('nseer1_0');
 Nseer_tree1.setImagesPath('../../images/');
 Nseer_tree1.setTableName('hr_config_file_kind');
 Nseer_tree1.setModuleName('../../xml/hr/file');
 Nseer_tree1.addRootNode('No0','<%=demo.getLang("erp","全部分类")%>',false,'1',[]);
initMyTree(Nseer_tree1);
createButton('../../xml/hr/file','hr_config_file_kind','treeButton');
}
</script>