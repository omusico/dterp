<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java"
	import="filetree.*,include.operateXML.*"%>
<script type="text/javascript"
	src="../../javascript/include/my/pageplubin.js"></script>
<%
	ServletContext context_s = session.getServletContext();
	String path_s = context_s.getRealPath("/");
	String userName_s = (String) session.getAttribute("userName");
	String xmlFile_s = "xml/include/listPage/" + userName_s
			+ session.getId() + ".xml";
	String url_s = request.getRequestURI();

	//String sql_xml="";
	//String strPage_xml="";
	String otherButtons = "";
	//Reading reader=new Reading(xmlFile_s);
	//boolean flag_search=false;
	//String inputTextId1="keyword";
	//String inputTextId2="keyword_chain";
	//String inputTextId3="div_keyword";
	//String searchTag="searchTag";
	String sql_search = "";
	///String keyword="";
	//int search_init=0;
	String strPage = request.getParameter("page");
	String pageSize_temp = request.getParameter("pageSize");
	//String readXml=request.getParameter("readXml");
	int intRowCount = 0;
	int pageSize = 25;
	if (pageSize_temp != null && !pageSize_temp.equals("")) {
		pageSize = Integer.parseInt(pageSize_temp);
	}
	pageContext.setAttribute("pageSize", new Integer(pageSize)
			.toString());
	try {
		//File f=new File(path_s+xmlFile_s);
		//if(f.exists()){
		//if(reader.getAttributeByAttribute("sql","url:"+url_s).size()!=0){
		//	flag_search=true;
		//sql_xml=(String)(reader.getAttributeByAttribute("sql","url:"+url_s).get(0));
		//strPage_xml=(String)(reader.getAttributeByAttribute("pageno","url:"+url_s).get(0));
		//}

		//keyword=request.getParameter(inputTextId2);
		//String searchTag1=request.getParameter(searchTag);
		//if(keyword==null){keyword="";}else{search_init++;}
		//if(!flag_search&&readXml==null||readXml!=null&&readXml.equals("n")||search_init!=0){
		//if(searchTag1==null){
		//sql_search=NseerSql.getRegularSql((String)session.getAttribute("unit_db_name"),tablename,keyword,condition,queue);
		//}
		//}else if(flag_search&&readXml==null&&strPage==null){
		//	sql_search=sql_xml;
		//	strPage=strPage_xml;
		//}else if(flag_search&&readXml==null&&strPage!=null){
		//	sql_search=sql_xml;
		//}else{
		//	sql_search=sql_xml;
		//	strPage=strPage_xml;
		//}
		nseer_db db = new nseer_db((String) session
		.getAttribute("unit_db_name"));
		//String sql_search1=sql_search.replace("*","id");

		ResultSet rs_search = db.executeQuery(my_sql_search);
		if (rs_search.next()) {
			rs_search.last();
			intRowCount = rs_search.getRow();//获取查询的行数
		}
		int maxPage = (intRowCount + pageSize - 1) / pageSize;
		if (strPage == null || strPage != null && strPage.equals("")
		&& !validata.validata(strPage)) {
			strPage = "1";
		} else if (Integer.parseInt(strPage) <= 0) {
			strPage = "1";
		} else if (maxPage > 0 && Integer.parseInt(strPage) > maxPage) {
			strPage = maxPage + "";
		}
		//if(reader.getAttributeByAttribute("sql","url:"+url_s).size()==0){
		//Inserting ins_xml=new Inserting();
		//String[] col_ele={"url","sql","pageno"};
		//String[] col_value={url_s,sql_search,strPage};
		//String[] v_value={};
		//ins_xml.addColXML(path_s+xmlFile_s,col_ele,col_value,v_value);
		//}else{
		//Updating update_xml=new Updating();
		//update_xml.editXML(path_s+xmlFile_s,"url",url_s,"sql",sql_search);
		//update_xml.editXML(path_s+xmlFile_s,"url",url_s,"pageno",strPage);
		//}
		db.close();
		sql_search = my_sql_search + " limit "
		+ (Integer.parseInt(strPage) - 1) * pageSize + ","
		+ pageSize;
		strPage = strPage + "⊙" + maxPage;

	} catch (Exception e) {
		e.printStackTrace();
	}
%>
