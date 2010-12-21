package manufacture.plan;


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


public class ValidatePlanNo extends HttpServlet {

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
				// 设置接收信息的字符集
				request.setCharacterEncoding("UTF-8");
				// 接收浏览器端提交的信息
				String uname = request.getParameter("uname");
				String id=request.getParameter("id");//获得计划编号
				

				// 设置输出信息的格式及字符集
				response.setContentType("text/xml; charset=UTF-8");
				response.setHeader("Cache-Control", "no-cache");
				// 创建输出流对象
				PrintWriter out = response.getWriter();
				// 依据验证结果输出不同的数据信息

				uname = getStr(uname);
				id=getStr(id);
				if(id==null){
				String sql_plan_id="select id from product_plan where C_DEFINE1='0' and plan_id='"+uname+"'";
				ResultSet rs_plan_id=crm_db.executeQuery(sql_plan_id);
				
				out.println("<response>");//start
				if (rs_plan_id.next()) {
					out.println("<res>" + "计划编号重复，请重新输入！" + "</res>");
				} else {
					out.println("<res>" + "true" + "</res>");
				}

				out.println("</response>");//end
				}else {
					String sql_plan_no="select plan_id from product_plan where C_DEFINE1='0' and id='"+id+"'";
					ResultSet rs_plan_no=crm_db.executeQuery(sql_plan_no);
					String new_no="";
					if(rs_plan_no.next()){
						new_no=rs_plan_no.getString("plan_id");
					}
					out.println("<response>");//start
					//计划编号没改变
					if(uname.equals(new_no)){
						out.println("<res>" + "true" + "</res>");
					}else{
						String sql_plan_id="select id from product_plan where C_DEFINE1='0' and plan_id='"+uname+"'";
						ResultSet rs_plan_id=crm_db.executeQuery(sql_plan_id);
						if (rs_plan_id.next()) {
							out.println("<res>" + "计划编号重复，请重新输入！" + "</res>");
						} else {
							out.println("<res>" + "true" + "</res>");
						}
					}
					out.println("</response>");//end
				}
				out.close();
				crm_db.close();
			}

		} catch (Exception ex) {
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

	/**
	 * 设置编码格式
	 * 
	 * @param str
	 * @return
	 */
	public String getStr(String str) {
		try {
			String temp_p = str;
			byte[] temp_t = temp_p.getBytes("ISO8859-1");
			String temp = new String(temp_t);
			return temp;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "NULL";
	}

}
