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

public class register_ok extends HttpServlet {

	ServletContext application;

	HttpSession session;

	public synchronized void service(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		HttpSession dbSession = request.getSession();// 获取会话session
		ServletContext dbApplication = dbSession.getServletContext();// 获取全局变量application

	nseer_db_backup1 mold_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
	
	try {
		String[] mold_spec = request.getParameterValues("product_name");
		if (mold_spec.length == 1) {
			response.getWriter().print("<script>window.location.href='/erpv7/mold/apply/newRegister.jsp';alert('没有模具数据，请添加后再提交!');</script>");
	
		}
		else{
			try
			{
				
			
			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (mold_db.conn((String) dbSession.getAttribute("unit_db_name"))) {

				// 经办人
				String purchase_operater = request
						.getParameter("purchase_operater");
				// 采购时间
				String purchase_time = request.getParameter("purchase_time");
				// 供货商
				int purchase_supplier_id = Integer.parseInt(request
						.getParameter("purchase_supplier_ida"));
				// 订单号
				String purchase_id = request.getParameter("purchase_id");
				// 登记人
				String purchase_register = request.getParameter("purchase_register");
				// 登记时间
				String purchase_register_time = request.getParameter("purchase_register_time");
				//备注
				
				String remark = "";
				if(request.getParameter("remark")!=null&&!request.getParameter("remark").equals(""))
				{
					remark=request.getParameter("remark");
				}
				int purchase_count = Integer.parseInt(request.getParameter("number"));
				// 获取当前时间
				// java.sql.Date d = new java.sql.Date(System
						// .currentTimeMillis());
				
				// 插入模具采购单表
				String sql = "insert into mold_purchase_order(purchase_code,purchase_operater,purchase_time,purchase_supplier_id,purchase_register,purchase_register_time,purchase_count,order_remark) values('"
						+ purchase_id
						+ "','"
						+ purchase_operater
						+ "','"
						+ purchase_time
						+ "','"
						+ purchase_supplier_id
						+ "','"
						+ purchase_register
						+ "','"
						+ purchase_register_time
						+ "','"
						+ purchase_count
						+ "','"+remark+"')";
				// 执行插入语句（模具采购单）
				mold_db.executeUpdate(sql);
				sql = "SELECT id FROM mold_purchase_order WHERE purchase_code='"+purchase_id+"'";
				ResultSet rs=mold_db.executeQuery(sql);
				
				int id = 0;// 获得纸规格数据
				
				if(rs.next()){
					id = rs.getInt("id");
				}
				// 模具
				// 模具数据
				String[] ida = request.getParameterValues("id");				
				String[] mold_codea = request
						.getParameterValues("product_ida");
				String[] mold_typea = request.getParameterValues("mold_type");					
				for (int i = 0; i < mold_spec.length - 1; i++) {
					String mold_code =mold_codea[i + 1];
					int mold_type =Integer.parseInt(mold_typea[i + 1]);
					int idt = Integer.parseInt(ida[i + 1]);
								
				// 插入入库详情表
				sql = "insert into mold_info(mold_location,mold_spec_id,mold_spec,mold_code,mold_type,purchase_time,mold_purchase_id,mold_purchase_supplier_id)"
							+ " values('"	
							+ 1
							+"','"
							+ idt
							+"','"
							+ mold_spec[i + 1]
							+"','"
							+ mold_code
							+ "','"
							+ mold_type
							+ "','"
							+ purchase_time
							+ "','"
							+ id
							+ "','"
							+ purchase_supplier_id
							+ "')";
					mold_db.executeUpdate(sql);
					// String[] a = request.getParameterValues("checkbox");
					
				//获取 插入主见Id	
			//	sql = "SELECT id FROM mold_info WHERE mold_spec_id='"+idt+"' and mold_spec='"+mold_spec[i + 1]+"' and purchase_time='"+purchase_time+"'";
					sql="select max(id) from mold_info";
				ResultSet rs1=mold_db.executeQuery(sql);
				
					int id1 = 0;// 获得纸规格数据
				
					if(rs1.next()){
					id1 = rs1.getInt(1);
				}
					
					// 模具采购详细表
					sql = "insert into mold_purchase_order_detail(mold_id,mold_spec_id,mold_purchase_id,mold_spec,mold_type,mold_code) values('"
						+id1+"','"+idt+"','"+ id + "','"+mold_spec[i + 1]+"','"+mold_type+"','"+ mold_code + "')";
					mold_db.executeUpdate(sql);
					

				}
				

			}
		
		}catch(Exception ex)
		{
			ex.printStackTrace();
			
		}
		//提交事务
		mold_db.commit();
		String path= request.getContextPath();
		mold_db.close();
		// 跳转页面
		response
				.sendRedirect(path+"/mold/apply/register_search.jsp");

		
		}
	} catch (Exception ex) {
		ex.printStackTrace();
	
	}
}
}