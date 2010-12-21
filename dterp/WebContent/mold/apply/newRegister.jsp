<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseer_cookie.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="getThreeKinds" class="include.get_three_kinds.getThreeKinds" scope="page"/>
<head>
<LINK href="../../javascript/table/onlineEditTable.css" type=text/css rel=stylesheet>
<script language="javascript" src="../../javascript/edit/editTable.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>

<script type="text/javascript">
var openWin=null;
function openS(){
document.getElementById("add").disabled="disabled";
	var n=0;
	if(openWin==null){
		if(document.getElementById("number").value.length>0){
			n = document.getElementById("number").value;}
			openWin=winopen("newRegister_product_list.jsp?number="+n,"","height=600,width=680,toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=yes");
		
	}else{
		openWin.focus();
	}
}
var openWin2=null;
function productCheck(){
	if(openWin2==null){
		openWin2=window.open('newRegister_product_list1.jsp','','height=600,width=680,toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=yes')
	}else{
		openWin2.focus();
	}
}

function delSelect(){
 var checkboxs = document.getElementsByName("checkbox");
 var table = document.getElementById("tableOnlineEdit");
 var tr = table.getElementsByTagName("tr");
 //没选择产品给出 相应提示
 var bool=false;
for (var i=0; i<checkboxs.length; i++) 
{
	if(checkboxs[i].checked == true )
 {
 	bool=true
 }
}

if(bool==false)
{
 alert("请选择要删除的产品！");
}
//删除 开始
 for (var i=0; i<checkboxs.length; i++) {
 if(tr.length==3){
 checkboxs[i].checked = false;
 return;
 }
 if(checkboxs[i].checked==true){
 removeTr(checkboxs[i]);
 i=-1;
 document.getElementById("number").value=document.getElementById("number").value-1;
 }
 }
}

function removeTr(obj) {
 var sTr = obj.parentNode.parentNode;
 sTr.parentNode.removeChild(sTr);
}
function CheckForm(TheForm){


 var table = document.getElementById("tableOnlineEdit");

 var tr1 = table.getElementsByTagName("tr");

 


     if(document.getElementsByName("product_ida").length>0)
    { 
    var temp;
	 for(var y=1;y<document.getElementsByName("product_ida").length;y++)
	 {

		temp=document.getElementsByName("product_ida")[y].value;
		
		//alert(document.getElementsByName("mold_type")[y].value);
		if(document.getElementsByName("mold_type")[y].value=="1")
		{
		
		//alert(temp.length);
		if(temp.length>=3)
		{
			//alert(temp.substring(temp.length-2,temp.length-1));
			if(temp.substring(temp.length-2,temp.length-1)!="-")
			{
				alert("新制编号格式错误");
				return false;
			}
		}else
		{
		        alert("新制编号格式错误");
				return false;
		}
		}else
		{
			if(temp.search("^-?\\d+$")!=0){
            alert("新制编号格式错误");
           return false;
           }
		}
	 }
    }
    

	
    if(TheForm.purchase_operater.value == "")
    {
    	alert("经办人不能为空！");
		return(false);
    }
    else if(TheForm.purchase_time.value== "")
    {
    	alert("采购时间不能为空！");
		return(false);
    }
    else if(TheForm.purchase_supplier_id.value== "")
    {
    	alert("供应商不能为空");
		return(false);
    }
    else if(TheForm.purchase_id.value== "")
    {
    	alert("订单号不能为空");
		return(false);
    }else if(tr1.length==3)
     {
     alert("请添加产品！");
	 return false;
    }
	
    

    
    return  true;
}


</script>
</head>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<form id="mutiValidation" method="POST" action="../../mold_register_ok" onSubmit="return CheckForm(this)">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="button" id="add" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="openS()" value="<%=demo.getLang("erp","添加产品")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="delSelect()" value="<%=demo.getLang("erp","删除产品")%>">&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>"></td>
 </tr>
 </table>
<%
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String time=formatter.format(now);
%>
<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","模具采购登记")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","经办人")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input name="purchase_operater" type="text" value="" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>
	 
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","采购时间")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input name="purchase_time" type="text" value="" id="date_start" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " onkeypress="event.returnValue=false;"/></td>

