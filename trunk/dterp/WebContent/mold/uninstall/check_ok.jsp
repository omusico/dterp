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
try{
String sql= "update mold_destruction SET mold_destruction_checker = '"+realname+"',mold_destruction_check_time = '"+time+"' WHERE mold_id = '"+id+"'";
mold_db.executeUpdate(sql);

String query="select * from mold_info  WHERE id = '"+id+"'";
ResultSet rs=mold_db2.executeQuery(query);
String type_now="0";
if(rs.next())
{
		String mold_type= rs.getString("mold_type");
		
		if(mold_type.equals("0"))
		{
			type_now="4";
		}
		if(mold_type.equals("1"))
		{
			type_now="5";
		}
}

sql= "update mold_info SET mold_location = '"+type_now+"',mold_life_status='"+6+"' WHERE id = '"+id+"'";
mold_db.executeUpdate(sql);
mold_db.close();
mold_db2.close();
}catch (Exception ex){
ex.printStackTrace();
}
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%="您正在做的业务是：模具管理--模具拆卸管理--模具拆卸审核"%></div>
		</td>
	</tr>
</table>
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