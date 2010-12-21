/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package mold;

import include.nseer_cookie.getFileLength;
import include.nseer_db.nseer_db_backup1;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

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

public class register_picture2_ok extends HttpServlet {// 创建方法
	ServletContext application;

	HttpSession session;



	public synchronized void service(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this, request,
				response, "", true, 8192, true);
		ServletContext dbApplication = dbSession.getServletContext();
		try {

			getFileLength getFileLength = new getFileLength();
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			nseer_db_backup1 mold_db = new nseer_db_backup1(dbApplication);
			SmartUpload mySmartUpload = new SmartUpload();
			SmartUpload requestUpload = new SmartUpload();
			
			mySmartUpload.setCharset("UTF-8");
			if (mold_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String human_ID = request.getParameter("id");
				int id = Integer.parseInt(human_ID);
				
				
				//String mold_spec=requestUpload.getRequest().getParameter("mold_spec") ;
				//String mold_code=requestUpload.getRequest().getParameter("mold_code") ;
				//String destruction_timea=request.getParameter("destruction_time") ;
				//从session中获取
				String mold_code=(String)session.getAttribute("mold_code");
				String mold_spec=(String)session.getAttribute("mold_spec");
				String destruction_timea=(String)session.getAttribute("destruction_time");
				//
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				java.util.Date now = new java.util.Date();//获取 时分秒
				String time2=formatter.format(now);//获取 时分秒
				time2=time2.substring(10,time2.length());
				destruction_timea+=time2;
				
				//java.sql.Date date = java.sql.Date.valueOf(destruction_timea);
				//destruction_timea=formatter.format(date);
				
				String file1=destruction_timea.substring(0, 4);
				String file2=destruction_timea.substring(5, 7);
				String file3=destruction_timea.substring(8, 10);
				String file4=destruction_timea.substring(11, 13);
				String file5=destruction_timea.substring(14, 16);
				String file6=destruction_timea.substring(17, 19);
				String destruction_time=destruction_timea.substring(0, 10);   
				String file_type = "jpg,gif";
				long d = getFileLength.getFileLength((String) session.getAttribute("unit_db_name"));
				mySmartUpload.setMaxFileSize(d);
				mySmartUpload.setAllowedFilesList(file_type);
				mySmartUpload.initialize(pageContext);
				try {
					mySmartUpload.upload();
					com.jspsmart.upload.SmartFile myFile = mySmartUpload .getFiles().getFile(0);
					ServletContext context = session.getServletContext();
					//String path = context.getRealPath("/");
					String path = request.getContextPath();
					String file = file1+file2+file3+file4+file5+file6+myFile.getFileName().substring(myFile.getFileName().length() - 4).toLowerCase();
					if(!UpLoadUrl.getUploadUrl().equals(""))
					{
					File b = new File(UpLoadUrl.getUploadUrl()+path+"/upload_file/uninstall/uninstall"+"_"+mold_code+"_"+destruction_time+"/");
					if(!b.exists()){
						b.mkdirs();
					}
					System.out.println(UpLoadUrl.getUploadUrl()+path+"/upload_file/uninstall/uninstall"+"_"+mold_code+"_"+destruction_time+"/" + file);
					
					myFile.saveAs(UpLoadUrl.getUploadUrl()+path+"/upload_file/uninstall/uninstall"+"_"+mold_code+"_"+destruction_time+"/" + file);
					String sql = "insert mold_destruction_pic(mold_id,pic_path)values('"+id+"','"+file+"')";
					mold_db.executeUpdate(sql);
					}
					
					
					if(request.getParameter("picType")!=null&&! request.getParameter("picType").equals("")&& request.getParameter("picType").equals("change"))
					{
						response.sendRedirect(path+"/mold/uninstall/change_search.jsp");
					}
					response.sendRedirect(path+"/mold/uninstall/register_search.jsp");
				} catch (Exception ex) {
					mold_db.close();
					ex.printStackTrace();
				}
				mold_db.commit();
				mold_db.close();
			} else {
				response.sendRedirect("error_conn.htm");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	
}