</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","供应商")%>：</td>
 <td  style="display:none"><input id="ida" name="purchase_supplier_ida"></td>
 <td align=left class="TD_STYLE2" width="20%"><input id="purchase_supplier_id" readonly="readonly" name="" type="text" value="" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " />
 <img src="../../images/finance/search.gif" width="20px" height="20px" onclick="productCheck()"></td>
	 
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","订单号")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input readonly="readonly" id="purchase_id" name="purchase_id" type="text" value="" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>
 
</tr>

</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table id=tableOnlineEdit <%=TABLE_STYLE5%> class="TABLE_STYLE5" style="width: 94%" border="0">
<thead>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td bordercolor=#DEDBD6 class="TD_STYLE2" width="5%" align=center rowspan=2><%=demo.getLang("erp","点选")%> </td>
 <td bordercolor=#DEDBD6 class="TD_STYLE2" width="15%" align=center rowspan=2><%=demo.getLang("erp","模具规格")%> </td>
 <td bordercolor=#DEDBD6 class="TD_STYLE2" width="15%" align=center rowspan=2> <%=demo.getLang("erp","新制编号")%> </td>
 <td bordercolor=#DEDBD6 class="TD_STYLE2" colspan="2" align=center><%=demo.getLang("erp","品名和规格")%> </td>
 <td bordercolor=#DEDBD6 class="TD_STYLE2" width="15%" align=center rowspan=2><%=demo.getLang("erp","加工项目")%></td>
 <td bordercolor=#DEDBD6 class="TD_STYLE2" colspan="3" align=center><%=demo.getLang("erp","图纸号")%> </td>
 	 </tr>

 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 
 <td bordercolor=#DEDBD6 class="TD_STYLE2" width="10%" align=center><%=demo.getLang("erp","上模")%></td>
 <td bordercolor=#DEDBD6 class="TD_STYLE2" width="10%" align=center><%=demo.getLang("erp","下模")%></td>

 <td bordercolor=#DEDBD6 class="TD_STYLE2" width="10%" align=center><%=demo.getLang("erp","上模")%></td>
 <td bordercolor=#DEDBD6 class="TD_STYLE2" width="10%" align=center><%=demo.getLang("erp","下模")%></td>
 <td bordercolor=#DEDBD6 class="TD_STYLE2" width="10%" align=center><%=demo.getLang("erp","衬铁")%></td>
 </tr>
 

 <tr style="display:none">
 <td width="5%" align=center><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="checkbox" id=checkLine1></td>
 <td  style="display:none"><input name="id"></td>
 <td width="15%" align=center><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name" type="text" onFocus="this.blur()"></td>
 <td width="15%" align=center><input  <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="product_ida" type="text" value="1"></td>
 <td width="10%" align=center><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="spec_top" type="text" onFocus="this.blur()"></td>
 <td width="10%" align=center><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="spec_bottom" type="text" onFocus="this.blur()"></td>
 <td width="15%" align=center>
 <select style="width:100%" name="mold_type">
  <option value ="0" selected>新品</option>
  <option value ="1">研磨品</option>
</select>
</td>
 <td width="10%" align=center><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="drawing_top" type="text" onFocus="this.blur()"></td>
 <td width="10%" align=center><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="drawing_bottom" type="text" onFocus="this.blur()"></td>
 <td width="10%" align=center><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="drawing_lron" type="text" onFocus="this.blur()"></td>
 </tr>
</thead>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">	


 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","总件数")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input readonly="readonly" id="number" name="number" type="text" value="" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="4%"><%=demo.getLang("erp","备注")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><input id="remark" name="remark" type="text" value="" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","登记人")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input readonly="readonly" name="purchase_register" type="text" value="<%=exchange.toHtml(register)%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>
	 
 <td align=right class="TD_STYLE8" width="4%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td align=left class="TD_STYLE2" width="20%"><input readonly="readonly" name="purchase_register_time" type="text" value="<%=exchange.toHtml(time)%>" style="border-bottom: 1px solid #000;border-top: 0px solid #000;border-left: 0px solid #000;border-right:0px solid #000; " /></td>
 
 </tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 </form>
 <script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
<script type="text/javascript">
document.body.onunload=function(){
	if(openWin!=null){
		openWin.close();
	}
}
</script>