
<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
 
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%//nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%//nseer_db stockdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@page import="manufacture.process.FileRead"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_gather.xml"/>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
 <div style=" font-size: 12px; color:#0000FF ">您正在做的业务是：库存管理--库存管理--成品内容替换</div></td>
 </tr>
 </table>
 <script>
 function fishCheck(){
 
 window.location.href="fish_register_list.jsp";
 
 }
 </script>
 <%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
 <%nseer_db design_db2 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
 <%nseer_db design_db3 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
 
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
 <%
 nseer_db_backup hr_db = new nseer_db_backup(application);
 nseer_db_backup1 stock_db1 = new nseer_db_backup1(application);// baseDao通用组件，里面封闭有对数据库操作的方法
	try {
				
	mySmartUpload.setCharset("UTF-8");
	
	mySmartUpload.initialize(pageContext);
	
	String file_type = "txt";
	
	long d = getFileLength.getFileLength((String) session.getAttribute("unit_db_name"));
	
	mySmartUpload.setMaxFileSize(d);
	
	mySmartUpload.setAllowedFilesList(file_type);
	
		mySmartUpload.upload();
	
		com.jspsmart.upload.SmartFile myFile = mySmartUpload.getFiles().getFile(0);
		
		String file_name = myFile.getFileName();
		String filePathName = myFile.getFilePathName();
		
		ServletContext context = session.getServletContext();
		
		String path = context.getRealPath("/");
		
		String file = DealWithString.joinIn(filePathName, myFile.getFileName());
		
		//String filePath=path + "stock/filePathDocument/" + file_name;//上传文件路径
	
		//获取文件存放文件夹名称
		String filegroup=file_name.substring(file_name.indexOf("-")+1,file_name.indexOf("."));

		//获得当前日期
		java.util.Date now = new java.util.Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		String time=formatter.format(now);
		String filePath=path + "/upload_file/scanner_file/"+time+"/"+filegroup+"/" ;//上传文件路径
		
		String suffName = file_name.substring(file_name.indexOf(".")-1,file_name.indexOf("."));//判断类型
			
			if(!suffName.equals("L")){
				 %>
			 <script type="text/javascript">window.location.href="register_error6.jsp";</script>
			 <%
			 return;
			}
		
		File a=new File(filePath);
		if(!a.exists()){
			a.mkdirs();
		}
		filePath=filePath+file_name;//
		
		myFile.saveAs(filePath);//上传完成
		
		FileRead fileRead = new FileRead();
		//Map<Integer,String> files=fileRead.readF2(filePath);
		//List<String> listFirst = new ArrayList<String>();
		List<String> fistFirst = fileRead.readSuccessList(filePath);//获得替换的内容
		List<String> fistMiddle = fileRead.readSuccessMiddle(filePath);//获得栈板号
		List<String> fistList = fileRead.readSuccessFirst(filePath);//获得被替换内容
		//判断是否有重复数据，如果有，则返回成品替换页面
		for(int i=0;i<fistFirst.size();i++){
			if(i==fistFirst.size()-1){
				break;
			}
			String first = fistFirst.get(i);
			String second = fistFirst.get(i+1);
			
			if(first.equals(second)){
				//跳回成品替换页面
				%>
				<script type="text/javascript">
<!--

window.location.href="register_error.jsp";
//-->
</script>
				<%
				return;
			}
		}
		for(int i=0;i<fistList.size();i++){
			if(fistList.size()-1==i){
				break;
			}
			String first = fistList.get(i);
			String second = fistList.get(i+1);
			
			if(first.equals(second)){
				//跳回成品替换页面
				%>
				<script type="text/javascript">
<!--
window.location.href="register_error.jsp";
//-->
</script>
				<%
				return;
			}
		}
		
		if(fistFirst.size()!=fistList.size()){
			%>
			<script type="text/javascript">
<!--
		window.location.href="register_error1.jsp";
//-->
</script>
			<%return;
			}
		
		//获得被替换内容，更新数据，使包装信息ID为零
		if (stock_db1.conn((String) session.getAttribute("unit_db_name"))) {
			for(int i=0;i<fistList.size();i++){
				String sql = "select id from product_info where replace(product_lot_no,'-','')='"+fistList.get(i)+"'";
				ResultSet rs1 = stock_db1.executeQuery(sql);
				int k = 0;
				if(rs1.next()){
					if(k!=0){
						k=0;
					}
					k++;
				}
				if(k==0){
					%>
						<script type="text/javascript">
<!--
		window.location.href="register_error2.jsp";
//-->
</script>
					
					<%return;
				}
			}
			for(int i=0;i<fistList.size();i++){
				
				
				
				
				String sql = "update product_info set package_id=0 where replace(product_lot_no,'-','')='"+fistList.get(i)+"'";
				stock_db1.executeUpdate(sql);
			}
			//获得栈板号，查找包装信息ID（一条）
			int packageInfoId = 0;
			String sqlPackageInfo = "select id from package_info where package_pallet='"+fistMiddle.get(0)+"'";
			ResultSet rsPackage=design_db.executeQuery(sqlPackageInfo);
			int q = 0;
			if(rsPackage.next()){
				if(q!=0){
					q=0;
				}
				packageInfoId = rsPackage.getInt("ID");
				q++;
			}
			if(q==0){
				%>
				<script type="text/javascript">
<!--
		window.location.href="register_error3.jsp";
//-->
</script>
				<%return;
			}
			for(int i=0;i<fistFirst.size();i++){
				String sql = "select id from product_info where replace(product_lot_no,'-','')='"+fistFirst.get(i)+"'";
				ResultSet rs1 = stock_db1.executeQuery(sql);
				int k = 0;
				if(rs1.next()){
					if(k!=0){
						k=0;
					}
					k++;
				}
				if(k==0){
					%>
<script type="text/javascript">
	window.location.href="register_error4.jsp";
<!--

//-->
</script>
<%return;
				}
			}
			//获得替换内容，更新数据，使数据包装ID添加到每条数据中
			for(int i=0;i<fistFirst.size();i++){
				String sql = "update product_info set package_id="+packageInfoId+" where replace(product_lot_no,'-','')='"+fistFirst.get(i)+"'";
				stock_db1.executeUpdate(sql);
			}
			String sql_update_package2="update package_info set package_count=package_count-"+fistList.size()+" where id="+packageInfoId;
			stock_db1.executeUpdate(sql_update_package2);
			sql_update_package2="update package_info set package_count=package_count+"+fistFirst.size()+" where id="+packageInfoId;
			stock_db1.executeUpdate(sql_update_package2);
			
		}
		%>
<form name="" id="" action="" method="post">

<div style="text-align: right">
<input type="button" <%=BUTTON_STYLE1%> onclick="javascript:window.location.href='read_pgq_ok.jsp'" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确认")%>">
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" <%=BUTTON_STYLE1%> onclick="javascript:window.history.back()" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>">
<br/>
</div>
</form>
<table width="80%" align="center">
<tr>
<td>

<%
String sqlFirst = "select product_spec,mold_spec from package_info where package_pallet='"+fistMiddle.get(0)+"'";
ResultSet rsFirst = design_db2.executeQuery(sqlFirst);
if(rsFirst.next()){
%>
原纸类型：<%=rsFirst.getString("product_spec") %>  &nbsp;&nbsp;&nbsp;
类型&nbsp; <%=rsFirst.getString("mold_spec") %> &nbsp; 栈板号&nbsp;<%=fistMiddle.get(0) %> 
<br /><br />
<%
	}
//页面
//循环被替换产品 显示相关信息 再取替换产品的LotNo
for(int i=0;i<fistList.size();i++){
	//通过LOTNO号去原料产品表查找包装信息表的相当信息以下面显示
	String sql_len2 = "select product_lot_no from product_info where replace(product_lot_no,'-','')='"+fistList.get(i)+"'";
ResultSet rs_result2 = design_db2.executeQuery(sql_len2);
if(rs_result2.next()){ 
	
%>

Lot.No <%=rs_result2.getString(1) %>
<%} %>替换为
<%
String sql_len1 = "select product_lot_no from product_info where replace(product_lot_no,'-','')='"+fistFirst.get(i)+"'";
ResultSet rs_result = design_db2.executeQuery(sql_len1);
if(rs_result.next()){
%>
Lot.No <%=rs_result.getString(1)%>
<%} %>
<br /><br />
<%

}
//并与之显示所有与栈板号相关的原材料产品信息
%>
<br /><br />
<table style="border: 1px solid;border-collapse: collapse;width: 40%;border-color: black" align="left" cols=1 id=tableOnlineEdit1>
<thead>


 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","原纸规格")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","LOT No.")%></td>
 </tr>
 <%
 for(int i=0;i<fistList.size();i++){
	 String sql_len1 = "select product_lot_no,product_spec from product_info where replace(product_lot_no,'-','')='"+fistFirst.get(i)+"'";
	 ResultSet rsPall = design_db2.executeQuery(sql_len1);
	 if(rsPall.next()){
		 %>
<tr <%=TR_STYLE1%> class="TR_STYLE1" >
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rsPall.getString("product_spec") %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rsPall.getString("product_lot_no") %></td>
 </tr>
		 <%}} %>
</thead>
</table>

<%
	} catch (Exception ex) {
		%>
		 <script type="text/javascript">window.location.href="register_error6.jsp";</script>
		 <%
	}
	stock_db1.commit();
	design_db.close();//关闭连接
	stock_db1.close();//关闭连接
	design_db2.close();
	design_db3.close();
 %>

<%@include file="../../include/head_msg.jsp"%>
