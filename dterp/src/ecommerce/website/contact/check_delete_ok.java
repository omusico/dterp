/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.website.contact;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataTag;
import include.get_sql.getInsertSql;

public class check_delete_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
try{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 ecommerce_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 ecommerce_db1 = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
counter count=new counter(dbApplication);
getInsertSql getInsertSql=new getInsertSql();

if(ecommerce_db.conn((String)dbSession.getAttribute("unit_db_name"))&&ecommerce_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_ID=request.getParameter("config_ID");
String contact_ID=request.getParameter("contact_ID");
String choice=request.getParameter("choice");
String checker_ID=request.getParameter("checker_ID") ;
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;

String sql6="select id from ecommerce_workflow where object_ID='"+contact_ID+"' and ((check_tag='0' and config_id<'"+config_ID+"') or (check_tag='1' and config_id='"+config_ID+"'))";
ResultSet rs6=ecommerce_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)session.getAttribute("unit_db_name"),"ecommerce_contact","contact_ID",contact_ID,"check_tag").equals("0")){
if(choice!=null){
if(choice.equals("")){
	String sql = "update ecommerce_contact set check_tag='9' where contact_ID='"+contact_ID+"'" ;
	ecommerce_db.executeUpdate(sql) ;

    sql = "delete from ecommerce_workflow where object_ID='"+contact_ID+"'" ;
	ecommerce_db.executeUpdate(sql) ;
	}else{
		
       sql6="select id from ecommerce_workflow where object_ID='"+contact_ID+"' and config_id<'"+config_ID+"' and    config_id>='"+choice+"'";
	    rs6=ecommerce_db.executeQuery(sql6) ;
		while(rs6.next()){
		String sql = "update ecommerce_workflow set check_tag='0' where id='"+rs6.getString("id")+"'" ;
		ecommerce_db1.executeUpdate(sql) ;
	}
}	
response.sendRedirect("ecommerce/website/contact/check_delete_ok.jsp?finished_tag=3");
}else{
response.sendRedirect("ecommerce/website/contact/check_delete_ok.jsp?finished_tag=2");
}
}else{
response.sendRedirect("ecommerce/website/contact/check_delete_ok.jsp?finished_tag=0");
}
}else{
response.sendRedirect("ecommerce/website/contact/check_delete_ok.jsp?finished_tag=1");
}
ecommerce_db.commit();
ecommerce_db1.commit();
ecommerce_db.close();
ecommerce_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}