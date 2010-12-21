/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.search;

import include.nseer_db.nseer_db_backup1;
import java.util.HashMap;   
import java.util.Map;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 
 * @author 高丰仪 功能：审核通过未通过 出库申请管理
 * 
 */
public class datumSearch extends HttpServlet {

	ServletContext application;

	HttpSession session;

	public synchronized void service(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		HttpSession dbSession = request.getSession();// 获取会话session
		ServletContext dbApplication = dbSession.getServletContext();// 获取全局变量application

		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		
		try {
//			 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_db.conn((String) dbSession
					.getAttribute("unit_db_name"))) {
				
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}