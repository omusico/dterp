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
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：",
			"document_main", "reason", "value");
%>
<%
int id=Integer.parseInt(request.getParameter("id"));
try{
String sql="DELETE FROM mold_assembly_installation WHERE mold_id = '"+id+"'";
mold_db.executeUpdate(sql);
sql="update mold_info set mold_life_status = 2,mold_machine_number=0,assembler='',assembly_time='',top_mold_code='',bottom_mold_code='',lock_code='',installer='',installation_time='' WHERE id = '"+id+"'";
mold_db.executeUpdate(sql);
mold_db.close();
}catch (Exception ex){
ex.printStackTrace();
}
%>
<div id="nseerGround" class="nseerGround">
<form method=""	action="">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<table  class="TABLE_STYLE2" border="0">
	<tr  class="TR_STYLE1">
		<td><div>&nbsp;&nbsp;该记录未通过审核,请返回!</div></td>
		<td  class="TD_STYLE3">
		<div  class="DIV_STYLE1">
		<input type="button" align="right" class="BUTTON_STYLE1" value="返回" onClick=location="check_list.jsp"></div>
		</td>
	</tr>
</table>

</form>
</div>