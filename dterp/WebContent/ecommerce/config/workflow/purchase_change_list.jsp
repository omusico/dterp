<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%@include file="../../include/head.jsp"%>
<%
String servlet_file="../../../ecommerce_config_workflow_purchase_change_ok";
String locate_file="purchase_change_locate.jsp";
String workflow_table="ecommerce_config_workflow";
%>
<%@include file="../../../include/workflow_change_list.jsp"%>