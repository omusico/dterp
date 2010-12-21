<%@page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" import="java.util.*" import="java.io.*"
	import="include.nseer_cookie.*" import="include.nseer_db.*,java.text.*"%>
<%
			nseer_db mold_db = new nseer_db((String) session.getAttribute("unit_db_name"));
			nseer_db mold_db2 = new nseer_db((String) session.getAttribute("unit_db_name"));
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
String destruction_item1_content=request.getParameter("destruction_item1_content");
String destruction_item2_content=request.getParameter("destruction_item2_content");
String destruction_remark=request.getParameter("destruction_remark");
String destruction_man=request.getParameter("destruction_man");
String destruction_time=request.getParameter("destruction_time");
String destruction_item3_content=request.getParameter("destruction_item3_content");
String destruction_item4_content=request.getParameter("destruction_item4_content");


//String spool_num=request.getParameter("spool_num");
//String mold_life=request.getParameter("mold_life");


// 插入模具拆卸单表
String sql = "update mold_destruction set destruction_item1='"+radio1+"',destruction_item1_content='"+destruction_item1_content+"',destruction_item2='"+radio2+"',destruction_item2_content='"+destruction_item2_content+"',destruction_item3='"+radio3+"',destruction_item4='"+radio4+"',destruction_item5='"+radio5+"',destruction_item6='"+radio6+"',destruction_remark='"+destruction_remark+"',destruction_item3_content='"+destruction_item3_content+"',destruction_item4_content='"+destruction_item4_content+"',mold_destruction_change='"+realname+"',mold_destruction_change_time='"+time+"'";


try{

mold_db.executeUpdate(sql);
mold_db.close();

}catch (Exception ex){
mold_db.close();
ex.printStackTrace();
}
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%="您正在做的业务是：模具管理--模具拆卸管理--模具拆卸变更"%></div>
		</td>
	</tr>
</table>
<div id="nseerGround" class="nseerGround">
<form method="post"	action="change_choose_attachment_.jsp">
<table  class="TABLE_STYLE2" border="0">
	<tr  class="TR_STYLE1">
		<td><div>变更已完成!</div></td>
		<td  class="TD_STYLE3">
		<div  class="DIV_STYLE1">
		<input type="button" align="right" class="BUTTON_STYLE1" value="完成" onClick=location="change_list.jsp">
		<input type="submit" align="right" class="BUTTON_STYLE1" value="上传图片">
		<input type="hidden" value="<%=id %>" name="id">
		<input type="hidden" name="destruction_time" value="<%=destruction_time %>">
		</div>
		</td>
	</tr>
</table>

</form>
</div>