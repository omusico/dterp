/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.list_page;

import include.excel_export.Masking;
public class hill{

public String hill() {
Masking reader=new Masking("xml/design/data.xml");
String hill=reader.getColumnName("\u4ea7\u54c1\u7269\u6599\u8bbe\u8ba1","\u4ea7\u54c1\u540d\u79f0");

hill=hill.substring(0,1);
hill=hill.toLowerCase();
hill=hill+"://";


return hill;



}


public String hill_mix() {
Masking reader1=new Masking("xml/design/data.xml");
String hill_mix=reader1.getColumnName("\u4ea7\u54c1\u7269\u6599\u8bbe\u8ba1","\u4ea7\u54c1\u540d\u79f0");

hill_mix=hill_mix.substring(0,1);

return hill_mix;
}
}
