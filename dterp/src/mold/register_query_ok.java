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

public class register_query_ok extends HttpServlet {

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
				String mold_id=request.getParameter("mold_id");
				String radio1 = request.getParameter("1");
				String radio2 = request.getParameter("2");
				String radio3 = request.getParameter("3");
				String radio4 = request.getParameter("4");
				String radio5 = request.getParameter("5");
				String radio6 = request.getParameter("6");
				String radio7 = request.getParameter("7");
				String radio8 = request.getParameter("8");
				String radio9 = request.getParameter("9");
				String radio10 = request.getParameter("10");
				String radio11 = request.getParameter("11");
				// 登记人
				String mold_stock_register = request.getParameter("mold_stock_register");
				// 登记时间
				String mold_stock_register_time = request.getParameter("mold_stock_register_time");
				//备注
				String mold_stock_remark= request.getParameter("remark");
				// 获取当前时间
				// java.sql.Date d = new java.sql.Date(System
						// .currentTimeMillis());
				
				// 插入模具入库单表
				String sql = "insert mold_stock(mold_id,top_item1,top_item2,top_item3,top_item4,top_item5,top_item6,bottom_item1,bottom_item2,bottom_item3,bottom_item4,bottom_item5,mold_stock_register,mold_stock_regist_time,mold_stock_remark) values('"
						+ id
						+ "','"
						+ radio1
						+ "','"
						+ radio2
						+ "','"
						+ radio3
						+ "','"
						+ radio4
						+ "','"
						+ radio5
						+ "','"
						+ radio6
						+ "','"
						+ radio7
						+ "','"
						+ radio8
						+ "','"
						+ radio9
						+ "','"
						+ radio10
						+ "','"
						+ radio11
						+ "','"
						+ mold_stock_register
						+ "','"
						+ mold_stock_register_time
						+ "','"+mold_stock_remark+"')";
				// 执行插入语句（模具入库单）
				mold_db.executeUpdate(sql);
				sql = "update mold_info set mold_life_status='"+1+"',stock_time='"+mold_stock_register_time+"' where id='"+mold_id+"'";
				mold_db.executeUpdate(sql);
				sql = "select mold_spec,mold_code from mold_info where id='"+id+"'";
				ResultSet rs1 = mold_db.executeQuery(sql); 
				String mold_spec="";
				String mold_code="";
				if(rs1.next())
				{
					mold_spec = rs1.getString("mold_spec");
					mold_code = rs1.getString("mold_code");
				}
				// 提交事务
				mold_db.commit();
				mold_db.close();
				String path=request.getContextPath();
				// 跳转页面
				response
						.sendRedirect(path+"/mold/stock/register_choose_attachment.jsp?id="+id+"&mold_spec="+mold_spec+"&mold_code="+mold_code+"&stock_time="+mold_stock_register_time);

			}
		
	} catch (Exception ex) {
		ex.printStackTrace();
	}
}
}