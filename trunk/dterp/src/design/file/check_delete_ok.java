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

import java.sql.*;
import javax.servlet.*;

import java.io.*;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataTag;
import include.get_sql.getInsertSql;

public class check_delete_ok extends HttpServlet {

	public synchronized void service(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this, request,
				response, "", true, 8192, true);
		ServletContext dbApplication = dbSession.getServletContext();

		ServletContext application;
		HttpSession session = request.getSession();
		nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
		nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
		ValidataNumber validata = new ValidataNumber();
		ValidataTag vt = new ValidataTag();
		counter count = new counter(dbApplication);
		try {

			if (design_db.conn((String) dbSession.getAttribute("unit_db_name"))
					&& finance_db.conn((String) dbSession
							.getAttribute("unit_db_name"))) {
				String id = request.getParameter("id");
				String remark=request.getParameter("demand");
				
				try {
					String sql = "update design_file set check_tag=2,checker='',check_time=default,remark='"+remark+"' where id=" + id;
					design_db.executeUpdate(sql);

				} catch (Exception ex) {
					ex.printStackTrace();
				}
				response.sendRedirect("design/file/check_delete_ok.jsp?finished_tag=0");

				design_db.commit();
				finance_db.commit();
				design_db.close();
				finance_db.close();
			} else {
				response.sendRedirect("error_conn.htm");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}