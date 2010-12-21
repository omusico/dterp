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
	import="java.sql.*" import="java.util.*" import="java.io.*"
	import="include.nseer_cookie.*" import="include.nseer_db.*,java.text.*"%>
<%
nseer_db manufacture_db = new nseer_db((String) session.getAttribute("unit_db_name"));
nseer_db manufacture_db1 = new nseer_db((String) session.getAttribute("unit_db_name"));
%>
<script language="javascript" src="../../javascript/newWindow.js" ></script>
<jsp:useBean id="query" scope="page" class="include.query.query" />
<jsp:useBean id="validata" scope="page" class="validata.ValidataNumber" />
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment"
	scope="page" />
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page" />
<jsp:useBean id="mask" class="include.operateXML.Reading" />
<jsp:setProperty name="mask" property="file"
	value="xml/design/design_file.xml" />
<%
	String mod = request.getRequestURI();
	demo.setPath(request);
	String handbook = demo.businessComment(mod, "您正在做的业务是：",
			"document_main", "reason", "value");
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
		<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
		<div class="div_handbook"><%="您正在做的业务是：生产管理--生产计划管理--商品添加"%></div>
		</td>
	</tr>
</table>

<script src="../../javascript/table/movetable.js">
</script>


<script language="javascript" src="../../javascript/edit/editTable.js">
</script>
<script language="javascript">


function addInstanceRow(objTable,Names,Values){
 var tbodyOnlineEdit=objTable.getElementsByTagName("TBODY")[0];
 var theadOnlineEdit=objTable.getElementsByTagName("THEAD")[0];
 var elm = theadOnlineEdit.lastChild.cloneNode(true);
 elm.style.display="";
 for(var i=0;i<Names.length;i++){

 setInputValue(elm,Names[i],Values[i]);
tbodyOnlineEdit.insertBefore(elm);
 }	  
 //window.opener.product_describe_ok[0].innerHTML=pro_value;
k++;
 
}







//var tableEdit=winopener.document.getElementsByTagName("form")[0];
//var edit=tableEdit.getElementsByTagName("TABLE")[0];
var edit=window.opener.tableOnlineEdit1;//表单名

//添加商品方法（参数与列名对应）
function addGoodsItem(product_namea, product_IDa, product_describea, amounta, amount_unita, cost_pricea,product_spec_ida) {


//暂时无用
var  product_name=product_namea.replace(/★/g,"<br>").replace(/☆/g," ");
var  describe=product_describea.replace(/★/g,"<br>").replace(/☆/g," ");
var  amount_unit=amount_unita.replace(/★/g,"<br>").replace(/☆/g," ");
var trOnlineEdits=edit.getElementsByTagName("tr");//得到表格所有行
  var flag=true;
 
  for(var x=0;x<trOnlineEdits.length;x++){
    var tdOnlineEdits=trOnlineEdits[x].getElementsByTagName("td");//得到表格所有单元格
    
    if(tdOnlineEdits[1].childNodes[0].value==product_name){
   	  flag=false;//该行数据已存在
    }
  }
//表单中需要更新的列
var values=[product_name, product_IDa, describe,describe,amounta, amount_unita, cost_pricea,product_spec_ida];
//表单中需要更新的列
var names=['product_name','product_ID','product_describe2','product_describe','amount','amount_unit','cost_price','product_spec_id']; 


if(flag){
//alert(product_spec_ida);
//表单中需要更新的列
 if(checkRow(edit,values[0])) {
 addInstanceRow(edit,names,values);
 }
}
}
//添加商品方法（参数与列名对应）
function addGoodsItemd(product_namea, product_IDa, product_describea, amounta, amount_unita, cost_pricea,product_spec_ida) {


//暂时无用
var  product_name=product_namea.replace(/★/g,"<br>").replace(/☆/g," ");
var  describe=product_describea.replace(/★/g,"<br>").replace(/☆/g," ");
var  amount_unit=amount_unita.replace(/★/g,"<br>").replace(/☆/g," ");
var trOnlineEdits=edit.getElementsByTagName("tr");//得到表格所有行
  var flag=true;
//表单中需要更新的列
var values=[product_name, product_IDa, describe,describe,amounta, amount_unita, cost_pricea,product_spec_ida];
//表单中需要更新的列
var names=['product_name','product_ID','product_describe2','product_describe','amount','amount_unit','cost_price','product_spec_id']; 


if(flag){

//表单中需要更新的列
 
 addInstanceRow(edit,names,values);
 
}
}



