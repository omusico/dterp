/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.file;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.*;
import java.io.*;

import include.nseer_cookie.exchange;
import include.nseer_db.*;
import java.text.*;
import include.get_name_from_ID.getNameFromID;
import include.nseer_cookie.*;
import validata.ValidataTag;
import include.operateDB.CdefineUpdate;
import include.alarm.CheckRows;

public class check_ok extends HttpServlet {

	ServletContext application;

	HttpSession session;



	public synchronized void doPost(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this, request,
				response, "", true, 8192, true);
		ServletContext dbApplication = dbSession.getServletContext();

		try {
			counter count = new counter(dbApplication);
			getNameFromID getNameFromID = new getNameFromID();
			ValidataTag vt = new ValidataTag();
			nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
			if (crm_db.conn((String) dbSession.getAttribute("unit_db_name"))) {

				// String oldKind_chain=request.getParameter("oldKind_chain");
				// String oldChain_id=Divide1.getId(oldKind_chain);

				String id = request.getParameter("id");

				String checker = request.getParameter("checker");
				String checker_ID = request.getParameter("checker_ID");
				String check_time = request.getParameter("check_time");

				try {

					String sql = "update crm_file set check_tag=1,checker='"
							+ checker + "',check_time='" + check_time
							+ "' where id=" + id;
					crm_db.executeUpdate(sql);
					/** ************************************************** */

					/** ************************************************** */

				} catch (Exception ex) {
					ex.printStackTrace();
				}

				response.sendRedirect("crm/file/check_ok.jsp?finished_tag=2");

				crm_db.commit();
				crm_db.close();
			} else {
				response.sendRedirect("error_conn.htm");
			}
		} catch (Exception x) {
			x.printStackTrace();

		}

	}
}