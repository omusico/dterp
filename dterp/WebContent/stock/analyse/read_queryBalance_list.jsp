<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.exchange"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stock_db2 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stock_db3 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stock_db4 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<%@page import="org.apache.axis.session.Session"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<head>
<LINK href="../../javascript/table/onlineEditTable.css" type=text/css rel=stylesheet>
<script language="javascript" src="../../javascript/edit/editTable.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>

<script type="text/javascript">
function delSelect(){
 var checkboxs = document.getElementsByName("checkbox");
 var table = document.getElementById("tableOnlineEdit");
 var tr = table.getElementsByTagName("tr");
 for (var i=0; i<checkboxs.length; i++) {
 if(tr.length==2){
 checkboxs[i].checked = false;
 return;
 }
 if(checkboxs[i].checked==true){
 removeTr(checkboxs[i]);
 i=-1;
 }
 }
}
function removeTr(obj) {
 var sTr = obj.parentNode.parentNode;
 sTr.parentNode.removeChild(sTr);
}
</script>

<script>
	function changeProduct(pg){
	var result = pg.value;
		if(result==0){
			document.getElementById("div1").style.display="none";
			document.getElementById("div2").style.display="none";
			document.getElementById("div3").style.display="none";
			document.getElementById("div4").style.display="none";
		}else if(result==1){
			document.getElementById("div1").style.display="block";
			document.getElementById("div2").style.display="none";
			document.getElementById("div3").style.display="none";
			document.getElementById("div4").style.display="none";
		}else if(result==2){
			document.getElementById("div1").style.display="none";
			document.getElementById("div2").style.display="block";
			document.getElementById("div3").style.display="none";
			document.getElementById("div4").style.display="none";
		}else if(result==3){
			document.getElementById("div1").style.display="none";
			document.getElementById("div2").style.display="none";
			document.getElementById("div3").style.display="block";
			document.getElementById("div4").style.display="none";
		}else if(result==4){
			document.getElementById("div1").style.display="none";
			document.getElementById("div2").style.display="none";
			document.getElementById("div3").style.display="none";
			document.getElementById("div4").style.display="block";
		}
	}
</script>


</head>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%="您正在做的业务是：库存管理--库存管理--动态库存查询"%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="POST" action="" onSubmit="">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="button" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" onclick="javascript:window.history.back()" value="<%=demo.getLang("erp","返回")%>"></td>
 </tr>
 </table>
 <%

String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String gather_ID=request.getParameter("gather_ID");
String new_apply="0";
String product_info_id=request.getParameter("id");
String sql="select * from product_info as a left join product_base_info b on  a.id=b.product_id where a.id='"+product_info_id+"' ";
ResultSet rs=stock_db.executeQuery(sql);
String product_spec="";
String product_lot_no="";
String product_type="";
String product_status="";
String product_base_length="";						
String product_base_weight="";						
String product_base_width="";						

String product_base_invoice_no="";
String product_stock="";
if(rs.next()){
	product_spec=rs.getString("product_spec");
	if(product_spec==null){
		product_spec="";
	}
	product_lot_no=rs.getString("product_lot_no");
	if(product_lot_no==null){
		product_lot_no="";
	}
	product_type=rs.getString("product_type");
	//if(product_type==null){
		//product_type="";
	//}
	product_status=rs.getString("product_status");
	product_base_invoice_no=rs.getString("product_base_invoice_no");
	if(product_base_invoice_no==null){
		product_base_invoice_no="";
	}
	product_base_length=rs.getString("product_base_length");
	if(product_base_length==null){
		product_base_length="";
	}
	product_base_weight=rs.getString("product_base_weight");
	if(product_base_weight==null){
		product_base_weight="";
	}
	product_base_width=rs.getString("product_base_width");
	if(product_base_width==null){
		product_base_width="";
	}
	product_stock=rs.getString("product_stock");
	if(product_stock==null){
		product_stock="";
	}
	
	
}
%>
<input type="hidden" name="new_apply" value="<%=new_apply%>">
<input name="gather_ID" type="hidden" value="<%=gather_ID%>">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
  <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","产品信息")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 
 <%
 String product_pstatus_str="";
 if(product_status.trim().equals("")){
	 product_status="0";
 }
 int product_pstatus2=Integer.parseInt(product_status);

 if(product_pstatus2==0){
 	product_pstatus_str="预入库";
 }
 if(product_pstatus2==1){
 	product_pstatus_str="在库";
 }
 if(product_pstatus2==2){
 	product_pstatus_str="生产中";
 }
 if(product_pstatus2==3){
 	product_pstatus_str="生产完成";
 }
 if(product_pstatus2==4){
 	product_pstatus_str="转换";
 }
 if(product_pstatus2==5){
 	product_pstatus_str="包装";
 }
 if(product_pstatus2==6){
 	product_pstatus_str="废弃";
 }
 String product_type_str="";
 if(product_type.trim().equals("")){
	 product_type="0";
 }
 int product_type2=Integer.parseInt(product_type);

 if(product_type2==0){
 	product_type_str="原纸";
 }
 if(product_type2==1){
 	product_type_str="4分切产品";
 }
 if(product_type2==2){
 	product_type_str="8mm切产品";
 }
 if(product_type2==3){
 	product_type_str="打孔";
 }
 if(product_type2==4){
 	product_type_str="特采品";
 }
 %>
 
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","原纸规格")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="15%"><input name="reason" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" value="<%=product_spec %>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","LOT No.")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="15%"><input name="reason" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" value="<%=product_lot_no %>"></td>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","类型")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="15%"><input name="reason" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" value="<%= product_type_str%>"></td>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","状态")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="15%"><input name="reason" type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" value="<%=product_pstatus_str %>"></td>
	</tr>
	
