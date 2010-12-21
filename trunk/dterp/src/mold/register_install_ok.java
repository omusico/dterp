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

public class register_install_ok extends HttpServlet {

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
                // 机器号
				//String mold_machine_number = request.getParameter("mold_machine_number");
				// 上模架编号
                String top_mold_code = request.getParameter("top_mold_code");

				// 下模架编号
				String bottom_mold_code = request.getParameter("bottom_mold_code");

				// 导锁编号
			String lock_code = request.getParameter("lock_code");

				// 组装者
				String assembler = request.getParameter("assembler");
				// 组装时间
				String assembly_time = request.getParameter("assembly_time");
				// 安装者
//				String installer = request.getParameter("installer");
				String installer="";
				// 安装时间
//				String installation_time = request.getParameter("installation_time");
				String installation_time="";
				// 使用周期
//				String mold_life = request.getParameter("mold_life");
				String mold_life="";
				//int purchase_count = Integer.parseInt(request.getParameter("number"));
				// 获取当前时间
				// java.sql.Date d = new java.sql.Date(System
						// .currentTimeMillis());
				
				// 插入模具详情表
				String sql = "update mold_info set mold_life='"+mold_life+"',mold_life_status='"+3+"',assembler='"+assembler+"',assembly_time='"+assembly_time+"',top_mold_code='"+top_mold_code+"',bottom_mold_code='"+bottom_mold_code+"',lock_code='"+lock_code+"',installer='"+installer+"',installation_time='"+installation_time+"' where id='"+id+"'";
				// 执行插入语句（模具详情表）
				mold_db.executeUpdate(sql);
				String radio1 = request.getParameter("1");
				String radio2 = request.getParameter("2");
				String radio3 = request.getParameter("3");
				String radio4 = request.getParameter("4");
				String radio5 = request.getParameter("5");
				String radio6 = request.getParameter("6");
				String stype_6 = request.getParameter("type_6");
				String type_6="";
				if(stype_6.equals("200(H40)")) 
				{
					type_6="1";
				}
				if(stype_6.equals("300(H58/H60)"))
				{
					type_6="2";
				}
				if(stype_6.equals("350(H75)"))
				{
					type_6="3";
				}
				if(stype_6.equals("400(H95)"))
				{
					type_6="4";
				}
				String radio7 = request.getParameter("7");
				String radio8 = request.getParameter("8");
				String radio9 = request.getParameter("9");
				String radio10 = request.getParameter("10");
				String radio11 = request.getParameter("11");
				String radio12 = request.getParameter("12");
				String radio13 = request.getParameter("13");
				String radio14 = request.getParameter("14");
				String radio15 = request.getParameter("15");
//				String radio16 = request.getParameter("16");
//				String radio17 = request.getParameter("17");
//				String radio18 = request.getParameter("18");
//				String radio19 = request.getParameter("19");
//				String radio20 = request.getParameter("20");
//				String radio21 = request.getParameter("21");
//				String radio22 = request.getParameter("22");
				
				String radio16 = "NG";
				String radio17 = "NG";
				String radio18 = "NG";
				String radio19 = "NG";
				String radio20 = "NG";
				String radio21 = "NG";
				String radio22 = "NG";
                // 登记人
				String mold_ai_register = request.getParameter("operator");
				// 登记时间
				String mold_ai_regist_time = request.getParameter("mold_ai_regist_time");
				// 插入模具组装安装表
				sql = "insert mold_assembly_installation(mold_id,assembly_item1,assembly_item2,assembly_item3,assembly_item4,assembly_item5,assembly_item6,assembly_item6_content,assembly_item7,assembly_item8,assembly_item9,assembly_item10,assembly_item11,assembly_item12,assembly_item13,assembly_item14,assembly_item15,installation_item1,installation_item2,installation_item3,installation_item4,installation_item5,installation_item6,installation_item7,mold_ai_register,mold_ai_regist_time)"
						+ " values('"							
						+ id
						+"','"
						+ radio1
						+"','"
						+ radio2
						+"','"
						+ radio3
						+"','"
						+ radio4
						+"','"
						+ radio5
						+"','"
						+ radio6
						+"','"
						+ type_6
						+"','"
						+ radio7
						+"','"
						+ radio8
						+"','"
						+ radio9
						+"','"
						+ radio10
						+"','"
						+ radio11
						+"','"
						+ radio12
						+"','"
						+ radio13
						+"','"
						+ radio14
						+"','"
						+ radio15
						+"','"
						+ radio16
						+"','"
						+ radio17
						+"','"
						+ radio18
						+"','"
						+ radio19
						+"','"
						+ radio20
						+"','"
						+ radio21
						+"','"
						+ radio22
						+"','"
						+ mold_ai_register
						+"','"
						+ mold_ai_regist_time
						+"')";
				// 执行插入语句（模具组装安装表）
				mold_db.executeUpdate(sql);

				
				// 提交事务
				mold_db.commit();
				mold_db.close();
				String path=request.getContextPath();
				// 跳转页面
				response
						.sendRedirect(path+"/mold/install/register_search.jsp");

			}		
	} catch (Exception ex) {
		ex.printStackTrace();
	}
}
}