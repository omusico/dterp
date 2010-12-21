/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package design.config.file;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class fieldType_register_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
try{
if(design_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String type_name=request.getParameter("type_name");
String sqll="select * from design_config_public_char where kind='产品用途' and type_name='"+type_name+"'";
ResultSet rs=design_db.executeQuery(sqll);
if(rs.next()){

response.sendRedirect("design/config/file/fieldType_register_ok_a.jsp");
}else{
      String sql = "insert into design_config_public_char(kind,type_name) values('产品用途','"+type_name+"')" ;
    	design_db.executeUpdate(sql) ;
		
response.sendRedirect("design/config/file/fieldType_register_ok_b.jsp");
}
design_db.commit();
design_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}	catch (Exception ex) {
		ex.printStackTrace();
	}
}
}