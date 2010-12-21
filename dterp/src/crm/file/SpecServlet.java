package crm.file;

import include.get_name_from_ID.getNameFromID;
import include.nseer_cookie.Divide1;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.counter;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class SpecServlet extends HttpServlet {

	public void init(ServletConfig config) throws ServletException {
	}

	/*
	 * 处理<GET> 请求方法.
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession dbSession = request.getSession();
		
		ServletContext dbApplication = dbSession.getServletContext();
		
		try {
			// 实例化

			
			nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
			
			if (crm_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				//设置接收信息的字符集
				request.setCharacterEncoding("UTF-8");
				// 接收浏览器端提交的信息
				String cid = request.getParameter("cid");
				
				// 设置输出信息的格式及字符集
				response.setContentType("text/xml; charset=UTF-8");
				response.setHeader("Cache-Control", "no-cache");
				// 创建输出流对象
				PrintWriter out = response.getWriter();
				// 依据验证结果输出不同的数据信息
				out.println("<response>");
				String sql_name="select * from option_spec where customer_id ='"+cid+"'";
				ResultSet rs_name=crm_db.executeQuery(sql_name);
				if(rs_name.next()){
					out.println("<res>" + rs_name.getString("product_middle_thickness") + "</res>");
					out.println("<res1>" + rs_name.getString("product_middle_thickness_away") + "</res1>");
					out.println("<res2>" + rs_name.getString("front_10P0_away") + "</res2>");
					out.println("<res3>" + rs_name.getString("front_E_away") + "</res3>");
					out.println("<res4>" + rs_name.getString("back_10P0_away") + "</res4>");
					out.println("<res5>" + rs_name.getString("back_E_away") + "</res5>");
				}else{
					out.println("<res>" + "true" + "</res>");
				}
				
				out.println("</response>");
				out.close();
				crm_db.close();
				
			}
		
		}catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/*
	 * 处理<POST> 请求方法.
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}