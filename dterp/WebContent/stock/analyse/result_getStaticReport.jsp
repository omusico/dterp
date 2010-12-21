
<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="common.*"   import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>

<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_gather.xml"/>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%
 String red=request.getParameter("red");
if(red!=null){
	%>
	<script type="text/javascript">window.location='inven_change.jsp?inven_date=<%=request.getParameter("inven_date") %>&red=1&isSucc=<%=request.getParameter("isSucc") %>';</script>
	 <%
	
}
%>
<script type="text/javascript">
<!--
function readCheck(){  
	
	window.location.href="read_register_list.jsp";

}
//-->
</script>

 <table  class="TABLE_STYLE2" width="100%">
 <tr height=20 class="TR_STYLE1">
 <td  class="TD_HANDBOOK_STYLE1"><div class="div_handbook">您正在做的业务是：库存管理--库存管理--库存盘点<script type="text/javascript" src="/erpv7/javascript/include/nseer_cookie/toolTip.js"></script><script type="text/javascript" src="/erpv7/javascript/include/div/alert.js"></script> <div style="position:absolute;top:25px;width:50px;left:0;"><table><tr></tr></table></div><input type="hidden" id="show-dialog-btn"></div></td>
 </tr>
 </table>
 <form action="inven_change.jsp" method="post"  >
<table width="100%"><tr>  
<td>
<input type="hidden" name="inven_date" value="<%=request.getParameter("inven_date") %>" />
</td><td align="right">
<input type="submit" onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup' class="BUTTON_STYLE1" value="调整">
</td></tr></table>
</form>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
<form name="" id="" action="" method="post">

	<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><div align="left">状态：0 包装在库 1 产品在库</div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","原纸规格")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","在库Lot No.")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","盘点Lot No")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","状态")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","库位")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","盘点时间")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","员工号")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","在库数量")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","盘点数量")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","调整数量")%></td>
 </tr>
