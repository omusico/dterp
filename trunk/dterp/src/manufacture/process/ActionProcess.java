package manufacture.process;

import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.Array;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import magic.action.Action;

/**
 * lixiaodong
 * 
 * @author Administrator 生产过程管理
 */
public class ActionProcess extends Action {
	/**
	 * 添加生产计划执行
	 * 
	 * @param request
	 * @param response
	 */
	public void add(HttpServletRequest request, HttpServletResponse response) {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();

		ServletContext dbApplication = dbSession.getServletContext();
		ServletContext application;
		HttpSession session = request.getSession();

		nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
		nseer_db_backup1 manufacture_db1 = new nseer_db_backup1(dbApplication);
		nseer_db_backup1 manufacture_db2 = new nseer_db_backup1(dbApplication);

		if (manufacture_db
				.conn((String) dbSession.getAttribute("unit_db_name"))
				&& manufacture_db1.conn((String) dbSession
						.getAttribute("unit_db_name"))
				&& manufacture_db2.conn((String) dbSession
						.getAttribute("unit_db_name"))) {

			try {

				String filePath = request.getParameter("filePath");// 上传文件路径
				FileRead fileread = new FileRead();// 文件读写类
				Map<Integer, String> filerows = new HashMap<Integer, String>();
				filerows = fileread.readF2(filePath);// 获得有效地每一行内容
				int row_m = Integer.parseInt(filerows.get(0));
				String x_date = filerows.get(1);// 时间
				String x_worker = filerows.get(2);// 员工id
				String x_type = filerows.get(3);// stat1——4分切,stat2——8mm切,stat3——打孔
				String product_info_id = request
						.getParameter("product_info_id");// 原料信息id

				// 原料信息
				String sql_details = "select stock_in_time,product_material_plan_id,product_lot_no,product_spec_id,product_spec,product_4_excep,product_8_excep,product_hole_excep,change_product_id from product_info where id="
						+ product_info_id;
				ResultSet rs_details = manufacture_db1
						.executeQuery(sql_details);
				String product_material_plan_id = "";
				String product_lot_no = "";
				String product_spec_id = "";
				String product_spec = "";
				String product_4_excep = "";
				String product_8_excep = "";
				String product_hole_excep = "";
				String change_product_id = "";
				String stock_in_time = "";
				if (rs_details.next()) {
					product_material_plan_id = rs_details
							.getString("product_material_plan_id");
					product_lot_no = rs_details.getString("product_lot_no");
					product_spec_id = rs_details.getString("product_spec_id");
					product_spec = rs_details.getString("product_spec");
					product_4_excep = rs_details.getString("product_4_excep");
					product_8_excep = rs_details.getString("product_8_excep");
					product_hole_excep = rs_details
							.getString("product_hole_excep");
					change_product_id = rs_details
							.getString("change_product_id");
					stock_in_time = rs_details.getString("stock_in_time");
				}
				if (!stock_in_time.equals("")) {// 已进行过临时入库操作
					String plan_id = request.getParameter("id");// 计划信息id
					String sql_q = "";
					if (x_type.toLowerCase().equals("stat1")) {

						// 判断是否是计划内原料
						String sql_pro_plan = "select id from plan_4_detail where plan_id="
								+ plan_id
								+ " and product_spec_id="
								+ product_spec_id;
						ResultSet rs_pro_plan = manufacture_db1
								.executeQuery(sql_pro_plan);
						if (rs_pro_plan.next()) {
							// 判断是否超出计划数量
							String sql_num = "select id,plan_id,product_spec,plan_count from plan_4_detail where plan_id="
									+ plan_id + "";
							ResultSet rs_num = manufacture_db
									.executeQuery(sql_num);

							String display_2 = "";// 计划数量
							String display_3 = "";// 调度数量
							String num_beyond="";
							while (rs_num.next()) {

								display_2 = rs_num.getString("plan_count");

								// 得到调度数量
								String sql_3 = "select count(id) as tdnum from product_info where product_material_plan_id='"
										+ plan_id
										+ "' and product_spec='"
										+ product_spec + "'";
								ResultSet rs_3 = manufacture_db2
										.executeQuery(sql_3);
								if (rs_3.next()) {
									display_3 = rs_3.getString("tdnum");
									if (Integer.parseInt(display_3) > Integer
											.parseInt(display_2)) {
										num_beyond="true";
										
									}
								}

							}
							if(num_beyond.equals("")){
							// 4分切
							// 验证是否添加过+是否在相应仓库中
							sql_q = "select id,product_is_production,stock_id from product_info where id="
									+ product_info_id;
							ResultSet rs_vali = manufacture_db
									.executeQuery(sql_q);
							String product_is_production = "";
							String stock_id = "0";
							if (rs_vali.next()) {
								product_is_production = rs_vali
										.getString("product_is_production");
								stock_id = rs_vali.getString("stock_id");
							}
//							 添加判断是否已存在生成品
							if (!product_is_production.equals("0")) {
								if (stock_id.equals("102")) {
									//计划执行状态变更
									String sql_pct = "update product_plan set plan_check_tag='3' " +
										" where id="+plan_id;
									manufacture_db.executeUpdate(sql_pct);	
									// 更新原料商品出库时间,清空仓库信息
									
									sql_q = "update product_info set stock_out_time='"
											+ x_date
											+ "',product_is_production='0',stock_id='0',stock_name='',product_temp_pallet='',product_status=2,product_produce_location=0,product_material_plan_id='"
											+ plan_id
											+ "' where id="
											+ product_info_id;
									manufacture_db.executeUpdate(sql_q);

									
									// 产生4个8mm切新产品
									sql_q = "insert product_info (product_lot_no,product_spec_id,product_spec,product_type,product_status,product_produce_location,product_4_excep,product_8_excep,product_hole_excep,product_product_plan_id,father_product_id,change_product_id) values ";
									for (int i = 1; i < 5; i++) {
										if (i == 4) {
											sql_q += "('" + product_lot_no
													+ "-" + i + "',"
													+ product_spec_id + ",'"
													+ product_spec
													+ "',1,2,0,'"
													+ product_4_excep + "','"
													+ product_8_excep + "','"
													+ product_hole_excep + "',"
													+ plan_id + ","
													+ product_info_id + ","
													+ change_product_id + ");";
										} else {
											sql_q += "('" + product_lot_no
													+ "-" + i + "',"
													+ product_spec_id + ",'"
													+ product_spec
													+ "',1,2,0,'"
													+ product_4_excep + "','"
													+ product_8_excep + "','"
													+ product_hole_excep + "',"
													+ plan_id + ","
													+ product_info_id + ","
													+ change_product_id + "),";
										}
									}
									manufacture_db.executeUpdate(sql_q);
									response
											.sendRedirect("manufacture/process/register_ok_a.jsp");
								} else {
									response
											.sendRedirect("manufacture/process/register_ok_e.jsp?id="
													+ product_lot_no);
								}

							} else {
								response
										.sendRedirect("manufacture/process/register_ok_f.jsp");
							}
							}else{
//								 已超出计划数量
								response
										.sendRedirect("manufacture/process/register_b_ok.jsp");
							}
						} else {
							response
									.sendRedirect("manufacture/process/register_ok_d.jsp");

						}
						
					} else if (x_type.toLowerCase().equals("stat2")) {
//						验证产品信息是否登记
						String sql_produre_in="select * from product_4_info where product_id='"+product_info_id+"'";
						ResultSet rs_produre_in = manufacture_db1.executeQuery(sql_produre_in);
						String product_flag="";//产品信息登记标志  “”——没登记，！“”——登记
						if(rs_produre_in.next()){
							product_flag=rs_produre_in.getString("id");
						}
						if(!product_flag.equals("")){
						// 判断是否是计划内原料
						String sql_pro_plan = "select id from plan_8mm_detail where plan_id="
								+ plan_id
								+ " and product_spec_id="
								+ product_spec_id;
						ResultSet rs_pro_plan = manufacture_db1
								.executeQuery(sql_pro_plan);
						
						
						if (rs_pro_plan.next()) {
//							 判断是否超出计划数量
							String sql_num = "select id,plan_id,product_spec,plan_package_count,plan_produce_count from plan_8mm_detail where plan_id="
									+ plan_id + "";
							ResultSet rs_num = manufacture_db.executeQuery(sql_num);

							String display_2 = "";// 计划数量
							String display_3 = "";// 调度数量
							String num_beyond="";
							while (rs_num.next()) {

								display_2=rs_num.getString("plan_produce_count");
								
								String display_2_1=rs_num.getString("plan_package_count");
								int num2_1=Integer.parseInt(display_2)+Integer.parseInt(display_2_1);
								
								
								int num2=(int)Math.ceil(num2_1/20.0);

								// 得到调度数量
								String sql_3 = "select count(id) as tdnum from product_info where product_material_plan_id='"
										+ plan_id
										+ "' and product_spec='"
										+ product_spec + "'";
								ResultSet rs_3 = manufacture_db2
										.executeQuery(sql_3);
								if (rs_3.next()) {
									display_3 = rs_3.getString("tdnum");
									if (Integer.parseInt(display_3) > num2) {
										num_beyond="true";
										
									}
								}

							}
							
							if(num_beyond.equals("")){
							
							// 8mm
							// 验证是否添加过+是否在相应仓库中
							sql_q = "select id,product_is_production,stock_id from product_info where id="
									+ product_info_id;
							ResultSet rs_vali = manufacture_db
									.executeQuery(sql_q);
							String product_is_production = "";
							String stock_id = "0";
							if (rs_vali.next()) {
								product_is_production = rs_vali
										.getString("product_is_production");
								stock_id = rs_vali.getString("stock_id");
							}

							if (!product_is_production.equals("0")) {
								if (stock_id.equals("103")) {
//									计划执行状态变更
									String sql_pct = "update product_plan set plan_check_tag='3' " +
											
										" where id="+plan_id;
									manufacture_db.executeUpdate(sql_pct);	
									// 更新原料商品出库时间
									String sql_out_time = "update product_info set stock_out_time='"
											+ x_date
											+ "' where id="
											+ product_info_id;
									manufacture_db.executeUpdate(sql_out_time);
									sql_q = "update product_info set product_is_production='0',stock_id='0',stock_name='',product_temp_pallet='',product_status=2,product_produce_location=1,product_material_plan_id='"
											+ plan_id
											+ "' where id="
											+ product_info_id;
									manufacture_db.executeUpdate(sql_q);
									// 产生20个打孔新产品
									sql_q = "insert product_info (product_lot_no,product_spec_id,product_spec,product_type,product_status,product_produce_location,product_4_excep,product_8_excep,product_hole_excep,product_product_plan_id,father_product_id,change_product_id) values ";
									for (int i = 1; i < 21; i++) {
										if (i == 20) {
											sql_q += "('" + product_lot_no
													+ "-" + i + "',"
													+ product_spec_id + ",'"
													+ product_spec
													+ "',2,2,1,'"
													+ product_4_excep + "','"
													+ product_8_excep + "','"
													+ product_hole_excep + "',"
													+ plan_id + ","
													+ product_info_id + ","
													+ change_product_id + ");";
										} else {
											sql_q += "('" + product_lot_no
													+ "-" + i + "',"
													+ product_spec_id + ",'"
													+ product_spec
													+ "',2,2,1,'"
													+ product_4_excep + "','"
													+ product_8_excep + "','"
													+ product_hole_excep + "',"
													+ plan_id + ","
													+ product_info_id + ","
													+ change_product_id + "),";
										}
									}
									manufacture_db.executeUpdate(sql_q);
									response
											.sendRedirect("manufacture/process/register_ok_a.jsp");
								} else {
									response
											.sendRedirect("manufacture/process/register_ok_e.jsp?id="
													+ product_lot_no);
								}

							} else {
								response
										.sendRedirect("manufacture/process/register_ok_f.jsp");
							}
							}else{
//								 已超出计划数量
								response
										.sendRedirect("manufacture/process/register_b_ok.jsp");
							}
						} else {
							response
									.sendRedirect("manufacture/process/register_ok_d.jsp");

						}
						}else{
							response
							.sendRedirect("manufacture/process/register_ok_h.jsp");
						}
					} else if (x_type.toLowerCase().equals("stat3")) {
//						 根据机器号查出模具号
						String mold_id = "";
						String mold_spec = "";
						String mold_spec_id="";
						// 机器号和生产状态是3——生产中
						sql_q = "select mold_spec_id,mold_code,mold_spec from mold_info where mold_machine_number="
								+ filerows.get(4)
								+ " and mold_location=3";
						ResultSet rs_mold_id = manufacture_db1
								.executeQuery(sql_q);
						if (rs_mold_id.next()) {
							mold_id = rs_mold_id
									.getString("mold_code");
							mold_spec = rs_mold_id
									.getString("mold_spec");
							mold_spec_id = rs_mold_id
									.getString("mold_spec_id");
						}
//						验证产品信息是否登记
						String sql_produre_in="select * from product_8mm_info where product_id='"+product_info_id+"'";
						ResultSet rs_produre_in = manufacture_db1.executeQuery(sql_produre_in);
						String product_flag="";//产品信息登记标志  “”——没登记，！“”——登记
						if(rs_produre_in.next()){
							product_flag=rs_produre_in.getString("id");
						}
						if(!product_flag.equals("")){
						// 判断是否是计划内原料+需添加机器号判断
						String sql_pro_plan = "select id from plan_hole_detail where plan_id="
								+ plan_id
								+ " and product_spec_id="
								+ product_spec_id +" and mold_id='"+mold_spec_id+"'";
						ResultSet rs_pro_plan = manufacture_db1
								.executeQuery(sql_pro_plan);
						if (rs_pro_plan.next()) {
//							 判断是否超出计划数量
							String sql_num = "select id,plan_id,product_spec,product_count from plan_hole_detail where plan_id="
									+ plan_id + "";
							ResultSet rs_num = manufacture_db.executeQuery(sql_num);

							String display_2 = "";// 计划数量
							String display_3 = "";// 调度数量
							String num_beyond="";
							while (rs_num.next()) {

								display_2 = rs_num.getString("product_count");

								// 得到调度数量
								String sql_3 = "select count(id) as tdnum from product_info where product_material_plan_id='"
										+ plan_id
										+ "' and product_spec='"
										+ product_spec + "' and product_machine='"+filerows.get(4).trim()+"' and product_pstatus!='2'";
								ResultSet rs_3 = manufacture_db2
										.executeQuery(sql_3);
								if (rs_3.next()) {
									display_3 = rs_3.getString("tdnum");
									if (Integer.parseInt(display_3) > Integer
											.parseInt(display_2)) {
										num_beyond="true";
										
									}
								}

							}
							if(num_beyond.equals("")){
							// 打孔
							// 验证是否添加过+是否在相应仓库中
							sql_q = "select id,product_is_production,stock_id from product_info where id="
									+ product_info_id;
							ResultSet rs_vali = manufacture_db
									.executeQuery(sql_q);
							String product_is_production = "";
							String stock_id = "0";
							if (rs_vali.next()) {
								product_is_production = rs_vali
										.getString("product_is_production");
								stock_id = rs_vali.getString("stock_id");
							}

							if (!product_is_production.equals("0")) {
								if (stock_id.equals("105")) {
									
									if (!mold_id.equals("")) {
//										计划执行状态变更
										String sql_pct = "update product_plan set plan_check_tag='3' " +
											" where id="+plan_id;
										manufacture_db.executeUpdate(sql_pct);	
										int moldids=mold_id.indexOf("-");
										if(moldids>0){//截取研磨品中的“-”前的字符串
											mold_id=mold_id.substring(0,moldids);
										}
										// 更新原料商品出库时间
										String sql_out_time = "update product_info set stock_out_time='"
												+ x_date
												+ "' where id="
												+ product_info_id;
										manufacture_db
												.executeUpdate(sql_out_time);
										sql_q = "update product_info set product_is_production='0',stock_id='0',stock_name='',product_temp_pallet='',product_status=2,product_produce_location=2,"
												+ "product_material_plan_id='"
												+ plan_id
												+ "',product_machine="
												+ filerows.get(4)
												+ ",product_mold_spec='"
												+ mold_spec
												+ "' where id="
												+ product_info_id;
										manufacture_db.executeUpdate(sql_q);

										// 日期拆分
										String yearS = (filerows.get(1))
												.substring(0, 4);
										yearS = yearS.substring(2);
										String monthS = (filerows.get(1))
												.substring(5, 7);
										if (monthS.subSequence(0, 1)
												.equals("0")) {
											monthS = monthS.substring(1);
										}
										String dayS = (filerows.get(1)).trim()
												.substring(8, 10);
										if (dayS.subSequence(0, 1).equals("0")) {
											dayS = dayS.substring(1);
										}
										// 月份用英文字母代替
										String monthE = GetMonthEnglish(monthS);
										String dateLotNo = product_lot_no + "-"
												+ yearS + "-" + monthE + "-"
												+ dayS;
										String machineLotNo = product_lot_no
												+ "-" + mold_id + "-" + monthS
												+ "-" + dayS;

										sql_q = "insert product_info (product_lot_no,product_middle_lot_no,product_spec_id,product_spec,product_type,product_status,product_produce_location,product_4_excep,product_8_excep,product_hole_excep,product_product_plan_id,father_product_id,change_product_id) values ";
										sql_q += "('" + machineLotNo + "','"
												+ dateLotNo + "',"
												+ product_spec_id + ",'"
												+ product_spec + "',3,2,2,'"
												+ product_4_excep + "','"
												+ product_8_excep + "','"
												+ product_hole_excep + "',"
												+ plan_id + ","
												+ product_info_id + ","
												+ change_product_id + ")";

										manufacture_db.executeUpdate(sql_q);

										response
												.sendRedirect("manufacture/process/register_ok_a.jsp");
									} else {
										response
												.sendRedirect("manufacture/process/register_ok_g.jsp");
									}
								} else {
									response
											.sendRedirect("manufacture/process/register_ok_e.jsp?id="
													+ product_lot_no);
								}
							} else {
								response
										.sendRedirect("manufacture/process/register_ok_f.jsp");

							}
							}else{
//								 已超出计划数量
								response
										.sendRedirect("manufacture/process/register_b_ok.jsp");
							}
						} else {
							response
									.sendRedirect("manufacture/process/register_ok_d.jsp");

						}
					}else{
						response
						.sendRedirect("manufacture/process/register_ok_h.jsp");
					}
					} else {
						// 文件错误页面
						response
								.sendRedirect("manufacture/process/register_ok_c.jsp");
					}
				} else {
					response
							.sendRedirect("manufacture/process/register_ok_e.jsp?id="
									+ product_lot_no);
				}
				manufacture_db.commit();
				manufacture_db1.commit();
				manufacture_db2.commit();
				manufacture_db.close();
				manufacture_db1.close();
				manufacture_db2.close();

			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
	}

	/**
	 * 月份用英文字母代替
	 * 
	 * @param month
	 */
	public String GetMonthEnglish(String month) {
		String monthE = "";
		if (month.equals("1")) {
			monthE = "A";
		} else if (month.equals("2")) {
			monthE = "B";
		} else if (month.equals("3")) {
			monthE = "C";
		} else if (month.equals("4")) {
			monthE = "D";
		} else if (month.equals("5")) {
			monthE = "E";
		} else if (month.equals("6")) {
			monthE = "F";
		} else if (month.equals("7")) {
			monthE = "G";
		} else if (month.equals("8")) {
			monthE = "H";
		} else if (month.equals("9")) {
			monthE = "I";
		} else if (month.equals("10")) {
			monthE = "G";
		} else if (month.equals("11")) {
			monthE = "K";
		} else if (month.equals("12")) {
			monthE = "L";
		}
		return monthE;
	}

	/**
	 * 废弃生产计划执行
	 * 
	 * @param request
	 * @param response
	 */
	public void abandon(HttpServletRequest request, HttpServletResponse response) {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();

		ServletContext dbApplication = dbSession.getServletContext();
		ServletContext application;
		HttpSession session = request.getSession();

		nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
		String changer = (String) session.getAttribute("realeditorc");
		java.util.Date now = new java.util.Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String time = formatter.format(now);

		if (manufacture_db
				.conn((String) dbSession.getAttribute("unit_db_name"))) {
			String id = request.getParameter("id");// 获得product_info id
			// 修改product_status为6——废弃，库位为exception，产品生产状态0——异常
			String sql_1 = "update product_info set product_status=6,product_stock='exception',product_pstatus='异常',stock_id='109',stock_name='废弃品库',stock_in_time='"
					+ time + "' where id=" + id;
			manufacture_db.executeUpdate(sql_1);
			try {
				manufacture_db.commit();
				manufacture_db.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			try {
				response.sendRedirect("manufacture/process/exception_list.jsp");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/**
	 * 转换生产计划执行
	 * 
	 * @param request
	 * @param response
	 */
	public void trans(HttpServletRequest request, HttpServletResponse response) {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();

		ServletContext dbApplication = dbSession.getServletContext();
		ServletContext application;
		HttpSession session = request.getSession();

		nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
		nseer_db_backup1 manufacture_db1 = new nseer_db_backup1(dbApplication);
		if (manufacture_db
				.conn((String) dbSession.getAttribute("unit_db_name"))
				&& manufacture_db1.conn((String) dbSession
						.getAttribute("unit_db_name"))) {
			String id = request.getParameter("id");// 获得异常前信息product_info id
			String product_after_no = "";
			if (request.getParameter("product_after_no") != null) {
				product_after_no = request.getParameter("product_after_no");
			}// 获得新Lot No
			String product_after_spec = "";
			if (request.getParameter("product_after_spec") != null) {
				product_after_spec = request.getParameter("product_after_spec");
			}// 获得新规格id
			String fact_length = "";
			if (request.getParameter("fact_length") != null) {
				fact_length = request.getParameter("fact_length");
			}// 获得新长度
			String product_after_noA = "";
			if (request.getParameter("product_after_noA") != null) {
				product_after_noA = request.getParameter("product_after_noA");
			}// 获得新Lot No
			String product_after_specA = "";
			if (request.getParameter("product_after_specA") != null) {
				product_after_specA = request
						.getParameter("product_after_specA");
			}// 获得新规格id
			String fact_lengthA = "";
			if (request.getParameter("fact_lengthA") != null) {
				fact_lengthA = request.getParameter("fact_lengthA");
			}// 获得新长度
			String product_after_noB = "";
			if (request.getParameter("product_after_noB") != null) {
				product_after_noB = request.getParameter("product_after_noB");
			}// 获得新Lot No
			String product_after_specB = "";
			if (request.getParameter("product_after_specB") != null) {
				product_after_specB = request
						.getParameter("product_after_specB");
			}// 获得新规格id
			String fact_lengthB = "";
			if (request.getParameter("fact_lengthB") != null) {
				fact_lengthB = request.getParameter("fact_lengthB");
			}// 获得新长度
			// 查询异常前信息
			String sql_1 = "select product_status,father_product_id,product_lot_no,stock_id,stock_name,product_stock,product_spec_id,product_spec,product_type,product_4_excep,product_8_excep,product_hole_excep from product_info where id="
					+ id;
			ResultSet rs_1 = manufacture_db.executeQuery(sql_1);
			try {
				if (rs_1.next()) {
					if (!product_after_no.equals("")) {
						// 添加转换表
						String sql_2 = "insert product_change (product_before_no,product_after_no,product_before_spec,product_after_spec) values ('"
								+ rs_1.getString("product_lot_no")
								+ "','"
								+ product_after_no
								+ "','"
								+ rs_1.getString("product_spec_id")
								+ "','"
								+ product_after_spec + "')";
						manufacture_db1.executeUpdate(sql_2);
						// 根据规格id获得新规格的名称
						sql_2 = "select id,product_name from design_file where id="
								+ product_after_spec;
						ResultSet rs2 = manufacture_db1.executeQuery(sql_2);
						String spec_name = "";
						if (rs2.next()) {
							spec_name = rs2.getString("product_name");
						}
						String old_no = rs_1.getString("product_lot_no");
						// 相同lotno号产品处理
						if (rs_1.getString("product_lot_no").trim().equals(
								product_after_no)) {
							if (rs_1.getString("product_type").equals("1")) {
								sql_2 = "update product_info set product_spec_id='"
										+ product_after_spec
										+ "',product_spec='"
										+ spec_name
										+ "',product_produce_location='-1',product_pstatus='正常',product_4_excep='是' where id="
										+ id;
							} else if (rs_1.getString("product_type").equals(
									"2")) {
								sql_2 = "update product_info set product_spec_id='"
										+ product_after_spec
										+ "',product_spec='"
										+ spec_name
										+ "',product_produce_location='-1',product_pstatus='正常',product_8_excep='是' where id="
										+ id;
							} else if (rs_1.getString("product_type").equals(
									"3")) {
								sql_2 = "update product_info set product_spec_id='"
										+ product_after_spec
										+ "',product_spec='"
										+ spec_name
										+ "',product_produce_location='-1',product_pstatus='正常',product_hole_excep='是' where id="
										+ id;
							}
							manufacture_db1.executeUpdate(sql_2);
						} else {

							// 添加新原料产品(3种转换品)
							if (rs_1.getString("product_type").equals("1")) {
								sql_2 = "insert product_info (product_lot_no,product_spec_id,product_spec,product_type,product_pstatus,product_produce_location,change_product_id,product_4_excep,product_8_excep,product_hole_excep,stock_id,stock_name,father_product_id,product_status,product_stock) values ('"
										+ product_after_no
										+ "','"
										+ product_after_spec
										+ "','"
										+ spec_name
										+ "','"
										+ rs_1.getString("product_type")
										+ "','正常','-1','"
										+ id
										+ "','是','"
										+ rs_1.getString("product_8_excep")
										+ "','"
										+ rs_1.getString("product_hole_excep")
										+ "',"
										+ rs_1.getString("stock_id")
										+ ",'"
										+ rs_1.getString("stock_name")
										+ "','"
										+ rs_1.getString("father_product_id")
										+ "','"
										+ rs_1.getString("product_status")
										+ "','"
										+ rs_1.getString("product_stock")
										+ "')";

							} else if (rs_1.getString("product_type").equals(
									"2")) {
								sql_2 = "insert product_info (product_lot_no,product_spec_id,product_spec,product_type,product_pstatus,product_produce_location,change_product_id,product_4_excep,product_8_excep,product_hole_excep,stock_id,stock_name,father_product_id,product_status,product_stock) values ('"
										+ product_after_no
										+ "','"
										+ product_after_spec
										+ "','"
										+ spec_name
										+ "','"
										+ rs_1.getString("product_type")
										+ "','正常','-1','"
										+ id
										+ "','"
										+ rs_1.getString("product_4_excep")
										+ "','是','"
										+ rs_1.getString("product_hole_excep")
										+ "',"
										+ rs_1.getString("stock_id")
										+ ",'"
										+ rs_1.getString("stock_name")
										+ "','"
										+ rs_1.getString("father_product_id")
										+ "','"
										+ rs_1.getString("product_status")
										+ "','"
										+ rs_1.getString("product_stock")
										+ "')";

							} else if (rs_1.getString("product_type").equals(
									"3")) {
								sql_2 = "insert product_info (product_lot_no,product_spec_id,product_spec,product_type,product_pstatus,product_produce_location,change_product_id,product_4_excep,product_8_excep,product_hole_excep,stock_id,stock_name,father_product_id,product_status,product_stock) values ('"
										+ product_after_no
										+ "','"
										+ product_after_spec
										+ "','"
										+ spec_name
										+ "','"
										+ rs_1.getString("product_type")
										+ "','正常','-1','"
										+ id
										+ "','"
										+ rs_1.getString("product_4_excep")
										+ "','"
										+ rs_1.getString("product_8_excep")
										+ "','是',"
										+ rs_1.getString("stock_id")
										+ ",'"
										+ rs_1.getString("stock_name")
										+ "','"
										+ rs_1.getString("father_product_id")
										+ "','"
										+ rs_1.getString("product_status")
										+ "','"
										+ rs_1.getString("product_stock")
										+ "')";

							}
							manufacture_db1.executeUpdate(sql_2);
							// 更新原信息
							sql_2 = "update product_info set product_status=4,product_pstatus='异常' where id="
									+ id;
							manufacture_db1.executeUpdate(sql_2);
						}
					} else if (!product_after_noB.equals("")) {
						// 11.11 8mm切正常切换
						String sql_2 = "insert product_change (product_before_no,product_after_no,product_before_spec,product_after_spec) values ('"
								+ rs_1.getString("product_lot_no")
								+ "','"
								+ product_after_noA
								+ "','"
								+ rs_1.getString("product_spec_id")
								+ "','"
								+ product_after_specA
								+ "'),('"
								+ rs_1.getString("product_lot_no")
								+ "','"
								+ product_after_noB
								+ "','"
								+ rs_1.getString("product_spec_id")
								+ "','"
								+ product_after_specB + "');";
						manufacture_db1.executeUpdate(sql_2);// 向转换表里添加了2条数据
						// 根据规格id获得新规格的名称
						sql_2 = "select id,product_name from design_file where id="
								+ product_after_specA;
						ResultSet rs2 = manufacture_db1.executeQuery(sql_2);
						String spec_nameA = "";
						if (rs2.next()) {
							spec_nameA = rs2.getString("product_name");// A转换品
						}
						sql_2 = "select id,product_name from design_file where id="
								+ product_after_specB;
						rs2 = manufacture_db1.executeQuery(sql_2);
						String spec_nameB = "";
						if (rs2.next()) {
							spec_nameB = rs2.getString("product_name");// B转换品
						}
						// 添加两条新产品信息
						sql_2 = "insert product_info (product_lot_no,product_spec_id,product_spec,product_type,product_pstatus,product_produce_location,change_product_id,product_4_excep,product_8_excep,product_hole_excep,stock_id,stock_name,father_product_id,product_status,product_stock) values ('"
								+ product_after_noA
								+ "','"
								+ product_after_specA
								+ "','"
								+ spec_nameA
								+ "','"
								+ rs_1.getString("product_type")
								+ "','正常','-1','"
								+ id
								+ "','"
								+ rs_1.getString("product_4_excep")
								+ "','是','"
								+ rs_1.getString("product_hole_excep")
								+ "',"
								+ rs_1.getString("stock_id")
								+ ",'"
								+ rs_1.getString("stock_name")
								+ "','"
								+ rs_1.getString("father_product_id")
								+ "','"
								+ rs_1.getString("product_status")
								+ "','"
								+ rs_1.getString("product_stock")
								+ "'),('"
								+ product_after_noB
								+ "','"
								+ product_after_specB
								+ "','"
								+ spec_nameB
								+ "','"
								+ rs_1.getString("product_type")
								+ "','正常','-1','"
								+ id
								+ "','"
								+ rs_1.getString("product_4_excep")
								+ "','是','"
								+ rs_1.getString("product_hole_excep")
								+ "',"
								+ rs_1.getString("stock_id")
								+ ",'"
								+ rs_1.getString("stock_name")
								+ "','"
								+ rs_1.getString("father_product_id")
								+ "','"
								+ rs_1.getString("product_status")
								+ "','"
								+ rs_1.getString("product_stock") + "')";
						manufacture_db1.executeUpdate(sql_2);
						// 更新原信息
						sql_2 = "update product_info set product_status=4,product_pstatus='异常' where id="
								+ id;
						manufacture_db1.executeUpdate(sql_2);
					}
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				manufacture_db.commit();
				manufacture_db1.commit();
				manufacture_db.close();
				manufacture_db1.close();
			} catch (SQLException e) {                    // add by wangshaolin
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		//try {
		//	manufacture_db.commit();
			//manufacture_db1.commit();
			//manufacture_db.close();
			//manufacture_db1.close();
		//} catch (SQLException e) {
			// TODO Auto-generated catch block
		//	e.printStackTrace();
		//}
		try {
			response.sendRedirect("manufacture/process/exception_list.jsp");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * 转换为特采品
	 * 
	 * @param request
	 * @param response
	 */
	public void tcpin(HttpServletRequest request, HttpServletResponse response) {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();

		ServletContext dbApplication = dbSession.getServletContext();
		ServletContext application;
		HttpSession session = request.getSession();

		nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
		if (manufacture_db
				.conn((String) dbSession.getAttribute("unit_db_name"))) {
			String id = request.getParameter("id");// 获得product_info id
			String sql_1 = "update product_info set product_type=4,product_pstatus='正常' where id="
					+ id;
			manufacture_db.executeUpdate(sql_1);
		}
		try {
			manufacture_db.commit();
			manufacture_db.close();
			response.sendRedirect("manufacture/process/exception_list.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * 生产结果确认
	 * 
	 * @param request
	 * @param response
	 */
	public void resultCheck(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this, request,
				response, null, false, JspWriter.DEFAULT_BUFFER, true);
		ServletContext dbApplication = dbSession.getServletContext();
		try {
			nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
			if (hr_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String filePath = request.getParameter("filepath");
				FileRead fileread = new FileRead();// 文件读写类
				Map<Integer, String> filerows = new HashMap<Integer, String>();
				filerows = fileread.readF2(filePath);// 获得有效地每一行内容
				int row_m = Integer.parseInt(filerows.get(0));
				String x_date = filerows.get(1);// 时间
				String x_worker = filerows.get(2);// 员工id
				String x_type = filerows.get(3);// conf1——4分切,conf2——8mm切,conf3——打孔
				String sql_x = "";
				String now_id = "";// 当前原料id
				// 循环信息
				for (int x = 4; x < filerows.size(); x++) {

					if (x % 2 == 0) {
						sql_x = "select REPLACE(product_lot_no,'-','') as lotNo,product_lot_no,id from product_info where REPLACE(product_lot_no,'-','')='"
								+ filerows.get(x) + "'";
						ResultSet rs_x = hr_db.executeQuery(sql_x);
						if (rs_x.next()) {

						}
					}
				}
				if (!now_id.equals("")) {
					response.sendRedirect("manufacture/process/checkerr.jsp?n="
							+ now_id);
				} else {
					response.sendRedirect("manufacture/process/check.jsp?path="
							+ filePath);
				}
				hr_db.close();
			} else {
				response.sendRedirect("error_conn.htm");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/**
	 * 生产结果确认执行
	 * 
	 * @param request
	 * @param response
	 */
	public void checkResultOk(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession dbSession = request.getSession();

		ServletContext dbApplication = dbSession.getServletContext();
		try {

			nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
			 nseer_db_backup1 hr_db9 = new nseer_db_backup1(dbApplication);
			nseer_db_backup1 hr_db1 = new nseer_db_backup1(dbApplication);
			nseer_db_backup1 hr_db2 = new nseer_db_backup1(dbApplication);
			if (hr_db.conn((String) dbSession.getAttribute("unit_db_name"))
					&& hr_db1.conn((String) dbSession
							.getAttribute("unit_db_name"))
					&& hr_db2.conn((String) dbSession
							.getAttribute("unit_db_name"))&&hr_db9.conn((String) dbSession
									.getAttribute("unit_db_name"))) {
				String filePath = request.getParameter("filepath");
				FileRead fileread = new FileRead();// 文件读写类
				Map<Integer, String> filerows = new HashMap<Integer, String>();
				filerows = fileread.readF2(filePath);// 获得有效地每一行内容
				int row_m = Integer.parseInt(filerows.get(0));
				String x_date = filerows.get(1);// 时间
				String x_worker = filerows.get(2);// 员工id
				String x_type = filerows.get(3);// conf1——4分切,conf2——8mm切,conf3——打孔
				if ((!filerows.get(3).toLowerCase().equals("conf1"))
						&& (!filerows.get(3).toLowerCase().equals("conf2"))
						&& (!filerows.get(3).toLowerCase().equals("conf3"))) {
					response.sendRedirect("manufacture/process/uploaderr.jsp");
				} else {
					String sql_x = "";
					String now_id = "";// 当前原料id
					String father_product_id = "";
					// 循环信息
					for (int x = 4; x < filerows.size(); x++) {
						String fx = filerows.get(x);
						if (fx == null) {
							continue;
						} else if (fx.trim().equals("")) {
							continue;
						} else {
							if (x % 2 == 0) {
								sql_x = "select REPLACE(product_lot_no,'-','') as lotNo,product_status,product_lot_no,id,father_product_id from product_info where REPLACE(product_lot_no,'-','')='"
										+ filerows.get(x) + "'";
								ResultSet rs_x = hr_db.executeQuery(sql_x);
								if (rs_x.next()) {
									now_id = rs_x.getString("id");
									// 11.11添加报废产品经过生产结果确认变更
									if (rs_x.getString("product_status")
											.equals("6")) {// 报废品判断
										// 清空库位号，仓库id，仓库名称，出库时间（从废弃品仓取出）
										String sql_6 = "update product_info set product_stock='',stock_id='0',stock_name='',stock_out_time='"
												+ x_date
												+ "' where id="
												+ now_id;
										hr_db1.executeUpdate(sql_6);
									} else {
										if (!father_product_id
												.equals(rs_x
														.getString("father_product_id"))) {
											father_product_id = rs_x
													.getString("father_product_id");// 更新父id
											String sql_fa = "update product_info set product_status=3 where id="
													+ father_product_id;
											hr_db1.executeUpdate(sql_fa);
										}
										// }
									}
									// hr_db.close();
									if (!now_id.trim().equals("")) {
										String sql_1 = "update product_info set product_status=3 where id="
												+ now_id;
										hr_db1.executeUpdate(sql_1);
									} else {
										continue;
									}
								}
							} else {
									 if(!now_id.trim().equals("")){
									 String sql_2 = "";
									 if
									 (filerows.get(x).toLowerCase().equals("excep"))
									 {
									 sql_2 = "update product_info set product_pstatus='异常' where id="+ now_id;
									 } else {
									 sql_2 = "update product_info set product_pstatus='正常' where id="+ now_id;
									 }
									 hr_db1.executeUpdate(sql_2);
									 }else{
									 continue;
									 }
			}
							
						}
					
					}
				}
				// hr_db.commit();
				hr_db1.commit();
				hr_db2.commit();
				// hr_db.close();
				hr_db1.close();
				hr_db2.close();
				hr_db.close();// add by wangshaolin
				hr_db9.close(); // add by wangshaolin 
				response
						.sendRedirect("manufacture/process/check_ok.jsp");
			} else {
				response.sendRedirect("error_conn.htm");
			}
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/**
	 * 删除栈板信息
	 * 
	 * @param request
	 * @param response
	 */
	public void delpackage(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession dbSession = request.getSession();

		ServletContext dbApplication = dbSession.getServletContext();
		try {

			nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);

			if (hr_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String id = request.getParameter("id");
				if (id != null && !id.equals("")) {
					String sql_del = "delete from package_info where id=" + id;
					hr_db.executeUpdate(sql_del);
					response
							.sendRedirect("manufacture/process/queryPackage_list_ok_a.jsp");
				} else {
					response
							.sendRedirect("manufacture/process/queryPackage_list_ok_b.jsp");
				}

			}
			hr_db.commit();
			//hr_db.commit();
			hr_db.close(); // add by wangshaolin
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/**
	 * 添加栈板号信息
	 * 
	 * @param request
	 * @param response
	 */
	public void addpallet(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession dbSession = request.getSession();

		ServletContext dbApplication = dbSession.getServletContext();
		try {

			nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);

			if (hr_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String product_spec_id = request
						.getParameter("product_spec_id");// 规格id
				String package_custom_id = request
						.getParameter("package_custom_id");// 客户id
				String package_factory_pallet = request
						.getParameter("package_factory_pallet");// 工厂托盘号（手填）
				String mold_spec_id = request.getParameter("mold_spec_id");// 模具规格id
				String product_pallet_sf = request
						.getParameter("product_pallet_sf");// 获得栈板号标示（改为工厂托盘号）
				//判断输入的栈板号是否已经存在
				String sql_re=" select package_pallet from package_info where package_pallet='"+product_pallet_sf+"'";
				ResultSet rs_re=hr_db.executeQuery(sql_re);
				String piid="";
				if(rs_re.next()){
					piid=rs_re.getString("package_pallet");
				}
				if(piid.equals("")){
				String mold_spec = "";
				String package_pallet = "";
				String product_spec = "";
				
				String sql_spec = "select id,product_name,type,product_pallet_sf from design_file where id="
						+ product_spec_id;
				ResultSet rs_spec = hr_db.executeQuery(sql_spec);
				if (rs_spec.next()) {
					product_spec = rs_spec.getString("product_name");

				}
				if (!mold_spec_id.equals("0")) {
					// 模具信息查询
					String sql_mold = "select mold_spec FROM mold_info where mold_spec_id="
							+ mold_spec_id;
					ResultSet rs_mold = hr_db.executeQuery(sql_mold);
					if (rs_mold.next()) {
						mold_spec = rs_mold.getString("mold_spec");
					}
				}

				// 当前栈板号
				/*
				String product_sf = product_pallet_sf;
				String sql_package_pallet = "select max(right(package_pallet,5)) as r, package_pallet from package_info where substring(package_pallet,1,instr(package_pallet,right(package_pallet,5))-1) ='"
						+ product_sf + "'";
				ResultSet rs_package_pallet = hr_db
						.executeQuery(sql_package_pallet);
				if (rs_package_pallet.next()) {
					if (rs_package_pallet.getString("r") != null
							&& !rs_package_pallet.getString("r").equals("null")) {
						String temp_int = String
								.valueOf(Integer.parseInt(rs_package_pallet
										.getString("r")) + 1);// 产生最大数字+1
						// 补齐5位数字
						while (temp_int.length() < 5) {
							temp_int = "0" + temp_int;
						}
						// 拼接栈板号
						package_pallet = product_sf + temp_int;
					} else {
						package_pallet = product_sf + "00001";
					}
				} else {

					package_pallet = product_sf + "00001";
				}*/
				// 添加包装信息表
				String sql_x = "INSERT package_info (product_spec_id,product_spec,package_pallet,package_factory_pallet,package_custom_id,mold_spec_id,mold_spec) VALUES ('"
						+ product_spec_id
						+ "','"
						+ product_spec
						+ "','"
						+ product_pallet_sf
						+ "','"
						+ package_factory_pallet
						+ "','"
						+ package_custom_id
						+ "','"
						+ mold_spec_id
						+ "','" + mold_spec + "')";
				hr_db.executeUpdate(sql_x);
				response.sendRedirect("manufacture/process/package_2.jsp?p_p="
						+ product_pallet_sf);
				hr_db.commit();
				hr_db.close();
				}else{
				response.sendRedirect("manufacture/process/package_error.jsp?p_p="
						+ piid);
				hr_db.close();
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/**
	 * 更新商品包装信息
	 * 
	 * @param request
	 * @param response
	 */
	public void addpackage(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession dbSession = request.getSession();

		ServletContext dbApplication = dbSession.getServletContext();
		try {

			nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);

			if (hr_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String filePath = request.getParameter("path");
				FileRead fileread = new FileRead();// 文件读写类
				Map<Integer, String> filerows = new HashMap<Integer, String>();
				filerows = fileread.readF2(filePath);// 获得有效地每一行内容
				int row_m = Integer.parseInt(filerows.get(0));
				String x_date = filerows.get(1);// 时间
				String x_worker = filerows.get(2);// 员工id
				String x_type = filerows.get(3);// pack——包装
				String x_package_stock = filerows.get(filerows.size() - 1);// 生产托盘号（栈板号）
				String product_spec = "";// 规格
				String product_pallet_sf = "";
				String package_pallet = "";
				String product_spec_id = "";
				String package_factory_pallet = "";
				String package_custom_id = "";
				String package_custom_name = "";
				String package_id = "";
				String sql_p = "select id,package_pallet from package_info where package_pallet='"
						+ x_package_stock + "'";
				ResultSet rs_p = hr_db.executeQuery(sql_p);
				if (rs_p.next()) {
					package_id = rs_p.getString("id");
				}

				if (!package_id.trim().equals("")) {//包装信息存在
					
					List listNG=new ArrayList();//错误的商品信息集合
					String stock_info = "";
					// 遍历信息更改包装id
					
					for (int x = 4; x < filerows.size() - 1; x++) {
						/*
						 * String sql_v="select package_id from product_info
						 * where
						 * REPLACE(product_lot_no,'-','')='"+filerows.get(x)+"'";
						 * ResultSet rs_v=hr_db.executeQuery(sql_v); String
						 * package_v=""; if(rs_v.next()){
						 * package_v=rs_v.getString("package_id"); }
						 */
						// 验证没有添加过包装信息
						// if(package_v.equals("0")){
						// 判断仓库信息
						String sql_qp = "select product_lot_no,stock_id from product_info where REPLACE(product_lot_no,'-','')='"
								+ filerows.get(x) + "'";
						ResultSet rs_qp = hr_db.executeQuery(sql_qp);
						String stock_id = "";
						
						if (rs_qp.next()) {
							stock_id = rs_qp.getString("stock_id");// 得到商品仓库id
							if (!stock_id.equals("107") && !stock_id.equals("108")) {
								listNG.add(rs_qp.getString("product_lot_no"));//向错误的包装信息集合添加信息
							}
						}else{
							listNG.add(filerows.get(x));
						}
					}
					int unum = 0;
					if (listNG.size()==0) {//如果没有错误信息在进行信息变更
						
						for (int x = 4; x < filerows.size() - 1; x++) {	
							String sql_pa = "update product_info set product_status='5',stock_id='0',stock_name='',product_stock='',stock_out_time='"
									+ x_date
									+ "',package_id='"
									+ package_id
									+ "' where REPLACE(product_lot_no,'-','')='"
									+ filerows.get(x) + "'";
							hr_db.executeUpdate(sql_pa);
							unum++;
						} 
					}
						/*
						 * }else{
						 * response.sendRedirect("manufacture/process/package_ok_f.jsp"); }
						 */
					
					if (listNG.size()>0) {
						
						// 原料未入临时库
						response
								.sendRedirect("manufacture/process/package_ok_e.jsp?filePath="
										+ filePath );
					} else {

						// 更新数量
						String sql_unum = "update package_info set package_count=package_count+"
								+ unum + " where id=" + package_id;
						hr_db.executeUpdate(sql_unum);
						response
								.sendRedirect("manufacture/process/package_ok.jsp");
					}
				}

				hr_db.commit();
				hr_db.close();

			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/**
	 * 更新商品异常信息
	 * 
	 * @param request
	 * @param response
	 */
	public void addspecial(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession dbSession = request.getSession();

		ServletContext dbApplication = dbSession.getServletContext();
		try {

			nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);

			if (hr_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String filePath = request.getParameter("path");

				FileRead fileread = new FileRead();// 文件读写类
				Map<Integer, String> filerows = new HashMap<Integer, String>();
				filerows = fileread.readF2(filePath);// 获得有效地每一行内容
				int row_m = Integer.parseInt(filerows.get(0));
				String x_date = filerows.get(1);// 时间
				String x_worker = filerows.get(2);// 员工id
				String x_type = filerows.get(3);// conf1——4分切,conf2——8mm切,conf3——打孔
				if ((!filerows.get(3).toLowerCase().equals("conf1"))
						&& (!filerows.get(3).toLowerCase().equals("conf2"))
						&& (!filerows.get(3).toLowerCase().equals("conf3"))) {
					response
							.sendRedirect("manufacture/process/file_upload_error1.jsp");
				} else {
					String sql_x = "";
					String now_id = "";// 当前原料id
					String father_product_id = "";
					// 循环信息
					for (int x = 4; x < filerows.size(); x++) {
						String fx = filerows.get(x);
						if (fx == null) {
							continue;
						} else if (fx.trim().equals("")) {
							continue;
						} else {
							if (x % 2 == 0) {
								sql_x = "select REPLACE(product_lot_no,'-','') as lotNo,product_lot_no,id,father_product_id from product_info where REPLACE(product_lot_no,'-','')='"
										+ filerows.get(x) + "'";
								ResultSet rs_x = hr_db.executeQuery(sql_x);
								if (rs_x.next()) {
									now_id = rs_x.getString("id");
								}
								if (!now_id.trim().equals("")) {

								} else {
									continue;
								}
							} else {
								if (!now_id.trim().equals("")) {
									String sql_2 = "";
									if (filerows.get(x).toLowerCase().equals("excep")) {
										sql_2 = "update product_info set product_pstatus='异常',product_status=3 where id="
												+ now_id;
									}else if(filerows.get(x).toLowerCase().equals("nomal")){
										sql_2 = "update product_info set product_pstatus='正常',product_status=3 where id="
											+ now_id;
									}
									hr_db.executeUpdate(sql_2);
								} else {
									continue;
								}
							}
						}
					}

					response
							.sendRedirect("manufacture/abnormity/file_upload_ok.jsp");
				}
				hr_db.commit();
				hr_db.close();

			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

}
