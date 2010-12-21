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
import java.io.*;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataTag;
import include.alarm.CheckRows;
import include.get_sql.getInsertSql;

public class check_delete_ok extends HttpServlet {

	public synchronized void service(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			HttpSession dbSession = request.getSession();
			ServletContext dbApplication = dbSession.getServletContext();
			nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
			
			ValidataNumber validata = new ValidataNumber();
			ValidataTag vt = new ValidataTag();
			counter count = new counter(dbApplication);

			String demand=request.getParameter("demand");//未通过缘由
			
			String id = request.getParameter("id");
			//修改审核状态为2，清空审核人审核时间，添加审核意见
			if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
				String sql = "update crm_file set check_tag='2',checker='',CHECK_TIME=default,DEMAND='"+demand+"' where id='" + id
						+ "'";
				crm_db.executeUpdate(sql);
				response.sendRedirect("crm/file/check_delete_ok.jsp?finished_tag=0");
			}
			crm_db.commit();
			
			crm_db.close();
			
			// }else{
			// response.sendRedirect("error_conn.htm");
			// }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}