</script>
<%	
	String first_state="0";//0——第一次加载，1——再次加载
	if(request.getParameter("specString")!=null){
		first_state="1";
	}
	String product_type=request.getParameter("p_t");
	int p_t=Integer.parseInt(product_type)-1;//0-原纸，1-4分切，2-8mm切，3-打孔
	//条件是产品业务状态是0（0->在库，1->生产中，2->生产完成，3->转换，4->废弃）的该类型原料
	String my_sql_search ="";
	String my_condition = " d.check_tag=1 and d.type=(select id from design_config_public_char where type_name='纸类型')";
	if(product_type.equals("1")){ 
		//4分切生产画面
		//正品仓101+原纸临时仓102
		my_sql_search = "SELECT d.product_name,d.id,count(pi.product_spec_id) as num,d.type FROM"
				+" (select product_spec_id from  product_info p"
				+" where p.product_type="+p_t+" and (p.product_status=1 or p.product_status=3) and (stock_id='101' or stock_id='102')) pi"
				+" right join design_file as d on d.id=pi.product_spec_id where "
				+my_condition+" group by d.id ";
		
	}else if(product_type.equals("2")){
		//8mm
		//103 四分切临时仓 （还需查询102*4）
		my_sql_search = "SELECT d.product_name,d.id,count(pi.product_spec_id) as num,d.type FROM"
			+" (select product_spec_id from  product_info p"
			+" where p.product_type="+p_t+" and (p.product_status=1 or p.product_status=3) and stock_id='103') pi"
			+" right join design_file as d on d.id=pi.product_spec_id where "
			+my_condition+" group by d.id ";
	}else if(product_type.equals("3")){
		//打孔
		//104 8mm切临时仓(下层)+105 8mm切临时仓(上层) （还需103*20+102*4*20）
		my_sql_search = "SELECT d.product_name,d.id,count(pi.product_spec_id) as num,d.type FROM"
			+" (select product_spec_id from  product_info p"
			+" where p.product_type="+p_t+" and (p.product_status=1 or p.product_status=3) and (stock_id='104' or stock_id='105')) pi"
			+" right join design_file as d on d.id=pi.product_spec_id where "
			+my_condition+" group by d.id ";
	}
	String specString="";
	if (request.getParameter("specString") != null&&request.getParameter("specString").length() > 0) {
		my_sql_search += " having d.product_name like'%"+ request.getParameter("specString") + "%' ";
		specString=request.getParameter("specString");
	}
	
	
	
	String register_ID = (String) session.getAttribute("human_ID");
	String realname = (String) session.getAttribute("realeditorc");
	String rowSummary = demo.getLang("erp", "符合条件的信息总数");

	String tablename = "product_info";
	String condition = "";
	String queue = "";
	String validationXml = "";
	String nickName = "";
	String fileName = "newRegister_product_list.jsp";
	int k = 0;
%>

