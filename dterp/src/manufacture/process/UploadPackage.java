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

import include.nseer_cookie.getFileLength;
import include.nseer_db.nseer_db_backup1;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import com.common.UpLoadUrl;
import com.jspsmart.upload.SmartUpload;

public class UploadPackage extends HttpServlet {// 创建方法
	ServletContext application;

	HttpSession session;

	

	public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this, request,response, "", true, 8192, true);
		ServletContext dbApplication = dbSession.getServletContext();
		try {

			getFileLength getFileLength = new getFileLength();
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
			nseer_db_backup1 hr_db1 = new nseer_db_backup1(dbApplication);
			SmartUpload mySmartUpload = new SmartUpload();
			mySmartUpload.setCharset("UTF-8");
			if (hr_db.conn((String) dbSession.getAttribute("unit_db_name"))&&hr_db1.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String human_ID = request.getParameter("human_ID");

				// long d = getFileLength.getFileLength((String)
				// session.getAttribute("unit_db_name"));
				mySmartUpload.setCharset("UTF-8");
				mySmartUpload.initialize(pageContext);
				String file_type = "txt";
				// long d = getFileLength.getFileLength((String)
				// session.getAttribute("unit_db_name"));
				// mySmartUpload.setMaxFileSize(d);
				mySmartUpload.setAllowedFilesList(file_type);
				try {
					mySmartUpload.upload();
					com.jspsmart.upload.SmartFile myFile = mySmartUpload
							.getFiles().getFile(0);
					String file_name = myFile.getFileName();
					ServletContext context = session.getServletContext();
					String path = request.getContextPath();

					// 获取文件存放文件夹名称
					String filegroup = file_name.substring(file_name
							.indexOf("-") + 1, file_name.indexOf("."));

					// 获得当前日期
					java.util.Date now = new java.util.Date();
					SimpleDateFormat formatter = new SimpleDateFormat(
							"yyyyMMdd");
					String time = formatter.format(now);
					
					String suffName = file_name.substring(file_name.indexOf(".")-1,file_name.indexOf("."));//判断类型
		 			
		 			if(!suffName.equals("J")){
		 				 response.sendRedirect("manufacture/process/register_error1.jsp");
		 				 return;
		 			}
					
					String filePath = UpLoadUrl.getUploadUrl()+path+"/upload_file/manufacture_result/"
							+ time + "/" + filegroup + "/";// 上传文件路径
					//filePath="/images/";
					File a = new File(filePath);
					if (!a.exists()) {
						a.mkdirs();
					}
					filePath = filePath + file_name;//

					myFile.saveAs(filePath);
					FileRead fileread = new FileRead();// 文件读写类
					Map<Integer, String> filerows = new HashMap<Integer, String>();
					filerows = fileread.readF2(filePath);// 获得有效地每一行内容
					int row_m = Integer.parseInt(filerows.get(0));
					String x_date = filerows.get(1);// 时间
					String x_worker = filerows.get(2);// 员工id
					String x_type = filerows.get(3);// conf1——4分切,conf2——8mm切,conf3——打孔
					if((!filerows.get(3).toLowerCase().equals("conf1"))&&(!filerows.get(3).toLowerCase().equals("conf2"))&&(!filerows.get(3).toLowerCase().equals("conf3")))
					{
						response.sendRedirect("manufacture/process/uploaderr.jsp");
					}else{
					String sql_x = "";
					String now_id = "";// 当前原料id
					String father_product_id = "";
					String product_is_production_tag="";
					// 循环信息
					for (int x = 4; x < filerows.size(); x++) {
						String fx = filerows.get(x);
						if (fx == null) {
							continue;
						}else if(fx.trim().equals("")){
							continue;
						} else {
							if (x % 2 == 0) {
								sql_x = "select REPLACE(product_lot_no,'-','') as lotNo,product_is_production,product_lot_no,id,father_product_id from product_info where REPLACE(product_lot_no,'-','')='"
										+ filerows.get(x) + "'";
								ResultSet rs_x = hr_db.executeQuery(sql_x);
								if (rs_x.next()) {
									now_id = rs_x.getString("product_lot_no");
									product_is_production_tag=rs_x.getString("product_is_production");
									
								}
								if(!now_id.trim().equals("")){
									break;
								}
								if(product_is_production_tag.equals("0")){
									break;
								}
							} 
						}
					}
					if(now_id.trim().equals("")){
						response.sendRedirect("manufacture/process/checkerr.jsp?n="+now_id);
					}else if(product_is_production_tag.equals("0")){
						response.sendRedirect("manufacture/process/checkerr1.jsp");
					}else{
						response.sendRedirect("manufacture/process/check.jsp?path="+ filePath);
					}
					}
				} catch (Exception ex) {
					response.sendRedirect("error_conn.htm");
				}
				
				hr_db1.close();
				
				hr_db.close();
			} else {
				response.sendRedirect("error_conn.htm");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}