<%
try{
String date=request.getParameter("inven_date");
if(date!=null&&!date.equals("")){
	date=date.substring(0,7);
}

//String sql="select * from ((select product_spec,product_lot_no ,product_stock, inven_time,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  "+
//" (select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  "+
//	"	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , product_info d   "+
	//"	 left  join   barcode_file  e  on d.product_lot_no =e.lot_no "+
	//"	 where ((c. In_Detail_product_id=d.id and d.product_status=1  )   "+
	//"	or d.id is null)   and (left(e.inven_time,7)='"+date+"' or e.lot_no is null )  )  "+
//	"	union  (select product_spec,product_lot_no ,product_stock, inven_time,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  "+ 
	//"	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b   "+
	//"	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , product_info d  "+ 
	//"	 right  join   barcode_file  e  on d.product_lot_no =e.lot_no "+
//	"	 where ((c. In_Detail_product_id=d.id and d.product_status=1)   "+
	//"	or d.id is null) and left(e.inven_time,7)='"+date+"'  )  "+
	//"	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_time,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   "+
	//"	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  "+
	//"	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , "+
	//"	 package_info d   left join   barcode_file  e  on d.package_pallet =e.lot_no  "+
	//"	where ((c. In_Detail_product_id=d.id )  or d.id is null)  "+
	//"	and (d.is_out_stock=0 or d.is_out_stock is null)  and (left(e.inven_time,7)='"+date+"' or e.lot_no is null )  ) "+
	//"	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_time,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  "+
	//"	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  "+
	//"	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , "+
	//"	 package_info d   right join   barcode_file  e  on d.package_pallet =e.lot_no  "+
	//"	where ((c. In_Detail_product_id=d.id )  or d.id is null) and "+
	//"	(d.is_out_stock=0 or d.is_out_stock is null)  and left(e.inven_time,7)='"+date+"'  )) as z   group by lot_no having(count(lot_no)=1 or product_lot_no is not null)";

//String sql="select * from ((select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   (select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , product_info d   	 left  join   barcode_file  e  on d.product_lot_no =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1  )   	or d.id is null)   and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )or e.lot_no is null )  )  	union  (select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b   	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , product_info d  	 right  join   barcode_file  e  on d.product_lot_no =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1)   	or d.id is null) and left(e.inven_month,7)='"+date+"' and e.inven_falg=0    ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , 	 package_info d   left join   barcode_file  e  on d.package_pallet =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null)  	and (d.is_out_stock=0 or d.is_out_stock is null)  and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )  or e.lot_no is null )  ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , 	 package_info d   right join   barcode_file  e  on d.package_pallet =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null) and 	(d.is_out_stock=0 or d.is_out_stock is null)  and left(e.inven_month,7)='"+date+"' and e.inven_falg=0 ) ) as z where lot_no is null union "+
//"select * from ((select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   (select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , product_info d   	 left  join   barcode_file  e  on d.product_lot_no =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1  )   	or d.id is null)   and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )or e.lot_no is null )  )  	union  (select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b   	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , product_info d  	 right  join   barcode_file  e  on d.product_lot_no =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1)   	or d.id is null) and left(e.inven_month,7)='"+date+"' and e.inven_falg=0   ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , 	 package_info d   left join   barcode_file  e  on d.package_pallet =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null)  	and (d.is_out_stock=0 or d.is_out_stock is null)  and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )  or e.lot_no is null )  ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , 	 package_info d   right join   barcode_file  e  on d.package_pallet =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null) and 	(d.is_out_stock=0 or d.is_out_stock is null)  and left(e.inven_month,7)='"+date+"' and e.inven_falg=0 ) ) as z "+
 //"group by lot_no having(count(lot_no)=1 or product_lot_no is not null) ";
//String sql="select * from ((select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   (select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , product_info d   	 left  join   barcode_file  e  on d.product_lot_no =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1  )   	or d.id is null)   and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )or e.lot_no is null )  )  	union  (select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	((select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b   	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , product_info d  )	 right  join   barcode_file  e  on d.product_lot_no =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1)   	or d.id is null) and left(e.inven_month,7)='"+date+"' and e.inven_falg=0    ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , 	 package_info d   left join   barcode_file  e  on d.package_pallet =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null)  	and (d.is_out_stock=0 or d.is_out_stock is null)  and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )  or e.lot_no is null )  ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	((select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , 	 package_info d)   right join   barcode_file  e  on d.package_pallet =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null) and 	(d.is_out_stock=0 or d.is_out_stock is null)  and left(e.inven_month,7)='"+date+"' and e.inven_falg=0 ) ) as z where lot_no is null union "+
//"select * from ((select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   (select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , product_info d   	 left  join   barcode_file  e  on d.product_lot_no =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1  )   	or d.id is null)   and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )or e.lot_no is null )  )  	union  (select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	((select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b   	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , product_info d  )	 right  join   barcode_file  e  on d.product_lot_no =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1)   	or d.id is null) and left(e.inven_month,7)='"+date+"' and e.inven_falg=0   ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , 	 package_info d   left join   barcode_file  e  on d.package_pallet =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null)  	and (d.is_out_stock=0 or d.is_out_stock is null)  and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )  or e.lot_no is null )  ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	((select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , 	 package_info d )  right join   barcode_file  e  on d.package_pallet =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null) and 	(d.is_out_stock=0 or d.is_out_stock is null)  and left(e.inven_month,7)='"+date+"' and e.inven_falg=0 ) ) as z "+
 //"group by lot_no having(count(lot_no)=1 or product_lot_no is not null) ";
//String sql="select * from ((select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   (select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=2 ) as c , product_info d   	 left  join   barcode_file  e  on d.product_lot_no =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1  )   	or d.id is null)   and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )or e.lot_no is null )  )  	union  (select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	((select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b   	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=2 ) as c , product_info d  )	 right  join   barcode_file  e  on d.product_lot_no =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1)   	or d.id is null) and left(e.inven_month,7)='"+date+"' and e.inven_falg=0    ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=4 ) as c , 	 package_info d   left join   barcode_file  e  on d.package_pallet =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null)  	and (d.is_out_stock=0 or d.is_out_stock is null)  and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )  or e.lot_no is null )  ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	((select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=4 ) as c , 	 package_info d)   right join   barcode_file  e  on d.package_pallet =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null) and 	(d.is_out_stock=0 or d.is_out_stock is null)  and left(e.inven_month,7)='"+date+"' and e.inven_falg=0 ) ) as z where lot_no is null union "+ 
//"select * from ((select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   (select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=2 ) as c , product_info d   	 left  join   barcode_file  e  on d.product_lot_no =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1  )   	or d.id is null)   and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )or e.lot_no is null )  )  	union  (select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	((select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b   	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=2 ) as c , product_info d  )	 right  join   barcode_file  e  on d.product_lot_no =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1)   	or d.id is null) and left(e.inven_month,7)='"+date+"' and e.inven_falg=0   ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=4) as c , 	 package_info d   left join   barcode_file  e  on d.package_pallet =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null)  	and (d.is_out_stock=0 or d.is_out_stock is null)  and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )  or e.lot_no is null )  ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	((select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=4 ) as c , 	 package_info d )  right join   barcode_file  e  on d.package_pallet =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null) and 	(d.is_out_stock=0 or d.is_out_stock is null)  and left(e.inven_month,7)='"+date+"' and e.inven_falg=0 ) ) as z group by lot_no having(count(lot_no)=1 or product_lot_no is not null)"; 


 //String sql="select * from ((select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   (select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=2 ) as c , product_info d   	 left  join   barcode_file  e  on replace(d.product_lot_no,'-','') =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1  )   	or d.id is null)   and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )or e.lot_no is null )  )  	union  (select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	((select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b   	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=2 ) as c , product_info d  )	 right  join   barcode_file  e  on replace(d.product_lot_no,'-','') =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1)   	or d.id is null) and left(e.inven_month,7)='"+date+"' and e.inven_falg=0    ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=4 ) as c , 	 package_info d   left join   barcode_file  e  on replace(d.package_pallet,'-','') =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null)  	and (d.is_out_stock=0 or d.is_out_stock is null)  and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )  or e.lot_no is null )  ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	((select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=4 ) as c , 	 package_info d)   right join   barcode_file  e  on replace(d.package_pallet,'-','') =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null) and 	(d.is_out_stock=0 or d.is_out_stock is null)  and left(e.inven_month,7)='"+date+"' and e.inven_falg=0 ) ) as z where lot_no is null union "+ 
//			"select * from ((select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   (select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=2 ) as c , product_info d   	 left  join   barcode_file  e  on replace(d.product_lot_no,'-','') =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1  )   	or d.id is null)   and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )or e.lot_no is null )  )  	union  (select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	((select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b   	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=2 ) as c , product_info d  )	 right  join   barcode_file  e   on  replace(d.product_lot_no,'-','')  =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1)   	or d.id is null) and left(e.inven_month,7)='"+date+"' and e.inven_falg=0   ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=4) as c , 	 package_info d   left join   barcode_file  e  on replace(d.package_pallet,'-','')  =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null)  	and (d.is_out_stock=0 or d.is_out_stock is null)  and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )  or e.lot_no is null )  ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	((select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=4 ) as c , 	 package_info d )  right join   barcode_file  e  on replace(d.package_pallet,'-','')  =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null) and 	(d.is_out_stock=0 or d.is_out_stock is null)  and left(e.inven_month,7)='"+date+"' and e.inven_falg=0 ) ) as z group by lot_no having(count(lot_no)=1 or product_lot_no is not null)"; 

   //String sql="(select * from ((select a.product_status,a.product_spec,a.product_lot_no ,a.product_stock, b.emp_no,b.lot_no,b.inven_time,b.inven_month   from "+
	// "  product_info a left join barcode_file b on "+
	// "  replace(a.product_lot_no ,'-','')=b.lot_no where a.product_status=1 and (b.inven_falg=0 or b.inven_falg is null) and (    left(b.inven_month,7)='"+date+"'     or b.inven_month is null ) ) "+
	// " union (select a.product_status, a.product_spec,a.product_lot_no ,a.product_stock, b.emp_no,b.lot_no,b.inven_time,b.inven_month from "+
	// " product_info a right join barcode_file b on replace(a.product_lot_no ,'-','')=b.lot_no where (a.product_status=1 or a.product_status is null) and b.inven_falg=0 and  left(b.inven_month,7)='"+date+"') "+

	// " union (select a.is_out_stock as product_status,  a.product_spec,a.package_pallet as product_lot_no ,a.package_stock as product_stock, b.emp_no,b.lot_no,b.inven_time,b.inven_month   from  "+
	//"  package_info a left join barcode_file b on "+
	//"   replace(a.package_pallet ,'-','')=b.lot_no where a.is_out_stock=0 and (b.inven_falg=0 or b.inven_falg is null) and (left(b.inven_month,7)='"+date+"' or b.inven_month is null ) ) "+
	//"  union (select a.is_out_stock as product_status, a.product_spec,a.package_pallet as product_lot_no ,a.package_stock as product_stock, b.emp_no,b.lot_no,b.inven_time,b.inven_month  from "+
	//"  package_info a right join barcode_file b on replace(a.package_pallet ,'-','')=b.lot_no where (a.is_out_stock=0 or a.is_out_stock is null) and b.inven_falg=0 and left(b.inven_month,7)='"+date+"')) as z where lot_no is null)  "+

	//"  union "+
	//"  (select * from ((select a.product_status, a.product_spec,a.product_lot_no ,a.product_stock, b.emp_no,b.lot_no,b.inven_time,b.inven_month   from  "+
	//"  product_info a left join barcode_file b on "+
	// "  replace(a.product_lot_no ,'-','')=b.lot_no where a.product_status=1 and (b.inven_falg=0 or b.inven_falg is null) and (left(b.inven_month,7)='"+date+"' or b.inven_month is null ) ) "+
	//"  union (select a.product_status, a.product_spec,a.product_lot_no ,a.product_stock, b.emp_no,b.lot_no,b.inven_time,b.inven_month from "+
	//"  product_info a right join barcode_file b on replace(a.product_lot_no ,'-','')=b.lot_no where (a.product_status=1 or a.product_status is null) and b.inven_falg=0 and left(b.inven_month,7)='"+date+"') "+

	//"  union (select a.is_out_stock as product_status, a.product_spec,a.package_pallet as product_lot_no ,a.package_stock as product_stock, b.emp_no,b.lot_no,b.inven_time,b.inven_month   from  "+
	//"  package_info a left join barcode_file b on "+
	//"   replace(a.package_pallet ,'-','')=b.lot_no where a.is_out_stock=0 and (b.inven_falg=0 or b.inven_falg is null) and (left(b.inven_month,7)='"+date+"' or b.inven_month is null ) ) "+
	//"  union (select a.is_out_stock as product_status, a.product_spec,a.package_pallet as product_lot_no ,a.package_stock as product_stock, b.emp_no,b.lot_no,b.inven_time,b.inven_month  from "+
	//"  package_info a right join barcode_file b on replace(a.package_pallet ,'-','')=b.lot_no where (a.is_out_stock=0 or a.is_out_stock is null) and b.inven_falg=0 and left(b.inven_month,7)='"+date+"')) as y group by lot_no having(count(lot_no)=1 or product_lot_no is not null)) ";


	//String sql1="(select b.stock as file_stock, a.product_stock, a.product_status,a.product_spec,a.product_lot_no ,a.product_stock, b.emp_no,b.lot_no,b.inven_time,b.inven_month   from  "+
	//"  product_info a left join (select * from barcode_file  where inven_falg=0 and left(inven_month,7)='"+date+"') b on   replace(a.product_lot_no ,'-','')=b.lot_no where a.product_status=1   )  "+
		//	 "  union (select b.stock as file_stock, a.product_stock, a.product_status, a.product_spec,a.product_lot_no ,a.product_stock, b.emp_no,b.lot_no,b.inven_time,b.inven_month from   "+
			// "  (select * from package_info where is_out_stock=0 ) a right join barcode_file b on replace(a.product_lot_no ,'-','')=b.lot_no where b.inven_falg=0 and  left(b.inven_month,7)='"+date+"')  ";
	//String sql2="(select b.stock as file_stock, a.package_stock, a.is_out_stock as product_status,  a.product_spec,a.package_pallet as product_lot_no ,a.package_stock as product_stock, b.emp_no,b.lot_no,b.inven_time,b.inven_month   from  "+
	//"  package_info a left join barcode_file b on "+
	//"   replace(a.package_pallet ,'-','')=b.lot_no where a.is_out_stock=0 and (b.inven_falg=0 or b.inven_falg is null) and (left(b.inven_month,7)='"+date+"' or b.inven_month is null ) ) "+
	//"  union (select b.stock as file_stock, a.package_stock, a.is_out_stock as product_status, a.product_spec,a.package_pallet as product_lot_no ,a.package_stock as product_stock, b.emp_no,b.lot_no,b.inven_time,b.inven_month  from "+
	//"  package_info a right join barcode_file b on replace(a.package_pallet ,'-','')=b.lot_no where (a.is_out_stock=0 or a.is_out_stock is null) and b.inven_falg=0 and left(b.inven_month,7)='"+date+"')";
	String sql1="(select b.stock as file_stock, a.product_stock, a.product_status,a.product_spec,a.product_lot_no ,a.product_stock, b.emp_no,b.lot_no,b.inven_time,b.inven_month from "+
		 " product_info a left join (select * from barcode_file where inven_falg=0 and left(inven_month,7)='"+date+"') b on replace(a.product_lot_no ,'-','')=b.lot_no where (a.product_status=1 or a.product_status=3) and (b.inven_falg=0 or b.inven_falg is null)   )  "+
		 " union (select b.stock as file_stock, a.product_stock, a.product_status, a.product_spec,a.product_lot_no ,a.product_stock, b.emp_no,b.lot_no,b.inven_time,b.inven_month from (select * from  product_info where product_status=1 or product_status=3  )  a "+
		 " right join barcode_file b on replace(a.product_lot_no,'-','')=b.lot_no where b.inven_falg=0 and  left(b.inven_month,7)='"+date+"') ";
	String sql2="(select b.stock as file_stock,a.package_stock,a.is_out_stock as product_status,a.product_spec,a.package_pallet as product_lot_no,a.package_stock as product_stock,b.emp_no,b.lot_no,b.inven_time,b.inven_month from "+
		" package_info a left join (select * from barcode_file where inven_falg=0 and left(inven_month,7)='"+date+"') b on "+
		" replace(a.package_pallet ,'-','')=b.lot_no where a.is_out_stock=0 and a.is_dissolve=0  )"+
		" union (select b.stock as file_stock, a.package_stock, a.is_out_stock as product_status, a.product_spec,a.package_pallet as product_lot_no ,a.package_stock as product_stock, b.emp_no,b.lot_no,b.inven_time,b.inven_month from "+
		" (select * from package_info where is_out_stock=0 and is_dissolve=0 ) a right join barcode_file b on replace(a.package_pallet ,'-','')=b.lot_no where  b.inven_falg=0 and left(b.inven_month,7)='"+date+"')";


  Map<String,CheckData> map=new HashMap<String,CheckData>();
	session.setAttribute("checkmap",map);
  List<String> list=new ArrayList<String>();
  for(int j=1;j<=2;j++){
	
   ResultSet rs=null;
	   if(j==1){
		   rs=stock_db.executeQuery(sql1);
	   }else{ 
		   rs=stock_db.executeQuery(sql2);
	   }
   while(rs.next()){
	   int inven_stock_count=0;
	   int stock_count=0;
	   if(rs.getString("lot_no")!=null){
		   inven_stock_count=1;  
	   }
	   if(rs.getString("product_lot_no")!=null){ 
		   stock_count=1;  
	   }
	   int revision_count=inven_stock_count-stock_count;
	   CheckData cd=new CheckData();
	   cd.setProduct_spec(rs.getString("product_spec"));
	   cd.setProduct_lot_no(rs.getString("product_lot_no"));
	   cd.setLot_no(rs.getString("lot_no"));
	   cd.setProduct_status(rs.getString("product_status"));
	   cd.setProduct_stock(rs.getString("Product_stock"));
	   cd.setInven_month(rs.getString("inven_month"));
	   cd.setInven_time(rs.getString("inven_time"));
	   cd.setEmp_no(rs.getString("emp_no"));
	   cd.setFile_stock(rs.getString("file_stock"));
	   cd.setProducdt_stock(rs.getString("product_stock"));
	   cd.setStock_count(stock_count);
	   cd.setInven_stock_count(inven_stock_count);
	   cd.setRevision_count(revision_count);
	   String lot_no=cd.getLot_no();
	   String product_lot_no=cd.getProduct_lot_no();
	   String key=lot_no+"_"+product_lot_no;
	  // if(lot_no==null&&product_lot_no==null){
	   	//	continue;
	  // }
	   //if(lot_no==null&&product_lot_no!=null){
	       
	 //  }
	   //if(lot_no!=null&&product_lot_no==null){
		   
	   //}
	   if(lot_no!=null&&product_lot_no!=null){
		   if(map.containsKey("null"+"_"+product_lot_no)){
			   	map.remove("null"+"_"+product_lot_no);
		   }
		   if(map.containsKey(lot_no+"_"+"null")){
			   	map.remove(lot_no+"_"+"null");
		   }
		   map.put(lot_no+"_"+product_lot_no,cd);
		   list.add(lot_no+"_"+product_lot_no);
	   }else{
		   boolean isAdd=true;
		   for(int m=0;m<list.size();m++){
			   String [] arr1=list.get(m).split("_");
			   if(lot_no!=null){
			   if(arr1[0].trim().equals(lot_no.trim())){
				   isAdd=false;
				   break;
			   }
			   }
			   if(product_lot_no!=null){
				   if(arr1[1].trim().equals(product_lot_no.trim())){
					   isAdd=false;
					   break;
				   }
			 }
		   
		   }
		
		   if(isAdd){
			map.put(lot_no+"_"+product_lot_no,cd);
		   }
	   } 
	   
	  // if(map.containsKey(key)){
	   	//	continue;
	  // }else{
		  // map.put(key,cd);
	   //}
   }
   }
   
   
%>


<%


   Object[] set= map.keySet().toArray();
   for(int i=0;i<set.length;i++){
	   CheckData  ck= map.get(set[i].toString());
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=ck.getProduct_spec()==null? "" :ck.getProduct_spec()%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=ck.getProduct_lot_no()==null? "" :ck.getProduct_lot_no() %></td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=ck.getLot_no()==null? "" :ck.getLot_no()  %></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=ck.getProduct_status()==null? "" :ck.getProduct_status()  %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=ck.getFile_stock()!=null?  getStockName(ck.getFile_stock()):ck.getProduct_stock() %></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" ><%=ck.getInven_time()==null? "" :ck.getInven_time()  %></td>
  <td <%=TD_STYLE2%> class="TD_STYLE2" ><%=ck.getEmp_no()==null? "" :ck.getEmp_no() %></td>
   <td <%=TD_STYLE2%> class="TD_STYLE2" ><%=ck.getStock_count() %></td>
    <td <%=TD_STYLE2%> class="TD_STYLE2" ><%=ck.getInven_stock_count() %></td>
     <td <%=TD_STYLE2%> class="TD_STYLE2" ><%=ck.getRevision_count() %></td>
      
 </tr>
 <% 
 }
   %>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <% 
  
  stock_db.close();
  }catch(Exception ex){
  ex.printStackTrace();
 	}	
  %>
  <%!
  public String getStockName(String arg0){
	  arg0=arg0.trim();
	  if(arg0.equals("stock1")){
		  return "正品仓";
	  }
	  if(arg0.equals("stock2")){
		  return "原纸临时仓";
	  }
	  if(arg0.equals("stock3")){
		  return "四分切临时仓";
	  }
	  if(arg0.equals("stock4")){
		  return "8mm切临时仓(下层)";
	  }
	  if(arg0.equals("stock5")){
		  return "8mm切临时仓(上层)";
	  }
	  if(arg0.equals("stock6")){
		  return "打孔临时库";
	  }
	  if(arg0.equals("stock7")){
		  return "生纸带包装库";
	  }
	  if(arg0.equals("stock8")){
		  return "打孔纸带包装库";
	  }
	  if(arg0.equals("stock9")){
		  return "废弃品库";
	  }
	  return " ";
  }
  %>
</form>
<%@include file="../../include/head_msg.jsp"%>


