package stock.analyse;

import java.io.IOException;
import java.sql.SQLException;

import include.nseer_db.nseer_db_backup1;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;

import magic.action.Action;

public class ActionAnalyse extends Action {
	public void relation(HttpServletRequest request, HttpServletResponse response){
		HttpSession dbSession=request.getSession();
		JspFactory _jspxFactory=JspFactory.getDefaultFactory();
		
		ServletContext dbApplication=dbSession.getServletContext();
		ServletContext application;
		HttpSession session=request.getSession();
		
		nseer_db_backup1 manufacture_db= new nseer_db_backup1(dbApplication);
		if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){
		try {
			String product_temp_pallet=request.getParameter("product_temp_pallet");
			String scene_pallet=request.getParameter("scene_pallet");
			String sql_relat="update product_info set scene_pallet='"+scene_pallet+
			"' where product_temp_pallet='"+product_temp_pallet+"'";
			manufacture_db.executeUpdate(sql_relat);
			
			manufacture_db.commit();
			manufacture_db.close();
			response.sendRedirect("stock/analyse/relationship_ok.jsp");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
	}
}
