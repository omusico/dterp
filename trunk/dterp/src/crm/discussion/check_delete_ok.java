/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.discussion;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.*;
import java.sql.*;
import include.nseer_db.*;
import validata.ValidataTag;

public class check_delete_ok extends HttpServlet{

ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

 
try{HttpSession session=request.getSession();
PrintWriter out=response.getWriter();
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 crm_db1 = new nseer_db_backup1(dbApplication);
ValidataTag vt=new  ValidataTag();
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String discussion_ID=request.getParameter("discussion_ID");
String choice=request.getParameter("choice");
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
if(choice!=null){
String sql6="select id from crm_workflow where object_ID='"+discussion_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=crm_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_discussion","discussion_ID",discussion_ID,"check_tag").equals("0")){
try{
	if(choice.equals("")){
	String sql2="update crm_discussion set check_tag='9',discussion_tag='1',modify_tag='0',check_time='"+check_time+"',checker='"+checker+"' where discussion_ID='"+discussion_ID+"' and check_tag='0'";
	crm_db.executeUpdate(sql2) ;
	sql2 = "delete from crm_workflow where object_ID='"+discussion_ID+"'" ;
	crm_db.executeUpdate(sql2) ;
	}else{

	sql6="select id from crm_workflow where object_ID='"+discussion_ID+"' and config_id<'"+config_id+"' and config_id>='"+choice+"'";
	rs6=crm_db.executeQuery(sql6);
	while(rs6.next()){
		String sql = "update crm_workflow set check_tag='0' where id='"+rs6.getString("id")+"'" ;
		crm_db1.executeUpdate(sql) ;
	}
	}
}
catch (Exception ex) {
		out.println("error"+ex);
	}	
  	response.sendRedirect("crm/discussion/check_delete_ok.jsp?finished_tag=0");
}else{	
	response.sendRedirect("crm/discussion/check_delete_ok.jsp?finished_tag=3");
}
}else{
	response.sendRedirect("crm/discussion/check_delete_ok.jsp?finished_tag=2");
}
}else{
	response.sendRedirect("crm/discussion/check_delete_ok.jsp?finished_tag=1");
}
crm_db.commit();
crm_db1.commit();
crm_db.close();
crm_db1.close();

}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}