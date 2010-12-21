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

import stock.entity.TrayDepart;

import magic.action.Action;

/**
 * 
 * @author 高丰仪 功能：审核通过未通过 入库申请管理
 * 
 */
public class dayTrayAction extends Action {

	ServletContext application;

	HttpSession session;

	/**
	 * 今日盘点
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
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))
					&&stock_db1.conn((String) dbSession.getAttribute("unit_db_name"))) {

				List<TrayDepart> list = new ArrayList<TrayDepart>();
				
				TrayDepart trayDepart = null;
				
				String sql = "select distinct product_spec from product_info";
				//查出品位（原纸规格）显示多少列
				ResultSet rs=stock_db.executeQuery(sql);
				
//				根据显示的品名查询各个产品阶段数量  6个
				while(rs.next()){
					
					trayDepart= new TrayDepart();
					
					trayDepart.setProduct_sepc(rs.getString("product_spec"));//品名
					sql = "select count(id) from product_info where product_spec='"+rs.getString("product_spec")+"' and ((product_stock!='' and product_temp_pallet='') or (product_stock='' and product_temp_pallet!=''))";
					ResultSet rsCount = stock_db1.executeQuery(sql);
					if(rsCount.next()){
						trayDepart.setCount(rsCount.getString(1));//数量
					}
					sql = "select count(id) from product_info where product_spec='"+rs.getString("product_spec")+"' and stock_id=2 and product_temp_pallet='' and product_stock!=''";
					rsCount = stock_db1.executeQuery(sql);
					if(rsCount.next()){
						trayDepart.setPaperCount(rsCount.getString(1));//原纸临时库数量
					}
					
					sql = "select count(id) from product_info where product_spec='"+rs.getString("product_spec")+"' and stock_id=3 and product_temp_pallet='' and product_stock!=''";
					rsCount = stock_db1.executeQuery(sql);
					if(rsCount.next()){
						trayDepart.setFourCount(rsCount.getString(1));//4分切临时库数量
					}
					
					sql = "select count(id) from product_info where product_spec='"+rs.getString("product_spec")+"' and stock_id=4 and product_temp_pallet='' and product_stock!=''";
					rsCount = stock_db1.executeQuery(sql);
					if(rsCount.next()){
						trayDepart.setEightDownCount(rsCount.getString(1));//8mm下层临时库数量
					}
					
					sql = "select count(id) from product_info where product_spec='"+rs.getString("product_spec")+"' and stock_id=5 and product_temp_pallet='' and product_stock!=''";
					rsCount = stock_db1.executeQuery(sql);
					if(rsCount.next()){
						trayDepart.setEightUpCount(rsCount.getString(1));//8mm上层临时库数量
					}
									
					sql = "select count(id) from product_info where product_spec='"+rs.getString("product_spec")+"' and stock_id=6 and product_temp_pallet!='' and product_stock=''";
					rsCount = stock_db1.executeQuery(sql);
					if(rsCount.next()){
						trayDepart.setStitleCount(rsCount.getString(1));//打孔临时库数量
					}
					
					sql = "select count(id) from product_info where product_spec='"+rs.getString("product_spec")+"' and stock_id=7  and product_temp_pallet='' and product_stock!=''";
					rsCount = stock_db1.executeQuery(sql);
					if(rsCount.next()){
						trayDepart.setEightUpSuccessCount(rsCount.getString(1));//8mm上层库数量
					}
					
					sql = "select count(id) from product_info where product_spec='"+rs.getString("product_spec")+"' and stock_id=7 and product_temp_pallet!='' and product_stock=''";
					rsCount = stock_db1.executeQuery(sql);
					if(rsCount.next()){
						trayDepart.setStitleCountSuccess(rsCount.getString(1));//打孔库数量
					}
					list.add(trayDepart);
				}
				
				stock_db1.close();stock_db.close();
				//根据显示的品名查询所有的数量
				request.setAttribute("listDepart",list);
				request.getRequestDispatcher("/stock/analyse/getTodayReport.jsp").forward(request,response);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	}