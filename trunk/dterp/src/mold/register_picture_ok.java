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
import java.sql.ResultSet;
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

public class register_picture_ok extends HttpServlet {// 创建方法
	ServletContext application;

	HttpSession session;

	nseer_db_backup1 erp_db = null;

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
			mySmartUpload.setCharset("UTF-8");
			if (mold_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String human_ID = request.getParameter("id");
			
				
				int id = Integer.parseInt(human_ID);
				String mold_spec=request.getParameter("mold_spec") ;
				String mold_code=request.getParameter("mold_code") ;
				String stock_timea=request.getParameter("stock_time") ;
				
				
                //重新获取
				//1.mold_spec
				String sql1="select * from mold_purchase_order_detail where mold_id='"+human_ID+"'";
				ResultSet rs1= mold_db.executeQuery(sql1);
				
				if(rs1.next())
				{
					mold_spec=rs1.getString("mold_spec");
				}
				//2.stock_timea
				java.util.Date now = new java.util.Date();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String time=formatter.format(now);
				stock_timea=time;
				
				
				String file1=stock_timea.substring(0, 4);
				String file2=stock_timea.substring(5, 7);
				String file3=stock_timea.substring(8, 10);
				String file4=stock_timea.substring(11, 13);
				String file5=stock_timea.substring(14, 16);
				String file6=stock_timea.substring(17, 19);
				String stock_time=stock_timea.substring(0, 10);   
				String file_type = "jpg,gif";
				long d = getFileLength.getFileLength((String) session.getAttribute("unit_db_name"));
				mySmartUpload.setMaxFileSize(d);
				mySmartUpload.setAllowedFilesList(file_type);
				mySmartUpload.initialize(pageContext);
				try {
					
						//上传开始
						mySmartUpload.upload();
						com.jspsmart.upload.SmartFile myFile = mySmartUpload .getFiles().getFile(0);
						ServletContext context = session.getServletContext();
						
	                    //String path = context.getRealPath("/");
						String path= request.getContextPath();
						if(!UpLoadUrl.getUploadUrl().equals(""))
						{
						// String path=  position.substring(1,position.length());
						String file = file1+file2+file3+file4+file5+file6+myFile.getFileName().substring(myFile.getFileName().length() - 4).toLowerCase();
						File b = new File(UpLoadUrl.getUploadUrl()+path + "/upload_file/stock_pictures/stock_pictures"+"_"+mold_code+"_"+stock_time+"/");
						if(!b.exists()){
							b.mkdirs();
						}
						//最终路径
						String all_path=UpLoadUrl.getUploadUrl()+path + "/upload_file/stock_pictures/stock_pictures"+"_"+mold_code+"_"+stock_time+"/" + file;
						myFile.saveAs(all_path);
						//写入数据库
						String sql = "insert into mold_stock_pic(mold_id,pic_path)values('"+id+"','"+file+"')";
						mold_db.executeUpdate(sql);
					   }
					response.sendRedirect(path+"/mold/stock/register_search.jsp");
					
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