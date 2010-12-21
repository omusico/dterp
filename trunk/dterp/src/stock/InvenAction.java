package stock;

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import include.nseer_db.nseer_db_backup1;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import com.common.UpLoadUrl;
import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

import common.Barcode;
import common.ReadFile;

import magic.action.Action;

public class InvenAction extends Action {
	
	public void doInven(HttpServletRequest request, HttpServletResponse response){
		nseer_db_backup1 security_db=null;
		try {
		HttpSession session=request.getSession();
		ServletContext dbApplication=session.getServletContext();
		 security_db= new nseer_db_backup1(dbApplication);
		 String date=request.getParameter("inven_date");
		 String dataPart=date.replace("-","").substring(0,6);
		if(security_db.conn((String) session.getAttribute("unit_db_name"))){
			
			ServletContext context = session.getServletContext();
			//String path = context.getRealPath("/");
			//updateInvo(path+"\\inven\\"+dataPart,security_db);
			String path = request.getContextPath();
			updateInvo(UpLoadUrl.getUploadUrl()+path+"/upload_file/inven/"+dataPart,security_db,date);
			//System.out.println(UpLoadUrl.getUploadUrl()+path+"/upload_file/inven/"+dataPart);
			security_db.commit();
			
			response.sendRedirect("stock/analyse/result_getStaticReport.jsp?inven_date="+date);
			
	
		}else{
			response.sendRedirect("error_conn.htm");
		}
		}  catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			try {
				if(security_db!=null){
					security_db.close();
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
	}
	
	public void updateInvo(String file,nseer_db_backup1 db,String date){
	
		List barCodeList=ReadFile.readFile(file);
		try {
			if(barCodeList!=null){
			for(int i=0;i<barCodeList.size();i++){
				Barcode barcode=(Barcode)barCodeList.get(i);
				List dataList=barcode.getData();
				 //SimpleDateFormat    df    =new    SimpleDateFormat("yyyy-MM-dd");  
		          //java.util.Date    cDate    =    df.parse(barcode.getCreateTime());  
				 
				//String time_part= df.format(cDate).substring(0,10);
				for(int j=0;j<dataList.size();j++){
					System.out.println(date.substring(0,7));
					String select_sql="select id from barcode_file where lot_no='"+dataList.get(j)+"' and inven_falg=0 and left(inven_month,7)='"+date.substring(0,7)+"'";
					ResultSet rs=db.executeQuery(select_sql);
					String bid="";
					if(rs.next()){
						bid=rs.getString("id");
					}
					String exe_sql="";
					if(bid.equals("")){
						exe_sql="insert into barcode_file(lot_no,inven_time,emp_no,stock,inven_falg,inven_month) values('"+dataList.get(j)+"','"+barcode.getCreateTime()+"','"+barcode.getEmpNo()+"','"+barcode.getStock()+"',0,'"+date+"')";
						
					}else{
						exe_sql="update barcode_file set inven_time='"+barcode.getCreateTime()+"',emp_no='"+barcode.getEmpNo()+"',stock='"+barcode.getStock()+"' where id='"+bid+"'";
					}
					
					db.executeUpdate(exe_sql);
				}
			}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//} catch (ParseException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		

	}
	public void del_product_info(HttpServletRequest request, HttpServletResponse response) throws IOException{
		nseer_db_backup1 security_db=null;
		 String inven_date=request.getParameter("inven_date");
		 String isSucc="1";
		try {
		HttpSession session=request.getSession();
		ServletContext dbApplication=session.getServletContext();
		 security_db= new nseer_db_backup1(dbApplication);
		
		String product_lot_no=request.getParameter("lot_no");
		
		if(security_db.conn((String) session.getAttribute("unit_db_name"))){
			String sql="update product_info set product_status=8 where product_lot_no='"+product_lot_no+"' and product_status=1";
			security_db.executeUpdate(sql);
			String sql2="update package_info set is_out_stock=3 where package_pallet='"+product_lot_no+"' and is_out_stock=0";
			security_db.executeUpdate(sql2);;
			security_db.commit();
			
			
	
		}else{
			response.sendRedirect("error_conn.htm");
		}
		}  catch (IOException e) {
			isSucc="0";
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			isSucc="0";
		}finally{
			try {
				if(security_db!=null){
					security_db.close();
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
		response.sendRedirect("stock/analyse/result_getStaticReport.jsp?inven_date="+inven_date+"&&red=1&&isSucc="+isSucc);
	}
	
}
