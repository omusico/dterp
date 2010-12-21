package manufacture.process;

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

public class ProductPalletServlet extends HttpServlet {
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
				String uname = request.getParameter("uname");
				
				uname=getStr(uname);
				
				// 设置输出信息的格式及字符集
				response.setContentType("text/xml; charset=UTF-8");
				response.setHeader("Cache-Control", "no-cache");
				// 创建输出流对象
				PrintWriter out = response.getWriter();
				// 依据验证结果输出不同的数据信息
				out.println("<response>");
				
				String sql_name="select id,product_pallet_sf,C_DEFINE1 from design_file where C_DEFINE1='0' and id='"+uname+"'";
				ResultSet rs_name=crm_db.executeQuery(sql_name);
				if(rs_name.next()){
					String product_pallet_sf=rs_name.getString("product_pallet_sf");
					if(product_pallet_sf.equals("")){
						out.println("<res>true</res>");
						
					}else{
						out.println("<res>" + product_pallet_sf + "</res>");
					}
				}
				
				out.println("</response>");
				out.close();
				
				
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
