package mold;

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

public class ValidateMachine extends HttpServlet {

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

				// 设置输出信息的格式及字符集
				response.setContentType("text/xml; charset=UTF-8");
				response.setHeader("Cache-Control", "no-cache");
				// 创建输出流对象
				PrintWriter out = response.getWriter();
				// 依据验证结果输出不同的数据信息

				uname = getStr(uname);
				String sql_name = "SELECT * FROM `mold_info` WHERE   mold_location=3  and mold_machine_number='"
						+ uname + "'";
				ResultSet rs_name = crm_db.executeQuery(sql_name);
				out.println("<response>");
				if (rs_name.next()) {
					if(!uname.equals("0"))
					{
						out.println("<res>" + "此机器已安装模具,请检查！" + "</res>");	
					}else
					{
						out.println("<res>" + "机器号不可为'0'!" + "</res>");	
					}	
					
				} else {
					out.println("<res>" + "true" + "</res>");
				}
				rs_name.close();
				out.println("</response>");
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