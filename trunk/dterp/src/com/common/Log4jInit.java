package com.common;



import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;


 public class Log4jInit extends javax.servlet.http.HttpServlet {
		private static final long serialVersionUID = 8421025842405267201L;  
		private static Logger logger = Logger.getLogger(Log4jInit.class);
		public void init(ServletConfig config) throws ServletException {    
			  super.init(config); 
			  
			  
			  
			  String prefix = config.getServletContext().getRealPath("/"); 
			 String file = config.getInitParameter("log4j"); 
			  String filePath = prefix + file; 
			  Properties props = new Properties(); 
			  try { 
			  FileInputStream istream = new FileInputStream(filePath); 
			  props.load(istream); 
			  istream.close(); 
			  String logFile = prefix + props.getProperty("log4j.appender.file.File");//设置路径 
			  
			  File f=new File(filePath);
		   if(!f.exists()){
			   f.createNewFile();
			   }
			  props.setProperty("log4j.appender.file.File",logFile); 
			  PropertyConfigurator.configure(props);//装入log4j配置信息 
			  logger.info(logFile);
			  System.out.println("启动日志成功！");
			  } catch (IOException e) { 
			  logger.debug("Could not read configuration file [" + filePath + "]."); 
			  logger.debug("Ignoring configuration file [" + filePath + "]."); 
			  System.out.println("启动日志失败！");
			  return; 
			  } 
			  
			  
			  
//			  String prefix = config.getServletContext().getRealPath("/");    
//			  String file = config.getInitParameter("log4j");    
//			  String filePath = prefix + file;    
//			  String outputDir = config.getInitParameter("outputDir");    
//			   
//			  Properties props = new Properties();    
//			  try {    
//			   File f=new File(filePath);
//			   if(!f.exists()){
//				   f.createNewFile();
//			   }
//			   
//			   FileInputStream istream = new FileInputStream(filePath);    
//			   props.load(istream);    
//			   istream.close();    
//			   String logFile = prefix + outputDir + "\\"   
//			     + props.getProperty("log4j.appender.file.File");   
//			   props.setProperty("log4j.appender.file.File", logFile);   
//			   PropertyConfigurator.configure(props);   
//			   System.out.println("启动日志成功！");   
//			  } catch (IOException e) {   
//			   System.out.println("启动日志失败！");    
//			  }    
//			 }    

		}
	}
