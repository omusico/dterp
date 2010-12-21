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
import java.sql.SQLException;
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
public class comeoutStoreAction extends Action {

	ServletContext application;

	HttpSession session;

	/**
	 * 出库确认
	 * 
	 * @param request
	 * @param response
	 */
	public void audting(HttpServletRequest request, HttpServletResponse response) {

		HttpSession dbSession = request.getSession();// 获取会话session
		ServletContext dbApplication = dbSession.getServletContext();// 获取全局变量application

		nseer_db_backup1 stock_d = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		
		String time2 = dbSession.getAttribute("time2").toString();
		String personName = dbSession.getAttribute("personName").toString();
		String person_id = dbSession.getAttribute("person_id").toString();
		String time1 = dbSession.getAttribute("time1").toString();
		String applyOrderNumberId = dbSession.getAttribute("applyOrderNumberId").toString();
		String deapat = dbSession.getAttribute("deapat").toString();
		List<String> readF2 = (List<String>)dbSession.getAttribute("readF2");
		List<String> readF = (List<String>)dbSession.getAttribute("readF");
		
		try {
			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_d.conn((String) dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String NO="";//帐单号
				 
				 String sql = "select stock_out_id from stock_out where stock_out_time like '%"+time2+"%' order by id desc limit 1";
				 ResultSet rs1 = stock_d.executeQuery(sql);
				 int timeCount = 0;
				 String orderNum = "";
				 if(rs1.next()){
					 timeCount=1;
					 orderNum= rs1.getString("stock_out_id");
				 }
				 //在此判断数据库是否有数据
				 if(timeCount==0){
					 NO = "CK"+time2.replace("-", "").substring(2,time2.replace("-", "").length())+"01";
				 }else{
					 NO = "CK"+(Integer.parseInt(("CK"+orderNum.replace("-", "").substring(2,orderNum.replace("-", "").length())).substring(2,("CK"+orderNum.replace("-", "").substring(2,orderNum.replace("-", "").length())).length()))+1);
				 }
				
				 String orderNumber=NO;
				
				sql = "insert into stock_out(stock_out_id,stock_out_operator_id,stock_out_reason_id,stock_out_time,stock_out_check_status,apply_stock_status,stock_out_count,stock_out_apply_id) values('"
						+ NO
						+ "','"
						+ personName
						+ "',"
						+ person_id
						+ ",'"
						+ time1
						+ "',"
						+ 0
						+ ","
						+ 0
						+ ","
						+ readF2.size() + "," + applyOrderNumberId + ")";
				stock_d.executeUpdate(sql);// 插入出库单
				stock_d.commit();
				
				sql = "select id from stock_out order by id desc limit 1";

				ResultSet rsApp = stock_d.executeQuery(sql);// 获取stock_out表的最大ID
				int applyId = 0;
				
				if(rsApp.next()) {
					applyId = rsApp.getInt("id");
				}
			
				

				// 在此判断是生产出库还是成品出库
				if (deapat.toLowerCase().equals("outs1")) {
					
					for (int i = 0; i < readF2.size(); i++) {
						sql = "update product_info set product_status=7,stock_out_time='"+readF.get(1)+"' where replace(product_lot_no,'-','')='"
								+ readF2.get(i) + "'";
						stock_d.executeUpdate(sql);
					}
					// 插入出库单详情readF2
					for(int i=0;i<readF2.size();i++){
						sql = "select * from stock_out_apply_detail inner join product_info on product_info.id = stock_out_apply_detail.out_detail_product_id where apply_out_id='"
							+ applyOrderNumberId + "' and replace(product_lot_no,'-','')='"+readF2.get(i)+"'";
					ResultSet rsApply = stock_db.executeQuery(sql);
					while (rsApply.next()) {
						sql = "insert into stock_out_detail(stoct_out_id,out_Detail_spec,out_Detail_product_id,out_Detail_invoice_no,out_Detail_width,out_Detail_length,out_Detail_weight,out_Detail_fault) values("
								+ applyId
								+ ",'"
								+ rsApply.getString("out_Detail_spec")
								+ "','"
								+ rsApply.getString("out_Detail_product_id")
								+ "','"
								+ rsApply.getString("out_Detail_invoice_no")
								+ "','"
								+ rsApply.getString("out_Detail_width")
								+ "','"
								+ rsApply.getString("out_Detail_length")
								+ "','"
								+ rsApply.getString("out_Detail_weight")
								+ "','"
								+ rsApply.getString("out_Detail_width")
								+ "')";
						stock_d.executeUpdate(sql);
					}
					}
					stock_d.commit();//提交事务
					
				} else if (deapat.toLowerCase().equals("outs2")) {
					
					for (int i = 0; i < readF2.size(); i++) {
						sql = "update package_info set package_stock='',is_out_stock=1,stock_out_time='"+readF.get(1)+"' where package_pallet='"
								+ readF2.get(i) + "'";
						stock_d.executeUpdate(sql);
					}
					for(int i=0;i<readF2.size();i++){
//						 插入出库单详情
						sql = "select * from stock_out_apply_detail inner join package_info on package_info.id = stock_out_apply_detail.out_detail_product_id where apply_out_id='"
								+ applyOrderNumberId + "' and package_pallet='"+readF2.get(i)+"'";
						ResultSet rsApply = stock_db.executeQuery(sql);
						while (rsApply.next()) {
							sql = "insert into stock_out_detail(stoct_out_id,out_Detail_spec,out_Detail_product_id,out_Detail_pal,out_Detail_pallet,out_Detail_pallet_count,out_Detail_weight,out_Detail_custom_id) values("
									+ applyId
									+ ",'"
									+ rsApply.getString("out_Detail_spec")
									+ "','"
									+ rsApply.getString("out_Detail_product_id")
									+ "','"
									+ rsApply.getString("out_Detail_pal")
									+ "','"
									+ rsApply.getString("out_Detail_pallect")
									+ "','"
									+ rsApply.getString("out_Detail_pallect_count")
									+ "','"
									+ rsApply.getString("out_Detail_weight")
									+ "','"
									+ rsApply.getString("out_Detail_custom_id")
									+ "')";
							stock_d.executeUpdate(sql);
							
						}
					}
					stock_d.commit();//提交事务
				}
				request.setAttribute("orderNumber", orderNumber);
				request.setAttribute("fileName", request.getParameter("fileName"));
				request.getRequestDispatcher("/stock/pay/result_register_list.jsp").forward(request,response);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally{
			try {
				stock_d.close();stock_db.close();
				dbSession.removeAttribute("time2");dbSession.removeAttribute("time1");
				dbSession.removeAttribute("person_id");dbSession.removeAttribute("personName");
				dbSession.removeAttribute("applyOrderNumberId");dbSession.removeAttribute("deapat");
				dbSession.removeAttribute("readF2");dbSession.removeAttribute("readF");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	}