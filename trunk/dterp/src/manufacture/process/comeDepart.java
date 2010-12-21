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

public class comeDepart extends HttpServlet {// 创建方法
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

		
		SmartUpload mySmartUpload = new SmartUpload();
		mySmartUpload.setCharset("UTF-8");
		if (hr_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
			String human_ID = request.getParameter("human_ID");

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
				//String path = context.getRealPath("/");
				String path = request.getContextPath();
				
				String suffName = file_name.substring(file_name.indexOf(".")-1,file_name.indexOf("."));//判断类型
	 			
	 			if(!suffName.equals("H")){
	 				 response.sendRedirect("stock/pay/register_error6.jsp");
	 				 return;
	 			}
				
				// 获取文件存放文件夹名称
				String filegroup = file_name.substring(
						file_name.indexOf("-") + 1, file_name.indexOf("."));

				// 获得当前日期
				java.util.Date now = new java.util.Date();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
				SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
	 			String time1=formatter1.format(now);
				String time = formatter.format(now);
				String time2 = formatter2.format(now);
				String filePath = UpLoadUrl.getUploadUrl()+path+"/upload_file/scanner_file/" + time + "/"
						+ filegroup + "/";// 上传文件路径

				File a = new File(filePath);
				if (!a.exists()) {
					a.mkdirs();
				}
				filePath = filePath + file_name;//

				myFile.saveAs(filePath);

				FileRead fileRead = new FileRead();
				List<String> readF = fileRead.readF2Over(filePath);// 获得llotNo
				// 或栈板号
				List<String> readF2 = fileRead.readF2Z(filePath);// 获得llotNo
				Map<Integer,String> read = fileRead.readF(filePath);// 获得llotNo
				String hr_name = read.get(2);
				Map<String, Integer> map = new HashMap<String, Integer>();
				 //在此声明一个HashMap集合
							        
				 //迭代数组
				 for (String str : readF2){
				 Integer num = map.get(str);
				 num = null == num ? 1 : num + 1;
				 map.put(str, num);
				 }		           
				 if (readF2.size() != map.size())
				 {
					response.sendRedirect("stock/pay/register_error.jsp");
					 return;
				 }
				 
				// 或栈板号
				int person_id = 0;// 出库理由Id
//				 是生产出库还是成品出库
				String deapat = readF.get(3);
				String sql = "";
				if(deapat.toLowerCase().equals("outs1")||deapat.toLowerCase().equals("outs2")){

				String LotNo = readF2.get(0);// 获得一个LOTNo号
				if (deapat.toLowerCase().equals("outs1")) {
					person_id = 3;// 出库理由Id
					sql = "select stock_out_apply.id,stock_out_apply.apply_out_count from product_info inner join stock_out_apply_detail on stock_out_apply_detail.Out_Detail_product_id = product_info.id inner join stock_out_apply on stock_out_apply.id = stock_out_apply_detail.apply_out_id where replace(product_info.product_lot_no,'-','')='"
						+ LotNo + "' and apply_out_check_status=1 and apply_out_reason_id=3";

				} else if (deapat.toLowerCase().equals("outs2")) {
					person_id = 5;// 出库理由Id
					sql = "select stock_out_apply.id,stock_out_apply.apply_out_count from package_info "
						+"inner join stock_out_apply_detail on stock_out_apply_detail.Out_Detail_pal = package_info.package_pallet "
						+"inner join stock_out_apply on stock_out_apply.id = stock_out_apply_detail.apply_out_id where package_info.package_pallet='"
						+ LotNo + "' and apply_out_check_status=1 and apply_out_reason_id=5";
				}

				ResultSet rs = hr_db.executeQuery(sql);
				int applyOrderNumberId = 0;// 获得出库申请单号
				int applyCount = 0;//入库数量
				if (rs.next()) {
					applyOrderNumberId = rs.getInt("stock_out_apply.id");
					applyCount = rs.getInt("stock_out_apply.apply_out_count");
				}else{
					hr_db.close();
					response.sendRedirect("stock/pay/register_error3.jsp");
					return;
				}
				
				//出库申请单数量大于出库单数量
				if(applyCount<readF2.size()){
					hr_db.close();
					response.sendRedirect("stock/pay/register_error2.jsp");
					return;
				}
				if (deapat.toLowerCase().equals("outs1")) {
					for(int i=0;i<readF2.size();i++){
 	 					String sqlIsNoN = "SELECT replace(product_lot_no,'-','') as lotNo FROM stock_out_detail INNER JOIN product_info ON stock_out_detail.Out_Detail_product_id = product_info.id";
 	 					ResultSet rs1=hr_db.executeQuery(sqlIsNoN);
 	 					String lotNo = "";
 	 					while(rs1.next()){
 	 						lotNo = rs1.getString(1);
 	 					
 	 					if(lotNo.equals(readF2.get(i))){
 	 						hr_db.close();
 	 						response.sendRedirect("stock/pay/register_error1.jsp");
 	 						return;
 	 					}}
 	 				}
				}else if(deapat.toLowerCase().equals("outs2")){
					for(int i=0;i<readF2.size();i++){
 	 					String sqlIsNoN = "SELECT package_pallet FROM stock_out_detail INNER JOIN package_info ON stock_out_detail.Out_Detail_product_id = package_info.id";
 	 					ResultSet rs1=hr_db.executeQuery(sqlIsNoN);
 	 					String lotNo = "";
 	 					while(rs1.next()){
 	 						lotNo = rs1.getString(1);
 	 					
 	 					if(lotNo.equals(readF2.get(i))){
 	 						hr_db.close();
 	 						response.sendRedirect("stock/pay/register_error1.jsp");
 	 						return;
 	 					}}
 	 				}
				}
				
				String orderNumber = fileRead.getOrderNumber();// 出库单号
				String personName = readF.get(2);// 出库人ID
				
				String applyTime = fileRead.getTime();// 出库时间
				
				dbSession.setAttribute("time2",time2);
				dbSession.setAttribute("personName",personName);
				dbSession.setAttribute("person_id",person_id);
				dbSession.setAttribute("time1",time1);
				dbSession.setAttribute("applyOrderNumberId",applyOrderNumberId);
				dbSession.setAttribute("deapat",deapat);
				dbSession.setAttribute("readF2",readF2);
				dbSession.setAttribute("readF",readF);
				
				hr_db.close();// 关闭连接
				request.setAttribute("deapat",deapat.toLowerCase());
				request.setAttribute("readF2",readF2);
				dbSession.setAttribute("orderNumber",orderNumber);
				dbSession.setAttribute("fileName",file_name );
				request.getRequestDispatcher("/stock/pay/fish_register_list.jsp").forward(request,response);
				
				}else{
					request.getRequestDispatcher("/stock/apply_pay/check_list_auditing1.jsp").forward(request,response);
				}
			} catch (Exception ex) {

					response.sendRedirect("stock/pay/register_error6.jsp");
				 
			}
		}
	}
}