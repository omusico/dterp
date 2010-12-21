package com.common;



import org.apache.log4j.Logger;

public class MyLog {
	private static Logger logger = Logger.getLogger(Log4jInit.class);
	public static void writeLog(Exception ex,String message){
		String stackTraceStr="\r\n";
		if(message!=null){
			stackTraceStr+=message;
		}
		stackTraceStr+=ex.getMessage()+"\r\n";
		StackTraceElement[] stackTrace=ex.getStackTrace();
		for(int i=0;i<stackTrace.length;i++){
			stackTraceStr+=stackTrace[i]+"\r\n";
		}
		logger.info(stackTraceStr);
	}
	public static void writeLog(Exception ex){
		writeLog(ex,null);
	}
}
