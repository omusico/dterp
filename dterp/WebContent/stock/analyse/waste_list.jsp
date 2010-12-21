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
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stock_db2 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stock_db3 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_apply_gather.xml"/>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">



<script>
	function searchDetail(){
	
		window.location.href="search_detail.jsp";
	
	}
	function readCheck(id){
	
		window.location.href="read_queryBalance_list.jsp?id="+id;
	
	}
</script>


<script type="text/javascript">

function reuse(id)
{
var res=confirm("是否确认该操作？");
	if(res)
	{
		document.location.href="../../stock_ActionWaste.do?m=reuse&id="+id;
	}else
	{
		return false;
	}
	
}
</script>

<style type="text/css" >
	.inputstate{
		border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; 
	}
</style>

<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<% 
try{
	
	String tablename="stock_apply_gather";
	DealWithString DealWithString=new DealWithString(application);
	String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
	 
	 
	 String my_condition="";
	 String first_state="0";//0——第一次加载，1——再次加载
	 if(request.getParameter("product_spec")!=null||request.getParameter("lot_no")!=null||
			 request.getParameter("product_stock")!= null||request.getParameter("stock_in_time1")!= null||
			 request.getParameter("stock_in_time2")!= null||request.getParameter("product_type")!= null||
			 request.getParameter("state")!= null||request.getParameter("product_temp_pallet")!= null){
	 	first_state="1";
	 }
//	 规格条件
	String product_spec=request.getParameter("product_spec");
	if(product_spec!=null&&!product_spec.trim().equals("")){
		my_condition +=" and a.product_spec like '%"+product_spec+"%'";
	}else{
		product_spec="";
	}
//	 lot_no条件
	String lot_no=request.getParameter("lot_no");
	if(lot_no!=null&&!lot_no.trim().equals("")){
		my_condition +=" and a.product_lot_no like '%"+lot_no+"%'";
	}else{
		lot_no="";
	}
//	 仓库条件
	String product_stock=request.getParameter("product_stock");
	if(product_stock!=null&&!product_stock.trim().equals("")){
		my_condition +=" and a.stock_id ='"+product_stock+"'";
	}else{
		product_stock="";
	}

//	入库时间1
	String stock_in_time1=request.getParameter("stock_in_time1");
//	入库时间2
	String stock_in_time2=request.getParameter("stock_in_time2");
	if(stock_in_time1!=null&&stock_in_time1.equals(stock_in_time2)&&(!stock_in_time1.equals(""))){
		my_condition +=" and a.stock_in_time like '%"+stock_in_time1+"%'";
	}else{
	if(stock_in_time1!=null&&!stock_in_time1.trim().equals("")){
		my_condition +=" and a.stock_in_time >= '"+stock_in_time1+"'";
	}else{
		stock_in_time1="";
	}

	if(stock_in_time2!=null&&!stock_in_time2.trim().equals("")){
		my_condition +=" and left(a.stock_in_time,10) <= '"+stock_in_time2+"' and a.stock_in_time !=''";
	}else{
		stock_in_time2="";
	}
	}

//	类型
	String product_type=request.getParameter("product_type");
	if(product_type!=null&&!product_type.trim().equals("")){
		my_condition +=" and a.product_type = '"+product_type+"'";
	}else{
		product_type="";
	}

//	状态
	String product_status=request.getParameter("state");
	if(product_status!=null&&!product_status.trim().equals("")){
		my_condition +=" and a.product_status = '"+product_status+"'";
	}else{
		product_status="";
	}
//	临时托盘号
	String product_temp_pallet=request.getParameter("product_temp_pallet");
	if(product_temp_pallet!=null&&!product_temp_pallet.trim().equals("")){
		my_condition +=" and a.product_temp_pallet like '%"+product_temp_pallet+"%'";
	}else{
		product_temp_pallet="";
	}
//	现场托盘号
	String scene_pallet=request.getParameter("scene_pallet");
	if(scene_pallet!=null&&!scene_pallet.trim().equals("")){
		my_condition +=" and a.scene_pallet like '%"+scene_pallet+"%'";
	}else{
		scene_pallet="";
	} 
	 
	 
	 %>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 
 <form id="search_form" name="search_form" action="waste_list.jsp" method="post" >
 <table style="width:100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1" align=left>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="7%"><%=demo.getLang("erp","原纸规格")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><input name="product_spec"  type="text"  value="<%=product_spec %>" Style="width:120px" ></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="7%"><%=demo.getLang("erp","Lot No.")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><input name="lot_no"  type="text"  value="<%=lot_no %>" Style="width:120px"></td>

  <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","类型")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><select name="product_type" id="product_type"  style="width:120px">
    		<option value="">--------全部--------</option>
    		<option value="0">原纸</option>
    		<option value="1">四分切</option>
    		<option value="2">8mm切</option>
    		<option value="3">打孔</option>
    		<option value="4">特采品</option>
 		 </select></td>

 <td align="right" class="TD_STYLE8" width="10%"><%=demo.getLang("erp","临时托盘号.")%>：</td>
 <td width="7%" align="left"><input name="product_temp_pallet"  type="text"  value="<%=product_temp_pallet %>" Style="width:120px">
 <td align="right" class="TD_STYLE8" width="10%"><%=demo.getLang("erp","现场托盘号.")%>：</td>
 <td width="7%" align="left"><input name="scene_pallet"  type="text"  value="<%=scene_pallet %>" Style="width:120px">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="7%">&nbsp;</td>		
 </tr>
 
 <tr <%=TR_STYLE1%> class="TR_STYLE1" align=left>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","入库时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><input id="date_start" name="stock_in_time1" type="text" value="<%=stock_in_time1 %>" Style="width:120px" ></td>
 <td align=center class="TD_STYLE8" width="9%"><font size="3">~&nbsp;</font></td>   
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><input id="date_end" name="stock_in_time2" type="text" value="<%=stock_in_time2 %>" Style="width:120px"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="7%"></td>		 
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="7%"></td>		 
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="7%"></td>		 
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="7%"></td>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="7%"></td>		 
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="7%"><input type="submit"  class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>"></td>


 </tr>
 </table>
 <form>
 
 
<%

//String my_sql_search = "select a.*,e.stock_out_time as stock_out_time,c.stock_in_time as stock_in_time  FROM product_info a,stock_in_detail b,stock_in c,stock_out_detail d,stock_out e where b.stock_in_id=c.id and a.id=b.In_Detail_product_id and d.Out_Detail_product_id=a.id and d.stoct_out_id=e.id "+my_condition+" group by a.id order by a.id";

String my_sql_search="SELECT a . * , b.stock_in_time AS stock_in_time, c.stock_out_time AS stock_out_time FROM product_info AS a LEFT JOIN ("+

	"SELECT stock_in_time, d.In_Detail_product_id AS In_Detail_product_id "+
	"FROM stock_in c, stock_in_detail d "+
	"WHERE d.stock_in_id = c.id "+
	") AS b ON a.id = b.In_Detail_product_id "+
	"LEFT JOIN ( "+
	"SELECT stock_out_time, d.Out_Detail_product_id AS Out_Detail_product_id "+
	"FROM stock_out c, stock_out_detail d "+
	"WHERE d.stoct_out_id = c.id "+
	") AS c ON a.id = c.Out_Detail_product_id "+
	"WHERE a.package_id=0 and product_status!=0 and product_status!=8 and product_status!=4 and  ( product_status!=6 or (stock_id = 109 and product_status = 6)) and product_is_production=1 and product_status='6'"+
	my_condition;
String register_ID = (String) session.getAttribute("human_ID");
String realname = (String) session.getAttribute("realeditorc");
String condition = "";

String validationXml = "";
String nickName = "生产计划";
String fileName = "queryBalance_list.jsp";
String rowSummary = demo.getLang("erp", "符合条件的生产计划总数：");
int k = 1;
%>
 <%@include file="../../include/search_my.jsp"%>
<%
ResultSet rs = stock_db.executeQuery(sql_search);

%>

<div id="nseer_grid_div"></div>
<%if(first_state.equals("0")){rs=null;} %>  
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
					  
                       {name: '<%=demo.getLang("erp","原纸规格")%>'},
                       {name: '<%=demo.getLang("erp","LOT No.")%>'},
                       {name: '<%=demo.getLang("erp","仓库")%>'},
					   {name: '<%=demo.getLang("erp","入库时间")%>'},
                       {name: '<%=demo.getLang("erp","出库时间")%>'},
                       {name: '<%=demo.getLang("erp","类型")%>'},
					   {name: '<%=demo.getLang("erp","库位")%>'},
					   {name: '<%=demo.getLang("erp","临时托盘号")%>'},
					   {name: '<%=demo.getLang("erp","现场托盘号")%>'},
					    {name: '<%=demo.getLang("erp","产品废弃")%>'}
					  
]
nseer_grid.column_width=[120,120,120,120,120,120,110,120,120,60];
nseer_grid.auto='<%=demo.getLang("erp","LOT No.")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
String product_pstatus_str="";
int product_pstatus2=rs.getInt("product_status");

