<!--
 *this file is part of nseer erp
 
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*,include.nseer_cookie.*" import="java.util.*"
	import="java.io.*"
	import="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.exchange,java.text.*"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：","document_main", "reason", "value");

	nseer_db manufacture_db = new nseer_db((String) session.getAttribute("unit_db_name"));
	nseer_db manufacture_db1 = new nseer_db((String) session.getAttribute("unit_db_name"));
	nseer_db manufacture_db2 = new nseer_db((String) session.getAttribute("unit_db_name"));
	String id=request.getParameter("id");//生产计划id
	
	String realname = (String) session.getAttribute("realeditorc");//审核人
	
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String time = formatter.format(now);//审核时间
%>
<LINK href="../../javascript/table/onlineEditTable.css" type=text/css rel=stylesheet>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script language="javascript">

function TwoSubmit(form){
form.action = "../../manufacture_plan_ActionPlan.do";
var m=document.getElementById("m");
var res=confirm("是否确认该操作？");
	if(res){	
		if (form.Ref[0].checked){
			m.value="delete";
			
		}else{
			m.value="check";
		}
		return true;
	}else{
		return false;
	}
}
</script>

<%--
	String register_time = "";
	String apply_ID = request.getParameter("apply_ID");
	try {
		String sql = "select * from manufacture_apply where apply_ID='"+ apply_ID + "'";
		ResultSet rs = manufacture_db.executeQuery(sql);
		if (rs.next()) {
			String check_time = rs.getString("check_time");
			String checker = rs.getString("checker");
			String remark = rs.getString("remark");
			if (rs.getString("register_time").equals("1800-01-01 00:00:00.0")) {
				register_time = "";
			} else {
				register_time = rs.getString("register_time");
			}
			String check_tag = "";
			String color1 = "#FF9A31";
			String color = "#FF9A31";
			if (rs.getString("check_tag").equals("0")) {
				check_tag = "等待";
			} else if (rs.getString("check_tag").equals("1")) {
				check_tag = "通过";
				color1 = "3333FF";
				color = "3333FF";
			} else if (rs.getString("check_tag").equals("9")) {
				check_tag = "未通过";
				color1 = "red";
				color = "red";
			}
--%>


<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>

<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" method="post" onsubmit="return TwoSubmit(this)">
<table style="width: 100%;" cellpadding="0" cellspacing="0">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8">
		<INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked><%=demo.getLang("erp", "未通过")%>
		<INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind> <%=demo.getLang("erp", "通过")%> 
		<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1">&nbsp;
		<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();">
		</td>
	</tr>
	<tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
</table>

<%
	
	String sql = "select id,plan_make_time,plan_no,plan_check_tag,plan_class,plan_id,plan_type,plan_maker,plan_register,plan_register_time,plan_checker,plan_check_time,plan_remark from product_plan where id="+ id;
	ResultSet rs_all=manufacture_db.executeQuery(sql);
	if(rs_all.next()){
%>
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<input type="hidden" name="plan_no" value="<%=rs_all.getString("plan_no") %>">
	<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "编号")%>：</td>
	<td align=left class="TD_STYLE2" width="40%">
	  <%=rs_all.getString("plan_no")%></td>
	<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%">&nbsp;</td>
	<td align=left class="TD_STYLE2" width="40%">&nbsp;</td>
		
</tr>
</table>
<%if(rs_all.getString("plan_type").equals("1")){ %>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" >
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">
		<font size="4"><b><%=demo.getLang("erp", "4分切生产计划")%></b></font>
		</td>
	</tr>
</table>
<%}else if(rs_all.getString("plan_type").equals("2")){ %>		
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" >
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b>
		<%=demo.getLang("erp", "8mm切生产计划")%>
		</b></font></td>
	</tr>
</table>	
<%}else if(rs_all.getString("plan_type").equals("3")){ %>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" >
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b>
		<%=demo.getLang("erp", "打孔生产计划")%>
		</b></font></td>
	</tr>
</table>
<%}%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<input type="hidden" id="m" name="m" value="check"><%-- action中方法 --%>
		<input type="hidden" name="id" value="<%=id %>">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "制定人")%>：</td>
		<td align=left class="TD_STYLE2" width="40%">
		  <input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="plan_maker" style="width: 150" value="<%=rs_all.getString("plan_maker") %>" onFocus="this.blur()"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "加工日期")%>：</td>
		<td align=left class="TD_STYLE2" width="40%">
		<input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="plan_make_time" style="width: 150" value="<%=rs_all.getString("plan_make_time") %>" onFocus="this.blur()">
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td>
		<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
			<tr <%=TR_STYLE1%> class="TR_STYLE1">
				<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "NO.")%>：</td>
		<td align=left class="TD_STYLE2" width="40%">
		  <input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="plan_id" style="width: 150" value="<%=rs_all.getString("plan_id") %>" onFocus="this.blur()"></td>
		
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "班次")%>&nbsp;&nbsp;：</td>
		<td align=left class="TD_STYLE2" width="40%">
		<%if(rs_all.getString("plan_class").equals("1")){ %>
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="早" onFocus="this.blur()" style="width: 150"> 
		<%}else if(rs_all.getString("plan_class").equals("2")){ %>
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="中" onFocus="this.blur()" style="width: 150">
		<%}else if(rs_all.getString("plan_class").equals("3")){ %>
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="晚" onFocus="this.blur()" style="width: 150">
		<%} %>
		</td>
	</tr>
	
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5" style="width: 94%">
	<%
		
		String sql_details="";
		String sql_num="";
		String sql_crm="";
		String sql_mold="";
		if(rs_all.getString("plan_type").equals("1")){
	%>
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "原纸规格")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "库存数量（本）")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "生产数量（本）")%></td>
	</tr>
	<%		
			//4分切
			sql_details="select id,plan_id,product_spec,plan_count from plan_4_detail where plan_id='"+rs_all.getString("id")+"'";
			ResultSet rs_details=manufacture_db1.executeQuery(sql_details);
			String display_1="";//当前原纸规格
			String display_2="";//计划数量
			String display_3="";//剩余数量

			while(rs_details.next()){
				display_1=rs_details.getString("product_spec");
				display_2=rs_details.getString("plan_count");
//				库存数量查询
				sql_num = "SELECT d.product_name,d.id,count(pi.product_spec_id) as num,d.type FROM"
				+" (select product_spec_id from  product_info p"
				+" where p.product_type=0 and (p.product_status=1 or p.product_status=3) and (stock_id='101' or stock_id='102')) pi"
				+" right join design_file as d on d.id=pi.product_spec_id where "
				+" d.check_tag=1 and d.type=(select id from design_config_public_char where type_name='纸类型')"+" group by d.id having d.product_name = '"+display_1+"'";
				ResultSet rs_num=manufacture_db2.executeQuery(sql_num);
				if(rs_num.next()){
					display_3=rs_num.getString("num");
				}else{
					display_3="0";
				}
	%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=display_1 %>&nbsp;</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=display_3 %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=display_2 %>&nbsp;</td>
	</tr>
	
	<%
			}
		}else if(rs_all.getString("plan_type").equals("2")){
	%>
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "原纸规格")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp", "原料数量（丁）")%></td>
		
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "包装数量（卷）")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "客户")%></td>
		
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "打孔数量（卷）")%></td>
	<tr>	
	<%
			//8mm切
		
			sql_details="select id,plan_id,product_spec,plan_package_count,plan_package_client,plan_produce_count from plan_8mm_detail where plan_id='"+rs_all.getString("id")+"'";
			ResultSet rs_details=manufacture_db1.executeQuery(sql_details);
			
			String crm_name="";

			while(rs_details.next()){
				
				sql_crm="select customer_name FROM crm_file where id="+rs_details.getString("plan_package_client") ;
				ResultSet rs_crm=manufacture_db2.executeQuery(sql_crm);
				if(rs_crm.next()){
					crm_name=rs_crm.getString("customer_name");
				}
				
				int all=0;
				int num1=0;
//				库存数量查询
				sql_num = "SELECT d.product_name,d.id,count(pi.product_spec_id) as num,d.type FROM"
				+" (select product_spec_id from  product_info p"
				+" where p.product_type=1 and (p.product_status=1 or p.product_status=3) and stock_id='103') pi"
				+" right join design_file as d on d.id=pi.product_spec_id where "
				+" d.check_tag=1 and d.type=(select id from design_config_public_char where type_name='纸类型')"+" group by d.id having d.product_name = '"+rs_details.getString("product_spec")+"'";
				ResultSet rs_num=manufacture_db2.executeQuery(sql_num);
				if(rs_num.next()){
					all=Integer.parseInt(rs_num.getString("num"));
				}
				sql_num= "SELECT d.product_name,count(pi.product_spec_id) as num,d.type FROM"
					+" (select product_spec_id from  product_info p"
					+" where p.product_type=0 and (p.product_status=1 or p.product_status=3) and stock_id='102') pi"
					+" right join design_file as d on d.id=pi.product_spec_id where "
					+" d.check_tag=1 and d.type=(select id from design_config_public_char where type_name='纸类型')"+" group by d.id having d.product_name = '"+rs_details.getString("product_spec")+"'";

				ResultSet rs_num1=manufacture_db2.executeQuery(sql_num);
				if(rs_num1.next()){
					num1=Integer.parseInt(rs_num1.getString("num"));
					all=all+num1*4;
				}
			
	%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs_details.getString("product_spec") %>&nbsp;</td>
		
		<%-- 显示原料数量 --%>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=all %>&nbsp;</td>
			
		 
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs_details.getString("plan_package_count") %>&nbsp;</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=crm_name %></td>
		
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs_details.getString("plan_produce_count") %>&nbsp;</td>
	</tr>
	<%		
			}
		}else if(rs_all.getString("plan_type").equals("3")){
	%>
	<tr <%=TR_STYLE2%> class="TR_STYLE2" style="text-align: center;">
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "原纸规格")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "原料数量（卷）")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "模具类型")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "计划设备数")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "生产数量（卷）")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "客户")%></td>
	</tr>	
	<%		
		//打孔
		sql_details="select id,plan_id,product_spec_id,product_spec,mold_id,machine_count,product_count,plan_package_client,plan_produce_count from plan_hole_detail where plan_id='"+rs_all.getString("id")+"'";
		ResultSet rs_details=manufacture_db1.executeQuery(sql_details);
		String crm_name="";
		String mold_name="";
		while(rs_details.next()){
			int all=0;
			int num1=0;
			int num2=0;
//			库存数量查询
			sql_num = "SELECT d.product_name,d.id,count(pi.product_spec_id) as num,d.type FROM"
			+" (select product_spec_id from  product_info p"
			+" where p.product_type=2 and (p.product_status=1 or p.product_status=3) and (stock_id='104' or stock_id='105')) pi"
			+" right join design_file as d on d.id=pi.product_spec_id where "
			+" d.check_tag=1 and d.type=(select id from design_config_public_char where type_name='纸类型')"+" group by d.id having d.product_name = '"+rs_details.getString("product_spec")+"'";
			ResultSet rs_num=manufacture_db2.executeQuery(sql_num);
			if(rs_num.next()){
				all=Integer.parseInt(rs_num.getString("num"));
			}
			sql_num= "SELECT d.product_name,count(pi.product_spec_id) as num,d.type FROM"
				+" (select product_spec_id from  product_info p"
				+" where p.product_type=0 and (p.product_status=1 or p.product_status=3) and stock_id='102') pi"
				+" right join design_file as d on d.id=pi.product_spec_id where "
				+" d.check_tag=1 and d.type=(select id from design_config_public_char where type_name='纸类型')"+" group by d.id having d.product_name = '"+rs_details.getString("product_spec")+"'";

			ResultSet rs_num1=manufacture_db2.executeQuery(sql_num);
			if(rs_num1.next()){
				num1=Integer.parseInt(rs_num1.getString("num"));
				all=all+num1*4*20;
			}
			sql_num= "SELECT d.product_name,count(pi.product_spec_id) as num,d.type FROM"
				+" (select product_spec_id from  product_info p"
				+" where p.product_type=1 and (p.product_status=1 or p.product_status=3) and stock_id='103') pi"
				+" right join design_file as d on d.id=pi.product_spec_id where "
				+" d.check_tag=1 and d.type=(select id from design_config_public_char where type_name='纸类型')"+" group by d.id having d.product_name = '"+rs_details.getString("product_spec")+"'";

			ResultSet rs_num2=manufacture_db2.executeQuery(sql_num);
			if(rs_num2.next()){
				num2=Integer.parseInt(rs_num2.getString("num"));
				all=all+num2*20;
			}
			//模具查询
			sql_mold="select mold_spec FROM mold_info where mold_spec_id="+rs_details.getString("mold_id") ;
			ResultSet rs_mold=manufacture_db2.executeQuery(sql_mold);
			if(rs_mold.next()){
				mold_name=rs_mold.getString("mold_spec");
			}
			//客户查询
			sql_crm="select customer_name FROM crm_file where id="+rs_details.getString("plan_package_client") ;
			ResultSet rs_crm=manufacture_db2.executeQuery(sql_crm);
			if(rs_crm.next()){
				crm_name=rs_crm.getString("customer_name");
			}
	%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs_details.getString("product_spec") %>&nbsp;</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=all %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=mold_name %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs_details.getString("machine_count") %>&nbsp;</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs_details.getString("product_count") %>&nbsp;</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=crm_name %></td>
	</tr>
	<%
		}
		}
	%>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%">
		<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="" onFocus="this.blur()"><%=rs_all.getString("plan_remark") %></textarea>
		</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "登记人")%>&nbsp;&nbsp;：</td>
		<td align=left class="TD_STYLE2" width="40%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs_all.getString("plan_register") %>" onFocus="this.blur()" style="width: 150"></td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "登记时间")%>&nbsp;&nbsp;：</td>
		<td align=left class="TD_STYLE2" width="40%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs_all.getString("plan_register_time") %>" onFocus="this.blur()" style="width: 150"></td>
	</tr>
	
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td colspan="4">
		<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
			<tr <%=TR_STYLE1%> class="TR_STYLE1">
				<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "审核人")%>&nbsp;&nbsp;：</td>
		<td align=left class="TD_STYLE2" width="40%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="plan_checker" type="text" value="<%=realname %>" onFocus="this.blur()" style="width: 150"></td>
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "审核时间")%>&nbsp;&nbsp;：</td>
		<td align=left class="TD_STYLE2" width="40%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="plan_check_time" type="text" value="<%=time.substring(0,10) %>" onFocus="this.blur()" style="width: 150"></td>
		
	</tr>
	
</table>



<%} %>
<%@include file="../include/paper_bottom.html"%>

</form>
</div>
<% 
manufacture_db.close();
manufacture_db1.close();
manufacture_db2.close();

%>
<%--
		}
		manufacture_db.close();
	} catch (Exception ex) {
		out.println("error" + ex);
	}
--%>
