 function fnLoad(){
		 	var pageform=document.getElementById("_nseer_page_form");
		 	//alert(pageform.parentNode.innerHTML);
		 	if(pageform==null){
		 		return ;
		 	}
		var search_form=document.getElementById("search_form"); 
		 	pageform.onsubmit =function(){
		 		var pageSize=pageform["pageSize"].value;  
		 		var page=pageform["page"].value;
		 		var params="pageSize="+pageSize+"&page="+page; 
		 		var search_form=document.getElementById("search_form"); 
		 		var uri=search_form.action; 
		 	    var index = uri.indexOf("?");
				if (index == -1) {
					uri += "?";
				} else {
					uri += "&";
				}
		 		search_form.action=uri+params;
		 	   
		 		search_form.submit();
		 		return false;
		 	}
		 	pageform.submit=pageform.onsubmit;

		 
		 var aList=getElement(pageform.parentNode,"a");
			//alert(aList.length);
		 for(var i=0;i<aList.length;i++){
				aList[i].onclick=function(){
				
		 		var url=this.href;
		 		//alert(url);
		 		search_form.action=	url;
		 		search_form.submit();
		 		return false;
		 	}
		 }
}
		 var isIE=document.all?true:false;
    	 if(isIE){
	    	window.attachEvent('onload', fnLoad);
	     }else if(!isIE){
		    window.addEventListener('load',fnLoad, false);
		}
		

 function getChild(node,eleArr,tag){
// alert(node.childNodes.length);
   if(typeof(node.childNodes)){
    var childs=node.childNodes;
    
    if(typeof(childs)){
     for(var i=0;i<childs.length;i++){
     	
      if(!typeof(childs[i].type)){
      }else{
	  
            if(typeof(childs[i].tagName)!="undefined"&&childs[i].tagName.toUpperCase()==tag.toUpperCase()){
        eleArr.push(childs[i]);
       }
      }
      getChild(childs[i],eleArr,tag);
     }
    }
     }
  }
 function getElement(arg0,arg1){
  var elementArray=[];
  var oDiv;
  if(arg0 instanceof String){
  	   oDiv=document.getElementById(arg0);
  }else{

  oDiv=arg0;
  	 
  }
  //alert(arg0.innerHTML);
  

  getChild(oDiv,elementArray,arg1);
   return elementArray;
 }