if(product_pstatus2==1){
	product_pstatus_str="在库";
}
if(product_pstatus2==2){
	product_pstatus_str="生产中";
}
if(product_pstatus2==3){
	product_pstatus_str="生产完成";
}
if(product_pstatus2==5){
	product_pstatus_str="包装";
}
if(product_pstatus2==6){
	product_pstatus_str="废弃";
}
if(product_pstatus2==7){
	product_pstatus_str="出库";
}

String product_type_str="";
int product_type2=rs.getInt("product_type");

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

String stock_in_time_str=rs.getString("a.stock_in_time");
String stock_out_time_str=rs.getString("a.stock_out_time");
if(stock_in_time_str==null){
	stock_in_time_str="";
}
if(stock_out_time_str==null){
	stock_out_time_str="";
}
if(!stock_in_time_str.equals("")){
stock_in_time_str=stock_in_time_str.substring(0,10);
}

if(!stock_out_time_str.equals("")){
	stock_out_time_str=stock_out_time_str.substring(0,10);
	}

%>
['<%=rs.getString("product_spec")%>',
'<%=rs.getString("product_lot_no")%>','<%=rs.getString("stock_name")%>',
'<%=stock_in_time_str%>',
'<%=stock_out_time_str%>',
'<%=product_type_str%>',
'<%=product_pstatus2!=7?rs.getString("product_stock"):""%>',
'<%=rs.getString("a.product_temp_pallet")%>',
'<%=rs.getString("a.scene_pallet")%>',
'<div style="text-decoration : underline;color:#3366FF" onclick=reuse(<%=rs.getString("id")%>)>废弃</div>'],

<%k++;%>
<%--'<div style="text-decoration : underline;color:#3366FF" onclick="readCheck(<%=rs.getString("id")%>)"><span><%="查看"%></span></div>'--%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>

<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<input type="hidden" name="" id="rows_num" value="<%=k%>">



<%
stock_db.close();	
stock_db2.close();
stock_db3.close();
}catch(Exception e){e.printStackTrace();}	
%>
<%@include file="../../include/head_msg.jsp"%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>