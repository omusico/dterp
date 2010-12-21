/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.reports;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class tableb_save extends HttpServlet{

	public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
		HttpSession dbSession=request.getSession();
		JspFactory _jspxFactory=JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
		ServletContext dbApplication=dbSession.getServletContext();


		ServletContext application;
		HttpSession session=request.getSession();
		nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);

		try{

			if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){

				String account_period=request.getParameter("account_period");
				String report_unit=request.getParameter("report_unit");


				String item_year1=request.getParameter("item_year1");
				String item_month1=request.getParameter("item_month1");

				String item_year4=request.getParameter("item_year4");
				String item_month4=request.getParameter("item_month4");

				String item_year5=request.getParameter("item_year5");
				String item_month5=request.getParameter("item_month5");

				String item_year10=request.getParameter("item_year10");
				String item_month10=request.getParameter("item_month10");

				String item_year11=request.getParameter("item_year11");
				String item_month11=request.getParameter("item_month11");

				String item_year14=request.getParameter("item_year14");
				String item_month14=request.getParameter("item_month14");

				String item_year15=request.getParameter("item_year15");
				String item_month15=request.getParameter("item_month15");

				String item_year16=request.getParameter("item_year16");
				String item_month16=request.getParameter("item_month16");

				String item_year18=request.getParameter("item_year18");
				String item_month18=request.getParameter("item_month18");

				String item_year19=request.getParameter("item_year19");
				String item_month19=request.getParameter("item_month19");

				String item_year23=request.getParameter("item_year23");
				String item_month23=request.getParameter("item_month23");

				String item_year25=request.getParameter("item_year25");
				String item_month25=request.getParameter("item_month25");

				String item_year27=request.getParameter("item_year27");
				String item_month27=request.getParameter("item_month27");

				String item_year28=request.getParameter("item_year28");
				String item_month28=request.getParameter("item_month28");

				String item_year30=request.getParameter("item_year30");
				String item_month30=request.getParameter("item_month30");
				
				String sql1="delete from finance_report_02 where account_period="+account_period;
				finance_db.executeUpdate(sql1);

				String sql="insert into finance_report_02(report_unit,account_period,item_year1,item_month1,item_year4,item_month4,item_year5,item_month5,item_year10,item_month10,item_year11,item_month11,item_year14,item_month14,item_year15,item_month15,item_year16,item_month16,item_year18,item_month18,item_year19,item_month19,item_year23,item_month23,item_year25,item_month25,item_year27,item_month27,item_year28,item_month28,item_year30,item_month30) values('"+report_unit+"',"+account_period+",'"+item_year1+"','"+item_month1+"','"+item_year4+"','"+item_month4+"','"+item_year5+"','"+item_month5+"','"+item_year10+"','"+item_month10+"','"+item_year11+"','"+item_month11+"','"+item_year14+"','"+item_month14+"','"+item_year15+"','"+item_month15+"','"+item_year16+"','"+item_month16+"','"+item_year18+"','"+item_month18+"','"+item_year19+"','"+item_month19+"','"+item_year23+"','"+item_month23+"','"+item_year25+"','"+item_month25+"','"+item_year27+"','"+item_month27+"','"+item_year28+"','"+item_month28+"','"+item_year30+"','"+item_month30+"')";
				finance_db.executeUpdate(sql);

				finance_db.commit();
				finance_db.close();
				response.sendRedirect("finance/reports/tableb_save_a.jsp");
			}else{
				response.sendRedirect("error_conn.htm");
			}
		}
		catch (Exception ex){
			ex.printStackTrace();
		}
	}
}