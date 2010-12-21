<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="query" scope="page" class="include.query.query"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%nseer_db purchase_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/design/design_file.xml"/>

<% 
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
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

var cost_price;

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
function addGoodsItem(product_namea, product_IDa, product_describea, amounta, amount_unita, cost_pricea,typea) {
var kk=1;
var checkrow=window.opener.document.getElementById("mutiValidation");
var valuew = checkrow.product_ID;
for (var i=0; i<valuew.length; i++) {
 if(valuew[i].value===product_IDa){

	 kk++;

 }

}
if(kk==1){


var checkrow1=window.opener.document.getElementById("mutiValidation");
var valuew1 = checkrow1.product_name;
for (var i=0; i<valuew1.length; i++) {
 if(valuew1[i].value==product_namea){
return;

 }

}
 describe=product_describea.replace(/★/g,"<br>").replace(/☆/g," ");
 product_name=product_namea.replace(/★/g,"<br>").replace(/☆/g," ");
 amount_unit=amount_unita.replace(/★/g,"<br>").replace(/☆/g," ");
 type=typea.replace(/★/g,"<br>").replace(/☆/g," ");

product_ID =product_IDa;
product_describe =describe;
amount = amounta;
cost_price=cost_pricea;

	
action = "add";

var url = "../../include_ajax_GetXml?" 

+ createAddQueryString(product_name, product_ID, product_describe, amount, amount_unit, cost_price,type,"add") 

+ "&ts=" + new Date().getTime();

createXMLHttpRequest();

xmlHttp.onreadystatechange = handleAddStateChange;

xmlHttp.open("GET", url, true);

xmlHttp.send(null);
}
else{return;}
}

//*********************************************
function createAddQueryString(product_name, product_ID, product_describe, amount, amount_unit, cost_price,type, action) {

var queryString = "product_name=" + product_name 

+ "product_ID=" + product_ID

+ "product_describe=" + product_describe

+ "amount=" + amount

+ "amount_unit=" + amount_unit

+ "cost_price=" + cost_price

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

cell = document.createElement("td");

cell.appendChild(deleteButto);

row.appendChild(cell);

//*********************************************

var deleteButton1 = document.createElement("input");

deleteButton1.setAttribute("type", "hidden");

deleteButton1.setAttribute("name", "type");

deleteButton1.setAttribute("value", type);

cell.appendChild(deleteButton1);

row.appendChild(cell);

//*********************************************
var deleteButton3 = document.createElement("input");

deleteButton3.setAttribute("type", "hidden");

deleteButton3.setAttribute("name", "product_describe");

deleteButton3.setAttribute("value", product_describe);

cell.appendChild(deleteButton3);

row.appendChild(cell);

//*********************************************
var deleteButton5 = document.createElement("input");

deleteButton5.setAttribute("type", "hidden");

deleteButton5.setAttribute("name", "amount_unit");

deleteButton5.setAttribute("value", amount_unit);

cell.appendChild(deleteButton5);

row.appendChild(cell);

//*********************************************

var deleteButton51 = document.createElement("input");

deleteButton51.setAttribute("type", "text");

deleteButton51.setAttribute("name", "product_name");

deleteButton51.setAttribute("value", product_name);

deleteButton51.setAttribute("onFocus","this.blur()");

deleteButton51.setAttribute("class","INPUT_STYLE4");


var cell = document.createElement("td");

cell.appendChild(deleteButton51);

row.appendChild(cell);

var deleteButton41 = document.createElement("input");

deleteButton41.setAttribute("type", "text");

deleteButton41.setAttribute("name", "product_ID");

deleteButton41.setAttribute("value", product_ID);

deleteButton41.setAttribute("onFocus","this.blur()");

deleteButton41.setAttribute("class","INPUT_STYLE4");



cell = document.createElement("td");

cell.appendChild(deleteButton41);

row.appendChild(cell);


//row.appendChild(createCellWithText(product_name));

var deleteButton61 = document.createElement("div");

deleteButton61.innerHTML=product_describe;

cell1 = document.createElement("td");

cell1.appendChild(deleteButton61);

row.appendChild(cell1);

//*********************************************
var deleteButton4 = document.createElement("input");

deleteButton4.setAttribute("type", "text");

deleteButton4.setAttribute("name", "amount");

deleteButton4.setAttribute("value", amount);

deleteButton4.setAttribute("class", "INPUT_STYLE5");

cell = document.createElement("td");

cell.appendChild(deleteButton4);

row.appendChild(cell);


row.appendChild(createCellWithText(amount_unit));

var deleteButton7 = document.createElement("input");

deleteButton7.setAttribute("type", "text");

deleteButton7.setAttribute("name", "cost_price");

deleteButton7.setAttribute("value", cost_price);

deleteButton7.setAttribute("class", "INPUT_STYLE5");

cell = document.createElement("td");

cell.appendChild(deleteButton7);

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
String condition="check_tag='1' and type!='服务型产品' and type!='部件' and type!='委外部件' and type!='商品' and type!='受托产品'";
String queue="order by register_time";
String validationXml="../../xml/design/design_file.xml";
String nickName="产品档案";
String fileName="register_product_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的产品档案总数");
%>
<%@include file="../../include/search.jsp"%>
<%try{
ResultSet rs1=purchase_db.executeQuery(sql_search);
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
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","用途类型")%>'},
                       {name: '<%=demo.getLang("erp","单位")%>'},
					   {name: '<%=demo.getLang("erp","单价")%>'},
                       {name: '<%=demo.getLang("erp","登记")%>'}
]
nseer_grid.column_width=[200,100,100,100,100,100];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 

