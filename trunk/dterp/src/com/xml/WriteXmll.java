// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   Solid.java

/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package com.xml;

import java.io.*;
import java.util.*;
import java.sql.*;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import include.excel_export.ReaderHelper;

public class WriteXmll
{

    private ReaderHelper a;
    private String _fldfor;
    private SAXBuilder builder;
    private Document doc;
    private Element _flddo;
    private Element root;

    public WriteXmll()
    {
        a = null;
        _fldfor = null;
        builder = null;
        doc = null;
        _flddo = null;
        root = null;
    }

    public WriteXmll(String s)
    {
        a = null;
        _fldfor = null;
        builder = null;
        doc = null;
        _flddo = null;
        root = null;
        a(s);
    }

    private void a(String s)
    {
        try
        {
            _fldfor = s;
            builder = new SAXBuilder();
            doc = builder.build(new File(_fldfor));
            root = doc.getRootElement();
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
    }

    private void a()
    {
        try
        {
        	Format format = Format.getCompactFormat();
        	format.setEncoding("UTF-8"); // 设置xml文件的字符为utf-8
        	format.setIndent("  "); // 设置xml文件的缩进为4个空格
        	XMLOutputter XMLOut = new XMLOutputter(format);// 元素后换行一层元素缩四格
        	XMLOut.output(doc, new FileOutputStream(_fldfor));
        }
        catch(FileNotFoundException filenotfoundexception)
        {
            filenotfoundexception.printStackTrace();
        }
        catch(IOException ioexception)
        {
            ioexception.printStackTrace();
        }
    }

    public void setFile(String s)
    {
        a(s);
    }

    public void update(String ss,String ss1,String ss2,String aa,String[] bb) throws SQLException
    {
            root.removeChildren(ss);
            //root.removeChildren(ss1);
			Element element = new Element(ss);
		element.setAttribute("nums",aa);
		root.addContent(element);
		Element element2 = new Element(ss1);
		element2.setAttribute("seriesname","访问纪录");
		element2.setAttribute("color","0xff3300");
		element.addContent(element2);
		int i=0;
		for(int j=0;j<bb.length;j++){
			Element element1 = new Element(ss2);
		element1.setAttribute("value",bb[j]);
		element2.addContent(element1);
            i++;
		}
            a();
    }

	public String getValue(String ss){
		List list=root.getChildren(ss);
		Iterator loop=list.iterator();
    while(loop.hasNext()) {
		Element element = (Element)loop.next();
		return element.getAttributeValue("value");
	}
	return null;
	}

	public String getDynamic(String ss){
		List list=root.getChildren(ss);
		Iterator loop=list.iterator();
    while(loop.hasNext()) {
		Element element = (Element)loop.next();
		return element.getAttributeValue("dynamic");
	}
	return null;
	}

}

