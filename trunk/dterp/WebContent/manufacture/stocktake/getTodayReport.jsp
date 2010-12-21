<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db stock_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
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
String tablename="design_module";
String realname=(String)session.getAttribute("realeditorc");
String condition="";
String queue="";
String validationXml=".";
String nickName="产品物料组成设计";
String fileName="check_list.jsp";
String rowSummary=demo.getLang("erp","当前可变更的设计单总数：");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
%>
<%
try{
String register_ID=(String)session.getAttribute("human_IDD");
int workflow_amount=0;
String my_sql_search="select distinct product_spec from product_info where product_status=1";
%>
<%@include file="../../include/search_my.jsp"%>
<form  name="search_form" id="search_form" action="getTodayReport.jsp" method="post">
<table width="100%" >
  <tr>
  	<td style="text-align: left;">&nbsp;&nbsp;盘点日期：<%=time.substring(0,10) %></td>
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
             			{name: '<%=demo.getLang("erp","原纸临时库(本)")%>'},
                       {name: '<%=demo.getLang("erp","4分切临时库(丁)")%>'},
                       {name: '<%=demo.getLang("erp","8mm切下层临时库(卷)")%>'},
                       {name: '<%=demo.getLang("erp","8mm切上层临时库(卷)")%>'},
                       {name: '<%=demo.getLang("erp","打孔临时库(卷)")%>'},
                       {name: '<%=demo.getLang("erp","包装生纸带(卷)")%>'},
                       {name: '<%=demo.getLang("erp","打孔纸带(卷)")%>'}
]
nseer_grid.column_width=[140,140,140,160,160,130,130,170];
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
	String sql = "select count(id) from product_info where product_spec='"+rs1.getString("product_spec")+"' and product_status !=4";
	ResultSet rsCount = stock_db1.executeQuery(sql);
	if(rsCount.next()){
		count=rsCount.getString(1);//数量
	}

	countD+=Integer.parseInt(count);
	sql = "select count(id) from product_info where product_spec='"+rs1.getString("product_spec")+"' and stock_id=102 and product_status !=4";
	rsCount = stock_db1.executeQuery(sql);
	if(rsCount.next()){
		paperCount=rsCount.getString(1);//原纸临时库数量
	}
	paperCountD+=Integer.parseInt(paperCount);
	sql = "select count(id) from product_info where product_spec='"+rs1.getString("product_spec")+"' and stock_id=103 and product_status !=4";
	rsCount = stock_db1.executeQuery(sql);
	if(rsCount.next()){
		fourLinCount=rsCount.getString(1);//4分切临时库数量
	}
	fourLinCountD+=Integer.parseInt(fourLinCount);
	sql = "select count(id) from product_info where product_spec='"+rs1.getString("product_spec")+"' and stock_id=104 and product_status !=4";
	rsCount = stock_db1.executeQuery(sql);
	if(rsCount.next()){
		eightDownCount=rsCount.getString(1);//8mm下层临时库数量
	}
	eightDownCountD+=Integer.parseInt(eightDownCount);
	sql = "select count(id) from product_info where product_spec='"+rs1.getString("product_spec")+"' and stock_id=105 and product_status !=4";
	rsCount = stock_db1.executeQuery(sql);
	if(rsCount.next()){
		eightUpCount=rsCount.getString(1);//8mm上层临时库数量
	}
	eightUpCountD+=Integer.parseInt(eightUpCount);			
	sql = "select count(id) from product_info where product_spec='"+rs1.getString("product_spec")+"' and stock_id=106 and product_status !=4";
	rsCount = stock_db1.executeQuery(sql);
	if(rsCount.next()){
		slight=rsCount.getString(1);//打孔临时库数量
	}
	slightD+=Integer.parseInt(slight);
	sql = "select count(id) from product_info where product_spec='"+rs1.getString("product_spec")+"' and stock_id=107 and product_status !=4";
	rsCount = stock_db1.executeQuery(sql);
	if(rsCount.next()){
		eightUpSuccess=rsCount.getString(1);//8mm上层库数量
	}
	eightUpSuccessD+=Integer.parseInt(eightUpSuccess);
	sql = "select count(id) from product_info where product_spec='"+rs1.getString("product_spec")+"' and stock_id=108 and product_status !=4";
	rsCount = stock_db1.executeQuery(sql);
	if(rsCount.next()){
		slightSuccess=rsCount.getString(1);//打孔库数量
	}
	slightSuccessD+=Integer.parseInt(slightSuccess);
	
%>
['<%=rs1.getString("product_spec")%>','<%=paperCount%>','<%=fourLinCount%>',
'<%=eightDownCount%>','<%=eightUpCount%>','<%=slight%>','<%=eightUpSuccess%>','<%=slightSuccess%>'
],
</page:pages>
['合计','<%=paperCountD%>','<%=fourLinCountD%>','<%=eightDownCountD%>','<%=eightUpCountD%>',
'<%=slightD%>','<%=eightUpSuccessD%>','<%=slightSuccessD%>'],['']];<%}%>
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%stock_db1.close();
design_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>


