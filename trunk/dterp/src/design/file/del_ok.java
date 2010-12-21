/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package design.file;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import java.io.*;
import java.util.*;
import include.nseer_cookie.*;
import include.alarm.CheckRows;
import include.get_name_from_ID.getNameFromID;
import include.operateDB.CdefineUpdate;

public class del_ok extends HttpServlet {
	ServletContext application;


	public synchronized void doPost(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this, request,
				response, "", true, 8192, true);
		ServletContext dbApplication = dbSession.getServletContext();

		try {
			// 实例化

			HttpSession session = request.getSession();
			
			
			nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
			if (hr_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String id=request.getParameter("id");//档案id
				//修改C_DEFINE1的值为1——已删除
				String sql_del="update design_file set C_DEFINE1='1' where id=" + id;
				hr_db.executeUpdate(sql_del);
				hr_db.commit();
				hr_db.close();
				response.sendRedirect("design/file/change_ok_c.jsp");
				
			} else {
				response.sendRedirect("error_conn.htm");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
	}
}