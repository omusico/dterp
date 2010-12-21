/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.logistics;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataTag;
import include.get_sql.getInsertSql;
import include.nseer_cookie.*;

public class change_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
counter count=new counter(dbApplication);
getInsertSql getInsertSql=new getInsertSql();
try{
if(design_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String fileKind_chain=request.getParameter("fileKind_chain");
String chain_id=Divide1.getId(fileKind_chain);
String chain_name=Divide1.getName(fileKind_chain);

String responsible_person_ID="";
String responsible_person_name="";

String product_ID=request.getParameter("product_ID") ;
String product_name=request.getParameter("product_name") ;
String factory_name=request.getParameter("factory_name") ;
String product_class=request.getParameter("product_class") ;
String product_nick=request.getParameter("product_nick") ;
String twin_name=request.getParameter("twin_name") ;
String twin_ID=request.getParameter("twin_ID") ;
String personal_unit=request.getParameter("personal_unit") ;
String personal_value=request.getParameter("personal_value") ;
if(personal_value.equals("")) personal_value ="0.00";
personal_value=personal_value.replaceAll(",", "");
String warranty=request.getParameter("warranty") ;
String lifecycle=request.getParameter("lifecycle") ;
String amount_unit=request.getParameter("amount_unit") ;
String register=request.getParameter("register") ;
String bodyc = new String(request.getParameter("provider_group").getBytes("UTF-8"),"UTF-8");
String provider_group=exchange.toHtml(bodyc);
String bodya = new String(request.getParameter("product_describe").getBytes("UTF-8"),"UTF-8");
String product_describe=exchange.toHtml(bodya);
String bodyb = new String(request.getParameter("promotion4").getBytes("UTF-8"),"UTF-8");
String promotion4=exchange.toHtml(bodyb);
String changer_ID=request.getParameter("changer_ID") ;
String changer=request.getParameter("changer") ;
String change_time=request.getParameter("change_time") ;
String lately_change_time=request.getParameter("lately_change_time") ;
String file_change_amount=request.getParameter("file_change_amount") ;
int change_amount=Integer.parseInt(file_change_amount)+1;
String column_group=getInsertSql.sql((String)dbSession.getAttribute("unit_db_name"),"design_file");
String list_price2=request.getParameter("list_price") ;
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
		if(!validata.validata(list_price)){
			n++;
		}
		if(!validata.validata(cost_price)){
			n++;
		}
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"check_tag").equals("1")){
if(n==0){
String sql2="select * from design_config_file_kind where file_id='"+chain_id+"'";
ResultSet rs2=design_db.executeQuery(sql2) ;
if(rs2.next()){

try{
	String sqloo= "select * from design_file where product_ID='"+product_ID+"'";
	 ResultSet rsoo = design_db.executeQuery(sqloo);
	 if(rsoo.next()){
	String sqll="insert into design_file_dig(CHAIN_ID,CHAIN_NAME,PRODUCT_ID,PRODUCT_NAME,PRODUCT_NICK,PRODUCT_CLASS,TYPE,AMOUNT_UNIT,PRODUCT_DESCRIBE,FACTORY_NAME,FACTORY_ID,PROVIDER_GROUP,PHOTO1,PHOTO2,WARRANTY,LIST_PRICE,COST_PRICE,REAL_COST_PRICE,LIFECYCLE,PERSONAL_UNIT,PERSONAL_VALUE,TWIN_NAME,TWIN_ID,REMARK,CHECK_TAG,ACHIEVEMENT_SUM,ATTACHMENT_NAME,RETURN_SUM,RETURN_AMOUNT,FILE_CHANGE_AMOUNT,USED_PRODUCT_NAME,RESPONSIBLE_PERSON_NAME,RESPONSIBLE_PERSON_ID,REGISTER,CHECKER,CHANGER,REGISTER_ID,CHECKER_ID,CHANGER_ID,REGISTER_TIME,CHECK_TIME,CHANGE_TIME,LATELY_CHANGE_TIME,LATELY_TRADE_TIME,DELETE_TIME,RECOVERY_TIME,MODIFY_TAG,EXCEL_TAG,EXCEL_TAG2,EXCEL_TAG3,EXCEL_TAG4,DESIGN_MODULE_TAG,DESIGN_PROCEDURE_TAG,DESIGN_CELL_TAG,RECOMMEND_PROVIDER_TAG,PRICE_CHANGE_TAG,PRICE_ALARM_TAG,promotion,opinion,promotion2,opinion2,promotion3,opinion3,promotion4,opinion4) values('"+rsoo.getString("CHAIN_ID")+"','"+rsoo.getString("CHAIN_NAME")+"','"+rsoo.getString("PRODUCT_ID")+"','"+rsoo.getString("PRODUCT_NAME")+"','"+rsoo.getString("PRODUCT_NICK")+"','"+rsoo.getString("PRODUCT_CLASS")+"','"+rsoo.getString("TYPE")+"','"+rsoo.getString("AMOUNT_UNIT")+"','"+rsoo.getString("PRODUCT_DESCRIBE")+"','"+rsoo.getString("FACTORY_NAME")+"','"+rsoo.getString("FACTORY_ID")+"','"+rsoo.getString("PROVIDER_GROUP")+"','"+rsoo.getString("PHOTO1")+"','"+rsoo.getString("PHOTO2")+"','"+rsoo.getString("WARRANTY")+"','"+rsoo.getString("LIST_PRICE")+"','"+rsoo.getString("COST_PRICE")+"','"+rsoo.getString("REAL_COST_PRICE")+"','"+rsoo.getString("LIFECYCLE")+"','"+rsoo.getString("PERSONAL_UNIT")+"','"+rsoo.getString("PERSONAL_VALUE")+"','"+rsoo.getString("TWIN_NAME")+"','"+rsoo.getString("TWIN_ID")+"','"+rsoo.getString("REMARK")+"','"+rsoo.getString("CHECK_TAG")+"','"+rsoo.getString("ACHIEVEMENT_SUM")+"','"+rsoo.getString("ATTACHMENT_NAME")+"','"+rsoo.getString("RETURN_SUM")+"','"+rsoo.getString("RETURN_AMOUNT")+"','"+rsoo.getString("FILE_CHANGE_AMOUNT")+"','"+rsoo.getString("USED_PRODUCT_NAME")+"','"+rsoo.getString("RESPONSIBLE_PERSON_NAME")+"','"+rsoo.getString("RESPONSIBLE_PERSON_ID")+"','"+rsoo.getString("REGISTER")+"','"+rsoo.getString("CHECKER")+"','"+rsoo.getString("CHANGER")+"','"+rsoo.getString("REGISTER_ID")+"','"+rsoo.getString("CHECKER_ID")+"','"+rsoo.getString("CHANGER_ID")+"','"+rsoo.getString("REGISTER_TIME")+"','"+rsoo.getString("CHECK_TIME")+"','"+rsoo.getString("CHANGE_TIME")+"','"+rsoo.getString("LATELY_CHANGE_TIME")+"','"+rsoo.getString("LATELY_TRADE_TIME")+"','"+rsoo.getString("DELETE_TIME")+"','"+rsoo.getString("RECOVERY_TIME")+"','"+rsoo.getString("MODIFY_TAG")+"','"+rsoo.getString("EXCEL_TAG")+"','"+rsoo.getString("EXCEL_TAG2")+"','"+rsoo.getString("EXCEL_TAG3")+"','"+rsoo.getString("EXCEL_TAG4")+"','"+rsoo.getString("DESIGN_MODULE_TAG")+"','"+rsoo.getString("DESIGN_PROCEDURE_TAG")+"','"+rsoo.getString("DESIGN_CELL_TAG")+"','"+rsoo.getString("RECOMMEND_PROVIDER_TAG")+"','"+rsoo.getString("PRICE_CHANGE_TAG")+"','"+rsoo.getString("PRICE_ALARM_TAG")+"','"+rsoo.getString("promotion")+"','"+rsoo.getString("opinion")+"','"+rsoo.getString("promotion2")+"','"+rsoo.getString("opinion2")+"','"+rsoo.getString("promotion3")+"','"+rsoo.getString("opinion3")+"','"+rsoo.getString("promotion4")+"','"+rsoo.getString("opinion4")+"')";
		design_db.executeUpdate(sqll);
	 }
	String sql = "update design_file set chain_id='"+chain_id+"',chain_name='"+chain_name+"',product_name='"+product_name+"',factory_name='"+factory_name+"',product_class='"+product_class+"',twin_name='"+twin_name+"',twin_ID='"+twin_ID+"',personal_unit='"+personal_unit+"',personal_value='"+personal_value+"',warranty='"+warranty+"',lifecycle='"+lifecycle+"',product_nick='"+product_nick+"',list_price='"+list_price+"',cost_price='"+cost_price+"',provider_group='"+provider_group+"',product_describe='"+product_describe+"',responsible_person_name='"+responsible_person_name+"',responsible_person_ID='"+responsible_person_ID+"',amount_unit='"+amount_unit+"',changer_ID='"+changer_ID+"',changer='"+changer+"',change_time='"+change_time+"',lately_change_time='"+lately_change_time+"',file_change_amount='"+change_amount+"',promotion4='"+promotion4+"',check_tag='0',excel_tag4='1' where product_ID='"+product_ID+"'";
	design_db.executeUpdate(sql) ;


	sql="delete from design_workflow where object_id='"+product_ID+"'";
	design_db.executeUpdate(sql);
	List rsList = GetWorkflow.getList(design_db, "design_config_workflow", "01");
	if(rsList.size()==0){//产品档案无工作流
		sql="update design_file set check_tag='1' where product_ID='"+product_ID+"'";
		design_db.executeUpdate(sql);
		sql="delete from ecommerce_workflow where object_id='"+product_ID+"' and type_id='05'";
		design_db.executeUpdate(sql);
		List rsList1 = GetWorkflow.getList(design_db, "ecommerce_config_workflow", "05");
		if(rsList1.size()==0){//电子商务的配送信息的发布审核无工作流
			sql = "update design_file set excel_tag4='3' where product_ID='"+product_ID+"'" ;//excel_tag为3表示所有审核工作流审核通过
			design_db.executeUpdate(sql);
     	}else{
			Iterator ite=rsList1.iterator();
			while(ite.hasNext()){
				String[] elem=(String[])ite.next();
				sql = "insert into ecommerce_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+product_ID+"','"+elem[1]+"','"+elem[2]+"','05')" ;
				design_db.executeUpdate(sql);
			}
		}
	}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into design_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+product_ID+"','"+elem[1]+"','"+elem[2]+"','01')" ;
		design_db.executeUpdate(sql);
		}
	}	

}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("ecommerce/logistics/change_choose_attachment.jsp?product_ID="+product_ID+"");
}else{
	response.sendRedirect("ecommerce/logistics/change_ok_a.jsp?product_ID="+product_ID+"");
	}
}else{
response.sendRedirect("ecommerce/logistics/change_ok_b.jsp?product_ID="+product_ID+"");
}}else{
response.sendRedirect("ecommerce/logistics/change_ok_c.jsp");
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