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
	String human_ID=request.getParameter("human_ID");
	nseer_db manufacture_db = new nseer_db((String) session.getAttribute("unit_db_name"));
	nseer_db manufacture_db1 = new nseer_db((String) session.getAttribute("unit_db_name"));
	nseer_db manufacture_db2 = new nseer_db((String) session.getAttribute("unit_db_name"));
	String id=request.getParameter("id");
%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script type="text/javascript">
//表单验证
function validateForm(){
	var flag=true;
	//判断文件是否为空
	if(mutiValidation.file1.value=="")
	{
		alert("请选择读取的文件");
		return false;
	}else{
	var fileName = mutiValidation.file1.value;
	var sufferName = fileName.substring(fileName.indexOf(".")-1,fileName.indexOf("."));
	if(sufferName!="I"){
		alert("您上传的类型不是有效文件，请核对后重新上传！");
		return false;
	}else{
		return true;
	}
	}
}
</script>

<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%=handbook%></div>
		</td>
	</tr>
</table>
<form id="mutiValidation" ENCTYPE="multipart/form-data" method="POST" action="register_3.jsp?id=<%=id %>&human_ID=<%=human_ID %>" onsubmit="return validateForm()">

<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td bordercolorlight=#848284 bordercolordark=#ffffff class="TD_STYLE8" align="left" style="width: 70%">
		<%=demo.getLang("erp", "读取文件")%>&nbsp;&nbsp;：
		<input type="file" <%=FILE_STYLE1%> contenteditable="false" class="FILE_STYLE1" name="file1" size="70">
		</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8">
		<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","读取文件信息")%>">&nbsp;
		<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();">
		</td>
	</tr>
</table>
<input name="id" type="hidden" value="<%=id %>"><%-- 计划id隐藏域 --%>
<input name="human_ID" type="hidden" value="<%=human_ID %>">
</form>


