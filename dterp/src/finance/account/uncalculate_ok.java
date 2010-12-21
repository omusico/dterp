/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.account; 

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import include.get_name_from_ID.getMultiNameFromID;
import include.get_name_from_ID.AccountPeriod;

public class uncalculate_ok extends HttpServlet{

	public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
		HttpSession dbSession=request.getSession();
		JspFactory _jspxFactory=JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
		ServletContext dbApplication=dbSession.getServletContext();


		ServletContext application;
		HttpSession session=request.getSession();
		nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
		nseer_db_backup1 financedb = new nseer_db_backup1(dbApplication);
		counter count=new counter(dbApplication);
		ValidataNumber validta=new ValidataNumber();
		getMultiNameFromID getMultiNameFromID=new getMultiNameFromID();
		AccountPeriod accountPeriod=new AccountPeriod();

		try{

			if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))&&financedb.conn((String)dbSession.getAttribute("unit_db_name"))){
				String summary_content="";
				String register=(String)session.getAttribute("realeditorc");
				String register_id=(String)session.getAttribute("human_IDD");
/*				java.util.Date  now  =  new  java.util.Date();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				String register_time=formatter.format(now);
*/				String register_time=request.getParameter("timea");
				String voucher_in_month_ID="";
				String chain_id="";
				String corr_chain_id="";
				int step=1;
				int voucher_id_start=0;
				int voucher_id_temp=0;
				String debit_subtotal="";
				String loan_subtotal="";
				String debit_sum="";
				String loan_sum="";
				String[] account_period=accountPeriod.getAccountPeriod((String)session.getAttribute("unit_db_name"));

				String sql="select distinct voucher_in_month_ID from finance_voucher where account_period='"+account_period[0]+"' order by voucher_in_month_ID desc";
				ResultSet rs=finance_db.executeQuery(sql);
				if(rs.next()){
					voucher_id_start=10000+Integer.parseInt(rs.getString("voucher_in_month_ID"));
				}

				String sqq="select * from finance_voucher where account_tag='1' and (profit_or_cost='0' or profit_or_cost='1') and profit_tag='1' and account_period='"+account_period[0]+"' order by chain_ID";
				ResultSet rsq=finance_db.executeQuery(sqq);
				while(rsq.next()){
					voucher_id_temp=voucher_id_start+step;
					voucher_in_month_ID=(voucher_id_temp+"").substring(1);
					step++;
					chain_id=rsq.getString("chain_ID");
					corr_chain_id="3131";
					String[] name=getMultiNameFromID.getNameFromID((String)dbSession.getAttribute("unit_db_name"),chain_id);

					String[] corr_name=getMultiNameFromID.getNameFromID((String)dbSession.getAttribute("unit_db_name"),corr_chain_id);
					summary_content=name[6]+"转本年利润";
/*					if(rsq.getDouble("debit_subtotal")==0){
						loan_subtotal="0.00";
						debit_subtotal=new java.text.DecimalFormat("#####0.00").format(rsq.getDouble("loan_subtotal"));
						debit_sum=new java.text.DecimalFormat("#####0.00").format(rsq.getDouble("loan_subtotal"));
						loan_sum=new java.text.DecimalFormat("#####0.00").format(rsq.getDouble("loan_subtotal"));
					}else{
						loan_subtotal=new java.text.DecimalFormat("#####0.00").format(rsq.getDouble("debit_subtotal"));
						debit_subtotal="0.00";
						debit_sum=new java.text.DecimalFormat("#####0.00").format(rsq.getDouble("debit_subtotal"));
						loan_sum=new java.text.DecimalFormat("#####0.00").format(rsq.getDouble("debit_subtotal"));
					}
*/
//					sql="insert into finance_voucher(voucher_in_month_id,details_number,chain_id,chain_name,voucher_type,debit_sum,loan_sum,summary,debit_subtotal,loan_subtotal,product_amount,product_price,product,register,register_id,register_time,chain_mate_id,tax_rate,account_period,profit_or_cost) values('"+voucher_in_month_ID+"','0','"+chain_id+"','"+name[6]+"','"+rsq.getString("voucher_type")+"','"+debit_sum+"','"+loan_sum+"','"+summary_content+"','"+debit_subtotal+"','"+loan_subtotal+"','"+rsq.getString("product_amount")+"','"+rsq.getString("product_price")+"','"+rsq.getString("product")+"','"+register+"','"+register_id+"','"+register_time+"','"+corr_chain_id+"','"+rsq.getString("tax_rate")+"','"+account_period[0]+"','')";
					sql="delete from finance_voucher where voucher_in_month_id='"+voucher_in_month_ID+"' and details_number='0' and chain_id='"+chain_id+"' and chain_name='"+name[6]+"' and voucher_type='"+rsq.getString("voucher_type")+"' and summary='"+summary_content+"' and register_time='"+register_time+"' and account_period='"+account_period[0]+"'";
					financedb.executeUpdate(sql);
//					sql="insert into finance_voucher(voucher_in_month_id,details_number,chain_id,chain_name,voucher_type,debit_sum,loan_sum,summary,debit_subtotal,loan_subtotal,product_amount,product_price,product,register,register_id,register_time,chain_mate_id,tax_rate,account_period,profit_or_cost) values('"+voucher_in_month_ID+"','1','"+corr_chain_id+"','"+corr_name[6]+"','"+rsq.getString("voucher_type")+"','"+debit_sum+"','"+loan_sum+"','"+summary_content+"','"+loan_subtotal+"','"+debit_subtotal+"','"+rsq.getString("product_amount")+"','"+rsq.getString("product_price")+"','"+rsq.getString("product")+"','"+register+"','"+register_id+"','"+register_time+"','"+chain_id+"','"+rsq.getString("tax_rate")+"','"+account_period[0]+"','')";
					sql="delete from finance_voucher where voucher_in_month_id='"+voucher_in_month_ID+"' and details_number='1' and chain_id='"+corr_chain_id+"' and chain_name='"+corr_name[6]+"' and voucher_type='"+rsq.getString("voucher_type")+"' and summary='"+summary_content+"' and register_time='"+register_time+"' and account_period='"+account_period[0]+"'";
					financedb.executeUpdate(sql);
					sql="update finance_voucher set profit_tag='0' where id='"+rsq.getString("id")+"'";
					financedb.executeUpdate(sql);
				}
				response.sendRedirect("finance/account/uncalculate_ok_a.jsp");
				financedb.commit();
				finance_db.commit();
				financedb.close();
				finance_db.close();
			}else{
				response.sendRedirect("error_conn.htm");
			}
		}
		catch (Exception ex){
			ex.printStackTrace();
		}
	}
}