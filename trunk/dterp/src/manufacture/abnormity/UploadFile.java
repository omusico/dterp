package manufacture.abnormity;

import include.nseer_cookie.getFileLength;
import include.nseer_db.nseer_db_backup1;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import manufacture.process.FileRead;

import com.common.UpLoadUrl;
import com.jspsmart.upload.SmartUpload;

public class UploadFile extends HttpServlet {
	ServletContext application;

	HttpSession session;



	public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this, request,response, "", true, 8192, true);
		ServletContext dbApplication = dbSession.getServletContext();
		try {

			getFileLength getFileLength = new getFileLength();
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
			nseer_db_backup1 hr_db1 = new nseer_db_backup1(dbApplication);
			SmartUpload mySmartUpload = new SmartUpload();
			mySmartUpload.setCharset("UTF-8");
			if (hr_db.conn((String) dbSession.getAttribute("unit_db_name"))&&hr_db1.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String human_ID = request.getParameter("human_ID");

				mySmartUpload.setCharset("UTF-8");
				mySmartUpload.initialize(pageContext);
				String file_type = "txt";
				
				mySmartUpload.setAllowedFilesList(file_type);
				try {
					mySmartUpload.upload();
					com.jspsmart.upload.SmartFile myFile = mySmartUpload.getFiles().getFile(0);
					String file_name = myFile.getFileName();
					ServletContext context = session.getServletContext();
					String path = request.getContextPath();

					// 获取文件存放文件夹名称
					String filegroup = file_name.substring(file_name.indexOf("-") + 1, file_name.indexOf("."));

					// 获得当前日期
					java.util.Date now = new java.util.Date();
					SimpleDateFormat formatter = new SimpleDateFormat(
							"yyyyMMdd");
					String time = formatter.format(now);
					
					String suffName = file_name.substring(file_name.indexOf(".")-1,file_name.indexOf("."));//判断类型
		 			
		 			if(!suffName.equals("J")){
		 				 response.sendRedirect("manufacture/abnormity/file_upload_error1.jsp");
		 				 return;
		 			}
					
					String filePath = UpLoadUrl.getUploadUrl()+path+"/upload_file/manufacture_special/"
							+ time + "/" + filegroup + "/";// 上传文件路径
					
					File a = new File(filePath);
					if (!a.exists()) {
						a.mkdirs();
					}
					filePath = filePath + file_name;//

					myFile.saveAs(filePath);
					response.sendRedirect("manufacture/abnormity/file_upload_1.jsp?path=" + filePath);
				} catch (Exception ex) {
					response.sendRedirect("error_conn.htm");
				}
				hr_db1.commit();
				hr_db1.close();
				hr_db.commit();
				hr_db.close();
			} else {
				response.sendRedirect("error_conn.htm");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
