/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package security.backup;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;

import java.io.*;

import include.nseer_cookie.down;
import include.data_backup.MysqlStore;

public class backup_ok extends HttpServlet {

	public void service(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this, request,response, "", true, 8192, true);
		ServletContext dbApplication = dbSession.getServletContext();

		ServletContext application;
		HttpSession session = request.getSession();
		down down = new down();
		MysqlStore mysql = new MysqlStore();

		try {
			ServletContext context = session.getServletContext();
			String path = context.getRealPath("/");
			if (mysql.backup((String) session.getAttribute("unit_db_name") + "_backup.sql", (String) session.getAttribute("unit_db_name")))
				down.download(response, path + "WEB-INF/"+ (String) session.getAttribute("unit_db_name") + "_backup.sql");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}