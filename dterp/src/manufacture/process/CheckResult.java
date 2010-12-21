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
import java.util.HashMap;
import java.util.Map;

import include.nseer_db.*;
import include.nseer_cookie.*;

import com.common.UpLoadUrl;
import com.jspsmart.upload.SmartUpload;

public class CheckResult extends HttpServlet {// 创建方法
	ServletContext application;

	HttpSession session;

	

	public synchronized void service(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this, request, response, "", true, 8192, true);
		ServletContext dbApplication = dbSession.getServletContext();
		try {

			getFileLength getFileLength = new getFileLength();
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
			nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
			SmartUpload mySmartUpload = new SmartUpload();
			mySmartUpload.setCharset("UTF-8");
			if (hr_db.conn((String) dbSession.getAttribute("unit_db_name"))&&manufacture_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String human_ID = request.getParameter("human_ID");
				
				//long d = getFileLength.getFileLength((String) session.getAttribute("unit_db_name"));
				mySmartUpload.setCharset("UTF-8");
		 		mySmartUpload.initialize(pageContext);
		 		String file_type = "txt";
		 		//long d = getFileLength.getFileLength((String) session.getAttribute("unit_db_name"));
		 		//mySmartUpload.setMaxFileSize(d);
		 		mySmartUpload.setAllowedFilesList(file_type);
		 		try {
		 			mySmartUpload.upload();
		 			com.jspsmart.upload.SmartFile myFile = mySmartUpload.getFiles().getFile(0);
		 			String file_name = myFile.getFileName();
		 			ServletContext context = session.getServletContext();
		 			String path = request.getContextPath();//  /erpv7
		 			
		 			//获取文件存放文件夹名称
		 			String filegroup=file_name.substring(file_name.indexOf("-")+1,file_name.indexOf("."));
		 			
		 			
		 			//获得当前日期
		 			java.util.Date now = new java.util.Date();
		 			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		 			String time=formatter.format(now);
		 			String filePath=UpLoadUrl.getUploadUrl()+path+"/upload_file/manufacture_package/"+time+"/"+filegroup+"/" ;//上传文件路径
		 			
		 			File a=new File(filePath);
		 			if(!a.exists()){
		 				a.mkdirs();
		 			}
		 			filePath=filePath+file_name;//
		 			String suffName = file_name.substring(file_name.indexOf(".")-1,file_name.indexOf("."));//判断类型
		 			//上传文件错误
		 			if(!suffName.toUpperCase().equals("K")){
		 				 response.sendRedirect("manufacture/process/register_error2.jsp");
		 				 return;
		 			}
		 			myFile.saveAs(filePath);
					FileRead fileread=new FileRead();//文件读写类
					Map<Integer, String> filerows=new HashMap<Integer, String>();
					filerows=fileread.readF2(filePath);//获得有效地每一行内容
					int row_m=Integer.parseInt(filerows.get(0));
					String x_date=filerows.get(1);//时间
					String x_worker=filerows.get(2);//员工id
					String x_type=filerows.get(3);//pack——包装
					String x_package_stock=filerows.get(filerows.size()-1);//生产托盘号（栈板号）
					
					String product_spec="";//规格
					String product_pallet_sf="";
					String package_pallet="";
					String product_spec_id="";
					String package_factory_pallet="";
					String package_custom_id="";
					String package_custom_name="";
					String package_id="";
					String sql_p="select id,package_pallet from package_info where package_pallet='"+x_package_stock+"'";
					ResultSet rs_p=manufacture_db.executeQuery(sql_p);
					if(rs_p.next()){
						package_id=rs_p.getString("id");
						
						
					}else{
						//栈板号不存在
						response.sendRedirect("manufacture/process/packageerr.jsp");
		 				return;
					}
					/*
					if(!package_id.trim().equals("")){
						//遍历信息更改包装id
						for(int x=4;x<filerows.size()-1;x++){
							String sql_pa="update product_info set package_id='"+package_id+"' where REPLACE(product_lot_no,'-','')='"+filerows.get(x)+"'";
							hr_db.executeUpdate(sql_pa);
						}
					}
					*/
					
					
					response.sendRedirect("manufacture/process/package_3.jsp?path="+filePath);
					
				} 
				catch (Exception ex) {
					response.sendRedirect("error_conn.htm");
				}
				manufacture_db.commit();
				manufacture_db.close();
				hr_db.commit();
				hr_db.close();
				
			} else {
				response.sendRedirect("error_conn.htm");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}