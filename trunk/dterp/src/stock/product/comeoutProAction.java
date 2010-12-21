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

import java.io.IOException;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;

import magic.action.Action;

/**
 * 
 * @author 高丰仪 功能：生产出库 出库申请单提交
 * 
 */
public class comeoutProAction extends Action {

	ServletContext application;

	HttpSession session;

	public void addChu(HttpServletRequest request, HttpServletResponse response) {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		ServletContext dbApplication = dbSession.getServletContext();
		ServletContext application;
		HttpSession session = request.getSession();
		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		nseer_db_backup1 stock_stock = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		nseer_db_backup1 stock_d = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		try {
			String deportPerson = request.getParameter("gatherer_name");// 出库人
			int deportId = Integer.parseInt(request.getParameter("reason"));// 出库理由
			String loginPerson = request.getParameter("register");// 登记人
			String loginTime = request.getParameter("registerTime");// 登记时间
			loginTime = loginTime.substring(0, 10);
			String remark = request.getParameter("remark");// 备注

			String[] paperSpec = request.getParameterValues("product_name");// 原纸规格
			String[] lotNo = request.getParameterValues("product_ID");// LOT
			// NO
			String[] InvoiceNo = request
					.getParameterValues("product_describe_ok");// Invoice NO
			String[] width = request.getParameterValues("amount");// 宽度
			String[] length = request.getParameterValues("amount_unit");// 长度
			String[] weight = request.getParameterValues("cost_price");// 重量
			String[] departLocation = request.getParameterValues("depot1");// 库位

			String[] productId = request.getParameterValues("productId");// 产品ID

			// 打开连接
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))
					&& stock_stock.conn((String) dbSession
							.getAttribute("unit_db_name"))
					&& stock_db.conn((String) dbSession
							.getAttribute("unit_db_name"))
					&& stock_d.conn((String) dbSession
							.getAttribute("unit_db_name"))) {

				// 获取当前时间
				java.sql.Date d = new java.sql.Date(System.currentTimeMillis());

				// 获得一个随机数
				Date t = new Date();
				String runNumber = (t + "").substring(17, 19);

				java.util.Date now = new java.util.Date();
				SimpleDateFormat formatter = new SimpleDateFormat(
						"yyyy-MM-dd HH:mm:ss");
				String time = formatter.format(now);
				SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd");
				String time1 = formatter1.format(now);

				String NO = "";// 帐单号

				String sql1 = "select apply_out_id from stock_out_apply where apply_out_register_time like '%"
						+ time1 + "%' order by id desc limit 1";
				ResultSet rs = stock_d.executeQuery(sql1);
				int timeCount = 0;
				String orderNum = "";
				if (rs.next()) {
					timeCount = 1;
					orderNum = rs.getString("apply_out_id");
				}
				// 在此判断数据库是否有数据
				if (timeCount == 0) {
					NO = "CS"
							+ time1.replace("-", "").substring(2,
									time1.replace("-", "").length()) + "01";
				} else {
					NO = "CS"
							+ (Integer.parseInt(("CS" + orderNum.replace("-",
									"").substring(2,
									orderNum.replace("-", "").length()))
									.substring(2,
											("CS" + orderNum.replace("-", "")
													.substring(
															2,
															orderNum.replace(
																	"-", "")
																	.length()))
													.length())) + 1);
				}

				// 插入入库申请表
				String sql = "insert into stock_out_apply(apply_out_id,apply_out_reason_id,apply_out_register,apply_out_register_time,apply_stock_status,apply_out_count,apply_out_remark,apply_out_operator) values('"
						+ NO
						+ "','"
						+ deportId
						+ "','"
						+ loginPerson
						+ "','"
						+ time.toString()
						+ "','"
						+ 0
						+ "','"
						+ (paperSpec.length - 1)
						+ "','"
						+ remark
						+ "','"
						+ deportPerson + "')";
				// // 执行插入语句（入库申请表）
				stock_db.executeUpdate(sql);
				stock_db.commit();

				sql = "select * from stock_out_apply order by id desc limit 1";

				ResultSet rsApply = stock_stock.executeQuery(sql);// 获取stock_in_apply表的最大ID
				int applyId = 0;
				while (rsApply.next()) {
					applyId = rsApply.getInt(1);
				}

				sql = "select * from stoct_out_apply order by id desc limit 1";

				for (int i = 0; i < paperSpec.length - 1; i++) {
					// 插入入库详情表
					sql = "insert into stock_out_apply_detail(apply_out_id,Out_Detail_product_id,out_Detail_invoice_no,out_Detail_spec,out_Detail_weight,out_Detail_width,out_Detail_length)"
							+ " values('"
							+ applyId
							+ "','"
							+ productId[i + 1]
							+ "','"
							+ InvoiceNo[i + 1]
							+ "','"
							+ paperSpec[i + 1]
							+ "','"
							+ weight[i + 1]
							+ "','"
							+ width[i + 1] + "','" + length[i + 1] + "')";
					stock_db.executeUpdate(sql);
					// 更改产品状态为预出库
					sql = "update product_info set product_out_apply_status=1  where id="
							+ productId[i + 1];
					stock_db.executeUpdate(sql);
				}

				stock_db.commit();// 提交事务
				stock_db.close();// 关闭连接
				stock_stock.close(); // add by wangshaolin
				stock_d.close(); // add by wangshaolin

				// 跳转页面
				response.sendRedirect("stock/apply_pay/register_search.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void addSuccess(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			HttpSession dbSession = request.getSession();// 获取会话session
			ServletContext dbApplication = dbSession.getServletContext();// 获取全局变量application

			nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
			nseer_db_backup1 stock_db1 = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
			nseer_db_backup1 stock_stock = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
			nseer_db_backup1 stock_d = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法

			String deportPerson = request.getParameter("gatherer_name");// 出库人
			int deportId = Integer.parseInt(request.getParameter("reason"));// 出库理由
			String loginPerson = request.getParameter("register");// 登记人
			String loginTime = request.getParameter("registerTime");// 登记时间
			String remark = request.getParameter("remark");// 备注

			String[] paperSpec = request.getParameterValues("product_name1");// 原纸规格
			String[] lotNo = request.getParameterValues("product_ID1");// 规格
			String[] InvoiceNo = request
					.getParameterValues("product_describe_ok1");// 栈板号
			String[] width = request.getParameterValues("amount1");// 托盘
			String[] length = request.getParameterValues("amount_unit1");// 数量
			String[] weigth = request.getParameterValues("cost_price1");// 净重
			String[] custerPerson = request.getParameterValues("cost_person");// 客户
			String[] departLocation = request.getParameterValues("cost_dopet");// 库位
			String[] person_cust_Id = request
					.getParameterValues("cost_personId");// 客户ID

			java.util.Date now = new java.util.Date();
			SimpleDateFormat formatter = new SimpleDateFormat(
					"yyyy-MM-dd HH:mm:ss");
			String time = formatter.format(now);

			// 打开连接
			if (stock_stock.conn((String) dbSession
					.getAttribute("unit_db_name"))
					&& stock_db.conn((String) dbSession
							.getAttribute("unit_db_name"))
					&& stock_d.conn((String) dbSession
							.getAttribute("unit_db_name"))) {
				SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd");
				String time1 = formatter1.format(now);

				String NO = "";// 帐单号

				String sql1 = "select apply_out_id from stock_out_apply where apply_out_register_time like '%"
						+ time1 + "%' order by id desc limit 1";
				ResultSet rs = stock_d.executeQuery(sql1);
				int timeCount = 0;
				String orderNum = "";
				if (rs.next()) {
					timeCount = 1;
					orderNum = rs.getString("apply_out_id");
				}
				// 在此判断数据库是否有数据
				if (timeCount == 0) {
					NO = "CS"
							+ time1.replace("-", "").substring(2,
									time1.replace("-", "").length()) + "01";
				} else {
					NO = "CS"
							+ (Integer.parseInt(("CS" + orderNum.replace("-",
									"").substring(2,
									orderNum.replace("-", "").length()))
									.substring(2,
											("CS" + orderNum.replace("-", "")
													.substring(
															2,
															orderNum.replace(
																	"-", "")
																	.length()))
													.length())) + 1);
				}

				// 打开连接
				if (stock_db1.conn((String) dbSession
						.getAttribute("unit_db_name"))) {

					// 获取当前时间
					java.sql.Date dTime = new java.sql.Date(System
							.currentTimeMillis());

					// 插入入库申请表
					String sql = "insert into stock_out_apply(apply_out_id,apply_out_reason_id,apply_out_register,apply_out_register_time,apply_stock_status,apply_out_count,apply_out_remark,apply_out_operator) values('"
							+ NO
							+ "','"
							+ deportId
							+ "','"
							+ loginPerson
							+ "','"
							+ time
							+ "','"
							+ 0
							+ "','"
							+ (paperSpec.length - 1)
							+ "','"
							+ remark
							+ "','"
							+ deportPerson + "')";
					// // 执行插入语句（入库申请表）
					stock_stock.executeUpdate(sql);
					stock_stock.commit();

					sql = "select * from stock_out_apply order by id desc limit 1";

					ResultSet rsApply = stock_stock.executeQuery(sql);// 获取stock_in_apply表的最大ID
					int applyId = 0;
					while (rsApply.next()) {
						applyId = rsApply.getInt(1);
					}

					String[] proId = request.getParameterValues("proId");

					// out_Detail_spec paperSpec
					for (int i = 0; i < paperSpec.length - 1; i++) {
						sql = "select id from crm_file where CUSTOMER_NAME='"
								+ custerPerson[i + 1] + "'";
						rsApply = stock_stock.executeQuery(sql);
						int personId = 0;
						if (rsApply.next()) {
							personId = rsApply.getInt(1);
						}

						// 插入出库详情表
						sql = "insert into stock_out_apply_detail(apply_out_id,Out_Detail_product_id,Out_Detail_invoice_no,Out_Detail_pal,Out_Detail_pallect,Out_Detail_pallect_count,Out_Detail_weight,Out_Detail_custom_id)"
								+ " values('"
								+ applyId
								+ "','"
								+ proId[i + 1]
								+ "','"
								+ lotNo[i + 1]
								+ "','"
								+ InvoiceNo[i + 1]
								+ "','"
								+ width[i + 1]
								+ "','"
								+ length[i + 1]
								+ "','"
								+ weigth[i + 1]
								+ "','" + personId + "')";

						stock_db.executeUpdate(sql);
						sql = "update package_info set package_out_apply_status=1 where id="
								+ proId[i + 1];
						stock_db.executeUpdate(sql);
					}
					stock_db.commit();// 提交事务
					stock_db.close();// 关闭连接
					stock_db1.close();
					stock_stock.close();
					stock_d.close();
				}
			}
			// 跳转页面
			response.sendRedirect("stock/apply_pay/register_search.jsp");

		} catch (Exception e) {
			e.getMessage();
		}
	}

	/**
	 * 审核
	 * 
	 * @param request
	 * @param response
	 */
	public void audting(HttpServletRequest request, HttpServletResponse response) {

		HttpSession dbSession = request.getSession();// 获取会话session
		ServletContext dbApplication = dbSession.getServletContext();// 获取全局变量application

		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法

		try {
			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String checkPerson = request.getParameter("registerPerson");// 审核人
				String checkTime = request.getParameter("registerTime");// 审核时间
				int id = Integer.parseInt(request.getParameter("orderId"));
				String sql = "update stock_out_apply set apply_out_check_status=1,apply_out_checker='"
						+ checkPerson
						+ "',apply_out_check_time='"
						+ checkTime
						+ "'  where id=" + id;
				stock_db.executeUpdate(sql);
				stock_db.commit();
			}
			stock_db.close();
			response
					.sendRedirect("stock/apply_pay/check_list_auditing_radio.jsp");
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

		try {
			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				int id = Integer.parseInt(request.getParameter("orderId"));
				String remark = request.getParameter("remark1");
				String checkPerson = request.getParameter("registerPerson");// 审核人
				String checkTime = request.getParameter("registerTime");// 审核时间
				String sql = "update stock_out_apply set apply_out_check_status=2,autding_remark='"
						+ remark
						+ "',apply_out_checker='"
						+ checkPerson
						+ "',apply_out_check_time='"
						+ checkTime
						+ "' where id=" + id;
				stock_db.executeUpdate(sql);
				stock_db.commit();
			}
			stock_db.close();
			response
					.sendRedirect("stock/apply_pay/check_list_auditing_radio1.jsp");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 */
	public void searchDetail(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession dbSession = request.getSession();// 获取会话session
		ServletContext dbApplication = dbSession.getServletContext();// 获取全局变量application

		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		nseer_db_backup1 stock_d = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法

		try {
			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))
					&& stock_d.conn((String) dbSession
							.getAttribute("unit_db_name"))) {
				int id = Integer.parseInt(request.getParameter("id"));
				String[] paperSpec = request.getParameterValues("product_name");// 原纸规格
				String[] lotNo = request.getParameterValues("product_ID");// LOT
				// NO
				String[] InvoiceNo = request
						.getParameterValues("product_describe_ok");// Invoice
				// NO
				String[] width = request.getParameterValues("amount");// 宽度
				String[] length = request.getParameterValues("amount_unit");// 长度
				String[] weight = request.getParameterValues("cost_price");// 重量
				String[] departLocation = request.getParameterValues("depot1");// 库位

				Map<String, Integer> map = new HashMap<String, Integer>();
				// 在此声明一个HashMap集合

				// 迭代数组
				for (String str : lotNo) {
					Integer num = map.get(str);
					num = null == num ? 1 : num + 1;
					map.put(str, num);
				}
				if (lotNo.length != map.size()) {
					response
							.sendRedirect("stock/apply_pay/change_error.jsp?number="
									+ id);
					return;
				}

				String remark = request.getParameter("remark");

				String sql = "update stock_out_apply set apply_out_check_status=0,apply_out_count='"
						+ (length.length - 1)
						+ "',apply_out_remark='"
						+ remark
						+ "' where id=" + id;
				stock_db.executeUpdate(sql);

				// 查询以前的数据
				sql = "select product_lot_no from stock_out_apply_detail inner join product_info on product_info.id = stock_out_apply_detail.Out_Detail_product_id where apply_out_id='"
						+ id + "'";
				ResultSet rs1 = stock_d.executeQuery(sql);
				// 把状态改为未预入库
				while (rs1.next()) {
					sql = "update product_info set product_out_apply_status=0 where product_lot_no='"
							+ rs1.getString("product_lot_no") + "'";
					stock_db.executeUpdate(sql);
				}

				sql = "delete from stock_out_apply_detail where apply_out_id='"
						+ id + "'";
				stock_db.executeUpdate(sql);
				String productId = "";

				for (int i = 0; i < paperSpec.length - 1; i++) {

					sql = "select id from product_info where product_lot_no='"
							+ lotNo[i + 1] + "'";
					ResultSet rs = stock_db.executeQuery(sql);
					if (rs.next()) {
						productId = rs.getString(1);
					}
					// 新增产品为预入库
					sql = "update product_info set product_out_apply_status=1 where id="
							+ productId;
					stock_db.executeUpdate(sql);
					// 插入入库详情表
					sql = "insert into stock_out_apply_detail(apply_out_id,Out_Detail_product_id,out_Detail_invoice_no,out_Detail_spec,out_Detail_weight,out_Detail_width,out_Detail_length)"
							+ " values('"
							+ id
							+ "','"
							+ productId
							+ "','"
							+ InvoiceNo[i + 1]
							+ "','"
							+ paperSpec[i + 1]
							+ "','"
							+ weight[i + 1]
							+ "','"
							+ width[i + 1]
							+ "','" + length[i + 1] + "')";
					stock_db.executeUpdate(sql);
				}
				stock_db.commit();
			}
			stock_db.close();
			stock_d.close();// add by wangshaolin
			response.sendRedirect("stock/apply_pay/change_search.jsp");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/**
	 * 变更 成品出库
	 * 
	 * @param request
	 * @param response
	 */
	public void search(HttpServletRequest request, HttpServletResponse response) {

		HttpSession dbSession = request.getSession();// 获取会话session
		ServletContext dbApplication = dbSession.getServletContext();// 获取全局变量application

		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		nseer_db_backup1 stock_d = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法

		try {
			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))
					&& stock_d.conn((String) dbSession
							.getAttribute("unit_db_name"))) {
				int id = Integer.parseInt(request.getParameter("id"));// 入库申请单号
				String[] paperSpec = request
						.getParameterValues("product_name1");// 原纸规格
				String[] lotNo = request.getParameterValues("product_ID1");// 规格
				String[] InvoiceNo = request
						.getParameterValues("product_describe_ok1");// 栈板号
				String[] width = request.getParameterValues("amount1");// 托盘
				String[] length = request.getParameterValues("amount_unit1");// 数量
				String[] weigth = request.getParameterValues("cost_price1");// 净重
				String[] custerPerson = request
						.getParameterValues("cost_person1");// 客户
				String[] departLocation = request
						.getParameterValues("cost_dopet1");// 库位

				Map<String, Integer> map = new HashMap<String, Integer>();
				// 在此声明一个HashMap集合

				// 迭代数组
				for (String str : InvoiceNo) {
					Integer num = map.get(str);
					num = null == num ? 1 : num + 1;
					map.put(str, num);
				}
				if (InvoiceNo.length != map.size()) {
					response
							.sendRedirect("stock/apply_pay/change_error1.jsp?number="
									+ id);
					return;
				}
				String remark = request.getParameter("remark");

				String sql = "update stock_out_apply set apply_out_check_status=0,apply_out_count='"
						+ (length.length - 1)
						+ "',apply_out_remark='"
						+ remark
						+ "' where id=" + id;
				stock_db.executeUpdate(sql);

				sql = "select package_pallet from stock_out_apply_detail inner join package_info on package_info.id = stock_out_apply_detail.Out_Detail_product_id  where apply_out_id='"
						+ id + "'";
				// 修改以前的数据，更改为未预入库
				ResultSet rs1 = stock_d.executeQuery(sql);
				while (rs1.next()) {
					sql = "update package_info set package_out_apply_status=0 where package_pallet='"
							+ rs1.getString("package_pallet") + "'";
					stock_db.executeUpdate(sql);
				}

				sql = "delete from stock_out_apply_detail where apply_out_id='"
						+ id + "'";
				stock_db.executeUpdate(sql);

				String oweRemark = "";
				String proId = "";
				for (int i = 0; i < paperSpec.length - 1; i++) {

					// 通过客户名查找客户ID
					sql = "select id from crm_file where CUSTOMER_NAME='"
							+ custerPerson[i + 1] + "'";
					ResultSet rs = stock_db.executeQuery(sql);
					if (rs.next()) {
						oweRemark = rs.getString(1);
					}
					sql = "select id from package_info where package_pallet='"
							+ InvoiceNo[i + 1] + "'";
					rs = stock_db.executeQuery(sql);
					if (rs.next()) {
						proId = rs.getString(1);
					}

					sql = "update package_info set package_out_apply_status=1 where id="
							+ proId;
					stock_db.executeUpdate(sql);
					// 插入出库详情表
					sql = "insert into stock_out_apply_detail(apply_out_id,Out_Detail_product_id,Out_Detail_invoice_no,Out_Detail_pal,Out_Detail_pallect,Out_Detail_pallect_count,Out_Detail_weight,Out_Detail_custom_id)"
							+ " values('"
							+ id
							+ "','"
							+ proId
							+ "','"
							+ lotNo[i + 1]
							+ "','"
							+ InvoiceNo[i + 1]
							+ "','"
							+ width[i + 1]
							+ "','"
							+ length[i + 1]
							+ "','"
							+ weigth[i + 1] + "'," + oweRemark + ")";
					stock_db.executeUpdate(sql);
				}
				stock_db.commit();
				stock_d.close();

				stock_db.close();
			}
			response.sendRedirect("stock/apply_pay/change_search.jsp");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public void delNum(HttpServletRequest request, HttpServletResponse response) {

		HttpSession dbSession = request.getSession();// 获取会话session
		ServletContext dbApplication = dbSession.getServletContext();// 获取全局变量application

		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		nseer_db_backup1 stock_d = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法

		try {
			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))&&stock_d.conn((String) dbSession.getAttribute("unit_db_name"))) {
				
				String id = request.getParameter("id");
				String proId = request.getParameter("proId");
							
				String sql = "select Out_Detail_product_id from stock_out_apply_detail where apply_out_id='"+id+"'";
				ResultSet rs = stock_d.executeQuery(sql);
				while(rs.next()){
					if(proId.equals("3")){
						sql = "update product_info set product_out_apply_status=0 where id="+rs.getString(1);
					}else if(proId.equals("5")){
						sql = "update package_info set package_out_apply_status=0 where id="+rs.getString(1);
					}
					stock_db.executeUpdate(sql);
				}
			    sql = "delete from stock_out_apply where id="+id;
				stock_db.executeUpdate(sql);
				sql = "delete from stock_out_apply_detail where apply_out_id='"+id+"'";
				stock_db.executeUpdate(sql);
				
				stock_db.commit();
				stock_db.close();stock_d.close();
				
				response.sendRedirect("stock/apply_pay/change_del.jsp");
			}
		}catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}