/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.process;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;

import java.io.*;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import include.nseer_db.*;
import include.nseer_cookie.*;

import com.common.UpLoadUrl;
import com.jspsmart.upload.SmartUpload;

public class tempStock extends HttpServlet {// 创建方法
	ServletContext application;

	HttpSession session;

	

	public synchronized void service(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this, request,
				response, "", true, 8192, true);
		ServletContext dbApplication = dbSession.getServletContext();

		getFileLength getFileLength = new getFileLength();
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
		nseer_db_backup1 hr_db1 = new nseer_db_backup1(dbApplication);
		
		//nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication); modify by wangshaolin
		SmartUpload mySmartUpload = new SmartUpload();
		mySmartUpload.setCharset("UTF-8");
		if (hr_db.conn((String) dbSession.getAttribute("unit_db_name"))&&hr_db1.conn((String) dbSession.getAttribute("unit_db_name"))) {

			mySmartUpload.setCharset("UTF-8");
			mySmartUpload.initialize(pageContext);
			String file_type = "txt";

			mySmartUpload.setAllowedFilesList(file_type);
			try {
				mySmartUpload.upload();
				com.jspsmart.upload.SmartFile myFile = mySmartUpload.getFiles()
						.getFile(0);
				String file_name = myFile.getFileName();
				ServletContext context = session.getServletContext();
				String path = request.getContextPath();
				
				String suffName = file_name.substring(file_name.indexOf(".")-1,file_name.indexOf("."));//判断类型
				
				if((!suffName.equals("B"))&&(!suffName.equals("C"))&&(!suffName.equals("D"))&&(!suffName.equals("E"))&&(!suffName.equals("F"))&&(!suffName.equals("G"))&&(!suffName.equals("O"))&&(!suffName.equals("P"))){
					response.sendRedirect("manufacture/process/register_error6.jsp");
				 return;
				}

				// 获取文件存放文件夹名称
				String filegroup = file_name.substring(
						file_name.indexOf("-") + 1, file_name.indexOf("."));

				// 获得当前日期
				java.util.Date now = new java.util.Date();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
				String time = formatter.format(now);
				String filePath =UpLoadUrl.getUploadUrl()+path+ "/upload_file/scanner_file/" + time + "/"
						+ filegroup + "/";// 上传文件路径

				File a = new File(filePath);
				if (!a.exists()) {
					a.mkdirs();
				}
				filePath = filePath + file_name;//

				myFile.saveAs(filePath);

				FileRead fileRead1 = new FileRead();
	 			List<String> listFile=fileRead1.readDocument(filePath);//获得正确的信息
	 			List<String> listInformation = fileRead1.readLotNo(filePath);//获得LOTNO号 或 栈板号
	 			List<String> listDepart = fileRead1.readDepart(filePath);//获得库位号 或 托盘
	 			List<String> listTop = fileRead1.readInformation(filePath);//获取头部信息
	 			String s  = listTop.get(3);
	 			String deapat = listTop.get(3).toLowerCase();
	 			//只有8MM切  4分切， 原纸  打孔可以更新数据库Z
			if(deapat.equals("inst3")||deapat.equals("inst4")||deapat.equals("inst5")||deapat.equals("inst6")||deapat.equals("inst7")||deapat.equals("inst8")||deapat.equals("inst9")||deapat.equals("inst10")||deapat.equals("inst11")){
				
				int departId = 0;
				String departName = "";
				if(deapat.equals("inst3")){
					departId=102;
					departName = "原纸临时仓";
				}else if(deapat.equals("inst4")){
					departId=103;
					departName = "四分切临时仓";
				}else if(deapat.equals("inst5")){
					departId=104;
					departName = "8mm切临时仓(下层)";
				}else if(deapat.equals("inst6")){
					departId=105;
					departName = "8mm切临时仓(上层)";
				}else if(deapat.equals("inst7")){
					departId=106;
					departName = "打孔临时库";
				}else if(deapat.equals("inst8")){
					departId=107;
					departName = "生纸带包装库";
				}else if(deapat.equals("inst9")){
					departId=108;
					departName = "打孔纸带包装库";
				}else if(deapat.equals("inst10")){
					departId=110;
					departName = "成品临时库";
					listFile=fileRead1.readDocumentS(filePath);//获得正确的信息
		 			 listInformation = fileRead1.readDocumentZ1(filePath);//获得LOTNO号 或 栈板号
		 			 listDepart = fileRead1.readDocumentK1(filePath);//获得库位号 或 托盘
				}else if(deapat.equals("inst11")){
					departId=111;
					departName = "品管仓库";
				}
				
				int count = 0;
				String productS="";
	 			for(int i=0;i<listInformation.size();i++){
	 				
	 				String sql = "";
	 				
	 				if(deapat.equals("inst3")){
	 					sql = "select id,product_status from product_info where replace(product_lot_no,'-','')='"+listInformation.get(i)+"' and product_status=7";
	 				}else if(deapat.equals("inst10")){
	 					sql = "select id,'3' as product_status from package_info where package_pallet='"+listInformation.get(i)+"'";
	 				}else if(deapat.equals("inst9")){
	 					sql = "select id,product_status from product_info where replace(product_lot_no,'-','')='"+listInformation.get(i)+"' and stock_id=106 and stock_name='打孔临时库'";
	 				}else{
	 					sql = "select id,product_status from product_info where replace(product_lot_no,'-','')='"+listInformation.get(i)+"'";
	 				}
	 				ResultSet rs=hr_db1.executeQuery(sql);
	 				while(rs.next()){
	 					productS=rs.getString("product_status");//接收生产完成信息
	 					if(productS.equals("2")){//生产中的产品
	 						break;
	 					}
	 					
	 					
	 					
	 					if(deapat.equals("inst3")||deapat.equals("inst4")||deapat.equals("inst5")){
	 						sql = "update product_info set product_stock='"+listDepart.get(i)+"',product_temp_pallet='',product_status=1,stock_id="+departId+",stock_name='"+departName+"',stock_in_time='"+listTop.get(1)+"' where replace(product_lot_no,'-','')='"+listInformation.get(i)+"'";
	 					//8MM下层 打孔入临时库 
	 					}else if(deapat.equals("inst7")){
	 						sql = "update product_info set product_temp_pallet='"+listDepart.get(i)+"',product_stock='',product_status=1,stock_id="+departId+",stock_name='"+departName+"',stock_in_time='"+listTop.get(1)+"' where replace(product_lot_no,'-','')='"+listInformation.get(i)+"'";
	 					}else if(deapat.equals("inst6")){
	 						sql = "update product_info set product_temp_pallet='"+listDepart.get(i)+"',product_stock='',product_status=1,stock_id="+departId+",stock_name='"+departName+"',stock_in_time='"+listTop.get(1)+"',stock_out_time='"+listTop.get(1)+"' where replace(product_lot_no,'-','')='"+listInformation.get(i)+"'";
	 					}else if(deapat.equals("inst8")){
	 						sql = "update product_info set product_stock='"+listDepart.get(i)+"',product_temp_pallet='',product_status=1,stock_id="+departId+",stock_name='"+departName+"',stock_in_time='"+listTop.get(1)+"',stock_out_time='"+listTop.get(1)+"' where replace(product_lot_no,'-','')='"+listInformation.get(i)+"'";
	 					}else if(deapat.equals("inst9")){
	 						//11.11库位号变更为temp，不清除临时栈板号
	 						sql = "update product_info set product_stock='TEMP',product_status=1,stock_id="+departId+",stock_name='"+departName+"',stock_in_time='"+listTop.get(1)+"',stock_out_time='"+listTop.get(1)+"' where replace(product_lot_no,'-','')='"+listInformation.get(i)+"'";
	 					}else if(deapat.equals("inst10")){
	 						sql = "update package_info set package_stock='"+listDepart.get(i)+"',stock_id='"+departId+"',stock_name='"+departName+"',stock_in_time='"+listTop.get(1)+"' where package_pallet='"+listInformation.get(i)+"'";
	 					}else if(deapat.equals("inst11")){
	 						//11.11添加品管仓库添加
	 						sql = "update product_info set product_stock='"+listDepart.get(i)+"',product_temp_pallet='',stock_id="+departId+",stock_name='"+departName+"',stock_in_time='"+listTop.get(1)+"',stock_out_time='"+listTop.get(1)+"' where replace(product_lot_no,'-','')='"+listInformation.get(i)+"'";
	 					}
	 					hr_db.executeUpdate(sql);
	 					count ++;
	 				}
	 			}
	 			if(productS.equals("2")){//生产中产品错误跳转11.17
	 				hr_db.close();
		 			hr_db1.close();
	 				response.sendRedirect("manufacture/process/register_error4.jsp");
	 			}
	 			hr_db.commit();//提交事务
	 			
	 			
	 			if(count==0){
	 				hr_db.close();
		 			hr_db1.close();
	 				response.sendRedirect("manufacture/process/register_error3.jsp");
	 			}else{
	 			hr_db.close();
	 			hr_db1.close();
	 			request.setAttribute("fileName",file_name);
	 			request.setAttribute("inst",deapat);
	 			request.setAttribute("listDepart",listInformation);
	 			request.getRequestDispatcher("/manufacture/process/tempstock_fish.jsp").forward(request,response);
	 			}
	 			}else{
				//不能进行的操作
	 				hr_db.close();
		 			hr_db1.close();
				response.sendRedirect("manufacture/process/tempstock_error.jsp");
			}

			} catch (Exception ex) {
				ex.printStackTrace();
				//response.sendRedirect("manufacture/process/register_error6.jsp");
			}
		}
	}
}