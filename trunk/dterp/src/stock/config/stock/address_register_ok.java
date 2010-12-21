/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.config.stock;
  
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.counter;

public class address_register_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
counter count=new counter(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String stock_ID=request.getParameter("stock_ID");
String stock_name=request.getParameter("stock_name");

String sql = "insert into stock_config_public_char(STOCK_ID,STOCK_NAME,DESCRIBE1) values('"+
				stock_ID+"','"+stock_name+"','库房')";
stock_db.executeUpdate(sql);
stock_db.commit();
stock_db.close();
response.sendRedirect("stock/config/stock/register_success.jsp");
}else{
	response.sendRedirect("error_conn.htm");
}
}
	catch (Exception ex) {
		ex.printStackTrace();
	}
}
}