</table>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;阶段<select name="select" id="select" onchange="changeProduct(this)">
 			<option value="0"></option>
    		<option value="1">原纸</option>
    		<option value="2">四分切</option>
    		<option value="3">8mm切</option>
    		<option value="4">打孔</option>
 		 </select>
<br /><br />

<div id="div1" style="display:none">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;原纸阶段
 <table <%=TABLE_STYLE5%> class="TABLE_STYLE5" cols=1 id=tableOnlineEdit1>
<thead>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","原纸规格")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","LOT No.")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","Invoice No.")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","宽度(mm)")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","长度(m)")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","重量(kgs)")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","出库时间")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","库位")%></td>
 	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","出库状态")%></td>
 </tr>
 
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_spec %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_spec %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_base_invoice_no %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_base_length %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_base_weight %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_base_width %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=product_stock %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><div onclick=""><%=product_pstatus_str %></div></td>
 </tr>

</thead>
</table>
</div>

<div id="div2"  style="display:none">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4分切阶段
 <table <%=TABLE_STYLE5%> class="TABLE_STYLE5" cols=1 id=tableOnlineEdit1>
<thead>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
   <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","天气")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","温度")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","湿度")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","原纸宽度")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","四分切宽度")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","四分切前厚度")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","四分切后厚度")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><%=demo.getLang("erp","加工实际长度")%></td>
	 	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><%=demo.getLang("erp","加工日期")%></td>
	 	 	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><%=demo.getLang("erp","加工时间")%></td>
 </tr>
 <%
 	String sql2="select * from product_4_info where product_id='"+product_info_id+"'";
   ResultSet rs2=stock_db2.executeQuery(sql2);
   while(rs2.next()){						

 %>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs2.getString("product_4_weather") %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs2.getString("product_4_temperature") %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs2.getString("product_4_humidity") %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs2.getString("product_width") %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs2.getString("product_4_width") %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs2.getString("product_4_before_thickness") %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs2.getString("product_4_after_thickness") %></td>
  <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs2.getString("product_4_fact_length") %></td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs2.getString("product_4_date") %></td>
      <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs2.getString("product_4_time") %></td>

 </tr>
<%
   }
%>
</thead>
</table>
</div>						
				



<div id="div3" style="display:none">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8mm切阶段
 <table <%=TABLE_STYLE5%> class="TABLE_STYLE5" cols=1 id=tableOnlineEdit1>
<thead>
  <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","天气")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","温度")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","湿度")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","实际长度")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","实际宽度")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","纸带外观")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","加工日期")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><%=demo.getLang("erp","加工时间")%></td>
 	
 </tr>
 <% 
 String sql3="select * from product_8mm_info where product_id='"+product_info_id+"'";
   ResultSet rs3=stock_db3.executeQuery(sql3);
   while(rs3.next()){
	   
	   %>  
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs3.getString("product_8mm_weather") %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs3.getString("product_8mm_temperature")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs3.getString("product_8mm_humidity")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs3.getString("product_8mm_fact_length")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs3.getString("product_8mm_fact_width")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs3.getString("product_8mm_paper_exterior")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs3.getString("product_8mm_date")%></td>
  <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs3.getString("product_8mm_time")%></td>

 </tr>
<%
   }
%>
</thead>
</table>
</div>

<div id="div4" style="display:none">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;打孔阶段
 <table <%=TABLE_STYLE5%> class="TABLE_STYLE5" cols=1 id=tableOnlineEdit1>
<thead>					
				

  <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","打孔纸带批次号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","角孔型号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","角孔尺寸的长")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","角孔尺寸的宽")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","打孔温度")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","打孔湿度")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","当日加工卷数")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><%=demo.getLang("erp","当日加工时间")%></td>
 	
 </tr>
  <% 
 String sql4="select * from product_8mm_info where product_id='"+product_info_id+"'";
   ResultSet rs4=stock_db4.executeQuery(sql4);
   while(rs4.next()){
	   
	   %>					
	   
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs4.getString("product_final_lot_no")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs4.getString("mold_style_id")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs4.getString("mold_size_length")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs4.getString("mold_size_width")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs4.getString("product_hole_temperature")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs4.getString("product_hole_humidity")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs4.getString("product_hole_num")%></td>
  <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs4.getString("product_8mm_time")%></td>
   <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs4.getString("product_hole_time")%></td>
  
 </tr>
<%
   }
%>
</thead>
</table>
</div>
<%
stock_db.close();
stock_db2.close();
stock_db3.close();
stock_db4.close();

%>
<%@include file="../include/paper_bottom.html"%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 </form>
 </div>
 <script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>