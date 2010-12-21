/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.auto_execute;

import javax.servlet.*;
import java.util.*;
import java.io.*;
import include.auto_execute.resetDB;
import include.auto_execute.ContactExpiry;
import include.auto_execute.GatherSumLimit;
import include.auto_execute.GatherExpiry;
import include.auto_execute.PriceLimit;
import include.nseer_cookie.getSome;
import include.multilanguage.InitLang;
import include.nseer_db.*;
import include.nseer_cookie.*;

public final class ContextListener implements ServletContextListener {
	private ServletContext context = null;
	private java.util.Timer timer = null;
	private static final int C_SCHEDULE_HOUR = 0;
	private static boolean isRunning = false;
	public void contextInitialized(ServletContextEvent event) {
		context = event.getServletContext();
		try{
			initDB initDB=new initDB();
			context.setAttribute("initDB",initDB);
			initDB.initDB(context);
			System.out.println("sync ok");
			System.out.println("正在创建数据库连接池，这个过程最长需要几分钟，请等待...");

			connPool connPool=new connPool("ondemand2",0,context,35);
			context.setAttribute("connPool",connPool);
			connPool connPool1=new connPool("mysql",0,context,10);
			context.setAttribute("connPool1",connPool1);
			System.out.println("Pool ok");

			context.setAttribute("nseerPrecision",KindDeep.getPre("ondemand2"));
			context.setAttribute("nseerAmountPrecision",KindDeep.getAmountPre("ondemand2"));
			context.setAttribute("nseerDraft","0");
			String path=context.getRealPath("/");
			CreateJFile c=new CreateJFile();
			c.create(path,"ondemand2");
			delFile df=new delFile();
			df.delete(path+"xml/listPage/");
			File f=new File(path+"xml/listPage/");
			f.mkdir();
			initML initML=new initML();
			context.setAttribute("initML",initML);
			initML.initML(context);

			resetDB resetDB=new resetDB();
			context.setAttribute("resetDB",resetDB);
			resetDB.resetDB(context);
			System.out.println("reset ok1");

			ContactExpiry ContactExpiry=new ContactExpiry();
			context.setAttribute("ContactExpiry",ContactExpiry);
			ContactExpiry.flow(context);

			GatherSumLimit GatherSumLimit=new GatherSumLimit();
			context.setAttribute("GatherSumLimit",GatherSumLimit);
			GatherSumLimit.cost(context);

			GatherExpiry GatherExpiry=new GatherExpiry();
			context.setAttribute("GatherExpiry",GatherExpiry);
			GatherExpiry.back(context);

			PriceLimit PriceLimit=new PriceLimit();
			context.setAttribute("PriceLimit",PriceLimit);
			PriceLimit.price(context);
			InitLang initlang=new InitLang();
			initlang.init("ondemand2",context);
			System.out.println("Init language ok!");
			System.out.println("reset ok2");
			getSome getSome=new getSome();
			getSome.getSome();
		} catch (Exception ex) {
			ex.printStackTrace();
		}         
		timer = new java.util.Timer(true);
		context.log("定时器启动");
		timer.schedule(new MyTask(),0,1500*1000);
		context.log("添加任务调度表");
	}

	public void contextDestroyed(ServletContextEvent event) {
		try{
			String path=context.getRealPath("/");
			DeleteJFile d=new DeleteJFile();
			d.delete(path);
		}catch(Exception ex){}
		context = event.getServletContext();
		resetDB resetDB = (resetDB)context.getAttribute("resetDB");
		context.removeAttribute("resetDB");

		ContactExpiry ContactExpiry = (ContactExpiry)context.getAttribute("ContactExpiry");
		context.removeAttribute("ContactExpiry");

		GatherSumLimit GatherSumLimit = (GatherSumLimit)context.getAttribute("GatherSumLimit");
		context.removeAttribute("GatherSumLimit");

		GatherExpiry GatherExpiry = (GatherExpiry)context.getAttribute("GatherExpiry");
		context.removeAttribute("GatherExpiry");

		PriceLimit PriceLimit = (PriceLimit)context.getAttribute("PriceLimit");
		context.removeAttribute("PriceLimit");


		timer.cancel();
		context.log("定时器销毁");
	}

	class MyTask extends TimerTask {

		public void run() {
			Calendar cal = Calendar.getInstance();
			if ( cal.get(Calendar.HOUR_OF_DAY)==10) {
				context.log("开始执行指定任务");

				try{
					resetDB resetDB=new resetDB();
					context.setAttribute("resetDB",resetDB);
					resetDB.resetDB(context);

					ContactExpiry ContactExpiry=new ContactExpiry();
					context.setAttribute("ContactExpiry",ContactExpiry);
					ContactExpiry.flow(context);

					GatherSumLimit GatherSumLimit=new GatherSumLimit();
					context.setAttribute("GatherSumLimit",GatherSumLimit);
					GatherSumLimit.cost(context);

					GatherExpiry GatherExpiry=new GatherExpiry();
					context.setAttribute("GatherExpiry",GatherExpiry);
					GatherExpiry.back(context);

					PriceLimit PriceLimit=new PriceLimit();
					context.setAttribute("PriceLimit",PriceLimit);
					PriceLimit.price(context);

					System.out.println("reset ok3");

				} catch (Exception ex) {  
					ex.printStackTrace();
				}
				context.log("指定任务执行结束");
			}
		}
	}
}
