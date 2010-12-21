
<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="common.*"  import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
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
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="9%"><%=demo.getLang("erp","原纸规格")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="9%"><%=demo.getLang("erp","在库Lot No.")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="9%"><%=demo.getLang("erp","盘点Lot No")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="9%"><%=demo.getLang("erp","状态")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="9%"><%=demo.getLang("erp","库位")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="9%"><%=demo.getLang("erp","盘点时间")%></td>
  <td <%=TD_STYLE2%> class="TD_STYLE2" width="9%"><%=demo.getLang("erp","员工号")%></td>
   <td <%=TD_STYLE2%> class="TD_STYLE2" width="9%"><%=demo.getLang("erp","在库数量")%></td>
    <td <%=TD_STYLE2%> class="TD_STYLE2" width="9%"><%=demo.getLang("erp","盘点数量")%></td>
    <td <%=TD_STYLE2%> class="TD_STYLE2" width="9%"><%=demo.getLang("erp","调整数量")%></td>
        <td <%=TD_STYLE2%> class="TD_STYLE2" width="9%"><%=demo.getLang("erp","废弃")%></td>
 </tr>

<%
try{
String date=request.getParameter("inven_date");

Map<String,CheckData> map= (Map<String,CheckData>)session.getAttribute("checkmap");
if(date!=null&&!date.equals("")){
	date=date.substring(0,7);
}

//String sql="select * from ((select product_spec,product_lot_no ,product_stock, inven_time,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  "+
//" (select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  "+
//	"	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , product_info d   "+
//	"	 left  join   barcode_file  e  on d.product_lot_no =e.lot_no "+
	//"	 where ((c. In_Detail_product_id=d.id and d.product_status=1)   "+
	//"	or d.id is null)  and (left(e.inven_time,7)='"+date+"' or e.lot_no is null )  )  "+
	//"	union  (select product_spec,product_lot_no ,product_stock, inven_time,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  "+ 
	//"	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b   "+
	////"	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , product_info d  "+ 
	//"	 right  join   barcode_file  e  on d.product_lot_no =e.lot_no "+
	//"	 where ((c. In_Detail_product_id=d.id and d.product_status=1)   "+
	//"	or d.id is null) and left(e.inven_time,7)='"+date+"'  )  "+
	//"	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_time,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   "+
	//"	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  "+
	//"	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' ) as c , "+
	//"	 package_info d   left join   barcode_file  e  on d.package_pallet =e.lot_no  "+
	///"	where ((c. In_Detail_product_id=d.id )  or d.id is null)  "+
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
//"select * from ((select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   (select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=2 ) as c , product_info d   	 left  join   barcode_file  e  on replace(d.product_lot_no,'-','') =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1  )   	or d.id is null)   and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )or e.lot_no is null )  )  	union  (select product_spec,product_lot_no ,product_stock, inven_month,emp_no,lot_no,product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	((select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b   	where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=2 ) as c , product_info d  )	 right  join   barcode_file  e   on  replace(d.product_lot_no,'-','')  =e.lot_no 	 where ((c. In_Detail_product_id=d.id and d.product_status=1)   	or d.id is null) and left(e.inven_month,7)='"+date+"' and e.inven_falg=0   ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from   	(select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=4) as c , 	 package_info d   left join   barcode_file  e  on replace(d.package_pallet,'-','')  =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null)  	and (d.is_out_stock=0 or d.is_out_stock is null)  and ((left(e.inven_month,7)='"+date+"' and e.inven_falg=0 )  or e.lot_no is null )  ) 	union  (select product_spec ,package_pallet as product_lot_no , package_stock as product_stock,inven_month,emp_no,lot_no,is_out_stock as product_status, c.stock_in_time as stock_in_time ,e.stock as file_stock  from  	((select  In_Detail_product_id,stock_in_time from stock_in a ,stock_in_detail b  	 where a.id=b.stock_in_id and left(a.stock_in_time,7)='"+date+"' and stock_in_reason_id=4 ) as c , 	 package_info d )  right join   barcode_file  e  on replace(d.package_pallet,'-','')  =e.lot_no  	where ((c. In_Detail_product_id=d.id )  or d.id is null) and 	(d.is_out_stock=0 or d.is_out_stock is null)  and left(e.inven_month,7)='"+date+"' and e.inven_falg=0 ) ) as z group by lot_no having(count(lot_no)=1 or product_lot_no is not null)"; 




  // ResultSet rs=stock_db.executeQuery(sql);
  // while(rs.next()){
	 //  if(rs.getString("lot_no")!=null&&rs.getString("product_lot_no")!=null){
	  // 		continue;
	//   }
	  // int inven_stock_count=0;
	  // int stock_count=0;
	  // if(rs.getString("lot_no")!=null){
		//   inven_stock_count=1;
	 //  }
	  // if(rs.getString("product_lot_no")!=null){ 
		  // stock_count=1;
	  // }
	


   Object[] set= map.keySet().toArray();
   for(int i=0;i<set.length;i++){
	   CheckData  ck= map.get(set[i].toString());

	   int revision_count=ck.getInven_stock_count()-ck.getStock_count();
	   if(revision_count==0){
		   continue;
	   }
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
     <td <%=TD_STYLE2%> class="TD_STYLE2" >
     <% if(ck.getStock_count()==1&&ck.getInven_stock_count()==0){ %>
     <a href="../../stock_InvenAction.do?m=del_product_info&&lot_no=<%=ck.getProduct_lot_no() %>&&inven_date=<%=request.getParameter("inven_date") %>" >废弃</a>
     <% } %>
     </td>
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
	  return "";
  }
  %>
</form>
<%
String isSucc=request.getParameter("isSucc");
if(isSucc!=null){
	%>
	<script type="text/javascript">
window.onload=function(){
	var isSucc="<%=request.getParameter("isSucc")%>";
	if(isSucc=="1"){
		alert("废弃成功");
	}
	if(isSucc=="0"){
		alert("废弃失败");
	}
}
</script>
	
<% 
}
%>

<%@include file="../../include/head_msg.jsp"%>


