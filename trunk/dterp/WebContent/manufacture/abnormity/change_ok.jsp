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
		<div class="div_handbook"><%="您正在做的业务是：生产管理--异常信息管理--异常信息变更"%></div>
		</td>
	</tr>
</table>	
<%

String event_name=request.getParameter("event_name");
String event_count=request.getParameter("event_count");
String event_exception_count=request.getParameter("event_exception_count");
String event_attach_count=request.getParameter("event_attach_count");
String event_take_time=request.getParameter("event_take_time");
String operator_ex =request.getParameter("operator_ex");
String repair_ex  =request.getParameter("repair_ex");


String realname = (String) session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String time=formatter.format(now);
String even_Id=request.getParameter("even_Id");
int event_product_id=Integer.parseInt(request.getParameter("event_product_id"));
String quality_ex=request.getParameter("quality_ex");
try{
String sql= "update event_info SET event_name='"+event_name+"',event_count='"+event_count+"',event_exception_count='"+event_exception_count+"',event_attach_count='"+event_attach_count+"',event_take_time='"+event_take_time+"',operator_ex='"+operator_ex+"',repair_ex='"+repair_ex+"' WHERE event_product_id = '"+event_product_id+"' and id="+even_Id;
 manufacture_db.executeUpdate(sql);
 manufacture_db.close();// add by wangshaolin
}catch (Exception ex){
ex.printStackTrace();
}
%>
<div id="nseerGround" class="nseerGround">
<form method=""	action=""ENCTYPE="">
<table  class="TABLE_STYLE2" border="0">
	<tr  class="TR_STYLE1">
		<td><div>该记录变更完成,请返回!</div></td>
		<td  class="TD_STYLE3">
		<div  class="DIV_STYLE1">
		<input type="button" align="right" class="BUTTON_STYLE1" value="返回" onClick=location="change_list.jsp"></div>
		</td>
	</tr>
</table>

</form>
</div>