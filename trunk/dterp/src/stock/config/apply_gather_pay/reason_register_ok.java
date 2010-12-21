/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.config.apply_gather_pay;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class reason_register_ok extends HttpServlet{

ServletContext application;
HttpSession session;


public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);

try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String reason=request.getParameter("reason");
String sqll="select * from stock_config_public_char where describe1='\u51fa\u5165\u5e93\u7406\u7531' and stock_name='"+reason+"'";
ResultSet rs=stock_db.executeQuery(sqll);
if(rs.next()||reason.equals("销售出库")||reason.equals("采购入库")||reason.equals("生产领料")){
response.sendRedirect("stock/config/apply_gather_pay/reason_register_ok_a.jsp");
}else{
      String sql = "insert into stock_config_public_char(describe1,stock_name) values('\u51fa\u5165\u5e93\u7406\u7531','"+reason+"')" ;
    	stock_db.executeUpdate(sql) ;
response.sendRedirect("stock/config/apply_gather_pay/reason_register_ok_b.jsp");
}
stock_db.commit();
stock_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
	catch (Exception ex) {
		ex.printStackTrace();
	}
}
}