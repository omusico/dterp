/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package design.file;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;
import include.operateDB.CdefineUpdate;
import validata.ValidataNumber;


public class register_ok extends HttpServlet{

	public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
		HttpSession dbSession=request.getSession();
		JspFactory _jspxFactory=JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
		ServletContext dbApplication=dbSession.getServletContext();

		ServletContext application;
		HttpSession session=request.getSession();
		nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
		
		ValidataNumber validata=new ValidataNumber();
		counter count=new counter(dbApplication);
		try{

			if(design_db.conn((String)dbSession.getAttribute("unit_db_name"))){
				String list_price2=request.getParameter("list_price") ;
				String product_number = request.getParameter("product_number");
				String shuilv = request.getParameter("shuilv");
				if(shuilv==null){ // add by wangshaolin
					shuilv="0.0";
				}
				StringTokenizer tokenTO4 = new StringTokenizer(list_price2,",");        
				String list_price="";
				while(tokenTO4.hasMoreTokens()) {
					String list_price1 = tokenTO4.nextToken();
					list_price +=list_price1;
				}
				String cost_price2=request.getParameter("cost_price") ;
				StringTokenizer tokenTO5 = new StringTokenizer(cost_price2,",");        
				String cost_price="";
				while(tokenTO5.hasMoreTokens()) {
					String cost_price1 = tokenTO5.nextToken();
					cost_price +=cost_price1;
				}
				int n=0;
				if(!validata.validata(list_price)||Double.parseDouble(list_price)<0){
					n++;
				}
				if(!validata.validata(cost_price)||Double.parseDouble(cost_price)<0){
					n++;
				}
				//if (product_number.length()<1){
				if (product_number!=null&&product_number.length()<1){ //mofidy by wangshaolin
					n++;
					n++;
				}
				if(n==0){
					String  responsible_person=request.getParameter("select4") ;
					String	responsible_person_ID="";
					String	responsible_person_name="";
					if(!responsible_person.equals("")){	
						responsible_person_ID=responsible_person.split("/")[0];
						responsible_person_name=responsible_person.split("/")[1];
					}
					String fileKind_chain=request.getParameter("fileKind_chain");
					String chain_id=Divide1.getId(fileKind_chain);
					String chain_name=Divide1.getName(fileKind_chain);

					String sql2="select * from design_config_file_kind where chain_id='"+chain_id+"'";
					ResultSet rs2=design_db.executeQuery(sql2) ;
					if(!chain_id.equals("")){
						String product_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
						//product_ID=product_ID.substring(0, 6)+"-"+product_number; modify by wangshaolin
						int product_length=0;
						String product_name=request.getParameter("product_name") ;
						String product_lengths=request.getParameter("product_length");
						if(product_lengths!=null&&product_lengths.length()>0)
							product_length=Integer.parseInt(product_lengths) ;
						int type1=Integer.parseInt(request.getParameter("type"));
						String c_define2=request.getParameter("c_define2");
						String factory_name=request.getParameter("factory_name") ;
						String spec_top=request.getParameter("spec_top");
						String spec_bottom=request.getParameter("spec_bottom");
						String drawing_bottom=request.getParameter("drawing_bottom");
						String drawing_top=request.getParameter("drawing_top");
						String drawing_lron=request.getParameter("drawing_lron");
						String type=request.getParameter("type") ;
						String product_class=request.getParameter("product_class") ;
						String product_nick=request.getParameter("product_nick") ;
						String product_pallet_sf=request.getParameter("product_pallet_sf") ;
						String twin_name=request.getParameter("twin_name") ;
						String twin_ID=request.getParameter("twin_ID") ;
						String personal_unit=request.getParameter("personal_unit") ;
						String personal_value=request.getParameter("personal_value") ;
						if(personal_value==null||personal_value.equals("")) //添加personal_value==null @xuwei
						{
							personal_value="0.0";
						} 
						personal_value=personal_value.replaceAll(",", "");
						String warranty=request.getParameter("warranty") ;
						String lifecycle=request.getParameter("lifecycle") ;
						String amount_unit=request.getParameter("amount_unit") ;
						String register=request.getParameter("register") ;
						String register_time=request.getParameter("register_time") ;
						String bodyc = new String(request.getParameter("provider_group").getBytes("UTF-8"),"UTF-8");
						String provider_group=exchange.toHtml(bodyc);
						String bodya = new String(request.getParameter("product_describe").getBytes("UTF-8"),"UTF-8");
						String product_describe=exchange.toHtml(bodya);
						try{
							String sqll="select * from design_file where C_DEFINE1='0' and product_ID='"+product_ID+"' and product_name='"+product_name+"'";
							ResultSet rset=design_db.executeQuery(sqll) ;
							if(rset.next()){

								response.sendRedirect("design/file/register_ok_a.jsp");
							}else{
								String sql;
								if(product_length==0){
									sql = "insert into design_file(chain_id,chain_name,product_ID,product_name,factory_name,product_class,type,spec_top,spec_bottom," +
											"drawing_top,drawing_bottom,drawing_lron,twin_name,twin_ID,personal_unit,personal_value,warranty,lifecycle,product_nick," +
											"list_price,cost_price,real_cost_price,register,register_time,provider_group,product_describe,check_tag,modify_tag," +
											"excel_tag,excel_tag2,excel_tag3,excel_tag4,responsible_person_name,responsible_person_ID,amount_unit,ORDER_SALE_BONUS_RATE,c_define2)" +
											" values ('"+chain_id+"','"+chain_name+"','"+product_ID+"','"+product_name+"','"+factory_name+"','"+product_class+"','"+type1+"','"+spec_top+"','"+spec_bottom+"','"+drawing_top+"','"+drawing_bottom+"','"+drawing_lron+"','"+twin_name+"','"+twin_ID+"','"+personal_unit+"','"+personal_value+"','"+warranty+"','"+lifecycle+"','"+product_nick+"','"+list_price+"','"+cost_price+"','"+cost_price+"','"+register+"','"+register_time+"','"+provider_group+"','"+product_describe+"','0','0','1','1','1','1','"+responsible_person_name+"','"+responsible_person_ID+"','"+amount_unit+"','"+shuilv+"','"+c_define2+"')" ;
								}else{
									sql = "insert into design_file(chain_id,chain_name,product_ID,product_name,factory_name,product_class,type,product_length,spec_top,spec_bottom,drawing_top,drawing_bottom,drawing_lron,twin_name,twin_ID,personal_unit,personal_value,warranty,lifecycle,product_nick,list_price,cost_price,real_cost_price,register,register_time,provider_group,product_describe,check_tag,modify_tag,excel_tag,excel_tag2,excel_tag3,excel_tag4,responsible_person_name,responsible_person_ID,amount_unit,ORDER_SALE_BONUS_RATE,product_pallet_sf,c_define2) values ('"+chain_id+"','"+chain_name+"','"+product_ID+"','"+product_name+"','"+factory_name+"','"+product_class+"','"+type1+"','"+product_length+"','"+spec_top+"','"+spec_bottom+"','"+drawing_top+"','"+drawing_bottom+"','"+drawing_lron+"','"+twin_name+"','"+twin_ID+"','"+personal_unit+"','"+personal_value+"','"+warranty+"','"+lifecycle+"','"+product_nick+"','"+list_price+"','"+cost_price+"','"+cost_price+"','"+register+"','"+register_time+"','"+provider_group+"','"+product_describe+"','0','0','1','1','1','1','"+responsible_person_name+"','"+responsible_person_ID+"','"+amount_unit+"','"+shuilv+"','"+product_pallet_sf+"','"+c_define2+"')" ;
								}
								design_db.executeUpdate(sql) ;	
								/*****************************************************/
								
								

								response.sendRedirect("design/file/register_ok.jsp");
							}
						}
						catch (Exception ex){
							ex.printStackTrace();
						}

					}else{

						response.sendRedirect("design/file/register_ok_b.jsp");
					}
				}else{

					response.sendRedirect("design/file/register_ok_c.jsp");
				}
				design_db.commit();
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