['<%=rs1.getString("product_ID")%>','<%=exchange.toHtml(rs1.getString("product_name"))%>','<%=exchange.toHtml(rs1.getString("type"))%>','<%=exchange.toHtml(rs1.getString("amount_unit"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("cost_price"))%>',
	<%if(rs1.getString("price_alarm_tag").equals("0")){%>
	'<div style="text-decoration : underline;color:#3366FF" onclick=addGoodsItem("<%=exchange.unHtmls(exchange.toHtml(rs1.getString("product_name")))%>","<%=rs1.getString("product_ID")%>","<%=exchange.unHtmls(rs1.getString("product_describe"))%>","1","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("amount_unit")))%>","<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("cost_price"))%>","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("type")))%>")><%=demo.getLang("erp","登记")%></div>'
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
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%purchase_db.close();}catch(Exception ex){ex.printStackTrace();}%>
<%}else{%>
<script language="javascript" src="../../javascript/edit/editTable.js">
</script>
<script language="javascript">
var edit=window.opener.tableOnlineEdit;
var names=['product_name','product_ID','product_describe1','product_describe','amount','amount_unit','cost_price','type'];
function addGoodsItem(product_namea, product_IDa, product_describea, amounta, amount_unita, cost_pricea,typea) {
	var describe=product_describea.replace(/★/g,"<br>").replace(/☆/g," ");
	var product_name=product_namea.replace(/★/g,"<br>").replace(/☆/g," ");
	var amount_unit=amount_unita.replace(/★/g,"<br>").replace(/☆/g," ");
	var type=typea.replace(/★/g,"<br>").replace(/☆/g," ");
var values=[product_name, product_IDa, describe, describe, amounta, amount_unit, cost_pricea,type];
 if(checkRow(edit,values[0])) {
 addInstanceRow(edit,names,values);
 }
}
</script>
<%
String tablename="design_file";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and type!='服务型产品' and type!='部件' and type!='委外部件' and type!='商品' and type!='受托产品'";
String queue="order by register_time";
String validationXml="../../xml/design/design_file.xml";
String nickName="产品档案";
String fileName="register_product_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的产品档案总数");
%>
<%@include file="../../include/search.jsp"%>
<%try{
ResultSet rs1=purchase_db.executeQuery(sql_search);
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
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","用途类型")%>'},
                       {name: '<%=demo.getLang("erp","单位")%>'},
					   {name: '<%=demo.getLang("erp","单价")%>'},
                       {name: '<%=demo.getLang("erp","登记")%>'}
]
nseer_grid.column_width=[200,100,100,100,100,100];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 

['<%=rs1.getString("product_ID")%>','<%=exchange.toHtml(rs1.getString("product_name"))%>','<%=exchange.toHtml(rs1.getString("type"))%>','<%=exchange.toHtml(rs1.getString("amount_unit"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("cost_price"))%>',
	<%if(rs1.getString("price_alarm_tag").equals("0")){%>
	'<div style="text-decoration : underline;color:#3366FF" onclick=addGoodsItem("<%=exchange.unHtmls(exchange.toHtml(rs1.getString("product_name")))%>","<%=rs1.getString("product_ID")%>","<%=exchange.unHtmls(rs1.getString("product_describe"))%>","1","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("amount_unit")))%>","<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("cost_price"))%>","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("type")))%>")><%=demo.getLang("erp","登记")%></div>'
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
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%purchase_db.close();}catch(Exception ex){ex.printStackTrace();}%>
<%}%>