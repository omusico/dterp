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

public class register_uninstall_ok extends HttpServlet {

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
				String radio1 = request.getParameter("1");
				String radio2 = request.getParameter("2");
				String radio3 = request.getParameter("3");
				String radio4 = request.getParameter("4");
				String radio5 = request.getParameter("5");
				String radio6 = request.getParameter("6");
				String destruction_item1_content=request.getParameter("destruction_item1_content");
				String destruction_item2_content=request.getParameter("destruction_item2_content");
				String destruction_remark=request.getParameter("destruction_remark");
				String destruction_man=request.getParameter("destruction_man");
				String destruction_time=request.getParameter("destruction_time");
				String destruction_item3_content=request.getParameter("destruction_item3_content");
				String destruction_item4_content=request.getParameter("destruction_item4_content");
				String spool_num=request.getParameter("spool_num");
				String mold_life=request.getParameter("mold_life");
				// 登记人
				String mold_destruction_register = request.getParameter("mold_destruction_register");
				// 登记时间
				String mold_destruction_regist_time = request.getParameter("mold_destruction_regist_time");
				// 获取当前时间
				// java.sql.Date d = new java.sql.Date(System
						// .currentTimeMillis());
				
				// 插入模具拆卸单表
				String sql = "insert mold_destruction(mold_id,destruction_item1,destruction_item1_content,destruction_item2,destruction_item2_content,destruction_item3,destruction_item4,destruction_item5,destruction_item6,destruction_remark,mold_destruction_register,mold_destruction_regist_time,destruction_item3_content,destruction_item4_content,mold_life_ul,spool_num) values('"
						+ id
						+ "','"
						+ radio1
						+ "','"
						+ destruction_item1_content
						+ "','"
						+ radio2
						+ "','"
						+ destruction_item2_content
						+ "','"
						+ radio3
						+ "','"
						+ radio4
						+ "','"
						+ radio5
						+ "','"
						+ radio6
						+ "','"
						+ destruction_remark
						+ "','"
						+ mold_destruction_register
						+ "','"
						+ mold_destruction_regist_time
						+ "','"+destruction_item3_content+"','"+destruction_item4_content+"','"+mold_life+"','"+spool_num+"')";
				// 执行插入语句（模具拆卸单）
				mold_db.executeUpdate(sql);
				sql = "update mold_info set mold_life_status=5, destruction_man='"+destruction_man+"',destruction_time='"+destruction_time+"' where id='"+id+"'";
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
				response.sendRedirect(path+"/mold/uninstall/register_choose_attachment.jsp?id="+id+"&mold_spec="+mold_spec+"&mold_code="+mold_code+"&destruction_time="+mold_destruction_regist_time);
				//request.getRequestDispatcher(path+"/mold/uninstall/register_choose_attachment.jsp?id="+id+"&mold_spec="+mold_spec+"&mold_code="+mold_code+"&destruction_time="+mold_destruction_regist_time).forward(request,response);
				//request.getRequestDispatcher("../../../register_choose_attachment.jsp").forward();
//				getServletContext().getRequestDispatcher("../../../register_choose_attachment.jsp").forward(request,response);
			}
		
	} catch (Exception ex) {
		ex.printStackTrace();
	}
}
}