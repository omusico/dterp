package com.common;

import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;

public class UpLoadUrl {

	/**
	 * 获取Tomcat路径
	 * @return
	 */
	public static String getUploadUrl() {
		String tomcat_url = System.getenv("UPLOAD_PATH"); // 获取Tomcat路径
		String path = "";// 最终路径
		if (tomcat_url != null && !tomcat_url.equals("")) {
			path = tomcat_url;
		}
		return path;
	}

	/**
	 * 获取http 地址
	 * @return
	 */
	public static String getHttpUrl(HttpServletRequest request) {
		String path = "http://"; //协议
		String ip=""; //ip地址
		String port=""; // 端口
		String project=""; //项目名称
		try {

			InetAddress localhost = InetAddress.getLocalHost();
			 ip = localhost.getHostAddress();
			// System.out.println("localhost: "+localhost.getHostName());

		} catch (UnknownHostException uhe) {
			System.err.println("Localhost not seeable. Something is odd. ");
		}
		//端口
		port=String.valueOf(request.getServerPort());
		port=":"+port;
	   //项目
		project=request.getContextPath();
       //拼接路径
		path=path+ip+port+project; 

		return path;
	}
}
