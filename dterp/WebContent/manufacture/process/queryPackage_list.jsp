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
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>


<script>
	function searchDetail(){
	
		window.location.href="search_detail.jsp";
	
	}
	
	function delcli(id){
		var res=confirm("确认要删除当前栈板号吗！");
		if(res){
			document.location.href="../../manufacture_process_ActionProcess.do?id="+id+"&m=delpackage";
		}else{
			return;
		}
	}
	function readCheck(id){
	
		window.location.href="read_queryPackage_list.jsp?id="+id;
	
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

//	 规格条件
	String product_spec=request.getParameter("product_spec");
	if(product_spec!=null&&!product_spec.trim().equals("")){
		my_condition +=" and product_spec like '%"+product_spec+"%'";
	}else{
		product_spec="";
	}
//	 模具规格条件
	String mold_spec=request.getParameter("mold_spec");
	if(mold_spec!=null&&!mold_spec.trim().equals("")){
		my_condition +=" and mold_spec like '%"+mold_spec+"%'";
	}else{
		mold_spec="";
	}
//	 栈板号条件
	String package_pallet=request.getParameter("package_pallet");
	if(package_pallet!=null&&!package_pallet.trim().equals("")){
		my_condition +=" and package_pallet like '%"+package_pallet+"%'";
	}else{
		package_pallet="";
	}



//	工厂托盘号
	String package_factory_pallet=request.getParameter("package_factory_pallet");
	if(package_factory_pallet!=null&&!package_factory_pallet.trim().equals("")){
		my_condition +=" and package_factory_pallet like '%"+package_factory_pallet+"%'";
	}else{
		package_factory_pallet="";
	}

//	库位状态
	String package_stock=request.getParameter("package_stock");
	if(package_stock!=null&&!package_stock.trim().equals("")){
		my_condition +=" and package_stock like  '%"+package_stock+"%'";
	}else{
		package_stock="";
	}
	
	 
//	库位状态
	String is_dissolve=request.getParameter("is_dissolve");
	if(is_dissolve!=null&&!is_dissolve.trim().equals("")){
		my_condition +=" and is_dissolve = '"+is_dissolve+"'";
	}else{
		is_dissolve="";
	}
	 
	 %>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>

 <form id="search_form" name="search_form" action="queryPackage_list.jsp" method="post" >
 <table width="100%" style="text-align:right;" border="0">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="26%"><%=demo.getLang("erp","原纸规格")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><input name="product_spec"  type="text"  value="<%=product_spec %>" Style="width=120px" ></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="8%"><%=demo.getLang("erp","模具规格")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><input name="mold_spec"  type="text"  value="<%=mold_spec %>" Style="width=120px"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="7%"><%=demo.getLang("erp","栈板号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><input name="package_pallet"  type="text"  value="<%=package_pallet %>" Style="width=120px"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","工厂托盘号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><input name="package_factory_pallet"  type="text"  value="<%=package_factory_pallet %>" Style="width=120px"></td>
  <td align=right class="TD_STYLE2" width="6%"><input type="submit" align=right class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>"></td>
 </tr>	
 </table>
 <form>
 
 
<%

//String my_sql_search = "select package_info  FROM package_info a,product_info b where a.product_id=b.id ";
String my_sql_search = "select *  FROM package_info  where 1 =1 and is_out_stock!=3  "+my_condition;
String register_ID = (String) session.getAttribute("human_ID");
String realname = (String) session.getAttribute("realeditorc");
String condition = "";

String validationXml = "";
String nickName = "生产计划";
String fileName = "queryPackage_list.jsp";
String rowSummary = demo.getLang("erp", "符合条件的生产计划总数：");
int k = 1;
%>
 <%@include file="../../include/search_my.jsp"%> 
<%
ResultSet rs = stock_db.executeQuery(sql_search);

%>

<div id="nseer_grid_div"></div>  
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}

				

var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
					  
                       
                       {name: '<%=demo.getLang("erp","原纸规格")%>'},
					   {name: '<%=demo.getLang("erp","模具规格")%>'},
                       {name: '<%=demo.getLang("erp","栈板号")%>'},
                       {name: '<%=demo.getLang("erp","工厂托盘号")%>'},
					   {name: '<%=demo.getLang("erp","客户")%>'},
					   {name: '<%=demo.getLang("erp","删除")%>'}
                       
					  
]
nseer_grid.column_width=[120,120,90,90,100,100];
nseer_grid.auto='<%=demo.getLang("erp","原纸规格")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
			String is_dissolve_str=rs.getString("is_dissolve");
			if(is_dissolve_str.equals("1")){
				is_dissolve_str="是";
			}else{
				is_dissolve_str="否";
			}
			String is_out_stock_str=rs.getString("is_out_stock");
			if(is_out_stock_str.equals("1")){
				is_out_stock_str="是";
			}else{
				is_out_stock_str="否";
			}
			
			String package_custom="";
//			客户名称
			String sql_3="SELECT id,customer_name FROM crm_file where id="+rs.getString("package_custom_id");
			ResultSet rs_3=stock_db2.executeQuery(sql_3);
			if(rs_3.next()){
				package_custom=rs_3.getString("customer_name");
			}
			if(rs.getString("package_count").equals("0")){

%>
['<%=rs.getString("product_spec")%>',
'<%=rs.getString("mold_spec")%>',
'<%=rs.getString("package_pallet")%>',
'<%=rs.getString("package_factory_pallet")%>',
'<%=package_custom%>',
'<div style="text-decoration : underline;color:#3366FF" onclick=delcli("<%=rs.getString("id")%>")><span>删除</span></div>'],
<%
			}k++;%>
</page:pages>  
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div> 
<div id="point_div_t"></div>  
<div id="point_div_b"></div>

<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<input type="hidden" name="" id="rows_num" value="<%=k%>">


<script type="text/javascript">
Calendar.setup ({inputField : "stock_in_time1", ifFormat : "%Y-%m-%d", showsTime : false, button : "stock_in_time1", singleClick : true, step : 1});
Calendar.setup ({inputField : "stock_in_time2", ifFormat : "%Y-%m-%d", showsTime : false, button : "stock_in_time2", singleClick : true, step : 1});
Calendar.setup ({inputField : "stock_out_time1", ifFormat : "%Y-%m-%d", showsTime : false, button : "stock_out_time1", singleClick : true, step : 1});
Calendar.setup ({inputField : "stock_out_time2", ifFormat : "%Y-%m-%d", showsTime : false, button : "stock_out_time2", singleClick : true, step : 1});


</script>
<%
stock_db.close();	
stock_db2.close();

}catch(Exception e){e.printStackTrace();}	
%>
<%@include file="../../include/head_msg.jsp"%>