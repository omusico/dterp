package common;

import java.io.IOException;
import java.sql.SQLException;

import include.nseer_db.nseer_db_backup1;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import magic.action.Action;

public class AdAction extends Action {
	//包装信息查询 解散
	public void getAd(HttpServletRequest request, HttpServletResponse response){
		nseer_db_backup1 security_db=null;
		try {
		HttpSession dbSession=request.getSession();
		ServletContext dbApplication=dbSession.getServletContext();
		 security_db= new nseer_db_backup1(dbApplication);
		 String id=request.getParameter("id");
		if(security_db.conn((String) dbSession.getAttribute("unit_db_name"))){
	
		String sql="select * from abc";
		
		security_db.executeQuery(sql);
		
		
		response.sendRedirect("stock/analyse/queryPackage_dissolve.jsp");
			
	
		}else{
			response.sendRedirect("error_conn.htm");
		}
		}  catch (IOException e) {
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
	public void doAdd(HttpServletRequest request, HttpServletResponse response){
							
		String notice_content=request.getParameter("notice_content");					
		String is_enabled=request.getParameter("is_enabled");							
		if(is_enabled==null){
			is_enabled="0";
		}
		String notice_register=request.getParameter("notice_register");								
		String notice_register_time=request.getParameter("notice_register_time");	
		nseer_db_backup1 security_db=null;
		try {
		HttpSession dbSession=request.getSession();
		ServletContext dbApplication=dbSession.getServletContext();
		 security_db= new nseer_db_backup1(dbApplication);
		 String id=request.getParameter("id");
		if(security_db.conn((String) dbSession.getAttribute("unit_db_name"))){
	
		String sql="INSERT INTO `notice_setting` (`notice_content`, `is_enabled`, `notice_register`, `notice_register_time`) VALUES "+
				"('"+notice_content+"', '"+is_enabled+"', '"+notice_register+"', '"+notice_register_time+"')";

		
		security_db.executeUpdate(sql);
		
		
		response.sendRedirect("security/recovery/ad_manager_ok.jsp");
			
	
		}else{
			response.sendRedirect("error_conn.htm");
		}
		}  catch (IOException e) {
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
