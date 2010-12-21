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
	import="java.io.*" import="com.jspsmart.upload.*"
	import="include.nseer_db.*,java.text.*,include.nseer_cookie.*"
	import="javax.servlet.*,javax.servlet.http.*"%>
<%@page import="manufacture.process.FileRead"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<jsp:useBean id="getFileLength" scope="page" class="include.nseer_cookie.getFileLength" />
<jsp:useBean id="UpLoadUrl" scope="page" class="com.common.UpLoadUrl" />
<script type="text/javascript">
<!--
function fishCheck(){
	
	//window.location.href="register_ok.jsp";
	//document.getElementById("div1").style.display="none";
	//document.getElementById("div2").style.display="inline";
	myform.action="../../stock_product_joinStoreAction?m=audting";

}

function registerCheck(){
	window.location.href="register_list.jsp";
}
//-->
</script>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
	
	<%
	nseer_db design_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));
%>

<%
	DealWithString DealWithString = new DealWithString(application);
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：",
			"document_main", "reason", "value");
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1" colspan="2">
		<div class="div_handbook" style="text-align: left"><%=handbook%></div>
		</td>
	</tr>
</table>
<div id="nseerGround" class="nseerGround">
<%
 		try {
 			
 		String orderNumber1 = "";//入库单号
 					
 		mySmartUpload.setCharset("UTF-8");
 		
 		mySmartUpload.initialize(pageContext);
 		
 		String file_type = "txt";
 		
 		long d = getFileLength.getFileLength((String) session.getAttribute("unit_db_name"));
 		
 		mySmartUpload.setMaxFileSize(d);
 		
 		mySmartUpload.setAllowedFilesList(file_type);
 			try{
 			mySmartUpload.upload();
 			}catch(Exception e){
 				%>
				 <script type="text/javascript">window.location.href="register_error6.jsp";</script>
				 <%
				
 			}
		
 			com.jspsmart.upload.SmartFile myFile = mySmartUpload.getFiles().getFile(0);
 			
 			String file_name = myFile.getFileName();
 			
 			String suffName = file_name.substring(file_name.indexOf(".")-1,file_name.indexOf("."));//判断类型
 			
 			String suffix=myFile.getFileExt();//文件后缀名
 			
 			String filePathName = myFile.getFilePathName();
 			
 			ServletContext context = session.getServletContext();
 			
 			//String path = context.getRealPath("/");
 			String path = request.getContextPath();
 			
 			String file = DealWithString.joinIn(filePathName, myFile.getFileName());
 				
 			//获取文件存放文件夹名称
 			String filegroup=file_name.substring(file_name.indexOf("-")+1,file_name.indexOf("."));

 			//获得当前日期
 			java.util.Date now = new java.util.Date();
 			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
 			String time=formatter.format(now);
 			SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 			String time1=formatter1.format(now);
 			SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
 			String time2=formatter2.format(now);
 			String filePath=UpLoadUrl.getUploadUrl()+path+ "/upload_file/scanner_file/"+time+"/"+filegroup+"/" ;//上传文件路径
 			
 			File a=new File(filePath);
 			if(!a.exists()){
 				a.mkdirs();
 			}
 			filePath=filePath+file_name;//
 			
 			myFile.saveAs(filePath);
 			
 			FileRead fileRead1 = new FileRead();
 			List<String> listFile=fileRead1.readDocument(filePath);//获得正确的信息

 			List<String> listInformation = fileRead1.readLotNo(filePath);//获得LOTNO号 或 栈板号
 			List<String> listDepart = fileRead1.readDepart(filePath);//获得库位号 或 托盘
 			List<String> listTop = fileRead1.readInformation(filePath);//获取头部信息
 			
 			String s  = listTop.get(3);
 			String b = listTop.get(3).toLowerCase();
 			
 			if(s.equals("INST2")){
				 listFile=fileRead1.readDocumentS(filePath);//获得正确的信息
	 			 listInformation = fileRead1.readDocumentZ(filePath);//获得LOTNO号 或 栈板号
	 			 listDepart = fileRead1.readDocumentK(filePath);//获得库位号 或 托盘
			}
 			
 			session.setAttribute("listInformation",listInformation);
 			session.setAttribute("listTop",listTop);
 			session.setAttribute("listDepart",listDepart);
 			
 			 Map<String, Integer> map = new HashMap<String, Integer>();
			 //在此声明一个HashMap集合
						        
			 //迭代数组
			 for (String str : listInformation){
			 Integer num = map.get(str);
			 num = (null == num ? 1 : num + 1);
			 map.put(str, num);
			 }
			 
			 if (listInformation.size() != map.size())
			 {
				 %>
				 <script type="text/javascript">window.location.href="register_error3.jsp";</script>
				 <%
				 return;
			 }
			
 			//只有是原材料入库或成品入库才能进行
 			if(s.equals("INST1")||s.equals("INST2")){

 	 			//是否有重复的数据
 	 			if(listTop.get(3).toLowerCase().equals("inst1")){
 	 				for(int i=0;i<listInformation.size();i++){
 	 					String sqlIsNoN = "SELECT replace(product_lot_no,'-','') as lotNo FROM stock_in_detail INNER JOIN product_info ON stock_in_detail.In_Detail_product_id = product_info.id";
 	 					ResultSet rs1=design_db1.executeQuery(sqlIsNoN);
 	 					String lotNo = "";
 	 					while(rs1.next()){
 	 						lotNo = rs1.getString(1);
 	 					
 	 					if(lotNo.equals(listInformation.get(i))){
 	 						design_db1.close();
 	 						%>
 	 						<script type="text/javascript">window.location.href="register_error.jsp";</script>
 	 						<%
 	 						return;
 	 					}}
 	 				}
 	 			}else if(listTop.get(3).toLowerCase().equals("inst2")){
 	 				for(int i=0;i<listInformation.size();i++){
 	 					//0917 lixiaodong 修改In_Detail_pal替换In_Detail_product_id
 	 					String sqlIsNoN = "SELECT package_pallet FROM stock_in_detail INNER JOIN package_info ON stock_in_detail.In_Detail_pal = package_info.package_pallet";
 	 					ResultSet rs1=design_db1.executeQuery(sqlIsNoN);
 	 					String lotNo = "";
 	 					while(rs1.next()){
 	 						lotNo = rs1.getString(1);
 	 					
 	 					if(lotNo.equals(listInformation.get(i))){
 	 						design_db1.close();
 	 						%>
 	 						<script type="text/javascript">window.location.href="register_error1.jsp";</script>
 	 						<%
 	 						return;
 	 					}
 	 					
 	 					}
 	 				}
 	 			}
 				
 			String personId = listTop.get(2);//经办人Id
 			
 			String orderNumber = fileRead1.getOrderNumber();//入库单号 
 			
 			orderNumber1=orderNumber;
 			
 			String lotNo = listInformation.get(0);//LOTNO
 			String sqlOrderNumber="";
 			if(s.equals("INST2")){
 				sqlOrderNumber = "select stock_in_apply.id,stock_in_apply.apply_in_apply_count from stock_in_apply_detail inner join package_info on package_info.id = stock_in_apply_detail.In_Detail_product_id inner join stock_in_apply on stock_in_apply.id = stock_in_apply_detail.apply_in_id where package_pallet='"+lotNo+"' and stock_in_apply.apply_in_apply_check_status=1 and apply_in_apply_reason_id=4";
 			}else if(s.equals("INST1")){
 				sqlOrderNumber = "select stock_in_apply.id,stock_in_apply.apply_in_apply_count from stock_in_apply_detail right join product_info on product_info.id = stock_in_apply_detail.In_Detail_product_id inner join stock_in_apply on stock_in_apply.id = stock_in_apply_detail.apply_in_id where replace(product_info.product_lot_no,'-','')='"+lotNo+"' and stock_in_apply.apply_in_apply_check_status=1 and apply_in_apply_reason_id=2";
 			}
 			ResultSet rsOrderNumber=design_db1.executeQuery(sqlOrderNumber);
 			int comeOrderNumberId = 0;//入库申请单号
 			int comeOrderNumberCount = 0;//入库单数量
 			if(rsOrderNumber.next()){
 				comeOrderNumberId = rsOrderNumber.getInt("stock_in_apply.id");
 				comeOrderNumberCount = rsOrderNumber.getInt("stock_in_apply.apply_in_apply_count");
 			}else{
 				design_db1.close();
 				%>
 				<script type="text/javascript">window.location.href="register_error4.jsp";</script>
 				<%
 				return;
 			}
 			
// 			判断入库申请产品与入库产品数量
 			if(comeOrderNumberCount<listInformation.size()){
 				design_db1.close();
 				%>
 				<script type="text/javascript">
 				window.location.href="register_error5.jsp";
 				</script>
 				<%
 				return;
 			}
 			
 			int departId = 0;//入库理由ID
 			if(listTop.get(3).toLowerCase().equals("inst1")){
 				departId=2;
 			}else if(listTop.get(3).toLowerCase().equals("inst2")){
 				departId=4;
 			}
 			int stockCount = listDepart.size();//入库件数
 	
%>
<div id="div1" style="display: inline">
<form name="myform" action="../../stock_product_joinStoreAction.do?m=audting" method="post" >
<input type="hidden" name="time2" value="<%=time2 %>" /> 
<input type="hidden" name="personId" value="<%=personId %>" /> 
<input type="hidden" name="departId" value="<%=departId %>" /> 
<input type="hidden" name="time1" value="<%=time1 %>" /> 
<input type="hidden" name="stockCount" value="<%=stockCount %>" /> 
<input type="hidden" name="comeOrderNumberId" value="<%=comeOrderNumberId %>" /> 
<input type="hidden" name="s" value="<%=s %>" /> 
<input type="hidden" name="file_name" value="<%=file_name %>" /> 

<div style="text-align: right">
<input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","确认")%>">
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="javascript:window.history.back()" value="<%=demo.getLang("erp","返回")%>">
<br/>
</div>
<table width="80%" align="center">
<tr>
<td>

读取文件：<%=file_name %>  &nbsp;&nbsp;&nbsp; 
<%if(listTop.get(3).toLowerCase().equals("inst1")){ %>
原料入库
<%}else if(listTop.get(3).toLowerCase().equals("inst2")){ %>
成品入库
<%} %>
<BR />
 <%

 //如果是成品入库则显示成品信息
 if(listTop.get(3).toLowerCase().equals("inst2")){
	 //从文件流中读出的数据依次和数据库中的成品对比，如果栈板号有相同的，则显示到页面
	 for(int i=0;i<listInformation.size();i++){	
		 String sql = "select package_pallet,product_spec,package_pallet from package_info";
		 ResultSet rsDocument = design_db1.executeQuery(sql);
	 while(rsDocument.next()){
		 if(rsDocument.getString("package_pallet").equals(listInformation.get(i))){
	 %>
	 <br />
	原纸规格：<%=rsDocument.getString("product_spec") %> &nbsp;&nbsp;栈板号：<%=rsDocument.getString("package_pallet") %>   &nbsp;&nbsp;库位： <%=listDepart.get(i) %> <br />

	 <%
		 }
	 }
	 }
 }else{
 for(int i=0;i<listInformation.size();i++){	
	 String sql = "select REPLACE(product_lot_no,'-','') as lotNo,product_lot_no,product_spec,product_stock from product_info";
	 ResultSet rsDocument = design_db1.executeQuery(sql);
 while(rsDocument.next()){
	 if(rsDocument.getString("lotNo").equals(listInformation.get(i))){
 %>
 <br />
原纸规格：<%=rsDocument.getString("product_spec") %>&nbsp;&nbsp;LotNo：<%=rsDocument.getString("product_lot_no") %>   &nbsp;&nbsp;库位： <%=listDepart.get(i) %> <br />

 <%
	 }
 }
 }
 }
 %>
</td>
</tr>
</table>

</form>
</div>

</div>
<%
 			}else{
 				%>
 				<script type="text/javascript">window.location.href="fish_register_list.jsp";</script>
 				<%	
 			}
	} catch (Exception ex) {
		//ex.printStackTrace();
	} finally{
		try{
			design_db1.close();
			}catch(Exception e){
				//e.printStackTrace();
			}
	}
	
%>

 