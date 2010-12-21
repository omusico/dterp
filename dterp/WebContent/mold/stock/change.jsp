<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*,java.text.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db mold_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="OperateXML" class="include.nseer_cookie.OperateXML" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
	 %>
 <%@include file="../include/head.jsp"%>
<script>

function closediv(){
	var loaddiv=document.getElementById("loaddiv");
	loaddiv.style.display="none";
}
</script>

<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script language="javascript" src="../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<link rel="stylesheet" type="text/css" href="../../css/include/nseerTree/nseertree.css">
<script type='text/javascript' src="../../javascript/include/nseer_cookie/toolTip.js"></script>
<script type='text/javascript' src='../../javascript/include/div/divLocate.js'></script>

<!-- 控制 未通过理由 显示隐藏 -->
<script>
function changeRadio(vl){
	var demand=document.getElementById("demand");
	if (vl.value=="cop"){
		demand.value="";
		demand.className="INPUT_STYLE5";
	}else if(vl.value=="Ind"){
		demand.value="";
		demand.className="INPUT_STYLE1";
	}
}

</script>

<body>
<%
int id=Integer.parseInt(request.getParameter("id"));
try{
String sql1="SELECT * FROM mold_purchase_order_detail left join design_file on mold_purchase_order_detail.mold_spec_id=design_file.id where mold_purchase_order_detail.mold_id='"+id+"'";
ResultSet rs1 = mold_db.executeQuery(sql1); 
if(rs1.next())
{
String time="";
int mold_id=rs1.getInt("mold_id");
String operator=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
time=formatter.format(now);
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
String file1=path+"xml/design/design_file.xml";
List returnList=OperateXML.returnList(file1,"name","mutiValidation","name","name","required","n");
%>
<script language="javascript">
function TwoSubmit(form){
form.action = "change_ok.jsp?id=<%=exchange.unHtmls(Integer.toString(rs1.getInt("mold_purchase_order_detail.mold_id")))%>";
}
</script>
<div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%--@include file="../include/paper_top.html"--%>
<form id="mutiValidation" method="post" onSubmit="return TwoSubmit(this)">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE3%> class="TD_STYLE3">
		<div <%=DIV_STYLE1%> class="DIV_STYLE1">
		<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","变更")%>" name="B1">&nbsp;
		<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div>
		</td>
	</tr>
</table>

<table class="TABLE_STYLE4" border="0" align=center width="100%"> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","模具规格")%>：</td>  
 <td align=left class="TD_STYLE2" width="17%"><input readonly="readonly" name="" type="text" value="<%=rs1.getString("mold_spec")%>"   /></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","模具编号")%>：</td>
 <td align=left class="TD_STYLE2" width="17%"><input readonly="readonly" name="" type="text" value="<%=rs1.getString("mold_code")%>"   /></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","加工项目")%>：</td>
 <td align=left class="TD_STYLE2" width="17%"><input readonly="readonly" name="" type="text" 
 <% 
 if(rs1.getInt("mold_type")==0)
 {%>
 value="新品"
 <%} %> 
 <%
 if(rs1.getInt("mold_type")==1)
 {%>
 value="研磨品"
 <%} %> 
 <%
 if(rs1.getInt("mold_type")==2)
 {%>
 value="报废"
 <%} %> 
   /></td>
 <td align=right class="TD_STYLE3" width="25%">
 </td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","品名和规格")%>：</td>
 <td align=left class="TD_STYLE2" width="17%"><input readonly="readonly" name="" type="text" value="上模：<%=rs1.getString("spec_top")%>&nbsp;下模：<%=rs1.getString("spec_bottom")%>"  ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","图纸号")%>：</td>
 <td align=left class="TD_STYLE2" width="17%"><input readonly="readonly" name="" type="text" value="上模：<%=rs1.getString("drawing_top")%>&nbsp;下模：<%=rs1.getString("drawing_bottom")%>&nbsp;衬铁：<%=rs1.getString("drawing_lron")%>"  ></td>
 <td align=right class="TD_STYLE8" width="8%"><%=demo.getLang("erp","入库时间")%>：</td>
 <td align=left class="TD_STYLE2" width="17%"><input readonly="readonly" name="" type="text" value="<%=request.getParameter("stock_time")%>" ></td>
 <td align=right class="TD_STYLE3" width="25%"></td>
 <td style="display:none"><input name="id" value="<%=rs1.getString("id")%>"></td>
 </tr>
</table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8">
 <input type="button" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","查看不良照片")%>"  onclick="openS()">
</td>
 </tr>
</table>
<script language="javascript">
function openS()
{
open("query_picture.jsp?id=<%=exchange.unHtmls(Integer.toString(rs1.getInt("mold_purchase_order_detail.mold_id")))%>","","height=600,width=680,toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=yes");
}
</script>
<% 
String sql2="SELECT * FROM mold_stock where mold_id='"+mold_id+"'";
ResultSet rs2 = mold_db.executeQuery(sql2); 
if(rs2.next())
{
%>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="height:12; padding:3px; "><%=demo.getLang("erp","上模针边角")%></div></td></tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","1：型号与刻字规格内容相符")%></td>

 <td <%=TD_STYLE21%> class="TD_STYLE2" width="10%" style="vertical-align:middle; text-align:center;">

 <%
			if(rs2.getString("top_item1").equals("OK") )
			{
				%>
	 <input type="radio" name="1" value="OK" checked="checked">OK &nbsp;<input type="radio" name="1" value="NG" >NG 
				<%
			}else
			{
				
				%>
	 <input type="radio" name="1" value="OK" checked="checked">OK &nbsp;<input type="radio" name="1" value="NG" checked="checked">NG 
				<%
			}
		%>
	
 </td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","2：模具外观无锈迹、外棱倒角均匀、光洁度无明显异常")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="10%" style="vertical-align:middle; text-align:center;">


 <%
			if(rs2.getString("top_item2").equals("OK") )
			{
				%>
	<input type="radio" name="2" value="OK" checked="checked">OK &nbsp;<input type="radio" name="2" value="NG" >NG 
				<%
			}else
			{
				
				%>
	 <input type="radio" name="2" value="OK" checked="checked">OK &nbsp;<input type="radio" name="2" value="NG" checked="checked">NG 
				<%
			}
		%>
</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","3：显微镜中观察：针头边角无缺损、棱刺")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="10%" style="vertical-align:middle; text-align:center;">

 <%
			if(rs2.getString("top_item3").equals("OK") )
			{
				%>
	 <input type="radio" name="3" value="OK" checked="checked">OK &nbsp;<input type="radio" name="3" value="NG" >NG 
				<%
			}else
			{
				
				%>
		 <input type="radio" name="3" value="OK" checked="checked">OK &nbsp;<input type="radio" name="3" value="NG" checked="checked">NG 
				<%
			}
		%>
 </td>
</tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","4：显微镜中观察：针头棱边宽")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="10%" style="vertical-align:middle; text-align:center;">

  <%
			if(rs2.getString("top_item4").equals("OK") )
			{
				%>
	 <input type="radio" name="4" value="OK" checked="checked">OK &nbsp;<input type="radio" name="4" value="NG" >NG 
				<%
			}else
			{
				
				%>
	 <input type="radio" name="4" value="OK" checked="checked">OK &nbsp;<input type="radio" name="4" value="NG" checked="checked">NG 
				<%
			}
		%>
 </td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","5：显微镜中观察：针头中间倒角90度")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="10%" style="vertical-align:middle; text-align:center;">

 
  <%
			if(rs2.getString("top_item5").equals("OK") )
			{
				%>
	  <input type="radio" name="5" value="OK" checked="checked">OK &nbsp;<input type="radio" name="5" value="NG" >NG 
				<%
			}else
			{
				
				%>
	  <input type="radio" name="5" value="OK" checked="checked">OK &nbsp;<input type="radio" name="5" value="NG" checked="checked">NG 
				<%
			}
		%>
 </td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","6：显微镜中观察：针头棱宽的薄棉光洁")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="10%" style="vertical-align:middle; text-align:center;">
 
 
   <%
			if(rs2.getString("top_item6").equals("OK") )
			{
				%>
	  <input type="radio" name="6" value="OK" checked="checked">OK &nbsp;<input type="radio" name="6" value="NG" >NG 
				<%
			}else
			{
				
				%>
	 <input type="radio" name="6" value="OK" checked="checked">OK &nbsp;<input type="radio" name="6" value="NG" checked="checked">NG 
				<%
			}
		%>
 </td>
</tr>
<!-- 第二列表 -->
<tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="height:12; padding:3px; "><%=demo.getLang("erp","下模针边角")%></div></td></tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","1：型号与刻字规格内容相符")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="10%" style="vertical-align:middle; text-align:center;">

 
    <%
			if(rs2.getString("bottom_item1").equals("OK") )
			{
				%>
	  <input type="radio" name="7" value="OK" checked="checked">OK &nbsp;<input type="radio" name="7" value="NG" >NG 
				<%
			}else
			{
				
				%>
	 <input type="radio" name="7" value="OK" checked="checked">OK &nbsp;<input type="radio" name="7" value="NG" checked="checked">NG 
				<%
			}
		%>
 </td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","2：模具外观无锈迹、外棱倒角均匀、光洁度无明显异常")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="10%" style="vertical-align:middle; text-align:center;">

 
     <%
			if(rs2.getString("bottom_item2").equals("OK") )
			{
				%>
	   <input type="radio" name="8" value="OK" checked="checked">OK &nbsp;<input type="radio" name="8" value="NG" >NG 
				<%
			}else
			{
				
				%>
	 <input type="radio" name="8" value="OK" checked="checked">OK &nbsp;<input type="radio" name="8" value="NG" checked="checked">NG 
				<%
			}
		%>
 </td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp"," 3：显微镜中观察：圆孔圆弧光滑连接")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="10%" style="vertical-align:middle; text-align:center;">

 
      <%
			if(rs2.getString("bottom_item3").equals("OK") )
			{
				%>
	   <input type="radio" name="9" value="OK" checked="checked">OK &nbsp;<input type="radio" name="9" value="NG" >NG 
				<%
			}else
			{
				
				%>
	  <input type="radio" name="9" value="OK" checked="checked">OK &nbsp;<input type="radio" name="9" value="NG" checked="checked">NG 
				<%
			}
		%>
 </td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","4：显微镜中观察：角孔边角无缺损")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="10%" style="vertical-align:middle; text-align:center;">

 
       <%
			if(rs2.getString("bottom_item4").equals("OK") )
			{
				%>
	   <input type="radio" name="10" value="OK" checked="checked">OK &nbsp;<input type="radio" name="10" value="NG" >NG 
				<%
			}else
			{
				
				%>
	   <input type="radio" name="10" value="OK" checked="checked">OK &nbsp;<input type="radio" name="10" value="NG" checked="checked">NG 
				<%
			}
		%>
 </td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="7%" style="vertical-align:middle; text-align:left;"><%=demo.getLang("erp","5：显微镜中观察：倒角圆弧半径对称、与直面光滑连接")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="10%" style="vertical-align:middle; text-align:center;">

 
        <%
			if(rs2.getString("bottom_item5").equals("OK") )
			{
				%>
	  <input type="radio" name="11" value="OK" checked="checked">OK &nbsp;<input type="radio" name="11" value="NG" >NG 
				<%
			}else
			{
				
				%>
 <input type="radio" name="11" value="OK" checked="checked">OK &nbsp;<input type="radio" name="11" value="NG" checked="checked">NG 
				<%
			}
		%>
 </td>
</tr>

<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/design/design_file.xml"/>
<%String nickName="产品档案";%>
<%@include file="../../include/cDefineMou.jsp"%>
</table>
</br>
</br>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" align=center width="100%">
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
    <td width="10%" align="right" style="vertical-align:top;">备注：</td>
    <td>
  		  <textarea class="TEXTAREA_STYLE1" name="remark" style="width:100%" rows="4" ><%=rs2.getString("mold_stock_remark")%></textarea>
  		  
  	</td> 
  </tr>
</table>
</br>
</br>
<%-- 
<table  class="TABLE_STYLE1">
	<tr style="background-image:url(../../images/line.gif)">
		<td colspan="4">
		<div style="width:100%; height:12; padding:3px;"><%=demo.getLang("erp", "未通过原由")%></div>
		</td>
	</tr>
	<div>
	<tr <%=TR_STYLE1%> class="TR_STYLE1" >
		<td <%=TD_STYLE4%> class="TD_STYLE1" width="1%"><%=demo.getLang("erp", "未通过原由")%></td>
		<td <%=TD_STYLE21%> class="TD_STYLE2"  width="10%"><textarea
			<%=TEXTAREA_STYLE1%> class="INPUT_STYLE5" name="demand" id="demand"></textarea>
		</td>
	</tr>
</table>
--%>
<table class="TABLE_STYLE4" border="0" align=center width="100%"> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align=right class="TD_STYLE8" width="6%"><%=demo.getLang("erp","登记人")%>：</td>  
 <td align=left class="TD_STYLE2" width="8%"><input readonly="readonly" name="mold_stock_register" type="text" value="<%=rs2.getString("mold_stock_register")%>"   style="width:95%"/></td>
 <td align=right class="TD_STYLE8" width="6%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td align=left class="TD_STYLE2" width="8%"><input readonly="readonly" name="mold_stock_register_time" type="text" value="<%=rs2.getString("mold_stock_regist_time")%>"   style="width:95%"/></td> 
 <td align=right class="TD_STYLE8" width="6%"><%=demo.getLang("erp","变更人")%>：</td>
 <td align=left class="TD_STYLE2" width="8%"><input readonly="readonly" name="mold_stock_register" type="text" value="<%=operator%>"  style="width:95%"/></td>
 <td align=right class="TD_STYLE8" width="6%"><%=demo.getLang("erp","变更时间")%>：</td>
 <td align=left class="TD_STYLE2" width="8%"><input readonly="readonly" name="mold_stock_register" type="text" value="<%=time%>"   style="width:95%"/></td>

 <%
 	if(  rs2.getString("mold_stock_checker")!=null&& rs2.getString("mold_stock_check_time")!=null&&!rs2.getString("mold_stock_checker").equals("")&& !rs2.getString("mold_stock_check_time").equals("") )
 	{
 		String mold_stock_check_time=rs2.getString("mold_stock_check_time");

 			
 			mold_stock_check_time=mold_stock_check_time.substring(0,10);

 		
 		%>
 		<td align=right class="TD_STYLE8" width="6%"><%=demo.getLang("erp","审核人")%>：</td>  
 		<td align=left class="TD_STYLE2" width="8%"><input readonly="readonly" name="mold_stock_register" type="text" value="<%=rs2.getString("mold_stock_checker")%>"   style="width:95%" /></td>
 		<td align=right class="TD_STYLE8" width="6%"><%=demo.getLang("erp","审核时间")%>：</td>  
 		<td align=left class="TD_STYLE2" width="8%"><input readonly="readonly" name="mold_stock_register" type="text" value="<%=mold_stock_check_time%>"   style="width:95%" /></td>
 		<%
 	}
 %>
 </tr>
</table>
<%	
mold_db.close();
}
}
}
catch(Exception ex){ex.printStackTrace();}
%>
<%--@include file="../include/paper_bottom.html"--%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
</div>



