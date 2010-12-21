/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.design_module;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import validata.ValidataNumber;
import include.nseer_cookie.counter;

public class register_module_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();
try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
int n=0;
for(int i=0;i<num;i++){
	String tem_using_amount="using_amount"+i;
String using_amount=request.getParameter(tem_using_amount) ;
		if(!validata.validata(using_amount)){
			n++;
		}
}
if(n==0){
String design_ID=request.getParameter("design_ID") ;
String module_design_ID=request.getParameter("module_design_ID") ;
String procedure_name=request.getParameter("procedure_name") ;
String register_time=request.getParameter("register_time") ;
String register=request.getParameter("register") ;
try{
double cost_price_sum=0.0d;
for(int i=0;i<num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_type="type"+i;
	String tem_amount="amount"+i;
	String tem_design_balance_amount="design_balance_amount"+i;
	String tem_using_amount="using_amount"+i;
	String tem_amount_unit="amount_unit"+i;
	String tem_cost_price="cost_price"+i;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String type=request.getParameter(tem_type) ;
String amount=request.getParameter(tem_amount) ;
String design_balance_amount=request.getParameter(tem_design_balance_amount) ;
String using_amount=request.getParameter(tem_using_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
String cost_price2=request.getParameter(tem_cost_price) ;
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(using_amount);
	double amount1=Double.parseDouble(design_balance_amount)-Double.parseDouble(using_amount);
	cost_price_sum+=subtotal;
	int j=i+1;
	ResultSet rs4=manufacture_db.executeQuery("select * from manufacture_design_procedure_module_details where design_ID='"+design_ID+"' and procedure_name='"+procedure_name+"' and product_ID='"+product_ID+"'");
	if(!rs4.next()){
	String sql1 = "insert into manufacture_design_procedure_module_details(design_ID,procedure_name,details_number,product_ID,product_name,product_describe,type,amount,cost_price,amount_unit,subtotal,register,register_time) values ('"+design_ID+"','"+procedure_name+"','"+j+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+type+"','"+using_amount+"','"+cost_price+"','"+amount_unit+"','"+subtotal+"','"+register+"','"+register_time+"')" ;
	manufacture_db.executeUpdate(sql1) ;
	String sql3="update design_module_details set design_balance_amount='"+amount1+"' where product_ID='"+product_ID+"' and design_ID='"+module_design_ID+"'";
design_db.executeUpdate(sql3) ;
	}
}
String sql2="update manufacture_design_procedure_details set design_module_tag='1',module_subtotal='"+cost_price_sum+"' where design_ID='"+design_ID+"' and procedure_name='"+procedure_name+"'";
manufacture_db.executeUpdate(sql2) ;
	response.sendRedirect("manufacture/design_module/register.jsp?design_ID="+design_ID+"");
	}
catch (Exception ex){
ex.printStackTrace();
}
}else{
	
	response.sendRedirect("manufacture/design_module/register_module_ok_b.jsp");
}
  design_db.commit();
  manufacture_db.commit();
  manufacture_db.close();
	design_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 