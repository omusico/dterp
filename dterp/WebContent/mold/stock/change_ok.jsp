<%@page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" import="java.util.*" import="java.io.*"
	import="include.nseer_cookie.*" import="include.nseer_db.*,java.text.*"%>
<%
			nseer_db mold_db = new nseer_db((String) session.getAttribute("unit_db_name"));
%>
<%@ taglib uri="/erp" prefix="FCK"%>
<script type="text/javascript" src="/erp/fckeditor.js"></script>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<%
String realname = (String) session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String time=formatter.format(now);
int id=Integer.parseInt(request.getParameter("id"));
String radio1 = request.getParameter("1");
String radio2 = request.getParameter("2");
String radio3 = request.getParameter("3");
String radio4 = request.getParameter("4");
String radio5 = request.getParameter("5");
String radio6 = request.getParameter("6");
String radio7 = request.getParameter("7");
String radio8 = request.getParameter("8");
String radio9 = request.getParameter("9");
String radio10 = request.getParameter("10");
String radio11 = request.getParameter("11");
String mold_stock_remark = request.getParameter("remark");

try{
String sql= "update mold_stock SET top_item1='"+radio1+"',top_item2='"+radio2+"',top_item3='"+radio3+"',top_item4='"+radio4+"',top_item5='"+radio5+"',top_item6='"+radio6+"',bottom_item1='"+radio7+"',bottom_item2='"+radio8+"',bottom_item3='"+radio9+"',bottom_item4='"+radio10+"',bottom_item5='"+radio11+"',mold_stock_change='"+realname +"',mold_stock_change_time='"+time+"',mold_stock_remark='"+mold_stock_remark+"' WHERE mold_id = '"+id+"'";
mold_db.executeUpdate(sql);
mold_db.close();
}catch (Exception ex){
ex.printStackTrace();
}
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%="您正在做的业务是：模具管理--模具库存管理--模具入库变更"%></div>
		</td>
	</tr>
</table>
<div id="nseerGround" class="nseerGround">
<form method=""	action=""ENCTYPE="">
<table  class="TABLE_STYLE2" border="0">
	<tr  class="TR_STYLE1">
		<td><div>该记录已变更,请返回!</div></td>
		<td  class="TD_STYLE3">
		<div  class="DIV_STYLE1">
		<input type="button" align="right" class="BUTTON_STYLE1" value="返回" onClick=location="change_list.jsp"></div>
		</td>
	</tr>
</table>

</form>
