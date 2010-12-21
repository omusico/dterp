<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db mold_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../javascript/newWindow.js" ></script>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/design/design_file.xml"/>
<% String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>

 <%
		if(strhead.indexOf(browercheck.IE)==-1){
%>
<script src="../../javascript/table/movetable.js">
</script>

<script type="text/javascript">

var xmlHttp;

var product_ID;

var product_name;

var product_describe;

var amount;

var amount_unit;

var real_cost_price;

var type;

var EMP_PREFIX = "emp-";

//*********************************************
function createXMLHttpRequest() {

if (window.ActiveXObject) {

xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

} 

else if (window.XMLHttpRequest) {

xmlHttp = new XMLHttpRequest();

}

}
//*********************************************
function addGoodsItem(product_namea, product_IDa, product_describea, amounta, amount_unita,real_cost_pricea, typea) {
 describe=product_describea.replace(/★/g,"<br>").replace(/☆/g," ");
 product_name=product_namea.replace(/★/g,"<br>").replace(/☆/g," ");
 amount_unit=amount_unita.replace(/★/g,"<br>").replace(/☆/g," ");
 type=typea.replace(/★/g,"<br>").replace(/☆/g," ");

var checkrow=window.opener.document.getElementById("mutiValidation");
var valuew = checkrow.product_ID;


for (var i=0; i<valuew.length; i++) {
 if(valuew[i].value==product_IDa){
return;
 }

}


product_ID =product_IDa;
product_describe =describe;
amount = amounta;
real_cost_price=real_cost_pricea;

	
action = "add";

var url = "../../include_ajax_GetXml?" 

+ createAddQueryString(product_name, product_ID, product_describe, amount, amount_unit,real_cost_price, type, "add") 

+ "&ts=" + new Date().getTime();

createXMLHttpRequest();

xmlHttp.onreadystatechange = handleAddStateChange;

xmlHttp.open("GET", url, true);

xmlHttp.send(null);

}

//*********************************************
function createAddQueryString(product_name, product_ID, product_describe, amount, amount_unit,real_cost_price, type, action) {

var queryString = "product_name=" + product_name 

+ "product_ID=" + product_ID

+ "product_describe=" + product_describe

+ "amount=" + amount

+ "amount_unit=" + amount_unit

+ "real_cost_price=" + real_cost_price

+ "type=" + type

+ "&action=" + action;

return queryString;

}
//*********************************************
//回调方法 
function handleAddStateChange() {

if(xmlHttp.readyState == 4) {

if(xmlHttp.status == 200) {

updateChoiceList();

clearInputBoxes();

}

else {

alert("Error while adding .");

}

}

}

function updateChoiceList() {

var responseXML = xmlHttp.responseXML;

var status = responseXML.getElementsByTagName("status").item(0).firstChild.nodeValue;

status = parseInt(status);

if(status != 1) {

return;

}
var row = document.createElement("tr");

responseXML.getElementsByTagName("uniqueID")[0].firstChild.nodeValue;
//*********************************************
var deleteButto = document.createElement("input");

deleteButto.setAttribute("type", "checkbox");

deleteButto.setAttribute("name", "checkbox");

var cell = document.createElement("td");

cell.appendChild(deleteButto);

row.appendChild(cell);
//*********************************************

var deleteButton3 = document.createElement("input");

deleteButton3.setAttribute("type", "hidden");

deleteButton3.setAttribute("name", "product_describe");

deleteButton3.setAttribute("value", product_describe);

cell.appendChild(deleteButton3);

row.appendChild(cell);

//*********************************************
var deleteButton4 = document.createElement("input");

deleteButton4.setAttribute("type", "hidden");

deleteButton4.setAttribute("name", "amount_unit");

deleteButton4.setAttribute("value", amount_unit);

cell.appendChild(deleteButton4);

row.appendChild(cell);

//*********************************************

var deleteButton7 = document.createElement("input");

deleteButton7.setAttribute("type", "hidden");

deleteButton7.setAttribute("name", "type");

deleteButton7.setAttribute("value", type);

cell.appendChild(deleteButton7);

row.appendChild(cell);

//*********************************************

var deleteButton41 = document.createElement("input");

deleteButton41.setAttribute("type", "text");

deleteButton41.setAttribute("name", "product_name");

deleteButton41.setAttribute("value", product_name);

deleteButton41.setAttribute("onFocus","this.blur()");

deleteButton41.setAttribute("class","INPUT_STYLE4");



cell = document.createElement("td");

cell.appendChild(deleteButton41);

row.appendChild(cell);


//row.appendChild(createCellWithText(product_name));

var deleteButton51 = document.createElement("input");

deleteButton51.setAttribute("type", "text");

deleteButton51.setAttribute("name", "product_ID");

deleteButton51.setAttribute("value", product_ID);

deleteButton51.setAttribute("onFocus","this.blur()");

deleteButton51.setAttribute("class","INPUT_STYLE4");


cell = document.createElement("td");

cell.appendChild(deleteButton51);

row.appendChild(cell);

var deleteButton61 = document.createElement("div");

deleteButton61.innerHTML=product_describe;

cell = document.createElement("td");

cell.appendChild(deleteButton61);

row.appendChild(cell);

//*********************************************
var deleteButton5 = document.createElement("input");

deleteButton5.setAttribute("type", "text");

deleteButton5.setAttribute("name", "amount");

deleteButton5.setAttribute("value", amount);

deleteButton5.setAttribute("class", "INPUT_STYLE5");

cell = document.createElement("td");

cell.appendChild(deleteButton5);

row.appendChild(cell);

row.appendChild(createCellWithText(amount_unit));


var deleteButton6 = document.createElement("input");

deleteButton6.setAttribute("type", "text");

deleteButton6.setAttribute("name", "real_cost_price");

deleteButton6.setAttribute("value", real_cost_price);

deleteButton6.setAttribute("class", "INPUT_STYLE5");

cell = document.createElement("td");

cell.appendChild(deleteButton6);

row.appendChild(cell);



var edit=window.opener.document.getElementById("tableOnlineEdit");

edit.appendChild(row);



updateChoiceListVisibility();
}

//*********************************************
function createCellWithText(text) {

cell = document.createElement("td");

cell.appendChild(document.createTextNode(text));

return cell;

}

//*********************************************
function updateChoiceListVisibility() {
var editt=window.opener.document.getElementById("tableOnlineEdit");
var choiceList = editt.getElementById("choiceList");
if(choiceList.childNodes.length> 0) {
editt.getElementById("choiceListSpan").style.display = "";
}else{
editt.getElementById("choiceListSpan").style.display = "none";
}
}
</script>
<script language="javascript" src="../../javascript/edit/editTable.js">
</script>
<%
String tablename="design_file";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and (type='外购商品' or type='物料')";
String queue="order by register_time";
String validationXml="../../xml/design/design_file.xml";
String nickName="产品档案";
String fileName="newRegister_product_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的产品档案总数");
%>
<%@include file="../../include/search.jsp"%>
<%try{
ResultSet rs1=mold_db.executeQuery(sql_search);
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","模具退格")%>'}
]
nseer_grid.column_width=[180,200,70,70,100,70];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 

