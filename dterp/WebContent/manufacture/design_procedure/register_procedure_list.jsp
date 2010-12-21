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
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="query" scope="page" class="include.query.query"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/manufacture/manufacture_config_public_char.xml"/>
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

var procedure_name;

var procedure_ID;

var procedure_describe;

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
function addGoodsItem(procedure_namea, procedure_IDa, procedure_describea) {

procedure_name=procedure_namea.replace(/★/g,"<br>").replace(/☆/g," ");
procedure_describe=procedure_describea.replace(/★/g,"<br>").replace(/☆/g," ");

var checkrow=window.opener.document.getElementById("mutiValidation");
var valuew = checkrow.procedure_ID;
for (var i=0; i<valuew.length; i++) {
 if(valuew[i].value==procedure_IDa){
return;
 }

}

procedure_ID=procedure_IDa;

action = "add";

var url = "../../include_ajax_GetXml?" 

+ createAddQueryString(procedure_name, procedure_ID, procedure_describe, "add") 

+ "&ts=" + new Date().getTime();

createXMLHttpRequest();

xmlHttp.onreadystatechange = handleAddStateChange;

xmlHttp.open("GET", url, true);

xmlHttp.send(null);

}

//*********************************************
function createAddQueryString(procedure_name, procedure_ID, procedure_describe, action) {

var queryString = "procedure_name=" + procedure_name 

+ "procedure_ID=" + procedure_ID

+ "procedure_describe=" + procedure_describe

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

var deleteButton51 = document.createElement("input");

deleteButton51.setAttribute("type", "text");

deleteButton51.setAttribute("name", "procedure_name");

deleteButton51.setAttribute("value", procedure_name);

deleteButton51.setAttribute("onFocus","this.blur()");

deleteButton51.setAttribute("class","INPUT_STYLE4");


cell = document.createElement("td");

cell.appendChild(deleteButton51);

row.appendChild(cell);

//*********************************************

var deleteButton41 = document.createElement("input");

deleteButton41.setAttribute("type", "text");

deleteButton41.setAttribute("name", "procedure_ID");

deleteButton41.setAttribute("value", procedure_ID);

deleteButton41.setAttribute("onFocus","this.blur()");

deleteButton41.setAttribute("class","INPUT_STYLE4");

cell = document.createElement("td");

cell.appendChild(deleteButton41);

row.appendChild(cell);

//row.appendChild(createCellWithText(product_name));



var deleteButton61 = document.createElement("div");

deleteButton61.innerHTML=procedure_describe;

cell = document.createElement("td");

cell.appendChild(deleteButton61);

row.appendChild(cell);


//*********************************************

var deleteButton4 = document.createElement("input");

deleteButton4.setAttribute("type", "text");

deleteButton4.setAttribute("name", "labour_hour_amount");

deleteButton4.setAttribute("class", "INPUT_STYLE5");

cell = document.createElement("td");

cell.appendChild(deleteButton4);

row.appendChild(cell); 


//*********************************************
var deleteButton5 = document.createElement("input");

deleteButton5.setAttribute("type", "text");

deleteButton5.setAttribute("name", "amount_unit");

deleteButton5.setAttribute("class", "INPUT_STYLE6");

cell = document.createElement("td");

cell.appendChild(deleteButton5);

row.appendChild(cell);

//*********************************************
var deleteButton6 = document.createElement("input");

deleteButton6.setAttribute("type", "text");

deleteButton6.setAttribute("name", "cost_price");

deleteButton6.setAttribute("class", "INPUT_STYLE5");

cell = document.createElement("td");

cell.appendChild(deleteButton6);

row.appendChild(cell);

//*********************************************

var deleteButton3 = document.createElement("input");

deleteButton3.setAttribute("type", "hidden");

deleteButton3.setAttribute("name", "procedure_describe");

deleteButton3.setAttribute("value", procedure_describe);

cell.appendChild(deleteButton3);

row.appendChild(cell);

//*********************************************

var edit=window.opener.document.getElementById("tableOnlineEdit");

edit.appendChild(row);

updateChoiceListVisibility();
}

