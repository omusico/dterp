package stock;

import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import magic.action.Action;

public class ActionWaste extends Action {
	public void reuse(HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException {
		nseer_db_backup1 db = null;
		try {
			HttpSession dbSession = request.getSession();
			ServletContext dbApplication = dbSession.getServletContext();
			
			
			String register=(String)dbSession.getAttribute("realeditorc");
			java.util.Date now = new java.util.Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			String time=formatter.format(now);

			ServletContext application;
			HttpSession session = request.getSession();
			db = new nseer_db_backup1(dbApplication);
			if (db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String id=request.getParameter("id");
				
				String sql="insert Into waste_info Select * From product_info where id='"
					+ id + "'";
				db.executeUpdate(sql);
				sql = "DELETE FROM product_info WHERE id = '"
					+ id + "'";
				db.executeUpdate(sql);
				//添加 删除人 删除时间
				String upSql="update waste_info set waste_info_register='"+register+"',waste_info_register_time='"+time+"' where id="+id;
				db.executeUpdate(upSql);
				
				db.commit();
					// 跳转页面
					String path= request.getContextPath();
					response.sendRedirect(path+"/stock/analyse/waste_list.jsp");

			}// 判断是否有 连接 end
		} catch (Exception ex) {
			if (db != null) {
				db.close();
			}
			

			ex.printStackTrace();
		} finally {
			if (db != null) {
				db.close();
			}
			
		}

	}
}
