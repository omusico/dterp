package security.data;

import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import magic.action.Action;

public class SecurityData extends Action {
	public void doUpdate(HttpServletRequest request, HttpServletResponse response){
		nseer_db_backup1 security_db=null;
		try {
		HttpSession dbSession=request.getSession();
		ServletContext dbApplication=dbSession.getServletContext();
		 security_db= new nseer_db_backup1(dbApplication);
		if(security_db.conn((String) dbSession.getAttribute("unit_db_name"))){
		String data_4_1_1=request.getParameter("data_4_1_1");
		String data_4_1_2=request.getParameter("data_4_1_2");
		String data_4_2_1=request.getParameter("data_4_2_1");
		String data_4_2_2=request.getParameter("data_4_2_2");
		String data_8_1_1=request.getParameter("data_8_1_1");
		String data_8_1_2=request.getParameter("data_8_1_2");
		String data_8_2_1=request.getParameter("data_8_2_1");
		String data_8_2_2=request.getParameter("data_8_2_2");
		String data_hole_1_1=request.getParameter("data_hole_1_1");
		String data_hole_1_2=request.getParameter("data_hole_1_2");
		String data_hole_2_1=request.getParameter("data_hole_2_1");
		String data_hole_2_2=request.getParameter("data_hole_2_2");
		
		String select_sql="select id from security_base_data";
		
		ResultSet rs=security_db.executeQuery(select_sql);
		String id="";
		String sql2="";
		
			if(rs.next()){
				 id=rs.getString("id");
				 sql2="update security_base_data set data_4_1_1='"+data_4_1_1+"',data_4_1_2='"+data_4_1_2+"',data_4_2_1='"+data_4_2_1+"',data_4_2_2='"+data_4_2_2+"',data_8_1_1='"+data_8_1_1+"',data_8_1_2='"+data_8_1_2+"',data_8_2_1='"+data_8_2_1+"',data_8_2_2='"+data_8_2_2+"',data_hole_1_1='"+data_hole_1_1+"',data_hole_1_2='"+data_hole_1_2+"',data_hole_2_1='"+data_hole_2_1+"',data_hole_2_2='"+data_hole_2_2+"' where id='"+id+"'";
				 
			}else{
				 sql2="INSERT INTO security_base_data ( id, `data_title_41`, `data_4_1_1`, `data_4_1_2`, `data_title_42`, `data_4_2_1`, `data_4_2_2`, `data_title_81`, `data_8_1_1`, `data_8_1_2`, `data_title_82`, `data_8_2_1`, `data_8_2_2`, `data_title_hole1`, `data_hole_1_1`, `data_hole_1_2`, `data_title_hole2`, `data_hole_2_1`, `data_hole_2_2`) "+
				" VALUES ('1', '湿度', '"+data_4_1_1+"', '"+data_4_1_2+"', '温度', '"+data_4_2_1+"', '"+data_4_2_2+"', '湿度', '"+data_8_1_1+"', '"+data_8_1_2+"', '温度', '"+data_8_2_1+"', '"+data_8_2_2+"', '湿度', '"+data_hole_1_1+"', '"+data_hole_1_2+"', '温度', '"+data_hole_2_1+"', '"+data_hole_2_2+"')";
				
			}
			security_db.executeUpdate(sql2);
			response.sendRedirect("manufacture/config/change_ok.jsp");
			
	
		}else{
			response.sendRedirect("error_conn.htm");
		}
		} catch (SQLException e) {
			
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				if(security_db!=null){
					security_db.close();
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
	}
	/**
	 * 编号设置删除
	 * @param request
	 * @param response
	 */
	public void del_no(HttpServletRequest request, HttpServletResponse response){
		nseer_db_backup1 security_db=null;
	
		try {
		HttpSession dbSession=request.getSession();
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		ServletContext dbApplication=dbSession.getServletContext();
		 security_db= new nseer_db_backup1(dbApplication);
		 
		if(security_db.conn((String) dbSession.getAttribute("unit_db_name"))){

			int i;
			int intRowCount;
			String sqll = "select * from option_no";
			ResultSet rs = security_db.executeQuery(sqll);
			rs.next();
			rs.last();
			intRowCount = rs.getRow();
			String[] del = new String[intRowCount];
			del = (String[]) session.getAttribute("del");
			
			
			if (del != null) {
				for (i = 1; i <= intRowCount; i++) {
					try {
						if (del[i - 1] != null) {
							
							
							String sql = "delete from option_no where id='"
								+ del[i - 1] + "'";
							security_db.executeUpdate(sql);
							
						}
					} catch (Exception ex) {
						out.println("error" + ex);
					}
				}
			}

			
			response.sendRedirect("manufacture/config/change_no_delete_ok.jsp");
			
			security_db.commit();
			security_db.close();

		
			
			
			
			
		}else{
			response.sendRedirect("error_conn.htm");
		}
		} catch (SQLException e) {
			
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				if(security_db!=null){
					security_db.close();
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
	}
	/**
	 * 编号设置删除
	 * @param request
	 * @param response
	 */
	public void add_no(HttpServletRequest request, HttpServletResponse response){
		nseer_db_backup1 security_db=null;
	
		try {
		HttpSession dbSession=request.getSession();
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		ServletContext dbApplication=dbSession.getServletContext();
		 security_db= new nseer_db_backup1(dbApplication);
		 
		if(security_db.conn((String) dbSession.getAttribute("unit_db_name"))){
			String no_name=request.getParameter("no_name");
			String no_type=request.getParameter("no_type");
			String no_value=request.getParameter("no_value");
			String description=request.getParameter("description");
			String register=request.getParameter("register");
			String register_time=request.getParameter("register_time");
			String sql_add="insert option_no (no_name,no_type,description,register,register_time,no_value) values ('"
				+no_name+"','"+no_type+"','"+description+"','"+register+"','"+register_time+"','"+no_value+"')";
			security_db.executeUpdate(sql_add);
			response.sendRedirect("manufacture/config/change_no_register_ok.jsp");
			security_db.commit();
			security_db.close();
			
			
		}else{
			response.sendRedirect("error_conn.htm");
		}
		} catch (SQLException e) {
			
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				if(security_db!=null){
					security_db.close();
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
	}
}
