/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function ajax_validation(formID,values,valuea,valueb,valuec,url,tothis){


var formName=document.getElementById(valuea);

var selectName=document.getElementById(values);
var form=document.getElementById(formID);



var Namevalue=encodeURI(formName.value);
var Selectvalue=encodeURI(selectName.value);
var xmlhttp;
if (window.XMLHttpRequest)
		{
		xmlhttp=new XMLHttpRequest();
		}
		else if (window.ActiveXObject)
		{
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(xmlhttp) {
			xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState==4)
				{
					try {
						if(xmlhttp.status==200) {
//var loadingDiv=document.getElementById('loaddiv');

//loadingDiv.innerHTML ='';

//loadingDiv.innerHTML=;

var text=xmlhttp.responseText+'123';


if(parseInt(text)==123){

//loadingDiv.style.display='none';

}else{
n_A.divShow(xmlhttp.responseText);
//loadingDiv.style.display='block';

//loadingDiv.innerHTML='<font color=#ffffff style="font-weight :bold;">'+xmlhttp.responseText+'</font>';



}



}
						else {
							//loadingDiv.innerHTML = "There is something wrong ".fontcolor("red")
							 + xmlhttp.status + "=" + xmlhttp.statusText;
							
						}
					} catch(exception) {
							//loadingDiv.innerHTML = "There is something wrong! ".fontcolor("red")
							 + exception;
                         
					}
				}

			};
		xmlhttp.open("POST", url, true);
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp.send('IDD=true&valuea='+Selectvalue+'&'+valuea+'='+Namevalue+'&valueb='+valueb+'&valuec='+valuec);
				
					   
			

		} else {
	        //loadingDiv.innerHTML =
			  "Can't create XMLHttpRequest object, please check your web browser.";
		}


}