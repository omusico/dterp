/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.product;

import include.nseer_db.nseer_db_backup1;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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

import magic.action.Action;

/**
 * 
 * @author 高丰仪 功能：审核通过未通过 入库申请管理
 * 
 */
public class comeoutDepartOutAction extends Action {

	ServletContext application;

	HttpSession session;

	/**
	 * 审核 通过
	 * 
	 * @param request
	 * @param response
	 */
	public void audting(HttpServletRequest request, HttpServletResponse response) {

		HttpSession dbSession = request.getSession();// 获取会话session
		ServletContext dbApplication = dbSession.getServletContext();// 获取全局变量application

		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		nseer_db_backup1 stock_db1 = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		
		try {
			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))&&stock_db1.conn((String) dbSession.getAttribute("unit_db_name"))) {
				int id = Integer.parseInt(request.getParameter("orderId"));//ID
				int proId = Integer.parseInt(request.getParameter("proId"));//入库理由ID
				String audtiong = request.getParameter("registerPerson");// 审核人
				String audtiongTime = request.getParameter("registerTime");// 审核时间

				if (audtiong == null || audtiongTime == null) {
					audtiong = "";
					audtiongTime = "";
				}

				String sql = "update stock_out set stock_out_checker='"
						+ audtiong + "' , stock_out_check_time='"
						+ audtiongTime
						+ "',stock_out_check_status=1  where id=" + id;
				stock_db.executeUpdate(sql);
				if(proId==3){
					sql = "select product_info.id from stock_out inner join stock_out_detail on stock_out.id = stock_out_detail.stoct_out_id inner join product_info on stock_out_detail.Out_Detail_product_id=product_info.id where stock_out.id='"+id+"'";
				}else if(proId==5){
					sql = "select package_info.id from stock_out inner join stock_out_detail on stock_out.id = stock_out_detail.stoct_out_id inner join package_info on stock_out_detail.Out_Detail_product_id=package_info.id where stock_out.id='"+id+"'";
				}
				ResultSet rs=stock_db1.executeQuery(sql);
				while(rs.next()){
					if(proId==3){
						sql ="update product_info set product_stock='',stock_id=0,stock_name='',product_out_apply_status=0,product_status=7 where id="+rs.getInt(1);
					}else if(proId==5){
						sql ="update package_info set package_stock='',stock_id=0,stock_name='',package_out_apply_status=0,is_out_stock=1 where id="+rs.getInt(1);
					}
					stock_db.executeUpdate(sql);
				}
				
				stock_db.commit();
				response
						.sendRedirect("stock/pay/check_list_auditing_radio.jsp");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/**
	 * 未通过
	 * 
	 * @param request
	 * @param response
	 */
	public void noAudting(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession dbSession = request.getSession();// 获取会话session
		ServletContext dbApplication = dbSession.getServletContext();// 获取全局变量application

		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		nseer_db_backup1 stock_db1 = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法

		try {
			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))
					&& stock_db1.conn((String) dbSession
							.getAttribute("unit_db_name"))) {
				int id = Integer.parseInt(request.getParameter("orderId"));

				int proId = Integer.parseInt(request.getParameter("proId"));
				String sql="";
				// 库位还原 应有一个集合存储清空后的库位stockH
//				 为2时为原材料入库 4时成品入库
				if (proId == 3) {
					sql = "select product_info.id from stock_out_detail inner join product_info on product_info.id = stock_out_detail.out_Detail_product_id where stoct_out_id="
							+ id;
					ResultSet rs = stock_db1.executeQuery(sql);// 用入库单ID查找产品ID
					while (rs.next()) {
						// product_stock=,product_status=1,stock_id=101,stock_name='',stock_in_time=  
						sql = "update product_info set product_status=1,stock_id=101,stock_name='正品仓',stock_out_time='' where id="
								+ rs.getInt("product_info.id");
						stock_db.executeUpdate(sql);// 循环替换产品库位
					}
				} else if (proId == 5) {
					sql = "select product_info.id from stock_out_detail inner join product_info on product_info.id = stock_out_detail.out_Detail_product_id where stoct_out_id="
							+ id;
					ResultSet rs = stock_db1.executeQuery(sql);// 用入库单ID查找产品ID
					while (rs.next()) {
						sql = "update product_info set product_status=1,stock_id=101,stock_name='正品仓',stock_out_time='' where id="
								+ rs.getInt("product_info.id");
						stock_db.executeUpdate(sql);// 循环替换产品库位
					}
				}
				 sql = "delete from stock_out where id=" + id;
				stock_db.executeUpdate(sql);
				sql = "delete from stock_out_detail where stoct_out_id=" + id;
				stock_db.executeUpdate(sql);

				stock_db.commit();
				stock_db.close();

				response.sendRedirect("stock/pay/check_list_auditing_radio1.jsp");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}