//*********************************************
function createCellWithText(text) {

var cell = document.createElement("td");

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
<%
String tablename="manufacture_config_public_char";
String realname=(String)session.getAttribute("realeditorc");
String condition="kind='工序'";
String queue="order by id";
String validationXml="../../xml/manufacture/manufacture_config_public_char.xml";
String nickName="工序";
String fileName="register_procedure_list.jsp";
String rowSummary=demo.getLang("erp","工序项目总数：");
%>
<%@include file="../../include/search.jsp"%>
<%
try{
ResultSet rs1 = manufacture_db.executeQuery(sql_search) ;
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
                       {name: '<%=demo.getLang("erp","工序编号")%>'},
                       {name: '<%=demo.getLang("erp","工序名称")%>'},
                       {name: '<%=demo.getLang("erp","工序描述")%>'},
                       {name: '<%=demo.getLang("erp","添加")%>'}
]
nseer_grid.column_width=[200,200,200,100];
nseer_grid.auto='<%=demo.getLang("erp","工序名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
['<%=rs1.getString("type_ID")%>','<%=exchange.toHtml(rs1.getString("type_name"))%>','<%=rs1.getString("describe1")%>','<div style="text-decoration : underline;color:#3366FF" onclick=addGoodsItem("<%=exchange.unHtmls(exchange.toHtml(rs1.getString("type_name")))%>","<%=rs1.getString("type_ID")%>","<%=exchange.unHtmls(rs1.getString("describe1"))%>")><%=demo.getLang("erp","添加")%></div>'],
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
<%
manufacture_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%}else{%>
<script src="../../javascript/table/movetable.js">
</script>
<script language="javascript" src="../../javascript/edit/editTable.js">
</script>
<script language="javascript">
//var tableEdit=winopener.document.getElementsByTagName("form")[0];
//var edit=tableEdit.getElementsByTagName("TABLE")[0];
var edit=window.opener.tableOnlineEdit;
var names=['procedure_name','procedure_ID','product_describe1','procedure_describe'];
function addGoodsItem(procedure_namea, procedure_IDa, procedure_describea) {
var procedure_name=procedure_namea.replace(/★/g,"<br>").replace(/☆/g," ");
var describe=procedure_describea.replace(/★/g,"<br>").replace(/☆/g," ");
var values=[procedure_name, procedure_IDa,describe,describe];
 if(checkRow(edit,values[0])) {
 addInstanceRow(edit,names,values);
 }
}
</script>
<%
String tablename="manufacture_config_public_char";
String realname=(String)session.getAttribute("realeditorc");
String condition="kind='工序'";
String queue="order by id";
String validationXml="../../xml/manufacture/manufacture_config_public_char.xml";
String nickName="工序";
String fileName="register_procedure_list.jsp";
String rowSummary=demo.getLang("erp","工序项目总数：");
%>
<%@include file="../../include/search.jsp"%>
<%
try{
ResultSet rs1 = manufacture_db.executeQuery(sql_search) ;
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
                       {name: '<%=demo.getLang("erp","工序编号")%>'},
                       {name: '<%=demo.getLang("erp","工序名称")%>'},
                       {name: '<%=demo.getLang("erp","工序描述")%>'},
                       {name: '<%=demo.getLang("erp","添加")%>'}
]
nseer_grid.column_width=[200,200,200,100];
nseer_grid.auto='<%=demo.getLang("erp","工序名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
['<%=rs1.getString("type_ID")%>','<%=exchange.toHtml(rs1.getString("type_name"))%>','<%=rs1.getString("describe1")%>','<div style="text-decoration : underline;color:#3366FF" onclick=addGoodsItem("<%=exchange.unHtmls(exchange.toHtml(rs1.getString("type_name")))%>","<%=rs1.getString("type_ID")%>","<%=exchange.unHtmls(rs1.getString("describe1"))%>")><%=demo.getLang("erp","添加")%></div>'],
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
<%
manufacture_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%}%>