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

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;

import magic.action.Action;

/**
 * 
 * @author 高丰仪 功能：原材料料 入库申请单提交
 * 
 */
public class registerAction extends Action {

	ServletContext application;

	HttpSession session;

	/**
	 * 入库申请 原材料入库
	 * 
	 * @param request
	 * @param response
	 */
	public void addYuan(HttpServletRequest request, HttpServletResponse response) {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();

		ServletContext dbApplication = dbSession.getServletContext();
		ServletContext application;
		HttpSession session = request.getSession();

		// HttpSession dbSession = request.getSession();// 获取会话session
		// ServletContext dbApplication = dbSession.getServletContext();//
		// 获取全局变量application

		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法

		try {

			// 入库申请的产品数据（原纸规格）
			String[] paper = request.getParameterValues("product_name");
			// 首先判断是否有产品，如果没有，则返回界面
			if (paper.length == 1) {
				response
						.getWriter()
						.print(
								"<script>window.location.href='/erpv7/stock/apply_gather/register.jsp';alert('没有产品数据，请添加后再提交!');</script>");
			} else {

		

				// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
				if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))) {

					// 经办人
					String stock_room_person = request
							.getParameter("gatherer_name");
					// 入库理由
					String stock_sake = request.getParameter("reason");
					// 登记人
					String stock_enter_person = request
							.getParameter("register");
					// 登记时间
					String stock_time = request.getParameter("register");
					// 备注
					String stock_remark = request.getParameter("remark");

					// 获取当前时间
					java.sql.Date d = new java.sql.Date(System
							.currentTimeMillis());

			
					
//					 入库申请的产品数据
					String[] LotNo = request.getParameterValues("product_ID");// LOT
					 //数据在2条以上时进行比较LOT NO是否相同
					 if(LotNo.length>2){
					 // 在此判断paper中数据中是否有重复数据
					 Map<String, Integer> map = new HashMap<String, Integer>();
					 //在此声明一个HashMap集合
								        
					 //迭代数组
					 for (String str : LotNo){
					 Integer num = map.get(str);
					 num = null == num ? 1 : num + 1;
					 map.put(str, num);
					 }		           
					 if (paper.length != map.size())
					 {
					// response.getWriter().print("<script>window.location.href='/erpv7/stock/apply_gather/register.jsp';alert('LOT NO.重复，请重新输入！');</script>");
					 response.sendRedirect("stock/apply_gather/register_lotNo_error.jsp");
						 return;
					 }
					 }		
					 
					 java.util.Date now = new java.util.Date();
					 SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					 String time=formatter.format(now);
					 SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd");
					 String time1=formatter1.format(now);
					 
					 String NO="";//帐单号
					 
					 String sql1 = "select apply_in_apply_code from stock_in_apply where apply_in_apply_register_time like '%"+time1+"%' order by id desc limit 1";
					 ResultSet rs = stock_db.executeQuery(sql1);
					 int timeCount = 0;
					 String orderNumber = "";
					 if(rs.next()){
						 timeCount=1;
						 orderNumber= rs.getString("apply_in_apply_code");
					 }
					 //在此判断数据库是否有数据
					 if(timeCount==0){
						 NO = "RS"+time1.replace("-", "").substring(2,time1.replace("-", "").length())+"01";
					 }else{
						 NO = "RS"+(Integer.parseInt(("RS"+orderNumber.replace("-", "").substring(2,orderNumber.replace("-", "").length())).substring(2,("RS"+orderNumber.replace("-", "").substring(2,orderNumber.replace("-", "").length())).length()))+1);
					 }
					
					// 插入入库申请表
					String sql = "insert into stock_in_apply(apply_in_apply_code,apply_in_apply_reason_id,apply_in_apply_register,apply_in_apply_register_time,apply_in_apply_operator,apply_in_apply_check_status,apply_stock_status,apply_in_apply_count,apply_in_apply_remark) values('"
							+ NO
							+ "','"
							+ stock_sake
							+ "','"
							+ stock_enter_person
							+ "','"
							+ time.toString()
							+ "','"
							+ stock_room_person
							+ "',"
							+ 0
							+ ","
							+ 0
							+ ",'"
							+ (paper.length - 1) + "','" + stock_remark + "')";
					// 执行插入语句（入库申请表）
					stock_db.executeUpdate(sql);
					// 提交事务
					stock_db.commit();

					sql = "select id from stock_in_apply order by id desc limit 1";

					ResultSet rsApply = stock_db.executeQuery(sql);// 获取stock_in_apply表的最大ID
					int applyId = 0;
					while (rsApply.next()) {
						applyId = rsApply.getInt(1);
					}

					// 产品
					
					// No.
					String[] Invoice = request
							.getParameterValues("product_describe_ok");// Invoice
					// No.
					String[] weight = request.getParameterValues("cost_price");// 重量
					String[] length = request.getParameterValues("amount_unit");// 长度
					String[] width = request.getParameterValues("amount");// 宽度
					String[] oweRemark = request
							.getParameterValues("product_describe");// 欠点内容

					String[] yuanPaper = request
							.getParameterValues("product_name");// 原纸规格
					String [] fault_number=request.getParameterValues("fault_number");

					for (int i = 0; i < paper.length - 1; i++) {
						if(Invoice[i+1].equals("")){
							Invoice[i+1]="";
						}
						// 如果宽度、厚度、长度为""时，增入默认值
						if (weight[i + 1].equals("")) {
							weight[i + 1] = "0";
						}
						if (length[i + 1].equals("")) {
							length[i + 1] = "0";
						}
						if (width[i + 1].equals("")) {
							width[i + 1] = "0";
						}

						// 通过纸规格名称去查找纸规格ID
						sql = "SELECT id FROM design_file WHERE product_name='"
								+ paper[i + 1] + "'";
						ResultSet rs1 = stock_db.executeQuery(sql);

						int id = 0;// 获得纸规格数据

						if (rs1.next()) {
							id = rs1.getInt(1);
						}
						// 插入产品表
						sql = "insert into product_info(product_lot_no,product_spec_id,product_spec,product_type,product_status) values('"
								+ LotNo[i + 1]
								+ "',"
								+ id
								+ ",'"
								+ paper[i + 1] + "'," + 0 + "," + 0 + ")";
						stock_db.executeUpdate(sql);

						sql = "select * from product_info order by id desc limit 1";

						ResultSet rsMax = stock_db.executeQuery(sql);// 获取product_info表的最大ID
						int maxId = 0;
						while (rsMax.next()) {
							maxId = rsMax.getInt(1);
						}

						// 插入入库详情表
						sql = "insert into stock_in_apply_detail(apply_in_id,In_Detail_product_id,In_Detail_invoice_no,In_Detail_spec,In_Detail_weight,In_Detail_width,In_Detail_length,In_Detail_fault,In_Detail_fault_number)"
								+ " values('"
								+ applyId
								+ "','"
								+ maxId
								+ "','"
								+ Invoice[i + 1]
								+ "','"
								+ yuanPaper[i + 1]
								+ "','"
								+ weight[i + 1]
								+ "','"
								+ length[i + 1]
								+ "','"
								+ width[i + 1]
								+ "','"
								+ oweRemark[i + 1] + "','"+fault_number[i+1]+"')";
						stock_db.executeUpdate(sql);
					}
					// 提交事务
					stock_db.commit();
					// 跳转页面
					response
							.sendRedirect("stock/apply_gather/register_search.jsp");
				}
				
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally{
			// 关闭资源
			try {
				stock_db.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/**
	 * 入库申请 成品入库
	 * 
	 * @param request
	 * @param response
	 */
	public void addSuccess(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		ServletContext dbApplication = dbSession.getServletContext();
		ServletContext application;
		HttpSession session = request.getSession();
		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		try {

			// 入库申请的产品数据（原纸规格）
			String[] paper = request.getParameterValues("product_name1");

			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))) {

				// 入库人
				String stock_room_person = request
						.getParameter("gatherer_name");
				// 入库理由
				String stock_sake = request.getParameter("reason");
				// 登记人
				String stock_enter_person = request.getParameter("register");
				// 登记时间
				String stock_time = request.getParameter("register");
				// 备注
				String stock_remark = request.getParameter("remark");

				// 获取当前时间
				java.sql.Date d = new java.sql.Date(System.currentTimeMillis());

				// 获得一个随机数
				Date t = new Date();
				String a = (t + "").substring(17, 19);
				
				 java.util.Date now = new java.util.Date();
				 SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				 String time=formatter.format(now);
				 SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd");
				 String time1=formatter1.format(now);
				
				 String NO="";//帐单号
				 
				 String sql1 = "select apply_in_apply_code from stock_in_apply where apply_in_apply_register_time like '%"+time1+"%' order by id desc limit 1";
				 ResultSet rs = stock_db.executeQuery(sql1);
				 int timeCount = 0;
				 String orderNumber = "";
				 if(rs.next()){
					 timeCount=1;
					 orderNumber= rs.getString("apply_in_apply_code");
				 }
				 //在此判断数据库是否有数据
				 if(timeCount==0){
					 NO = "RS"+time1.replace("-", "").substring(2,time1.replace("-", "").length())+"01";
				 }else{
					 NO = "RS"+(Integer.parseInt(("RS"+orderNumber.replace("-", "").substring(2,orderNumber.replace("-", "").length())).substring(2,("RS"+orderNumber.replace("-", "").substring(2,orderNumber.replace("-", "").length())).length()))+1);
				 }
				 
				
				// 插入入库申请表
				String sql = "insert into stock_in_apply(apply_in_apply_code,apply_in_apply_reason_id,apply_in_apply_register,apply_in_apply_register_time,apply_in_apply_operator,apply_in_apply_check_status,apply_stock_status,apply_in_apply_count,apply_in_apply_remark) values('"
						+ NO
						+ "','"
						+ stock_sake
						+ "','"
						+ stock_enter_person
						+ "','"
						+ time.toString()
						+ "','"
						+ stock_room_person
						+ "',"
						+ 0
						+ ","
						+ 0
						+ ",'"
						+ (paper.length - 1) + "','" + stock_remark + "')";
				// 执行插入语句（入库申请表）
				stock_db.executeUpdate(sql);
				stock_db.commit();

				sql = "select * from stock_in_apply order by id desc limit 1";

				ResultSet rsMax = stock_db.executeQuery(sql);// 获取product_info表的最大ID
				int maxId = 0;
				while (rsMax.next()) {
					maxId = rsMax.getInt(1);
				}

				// 产品
				// 入库申请的产品数据
				String[] LotNo = request.getParameterValues("product_ID1");// 规格
				String[] Invoice = request
						.getParameterValues("product_describe_ok");// 栈板号
			
				String[] weight = request.getParameterValues("tuoPan1");// 托盘
				String[] length = request.getParameterValues("count1");// 数量
				String[] width = request.getParameterValues("weight1");// 净重
				String[] oweRemark = request.getParameterValues("admin1");// 客户名称
				String[] proId = request.getParameterValues("proId");// 产品ID

				for (int i = 0; i < paper.length - 1; i++) {
					// 如果不输入默认为0
					if(length[i+1].equals("")){
						length[i+1]="0";
					}
					if(width[i+1].equals("")){
						width[i+1]="0";
					}
					sql = "select id from crm_file where CUSTOMER_NAME='"+oweRemark[i+1]+"'";
					rs = stock_db.executeQuery(sql);
					String personId = "";
					if(rs.next()){
						personId = rs.getString(1);
					}
					// 插入入库详情表In_Detail_custom_id
					sql = "insert into stock_in_apply_detail(apply_in_id,In_Detail_product_id,In_Detail_spec,In_Detail_weight,In_Detail_pal,In_Detail_pallect,In_Detail_pallect_count,In_Detail_custom_id)"
							+ " values('"
							+ maxId
							+ "','"
							+ proId[i + 1]
							+ "','"
							+ LotNo[i + 1]
							+ "','"
							+ width[i + 1]
							+ "','"
							+ Invoice[i + 2]
							+ "','"
							+ weight[i + 1]
							+ "','"
							+ length[i + 1]
							+ "','"
							+ personId
							+ "')";
					stock_db.executeUpdate(sql);
					sql = "update package_info set package_in_apply_status=1,package_count='"+length[i+1]+"' where id="+proId[i+1];
					stock_db.executeUpdate(sql);
				}
				// 提交事务
				stock_db.commit();
				// 跳转页面
				response.sendRedirect("stock/apply_gather/register_search.jsp");

			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally{
			try {
				stock_db.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/**
	 * 入库申请审核
	 * 
	 * @param request
	 * @param response
	 */
	public void audting(HttpServletRequest request, HttpServletResponse response) {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		ServletContext dbApplication = dbSession.getServletContext();
		ServletContext application;
		HttpSession session = request.getSession();
		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		nseer_db_backup1 stock_db1 = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		try {
			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))&&stock_db1.conn((String) dbSession.getAttribute("unit_db_name"))) {
				int id = Integer.parseInt(request.getParameter("id"));
				int departId = Integer.parseInt(request.getParameter("pId"));// 入库理由ID
				String audtiong = request.getParameter("registerPerson");// 审核人
				String audtiongTime = request.getParameter("registerTime");// 审核时间
				
				if(audtiong==null||audtiongTime==null){
					audtiong="";
					audtiongTime="";
				}
				String sql = "update stock_in_apply set apply_in_apply_check_status=1,apply_in_apply_checker='"+audtiong+"',apply_in_apply_check_time='"+audtiongTime+"'  where id="
						+ id;
				stock_db.executeUpdate(sql);
				// 当为原材料入库时
				if(departId==2){
					// 插入原纸信息表
					sql = "select * from stock_in_apply inner join stock_in_apply_detail on stock_in_apply_detail.apply_in_id=stock_in_apply.id inner join product_info on product_info.id = stock_in_apply_detail.In_Detail_product_id where stock_in_apply_detail.apply_in_id="+id;
					ResultSet rs = stock_db1.executeQuery(sql);
					while(rs.next()){
						sql = "insert into product_base_info(product_id,product_base_invoice_no,product_base_width,product_base_weight,product_base_length,product_base_fault) values('"
							+rs.getString("product_info.id")+"','"+rs.getString("stock_in_apply_detail.In_Detail_invoice_no")+"','"+rs.getString("stock_in_apply_detail.In_Detail_length")+"','"+rs.getString("stock_in_apply_detail.In_Detail_weight")+"','"+rs.getString("stock_in_apply_detail.In_Detail_width")+"','"+rs.getString("stock_in_apply_detail.In_Detail_fault")+"')";
						stock_db.executeUpdate(sql);
					}
				}
				stock_db.commit();
			}
				response
						.sendRedirect("stock/apply_gather/check_list_auditing_radio.jsp");
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally{
			try {
				stock_db1.close();stock_db.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/**
	 * 入库申请未通过
	 * 
	 * @param request
	 * @param response
	 */
	public void waiver(HttpServletRequest request, HttpServletResponse response) {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		ServletContext dbApplication = dbSession.getServletContext();
		ServletContext application;
		HttpSession session = request.getSession();
		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法

		try {
			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				int numberId = Integer.parseInt(request
						.getParameter("numberId"));// 传入库单号id
				String remark = request.getParameter("remark2");//未通过理由
				
				String sql = "update stock_in_apply set apply_in_apply_check_status=2,autding_remark='"+remark+"' where id="+numberId;
//				
				//int audId = Integer.parseInt(request.getParameter("audId"));// 传入入库理由ID
				stock_db.executeUpdate(sql);
				stock_db.commit();
			}		
			response.sendRedirect("stock/apply_gather/check_list_auditing_radio1.jsp");
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally{
			try {
				stock_db.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	/**
	 * 变更
	 * 
	 * @param request
	 * @param response
	 */
	public void changeDetail(HttpServletRequest request, HttpServletResponse response) {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		ServletContext dbApplication = dbSession.getServletContext();
		ServletContext application;
		HttpSession session = request.getSession();
		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		nseer_db_backup1 stock_db1 = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		
		try {
//			 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))&&stock_db1.conn((String) dbSession.getAttribute("unit_db_name"))) {
				int numberId = Integer.parseInt(request
						.getParameter("id"));// 传入库单号id
				
//				 入库申请的产品数据（原纸规格）
				String[] paper = request.getParameterValues("product_name");
				
				String[] LotNo = request.getParameterValues("product_ID");// LOT
				// No.
				String[] Invoice = request
						.getParameterValues("product_describe_ok");// Invoice
				// No.
				String[] weight = request.getParameterValues("cost_Weight");// 重量
				String[] length = request.getParameterValues("amount_unit");// 长度
				String[] width = request.getParameterValues("amount");// 宽度
				String[] oweRemark = request
						.getParameterValues("product_describeN");// 欠点内容
				String [] fault_number=request.getParameterValues("fault_number");
				
				Map<String, Integer> map = new HashMap<String, Integer>();
				 //在此声明一个HashMap集合
							        
				 //迭代数组
				 for (String str : LotNo){
				 Integer num = map.get(str);
				 num = null == num ? 1 : num + 1;
				 map.put(str, num);
				 }		           
				 if (paper.length != map.size()){
					 response.sendRedirect("stock/apply_gather/change_error.jsp?number="+numberId);
					 return;
				 }
				 String remark = request.getParameter("remark");
				
				String sql = "update stock_in_apply set apply_in_apply_check_status=0,apply_in_apply_count='"+(width.length-1)+"',apply_in_apply_remark='"+remark+"' where id="+numberId;
				
				stock_db.executeUpdate(sql);
				
				sql="select In_Detail_product_id from stock_in_apply_detail where apply_in_id='"+numberId+"'";
				ResultSet rs = stock_db.executeQuery(sql);
				while(rs.next()){
					sql = "delete from product_info where id="+rs.getString("In_Detail_product_id");
					stock_db1.executeUpdate(sql);
				}
				sql = "delete from stock_in_apply_detail where apply_in_id='"+numberId+"'";
				stock_db.executeUpdate(sql);
				
				for (int i = 0; i < paper.length - 1; i++) {
					
					if(Invoice[i+1].equals("")){
						Invoice[i+1]="";
					}
					// 如果宽度、厚度、长度为""时，增入默认值
					if (weight[i + 1].equals("")) {
						weight[i + 1] = "0";
					}
					if (length[i + 1].equals("")) {
						length[i + 1] = "0";
					}
					if (width[i + 1].equals("")) {
						width[i + 1] = "0";
					}
					
					// 通过纸规格名称去查找纸规格ID
					sql = "SELECT id FROM design_file WHERE product_name='"
							+ paper[i+1] + "'";
					 rs = stock_db.executeQuery(sql);

					int id = 0;// 获得纸规格数据

					if (rs.next()) {
						id = rs.getInt("id");
					}
					// 插入产品表
					sql = "insert into product_info(product_lot_no,product_spec_id,product_spec,product_type,product_status) values('"
							+ LotNo[i+1]
							+ "',"
							+ id
							+ ",'"
							+ paper[i+1] + "'," + 0 + "," + 0 + ")";
					stock_db.executeUpdate(sql);

					sql = "select id from product_info order by id desc limit 1";

					ResultSet rsMax = stock_db.executeQuery(sql);// 获取product_info表的最大ID
					int maxId = 0;
					while (rsMax.next()) {
						maxId = rsMax.getInt(1);
					}

					// 插入入库详情表
					sql = "insert into stock_in_apply_detail(apply_in_id,In_Detail_product_id,In_Detail_invoice_no,In_Detail_spec,In_Detail_weight,In_Detail_width,In_Detail_length,In_Detail_fault,In_Detail_fault_number)"
							+ " values('"
							+ numberId
							+ "','"
							+ maxId
							+ "','"
							+ Invoice[i+1]
							+ "','"
							+ paper[i+1]
							+ "','"
							+ weight[i+1]
							+ "','"
							+ length[i+1]
							+ "','"
							+ width[i+1]
							+ "','"
							+ oweRemark[i+1] + "','"+fault_number[i+1]+"')";
					stock_db.executeUpdate(sql);
				}
				
				stock_db.commit();	
				response.sendRedirect("stock/apply_gather/change_search.jsp");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally{
			try {
				stock_db.close();			stock_db1.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	/**
	 * 变更
	 * 
	 * @param request
	 * @param response
	 */
	public void change(HttpServletRequest request, HttpServletResponse response) {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		ServletContext dbApplication = dbSession.getServletContext();
		ServletContext application;
		HttpSession session = request.getSession();
		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		nseer_db_backup1 stock_d = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		try {
			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))&&stock_d.conn((String) dbSession.getAttribute("unit_db_name"))) {
				int numberId = Integer.parseInt(request.getParameter("id"));// 传入库单号id
				
				 //入库申请的产品数据（原纸规格）
				String[] paper = request.getParameterValues("product_nameN");
//				 入库申请的产品数据
				String[] LotNo = request.getParameterValues("product_IDN");// 规格
				String[] Invoice = request.getParameterValues("b_prodcu_name");// 栈板号
				String[] weight = request.getParameterValues("product_count");// 托盘
				String[] length = request.getParameterValues("amount_unitN");// 数量
				String[] width = request.getParameterValues("cost_cost");// 净重
				
				 String remark = request.getParameter("remark");
				
				String sql = "update stock_in_apply set apply_in_apply_check_status=0,apply_in_apply_count='"+(Invoice.length-1)+"',apply_in_apply_remark='"+remark+"' where id="+numberId;
				
				stock_db.executeUpdate(sql);
				
				sql = "select In_Detail_product_id from stock_in_apply_detail where apply_in_id='"+numberId+"'";
				ResultSet rs1 = stock_d.executeQuery(sql);
				while(rs1.next()){
					sql = "update package_info set package_in_apply_status=0 where id="+rs1.getString(1);
					stock_db.executeUpdate(sql);
				}
				
				sql = "delete from stock_in_apply_detail where apply_in_id='"+numberId+"'";
				stock_db.executeUpdate(sql);
				
				String[] personName = request.getParameterValues("cost_priceN");//客户名称
				
				String oweRemark ="";
				String proId= "";
				
				for (int i = 0; i < paper.length - 1; i++) {
					
					//通过客户名查找客户ID
					sql = "select id from crm_file where CUSTOMER_NAME='"+personName[i+1]+"'";
					ResultSet rs= stock_db.executeQuery(sql);
					if(rs.next()){
						oweRemark=rs.getString(1);
					}
					sql = "select id from package_info where package_pallet='"+paper[i+1]+"'";
					rs = stock_db.executeQuery(sql);
					if(rs.next()){
						proId = rs.getString(1);
					}
					//通过栈板号查找产品ID
//					 如果不输入默认为0
					if(length[i+1].equals("")){
						length[i+1]="0";
					}
					if(width[i+1].equals("")){
						width[i+1]="0";
					}
					// 插入入库详情表In_Detail_custom_id
					 sql = "insert into stock_in_apply_detail(apply_in_id,In_Detail_product_id,In_Detail_spec,In_Detail_weight,In_Detail_pal,In_Detail_pallect,In_Detail_pallect_count,In_Detail_custom_id)"
							+ " values('"
							+ numberId
							+ "','"
							+ proId
							+ "','"
							+ LotNo[i+1]
							+ "','"
							+ width[i+1]
							+ "','"
							+ paper[i+1]
							+ "',"
							+ weight[i+1]
							+ ",'"
							+ length[i+1]
							+ "','"
							+ oweRemark
							+ "')";
					stock_db.executeUpdate(sql);
					sql = "update package_info set package_in_apply_status=1 where id="+proId;
					stock_db.executeUpdate(sql);
				}
				stock_db.commit();
			}
		response.sendRedirect("stock/apply_gather/change_search.jsp");

		} catch (Exception ex) {
			ex.printStackTrace();
		
		}finally{
			try {
				stock_d.close();stock_db.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	public void delNum(HttpServletRequest request, HttpServletResponse response) {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		ServletContext dbApplication = dbSession.getServletContext();
		ServletContext application;
		HttpSession session = request.getSession();
		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		nseer_db_backup1 stock_d = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		try {
			// 判断是否能打开数据库连接，如果能打开，则进行下面的操作
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))&&stock_d.conn((String) dbSession.getAttribute("unit_db_name"))) {
				int numberId = Integer.parseInt(request.getParameter("id"));// 传入库单号id
				String sql = "";
				String nId = request.getParameter("numberId");
				if(nId.equals("4")){
					sql = "select In_Detail_product_id from stock_in_apply_detail where apply_in_id='"+numberId+"'";
					ResultSet rs = stock_d.executeQuery(sql);
					while(rs.next()){
						sql = "update package_info set package_in_apply_status=0 where id="+rs.getString(1);
						stock_db.executeUpdate(sql);
					}
				}
				 sql = "delete from stock_in_apply where id="+numberId;
				stock_db.executeUpdate(sql);
				sql = "delete from stock_in_apply_detail where apply_in_id='"+numberId+"'";
				stock_db.executeUpdate(sql);
				stock_db.commit();
				response.sendRedirect("stock/apply_gather/change_del.jsp");
			}
		}catch (Exception ex) {
			ex.printStackTrace();
		}finally{
			try {
				stock_db.close();stock_d.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}