
window.onload=function(){
	window.opener.openWin2=this;
	if(window.opener.document.getElementById("add")!=null){
	window.opener.document.getElementById("add").removeAttribute("disabled");
	}
	if(window.opener.document.getElementById("add1")!=null){
	window.opener.document.getElementById("add1").removeAttribute("disabled");
	}
	if(window.opener.document.getElementById("add2")!=null){
	window.opener.document.getElementById("add2").removeAttribute("disabled");
	}
	document.body.onunload=function(){
		window.opener.openWin2=null;
		if(window.opener.document.getElementById("add")!=null){
		window.opener.document.getElementById("add").removeAttribute("disabled");
		}
		if(window.opener.document.getElementById("add1")!=null){
		window.opener.document.getElementById("add1").removeAttribute("disabled");
		}
		if(window.opener.document.getElementById("add2")!=null){
		window.opener.document.getElementById("add2").removeAttribute("disabled");
		}
	}
	
	window.opener.attachEvent("onunload", function(){
	    window.close();
	})
	
	window.attachEvent("onfocus", function(){
	   if(window.opener.document.getElementById("add")!=null){
	window.opener.document.getElementById("add").removeAttribute("disabled");
	}
	if(window.opener.document.getElementById("add1")!=null){
	window.opener.document.getElementById("add1").removeAttribute("disabled");
	}
	if(window.opener.document.getElementById("add2")!=null){
	window.opener.document.getElementById("add2").removeAttribute("disabled");
	}
	})
	
	
	
 }

window.onerror=function(){
	return true;
}