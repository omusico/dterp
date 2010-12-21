package mold.order;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.sql.SQLException;

import include.nseer_db.nseer_db_backup;
import include.nseer_db.nseer_db_backup1;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import magic.action.Action;

/**
 * 模具管理
 * 
 * @author xuwei
 * 
 */
public class ActionMold extends Action {

	// protected void service(HttpServletRequest request, HttpServletResponse
	// response) {
	//		
	// String method=request.getParameter("m");
	// nseer_db_backup1 db=null;
	// try {
	// Method
	// m=this.getClass().getMethod(method,HttpServletRequest.class,HttpServletResponse.class,nseer_db_backup1.class);
	// HttpSession dbSession=request.getSession();
	// JspFactory _jspxFactory=JspFactory.getDefaultFactory();
	// PageContext pageContext =
	// _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
	// ServletContext dbApplication=dbSession.getServletContext();
	//		
	//
	// ServletContext application;
	// HttpSession session=request.getSession();
	// db = new nseer_db_backup1(dbApplication);
	// if(db.conn((String) dbSession.getAttribute("unit_db_name"))){
	// //调用方法
	// m.invoke(this,request,response,db);
	// db.commit();
	//					
	// } else {
	// db=null;
	// response.sendRedirect("error_conn.htm");
	// }
	//			
	//			
	// } catch (Exception e) {
	//			
	// e.printStackTrace();
	//			
	// }finally{
	// if(db!=null){
	// try {
	// db.close();
	// } catch (SQLException e1) {
	// // TODO Auto-generated catch block
	// e1.printStackTrace();
	// System.out.println(e1.getMessage());
	// }
	// }
	// }
	// }

	/**
	 * 模具采购
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws IOException
	 * @throws SQLException 
	 */
	public void add(HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException {
		nseer_db_backup1 db = null;
		nseer_db_backup1 purchase_db = null;
		try {
			HttpSession dbSession = request.getSession();
			ServletContext dbApplication = dbSession.getServletContext();

			ServletContext application;
			HttpSession session = request.getSession();
			db = new nseer_db_backup1(dbApplication);
			purchase_db = new nseer_db_backup1(dbApplication);
			if (db.conn((String) dbSession.getAttribute("unit_db_name"))
					&& purchase_db.conn((String) dbSession
							.getAttribute("unit_db_name"))) {

				// 获取用户输入
				String reason = request.getParameter("reason");// 经办人
				String mold_order = request.getParameter("mold_order");// 订单号!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				String demand_gather_time = request
						.getParameter("demand_gather_time");// 采购时间
				String register = request.getParameter("register");// 采购人
				String register_time = request.getParameter("register_time");// 采购时间
				// 获取模具列表
				// request.getParameter("product_name");//模具规格
				// request.getParameter("mold_code"); //模具编号
				// request.getParameter("mold_name"); //品名和规格
				// request.getParameter("mold_item");//加工项目
				// request.getParameter("mold_drawing");//图纸
				// request.getParameter("product_ID");//Id
				String code_temp[] = request.getParameterValues("mold_code");
				String product_name_tem[] = request
						.getParameterValues("product_name");
				String mold_name_temp[] = request
						.getParameterValues("mold_name");
				String mold_item_temp[] = request
						.getParameterValues("mold_item");
				String mold_drawing_temp[] = request
						.getParameterValues("mold_drawing");
				String id_temp[] = request.getParameterValues("product_ID");

				// 用于接收
				String code = "";
				String product_name = "";
				String mold_name = "";
				String mold_item = "";
				String mold_drawing = "";
				String id = "";

				for (int i = 1; i < id_temp.length; i++) {
					code = code_temp[i];
					product_name = product_name_tem[i];
					mold_name = mold_name_temp[i];
					mold_item = mold_item_temp[i];
					mold_drawing = mold_drawing_temp[i];
					id = id_temp[i];
					String sql = "insert into mold_info(mold_spec_id,mold_type,mold_spec,mold_drawing,MOLD_ID)values("
							+ id
							+ ","
							+ mold_item
							+ ",'"
							+ mold_name
							+ "','"
							+ mold_drawing + "'," + code + ")";

					db.executeUpdate(sql);

				}
			

				// 总表
				String order_id = "xy123";

				// 供货商？
				String purchase_sql = "insert into mold_purchase_order (purchase_id,purchase_operater,purchase_time,purchase_count,purchase_register,purchase_register_time)values('"
						+ order_id
						+ "','"
						+ reason
						+ "','"
						+ demand_gather_time
						+ "','"
						+ id_temp.length
						+ "','"
						+ id_temp.length
						+ "','"
						+ register
						+ "','"
						+ register
						+ "','" + register_time + "')";
				purchase_db.executeUpdate(purchase_sql);

			}// 判断是否有 连接 end
		} catch (Exception ex) {
			if(db!=null)
			{
				db.close();
			}
			if(purchase_db!=null)
			{
				purchase_db.close();
			}
			
			ex.printStackTrace();
		}finally
		{
			if(db!=null)
			{
				db.close();
			}
			if(purchase_db!=null)
			{
				purchase_db.close();
			}
		}

	}

}
