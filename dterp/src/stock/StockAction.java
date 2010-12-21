package stock;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import include.nseer_db.nseer_db_backup1;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;

import magic.action.Action;

public class StockAction extends Action {
	//包装信息查询 解散
	public void doUpdate(HttpServletRequest request, HttpServletResponse response){
		nseer_db_backup1 security_db=null;
		
		try {
		HttpSession dbSession=request.getSession();
		ServletContext dbApplication=dbSession.getServletContext();
		 security_db= new nseer_db_backup1(dbApplication);
		 nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);// baseDao通用组件，里面封闭有对数据库操作的方法
		 String id=request.getParameter("id");
		if(security_db.conn((String) dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String) dbSession.getAttribute("unit_db_name"))){
	
		String select_sql="update package_info set is_dissolve=1 where id='"+id+"'";
		
		security_db.executeUpdate(select_sql);
		
		String sql2="";
		
		select_sql = "select product_lot_no from product_info where package_id='"+id+"'";
		ResultSet rs = stock_db.executeQuery(select_sql);
		String stock_id= "";//lotNo号
			while(rs.next()){
				 stock_id=rs.getString(1);
				 String[] stock_s = stock_id.split("-");
				 int s= stock_s.length;
			if(s==7){
				 sql2="update product_info set package_id=0,product_stock='temp',stock_id=107,stock_name='生纸带包装库' where package_id='"+id+"'";
			}else{
				 sql2="update product_info set package_id=0,product_stock='temp',stock_id=108,stock_name='打孔纸带包装库' where package_id='"+id+"'";
			}
				security_db.executeUpdate(sql2);
			}

			security_db.commit();
		
		response.sendRedirect("stock/analyse/queryPackage_dissolve.jsp");
			
		}else{
			response.sendRedirect("error_conn.htm");
		}
		}  catch (Exception e) {
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
