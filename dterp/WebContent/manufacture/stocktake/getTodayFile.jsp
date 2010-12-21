<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db stock_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db stock_db2 = new nseer_db((String)session.getAttribute("unit_db_name"));
%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>

<jsp:setProperty name="mask" property="file" value="xml/design/design_module.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String tablename="design_module";
String realname=(String)session.getAttribute("realeditorc");
String condition="";
String queue="";
String validationXml=".";
String nickName="产品物料组成设计";
String fileName="check_list.jsp";
String rowSummary=demo.getLang("erp","当前可变更的设计单总数：");
%>
<%
try{
String register_ID=(String)session.getAttribute("human_IDD");
int workflow_amount=0;
String my_sql_search="select a.emp_no,b.product_spec,a.inven_time,b.lot_no,a.lot_no,b.product_lot_no,b.product_status from "+
	"(select product_lot_no,replace(product_lot_no,'-','') as lot_no,product_status,product_spec from product_info where product_status=1 "
	+"group by replace(product_info.product_lot_no,'-','')) b left join barcode_file a on a.lot_no=b.lot_no where a.inven_time ='"+time.substring(0,10)+"' group by b.product_spec";

%>
<%@include file="../../include/search_my.jsp"%>
<form  name="search_form" id="search_form" action="getTodayFile.jsp" method="post">
<table width="100%">
  <tr>
    <td>
    	<input type="hidden" name="searchId" value="45"  />
    	&nbsp;&nbsp;盘点日期：<%=time.substring(0,10) %>
    </td>
    <td style="text-align: right;">
    	<input type="hidden" name="searchId" value="45"  />
    	<input type="submit" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","&nbsp;盘&nbsp;&nbsp;点&nbsp;")%>">
    </td>
  </tr>
</table>
</form>

<%		ResultSet rs1 = design_db.executeQuery(sql_search); %>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
					   {name: '<%=demo.getLang("erp","品名")%>'},
                       {name: '<%=demo.getLang("erp","盘点者ID")%>'},
             			{name: '<%=demo.getLang("erp","原纸临时库(本)")%>'},
                       {name: '<%=demo.getLang("erp","4分切临时库(丁)")%>'},
                       {name: '<%=demo.getLang("erp","8mm切下层临时库(卷)")%>'},
                       {name: '<%=demo.getLang("erp","8mm切上层临时库(卷)")%>'},
                       {name: '<%=demo.getLang("erp","打孔临时库(卷)")%>'},
                       {name: '<%=demo.getLang("erp","包装生纸带(卷)")%>'},
                       {name: '<%=demo.getLang("erp","打孔生纸带(卷)")%>'}
]
nseer_grid.column_width=[130,80,130,130,150,150,110,110,190];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
<%
int countD = 0;
int paperCountD = 0;
int fourLinCountD = 0;
int eightDownCountD = 0;
int eightUpCountD = 0;
int slightD=0;
int eightUpSuccessD = 0;
int slightSuccessD = 0;
if(request.getParameter("searchId")!=null){
%>
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%
	//design_db
	String count = "";//数量
	String paperCount = "";//原纸临时库数量
	String fourLinCount = "";//4分切临时库数量
	String eightDownCount = "";//8mm下层临时库数量
	String eightUpCount = "";//8mm上层临时库数量
	String slight="";//打孔临时库数量
	String eightUpSuccess = "";//8mm上层库数量
	String slightSuccess = "";//打孔库数量
	String sql = "select count(id) from product_info where product_spec='"+rs1.getString("b.product_spec")+"' and ((product_stock!='' and product_temp_pallet='') or (product_stock='' and product_temp_pallet!=''))";
	ResultSet rsCount = stock_db1.executeQuery(sql);
	if(rsCount.next()){
		count=rsCount.getString(1);//数量
	}
	sql = "select count(barcode_file.id) from barcode_file inner join product_info on barcode_file.lot_no = replace(product_info.product_lot_no,'-','') where barcode_file.stock='stock2'  and product_info.product_spec='"+rs1.getString("b.product_spec")+"'";
	rsCount = stock_db1.executeQuery(sql);
	if(rsCount.next()){
		paperCount=rsCount.getString(1);//原纸临时库数量
	}
	
	sql = "select count(barcode_file.id) from barcode_file inner join product_info on barcode_file.lot_no = replace(product_info.product_lot_no,'-','') where barcode_file.stock='stock3'  and product_info.product_spec='"+rs1.getString("b.product_spec")+"'";
	rsCount = stock_db1.executeQuery(sql);
	if(rsCount.next()){
		fourLinCount=rsCount.getString(1);//4分切临时库数量
	}
	
	sql = "select count(barcode_file.id) from barcode_file inner join product_info on barcode_file.lot_no = replace(product_info.product_lot_no,'-','') where barcode_file.stock='stock4'  and product_info.product_spec='"+rs1.getString("b.product_spec")+"'";
	rsCount = stock_db1.executeQuery(sql);
	if(rsCount.next()){
		eightDownCount=rsCount.getString(1);//8mm下层临时库数量
	}
	
	sql = "select count(barcode_file.id) from barcode_file inner join product_info on barcode_file.lot_no = replace(product_info.product_lot_no,'-','') where barcode_file.stock='stock5'  and product_info.product_spec='"+rs1.getString("b.product_spec")+"'";
	rsCount = stock_db1.executeQuery(sql);
	if(rsCount.next()){
		eightUpCount=rsCount.getString(1);//8mm上层临时库数量
	}
					
	sql = "select count(barcode_file.id) from barcode_file inner join product_info on barcode_file.lot_no = replace(product_info.product_lot_no,'-','') where barcode_file.stock='stock6'  and product_info.product_spec='"+rs1.getString("b.product_spec")+"'";
	rsCount = stock_db1.executeQuery(sql);
	if(rsCount.next()){
		slight=rsCount.getString(1);//打孔临时库数量
	}
	
	sql = "select count(barcode_file.id) from barcode_file inner join product_info on barcode_file.lot_no = replace(product_info.product_lot_no,'-','') where barcode_file.stock='stock7'  and product_info.product_spec='"+rs1.getString("b.product_spec")+"'";
	rsCount = stock_db1.executeQuery(sql);
	if(rsCount.next()){
		eightUpSuccess=rsCount.getString(1);//8mm上层库数量
	}
	
	sql = "select count(barcode_file.id) from barcode_file inner join product_info on barcode_file.lot_no = replace(product_info.product_lot_no,'-','') where barcode_file.stock='stock8'  and product_info.product_spec='"+rs1.getString("b.product_spec")+"'";
	rsCount = stock_db1.executeQuery(sql);
	if(rsCount.next()){
		slightSuccess=rsCount.getString(1);//打孔库数量
	}
	 countD +=Integer.parseInt(count);
	 paperCountD +=Integer.parseInt(paperCount);
	 fourLinCountD +=Integer.parseInt(fourLinCount);
	 eightDownCountD +=Integer.parseInt(eightDownCount);
	 eightUpCountD +=Integer.parseInt(eightUpCount);
	 slightD+=Integer.parseInt(slight);
	 eightUpSuccessD +=Integer.parseInt(eightUpSuccess);
	 slightSuccessD +=Integer.parseInt(slightSuccess);
%>
[
'<%=rs1.getString("b.product_spec")%>',
'<%=rs1.getString("a.emp_no")%>',
'<%=paperCount%>',
'<%=fourLinCount%>',
'<%=eightDownCount%>',
'<%=eightUpCount%>',
'<%=slight%>',
'<%=eightUpSuccess%>',
'<%=slightSuccess%>'
],
</page:pages>
['','合计','<%=paperCountD%>','<%=fourLinCountD%>','<%=eightDownCountD%>','<%=eightUpCountD%>','<%=slightD%>','<%=eightUpSuccessD%>','<%=slightSuccessD%>'],['']];<%}%>
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%stock_db1.close();
stock_db2.close();
design_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>


