/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.other;

import include.nseer_cookie.*;
import include.nseer_db.nseer_db_backup1;
import java.io.IOException;
import java.sql.ResultSet;
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
import com.jspsmart.upload.SmartUpload;

public class register_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{

HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
SmartUpload mySmartUpload=new SmartUpload();
mySmartUpload.setCharset("UTF-8");
counter count=new counter(dbApplication);
nseer_db_backup1 ecommerce_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 ecommerce_db1 = new nseer_db_backup1(dbApplication);
if(ecommerce_db.conn((String)dbSession.getAttribute("unit_db_name"))&&ecommerce_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
mySmartUpload.initialize(pageContext);
String file_type=getFileLength.getFileType((String)session.getAttribute("unit_db_name"));
long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
mySmartUpload.setMaxFileSize(d);
mySmartUpload.setAllowedFilesList(file_type);
try{
mySmartUpload.upload();
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
String topic = mySmartUpload.getRequest().getParameter("topic");
String filekind_chain=mySmartUpload.getRequest().getParameter("filekind_chain");
String chain_id=Divide1.getId(filekind_chain);
String chain_name=Divide1.getName(filekind_chain);
String register = mySmartUpload.getRequest().getParameter("register");
String register_ID = mySmartUpload.getRequest().getParameter("register_ID");
String register_time = mySmartUpload.getRequest().getParameter("register_time");
String content = new String(mySmartUpload.getRequest().getParameter("content").getBytes("UTF-8"),"UTF-8");
String sql1="select * from ecommerce_other where chain_id='"+chain_id+"' and chain_name='"+chain_name+"' and check_tag='1'";
ResultSet rs=ecommerce_db.executeQuery(sql1);
if(chain_id.equals("02")&&!rs.next()||!chain_id.equals("02")){
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	com.jspsmart.upload.SmartFile file = mySmartUpload.getFiles().getFile(i);
	if (file.isMissing()){
		file_name[i]="";
		continue;
	}
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"ecommerceAttachmentcount");
	count.write((String)dbSession.getAttribute("unit_db_name"),"ecommerceAttachmentcount",filenum);
	file_name[i]=filenum+file.getFileName();
	file.saveAs(path+"ecommerce\\file_attachments\\" + filenum+file.getFileName());
}
String other_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
String sqla="";
String sqlb ="";
if(chain_id.equals("02")) {
	 sqla = "insert into ecommerce_other(register,register_ID,register_time,other_ID,topic,content,chain_id,chain_name";
	 sqlb = ") values ('"+register+"','"+register_ID+"','"+register_time+"','"+other_ID+"','"+topic+"','"+content+"','"+chain_id+"','"+chain_name+"'" ;
}else{
	sqla = "insert into ecommerce_other(register,register_ID,register_time,other_ID,topic,content,chain_id,chain_name";
	sqlb = ") values ('"+register+"','"+register_ID+"','"+register_time+"','"+other_ID+"','"+topic+"','"+content+"','"+chain_id+"','"+chain_name+"'" ;
}
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	int p=i+1;
	sqla=sqla+",attachment"+p;
	sqlb=sqlb+",'"+file_name[i]+"'";
}
String sql=sqla+sqlb+")";
	ecommerce_db.executeUpdate(sql) ;
 sql="update ecommerce_config_other_kind set delete_tag='1' where file_id='"+chain_id+"'";
	ecommerce_db.executeUpdate(sql);//delete_tag为1说明分类被使用	
		List rsList = (List)new java.util.ArrayList();
	String[] elem=new String[3];
	 sql="select id,describe1,describe2 from ecommerce_config_workflow where type_id='08'";
	ResultSet rset=ecommerce_db.executeQuery(sql);
	while(rset.next()){
		elem=new String[3];
		elem[0]=rset.getString("id");
		elem[1]=rset.getString("describe1");
		elem[2]=rset.getString("describe2");
		rsList.add(elem);
	}
	if(rsList.size()==0){
		sql="update ecommerce_other set check_tag='1',excel_tag='3' where other_ID='"+other_ID+"'";
		ecommerce_db.executeUpdate(sql) ;
}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into ecommerce_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+other_ID+"','"+elem[1]+"','"+elem[2]+"','08')" ;
		ecommerce_db.executeUpdate(sql) ;
		}
	}
response.sendRedirect("ecommerce/other/register_ok_b.jsp");
}else{
	response.sendRedirect("ecommerce/other/register_ok_d.jsp");
}
	ecommerce_db.commit();
	ecommerce_db1.commit();
	ecommerce_db.close();
	ecommerce_db1.close();
}catch(Exception ex){
	response.sendRedirect("ecommerce/other/register_ok_a.jsp");
}
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
	}
}
}