<%@include file="../../include/search_my.jsp"%>
<%--@include file="../../include/search.jsp"--%>
<%
		try {
		ResultSet rs1 = manufacture_db.executeQuery(sql_search);
%>
<%-- 
<%@include file="../../include/search_top.jsp" %>
--%>
<form action="newRegister_product_list.jsp?p_t=<%=product_type %>" method="post" name="search_form" id="search_form">
<table width="98%" style="text-align: right;" align="center">
	<tr>
		<td>原纸规格： <input type="text" size="40" name="specString" value="<%=specString %>"/>
		<input type="hidden" name="p_t" value="<%=product_type%>"> 
		<input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>"></td>
	</tr>
</table>
</form>
<div id="nseer_grid_div"></div>
<%if(first_state.equals("0")){rs1=null;} %>
<%if(product_type.equals("1")){ //4分切生产画面%>
<script type="text/javascript">

var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","原纸规格")%>'},
                       {name: '<%=demo.getLang("erp","库存数量(本)")%>'},
                       {name: '<%=demo.getLang("erp","选择")%>'}
]
nseer_grid.column_width=[200,120,60];
nseer_grid.auto='<%=demo.getLang("erp","原纸规格")%>';
nseer_grid.data = [

<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 

['<%=rs1.getString("d.product_name") %>',
'<%=rs1.getString("num") %>',
'<div style="text-decoration : underline;color:#3366FF;CURSOR: hand;" onclick=addGoodsItem("<%=exchange.unHtmls(rs1.getString("d.product_name"))%>","<%=exchange.unHtmls(rs1.getString("num"))%>","<%=exchange.unHtmls("1")%>","1","<%=exchange.unHtmls(exchange.toHtml("1"))%>","<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(1.00)%>","<%=rs1.getString("d.id")%>")><%=demo.getLang("erp","选择")%></div>'],
	
<%k++;%>
</page:pages>

['']];
nseer_grid.init();
function init_div(){
	var height=document.getElementById("nseergrid").style.height;
	
	document.getElementById("nseergrid").style.height=parseInt(height)-40;
	document.getElementById("nseer_grid_div").style.left=10;
	document.getElementById("nseer_grid_nseer_xbar").style.top = nseer_grid.int(document.getElementById("nseergrid").style.height) - (nseer_grid.scroll_w - 1);
}
init_div();
var isIE=document.all?true:false;
if(isIE){
	    	window.attachEvent('onresize', init_div);
}else if(!isIE){
		    window.addEventListener('resize',init_div, false);
}
</script>
<%}else if(product_type.equals("2")){//8mm切%>
<script type="text/javascript">

var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","原纸规格")%>'},
                       {name: '<%=demo.getLang("erp","库存数量(丁)")%>'},
                       {name: '<%=demo.getLang("erp","选择")%>'}
]
nseer_grid.column_width=[200,120,60];
nseer_grid.auto='<%=demo.getLang("erp","原纸规格")%>';
nseer_grid.data = [

<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%
int all=Integer.parseInt(rs1.getString("num"));
int num1=0;
String num_search = "SELECT d.product_name,count(pi.product_spec_id) as num,d.type FROM"
	+" (select product_spec_id from  product_info p"
	+" where p.product_type=0 and (p.product_status=1 or p.product_status=3) and stock_id='102') pi"
	+" right join design_file as d on d.id=pi.product_spec_id where "
	+my_condition+" group by d.id having d.product_name = '"+rs1.getString("d.product_name")+"'";

ResultSet rs_num1=manufacture_db1.executeQuery(num_search);
if(rs_num1.next()){
	num1=Integer.parseInt(rs_num1.getString("num"));
	all=all+num1*4;
}
%>
['<%=rs1.getString("d.product_name") %>',
'<%=all %>',
'<div style="text-decoration : underline;color:#3366FF;CURSOR: hand;" onclick=addGoodsItem("<%=exchange.unHtmls(rs1.getString("d.product_name"))%>","1","<%=exchange.unHtmls("0")%>","<%=exchange.toHtml("1")%>","<%=exchange.unHtmls(exchange.toHtml("1"))%>","<%=exchange.unHtmls(String.valueOf(all))%>","<%=rs1.getString("d.id")%>")><%=demo.getLang("erp","选择")%></div>'],

<%k++;%>
</page:pages>

['']];
nseer_grid.init();
function init_div(){
	var height=document.getElementById("nseergrid").style.height;
	
	document.getElementById("nseergrid").style.height=parseInt(height)-40;
	document.getElementById("nseer_grid_div").style.left=10;
	document.getElementById("nseer_grid_nseer_xbar").style.top = nseer_grid.int(document.getElementById("nseergrid").style.height) - (nseer_grid.scroll_w - 1);
}
init_div();
var isIE=document.all?true:false;
if(isIE){
	    	window.attachEvent('onresize', init_div);
}else if(!isIE){
		    window.addEventListener('resize',init_div, false);
}
</script>	
	<%
}else if(product_type.equals("3")){//打孔
	%>
<script type="text/javascript">

var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","原纸规格")%>'},
                       {name: '<%=demo.getLang("erp","库存数量(卷)")%>'},
                       {name: '<%=demo.getLang("erp","选择")%>'}
]
nseer_grid.column_width=[200,120,60];
nseer_grid.auto='<%=demo.getLang("erp","原纸规格")%>';
nseer_grid.data = [

<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%
int all=Integer.parseInt(rs1.getString("num"));
int num1=0;
String num_search1 = "SELECT d.product_name,count(pi.product_spec_id) as num,d.type FROM"
	+" (select product_spec_id from  product_info p"
	+" where p.product_type=0 and (p.product_status=1 or p.product_status=3) and stock_id='102') pi"
	+" right join design_file as d on d.id=pi.product_spec_id where "
	+my_condition+" group by d.id having d.product_name = '"+rs1.getString("d.product_name")+"'";

ResultSet rs_num1=manufacture_db1.executeQuery(num_search1);
if(rs_num1.next()){
	num1=Integer.parseInt(rs_num1.getString("num"));
	all=all+num1*4*20;
}
int num2=0;
String num_search2 = "SELECT d.product_name,count(pi.product_spec_id) as num,d.type FROM"
	+" (select product_spec_id from  product_info p"
	+" where p.product_type=1 and (p.product_status=1 or p.product_status=3) and stock_id='103') pi"
	+" right join design_file as d on d.id=pi.product_spec_id where "
	+my_condition+" group by d.id having d.product_name = '"+rs1.getString("d.product_name")+"'";

ResultSet rs_num2=manufacture_db1.executeQuery(num_search2);
if(rs_num2.next()){
	num2=Integer.parseInt(rs_num2.getString("num"));
	all=all+num2*20;
}
%>
['<%=rs1.getString("d.product_name") %>',
'<%=all %>',
'<div style="text-decoration : underline;color:#3366FF;CURSOR: hand;" onclick=addGoodsItemd("<%=exchange.unHtmls(rs1.getString("d.product_name"))%>","<%=exchange.unHtmls("选择模具类型")%>","<%=exchange.unHtmls("1")%>","1","<%=exchange.unHtmls(exchange.toHtml("选择客户"))%>","<%=exchange.unHtmls(String.valueOf(all))%>","<%=rs1.getString("d.id")%>")><%=demo.getLang("erp","选择")%></div>'],
	
<%k++;%>
</page:pages>

['']];
nseer_grid.init();
function init_div(){
	var height=document.getElementById("nseergrid").style.height;
	
	document.getElementById("nseergrid").style.height=parseInt(height)-40;
	document.getElementById("nseer_grid_div").style.left=10;
	document.getElementById("nseer_grid_nseer_xbar").style.top = nseer_grid.int(document.getElementById("nseergrid").style.height) - (nseer_grid.scroll_w - 1);
}
init_div();
var isIE=document.all?true:false;
if(isIE){
	    	window.attachEvent('onresize', init_div);
}else if(!isIE){
		    window.addEventListener('resize',init_div, false);
}
</script>
	<%
}%>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%--@include file="../../include/search_bottom.jsp"--%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>" />
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<%
	manufacture_db.close();
	manufacture_db1.close();
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>
<%@include file="../../include/head_msg.jsp"%>
