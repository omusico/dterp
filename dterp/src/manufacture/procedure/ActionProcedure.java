package manufacture.procedure;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;


import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import validata.ValidataNumber;



import magic.action.Action;
/**
 * lixiaodong 
 * @author Administrator
 * 产品信息管理
 */
public class ActionProcedure extends Action {
	/**
	 * 产品信息登记
	 * @param request
	 * @param response
	 */
	public void add(HttpServletRequest request, HttpServletResponse response){
		HttpSession dbSession=request.getSession();
		JspFactory _jspxFactory=JspFactory.getDefaultFactory();
		
		ServletContext dbApplication=dbSession.getServletContext();
		ServletContext application;
		HttpSession session=request.getSession();
		
		nseer_db_backup1 manufacture_db= new nseer_db_backup1(dbApplication);
		nseer_db_backup1 manufacture_db1= new nseer_db_backup1(dbApplication);
		
		
		
		if(manufacture_db.conn((String) dbSession.getAttribute("unit_db_name"))&&manufacture_db1.conn((String) dbSession.getAttribute("unit_db_name"))){
			String id=request.getParameter("product_id");//原料id
			String sql_all="select id,product_produce_location,product_spec_id,product_spec,product_lot_no,product_status from product_info where id="+id;
			ResultSet rs_all=manufacture_db.executeQuery(sql_all);
			String product_produce_location="";//发生场所
			
			try {
				if(rs_all.next()){
					if(rs_all.getString("product_produce_location").equals("0")){
						product_produce_location="4分切";
						String product_4_weather=request.getParameter("product_4_weather");
						String product_4_temperature=request.getParameter("product_4_temperature");
						String product_4_humidity=request.getParameter("product_4_humidity");
						String product_4_register=request.getParameter("product_4_register");
						String product_4_register_time=request.getParameter("product_4_register_time");
						String product_4_operator=request.getParameter("product_4_operator");
						for(int i=1;i<5;i++){
							//正常填写信息
							String part_id_temp="part_id"+i;
							String part_id=request.getParameter(part_id_temp);
							String product_4_width_temp="product_4_width"+i;
							String product_4_width=request.getParameter(product_4_width_temp);
							String product_4_before_thickness_temp="product_4_before_thickness"+i;
							String product_4_before_thickness=request.getParameter(product_4_before_thickness_temp);
							String product_4_after_thickness_temp="product_4_after_thickness"+i;
							String product_4_after_thickness=request.getParameter(product_4_after_thickness_temp);
							String product_4_fact_length_temp="product_4_fact_length"+i;
							String product_4_fact_length=request.getParameter(product_4_fact_length_temp);
							String product_4_date_temp="product_4_date"+i;
							String product_4_date=request.getParameter(product_4_date_temp);
							String product_4_time_temp="product_4_time"+i;
							String product_4_time=request.getParameter(product_4_time_temp);
							
							//错误信息()
							
							String sql_ok="";/*"INSERT INTO product_4_info "
								+"(product_id,product_4_weather,product_4_temperature,product_4_humidity,product_4_width,product_4_before_thickness,"
								+"product_4_after_thickness,product_4_fact_length,product_4_date,product_4_time,product_4_workdefect_start,product_4_workdefect_sharp,"
								+"product_4_workdefect_size,product_4_workdefect_content,product_4_workdefect_content_other,product_4_notedefect_start,"
								+"product_4_notedefect_sharp,product_4_notedefect_size,product_4_notedefect_content,product_4_notedefect_content_other,product_4_register,"
								+"product_4_register_time,product_4_checker,product_4_checker_time,product_4_operator) VALUES ('')";
							*/
							String defect_no_temp="defect_no"+i;
							String def="";
							if(request.getParameter(defect_no_temp).equals("1")){
								def="workdefect";
							}else if(request.getParameter(defect_no_temp).equals("2")){
								def="notedefect";
							}
							if(!def.equals("")){
								//获得异常信息
								//String product_4_start_temp="product_4_"+def+"_start"+i;
								String product_4_start=request.getParameter("product_4_start"+i);
								//String product_4_sharp_temp="product_4_"+def+"_sharp"+i;
								String product_4_sharp=request.getParameter("product_4_sharp"+i);
								//String product_4_size_temp="product_4_"+def+"_size"+i;
								String product_4_size=request.getParameter("product_4_size"+i);
								//String product_4_content_temp="product_4_"+def+"_content"+i;
								String product_4_content=request.getParameter("product_4_content"+i);
								//String product_4_content_other_temp="product_4_"+def+"_content_other";
								String product_4_content_other=request.getParameter("product_4_content_other"+i);
								if(def.equals("workdefect")){
									sql_ok="INSERT INTO product_4_info "
										+"(product_id,product_4_weather,product_4_temperature,product_4_humidity,product_4_width,"
										+"product_4_before_thickness,product_4_after_thickness,product_4_fact_length,product_4_date,product_4_time,"
										+"product_4_workdefect_start,product_4_workdefect_sharp,product_4_workdefect_size,product_4_workdefect_content,product_4_workdefect_content_other,"
										+"product_4_register,product_4_register_time,product_4_operator) VALUES ('"
										+part_id+"','"+product_4_weather+"','"+product_4_temperature+"','"+product_4_humidity+"','"+product_4_width+"','"+product_4_before_thickness+"','"
										+product_4_after_thickness+"','"+product_4_fact_length+"','"+product_4_date+"','"+product_4_time+"','"+product_4_start+"','"
										+product_4_sharp+"','"+product_4_size+"','"+product_4_content+"','"+product_4_content_other+"','"+product_4_register+"','"
										+product_4_register_time+"','"+product_4_operator+"')";
								}else if(def.equals("notedefect")){
									sql_ok="INSERT INTO product_4_info "
										+"(product_id,product_4_weather,product_4_temperature,product_4_humidity,product_4_width,"
										+"product_4_before_thickness,product_4_after_thickness,product_4_fact_length,product_4_date,product_4_time,"
										+"product_4_notedefect_start,product_4_notedefect_sharp,product_4_notedefect_size,product_4_notedefect_content,product_4_notedefect_content_other,"
										+"product_4_register,product_4_register_time,product_4_operator) VALUES ('"
										+part_id+"','"+product_4_weather+"','"+product_4_temperature+"','"+product_4_humidity+"','"+product_4_width+"','"+product_4_before_thickness+"','"
										+product_4_after_thickness+"','"+product_4_fact_length+"','"+product_4_date+"','"+product_4_time+"','"+product_4_start+"','"
										+product_4_sharp+"','"+product_4_size+"','"+product_4_content+"','"+product_4_content_other+"','"+product_4_register+"','"
										+product_4_register_time+"','"+product_4_operator+"')";
								}
							}else {
								//没有异常信息
								sql_ok="INSERT INTO product_4_info "
									+"(product_id,product_4_weather,product_4_temperature,product_4_humidity,product_4_width,"
									+"product_4_before_thickness,product_4_after_thickness,product_4_fact_length,product_4_date,product_4_time,"
									+"product_4_register,product_4_register_time,product_4_operator) VALUES ('"
									+part_id+"','"+product_4_weather+"','"+product_4_temperature+"','"+product_4_humidity+"','"+product_4_width+"','"+product_4_before_thickness+"','"
									+product_4_after_thickness+"','"+product_4_fact_length+"','"+product_4_date+"','"+product_4_time+"','"+product_4_register+"','"
									+product_4_register_time+"','"+product_4_operator+"')";
							}
							manufacture_db1.executeUpdate(sql_ok);
						}
					}else if(rs_all.getString("product_produce_location").equals("1")){
						product_produce_location="8mm切";
						String product_8mm_weather=request.getParameter("product_8mm_weather");
						String product_8mm_temperature=request.getParameter("product_8mm_temperature");
						String product_8mm_humidity=request.getParameter("product_8mm_humidity");
						String product_8mm_register=request.getParameter("product_8mm_register");
						String product_8mm_register_time=request.getParameter("product_8mm_register_time");
						String product_8mm_operator=request.getParameter("product_8mm_operator");
						String product_8mm_date=request.getParameter("product_8mm_date");
						String product_8mm_time=request.getParameter("product_8mm_time");
						String product_8mm_time1=request.getParameter("product_8mm_time1");
						String product_8mm_time2=request.getParameter("product_8mm_time2");
						String product_8mm_time3=request.getParameter("product_8mm_time3");
						
						product_8mm_time=product_8mm_time+":"+product_8mm_time1+"-"+product_8mm_time2+":"+product_8mm_time3;
						
						String kno=request.getParameter("k");
						int intk=Integer.parseInt(kno);
						for(int i=1;i<intk;i++){
							String part_id_temp="part_id"+i;
							String part_id=request.getParameter(part_id_temp);
							String product_8mm_fact_length_temp="product_8mm_fact_length"+i;
							String product_8mm_fact_length=request.getParameter(product_8mm_fact_length_temp);
							String product_8mm_fact_width_temp="product_8mm_fact_width"+i;
							String product_8mm_fact_width=request.getParameter(product_8mm_fact_width_temp);
							String product_8mm_paper_exterior_temp="product_8mm_paper_exterior"+i;
							String product_8mm_paper_exterior=request.getParameter(product_8mm_paper_exterior_temp);
							String product_8mm_paper_exterior_other_temp="product_8mm_paper_exterior_other"+i;
							String product_8mm_paper_exterior_other=request.getParameter(product_8mm_paper_exterior_other_temp);
							String product_8mm_volume_exterior_temp="product_8mm_volume_exterior"+i;
							String product_8mm_volume_exterior=request.getParameter(product_8mm_volume_exterior_temp);
							String product_8mm_volume_exterior_other_temp="product_8mm_volume_exterior_other"+i;
							String product_8mm_volume_exterior_other=request.getParameter(product_8mm_volume_exterior_other_temp);
							String product_8mm_defect_temp="product_8mm_defect"+i;
							String product_8mm_defect=request.getParameter(product_8mm_defect_temp);
							String product_8mm_defect_other_temp="product_8mm_defect_other"+i;
							String product_8mm_defect_other=request.getParameter(product_8mm_defect_other_temp);
							String product_8mm_peel_temp="product_8mm_peel"+i;
							String product_8mm_peel=request.getParameter(product_8mm_peel_temp);
							
							String sql_ok="INSERT product_8mm_info (product_id,product_8mm_weather,product_8mm_temperature,product_8mm_humidity,"
								+"product_8mm_fact_length,product_8mm_fact_width,product_8mm_paper_exterior,product_8mm_paper_date,product_8mm_paper_time,"
								+"product_8mm_paper_exterior_other,product_8mm_volume_exterior,product_8mm_volume_exterior_other,product_8mm_defect,product_8mm_defect_other,product_8mm_peel,"
								+"product_8mm_register,product_8mm_register_time,product_8mm_operator) VALUES ('"
								+part_id+"','"+product_8mm_weather+"','"+product_8mm_temperature+"','"+product_8mm_humidity+"','"+product_8mm_fact_length+"','"
								+product_8mm_fact_width+"','"+product_8mm_paper_exterior+"','"+product_8mm_date+"','"+product_8mm_time+"','"
								+product_8mm_paper_exterior_other+"','"+product_8mm_volume_exterior+"','"+product_8mm_volume_exterior_other+"','"+product_8mm_defect+"','"+product_8mm_defect_other+"','"
								+product_8mm_peel+"','"+product_8mm_register+"','"+product_8mm_register_time+"','"+product_8mm_operator+"')";
							manufacture_db1.executeUpdate(sql_ok);
						}
						
						
						
					}else if(rs_all.getString("product_produce_location").equals("2")){
						product_produce_location="打孔";
						ValidataNumber validata = new ValidataNumber();
						//基本信息
						String product_final_lot_no=request.getParameter("product_final_lot_no");
						String product_hole_temperature=request.getParameter("product_hole_temperature");
						String product_hole_humidity=request.getParameter("product_hole_humidity");
						String product_hole_register=request.getParameter("product_hole_register");
						String product_hole_register_time=request.getParameter("product_hole_register_time");
						String product_hole_operator=request.getParameter("product_hole_operator");
						String mold_style=request.getParameter("mold_style");
						String mold_size_length=request.getParameter("mold_size_length");
						String mold_size_width=request.getParameter("mold_size_width");
						String product_hole_date=request.getParameter("product_hole_date");//获得打孔加工日期
						//获得产品信息表id
						String sql_pro_id="select id,product_lot_no from product_info where product_lot_no='"+product_final_lot_no+"'";
						ResultSet rs_pro_id=manufacture_db1.executeQuery(sql_pro_id);
						String pro_id="";
						if(rs_pro_id.next()){
							pro_id=rs_pro_id.getString("id");
						}
						
						//
						String product_hole_num=request.getParameter("product_hole_num");
						String product_hole_time=request.getParameter("product_hole_time");
						String product_dust_clean=request.getParameter("product_dust_clean");
						String product_needle_status=request.getParameter("product_needle_status");
						
						String product_needle_content=request.getParameter("product_needle_content");
						if(product_needle_content==null){
							product_needle_content="0";
						}
						if(!validata.validata(product_needle_content)){
							product_needle_content="0";
						}
						String mold_hole_count=request.getParameter("mold_hole_count");
						
						String product_middle_lot_no=request.getParameter("product_middle_lot_no");
						String prodcut_middle_length=request.getParameter("prodcut_middle_length");
						String product_middle_width=request.getParameter("product_middle_width");
						String product_middle_thickness=request.getParameter("product_middle_thickness");
						String product_surface=request.getParameter("product_surface");
						String product_exterior=request.getParameter("product_exterior");
						String _2front_circle=request.getParameter("2front_circle");
						String _2front_square=request.getParameter("2front_square");
						String front_10P0=request.getParameter("front_10P0");
						String front_E=request.getParameter("front_E");
						String front_burn=request.getParameter("front_burn");
						String stop_damage=request.getParameter("stop_damage");
						String stop_length=request.getParameter("stop_length");
						if(stop_length.equals("")){
							stop_length="0";
						}
						if(!validata.validata(stop_length)){
							stop_length="0";
						}
						String final_status=request.getParameter("final_status");
						String final_particles=request.getParameter("final_particles");
						String final_particles_content=request.getParameter("final_particles_content");
						if(final_particles_content==null){
							final_particles_content="0";
						}
						if(!validata.validata(final_particles_content)){
							final_particles_content="0";
						}
						String _2back_circle=request.getParameter("2back_circle");
						String _2back_square=request.getParameter("2back_square");
						
						String back_10P0=request.getParameter("back_10P0");
						String back_E=request.getParameter("back_E");
						String back_burn=request.getParameter("back_burn");
						String check_surface=request.getParameter("check_surface");
						String check_exterior=request.getParameter("check_exterior");
						String check_hole_repeat=request.getParameter("check_hole_repeat");
						String check_flatness=request.getParameter("check_flatness");
						String check_error_result=request.getParameter("check_error_result");
						String check_hole_count=request.getParameter("check_hole_count");
						if(check_hole_count.equals("")){
							check_hole_count="0";
						}
						if(!validata.validata(check_hole_count)){
							check_hole_count="0";
						}
						String product_final_length=request.getParameter("product_final_length");
						String check_result=request.getParameter("check_result");
						
						String sql_ok="INSERT INTO product_hole_info (product_id,product_final_lot_no,mold_style_id,mold_size_length,mold_size_width,"
							+"product_hole_temperature,product_hole_humidity,product_hole_num,product_hole_time,product_dust_clean,product_needle_status,"
							+"product_needle_content,product_middle_lot_no,prodcut_middle_length,product_middle_width,product_middle_thickness,product_surface,"
							+"product_exterior,2front_circle,2front_square,front_10P0,front_E,front_burn,stop_damage,stop_length,final_status,final_particles,"
							+"final_particles_content,2back_circle,2back_square,back_10P0,back_E,back_burn,check_surface,check_exterior,check_hole_repeat,"
							+"check_flatness,check_error_result,check_hole_count, product_final_length,check_result,product_hole_register,product_hole_register_time,"
							+"product_hole_operator,mold_hole_count,product_hole_date) VALUES ("
							+"'"+pro_id+"','"+product_final_lot_no+"','"+mold_style+"','"+mold_size_length+"','"+mold_size_width+"','"+product_hole_temperature+"','"
							+product_hole_humidity+"','"+product_hole_num+"','"+product_hole_time+"','"+product_dust_clean+"','"+product_needle_status+"','"
							+product_needle_content+"','"+product_middle_lot_no+"','"+prodcut_middle_length+"','"+product_middle_width+"','"+product_middle_thickness+"','"
							+product_surface+"','"+product_exterior+"','"+_2front_circle+"','"+_2front_square+"','"+front_10P0+"','"+front_E+"','"+front_burn+"','"
							+stop_damage+"','"+stop_length+"','"+final_status+"','"+final_particles+"','"+final_particles_content+"','"+_2back_circle+"','"+_2back_square+"','"
							+back_10P0+"','"+back_E+"','"+back_burn+"','"+check_surface+"','"+check_exterior+"','"+check_hole_repeat+"','"+check_flatness+"','"
							+check_error_result+"','"+check_hole_count+"','"+product_final_length+"','"+check_result+"','"+product_hole_register+"','"
							+product_hole_register_time+"','"+product_hole_operator+"','"+mold_hole_count+"','"+product_hole_date+"')";
						manufacture_db1.executeUpdate(sql_ok);
						String product_mold_spec=request.getParameter("mold_style_spec");
						//更新产品信息表的模具规格
						String sql_update="update product_info set product_mold_spec='"+product_mold_spec+"' where id="+id;
						manufacture_db1.executeUpdate(sql_update);
						//机器累计打孔数更新
//						String product_machine=request.getParameter("product_machine");
//						String sql_mold="update mold_info set mold_hole_count=mold_hole_count+1 where mold_machine_number="+product_machine;
//						manufacture_db1.executeUpdate(sql_mold);
					
					}
				}
				manufacture_db1.commit();
				manufacture_db.close();
				manufacture_db1.close();
				response.sendRedirect("manufacture/procedure/register_ok_a.jsp");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	/**
	 * 产品信息修改
	 * @param request
	 * @param response
	 */
	public void update(HttpServletRequest request, HttpServletResponse response){
		HttpSession dbSession=request.getSession();
		JspFactory _jspxFactory=JspFactory.getDefaultFactory();
		
		ServletContext dbApplication=dbSession.getServletContext();
		ServletContext application;
		HttpSession session=request.getSession();
		
		nseer_db_backup1 manufacture_db= new nseer_db_backup1(dbApplication);
		nseer_db_backup1 manufacture_db1= new nseer_db_backup1(dbApplication);
		
		
		
		if(manufacture_db.conn((String) dbSession.getAttribute("unit_db_name"))&&manufacture_db1.conn((String) dbSession.getAttribute("unit_db_name"))){
			String id=request.getParameter("changeId");//原料id
			String sql_all="select id,product_produce_location,product_spec_id,product_spec,product_lot_no,product_status from product_info where id="+id;
			ResultSet rs_all=manufacture_db.executeQuery(sql_all);
			String product_produce_location="";//发生场所
			
			try {
				if(rs_all.next()){
					if(rs_all.getString("product_produce_location").equals("0")){
//						删除原有信息表信息
						String sql_del="delete from product_4_info where product_id in (select id from product_info where father_product_id='"+id+"')";
						manufacture_db1.executeUpdate(sql_del);
						product_produce_location="4分切";
						String product_4_weather=request.getParameter("product_4_weather");
						String product_4_temperature=request.getParameter("product_4_temperature");
						String product_4_humidity=request.getParameter("product_4_humidity");
						String product_4_register=request.getParameter("product_4_register");
						String product_4_register_time=request.getParameter("product_4_register_time");
						String product_4_operator=request.getParameter("product_4_operator");
						for(int i=1;i<5;i++){
							//正常填写信息
							String part_id_temp="part_id"+i;
							String part_id=request.getParameter(part_id_temp);
							String product_4_width_temp="product_4_width"+i;
							String product_4_width=request.getParameter(product_4_width_temp);
							String product_4_before_thickness_temp="product_4_before_thickness"+i;
							String product_4_before_thickness=request.getParameter(product_4_before_thickness_temp);
							String product_4_after_thickness_temp="product_4_after_thickness"+i;
							String product_4_after_thickness=request.getParameter(product_4_after_thickness_temp);
							String product_4_fact_length_temp="product_4_fact_length"+i;
							String product_4_fact_length=request.getParameter(product_4_fact_length_temp);
							String product_4_date_temp="product_4_date"+i;
							String product_4_date=request.getParameter(product_4_date_temp);
							String product_4_time_temp="product_4_time"+i;
							String product_4_time=request.getParameter(product_4_time_temp);
							
							//错误信息()
							
							String sql_ok="";/*"INSERT INTO product_4_info "
								+"(product_id,product_4_weather,product_4_temperature,product_4_humidity,product_4_width,product_4_before_thickness,"
								+"product_4_after_thickness,product_4_fact_length,product_4_date,product_4_time,product_4_workdefect_start,product_4_workdefect_sharp,"
								+"product_4_workdefect_size,product_4_workdefect_content,product_4_workdefect_content_other,product_4_notedefect_start,"
								+"product_4_notedefect_sharp,product_4_notedefect_size,product_4_notedefect_content,product_4_notedefect_content_other,product_4_register,"
								+"product_4_register_time,product_4_checker,product_4_checker_time,product_4_operator) VALUES ('')";
							*/
							String defect_no_temp="defect_no"+i;
							String def="";
							if(request.getParameter(defect_no_temp).equals("1")){
								def="workdefect";
							}else if(request.getParameter(defect_no_temp).equals("2")){
								def="notedefect";
							}
							if(!def.equals("")){
								//获得异常信息
								//String product_4_start_temp="product_4_"+def+"_start"+i;
								String product_4_start=request.getParameter("product_4_start"+i);
								//String product_4_sharp_temp="product_4_"+def+"_sharp"+i;
								String product_4_sharp=request.getParameter("product_4_sharp"+i);
								//String product_4_size_temp="product_4_"+def+"_size"+i;
								String product_4_size=request.getParameter("product_4_size"+i);
								//String product_4_content_temp="product_4_"+def+"_content"+i;
								String product_4_content=request.getParameter("product_4_content"+i);
								//String product_4_content_other_temp="product_4_"+def+"_content_other";
								String product_4_content_other=request.getParameter("product_4_content_other"+i);
								if(def.equals("workdefect")){
									sql_ok="INSERT INTO product_4_info "
										+"(product_id,product_4_weather,product_4_temperature,product_4_humidity,product_4_width,"
										+"product_4_before_thickness,product_4_after_thickness,product_4_fact_length,product_4_date,product_4_time,"
										+"product_4_workdefect_start,product_4_workdefect_sharp,product_4_workdefect_size,product_4_workdefect_content,product_4_workdefect_content_other,"
										+"product_4_register,product_4_register_time,product_4_operator) VALUES ('"
										+part_id+"','"+product_4_weather+"','"+product_4_temperature+"','"+product_4_humidity+"','"+product_4_width+"','"+product_4_before_thickness+"','"
										+product_4_after_thickness+"','"+product_4_fact_length+"','"+product_4_date+"','"+product_4_time+"','"+product_4_start+"','"
										+product_4_sharp+"','"+product_4_size+"','"+product_4_content+"','"+product_4_content_other+"','"+product_4_register+"','"
										+product_4_register_time+"','"+product_4_operator+"')";
								}else if(def.equals("notedefect")){
									sql_ok="INSERT INTO product_4_info "
										+"(product_id,product_4_weather,product_4_temperature,product_4_humidity,product_4_width,"
										+"product_4_before_thickness,product_4_after_thickness,product_4_fact_length,product_4_date,product_4_time,"
										+"product_4_notedefect_start,product_4_notedefect_sharp,product_4_notedefect_size,product_4_notedefect_content,product_4_notedefect_content_other,"
										+"product_4_register,product_4_register_time,product_4_operator) VALUES ('"
										+part_id+"','"+product_4_weather+"','"+product_4_temperature+"','"+product_4_humidity+"','"+product_4_width+"','"+product_4_before_thickness+"','"
										+product_4_after_thickness+"','"+product_4_fact_length+"','"+product_4_date+"','"+product_4_time+"','"+product_4_start+"','"
										+product_4_sharp+"','"+product_4_size+"','"+product_4_content+"','"+product_4_content_other+"','"+product_4_register+"','"
										+product_4_register_time+"','"+product_4_operator+"')";
								}
							}else {
								//没有异常信息
								sql_ok="INSERT INTO product_4_info "
									+"(product_id,product_4_weather,product_4_temperature,product_4_humidity,product_4_width,"
									+"product_4_before_thickness,product_4_after_thickness,product_4_fact_length,product_4_date,product_4_time,"
									+"product_4_register,product_4_register_time,product_4_operator) VALUES ('"
									+part_id+"','"+product_4_weather+"','"+product_4_temperature+"','"+product_4_humidity+"','"+product_4_width+"','"+product_4_before_thickness+"','"
									+product_4_after_thickness+"','"+product_4_fact_length+"','"+product_4_date+"','"+product_4_time+"','"+product_4_register+"','"
									+product_4_register_time+"','"+product_4_operator+"')";
							}
							manufacture_db1.executeUpdate(sql_ok);
						}
					}else if(rs_all.getString("product_produce_location").equals("1")){
						product_produce_location="8mm切";
//						删除原有信息表信息
						String sql_del="delete from product_8mm_info where product_id in (select id from product_info where father_product_id='"+id+"')";
						manufacture_db1.executeUpdate(sql_del);
						String product_8mm_weather=request.getParameter("product_8mm_weather");
						String product_8mm_temperature=request.getParameter("product_8mm_temperature");
						String product_8mm_humidity=request.getParameter("product_8mm_humidity");
						String product_8mm_register=request.getParameter("product_8mm_register");
						String product_8mm_register_time=request.getParameter("product_8mm_register_time");
						String product_8mm_operator=request.getParameter("product_8mm_operator");
						String product_8mm_date=request.getParameter("product_8mm_date");
						String product_8mm_time=request.getParameter("product_8mm_time");
					
						for(int i=1;i<21;i++){
							String part_id_temp="part_id"+i;
							String part_id=request.getParameter(part_id_temp);
							String product_8mm_fact_length_temp="product_8mm_fact_length"+i;
							String product_8mm_fact_length=request.getParameter(product_8mm_fact_length_temp);
							String product_8mm_fact_width_temp="product_8mm_fact_width"+i;
							String product_8mm_fact_width=request.getParameter(product_8mm_fact_width_temp);
							String product_8mm_paper_exterior_temp="product_8mm_paper_exterior"+i;
							String product_8mm_paper_exterior=request.getParameter(product_8mm_paper_exterior_temp);
							String product_8mm_paper_exterior_other_temp="product_8mm_paper_exterior_other"+i;
							String product_8mm_paper_exterior_other=request.getParameter(product_8mm_paper_exterior_other_temp);
							String product_8mm_volume_exterior_temp="product_8mm_volume_exterior"+i;
							String product_8mm_volume_exterior=request.getParameter(product_8mm_volume_exterior_temp);
							String product_8mm_volume_exterior_other_temp="product_8mm_volume_exterior_other"+i;
							String product_8mm_volume_exterior_other=request.getParameter(product_8mm_volume_exterior_other_temp);
							String product_8mm_defect_temp="product_8mm_defect"+i;
							String product_8mm_defect=request.getParameter(product_8mm_defect_temp);
							String product_8mm_defect_other_temp="product_8mm_defect_other"+i;
							String product_8mm_defect_other=request.getParameter(product_8mm_defect_other_temp);
							String product_8mm_peel_temp="product_8mm_peel"+i;
							String product_8mm_peel=request.getParameter(product_8mm_peel_temp);
							
							String sql_ok="INSERT product_8mm_info (product_id,product_8mm_weather,product_8mm_temperature,product_8mm_humidity,"
								+"product_8mm_fact_length,product_8mm_fact_width,product_8mm_paper_exterior,product_8mm_paper_date,product_8mm_paper_time,"
								+"product_8mm_paper_exterior_other,product_8mm_volume_exterior,product_8mm_volume_exterior_other,product_8mm_defect,product_8mm_defect_other,product_8mm_peel,"
								+"product_8mm_register,product_8mm_register_time,product_8mm_operator) VALUES ('"
								+part_id+"','"+product_8mm_weather+"','"+product_8mm_temperature+"','"+product_8mm_humidity+"','"+product_8mm_fact_length+"','"
								+product_8mm_fact_width+"','"+product_8mm_paper_exterior+"','"+product_8mm_date+"','"+product_8mm_time+"','"
								+product_8mm_paper_exterior_other+"','"+product_8mm_volume_exterior+"','"+product_8mm_volume_exterior_other+"','"+product_8mm_defect+"','"+product_8mm_defect_other+"','"
								+product_8mm_peel+"','"+product_8mm_register+"','"+product_8mm_register_time+"','"+product_8mm_operator+"')";
							manufacture_db1.executeUpdate(sql_ok);
						}
						
						
						
					}else if(rs_all.getString("product_produce_location").equals("2")){
						product_produce_location="打孔";
//						删除原有信息表信息
						String sql_del="delete from product_hole_info where product_id in (select id from product_info where father_product_id='"+id+"')";
						manufacture_db1.executeUpdate(sql_del);
						ValidataNumber validata = new ValidataNumber();
						//基本信息
						String product_final_lot_no=request.getParameter("product_final_lot_no");
						String product_hole_temperature=request.getParameter("product_hole_temperature");
						String product_hole_humidity=request.getParameter("product_hole_humidity");
						String product_hole_register=request.getParameter("product_hole_register");
						String product_hole_register_time=request.getParameter("product_hole_register_time");
						String product_hole_operator=request.getParameter("product_hole_operator");
						String mold_style=request.getParameter("mold_style");
						String mold_size_length=request.getParameter("mold_size_length");
						String mold_size_width=request.getParameter("mold_size_width");
						String product_hole_date=request.getParameter("product_hole_date");//获得打孔加工日期
						//获得产品信息表id
						String sql_pro_id="select id,product_lot_no from product_info where product_lot_no='"+product_final_lot_no+"'";
						ResultSet rs_pro_id=manufacture_db1.executeQuery(sql_pro_id);
						String pro_id="";
						if(rs_pro_id.next()){
							pro_id=rs_pro_id.getString("id");
						}
						
						//
						String product_hole_num=request.getParameter("product_hole_num");
						String product_hole_time=request.getParameter("product_hole_time");
						String product_dust_clean=request.getParameter("product_dust_clean");
						String product_needle_status=request.getParameter("product_needle_status");
						
						String product_needle_content=request.getParameter("product_needle_content");
						if(product_needle_content==null){
							product_needle_content="0";
						}
						if(!validata.validata(product_needle_content)){
							product_needle_content="0";
						}
						String mold_hole_count=request.getParameter("mold_hole_count");
						
						String product_middle_lot_no=request.getParameter("product_middle_lot_no");
						String prodcut_middle_length=request.getParameter("prodcut_middle_length");
						String product_middle_width=request.getParameter("product_middle_width");
						String product_middle_thickness=request.getParameter("product_middle_thickness");
						String product_surface=request.getParameter("product_surface");
						String product_exterior=request.getParameter("product_exterior");
						String _2front_circle=request.getParameter("2front_circle");
						String _2front_square=request.getParameter("2front_square");
						String front_10P0=request.getParameter("front_10P0");
						String front_E=request.getParameter("front_E");
						String front_burn=request.getParameter("front_burn");
						String stop_damage=request.getParameter("stop_damage");
						String stop_length=request.getParameter("stop_length");
						if(stop_length.equals("")){
							stop_length="0";
						}
						if(!validata.validata(stop_length)){
							stop_length="0";
						}
						String final_status=request.getParameter("final_status");
						String final_particles=request.getParameter("final_particles");
						String final_particles_content=request.getParameter("final_particles_content");
						if(final_particles_content==null){
							final_particles_content="0";
						}
						if(!validata.validata(final_particles_content)){
							final_particles_content="0";
						}
						String _2back_circle=request.getParameter("2back_circle");
						String _2back_square=request.getParameter("2back_square");
						
						String back_10P0=request.getParameter("back_10P0");
						String back_E=request.getParameter("back_E");
						String back_burn=request.getParameter("back_burn");
						String check_surface=request.getParameter("check_surface");
						String check_exterior=request.getParameter("check_exterior");
						String check_hole_repeat=request.getParameter("check_hole_repeat");
						String check_flatness=request.getParameter("check_flatness");
						String check_error_result=request.getParameter("check_error_result");
						String check_hole_count=request.getParameter("check_hole_count");
						if(check_hole_count.equals("")){
							check_hole_count="0";
						}
						if(!validata.validata(check_hole_count)){
							check_hole_count="0";
						}
						String product_final_length=request.getParameter("product_final_length");
						String check_result=request.getParameter("check_result");
						
						String sql_ok="INSERT INTO product_hole_info (product_id,product_final_lot_no,mold_style_id,mold_size_length,mold_size_width,"
							+"product_hole_temperature,product_hole_humidity,product_hole_num,product_hole_time,product_dust_clean,product_needle_status,"
							+"product_needle_content,product_middle_lot_no,prodcut_middle_length,product_middle_width,product_middle_thickness,product_surface,"
							+"product_exterior,2front_circle,2front_square,front_10P0,front_E,front_burn,stop_damage,stop_length,final_status,final_particles,"
							+"final_particles_content,2back_circle,2back_square,back_10P0,back_E,back_burn,check_surface,check_exterior,check_hole_repeat,"
							+"check_flatness,check_error_result,check_hole_count, product_final_length,check_result,product_hole_register,product_hole_register_time,"
							+"product_hole_operator,mold_hole_count,product_hole_date) VALUES ("
							+"'"+pro_id+"','"+product_final_lot_no+"','"+mold_style+"','"+mold_size_length+"','"+mold_size_width+"','"+product_hole_temperature+"','"
							+product_hole_humidity+"','"+product_hole_num+"','"+product_hole_time+"','"+product_dust_clean+"','"+product_needle_status+"','"
							+product_needle_content+"','"+product_middle_lot_no+"','"+prodcut_middle_length+"','"+product_middle_width+"','"+product_middle_thickness+"','"
							+product_surface+"','"+product_exterior+"','"+_2front_circle+"','"+_2front_square+"','"+front_10P0+"','"+front_E+"','"+front_burn+"','"
							+stop_damage+"','"+stop_length+"','"+final_status+"','"+final_particles+"','"+final_particles_content+"','"+_2back_circle+"','"+_2back_square+"','"
							+back_10P0+"','"+back_E+"','"+back_burn+"','"+check_surface+"','"+check_exterior+"','"+check_hole_repeat+"','"+check_flatness+"','"
							+check_error_result+"','"+check_hole_count+"','"+product_final_length+"','"+check_result+"','"+product_hole_register+"','"
							+product_hole_register_time+"','"+product_hole_operator+"','"+mold_hole_count+"','"+product_hole_date+"')";
						manufacture_db1.executeUpdate(sql_ok);
						String product_mold_spec=request.getParameter("mold_style_spec");
						//更新产品信息表的模具规格
						String sql_update="update product_info set product_mold_spec='"+product_mold_spec+"' where id="+id;
						manufacture_db1.executeUpdate(sql_update);
						//机器累计打孔数更新
//						String product_machine=request.getParameter("product_machine");
//						String sql_mold="update mold_info set mold_hole_count=mold_hole_count+1 where mold_machine_number="+product_machine;
//						manufacture_db1.executeUpdate(sql_mold);
					
					}
				}
				manufacture_db1.commit();
				manufacture_db.close();
				manufacture_db1.close();
				response.sendRedirect("manufacture/procedure/change_ok_a.jsp");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	/**
	 * 产品信息登记审核
	 * @param request
	 * @param response
	 */
	public void check(HttpServletRequest request, HttpServletResponse response){
		HttpSession dbSession=request.getSession();
		JspFactory _jspxFactory=JspFactory.getDefaultFactory();
		
		ServletContext dbApplication=dbSession.getServletContext();
		ServletContext application;
		HttpSession session=request.getSession();
		
		nseer_db_backup1 manufacture_db= new nseer_db_backup1(dbApplication);
		nseer_db_backup1 manufacture_db1= new nseer_db_backup1(dbApplication);
		
		
		
		if(manufacture_db.conn((String) dbSession.getAttribute("unit_db_name"))&&manufacture_db1.conn((String) dbSession.getAttribute("unit_db_name"))){
			String id=request.getParameter("id");
			String checker=request.getParameter("checker");
			String checker_time=request.getParameter("checker_time");
			String sql_all="select id,product_type,father_product_id from product_info where father_product_id="+id;
			ResultSet rs_all=manufacture_db.executeQuery(sql_all);
			String sql_ckeck="";
			try {
				while(rs_all.next()){
					if(rs_all.getString("product_type").equals("1")){
						//4
						sql_ckeck="update product_4_info set product_4_checker='"+checker+"',product_4_checker_time='"+checker_time+"' where product_id="+rs_all.getString("id");
					}else if(rs_all.getString("product_type").equals("2")){ 
						//8
						sql_ckeck="update product_8mm_info set product_8mm_checker='"+checker+"',product_8mm_checker_time='"+checker_time+"' where product_id="+rs_all.getString("id");
					}else if(rs_all.getString("product_type").equals("3")){
						//打孔
						sql_ckeck="update product_hole_info set product_hole_checker='"+checker+"',product_hole_checker_time='"+checker_time+"' where product_id="+rs_all.getString("id");
					}
					manufacture_db1.executeUpdate(sql_ckeck);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		
		}
		try {
			manufacture_db1.commit();
			manufacture_db.close();
			manufacture_db1.close();
			response.sendRedirect("manufacture/procedure/check_ok_a.jsp");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 产品信息登记审核不通过
	 * @param request
	 * @param response
	 */
	public void del(HttpServletRequest request, HttpServletResponse response){
		HttpSession dbSession=request.getSession();
		JspFactory _jspxFactory=JspFactory.getDefaultFactory();
		
		ServletContext dbApplication=dbSession.getServletContext();
		ServletContext application;
		HttpSession session=request.getSession();
		
		nseer_db_backup1 manufacture_db= new nseer_db_backup1(dbApplication);
		nseer_db_backup1 manufacture_db1= new nseer_db_backup1(dbApplication);
		
		
		
		if(manufacture_db.conn((String) dbSession.getAttribute("unit_db_name"))&&manufacture_db1.conn((String) dbSession.getAttribute("unit_db_name"))){
			String id=request.getParameter("id");
			String sql_all="select id,product_type,father_product_id from product_info where father_product_id="+id;
			ResultSet rs_all=manufacture_db.executeQuery(sql_all);
			String sql_ckeck="";
			try {
				while(rs_all.next()){
					if(rs_all.getString("product_type").equals("1")){
						//4
						sql_ckeck="delete from product_4_info where product_id="+rs_all.getString("id");
					}else if(rs_all.getString("product_type").equals("2")){ 
						//8
						sql_ckeck="delete from product_8mm_info where product_id="+rs_all.getString("id");
					}else if(rs_all.getString("product_type").equals("3")){
						//打孔
						sql_ckeck="delete from product_hole_info where product_id="+rs_all.getString("id");
					}
					manufacture_db1.executeUpdate(sql_ckeck);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		try {
			manufacture_db1.commit();
			manufacture_db.close();
			manufacture_db1.close();
			response.sendRedirect("manufacture/procedure/check_ok_a.jsp");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}