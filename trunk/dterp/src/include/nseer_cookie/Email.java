/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.nseer_cookie;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;

import javax.mail.*;
import javax.mail.internet.*;

public class Email{
	private String msh;
	private String msa;
	private String fa;
	private String ps;
	public void getProperty() {
		Properties properties = new Properties();
		
		try {
			InputStream inputstream = getClass().getClassLoader()
					.getResourceAsStream("/conf/mail.properties");
			
			properties.load(inputstream);
			
			if (inputstream != null) {
				inputstream.close();
				
			}
		} catch (IOException ex) {
			System.err.println("Open Propety File Error");
		}
		msh = properties.getProperty("mail.smtp.host");
		
		msa = properties.getProperty("mail.smtp.auth");
		fa = properties.getProperty("fromAddress");
		ps = properties.getProperty("password");
		
	}
public void send(String[] emailbox,String smtp,String from,String passwd,String subject,String content){

try{
	Properties props = new Properties();//也可用Properties props = System.getProperties(); 
	this.getProperty();
    props.put("mail.smtp.host",msh);//存储发送邮件服务器的信息
    props.put("mail.smtp.auth",msa);//同时通过验证
    if(msh.indexOf("smtp.gmail.com")>=0)
	{
    	props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    	props.setProperty("mail.smtp.socketFactory.fallback", "false");
    	props.setProperty("mail.smtp.port", "465");
    	props.setProperty("mail.smtp.socketFactory.port", "465");
	}        
    Session s = Session.getDefaultInstance(props,null);//根据属性新建一个邮件会话
	s.setDebug(true);

    MimeMessage msg = new MimeMessage(s);//由邮件会话新建一个消息对象

	InternetAddress fromAddress = new InternetAddress(fa);
    msg.setFrom(fromAddress);//设置发件人

            
    for(int i=0;i<emailbox.length;i++){
		InternetAddress toAddress = new InternetAddress(emailbox[i]);
		msg.addRecipient(Message.RecipientType.BCC,toAddress);
		}////*****//////////

	msg.setSubject(subject);//设置主题
	BodyPart bp=new MimeBodyPart();
	bp.setContent(content,"text/html;charset=UTF-8");
	Multipart mp=new MimeMultipart();
	mp.addBodyPart(bp);
	msg.setContent(mp);//设置信件内容
    msg.setSentDate(new Date());//设置发信时间
                
            
    msg.saveChanges();//存储邮件信息
    Transport transport=s.getTransport("smtp");
    transport.connect(msh,fa,ps);//以smtp方式登录邮箱
    transport.sendMessage(msg,msg.getAllRecipients());
}catch(Exception ex){ex.printStackTrace();};
}

}