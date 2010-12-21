package manufacture.plan;

import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;

import magic.action.Action;

/**
 * lixiaodong 
 * @author Administrator
 * 生产计划管理
 */
public class ActionPlan extends Action{
	/**
	 * 添加生产计划
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
		String page_m="";//记录跳转页面
		//数据库连接成功
		try{
		if(manufacture_db.conn((String) dbSession.getAttribute("unit_db_name"))&&manufacture_db1.conn((String) dbSession.getAttribute("unit_db_name"))){
			//生成计划id
			//String plan_id=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
			//页面值获取
			String plan_id=request.getParameter("plan_id");//计划编号
			String plan_type =request.getParameter("plan_type");//产品类型
			if(plan_type.equals("1")){
				
				page_m="quarter_produce";
			}else if(plan_type.equals("2")){//8mm切
				
				page_m="8mm_produce";
			}else if(plan_type.equals("3")){//打孔
				
				page_m="drilling_produce";
			}
			String sql_plan_id="select id from product_plan where C_DEFINE1='0' and plan_id='"+plan_id+"'";
			ResultSet rs_plan_id=manufacture_db.executeQuery(sql_plan_id);
			if(rs_plan_id.next()){
				plan_type="false";//no重复
			}
			if(!plan_type.equals("false")){
			String plan_maker = request.getParameter("plan_maker");//制定人
			String plan_class=request.getParameter("plan_class");//班次
			String plan_register = request.getParameter("plan_register");//登记人
			String plan_register_time = request.getParameter("plan_register_time");//登记时间
			String plan_remark = request.getParameter("plan_remark");//备注
			String plan_no=request.getParameter("plan_no");//编码
			String plan_make_time=request.getParameter("plan_make_time");
			String add_id="";
			//操作product_plan表
			
			String sql="show table status where name= 'product_plan'";

			ResultSet rs=manufacture_db.executeQuery(sql);

			if(rs.next()){
				add_id=rs.getString("Auto_increment");
			}else{
				add_id="";
			}
			String sql_insert="insert `product_plan` (`plan_id`, `plan_type`, `plan_class`, `plan_maker`, `plan_register`, `plan_register_time`, `plan_remark`,plan_no,plan_make_time) VALUES ('"
				+plan_id+"', '"+plan_type+"', '"+plan_class+"', '"+plan_maker+"', '"+plan_register+"', '"+plan_register_time+"', '"+plan_remark+"','"+plan_no+"','"+plan_make_time+"')";
			manufacture_db.executeUpdate(sql_insert);
			//4分切
			if(plan_type.equals("1")){
				
				String[] product_spec_s=request.getParameterValues("product_name");//原纸规格
				//String[] product_spec_id_s=request.getParameterValues("product_spec_id");//原纸规格id
				String[] plan_count_s=request.getParameterValues("product_describe_ok");//原纸数量
				String[] plan_count_m=request.getParameterValues("product_ID");//原料数量
				//数量判断
				/*
				for(int i=0;i<product_spec_s.length;i++){
					int num_m=Integer.parseInt(plan_count_m[i]);
					int num_s=Integer.parseInt(plan_count_s[i]);
					if(num_s>num_m){
						//数量错误页面
						response.sendRedirect("manufacture/plan/register_ok_b.jsp?page_m="+page_m);
						
					}
				}*/
				//操作plan_4_detail表
				for(int i=0;i<product_spec_s.length;i++){
					if(!product_spec_s[i].trim().equals("")){
					String sql_spec_id="SELECT id,product_name from design_file where product_name='"+product_spec_s[i]+"'";
					ResultSet rs_spec_id=manufacture_db1.executeQuery(sql_spec_id);
					String specid="";//规格编号
					
					if(rs_spec_id.next()){
						specid=rs_spec_id.getString("id");
					}
					
					
					sql_insert="insert plan_4_detail (plan_id,product_spec,plan_count,product_spec_id) values ('"+add_id+"','"+product_spec_s[i]+"','"+plan_count_s[i]+"','"+specid+"')";
					manufacture_db.executeUpdate(sql_insert);
					}
				}
			}else if(plan_type.equals("2")){//8mm切
				
				String[] product_spec_s=request.getParameterValues("product_name");//纸规格
				//String[] product_spec_id_s=request.getParameterValues("product_spec_id");//原纸规格id
				String[] plan_package_count_s=request.getParameterValues("product_ID");//计划包装数量
				String[] plan_package_client_s=request.getParameterValues("product_describe");//客户id
				String[] plan_produce_count_s=request.getParameterValues("amount");//计划打孔数量
				String[] plan_count_m=request.getParameterValues("cost_price");//原料数量
				//数量判断
				/*
				for(int i=0;i<product_spec_s.length;i++){
					int num_m=Integer.parseInt(plan_count_m[i]);
					int num_s=Integer.parseInt(plan_produce_count_s[i])+Integer.parseInt(plan_package_count_s[i]);
					num_s=(int)(num_s/20);
					if(num_s>num_m){
						//数量错误页面
						response.sendRedirect("manufacture/plan/register_ok_b.jsp?page_m="+page_m);
					}
				}*/
				//操作plan_8mm_detail
				for(int i=0;i<product_spec_s.length;i++){
					if(!product_spec_s[i].trim().equals("")){
					String sql_spec_id="SELECT id,product_name from design_file where product_name='"+product_spec_s[i]+"'";
					ResultSet rs_spec_id=manufacture_db1.executeQuery(sql_spec_id);
					String specid="";//规格编号
					
					if(rs_spec_id.next()){
						specid=rs_spec_id.getString("id");
					}
					
					sql_insert="insert plan_8mm_detail " +
							"(plan_id,product_spec,plan_package_count,plan_package_client,plan_produce_count,product_spec_id)" +
							" values " +
							"('"+add_id+"','"+product_spec_s[i]+"','"+plan_package_count_s[i]+
							"','"+plan_package_client_s[i]+"','"+plan_produce_count_s[i]+"','"+specid+"')";
					manufacture_db.executeUpdate(sql_insert);
					}
				}
				
			}else if(plan_type.equals("3")){//打孔
				
				String[] product_spec_s=request.getParameterValues("product_name");//纸规格
				//String[] product_spec_id_s=request.getParameterValues("product_spec_id");//原纸规格id
				String[] mold_id_s=request.getParameterValues("mold_id");//计划包装数量
				String[] machine_count_s=request.getParameterValues("product_describe2");//计划设备数
				String[] product_count_s=request.getParameterValues("amount");//生产数量
				String[] plan_package_client_s=request.getParameterValues("plan_package_client");//客户
				String[] plan_count_m=request.getParameterValues("cost_price");//原料数量
				//数量判断
				/*
				for(int i=0;i<product_spec_s.length;i++){
					int num_m=Integer.parseInt(plan_count_m[i]);
					int num_s=Integer.parseInt(product_count_s[i]);
					
					if(num_s>num_m){
						//数量错误页面
						response.sendRedirect("manufacture/plan/register_ok_b.jsp?page_m="+page_m);
					}
				}
				*/
				//操作plan_hole_detail
				for(int i=0;i<product_spec_s.length;i++){
					if(!product_spec_s[i].trim().equals("")){
					String sql_spec_id="SELECT id,product_name from design_file where product_name='"+product_spec_s[i]+"'";
					ResultSet rs_spec_id=manufacture_db1.executeQuery(sql_spec_id);
					String specid="";//规格编号
					
					if(rs_spec_id.next()){
						specid=rs_spec_id.getString("id");
					}
					
					sql_insert="insert plan_hole_detail (plan_id,product_spec,mold_id,machine_count,product_count,plan_package_client,product_spec_id) values ('"
						+add_id+"','"+product_spec_s[i]+"','"+mold_id_s[i]+"','"+machine_count_s[i]+"','"+product_count_s[i]+"','"+plan_package_client_s[i]+"','"+specid+"')";
					manufacture_db.executeUpdate(sql_insert);
					}
				}
			}

				//manufacture_db1.close();
				//manufacture_db.commit();
				//manufacture_db.close();


				response.sendRedirect("manufacture/plan/register_ok_a.jsp?page_m="+page_m);

		}else{
			response.sendRedirect("manufacture/plan/register_ok_c.jsp?page_m="+page_m);
		}
			
			manufacture_db1.close();
			manufacture_db.commit();
			manufacture_db.close(); // add by wangshaolin 2010 11 16
		}
		}catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	/**
	 * 审核生产计划
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
//		数据库连接成功
		if(manufacture_db.conn((String) dbSession.getAttribute("unit_db_name"))){
			//生成计划id
			String id=request.getParameter("id");//计划id
			//页面值获取
			String plan_checker=request.getParameter("plan_checker");//审核人
			String plan_check_time =request.getParameter("plan_check_time");//审核时间
			
			//操作product_plan表
			String sql_update="update `product_plan` set plan_check_tag=1,plan_checker='"+plan_checker+"',plan_check_time='"+plan_check_time+"' where id="+id;
			manufacture_db.executeUpdate(sql_update);
			
			
			try {
				manufacture_db.commit();
				manufacture_db.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				response.sendRedirect("manufacture/plan/check_ok.jsp?finished_tag=0");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	/**
	 * 审核不通过生产计划
	 * @param request
	 * @param response
	 */
	public void delete(HttpServletRequest request, HttpServletResponse response){
		HttpSession dbSession=request.getSession();
		JspFactory _jspxFactory=JspFactory.getDefaultFactory();
		
		ServletContext dbApplication=dbSession.getServletContext();
		ServletContext application;
		HttpSession session=request.getSession();
		
		nseer_db_backup1 manufacture_db= new nseer_db_backup1(dbApplication);
//		数据库连接成功
		if(manufacture_db.conn((String) dbSession.getAttribute("unit_db_name"))){
			//生成计划id
			String id=request.getParameter("id");//计划id
			//页面值获取
			String choice=request.getParameter("choice");//审核人
			
			
			//操作product_plan表(修改check_tag为2，作为审核不通过标记)
			String sql_update="update `product_plan` set plan_check_tag=2,plan_checker='',plan_check_time='' where id="+id;
			manufacture_db.executeUpdate(sql_update);
			
			
			try {
				manufacture_db.commit();
				manufacture_db.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				response.sendRedirect("manufacture/plan/check_ok.jsp?finished_tag=0");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	/**
	 * 修改生产计划
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
		try{
		//数据库连接成功
		if(manufacture_db.conn((String) dbSession.getAttribute("unit_db_name"))&&manufacture_db1.conn((String) dbSession.getAttribute("unit_db_name"))){
			//生成计划id
			String id=request.getParameter("id");//计划id
			String plan_id=request.getParameter("plan_id");//计划编号
			String plan_type =request.getParameter("plan_type");//产品类型
			String plan_maker = request.getParameter("plan_maker");//制定人
			String plan_class=request.getParameter("plan_class");//班次
			String plan_register = request.getParameter("plan_register");//登记人
			String plan_register_time = request.getParameter("plan_register_time");//登记时间
			String plan_remark = request.getParameter("plan_remark");//备注
			String plan_no=request.getParameter("plan_no");//编码
			String plan_make_time=request.getParameter("plan_make_time");
			String page_m="";
			if(plan_type.equals("1")){
				
				page_m="change_list";
			}else if(plan_type.equals("2")){//8mm切
				
				page_m="change_list";
			}else if(plan_type.equals("3")){//打孔
				
				page_m="change_list";
			}
			
			if(!plan_type.equals("false")){
			//操作product_plan表
			String sql_update="update `product_plan` set plan_check_tag=0,plan_id='"
				+plan_id+"',plan_maker='"
				+plan_maker+"',plan_class='"+plan_class+"',plan_remark='"
				+plan_remark+"',plan_no='"+plan_no+"',plan_make_time='"+plan_make_time+"' where id="+id;
			manufacture_db.executeUpdate(sql_update);
			
//			4分切
			if(plan_type.equals("1")){
				sql_update="delete from plan_4_detail where plan_id='"+id+"'";
				manufacture_db.executeUpdate(sql_update);
				String[] product_spec_s=request.getParameterValues("product_name");//原纸规格
				//String[] product_spec_id_s=request.getParameterValues("product_spec_id");//原纸规格id
				String[] plan_count_s=request.getParameterValues("product_describe_ok");//原纸数量
				//操作plan_4_detail表
				for(int i=0;i<product_spec_s.length;i++){
					if(!product_spec_s[i].equals("")){
					String sql_spec_id="SELECT id,product_name from design_file where product_name='"+product_spec_s[i]+"'";
					ResultSet rs_spec_id=manufacture_db1.executeQuery(sql_spec_id);
					String specid="";//规格编号
					try {
						if(rs_spec_id.next()){
							specid=rs_spec_id.getString("id");
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					sql_update="insert plan_4_detail (plan_id,product_spec,plan_count,product_spec_id) values ('"+id+"','"+product_spec_s[i]+"','"+plan_count_s[i]+"','"+specid+"')";
					manufacture_db.executeUpdate(sql_update);
					}
				}
			}else if(plan_type.equals("2")){//8mm切
				sql_update="delete from plan_8mm_detail where plan_id='"+id+"'";
				manufacture_db.executeUpdate(sql_update);
				String[] product_spec_s=request.getParameterValues("product_name");//纸规格
				//String[] product_spec_id_s=request.getParameterValues("product_spec_id");//原纸规格id
				String[] plan_package_count_s=request.getParameterValues("product_ID");//计划包装数量
				String[] plan_package_client_s=request.getParameterValues("product_describe");//客户id
				String[] plan_produce_count_s=request.getParameterValues("amount");//计划打孔数量
				//操作plan_8mm_detail
				for(int i=0;i<product_spec_s.length;i++){
					if(!product_spec_s[i].equals("")){
					String sql_spec_id="SELECT id,product_name from design_file where product_name='"+product_spec_s[i]+"'";
					ResultSet rs_spec_id=manufacture_db1.executeQuery(sql_spec_id);
					String specid="";//规格编号
					try {
						if(rs_spec_id.next()){
							specid=rs_spec_id.getString("id");
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					sql_update="insert plan_8mm_detail (plan_id,product_spec,plan_package_count,plan_package_client,plan_produce_count,product_spec_id) values ('"+id+"','"+product_spec_s[i]+"','"+plan_package_count_s[i]+"','"+plan_package_client_s[i]+"','"+plan_produce_count_s[i]+"','"+specid+"')";
					manufacture_db.executeUpdate(sql_update);
					}
				}
				
			}else if(plan_type.equals("3")){//打孔
				sql_update="delete from plan_hole_detail where plan_id='"+id+"'";
				manufacture_db.executeUpdate(sql_update);
				String[] product_spec_s=request.getParameterValues("product_name");//纸规格
				//String[] product_spec_id_s=request.getParameterValues("product_spec_id");//原纸规格id
				String[] mold_id_s=request.getParameterValues("mold_id");//计划包装数量
				String[] machine_count_s=request.getParameterValues("product_describe2");//计划设备数
				String[] product_count_s=request.getParameterValues("amount");//生产数量
				String[] plan_package_client_s=request.getParameterValues("plan_package_client");//客户
				String[] plan_count_m=request.getParameterValues("cost_price");//原料数量
				//操作plan_hole_detail
				for(int i=0;i<product_spec_s.length;i++){
					if(!product_spec_s[i].equals("")){
					String sql_spec_id="SELECT id,product_name from design_file where product_name='"+product_spec_s[i]+"'";
					ResultSet rs_spec_id=manufacture_db1.executeQuery(sql_spec_id);
					String specid="";//规格编号
					try {
						if(rs_spec_id.next()){
							specid=rs_spec_id.getString("id");
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					sql_update="insert plan_hole_detail (plan_id,product_spec,mold_id,machine_count,product_count,plan_package_client,product_spec_id) values ('"
						+id+"','"+product_spec_s[i]+"','"+mold_id_s[i]+"','"+machine_count_s[i]+"','"+product_count_s[i]+"','"+plan_package_client_s[i]+"','"+specid+"')";
					manufacture_db.executeUpdate(sql_update);
					}
				}
			}
			
				//manufacture_db1.close();
				//manufacture_db.commit();
				//manufacture_db.close();
			
				response.sendRedirect("manufacture/plan/change_ok_a.jsp");
			}else{
				response.sendRedirect("manufacture/plan/register_ok_c.jsp?page_m="+page_m);
			}
			manufacture_db1.close();
			manufacture_db.commit();
			manufacture_db.close();  // add by wangshaolin 
			
		}
		}catch (Exception e) {
			
			e.printStackTrace();
		}
	}
	/**
	 * 审核不通过生产计划
	 * @param request
	 * @param response
	 */
	public void delPlan(HttpServletRequest request, HttpServletResponse response){
		HttpSession dbSession=request.getSession();
		JspFactory _jspxFactory=JspFactory.getDefaultFactory();
		
		ServletContext dbApplication=dbSession.getServletContext();
		ServletContext application;
		HttpSession session=request.getSession();
		
		nseer_db_backup1 manufacture_db= new nseer_db_backup1(dbApplication);
		try {
//		数据库连接成功
		if(manufacture_db.conn((String) dbSession.getAttribute("unit_db_name"))){
			//生成计划id
			String id=request.getParameter("id");//计划id
			//页面值获取
			
			
			
			//操作product_plan表(修改C_DEFINE1为1，作为删除标记)
			String sql_update="update `product_plan` set C_DEFINE1='1' where id="+id;
			manufacture_db.executeUpdate(sql_update);
			String plan_type=request.getParameter("plan_type");
			String sql_update_details="";
			if(plan_type.equals("1")){
				sql_update_details="update `plan_4_detail` set C_DEFINE1='1' where plan_id="+id;
			}else if(plan_type.equals("2")){
				sql_update_details="update `plan_8mm_detail` set C_DEFINE1='1' where plan_id="+id;
			}else if(plan_type.equals("3")){
				sql_update_details="update `plan_hole_detail` set C_DEFINE1='1' where plan_id="+id;
			}
			manufacture_db.executeUpdate(sql_update_details);
			
			
				manufacture_db.commit();
				manufacture_db.close();
				
			
			
				response.sendRedirect("manufacture/plan/del_ok.jsp");
		}
		
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	}
}
