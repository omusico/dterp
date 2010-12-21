/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.engage.test;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;   
import java.io.*;
import include.nseer_cookie.exchange;
import include.nseer_db.*;

public class pointQuery_ok extends HttpServlet{
//创建方法
ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{

HttpSession session=request.getSession();
PrintWriter out=response.getWriter();

nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String human_name=exchange.unURL(request.getParameter("human_name"));
String idcard=exchange.unURL(request.getParameter("idcard"));
String total_points=request.getParameter("total_points");
String test_amount=request.getParameter("test_amount");
String test_check_time=request.getParameter("test_check_time") ;
String test_checker=request.getParameter("test_checker") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String suggestion=request.getParameter("Ref") ;
String result="";
String sql ="";
if(suggestion.equals("1")) {
	result="建议面试";
	sql = "update hr_resume set check_tag='1',interview_tag='1',test_amount='"+test_amount+"',total_points='"+total_points+"',test_checker='"+test_checker+"',test_check_time='"+test_check_time+"',remark='"+remark+"' where idcard='"+idcard+"'" ;
}else if(suggestion.equals("2")){
	result="建议笔试";
	sql = "update hr_resume set interview_tag='2',test_amount='"+test_amount+"',total_points='"+total_points+"',test_checker='"+test_checker+"',test_check_time='"+test_check_time+"',remark='"+remark+"' where idcard='"+idcard+"'" ;
}else if(suggestion.equals("3")){
	result="建议录用";
	sql = "update hr_resume set interview_tag='3',test_amount='"+test_amount+"',total_points='"+total_points+"',test_checker='"+test_checker+"',test_check_time='"+test_check_time+"',remark='"+remark+"' where idcard='"+idcard+"'" ;
}
try{
	hr_db.executeUpdate(sql) ;
	String sql1="update hr_tester set check_tag='2' where idcard='"+idcard+"'";
	hr_db.executeUpdate(sql1) ;
	 hr_db.commit();
	hr_db.close();


	response.sendRedirect("hr/engage/test/pointQuery_ok_a.jsp");
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}