<%@page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" import="java.util.*" import="java.io.*"
	import="include.nseer_cookie.*" import="include.nseer_db.*,java.text.*"%>

<%@ taglib uri="/erp" prefix="FCK"%>
<script type="text/javascript" src="/erp/fckeditor.js"></script>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<%--
String realname = (String) session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm s");
String time=formatter.format(now);
int id=Integer.parseInt(request.getParameter("id"));
try{
String sql= "update mold_purchase_order SET purchase_checker = '"+realname+"',purchase_check_time = '"+time+"',purchase_check_type = '"+1+"' WHERE id = '"+id+"'";
mold_db.executeUpdate(sql);
sql= "update mold_info SET mold_location = '"+1+"' WHERE mold_purchase_id = '"+id+"'";
mold_db.executeUpdate(sql);
}catch (Exception ex){
ex.printStackTrace();
}
--%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%="您正在做的业务是：模具管理--模具组装管理--模具组装登记"%></div>
		</td>
	</tr>
</table>
<div id="nseerGround" class="nseerGround">
<form method=""	action=""ENCTYPE="">
<table  class="TABLE_STYLE2" border="0">
	<tr  class="TR_STYLE1">
		<td><div>模具组装安装登记成功，请点击完成</div></td>
		<td  class="TD_STYLE3">
		<div  class="DIV_STYLE1">
		<input type="button" align="right" class="BUTTON_STYLE1" value="完成" onClick=location="register.jsp"></div>
		</td>
	</tr>
</table>

</form>
</div>