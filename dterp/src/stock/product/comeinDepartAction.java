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

import include.nseer_db.nseer_db;
import include.nseer_db.nseer_db_backup1;
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
import manufacture.process.FileRead;

/**
 * 
 * @author 高丰仪 功能：审核通过未通过 入库申请管理
 * 
 */
public class comeinDepartAction extends Action {

	ServletContext application;

	HttpSession session;

	/**
	 * 审核通过
	 * 
	 * @param request
	 * @param response
	 */
	public void audting(HttpServletRequest request, HttpServletResponse response){

		HttpSession dbSession = request.getSession();// 获取会话session
		ServletContext dbApplication = dbSession.getServletContext();// 获取全局变量application

		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		nseer_db_backup1 stock_db1 = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		
		try {
			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))&&stock_db1.conn((String) dbSession.getAttribute("unit_db_name"))) {
				
			int	id = Integer.parseInt(request.getParameter("id"));
			
			int proId = Integer.parseInt(request.getParameter("sake"));// 入库理由ID
			
			String audtiong = request.getParameter("registerPerson");// 审核人
			String audtiongTime = request.getParameter("registerTime");// 审核时间
			
			if(audtiong==null||audtiongTime==null){
				audtiong="";
				audtiongTime="";
			}
	
			String sql = "update stock_in set  stock_in_checker='"+audtiong+"' , stock_in_check_time='"+audtiongTime+"', stock_in_check_status=1  where id="+id;
			stock_db.executeUpdate(sql);
			if(proId==2){
			sql = "select product_info.id from stock_in_detail inner join product_info on stock_in_detail.In_Detail_product_id=product_info.id where stock_in_id='"+id+"'";
			ResultSet rs=stock_db1.executeQuery(sql);
			while(rs.next()){
					sql = "update product_info set product_status=1 where id='"+rs.getString("product_info.id")+"'";
					stock_db.executeUpdate(sql);
				}
			}
			stock_db.commit();
			response.sendRedirect("stock/gather/check_list_auditing_radio.jsp");
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
					&& stock_db1.conn((String) dbSession.getAttribute("unit_db_name"))) {

				int id = Integer.parseInt(request.getParameter("id"));// 入库单ID

				int sakeId = Integer.parseInt(request.getParameter("sake"));// 入库理由ID

				String sql = "delete from stock_in where id = " + id;

				stock_db.executeUpdate(sql);// 删除入库单

				// 为2时为原材料入库 4时成品入库
				if (sakeId == 2) {
					sql = "select product_info.id from stock_in_detail inner join product_info on product_info.id = stock_in_detail.In_Detail_product_id where stock_in_id="
							+ id;
					ResultSet rs = stock_db1.executeQuery(sql);// 用入库单ID查找产品ID
					while (rs.next()) {
						// product_stock=,product_status=1,stock_id=101,stock_name='正品仓',stock_in_time=  
						sql = "update product_info set product_stock='',product_status=0,stock_id=0,stock_name='',stock_in_time='' where id="
								+ rs.getInt("product_info.id");
						stock_db.executeUpdate(sql);// 循环替换产品库位
					}
				} else if (sakeId == 4) {
					sql = "select package_info.id from stock_in_detail inner join package_info on package_info.id = stock_in_detail.In_Detail_product_id where stock_in_id="
							+ id;
					ResultSet rs = stock_db1.executeQuery(sql);// 用入库单ID查找产品ID
					while (rs.next()) {
						sql = "update package_info set package_stock='',stock_id=0,stock_name='',stock_in_time='' where id="
								+ rs.getInt("package_info.id");
						stock_db.executeUpdate(sql);// 循环替换产品库位
					}
				}
				sql = "delete from stock_in_detail where stock_in_id=" + id;// 删除入库单详情
				stock_db.executeUpdate(sql);
				stock_db.commit();

			}

			stock_db1.close();
			stock_db.close();// 关闭连接
			response.sendRedirect("stock/gather/check_list_auditing_radio1.jsp");

		} catch (Exception ex) {
			ex.printStackTrace();
		}

	}

	public void comeDepart(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession dbSession = request.getSession();// 获取会话session
		ServletContext dbApplication = dbSession.getServletContext();// 获取全局变量application

		nseer_db_backup1 stock_db1 = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		nseer_db_backup1 design_db1 = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法

		try {
			String filePath = request.getParameter("filePath").toString();
			FileRead fileRead1 = new FileRead();
			List<String> listFile = fileRead1.readDocument(filePath);// 获得正确的信息
			List<String> listInformation = fileRead1.readLotNo(filePath);// 获得LOTNO号
																			// 或
																			// 栈板号
			List<String> listDepart = fileRead1.readDepart(filePath);// 获得库位号
																		// 或 托盘
			List<String> listTop = fileRead1.readInformation(filePath);// 获取头部信息
			String s = listTop.get(3);
			String b = listTop.get(3).toLowerCase();

			if (stock_db1.conn((String) session.getAttribute("unit_db_name"))) {
				String personId = listTop.get(2);// 经办人Id

				String orderNumber = fileRead1.getOrderNumber();// 入库单号
				String lotNo = listInformation.get(0);// LOTNO
				String sqlOrderNumber = "select stock_in_apply.apply_in_apply_code from stock_in_apply_detail inner join product_info on product_info.id = stock_in_apply_detail.In_Detail_product_id inner join stock_in_apply on stock_in_apply.id = stock_in_apply_detail.apply_in_id where product_info.product_lot_no='"
						+ lotNo + "'";
				ResultSet rsOrderNumber = design_db1
						.executeQuery(sqlOrderNumber);
				String comeOrderNumber = "";// 入库申请单号
				if (rsOrderNumber.next()) {
					comeOrderNumber = rsOrderNumber
							.getString("stock_in_apply.apply_in_apply_code");
				}
				int departId = 0;// 入库理由ID
				if (listTop.get(3).toLowerCase().equals("inst1")) {
					departId = 2;
				} else if (listTop.get(3).toLowerCase().equals("inst2")) {
					departId = 4;
				}
				int stockCount = listDepart.size();// 入库件数

				String sqlStock = "insert into stock_in(stock_in_code,stock_in_operator_id,stock_in_reason_id,stock_in_time,stock_in_check_status,stock_in_count,stock_in_apply_id) values('"
						+

						orderNumber
						+ "','"
						+ personId
						+ "',"
						+ departId
						+ ",'"
						+ fileRead1.getTime()
						+ "',"
						+ 0
						+ ","
						+ stockCount
						+ ",'" + comeOrderNumber + "'" + ")";
				stock_db1.executeUpdate(sqlStock);
				// 插入入库申请表

				for (int i = 0; i < listInformation.size(); i++) {
					// 执行更新
					String updateSql = "";
					// 原料入库 原纸入临时库
					if (listTop.get(3).toLowerCase().equals("inst1")
							|| listTop.get(3).toLowerCase().equals("inst3")) {
						updateSql = "update product_info set product_stock='"
								+ listDepart.get(i)
								+ "' , product_status=1,product_type=1 where REPLACE(product_lot_no,'-','')='"
								+ listInformation.get(i) + "'";
						// 成品入库
					} else if (listTop.get(3).toLowerCase().equals("inst2")) {
						updateSql = "update package_info set package_stock='"
								+ listDepart.get(i)
								+ "' where package_pallet='"
								+ listInformation.get(i) + "'";
					}

					stock_db1.executeUpdate(updateSql);// 循环执行更新 加上库位且状态为已入库

				}

				stock_db1.commit();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}