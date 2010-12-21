<%@page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" import="java.util.*" import="java.io.*"
	import="include.nseer_cookie.*" import="include.nseer_db.*,java.text.*"%>
<%
			nseer_db manufacture_db = new nseer_db((String) session.getAttribute("unit_db_name"));
%>
<%@ taglib uri="/erp" prefix="FCK"%>
<script type="text/javascript" src="/erp/fckeditor.js"></script>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%="您正在做的业务是：生产管理--异常信息管理--异常信息登记"%></div>
		</td>
	</tr>
</table>
<%
String event_id="1253487121";
String event_name=request.getParameter("event_name"); //事件名
String event_place=request.getParameter("event_place");//场所
int event_product_id=Integer.parseInt(request.getParameter("OnlineEdit3"));
String event_count=request.getParameter("event_count");
String event_exception_count=request.getParameter("event_exception_count");
String event_attach_count=request.getParameter("event_attach_count");
//String event_content=request.getParameter("event_content");
String event_designer=request.getParameter("event_designer");
String event_design_time=request.getParameter("event_design_time");
String event_operater=request.getParameter("event_operater");
String operator_ex =request.getParameter("operator_ex");
String repair_ex  =request.getParameter("repair_ex");
String event_take_time=request.getParameter("event_take_time");

try{
String sql= "insert into event_info(event_id,event_name,event_place,event_product_id,event_count,event_exception_count,event_attach_count,event_designer,event_design_time,event_operater,operator_ex,repair_ex,event_take_time) values ('"+event_id+"','"+event_place+"','"+event_name+"','"+event_product_id+"','"+event_count+"','"+event_exception_count+"','"+event_attach_count+"','"+event_designer+"','"+event_design_time+"','"+event_operater+"','"+operator_ex+"','"+repair_ex+"','"+event_take_time+"')";
 manufacture_db.executeUpdate(sql);
 manufacture_db.close(); // add by wangshaolin
}catch (Exception ex){
ex.printStackTrace();
}
%>
<div id="nseerGround" class="nseerGround">
<form method=""	action=""ENCTYPE="">
<table  class="TABLE_STYLE2" border="0">
	<tr  class="TR_STYLE1">
		<td><div>提交成功，需要审核！</div></td>
		<td  class="TD_STYLE3">
		<div  class="DIV_STYLE1">
		<input type="button" align="right" class="BUTTON_STYLE1" value="返回" onClick=location="register.jsp"></div>
		</td>
	</tr>
</table>

</form>
</div>