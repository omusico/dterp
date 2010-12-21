/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.intrmanufacture;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import include.nseer_db.*;
import java.text.*;
import include.nseer_cookie.*;
import validata.ValidataNumber;
import validata.ValidataRecordNumber;

public class registerNew_ok extends HttpServlet{

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
ValidataNumber  validata=new  ValidataNumber();
nseer_db_backup1 intrmanufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 intrmanufacture_db1 = new nseer_db_backup1(dbApplication);
nseer_db_backup1 intrmanufacturedb = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 fund_db = new nseer_db_backup1(dbApplication);
if(intrmanufacturedb.conn((String)dbSession.getAttribute("unit_db_name"))&&intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&intrmanufacture_db1.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db.conn((String)dbSession.getAttribute("unit_db_name"))&&fund_db.conn((String)dbSession.getAttribute("unit_db_name"))){
	String time="";
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	time=formatter.format(now);
ValidataRecordNumber  vrn= new  ValidataRecordNumber();	
String product_ID=request.getParameter("product_ID");
String product_name=request.getParameter("product_name");
String balance_amount=request.getParameter("balance_amount");
String[] provider_name=request.getParameterValues("provider_name") ;
String[] provider_ID=request.getParameterValues("provider_ID") ;
String[] contact_person=request.getParameterValues("contact_person1") ;
String[] provider_tel=request.getParameterValues("provider_tel1") ;
String[] demand_gather_time=request.getParameterValues("demand_gather_time1") ;
String[] demand_amount=request.getParameterValues("demand_amount") ;
String[] demand_price=request.getParameterValues("demand_price") ;
int p=0;
double demand_amount_sum=0.0d;
for(int i=0;i<provider_ID.length;i++){
	if(!demand_amount[i].equals("")){
		if(!validata.validata(demand_amount[i])){
			p++;
		}else{
			demand_amount_sum+=Double.parseDouble(demand_amount[i]);
		}
	}
	if(!demand_price[i].equals("")){
		StringTokenizer tokenTO1 = new StringTokenizer(demand_price[i],",");        
		String demand_price2="";
            while(tokenTO1.hasMoreTokens()) {
                String demand_price1 = tokenTO1.nextToken();
		demand_price2+=demand_price1;
		}
		if(!validata.validata(demand_price2)||Double.parseDouble(demand_price2)<0){
			p++;
		}	
	}
}
if(p==0){
	
String register=request.getParameter("register");
String register_time=request.getParameter("register_time");
demand_amount_sum=0.0d;
double demand_cost_price_sum=0.0d;
int m=0;
int n=0;
for(int i=0;i<provider_ID.length;i++){
	if(!demand_amount[i].equals("")&&!demand_price[i].equals("")){
		if(Double.parseDouble(demand_amount[i])!=0){
		n++;
		}
	}
	if(!demand_amount[i].equals("")&&demand_price[i].equals("")){
		m++;
	}
}
if(n!=0&&m==0){
String intrmanufacture_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
m=1;
for(int i=0;i<provider_ID.length;i++){
	if(!demand_amount[i].equals("")&&Double.parseDouble(demand_amount[i])!=0){
		StringTokenizer tokenTO = new StringTokenizer(demand_price[i],",");        
		String demand_price2="";
            while(tokenTO.hasMoreTokens()) {
                String demand_price1 = tokenTO.nextToken();
		demand_price2+=demand_price1;
		}
		double amount=Double.parseDouble(demand_amount[i]);
		demand_amount_sum+=amount;
		double subtotal=amount*Double.parseDouble(demand_price2);
		demand_cost_price_sum+=subtotal;
		String sql="insert into intrmanufacture_details(intrmanufacture_ID,details_number,provider_ID,provider_name,demand_contact_person,demand_contact_person_tel,demand_amount,demand_price,demand_cost_price_sum,demand_gather_time) values('"+intrmanufacture_ID+"','"+m+"','"+provider_ID[i]+"','"+provider_name[i]+"','"+contact_person[i]+"','"+provider_tel[i]+"','"+amount+"','"+demand_price2+"','"+subtotal+"','"+demand_gather_time[i]+"')";
		intrmanufacture_db.executeUpdate(sql);
		m++;
	}
}
double price=demand_cost_price_sum/demand_amount_sum;
String sql1="insert into intrmanufacture_intrmanufacture(intrmanufacture_ID,product_ID,product_name,register,register_time,demand_amount,demand_price,demand_cost_price_sum,check_tag,pay_ID_group) values('"+intrmanufacture_ID+"','"+product_ID+"','"+product_name+"','"+register+"','"+register_time+"','"+demand_amount_sum+"','"+price+"','"+demand_cost_price_sum+"','1','新发生')";
intrmanufacture_db.executeUpdate(sql1);

	List rsList = (List)new java.util.ArrayList();
	String[] elem=new String[3];
	String sql = "select id,describe1,describe2 from intrmanufacture_config_workflow where type_id='05'";
	ResultSet rset = intrmanufacture_db.executeQuery(sql);
	while(rset.next()){
		elem=new String[3];
		elem[0]=rset.getString("id");
		elem[1]=rset.getString("describe1");
		elem[2]=rset.getString("describe2");
		rsList.add(elem);
	}
if(rsList.size()==0){
	String sqll = "update intrmanufacture_intrmanufacture set check_tag='2',intrmanufacture_tag='1',invoice_tag='1',gather_tag='1',stock_gather_tag='1',pay_tag='1' where intrmanufacture_ID='"+intrmanufacture_ID+"'" ;
	intrmanufacture_db.executeUpdate(sqll) ;
	int record_number=0;
	String sql98="select count(*) from intrmanufacture_details where intrmanufacture_ID='"+intrmanufacture_ID+"'";
	ResultSet rs98=intrmanufacture_db.executeQuery(sql98) ;
	while(rs98.next()){
		record_number=rs98.getInt("count(*)");
	}
	String design_ID="";
	double module_cost=0.0d;
	String sql16="select * from design_module where product_ID='"+product_ID+"'";
	ResultSet rs16=design_db.executeQuery(sql16) ;
	while(rs16.next()){
		design_ID=rs16.getString("design_ID");
		module_cost=rs16.getDouble("cost_price_sum")*demand_amount_sum;
	}
	double list_price_sum=price*demand_amount_sum;
	sql = "update intrmanufacture_intrmanufacture set list_price_sum='"+list_price_sum+"',list_price='"+price+"',checker='"+register+"',check_time='"+register_time+"',check_tag='2',intrmanufacture_tag='1',invoice_tag='1',gather_tag='1',stock_gather_tag='1',pay_tag='1',module_cost_price_sum='"+module_cost+"' where intrmanufacture_ID='"+intrmanufacture_ID+"'" ;
	intrmanufacture_db.executeUpdate(sql) ;
	String sql9="select * from intrmanufacture_details where intrmanufacture_ID='"+intrmanufacture_ID+"'";
	ResultSet rs9=intrmanufacture_db.executeQuery(sql9) ;
	while(rs9.next()){
		String pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));
		String part_pay_ID=pay_ID+"part";
		int i=1;
		int j=0;
		double module_cost_price_sum=0.0d;
		double module_demand_amount=0.0d;
		double part_cost_price_sum=0.0d;
		double part_module_demand_amount=0.0d;
		String sql6="select * from design_module_details where design_ID='"+design_ID+"' order by details_number";
		ResultSet rs6=design_db.executeQuery(sql6) ;
		while(rs6.next()){			
			if(rs6.getString("type").equals("物料")){
			double module_cost_price=rs6.getDouble("subtotal")*rs9.getDouble("demand_amount");
			double module_demand_amount1=rs6.getDouble("amount")*rs9.getDouble("demand_amount");
			module_cost_price_sum+=module_cost_price;
			module_demand_amount+=module_demand_amount1;
			String sql7="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,product_describe,type,amount,apply_purchase_amount,amount_unit,cost_price,subtotal) values('"+pay_ID+"','"+i+"','"+rs6.getString("product_ID")+"','"+rs6.getString("product_name")+"','"+rs6.getString("product_describe")+"','"+rs6.getString("type")+"','"+module_demand_amount1+"','"+module_demand_amount1+"','"+rs6.getString("amount_unit")+"','"+rs6.getString("cost_price")+"','"+module_cost_price+"')";
			stock_db.executeUpdate(sql7) ;
			}			
			if(rs6.getString("type").equals("部件")||rs6.getString("type").equals("委外部件")){
				double part_module_cost_price=rs6.getDouble("subtotal")*rs9.getDouble("demand_amount");
				double part_module_demand_amount1=rs6.getDouble("amount")*rs9.getDouble("demand_amount");
				part_cost_price_sum+=part_module_cost_price;
				part_module_demand_amount+=part_module_demand_amount1;
				module_cost_price_sum+=part_module_cost_price;
				module_demand_amount+=part_module_demand_amount1;
				j++;
				String sql13="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,product_describe,type,amount,apply_purchase_amount,amount_unit,cost_price,subtotal) values('"+pay_ID+"','"+i+"','"+rs6.getString("product_ID")+"','"+rs6.getString("product_name")+"','"+rs6.getString("product_describe")+"','"+rs6.getString("type")+"','"+part_module_demand_amount1+"','0','"+rs6.getString("amount_unit")+"','"+rs6.getString("cost_price")+"','"+part_module_cost_price+"')";
				stock_db.executeUpdate(sql13) ;
				String sql18="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,product_describe,type,amount,apply_manufacture_amount,amount_unit,cost_price,subtotal) values('"+part_pay_ID+"','"+j+"','"+rs6.getString("product_ID")+"','"+rs6.getString("product_name")+"','"+rs6.getString("product_describe")+"','"+rs6.getString("type")+"','"+part_module_demand_amount1+"','"+part_module_demand_amount1+"','"+rs6.getString("amount_unit")+"','"+rs6.getString("cost_price")+"','"+part_module_cost_price+"')";
				stock_db.executeUpdate(sql18) ;
			}
			i++;
		}
if(j==0&&vrn.validata((String)dbSession.getAttribute("unit_db_name"),"stock_pay","reasonexact",intrmanufacture_ID)<record_number){
		String sql19="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,apply_purchase_amount,cost_price_sum,register,register_time) values('"+pay_ID+"','生产领料','"+intrmanufacture_ID+"','"+rs9.getString("provider_name")+"','"+module_demand_amount+"','"+module_demand_amount+"','"+module_cost_price_sum+"','"+register+"','"+register_time+"')";
		stock_db.executeUpdate(sql19) ;

	}else if(j!=0&&vrn.validata((String)dbSession.getAttribute("unit_db_name"),"stock_pay","reasonexact",intrmanufacture_ID)<2*record_number){
		String sql20="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,apply_purchase_amount,cost_price_sum,register,register_time) values('"+pay_ID+"','生产领料','"+intrmanufacture_ID+"','"+rs9.getString("provider_name")+"','"+module_demand_amount+"','"+module_demand_amount+"','"+module_cost_price_sum+"','"+register+"','"+register_time+"')";
		stock_db.executeUpdate(sql20) ;
		String sql21="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,apply_purchase_amount,cost_price_sum,register,register_time) values('"+part_pay_ID+"','部件出库','"+intrmanufacture_ID+"','"+rs9.getString("provider_name")+"','"+part_module_demand_amount+"','"+part_module_demand_amount+"','"+part_cost_price_sum+"','"+register+"','"+register_time+"')";
		stock_db.executeUpdate(sql21) ;
	}	
	String sql22="update intrmanufacture_details set module_cost_price_sum='"+module_cost_price_sum+"' where intrmanufacture_ID='"+intrmanufacture_ID+"'";
	if(vrn.validata((String)dbSession.getAttribute("unit_db_name"),"stock_gather","reasonexact",intrmanufacture_ID)<record_number){
		double gather_cost_price_sum=rs9.getDouble("demand_cost_price_sum")+module_cost_price_sum;
		double gather_demand_price=gather_cost_price_sum/rs9.getDouble("demand_amount");
		String gather_ID=NseerId.getId("stock/gather",(String)dbSession.getAttribute("unit_db_name"));
		String sql5="insert into stock_gather(gather_ID,reason,reasonexact,reasonexact_details,demand_amount,cost_price,cost_price_sum,register,register_time) values('"+gather_ID+"','委外入库','"+intrmanufacture_ID+"','"+rs9.getString("provider_name")+"','"+rs9.getString("demand_amount")+"','"+rs9.getString("demand_price")+"','"+gather_cost_price_sum+"','"+register+"','"+register_time+"')";
		stock_db.executeUpdate(sql5) ;
		String sql17="insert into stock_gather_details(gather_ID,details_number,product_ID,product_name,amount,ungather_amount,cost_price,subtotal) values('"+gather_ID+"','1','"+product_ID+"','"+product_name+"','"+rs9.getString("demand_amount")+"','"+rs9.getString("demand_amount")+"','"+gather_demand_price+"','"+gather_cost_price_sum+"')";
		stock_db.executeUpdate(sql17) ;
	}
	}
	String sql99="select * from intrmanufacture_details where intrmanufacture_ID='"+intrmanufacture_ID+"'";
	ResultSet rs99=intrmanufacture_db.executeQuery(sql99) ;
	while(rs99.next()){
		String chain_id="";
		String chain_name="";	
		String intrmanufacturer_ID="";
		String intrmanufacturer="";
		String sql15="select * from intrmanufacture_file where provider_ID='"+rs99.getString("provider_ID")+"'";
		ResultSet rs15=intrmanufacturedb.executeQuery(sql15);
		if(rs15.next()){
			chain_id=rs15.getString("chain_id");
			chain_name=rs15.getString("chain_name");			
			intrmanufacturer_ID=rs15.getString("intrmanufacturer_ID");
			intrmanufacturer=rs15.getString("intrmanufacturer");
			if(rs99.getDouble("demand_cost_price_sum")>=0){
			double trade_amount=rs15.getDouble("trade_amount")+1;
			double trade_sum=rs15.getDouble("achievement_sum")+rs99.getDouble("demand_cost_price_sum");
			String sql90="update intrmanufacture_file set trade_amount='"+trade_amount+"',achievement_sum='"+trade_sum+"' where provider_ID='"+rs99.getString("provider_ID")+"'";
			intrmanufacture_db1.executeUpdate(sql90) ;
			}else{
			double return_amount=rs15.getDouble("return_amount")+1;
			double trade_sum=rs15.getDouble("achievement_sum")+rs99.getDouble("demand_cost_price_sum");
			double return_sum=rs15.getDouble("return_sum")+rs99.getDouble("demand_cost_price_sum");
			String sql90="update intrmanufacture_file set return_amount='"+return_amount+"',achievement_sum='"+trade_sum+"',return_sum='"+return_sum+"' where provider_ID='"+rs99.getString("provider_ID")+"'";
			intrmanufacture_db1.executeUpdate(sql90) ;
			}
		}
		String fund_ID=NseerId.getId("fund/pay",(String)dbSession.getAttribute("unit_db_name"));
		if(vrn.validata((String)dbSession.getAttribute("unit_db_name"),"fund_fund","reasonexact",intrmanufacture_ID)<record_number){
		String sql12="insert into fund_fund(fund_ID,reason,reasonexact,chain_id,chain_name,funder,funder_ID,file_chain_id,file_chain_name,demand_cost_price_sum,currency_name,personal_unit,register,register_time,sales_purchaser_ID,sales_purchaser_name) values('"+fund_ID+"','付款','"+intrmanufacture_ID+"','"+chain_id+"','"+chain_name+"','"+rs99.getString("provider_name")+"','"+rs99.getString("provider_ID")+"','2121','应付账款-委外加工费','"+rs99.getString("demand_cost_price_sum")+"','人民币','元','"+register+"','"+register_time+"','"+intrmanufacturer_ID+"','"+intrmanufacturer+"')";
		fund_db.executeUpdate(sql12) ;
		}
	}
	}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into intrmanufacture_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+intrmanufacture_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		intrmanufacture_db.executeUpdate(sql) ;
		}
	}
response.sendRedirect("intrmanufacture/intrmanufacture/registerNew_choose.jsp?intrmanufacture_ID="+intrmanufacture_ID+"");
}else{
session.setAttribute("product_name",product_name);
session.setAttribute("product_ID",product_ID);
response.sendRedirect("intrmanufacture/intrmanufacture/registerNew_ok_a.jsp");
}
  }else{
session.setAttribute("product_name",product_name);
session.setAttribute("product_ID",product_ID);
response.sendRedirect("intrmanufacture/intrmanufacture/registerNew_ok_b.jsp");
}
intrmanufacture_db.commit();
	intrmanufacture_db1.commit();
	stock_db.commit();
fund_db.commit();
intrmanufacturedb.commit();
intrmanufacture_db.close();
	intrmanufacture_db1.close();
	stock_db.close();
fund_db.close();
intrmanufacturedb.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}

