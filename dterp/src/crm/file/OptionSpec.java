package crm.file;

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
 * 规格值设定
 */
public class OptionSpec extends Action{
	/**
	 * 规格值设定
	 * @param request
	 * @param response
	 */
	public void option(HttpServletRequest request, HttpServletResponse response){
		HttpSession dbSession=request.getSession();
		JspFactory _jspxFactory=JspFactory.getDefaultFactory();
		
		ServletContext dbApplication=dbSession.getServletContext();
		ServletContext application;
		HttpSession session=request.getSession();
		
		nseer_db_backup1 manufacture_db= new nseer_db_backup1(dbApplication);
		nseer_db_backup1 manufacture_db1= new nseer_db_backup1(dbApplication);
		
		//数据库连接成功
		try{
		if(manufacture_db.conn((String) dbSession.getAttribute("unit_db_name"))&&manufacture_db1.conn((String) dbSession.getAttribute("unit_db_name"))){}
			String customer_id=request.getParameter("customer_id");
			String product_middle_thickness=request.getParameter("product_middle_thickness");
			String product_middle_thickness_away=request.getParameter("product_middle_thickness_away");
			String front_10P0_away=request.getParameter("front_10P0_away");
			String front_E_away=request.getParameter("front_E_away");
			String back_10P0_away=request.getParameter("back_10P0_away");
			String back_E_away=request.getParameter("back_E_away");
			String plan_register=request.getParameter("register");
			String plan_register_time=request.getParameter("register_time");
			String sql_flag= "select * from option_spec where customer_id='"+customer_id+"'";
			ResultSet rs_flag=manufacture_db.executeQuery(sql_flag);
			String sql_f="";
			if(rs_flag.next()){
				sql_f="update option_spec set product_middle_thickness='"+product_middle_thickness+"',product_middle_thickness_away='"+product_middle_thickness_away+"',front_10P0_away='"
				+front_10P0_away+"',front_E_away='"+front_E_away+"',back_10P0_away='"+back_10P0_away+"',back_E_away='"+back_E_away+"',plan_register='"
				+plan_register+"',plan_register_time='"+plan_register_time+"' where customer_id='"+customer_id+"'";
			}else{
				sql_f="INSERT INTO `ondemand2`.`option_spec` (`customer_id`, `product_middle_thickness`, `product_middle_thickness_away`, `front_10P0_away`, `front_E_away`, `back_10P0_away`, `back_E_away`, `plan_register`, `plan_register_time`) VALUES "
					+"('"+customer_id+"','"+product_middle_thickness+"','"+product_middle_thickness_away+"','"+front_10P0_away+"','"+front_E_away+"','"
					+back_10P0_away+"','"+back_E_away+"','"+plan_register+"','"+plan_register_time+"');";
			}
			manufacture_db1.executeUpdate(sql_f);
			manufacture_db1.commit();
			manufacture_db.close();
			manufacture_db1.close();
			response.sendRedirect("crm/option/option_spec_ok.jsp");
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
}
