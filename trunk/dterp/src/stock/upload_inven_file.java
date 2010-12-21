/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;

import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.common.UpLoadUrl;
import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

public class upload_inven_file extends HttpServlet {// 创建方法
	

	public synchronized void service(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		//String inven_date=request.getParameter("inven_time");
		//String aaaaaaaa=request.getParameter("abc");
		SmartUpload mySmartUpload = new SmartUpload();
		
		mySmartUpload.setCharset("UTF-8");
		mySmartUpload.setAllowedFilesList("txt");
		
		HttpSession session = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this, request, response, "", true, 8192, true);
		try {
			mySmartUpload.initialize(pageContext);
			mySmartUpload.upload();
			String inven_date=mySmartUpload.getRequest().getParameter("inven_time");
 			com.jspsmart.upload.SmartFile myFile = mySmartUpload.getFiles().getFile(0);
 			String file_name = myFile.getFileName();
 			ServletContext context = session.getServletContext();
 			String path = request.getContextPath();
 			//java.util.Date now = new java.util.Date();
 		
 			  
 			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM");
 			//java.util.Date    cDate    =    formatter.parse(inven_date);  
 			SimpleDateFormat formatter2 = new SimpleDateFormat("yyyyMMddHHmmss");
 			String filePart=formatter2.format(new Date());
 			String time=inven_date.replaceAll("-","").substring(0,6);
 			//String filegroup=file_name.substring(file_name.indexOf("-")+1,file_name.indexOf("."));
 			String filePath=UpLoadUrl.getUploadUrl()+path+ "/upload_file/inven/"+time ;//上传文件路径
 			
 			File a=new File(filePath);
 			if(!a.exists()){
 				a.mkdirs();
 			}
 			filePath=filePath+"/"+filePart+file_name;//
 			//System.out.println(filePath);
 			myFile.saveAs(filePath);
 			
 			response.sendRedirect("stock/analyse/upload_inven_file_ok.jsp");
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SmartUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
}