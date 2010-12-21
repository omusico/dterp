/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.discussion;
 
 
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
ServletContext dbApplication=dbSession.getServletContext();
nseer_db_backup1 intrmanufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 intrmanufacture_db1 = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
counter count=new counter(dbApplication);

if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&intrmanufacture_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String discussion_ID=request.getParameter("discussion_ID");
String choice=request.getParameter("choice");
String checker_ID=request.getParameter("checker_ID") ;
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
String sql6="select id from intrmanufacture_workflow where object_ID='"+discussion_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=intrmanufacture_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"intrmanufacture_discussion","discussion_ID",discussion_ID,"check_tag").equals("0")){
if(choice!=null){
	if(choice.equals("")){
	String sql = "update intrmanufacture_discussion set check_tag='9',discussion_tag='1',modify_tag='0',check_time='"+check_time+"',checker='"+checker+"' where discussion_ID='"+discussion_ID+"' and check_tag='0'" ;
	intrmanufacture_db.executeUpdate(sql) ;
    sql = "delete from intrmanufacture_workflow where object_ID='"+discussion_ID+"'" ;
		intrmanufacture_db.executeUpdate(sql) ;
	}else{

	sql6="select id from intrmanufacture_workflow where object_ID='"+discussion_ID+"' and config_id<'"+config_id+"' and config_id>='"+choice+"'";
	rs6=intrmanufacture_db.executeQuery(sql6);
	while(rs6.next()){
		String sql = "update intrmanufacture_workflow set check_tag='0' where id='"+rs6.getString("id")+"'" ;
		intrmanufacture_db1.executeUpdate(sql) ;
	}
	}	
response.sendRedirect("intrmanufacture/discussion/check_delete_ok.jsp?finished_tag=0");
}else{
response.sendRedirect("intrmanufacture/discussion/check_delete_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("intrmanufacture/discussion/check_delete_ok.jsp?finished_tag=3");
}
}else{
	response.sendRedirect("intrmanufacture/discussion/check_delete_ok.jsp?finished_tag=2");
}
intrmanufacture_db.commit();
intrmanufacture_db1.commit();
intrmanufacture_db.close();
intrmanufacture_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}