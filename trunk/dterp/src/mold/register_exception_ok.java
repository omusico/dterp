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
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class register_exception_ok extends HttpServlet {

	ServletContext application;

	HttpSession session;

	public synchronized void service(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		HttpSession dbSession = request.getSession();// 获取会话session
		ServletContext dbApplication = dbSession.getServletContext();// 获取全局变量application

	nseer_db_backup1 mold_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
	
	try {
			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (mold_db.conn((String) dbSession.getAttribute("unit_db_name"))) {

				int id = Integer.parseInt(request.getParameter("id"));
				String exception_content = request.getParameter("exception_content");				
				// 登记人
				String exception_register = request.getParameter("exception_register");
				// 登记时间
				String exception_regist_time = request.getParameter("exception_regist_time");
				// 获取当前时间
				// java.sql.Date d = new java.sql.Date(System
						// .currentTimeMillis());
				
				// 插入模具异常信息表
				String sql = "insert mold_exception(mold_id,exception_content,exception_register,exception_regist_time,mold_status) values('"
						+ id
						+ "','"
						+ exception_content
						+ "','"
						+ exception_register
						+ "','"
						+ exception_regist_time					
						+ "',"+0+")";
				// 执行插入语句（模具异常信息表）
				mold_db.executeUpdate(sql);
				//sql = "insert mold_info(mold_life_status) values('"+1+"')";
				//mold_db.executeUpdate(sql);
				// 提交事务
				mold_db.commit();
				mold_db.close();
				String path=request.getContextPath();
				dbSession.setAttribute("id", exception_register);
				dbSession.setAttribute("id", request.getParameter("mold_spec"));
				dbSession.setAttribute("id", request.getParameter("mold_code"));
				
				
				String mold_stock_register_time=exception_regist_time;
				String mold_spec=request.getParameter("mold_spec");
				String mold_code=request.getParameter("mold_code");
				

				response
						.sendRedirect(path+"/mold/exception/register_choose_attachment.jsp?id="+id+"&mold_spec="+mold_spec+"&mold_code="+mold_code+"&stock_time="+mold_stock_register_time);


			}
		
	} catch (Exception ex) {
		ex.printStackTrace();
	}
}
}