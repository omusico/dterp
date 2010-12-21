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
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%--
int id=Integer.parseInt(request.getParameter("id"));
try{
String sql="DELETE FROM mold_purchase_order_detail WHERE mold_purchase_id = '"+id+"'";
mold_db.executeUpdate(sql);
sql="DELETE FROM mold_info WHERE mold_purchase_id = '"+id+"'";
mold_db.executeUpdate(sql);
sql="DELETE FROM mold_purchase_order WHERE id = '"+id+"'";
mold_db.executeUpdate(sql);
}catch (Exception ex){
ex.printStackTrace();
}
--%>
<%
int id=Integer.parseInt(request.getParameter("id"));
String ex_content=request.getParameter("demand");
try{
	String sql="update mold_purchase_order set  purchase_check_type=2,purchase_ex_content='"+ex_content+"'  where id = '"+id+"'";
	mold_db.executeUpdate(sql);
	mold_db.close();
}catch (Exception ex){
		ex.printStackTrace();
		}

%>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<form method=""	action="" name="myform">
<table  class="TABLE_STYLE3" border="0">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td class="TD_STYLE3">&nbsp;&nbsp;该记录未通过审核,请返回!</td>
		<td  class="TD_STYLE3" align="right">
		<input type="button" align="right" class="BUTTON_STYLE1" value="返回" onClick=location="check_list.jsp">
		</td>
	</tr>
</table>

</form>
</div>