['<%=rs1.getString("product_ID")%>','<%=rs1.getString("product_name")%>','<%=rs1.getString("type")%>','<%=rs1.getString("amount_unit")%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("real_cost_price"))%>',
	<%if(rs1.getString("price_alarm_tag").equals("0")){%>
	'<div style="text-decoration : underline;color:#3366FF;CURSOR: hand;" onclick=addGoodsItem("<%=exchange.unHtmls(exchange.toHtml(rs1.getString("product_name")))%>","<%=rs1.getString("product_ID")%>","<%=exchange.unHtmls(rs1.getString("product_describe"))%>","1","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("amount_unit")))%>","<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("real_cost_price"))%>","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("type")))%>")><%=demo.getLang("erp","采购")%></div>'
	<%}else{%>
		'<%=demo.getLang("erp","价格调整")%>'
	<%}%>],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%mold_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>
<%
}else{%>

<script src="../../javascript/table/movetable.js">
</script>
<script language="javascript" src="../../javascript/edit/editTable.js">
</script>

<script>
function checkRow(objTable,unique) {

 var tbodyOnlineEdit=objTable.getElementsByTagName("thead")[0];
var tbodyEdit=objTable.getElementsByTagName("TBODY")[0];//js添加
 ////alert(objTable.innerHTML);
 ////alert(tbodyOnlineEdit.children.length);//
 for (var i=3; i<tbodyOnlineEdit.children.length; i++){
  var temp=tbodyOnlineEdit.children[i].childNodes[1].childNodes[0].value;
  // //alert(unique+":"+temp);
  //if(unique==temp) return false;
 }
 
for (var j=tbodyEdit.children.length-1; j>=0 ; j-- ){
   var temp2=tbodyEdit.children[j].childNodes[1].childNodes[0].value;
   ////alert(unique+":"+temp);
  // if(unique==temp2) return false;
 }
 
 
return true; 
}
</script>
<script language="javascript">
//var tableEdit=winopener.document.getElementsByTagName("form")[0];
//var edit=tableEdit.getElementsByTagName("TABLE")[0];
var z=1;
var n=0;//?
<%
if(request.getParameter("number")!=null&&request.getParameter("number").length()>0)//?
{
%>n=<%=Integer.parseInt(request.getParameter("number"))%><%;}%>


var edit=window.opener.tableOnlineEdit;

var names=['id','product_name','spec_top','spec_bottom','drawing_top','drawing_bottom','drawing_lron'];
function addGoodsItem(ida,product_namea, spec_topa, spec_bottoma, drawing_topa, drawing_bottoma,drawing_lrona) {

//alert(edit.innerHTML);

    var id=ida.replace(/★/g,"<br>").replace(/☆/g," ");
	var product_name=product_namea.replace(/★/g,"<br>").replace(/☆/g," ");
	var spec_top=spec_topa.replace(/★/g,"<br>").replace(/☆/g," ");
	var spec_bottom=spec_bottoma.replace(/★/g,"<br>").replace(/☆/g," ");
	var drawing_top=drawing_topa.replace(/★/g,"<br>").replace(/☆/g," ");
	var drawing_bottom=drawing_bottoma.replace(/★/g,"<br>").replace(/☆/g," ");
	var drawing_lron=drawing_lrona.replace(/★/g,"<br>").replace(/☆/g," ");
	var values=[id,product_name, spec_top, spec_bottom, drawing_top, drawing_bottom, drawing_lron];
 //if(checkRow(edit,values[0])) {

 if(window.opener.document.getElementById("number").value!=null && window.opener.document.getElementById("number").value.length>0)
 { 
  z=window.opener.document.getElementById("number").value;
  z=++z;
 }
 window.opener.document.getElementById("number").value =z;
 addInstanceRow(edit,names,values);
 //}
}
</script>
<%
String my_sql_search = "SELECT * FROM design_file where type=2 and check_tag='1'";
String keyword="";
String mold_type="";
if(request.getParameter("keyword") != null&&request.getParameter("keyword").length() > 0)
{
	keyword=request.getParameter("keyword");
	my_sql_search +=" having product_name like'%"+request.getParameter("keyword")+"%'";
}
if(request.getParameter("mold_type") != null&&request.getParameter("mold_type").length() > 0)
{
	mold_type=request.getParameter("mold_type");
	my_sql_search +=" and CHAIN_NAME like'%"+request.getParameter("mold_type")+"%'";
}
String tablename="design_file";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and (type='外购商品' or type='物料')";
String queue="order by register_time";
String validationXml="../../xml/design/design_file.xml";
String nickName="产品档案";
String fileName="newRegister_product_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的产品档案总数");
int k=0;
%>
<%@include file="../../include/search_my.jsp"%>
<%try{
	
	String keyword2=request.getParameter("keyword");

	
	ResultSet rs1 =null;
	if(keyword2!=null){
		rs1=mold_db.executeQuery(sql_search);

	}else{
		intRowCount=0;
	}
 
%>
<%--@include file="../../include/search_top.jsp"--%>
<form action="newRegister_product_list.jsp" method="post" name="search_form" id="search_form">
<table align="center" border="0" width ="98%">
	<tr class="TR_STYLE1">
		<td align="right" class="TD_STYLE6">
		  
		  模具规格：<input type="text" name="keyword" value="<%=keyword %>" style="width: 120">
		  模具分类：<input type="text" name="mold_type" value="<%=mold_type %>" style="width: 120">
		  <input type="submit" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","查询")%>" >
		</td>
	</tr>
</table>
</form>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","模具规格")%>'},
                       {name: '<%=demo.getLang("erp","模具分类")%>'},
                       {name: '<%=demo.getLang("erp","备注")%>'},
                       {name: '<%=demo.getLang("erp","选择")%>'}
]
nseer_grid.column_width=[500,150];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [

<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 

['<%=rs1.getString("product_name")%>','<%=rs1.getString("CHAIN_NAME")%>','<%=rs1.getString("C_DEFINE2")%>','<div style="text-decoration : underline;color:#3366FF;CURSOR: hand;" onClick=addGoodsItem("<%=exchange.unHtmls(Integer.toString(rs1.getInt("id")))%>","<%=exchange.unHtmls(rs1.getString("product_name")) %>","<%=exchange.unHtmls(rs1.getString("spec_top"))%>","<%=exchange.unHtmls(rs1.getString("spec_bottom"))%>","<%=exchange.unHtmls(rs1.getString("drawing_top"))%>","<%=exchange.unHtmls(rs1.getString("drawing_bottom"))%>","<%=exchange.unHtmls(rs1.getString("drawing_lron"))%>")><%=demo.getLang("erp","选择")%></div>'],
<%k++;%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%mold_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>
<%}%>