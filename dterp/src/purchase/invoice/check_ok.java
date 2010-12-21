/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package purchase.invoice;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import validata.ValidataNumber;
import include.nseer_cookie.counter;

public class check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))){

ValidataNumber validata=new ValidataNumber();
counter count=new counter(dbApplication);


String purchase_ID=request.getParameter("purchase_ID");
String checker=request.getParameter("checker");
String check_time=request.getParameter("check_time");
String checker_ID=request.getParameter("checker_ID");
String config_ID=request.getParameter("config_ID");
String invoice_time=request.getParameter("invoice_time");
String product_ID=request.getParameter("product_ID");
String product_name=request.getParameter("product_name");
String demand_cost_price_sum_all=request.getParameter("demand_cost_price_sum_all") ;
String real_invoiced_sum1=request.getParameter("real_invoiced_sum") ;
String[] provider_name=request.getParameterValues("provider_name") ;
String[] id=request.getParameterValues("id") ;
String[] provider_ID=request.getParameterValues("provider_ID") ;
String[] real_contact_person=request.getParameterValues("real_contact_person") ;
String[] real_contact_person_tel=request.getParameterValues("real_contact_person_tel") ;
String[] demand_cost_price_sum=request.getParameterValues("demand_cost_price_sum") ;
String[] invoiced_sum=request.getParameterValues("invoiced_sum") ;
String[] invoicing_sum=request.getParameterValues("invoicing_sum") ;
String[] remark=request.getParameterValues("remark") ;
String sql6="select id from purchase_workflow where object_ID='"+purchase_ID+"' and invoice_time='"+invoice_time+"' and ((check_tag='0' and config_id<'"+config_ID+"') or (check_tag='1' and config_id='"+config_ID+"'))";
ResultSet rs6=purchase_db.executeQuery(sql6);
if(!rs6.next()){
double real_invoiced_sum=Double.parseDouble(real_invoiced_sum1);
int p=0;
	String provider_ID_control=provider_ID[0];
	double invoice_control=0.0d;
for(int i=0;i<provider_ID.length;i++){
	if(!invoicing_sum[i].equals("")){
		StringTokenizer tokenTO1 = new StringTokenizer(invoicing_sum[i],",");        
		String invoicing_sum2="";
            while(tokenTO1.hasMoreTokens()) {
                String invoicing_sum1 = tokenTO1.nextToken();
		invoicing_sum2+=invoicing_sum1;
		}
		if(!validata.validata(invoicing_sum2)){
		p++;
		}
		if(real_contact_person[i].indexOf("'")!=-1||real_contact_person[i].indexOf("\"")!=-1||real_contact_person[i].indexOf(",")!=-1||real_contact_person_tel[i].indexOf("'")!=-1||real_contact_person_tel[i].indexOf("\"")!=-1||real_contact_person_tel[i].indexOf(",")!=-1||remark[i].indexOf("'")!=-1||remark[i].indexOf("\"")!=-1||remark[i].indexOf(",")!=-1||real_contact_person[i].length()>30||real_contact_person_tel[i].length()>30){
		p++;
		}
	}
}
if(p==0){
int n=0;
for(int i=0;i<provider_ID.length;i++){
	if(!invoicing_sum[i].equals("")){
		n++;
	}
}
if(n!=0){
String sql8="select * from purchase_purchasing where purchase_ID='"+purchase_ID+"' and check_tag='0' and kind='发票' order by id";
ResultSet rs8=purchase_db.executeQuery(sql8);
if(rs8.next()){
boolean flag=false; 
sql8 = "update purchase_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+purchase_ID+"' and config_id='"+config_ID+"' and invoice_time='"+invoice_time+"'" ;

	purchase_db.executeUpdate(sql8);
sql8="select id from purchase_workflow where object_ID='"+purchase_ID+"' and invoice_time='"+invoice_time+"' and check_tag='0'";
	rs8=purchase_db.executeQuery(sql8);
if(!rs8.next()){
flag=true;
for(int i=0;i<provider_ID.length;i++){
String sql="update purchase_purchasing set check_tag='1' where id='"+id[i]+"' and check_tag='0' and invoice_time='"+invoice_time+"'";
purchase_db.executeUpdate(sql);
}
}
	provider_ID_control=provider_ID[0];
	double invoiced_sum_control=Double.parseDouble(invoiced_sum[0]);
for(int i=0;i<provider_ID.length;i++){
	if(invoicing_sum[i].equals("")) invoicing_sum[i]="0";
	StringTokenizer tokenTO = new StringTokenizer(invoicing_sum[i],",");        
		String invoicing_sum2="";
            while(tokenTO.hasMoreTokens()) {
                String invoicing_sum1 = tokenTO.nextToken();
		invoicing_sum2+=invoicing_sum1;
		}
if(provider_ID[i].equals(provider_ID_control)){
	if(Double.parseDouble(invoicing_sum2)!=0){
	invoiced_sum_control+=Double.parseDouble(invoicing_sum2);
		real_invoiced_sum+=Double.parseDouble(invoicing_sum2);
		String sql="update purchase_purchasing set real_contact_person='"+real_contact_person[i]+"',real_contact_person_tel='"+real_contact_person_tel[i]+"',invoicing_sum='"+invoicing_sum2+"',remark='"+remark[i]+"',checker='"+checker+"',check_time='"+check_time+"' where id='"+id[i]+"'";
		purchase_db.executeUpdate(sql);
        if(flag){
		if(invoiced_sum_control==Double.parseDouble(demand_cost_price_sum[i])){
		String sql1="update purchase_details set invoiced_sum='"+invoiced_sum_control+"',uninvoice_sum='0',invoice_tag='1' where purchase_ID='"+purchase_ID+"' and provider_ID='"+provider_ID[i]+"'";
		purchase_db.executeUpdate(sql1);
		}else{
			double uninvoice_sum=Double.parseDouble(demand_cost_price_sum[i])-invoiced_sum_control;
			String sql1="update purchase_details set invoiced_sum='"+invoiced_sum_control+"',uninvoice_sum='"+uninvoice_sum+"',invoice_check_tag='0' where purchase_ID='"+purchase_ID+"' and provider_ID='"+provider_ID[i]+"'";
			purchase_db.executeUpdate(sql1);
		}
		}else{
		double uninvoice_sum=Double.parseDouble(demand_cost_price_sum[i])-invoiced_sum_control;
		String sql2="update purchase_details set invoiced_sum='"+invoiced_sum_control+"',uninvoice_sum='"+uninvoice_sum+"' where purchase_ID='"+purchase_ID+"' and provider_ID='"+provider_ID[i]+"'";
		purchase_db.executeUpdate(sql2);
		}
		}else if(Double.parseDouble(invoicing_sum2)==0){
			if(flag){
		String sql7="delete from purchase_purchasing where id='"+id[i]+"'";
		purchase_db.executeUpdate(sql7);
		String sql222="update purchase_details set invoice_check_tag='0' where purchase_ID='"+purchase_ID+"' and provider_ID='"+provider_ID[i]+"'";
		purchase_db.executeUpdate(sql222);
			}
		}
}else{
	if(Double.parseDouble(invoicing_sum2)!=0){
		provider_ID_control=provider_ID[i];
	invoiced_sum_control=Double.parseDouble(invoiced_sum[i])+Double.parseDouble(invoicing_sum2);
		real_invoiced_sum+=Double.parseDouble(invoicing_sum2);
		String sql="update purchase_purchasing set real_contact_person='"+real_contact_person[i]+"',real_contact_person_tel='"+real_contact_person_tel[i]+"',invoicing_sum='"+invoicing_sum2+"',remark='"+remark[i]+"',checker='"+checker+"',check_time='"+check_time+"' where id='"+id[i]+"'";
		purchase_db.executeUpdate(sql);
        if(flag){
		if(invoiced_sum_control==Double.parseDouble(demand_cost_price_sum[i])){
		String sql1="update purchase_details set invoiced_sum='"+invoiced_sum_control+"',uninvoice_sum='0',invoice_tag='1' where purchase_ID='"+purchase_ID+"' and provider_ID='"+provider_ID[i]+"'";
		purchase_db.executeUpdate(sql1);
		}else{
			double uninvoice_sum=Double.parseDouble(demand_cost_price_sum[i])-invoiced_sum_control;
			String sql2="update purchase_details set invoiced_sum='"+invoiced_sum_control+"',uninvoice_sum='"+uninvoice_sum+"',invoice_check_tag='0' where purchase_ID='"+purchase_ID+"' and provider_ID='"+provider_ID[i]+"'";
			purchase_db.executeUpdate(sql2);
		}
		}else{
		double uninvoice_sum=Double.parseDouble(demand_cost_price_sum[i])-invoiced_sum_control;
		String sql2="update purchase_details set invoiced_sum='"+invoiced_sum_control+"',uninvoice_sum='"+uninvoice_sum+"' where purchase_ID='"+purchase_ID+"' and provider_ID='"+provider_ID[i]+"'";
		purchase_db.executeUpdate(sql2);
		}
		}else if(Double.parseDouble(invoicing_sum2)==0){
			if(flag){
		String sql7="delete from purchase_purchasing where id='"+id[i]+"'";
		purchase_db.executeUpdate(sql7);
		String sql222="update purchase_details set invoice_check_tag='0' where purchase_ID='"+purchase_ID+"' and provider_ID='"+provider_ID[i]+"'";
		purchase_db.executeUpdate(sql222);
			}
		}	
}
}

if(flag){
if(real_invoiced_sum==Double.parseDouble(demand_cost_price_sum_all)){
	String sql3="update purchase_purchase set invoiced_sum='"+real_invoiced_sum+"',invoice_tag='3' where purchase_ID='"+purchase_ID+"'";
		purchase_db.executeUpdate(sql3);
		String sql21="select * from purchase_purchase where stock_gather_tag='3' and invoice_tag='3' and gather_tag='3' and check_tag='2' and purchase_ID='"+purchase_ID+"'";
		ResultSet rs21=purchase_db.executeQuery(sql21);
		if(rs21.next()){
		String sql22="update purchase_purchase set purchase_tag='2' where purchase_ID='"+purchase_ID+"'";
		purchase_db.executeUpdate(sql22);
		}
	response.sendRedirect("purchase/invoice/check_ok.jsp?finished_tag=4");
	}else{
	String sql4="update purchase_purchase set invoiced_sum='"+real_invoiced_sum+"',invoice_check_tag='0' where purchase_ID='"+purchase_ID+"'";
	purchase_db.executeUpdate(sql4);
	response.sendRedirect("purchase/invoice/check_ok.jsp?finished_tag=0");
	}
}else{
response.sendRedirect("purchase/invoice/check_ok.jsp?finished_tag=3");
}
 }else{
	response.sendRedirect("purchase/invoice/check_ok.jsp?finished_tag=1");
	}
 }else{
	response.sendRedirect("purchase/invoice/check_ok_d.jsp?purchase_ID="+purchase_ID+"");
	}
 }else{
	response.sendRedirect("purchase/invoice/check_ok_e.jsp?purchase_ID="+purchase_ID+"");
}
}else{
response.sendRedirect("purchase/invoice/check_ok.jsp?finished_tag=2");
}
	purchase_db.commit();	
	purchase_db.close();

}else{
	response.sendRedirect("error_conn.htm");
}

}
catch (Exception ex){
ex.printStackTrace();
}
}
}