<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>
<%
	
	String sql = "select id,plan_check_tag,plan_class,plan_id,plan_type,plan_maker,plan_register,plan_register_time,plan_checker,plan_check_time,plan_remark from product_plan where id="+ id;
	ResultSet rs_all=manufacture_db.executeQuery(sql);
	if(rs_all.next()){
%>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<%if(rs_all.getString("plan_type").equals("1")){ %>
		<td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp", "4分切生产计划")%></b></font></td>
		<%}else if(rs_all.getString("plan_type").equals("2")){ %>
		<td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp", "8mm切生产计划")%></b></font></td>
		<%}else if(rs_all.getString("plan_type").equals("3")){ %>
		<td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp", "打孔生产计划")%></b></font></td>
		<%}%>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
	</tr>
</table>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "制定人")%>&nbsp;&nbsp;：</td>
		<td align=left class="TD_STYLE2" width="40%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs_all.getString("plan_maker") %>" onFocus="this.blur()" style="width: 150"></td>
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
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5" style="width: 90%">
	
	<%
		
		String sql_details="";
		String sql_num="";
		String sql_crm="";
		String sql_mold="";
		if(rs_all.getString("plan_type").equals("1")){
	%>
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "原纸规格")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "计划数量（本）")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "调度数量（本）")%></td>
	</tr>
	<%		
			//4分切
			sql_details="select id,plan_id,product_spec,plan_count from plan_4_detail where plan_id='"+rs_all.getString("id")+"'";
			ResultSet rs_details=manufacture_db1.executeQuery(sql_details);
			String display_1="";//当前原纸规格
			String display_2="";//计划数量
			String display_3="";//调度数量
			
			while(rs_details.next()){
				display_1=rs_details.getString("product_spec");
				display_2=rs_details.getString("plan_count");
//				得到调度数量
				String sql_3="select count(id) as tdnum from product_info where product_material_plan_id='"
					+id+"' and product_spec='"+display_1+"' and product_pstatus!='2'";
				ResultSet rs_3=manufacture_db2.executeQuery(sql_3);
				if(rs_3.next()){
					display_3=rs_3.getString("tdnum");
				}
	%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=display_1 %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" style="text-align: center" name="num_1" type="text" onFocus="this.blur()" value="<%=display_2 %>"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" style="text-align: center" name="num_2" type="text" onFocus="this.blur()" value="<%=display_3 %>"></td>
	</tr>
	
	<%
			}
		}else if(rs_all.getString("plan_type").equals("2")){
	%>
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
		
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "原纸规格")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "计划数量（卷）")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "计划数量（丁）")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "调度数量（丁）")%></td>
	<tr>	
	<%
			//8mm切
		
			sql_details="select id,plan_id,product_spec,plan_package_count,plan_package_client,plan_produce_count from plan_8mm_detail where plan_id='"+rs_all.getString("id")+"'";
			ResultSet rs_details=manufacture_db1.executeQuery(sql_details);
			String crm_name="";
			String display_1="";//当前原纸规格
			String display_2="";//计划数量
			String display_3="";//调度数量
			//客户查询
			while(rs_details.next()){
				display_1=rs_details.getString("product_spec");
				//得到计划数量
				String display_2_1=rs_details.getString("plan_package_count");
				int d21=Integer.parseInt(display_2_1);
				String display_2_2=rs_details.getString("plan_produce_count");
				int d22=Integer.parseInt(display_2_2);
				display_2=String.valueOf(d21+d22);
				int num2=(int)Math.ceil((Integer.parseInt(display_2)/20.0));
				
			    //String.valueOf((int)((Integer.parseInt(rs_details.getString("plan_package_count"))+Integer.parseInt(rs_details.getString("plan_produce_count")))/20)+1);
				sql_crm="select customer_name FROM crm_file where id="+rs_details.getString("plan_package_client") ;
				ResultSet rs_crm=manufacture_db2.executeQuery(sql_crm);
				if(rs_crm.next()){
					crm_name=rs_crm.getString("customer_name");
				}
				//得到调度数量
				String sql_3="select count(id) as tdnum from product_info where product_material_plan_id='"
					+id+"' and product_spec='"+display_1+"' and product_pstatus!='2'";
				ResultSet rs_3=manufacture_db2.executeQuery(sql_3);
				if(rs_3.next()){
					display_3=rs_3.getString("tdnum");
				}
	%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs_details.getString("product_spec") %></td>
		
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="" style="text-align: center" type="text" onFocus="this.blur()" value="<%=display_2 %>"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="num_1" style="text-align: center" type="text" onFocus="this.blur()" value="<%=num2 %>"></td>
		
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="num_2" style="text-align: center" type="text" onFocus="this.blur()" value="<%=display_3 %>"></td>
	</tr>
	<%		
			}
		}else if(rs_all.getString("plan_type").equals("3")){
	%>
	<tr <%=TR_STYLE2%> class="TR_STYLE2" style="text-align: center;">
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "原纸规格")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "模具类型")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "计划设备数")%></td>
		
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "客户")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "计划数量（卷）")%></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=demo.getLang("erp", "调度数量（卷）")%></td>
	</tr>	
	<%		


		//打孔
		sql_details="select id,plan_id,product_spec_id,product_spec,mold_id,machine_count,product_count,plan_package_client,plan_produce_count from plan_hole_detail where plan_id='"+rs_all.getString("id")+"'";
		ResultSet rs_details=manufacture_db1.executeQuery(sql_details);
		String crm_name="";
		String mold_name="";
		String display_1="";//当前原纸规格
		String display_2="";//计划数量
		String display_3="";//调度数量
		while(rs_details.next()){
			//得到计划数量
			display_1=rs_details.getString("product_spec");
			display_2=rs_details.getString("product_count");
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
			
//			 根据机器号查出模具号
			String mold_id = "";
			String mold_spec = "";
			String mold_spec_id="";
			String mold_machine_number="";
			// 机器号和生产状态是3——生产中    mold_life_status=8安装已审核并且没有报废
			String sql_q = "select mold_spec_id,mold_code,mold_spec,mold_machine_number from mold_info where mold_spec_id="
					+ rs_details.getString("mold_id")
					+ " and mold_type!=3 and mold_life_status=8";
			ResultSet rs_mold_id = manufacture_db2
					.executeQuery(sql_q);
			if (rs_mold_id.next()) {
				mold_id = rs_mold_id
						.getString("mold_code");
				mold_spec = rs_mold_id
						.getString("mold_spec");
				mold_spec_id = rs_mold_id
						.getString("mold_spec_id");
				mold_machine_number=rs_mold_id
						.getString("mold_machine_number");
			}
			
			
			
			//得到调度数量
			String sql_3="select count(id) as tdnum from product_info where product_material_plan_id='"
				+id+"' and product_spec='"+display_1+"' and product_machine='"+mold_machine_number+"' and product_pstatus!='2'";
			ResultSet rs_3=manufacture_db2.executeQuery(sql_3);
			if(rs_3.next()){
				display_3=rs_3.getString("tdnum");
			}
	%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs_details.getString("product_spec") %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=mold_name %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs_details.getString("machine_count") %></td>
		
		<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=crm_name %></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" style="text-align: center" name="num_1" type="text" onFocus="this.blur()" value="<%=display_2 %>"></td>
		<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" style="text-align: center" name="num_2" type="text" onFocus="this.blur()" value="<%=display_3 %>"></td>
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
		<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="plan_remark" onFocus="this.blur()"><%=rs_all.getString("plan_remark") %></textarea>
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
	<%if(rs_all.getString("plan_check_tag").equals("1")){ %>
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
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs_all.getString("plan_checker") %>" onFocus="this.blur()" style="width: 150"></td>
		
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp", "审核时间")%>&nbsp;&nbsp;：</td>
		<td align=left class="TD_STYLE2" width="40%">
		<input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="" type="text" value="<%=rs_all.getString("plan_check_time") %>" onFocus="this.blur()" style="width: 150"></td>
		
	</tr>
	<%} %>
</table>


<%} %>
<%@include file="../include/paper_bottom.html"%>
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
