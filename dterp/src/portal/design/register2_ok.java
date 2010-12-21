/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package portal.design;

import include.get_rate_from_ID.getRateFromID;
import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import validata.ValidataNumber;


public class register2_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

 
try{
PrintWriter out=response.getWriter();
session=request.getSession();
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
counter count= new counter(dbApplication);
ValidataNumber validata= new ValidataNumber();
getRateFromID getRateFromID= new getRateFromID();
String customer_ID=request.getParameter("customer_ID") ;
String register_ID=(String)session.getAttribute("human_IDD");
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
String demand_pay_fee_sum2=request.getParameter("demand_pay_fee_sum") ;
String sales_name=request.getParameter("sales_name") ;
String sales_ID=request.getParameter("sales_ID") ;
double order_discount=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"security_users","human_ID",sales_ID,"order_discount");
double order_discount1=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"security_users","human_ID",register_ID,"order_discount");
int n=0;
for(int i=1;i<num;i++){
	String tem_amount="amount"+i;
	String tem_off_discount="off_discount"+i;
	String tem_list_price="list_price"+i;
String amount=request.getParameter(tem_amount) ;
String off_discount=request.getParameter(tem_off_discount) ;
String list_price2=request.getParameter(tem_list_price) ;
StringTokenizer tokenTO2 = new StringTokenizer(list_price2,",");        
String list_price="";
            while(tokenTO2.hasMoreTokens()) {
                String list_price1 = tokenTO2.nextToken();
		list_price +=list_price1;
		}
		if(!validata.validata(amount)||!validata.validata(off_discount)||!validata.validata(list_price)){
			n++;
		}else if(Double.parseDouble(off_discount)>order_discount&&Double.parseDouble(off_discount)>order_discount1){
			n++;
		}
}
if(n==0){

String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
String discussion_ID=NseerId.getId("crm/discussion",(String)dbSession.getAttribute("unit_db_name"));
String demand_contact_person_tel=request.getParameter("demand_contact_person_tel") ;
String demand_pay_time=request.getParameter("demand_pay_time") ;
String register_time=request.getParameter("register_time") ;
String register=request.getParameter("register") ;
String type=request.getParameter("type") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);

try{
	String sql3="select * from crm_file where customer_ID='"+customer_ID+"'";
	ResultSet rs=crm_db.executeQuery(sql3);
	if(rs.next()){
		String sql = "insert into crm_discussion(discussion_ID,chain_ID,chain_name,customer_ID,customer_name,demand_contact_person_tel,demand_pay_time,sales_name,sales_ID,register_time,type,remark,check_tag,excel_tag) values ('"+discussion_ID+"','"+rs.getString("chain_ID")+"','"+rs.getString("chain_name")+"','"+customer_ID+"','"+rs.getString("customer_name")+"','"+demand_contact_person_tel+"','"+demand_pay_time+"','"+rs.getString("sales_name")+"','"+rs.getString("sales_ID")+"','"+register_time+"','"+rs.getString("type")+"','"+remark+"','0','2')" ;
	crm_db.executeUpdate(sql) ;
	}
String id="";
String sqlb="select id from crm_discussion where discussion_ID='"+discussion_ID+"'";
rs=crm_db.executeQuery(sqlb);
	if(rs.next()){
		id=rs.getString("id");
	}
double sale_price_sum=0.0d;
double cost_price_sum=0.0d;
double real_cost_price_sum=0.0d;
int pay_amount_sum=0;
for(int i=1;i<num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_off_discount="off_discount"+i;
	String tem_list_price="list_price"+i;
	String tem_cost_price="cost_price"+i;
	String tem_real_cost_price="real_cost_price"+i;
	String tem_amount_unit="amount_unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount=request.getParameter(tem_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
String off_discount=request.getParameter(tem_off_discount) ;
String list_price2=request.getParameter(tem_list_price) ;
StringTokenizer tokenTO2 = new StringTokenizer(list_price2,",");        
String list_price="";
            while(tokenTO2.hasMoreTokens()) {
                String list_price1 = tokenTO2.nextToken();
		list_price +=list_price1;
		}
String cost_price2=request.getParameter(tem_cost_price) ;
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
String real_cost_price2=request.getParameter(tem_real_cost_price) ;
StringTokenizer tokenTO4 = new StringTokenizer(real_cost_price2,",");        
String real_cost_price="";
            while(tokenTO4.hasMoreTokens()) {
                String real_cost_price1 = tokenTO4.nextToken();
		real_cost_price +=real_cost_price1;
		}
	double subtotal=Double.parseDouble(list_price)*(1-Double.parseDouble(off_discount)/100)*Double.parseDouble(amount);
	double cost_price_after_discount_sum=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	double real_cost_price_after_discount_sum=Double.parseDouble(real_cost_price)*Double.parseDouble(amount);
	sale_price_sum+=subtotal;
	cost_price_sum+=cost_price_after_discount_sum;
	real_cost_price_sum+=real_cost_price_after_discount_sum;
	pay_amount_sum+=Double.parseDouble(amount);
	String sql1 = "insert into crm_discussion_details(discussion_ID,details_number,product_ID,product_name,product_describe,list_price,amount,cost_price,real_cost_price,off_discount,subtotal,amount_unit) values ('"+discussion_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+list_price+"','"+amount+"','"+cost_price+"','"+real_cost_price+"','"+off_discount+"','"+subtotal+"','"+amount_unit+"')" ;
	crm_db.executeUpdate(sql1) ;
}
List rsList = GetWorkflow.getList(crm_db, "crm_config_workflow", "02");
	String[] elem=new String[3];
	if(rsList.size()==0){
		String sql="update crm_discussion set sale_price_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"',real_cost_price_sum='"+real_cost_price_sum+"',check_tag='1' where discussion_ID='"+discussion_ID+"'";
		crm_db.executeUpdate(sql) ;
	}else{
		String sql="update crm_discussion set sale_price_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"',real_cost_price_sum='"+real_cost_price_sum+"' where discussion_ID='"+discussion_ID+"'";
		crm_db.executeUpdate(sql) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into crm_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+discussion_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		crm_db.executeUpdate(sql) ;
		}
	}
response.sendRedirect("portal/design/register2_choose_attachment.jsp?discussion_ID="+discussion_ID+"");	
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
	
	response.sendRedirect("portal/design/register2_ok_a.jsp?customer_ID="+customer_ID);
	}
	crm_db.commit();
	crm_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();	
}
}
}