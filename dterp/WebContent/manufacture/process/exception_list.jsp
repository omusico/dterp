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
	import="java.sql.*,include.nseer_cookie.*" import="java.util.*"
	import="java.io.*" import="include.nseer_db.*,java.text.*"%>
<%
			nseer_db manufacture_db = new nseer_db((String) session.getAttribute("unit_db_name"));
%>
<jsp:useBean id="query" scope="page"
	class="include.query.getRecordCount" />
<jsp:useBean id="validata" scope="page" class="validata.ValidataNumber" />
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page" />
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page" />
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page" />
<jsp:useBean id="mask" class="include.operateXML.Reading" />
<jsp:setProperty name="mask" property="file" value="xml/manufacture/manufacture_apply.xml" />
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/manufacture/apply/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<script type="text/javascript">
function feiqi(idNo){
	var res=confirm("确认要废弃当前产品吗！");
	if(res){
		document.location.href="../../manufacture_process_ActionProcess.do?id="+idNo+"&m=abandon";
	}else{
		return;
	}
}
</script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css" />
<%
		
		try{
		DealWithString DealWithString = new DealWithString(application);
		String mod = request.getRequestURI();
		demo.setPath(request);
		String handbook = demo.businessComment(mod, "您正在做的业务是：","document_main", "reason", "value");
		String tablename = "product_plan";
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<%
		String first_state="0";//0——第一次加载，1——再次加载
		if(request.getParameter("plan_typeS")!=null||request.getParameter("product_specS")!= null||request.getParameter("LotNoS")!= null){
			first_state="1";
		}
		//产品表中业务状态是2——生产中或3——生产完成的，产品生产状态是''——或者'1'正常
		String my_condition=" ((product_status=2 or product_status=3) and product_pstatus='异常' and id in (select event_product_id from event_info where event_checker!=''))"+ 
			"or (product_pstatus='正常' and product_status=3 and product_is_production='1' and product_type=2 ) ";
		//发生场所查询
		if (request.getParameter("plan_typeS") != null&&request.getParameter("plan_typeS").length() > 0) {
			if(!request.getParameter("plan_typeS").equals("0")){
			my_condition += " and product_type="+request.getParameter("plan_typeS");
			}
		}
		//
		String product_specS="";
		if (request.getParameter("product_specS") != null&&request.getParameter("product_specS").length() > 0) {
			my_condition += " and product_spec like '%"+request.getParameter("product_specS")+"%'";
			product_specS=request.getParameter("product_specS");
		}
		String LotNoS="";
		if (request.getParameter("LotNoS") != null&&request.getParameter("LotNoS").length() > 0) {
			my_condition += " and product_lot_no like '%"+request.getParameter("LotNoS")+"%'";
			LotNoS=request.getParameter("LotNoS");
		}
		//
		String my_sql_search = "select id,product_lot_no,product_type,product_spec_id,product_spec,product_status,product_pstatus,product_produce_location FROM product_info where "+ my_condition + " order by id desc ";
		
		String register_ID = (String) session.getAttribute("human_ID");
		String realname = (String) session.getAttribute("realeditorc");
		String condition = "";
		String validationXml = "";
		String nickName = "生产计划";
		String fileName = "print_list.jsp";
		String rowSummary = demo.getLang("erp", "符合条件的生产计划总数：");
		int k = 1;
		
%>
<%@include file="../../include/search_my.jsp"%>
<%--@include file="../../include/search.jsp"--%>
<%
	try{
	ResultSet rs = manufacture_db.executeQuery(sql_search);
	
	String plan_typeD="";//生产场所显示
	
%>
<%--
		ResultSet rs = manufacture_db.executeQuery(sql_search);
		String sql_temp = sql_search.substring(0, sql_search.indexOf("limit"));
		intRowCount = query.count((String) session.getAttribute("unit_db_name"), sql_temp.replace("*","distinct apply_ID"));
		otherButtons = "&nbsp;<input type=\"button\" " + BUTTON_STYLE1
		+ " class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+ demo.getLang("erp", "全选")
		+ "\" name=\"check\" onclick=\"selAll()\">"+ DgButton.getGar(tablename, request);
		String apply_id_control = "";
		int maxPage = (intRowCount + pageSize - 1) / pageSize;
		strPage = strPage.split("⊙")[0] + "⊙" + maxPage;
--%>
<%--@include file="../../include/search_top.jsp"--%>
<form action="exception_list.jsp" method="post" name="search_form" id="search_form">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE6%> class="TD_STYLE6">类型：
		  <select name="plan_typeS" style="width: 160">
		  <%
		  if (request.getParameter("plan_typeS") != null&&request.getParameter("plan_typeS").length() > 0) {
				if(request.getParameter("plan_typeS").equals("1")){
		  %>
		  <option value="0">全部</option>
		  <option value="1" selected="selected">4分切产品</option>
		  <option value="2">8mm切产品</option>
		  <option value="3">打孔产品</option>
		  
		  <%
				}else if(request.getParameter("plan_typeS").equals("2")){
		  %>
		  <option value="0">全部</option>
		  <option value="1">4分切产品</option>
		  <option value="2" selected="selected">8mm切产品</option>
		  <option value="3">打孔产品</option>
		  
		  <%		
				}else if(request.getParameter("plan_typeS").equals("3")){
		  %>
		  <option value="0">全部</option>
		  <option value="1">4分切产品</option>
		  <option value="2">8mm切产品</option>
		  <option value="3" selected="selected">打孔产品</option>
		  
		  <%			
				}else{
		  %>
		  <option value="0" selected="selected">全部</option>
		  <option value="1">4分切产品</option>
		  <option value="2">8mm切产品</option>
		  <option value="3">打孔产品</option>
		  
		  <%			
				}
		  }else{
		  %>
		  <option value="0">全部</option>
		  <option value="1">4分切产品</option>
		  <option value="2">8mm切产品</option>
		  <option value="3">打孔产品</option>
		  
		  <%	
		  }
		  %>
		  
		  </select>&nbsp;
		  规格：<input type="text" name="product_specS" id="" value="<%=product_specS %>" style="width: 150">&nbsp;
		  Lot No：<input type="text" name="LotNoS" id="" value="<%=LotNoS %>" style="width: 150">
		  <input type="submit" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>" >
		</td>
	</tr>
</table>
</form>
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
					   
                       {name: '<%=demo.getLang("erp","规格")%>'},
                       {name: '<%=demo.getLang("erp","Lot No")%>'},
                       {name: '<%=demo.getLang("erp","类型")%>'},
                       {name: '<%=demo.getLang("erp","状态")%>'},
                       {name: '<%=demo.getLang("erp","转换")%>'},
	                   {name: '<%=demo.getLang("erp","废弃")%>'}
]
nseer_grid.column_width=[200,200,200,200,200,200];
nseer_grid.auto='<%=demo.getLang("erp","Lot No")%>';
nseer_grid.data = [

<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 

<%
k++;
if(rs.getString("product_type").equals("0")){
	plan_typeD="原纸";
}else if(rs.getString("product_type").equals("1")){
	plan_typeD="4分切产品";
}else if(rs.getString("product_type").equals("2")){
	plan_typeD="8mm切产品";
}else if(rs.getString("product_type").equals("3")){
	plan_typeD="打孔产品";
}

%>
[
'<%=rs.getString("product_spec")%>',
'<%=rs.getString("product_lot_no")%>',
'<%=plan_typeD %>',
'<%=rs.getString("product_pstatus")%>',
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("exception_details.jsp?id=<%=rs.getString("id") %>")><%=demo.getLang("erp", "转换")%></div>',
<%
if(rs.getString("product_pstatus").equals("异常")){
%>
'<div style="text-decoration : underline;color:#3366FF" onclick=feiqi("<%=rs.getString("id") %>")><%=demo.getLang("erp", "废弃")%></div>'
<%	
}else{
%>
'<%="----" %>'
<%	
} 
%>
],


</page:pages>

['']];
nseer_grid.init();
function init_div(){
	var height=document.getElementById("nseergrid").style.height;
	
	document.getElementById("nseergrid").style.height=parseInt(height)-40;
	document.getElementById("nseer_grid_div").style.left=10;
	document.getElementById("nseer_grid_nseer_xbar").style.top = nseer_grid.int(document.getElementById("nseergrid").style.height) - (nseer_grid.scroll_w - 1);
}
init_div();
var isIE=document.all?true:false;
if(isIE){
	    	window.attachEvent('onresize', init_div);
}else if(!isIE){
		    window.addEventListener('resize',init_div, false);
}
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%--@include file="../../include/search_bottom.jsp"--%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>" />
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<%
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	manufacture_db.close();
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>
<%@include file="../../include/head_msg.jsp"%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
