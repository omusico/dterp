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
		<div class="div_handbook"><%="您正在做的业务是：生产管理--异常信息管理--异常信息审核"%></div>
		</td>
	</tr>
</table>
<%
int event_product_id=Integer.parseInt(request.getParameter("event_product_id"));
String even_Id=request.getParameter("even_Id");
try{
String sql= "DELETE FROM event_info WHERE event_product_id = '"+event_product_id+"' and id="+even_Id;
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
		<td><div>该记录未通过审核,请返回!</div></td>
		<td  class="TD_STYLE3">
		<div  class="DIV_STYLE1">
		<input type="button" align="right" class="BUTTON_STYLE1" value="返回" onClick=location="check_list.jsp"></div>
		</td>
	</tr>
</table>

</form>
</div>