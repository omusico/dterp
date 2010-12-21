/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package design.file;

import include.get_sql.getInsertSql;
import include.nseer_cookie.Divide1;
import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;
import include.operateDB.CdefineUpdate;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import validata.ValidataNumber;
import validata.ValidataTag;

public class change_ok extends HttpServlet {

	public void service(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this, request,
				response, "", true, 8192, true);
		ServletContext dbApplication = dbSession.getServletContext();

		ServletContext application;
		HttpSession session = request.getSession();
		nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
		ValidataNumber validata = new ValidataNumber();
		ValidataTag vt = new ValidataTag();
		counter count = new counter(dbApplication);
		getInsertSql getInsertSql = new getInsertSql();
		try {

			if (design_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				ResultSet rset = null;
				int product_length = 0;
				int product_length_s = 0;
				String id = request.getParameter("id");
				String fileKind_chain = request.getParameter("fileKind_chain");
				String chain_id = Divide1.getId(fileKind_chain);
				String chain_name = Divide1.getName(fileKind_chain);
				String product_lengths = request.getParameter("product_length");
				String product_lengths_s = request
						.getParameter("product_length_s");
				String product_pallet_sf=request.getParameter("product_pallet_sf") ;
				if (product_lengths_s != null && product_lengths_s.length() > 0)
					product_length_s = Integer.parseInt(product_lengths_s);
				if (product_lengths != null && product_lengths.length() > 0)
					product_length = Integer.parseInt(product_lengths);
				int type1 = Integer.parseInt(request.getParameter("type"));
				String type = new String(request.getParameter("type").getBytes(
						"UTF-8"), "UTF-8");
				String product_ID = request.getParameter("product_ID");
				String product_name = request.getParameter("product_name");
				String factory_name = request.getParameter("factory_name");
				String spec_top = request.getParameter("spec_top");
				String spec_bottom = request.getParameter("spec_bottom");
				String drawing_bottom = request.getParameter("drawing_bottom");
				String drawing_top = request.getParameter("drawing_top");
				String drawing_lron = request.getParameter("drawing_lron");
				String product_class = request.getParameter("product_class");
				String product_nick = request.getParameter("product_nick");
				String twin_name = request.getParameter("twin_name");
				String twin_ID = request.getParameter("twin_ID");
				String personal_unit = request.getParameter("personal_unit");
				String personal_value = request.getParameter("personal_value");
				personal_value = personal_value.replaceAll(",", "");
				String warranty = request.getParameter("warranty");
				String lifecycle = request.getParameter("lifecycle");
				String amount_unit = request.getParameter("amount_unit");
				String register = request.getParameter("register");
				String bodyc = new String(request
						.getParameter("provider_group").getBytes("UTF-8"),
						"UTF-8");
				String provider_group = exchange.toHtml(bodyc);
				String bodya = new String(request.getParameter(
						"product_describe").getBytes("UTF-8"), "UTF-8");
				String product_describe = exchange.toHtml(bodya);
				String changer_ID = request.getParameter("changer_ID");
				String changer = request.getParameter("changer");
				String change_time = request.getParameter("change_time");
				String lately_change_time = request
						.getParameter("lately_change_time");
				String file_change_amount = request
						.getParameter("file_change_amount");
				int change_amount = Integer.parseInt(file_change_amount) + 1;
				String column_group = getInsertSql.sql((String) dbSession
						.getAttribute("unit_db_name"), "design_file");
				String list_price2 = request.getParameter("list_price");
				String list_price = list_price2.replaceAll(",", "");
				String c_define2=request.getParameter("c_define2");
				String cost_price2 = request.getParameter("cost_price");
				String cost_price = cost_price2.replaceAll(",", "");
				String responsible_person_ID = "";
				String responsible_person_name = "";
				String responsible_person = request.getParameter("select4");
				if (!responsible_person.equals("")
						&& !responsible_person.equals("/")) {
					responsible_person_ID = responsible_person.split("/")[0];
					responsible_person_name = responsible_person.split("/")[1];
				}
				int n = 0;

				try {
					
					String sql="";
					if (product_length == 0 && product_length_s == 0)
						sql = "update design_file set spec_bottom='"
								+ spec_bottom + "',drawing_top='" + drawing_top
								+ "', drawing_bottom='" + drawing_bottom
								+ "', drawing_lron='" + drawing_lron
								+ "',spec_top='" + spec_top + "',chain_id='"
								+ chain_id + "',chain_name='" + chain_name
								+ "',product_name='" + product_name
								+ "',factory_name='" + factory_name
								+ "',product_class='" + product_class
								+ "',twin_name='" + twin_name + "',twin_ID='"
								+ twin_ID + "',personal_unit='" + personal_unit
								+ "',personal_value='" + personal_value
								+ "',warranty='" + warranty + "',lifecycle='"
								+ lifecycle + "',product_nick='" + product_nick
								+ "',list_price='" + list_price
								+ "',cost_price='" + cost_price
								+ "',provider_group='" + provider_group
								+ "',product_describe='" + product_describe
								+ "',responsible_person_name='"
								+ responsible_person_name
								+ "',responsible_person_ID='"
								+ responsible_person_ID + "',amount_unit='"
								+ amount_unit + "',changer_ID='" + changer_ID
								+ "',changer='" + changer + "',change_time='"
								+ change_time + "',lately_change_time='"
								+ lately_change_time + "',file_change_amount='"
								+ change_amount
								+ "',c_define2='"+c_define2+"',check_tag='0',excel_tag='1',type='"
								+ type1 + "' where id=" + id + "";
					else
						sql = "update design_file set spec_bottom='"
								+ spec_bottom + "',drawing_top='" + drawing_top
								+ "', drawing_bottom='" + drawing_bottom
								+ "', drawing_lron='" + drawing_lron
								+ "',spec_top='" + spec_top
								+ "', product_length='" + product_length
								+ "',product_pallet_sf='"+product_pallet_sf+"',chain_id='" + chain_id + "',chain_name='"
								+ chain_name + "',product_name='"
								+ product_name + "',factory_name='"
								+ factory_name + "',product_class='"
								+ product_class + "',twin_name='" + twin_name
								+ "',twin_ID='" + twin_ID + "',personal_unit='"
								+ personal_unit + "',personal_value='"
								+ personal_value + "',warranty='" + warranty
								+ "',lifecycle='" + lifecycle
								+ "',product_nick='" + product_nick
								+ "',list_price='" + list_price
								+ "',cost_price='" + cost_price
								+ "',provider_group='" + provider_group
								+ "',product_describe='" + product_describe
								+ "',responsible_person_name='"
								+ responsible_person_name
								+ "',responsible_person_ID='"
								+ responsible_person_ID + "',amount_unit='"
								+ amount_unit + "',changer_ID='" + changer_ID
								+ "',changer='" + changer + "',change_time='"
								+ change_time + "',lately_change_time='"
								+ lately_change_time + "',file_change_amount='"
								+ change_amount
								+ "',c_define2='"+c_define2+"',check_tag='0',excel_tag='1',type='"
								+ type1 + "' where id=" + id + "";
					design_db.executeUpdate(sql);
					/** ************************************************** */
					
					/** ************************************************** */
					

					

				} catch (Exception ex) {
					ex.printStackTrace();
				}
				response
						.sendRedirect("design/file/change_ok_c.jsp");

				design_db.commit();
				design_db.close();
			} else {
				response.sendRedirect("error_conn.htm");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}