<%@page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" import="java.util.*" import="java.io.*"
	import="include.nseer_cookie.*" import="include.nseer_db.*,java.text.*"%>
<%
			
nseer_db_backup1 stock_dbFist = new nseer_db_backup1(application);// baseDao通用组件，里面封闭有对数据库操作的方法
%>
<%@ taglib uri="/erp" prefix="FCK"%>
<script type="text/javascript" src="/erp/fckeditor.js"></script>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<%
String realname = (String) session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm s");
String time=formatter.format(now);
int id=Integer.parseInt(request.getParameter("id"));
try{
	if(stock_dbFist.conn((String) session.getAttribute("unit_db_name"))){
String sql= "update mold_purchase_order SET purchase_checker = '"+realname+"',purchase_check_time = '"+time+"',purchase_check_type = '"+1+"' WHERE id = '"+id+"'";
stock_dbFist.executeUpdate(sql);
stock_dbFist.commit();
//sql= "update mold_info SET mold_location = '"+1+"' WHERE mold_purchase_id = '"+id+"'";
//mold_db.executeUpdate(sql);
	}
stock_dbFist.close();
}catch (Exception ex){
ex.printStackTrace();
}
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%="您正在做的业务是：模具管理--模具采购管理--模具采购审核"%></div>
		</td>
	</tr>
</table>
<br />
<div id="nseerGround" class="nseerGround">
<form method=""	action=""ENCTYPE="">
<table  class="TABLE_STYLE2" border="0">
	<tr  class="TR_STYLE1">
		<td><div>该记录已通过审核,请返回!</div></td>
		<td  class="TD_STYLE3">
		<div  class="DIV_STYLE1">
		<input type="button" align="right" class="BUTTON_STYLE1" value="返回" onClick=location="check_list.jsp"></div>
		</td>
	</tr>
</table>

</form>
</div>