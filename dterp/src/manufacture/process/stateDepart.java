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

public class stateDepart extends HttpServlet {// 创建方法
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
		//nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication); modify by wangshaolin
		SmartUpload mySmartUpload = new SmartUpload();
		mySmartUpload.setCharset("UTF-8");

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
			String path = context.getRealPath("/");

			String path2 = request.getContextPath();

			// 获取文件存放文件夹名称
			String filegroup = file_name.substring(file_name.indexOf("-") + 1,
					file_name.indexOf("."));

			// 获得当前日期
			java.util.Date now = new java.util.Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			String time = formatter.format(now);
			
			String suffName = file_name.substring(file_name.indexOf(".")-1,file_name.indexOf("."));//判断类型
			
			if(!suffName.equals("M")){
				response.sendRedirect("manufacture/stocktake/register_error6.jsp");
			 return;
			}
			String filePath =UpLoadUrl.getUploadUrl()+path2+ "/upload_file/scanner_file/" + time + "/"
					+ filegroup + "/";// 上传文件路径

			File a = new File(filePath);
			if (!a.exists()) {
				a.mkdirs();
			}
			filePath = filePath + file_name;//

			myFile.saveAs(filePath);

			if (hr_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				FileRead fileRead1 = new FileRead();
				List<String> listFile = fileRead1.readDocument(filePath);// 获得正确的信息

				String deapat = listFile.get(3).toLowerCase();// 上传类型 inven

				if (deapat.equals("inven")) {

					List<String> listDepart = fileRead1.readF2Z(filePath);

					String stock = listFile.get(4);// 仓库

					String personNo = listFile.get(2);// 员工编号

					String fileTime = listFile.get(1).substring(0, 10);// 时间

					for (int i = 0; i < listDepart.size(); i++) {
						String sql ="select id from barcode_file where inven_time='"+fileTime+"' and lot_no='"+listDepart.get(i)+"'";
						ResultSet rs_commitRepeat=hr_db.executeQuery(sql);
						if(rs_commitRepeat.next()){
							i=listDepart.size();
						}else{
						sql = "insert into barcode_file (lot_no,inven_time,emp_no,stock,inven_falg) values('"
								+ listDepart.get(i)
								+ "','"
								+ fileTime
								+ "','"
								+ personNo + "','" + stock + "'," + 1 + ")";
						hr_db.executeUpdate(sql);
						}
					}

					hr_db.commit();
				} else {
					response
							.sendRedirect("manufacture/stocktake/register_error.jsp");
				}

			}
			hr_db.close();
			request.setAttribute("fileName", file_name);
			request.getRequestDispatcher(
					"/manufacture/stocktake/fish_register_list.jsp").forward(
					request, response);

		} catch (Exception ex) {
			response.sendRedirect("manufacture/stocktake/register_error6.jsp");
		}

	}
}