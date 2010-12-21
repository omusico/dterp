package mold.reuse;

import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import magic.action.Action;

public class ActionReuse extends Action {
	public void reuse(HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException {
		nseer_db_backup1 db = null;
		try {
			HttpSession dbSession = request.getSession();
			ServletContext dbApplication = dbSession.getServletContext();

			ServletContext application;
			HttpSession session = request.getSession();
			db = new nseer_db_backup1(dbApplication);
			if (db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String id=request.getParameter("id");
				String sql = "DELETE FROM mold_destruction WHERE mold_id = '"
					+ id + "'";
					db.executeUpdate(sql);
					sql = "DELETE FROM mold_destruction_pic WHERE mold_id = '" + id
					+ "'";
					db.executeUpdate(sql);
					sql = "update mold_info set mold_life_status =4,destruction_man='',destruction_time='' WHERE id = '"
					+ id + "'";
					db.executeUpdate(sql);
					String sql3="update mold_info set mold_location ='3',mold_machine_number=0,installer='',installation_time='' WHERE id = '"+id+"'";
					db.executeUpdate(sql3);
					
					// 跳转页面
					String path= request.getContextPath();
					response.sendRedirect(path+"/mold/reuse/reuse_list.jsp");

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
