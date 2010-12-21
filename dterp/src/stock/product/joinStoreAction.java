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
public class joinStoreAction extends Action {

	ServletContext application;

	HttpSession session;

	/**
	 * 入库确认
	 * 
	 * @param request
	 * @param response
	 */
	public void audting(HttpServletRequest request, HttpServletResponse response) {

		HttpSession dbSession = request.getSession();// 获取会话session
		ServletContext dbApplication = dbSession.getServletContext();// 获取全局变量application

		nseer_db_backup1 stock_d = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		
		String time2 = request.getParameter("time2");
		String personId = request.getParameter("personId");
		String  departId= request.getParameter("departId");
		String  time1= request.getParameter("time1");
		String  stockCount= request.getParameter("stockCount");
		String  comeOrderNumberId= request.getParameter("comeOrderNumberId");
		String  s= request.getParameter("s");
		List<String> listInformation= (List<String>)dbSession.getAttribute("listInformation");
		List<String> listTop= (List<String>)dbSession.getAttribute("listTop");
		List<String> listDepart= (List<String>)dbSession.getAttribute("listDepart");
		String file_name = request.getParameter("file_name");

		try {
			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_d.conn((String) dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String NO="";//帐单号
				 
				 String sql1 = "select stock_in_code from stock_in where stock_in_time like '%"+time2+"%' order by id desc limit 1";
				 ResultSet rs = stock_d.executeQuery(sql1);
				 int timeCount = 0;
				 String orderNum = "";
				 if(rs.next()){
					 timeCount=1;
					 orderNum= rs.getString("stock_in_code");
				 }
				 //在此判断数据库是否有数据
				 if(timeCount==0){
					 NO = "RK"+time2.replace("-", "").substring(2,time2.replace("-", "").length())+"01";
				 }else{
					 NO = "RK"+(Integer.parseInt(("RK"+orderNum.replace("-", "").substring(2,orderNum.replace("-", "").length())).substring(2,("RK"+orderNum.replace("-", "").substring(2,orderNum.replace("-", "").length())).length()))+1);
				 }
	 			
				 String orderNumber1=NO;//入库单号
				 
	 				String sqlStock = "insert into stock_in(stock_in_code,stock_in_operator_id,stock_in_reason_id,stock_in_time,stock_in_check_status,stock_in_count,stock_in_apply_id) values('"+
						
	 	 			NO+"','"+personId+"',"+departId+",'"+time1+"',"+0+","+stockCount+","+comeOrderNumberId+")";
	 				stock_db.executeUpdate(sqlStock);
	 				stock_db.commit();
	 	 			//查询stock_in最大ID
	 	 			String sqlMaxCount = "select id from stock_in order by id desc limit 1";
	 	 			String stock_in_id = "";
	 	 			ResultSet rs_stock=stock_db.executeQuery(sqlMaxCount);
	 	 			if(rs_stock.next()){
	 	 				stock_in_id=rs_stock.getString(1);
	 	 			}
	 	 			
	 	 			int k= 0;
	 	 			for(int i=0;i<listInformation.size();i++){
	 	 				String sqlComeOrder="";
	 	 				if(s.equals("INST1")){
	 	 					 sqlComeOrder = "SELECT * FROM stock_in_apply_detail inner join product_info on product_info.id = stock_in_apply_detail.In_Detail_product_id where apply_in_id ='"+comeOrderNumberId+"' and replace(product_lot_no,'-','')='"+listInformation.get(i)+"'";
	 	 				}else if(s.equals("INST2")){
	 	 					sqlComeOrder = "SELECT * FROM stock_in_apply_detail inner join package_info on package_info.id = stock_in_apply_detail.In_Detail_product_id where apply_in_id ='"+comeOrderNumberId+"' and package_pallet='"+listInformation.get(i)+"'";
	 	 				}
	 	 			
	 	 			ResultSet rsOrder=stock_d.executeQuery(sqlComeOrder);

	 	 				while(rsOrder.next()){
	 	 	 				//插入入库申请表 2代表原料   4代表成品
	 	 	 				String paperSql="";
	 	 		 			if(departId.equals("2")){
	 	 		 				 paperSql = "insert into stock_in_detail(stock_in_id,In_Detail_spec,In_Detail_product_id,In_Detail_invoice_no,In_Detail_width,In_Detail_length,In_Detail_weight,In_Detail_fault) values('"+stock_in_id+"','"+
	 	 		 				rsOrder.getString("In_Detail_spec")+"','"+rsOrder.getString("In_Detail_product_id")+"','"+rsOrder.getString("In_Detail_invoice_no")+"','"+rsOrder.getString("In_Detail_width")+
	 	 		 				"','"+rsOrder.getString("In_Detail_length")+"','"+rsOrder.getString("In_Detail_weight")+"','"+rsOrder.getString("In_Detail_width")+"')";
	 	 		 			}else if(departId.equals("4")){
	 	 		 				paperSql = "insert into stock_in_detail(stock_in_id,In_Detail_spec,In_Detail_product_id,In_Detail_pal,In_Detail_pallet,In_Detail_pallet_count,In_Detail_weight,In_Detail_custom_id) values('"+stock_in_id+"','"+
	 	 		 				rsOrder.getString("In_Detail_spec")+"','"+rsOrder.getString("In_Detail_product_id")+"','"+rsOrder.getString("In_Detail_pal")+"','"+rsOrder.getString("In_Detail_pallect")+"','"+
	 	 		 				rsOrder.getString("In_Detail_pallect_count")+"','"+rsOrder.getString("In_Detail_weight")+"','"+rsOrder.getString("In_Detail_custom_id")+"')";
	 	 		 				
	 	 		 			
	 	 		 			
	 	 		 			}
	 	 		 			stock_db.executeUpdate(paperSql);
	 	 		 			//9.21 lixiaodong 加入包装托盘重量更新
	 	 		 			if(departId.equals("4")){
	 	 		 				
	 	 		 				paperSql = "update package_info set package_weight=package_weight+"+rsOrder.getString("In_Detail_weight")+" where package_pallet='"+listInformation.get(i)+"'";
	 	 		 				stock_db.executeUpdate(paperSql);	
	 	 		 			}
	 	 		 			
	 	 		 		}
	 	 				k++;
	 	 			}

	 	 			 for(int i=0;i<listInformation.size();i++){	
	 	 	 			 //执行更新
	 	 	 			 String updateSql="";
	 	 	 			//原料入库   原纸入临时库
	 	 	 			 if(listTop.get(3).toLowerCase().equals("inst1")){
	 	 	 				 updateSql = "update product_info set product_stock='"+listDepart.get(i)+"',product_status=1,stock_id=101,stock_name='正品仓',stock_in_time='"+listTop.get(1)+"'  where REPLACE(product_lot_no,'-','')='"+listInformation.get(i)+"'";
	 	 	 			//成品入库
	 	 	 			 }else if(listTop.get(3).toLowerCase().equals("inst2")){ 
	 	 	 				 updateSql = "update package_info set package_stock='"+listDepart.get(i)+"',stock_id=101,stock_name='正品仓',stock_in_time='"+listTop.get(1)+"',package_in_apply_status=0,package_out_apply_status=0 where package_pallet='"+listInformation.get(i)+"'";
	 	 	 			 }
	 	 	 			 
	 	 	 			stock_db.executeUpdate(updateSql);//循环执行更新  加上库位且状态为已入库
	 	 	 			
	 	 	 		 }
	 	 			stock_db.commit();
	 	 			request.setAttribute("orderNumber1",orderNumber1);
	 	 			request.setAttribute("file_name", file_name);
				request.getRequestDispatcher("/stock/gather/register_fish.jsp").forward(request,response);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally{
			try {
				dbSession.removeAttribute("listInformation");
				dbSession.removeAttribute("listTop");
				dbSession.removeAttribute("listDepart");
				stock_d.close();stock_db.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	}