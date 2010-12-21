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
		if(request.getParameter("plan_typeS")!=null||request.getParameter("register_timeS")!= null){
			first_state="1";
		}
		String my_condition="and plan_check_tag in (0,1,2)";//加入订单已执行标志位   plan_check_tag=3
		//计划类型查询
		String register_timeS="";
		if (request.getParameter("plan_typeS") != null&&request.getParameter("plan_typeS").length() > 0) {
			if(!request.getParameter("plan_typeS").equals("0")){
			my_condition += " and plan_type="+request.getParameter("plan_typeS");
			}
		}
		//
		if (request.getParameter("register_timeS") != null&&request.getParameter("register_timeS").length() > 0) {
			my_condition += " and plan_register_time like '%"+request.getParameter("register_timeS")+"%'";
			register_timeS=request.getParameter("register_timeS");
		}
//		查询
		if (request.getParameter("plan_typeS1") != null&&request.getParameter("plan_typeS1").length() > 0) {
			if(!request.getParameter("plan_typeS1").equals("all")){
				my_condition += " and plan_check_tag="+request.getParameter("plan_typeS1");
			}
		}
		String my_sql_search = "select id,plan_id,plan_type,plan_maker,plan_make_time,plan_register,plan_register_time,plan_check_tag FROM product_plan where C_DEFINE1='0' "+ my_condition + " order by id desc ";
		
		String register_ID = (String) session.getAttribute("human_ID");
		String realname = (String) session.getAttribute("realeditorc");
		String condition = "";
	
		String validationXml = "";
		String nickName = "生产计划";
		String fileName = "change_list.jsp";
		String rowSummary = demo.getLang("erp", "符合条件的生产计划总数：");
		int k = 1;
		
%>
<%@include file="../../include/search_my.jsp"%>
<%--@include file="../../include/search.jsp"--%>
<%
	try{
	ResultSet rs = manufacture_db.executeQuery(sql_search);
	String plan_check_tag="";
	String plan_typeD="";//计划类型显示
	String page_name="";//根据不同计划跳转不同修改页面
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
<form action="change_list.jsp" method="post" name="search_form" id="search_form">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE6%> class="TD_STYLE6">
		登记时间：
		<input type="text" name="register_timeS" id="date_start" value="<%=register_timeS %>" style="width: 150">&nbsp;
		生产计划类型：
		  <select name="plan_typeS" style="width: 160">
		  <%
		  if (request.getParameter("plan_typeS") != null&&request.getParameter("plan_typeS").length() > 0) {
				if(request.getParameter("plan_typeS").equals("1")){
		  %>
		  <option value="0">------全部------</option>
		  <option value="1" selected="selected">4分切生产计划</option>
		  <option value="2">8mm切生产计划</option>
		  <option value="3">打孔生产计划</option>
		  <%
				}else if(request.getParameter("plan_typeS").equals("2")){
		  %>
		  <option value="0">------全部------</option>
		  <option value="1">4分切生产计划</option>
		  <option value="2" selected="selected">8mm切生产计划</option>
		  <option value="3">打孔生产计划</option>
		  <%		
				}else if(request.getParameter("plan_typeS").equals("3")){
		  %>
		  <option value="0">------全部------</option>
		  <option value="1">4分切生产计划</option>
		  <option value="2">8mm切生产计划</option>
		  <option value="3" selected="selected">打孔生产计划</option>
		  <%			
				}else{
		  %>
		  <option value="0" selected="selected">------全部------</option>
		  <option value="1">4分切生产计划</option>
		  <option value="2">8mm切生产计划</option>
		  <option value="3">打孔生产计划</option>
		  <%			
				}
		  }else{
		  %>
		  <option value="0">------全部------</option>
		  <option value="1">4分切生产计划</option>
		  <option value="2">8mm切生产计划</option>
		  <option value="3">打孔生产计划</option>
		  <%	
		  }
		  %>
		  
		  </select>&nbsp;
		  审核状态：
		  <select name="plan_typeS1" style="width: 12%">
		  <%
		  if (request.getParameter("plan_typeS1") != null&&request.getParameter("plan_typeS1").length() > 0) {
				if(request.getParameter("plan_typeS1").equals("0")){
		  %>
		  <option value="all">---------全部---------</option>
		  <option value="0" selected="selected">未审核</option>
		  <option value="1">审核通过</option>
		  <option value="2">审核未通过</option>
		  <%
				}else if(request.getParameter("plan_typeS1").equals("1")){
		  %>
		  <option value="all">---------全部---------</option>
		  <option value="0" >未审核</option>
		  <option value="1" selected="selected">审核通过</option>
		  <option value="2" >审核未通过</option>
		  <%			
							}else if(request.getParameter("plan_typeS1").equals("2")){
		  %>
		  <option value="all">---------全部---------</option>
		  <option value="0">未审核</option>
		  <option value="1">审核通过</option>
		  <option value="2" selected="selected">审核未通过</option>
		  <%			
				}else if(request.getParameter("plan_typeS1").equals("all")){
		  %>
		  <option value="all" selected="selected">---------全部---------</option>
		  <option value="0">未审核</option>
		  <option value="1">审核通过</option>
		  <option value="2">审核未通过</option>
		  <%				
				}
		  }else{
		  %>
		  <option value="all" selected="selected">---------全部---------</option>
		  <option value="0">未审核</option>
		  <option value="1">审核通过</option>
		  <option value="2">审核未通过</option>
		  <%	
		  }
		  %>
		  
		  </select>
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
					   
                       {name: '<%=demo.getLang("erp","生产计划编号")%>'},
                       {name: '<%=demo.getLang("erp","生产计划类型")%>'},
                       {name: '<%=demo.getLang("erp","加工日期")%>'},
                       {name: '<%=demo.getLang("erp","制定人")%>'},
                       {name: '<%=demo.getLang("erp","登记人")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'},
                       {name: '<%=demo.getLang("erp","审核状态")%>'},
	                   {name: '<%=demo.getLang("erp","变更")%>'}
]
nseer_grid.column_width=[90,120,100,100,100,120,80,60];
nseer_grid.auto='<%=demo.getLang("erp","生产计划类型")%>';
nseer_grid.data = [

<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 

<%
k++;
if(rs.getString("plan_type").equals("1")){
	plan_typeD="4分切生产计划";
	page_name="change_4.jsp";
}else if(rs.getString("plan_type").equals("2")){
	plan_typeD="8mm切生产计划";
	page_name="change_8.jsp";
}else if(rs.getString("plan_type").equals("3")){
	plan_typeD="打孔生产计划";
	page_name="change_hole.jsp";
}
if(rs.getString("plan_check_tag").equals("0")){
	plan_check_tag="未审核";
}else if(rs.getString("plan_check_tag").equals("1")){
	plan_check_tag="审核通过";
}else if(rs.getString("plan_check_tag").equals("2")){
	plan_check_tag="审核未通过";
}
%>
['<%=rs.getString("plan_id")%>',
'<%=plan_typeD%>',
'<%=rs.getString("plan_make_time")%>',
'<%=rs.getString("plan_maker")%>',
'<%=rs.getString("plan_register")%>',
'<%=rs.getString("plan_register_time").substring(0,10)%>',
'<%=plan_check_tag %>',
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("<%=page_name%>?id=<%=rs.getString("id") %>")><%=demo.getLang("erp", "变更")%></div>'],


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
