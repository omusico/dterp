var nseer_over_tag=0;
var nseer_up_tag=0;
var nseer_del_tag=0;
var nseer_char='';
var div1;
var isdown = false; 
var img_tag;


function getPath(){
	var str=window.location.pathname;
	var arr=str.split("/");
        if (arr[0] == ""){
          return arr[1];
        }
        else{
          return arr[0];
        }
}
String.prototype.Trim = function()
{
return this.replace(/(^\s*)|(\s*$)/g, "");
}

function Tree(MyTree){
  this.name = MyTree||"MyTree";
  this.node_list = new Array();
  this.root_list = new Array();
  this.tree_depth = 0;
  this.html_content = "";
  this.selected_node_id = -1;
  this.image_path = "images/";//图片路径
  this.show_line = true;//是否显示连线
  this.show_add_img = true;//是否显示+-
  this.show_node_img = true;//是否显示图片
  
  this.setImagesPath = function(img_path){
    this.image_path = img_path;
  }

  /*****节点操作方法开始*****/
  //添加跟节点
  this.addRootNode = function (name, showStr, isOpen, nickName,cashTag, stockTag,de_tag){
    return this.addNode(-1, 0, name, showStr, isOpen, nickName,cashTag, stockTag,de_tag);
  }

  //添加节点*******************************************
  this.addNode = function(pid, deepID, name, showStr, isOpen, nickName,cashTag, stockTag,de_tag){
    var inNode = new BSNode(this.node_list.length, pid, deepID, this.name, name, showStr, isOpen, nickName,cashTag, stockTag,de_tag);
	if (pid >= 0){
      this.node_list[pid].addChildItem(this.node_list.length);
    }
    else{
      this.root_list.length++;
      this.root_list[this.root_list.length-1] = this.node_list.length;
    }
    this.node_list.length++;
    this.node_list[this.node_list.length-1] = inNode;

    if (deepID > this.tree_depth){
      this.tree_depth = deepID;
    }
	
    if (document.getElementById(this.name+"_div") != null){	
      //树已生成时动态添加;
	  var node = this.node_list[inNode.id];
    //得到父节点对象
    this.openParentNode(node.pid);
    var p_node = this.node_list[node.pid];
    //得到父节点的元素

    var div = document.getElementById(this.name+"_"+p_node.id+"_div");
    //重画兄弟和本身
    tempStr = "";
    if (p_node.child_list.length > 0){
      var prevNode = node.prev();
      if (prevNode != null){
        div.removeChild(document.getElementById(this.name+"_"+prevNode.id+"_node"));
        div.removeChild(document.getElementById(this.name+"_"+prevNode.id+"_div"));
        tempStr += this.DrawNode(prevNode.getId());
      }
      tempStr += this.DrawNode(inNode.id);
      div.innerHTML = (div.innerHTML+tempStr);
    }
    }
    return inNode;
  }


  //打开父亲节点————————————————————————————————————————————————————————————————————
  this.openParentNode = function(id){
    if (id >= 0){
      var node = this.node_list[id];
      var div = document.getElementById(this.name+"_"+id+"_div");
      var thisdiv = document.getElementById(this.name+"_"+node.id+"_node");
      div.style.display = "block";
      node.isOpen = true;
      //重画父节点
      var tempStr = "";
      tempStr += "<nobr>";
      tempStr += this.DrawLink(node.id);
      tempStr += this.DrawWord(node.id);
      tempStr += "</nobr>";
      thisdiv.innerHTML = tempStr;
      this.openParentNode(node.pid);
    }
  }

  //节点打开操作
  this.openNode = function(id){
    var node = this.node_list[id];	
    var div = document.getElementById(this.name+"_"+id+"_div");
    var str = document.getElementById(this.name+"_"+id);
    var imgo = document.getElementById(this.name+"_"+id+"_o");
    var imgf = document.getElementById(this.name+"_"+id+"_f");
   /* try{
      var thisForm = eval("frmBusiness");
    }
    catch(e){
      var thisForm = null;
    }*/
    if (node.isOpen){
      div.style.display = "none";
      if (imgo!=null){
        imgo.src = imgo.src.replace("minus.gif", "plus.gif");
    	}
      if (imgf!=null){
	      imgf.src = imgf.src.replace(node.openImg, node.closeImg);
    	}
      node.isOpen = false;
      this.setTreeNodeID(id);
      if (this.getChgFlg(id)){
        str.focus();
        this.changeClickID(id);
      }
   
    }
    else{
      if (node.child_list.length > 0){
        div.style.display = "block";
				node.isOpen = true;
      }
      if (imgf!=null){
	      imgf.src = imgf.src.replace(node.closeImg, node.openImg);
    	}
      if (imgo!=null){
        imgo.src = imgo.src.replace("plus.gif", "minus.gif");
    	}
      this.setTreeNodeID(id);
   
      //调整父元素的滚动条
      var mainDiv = document.getElementById(this.name+"_div");
      var pNode = mainDiv.parentNode;
      if (pNode != null){
      	var curH = div.offsetTop - pNode.scrollTop;//该节点在相对高度
      	var difH = pNode.offsetHeight-curH-(str.offsetHeight);
      	var addH = 0;
		if ((curH + div.offsetHeight) > pNode.offsetHeight){
			addH = div.offsetHeight-difH;
		}
		if ((curH-addH) < 0){
			addH = curH-(str.offsetHeight+2);
		}
		pNode.scrollTop = pNode.scrollTop+addH;
      }
    }
	if(node.child_list.length==0){

		initTreeNode(node.name.substring(2),node.nickName);
	}
  }



  //删除节点*******************************************
  this.removeNode = function(nodeId){
    if (nodeId >= 0 && nodeId < this.node_list.length){
      this.changeClickID("-1");
      this.setTreeNodeID("-1");
      var thisNode = this.node_list[nodeId];
      if (document.getElementById(this.name+"_"+nodeId+"_node")!= null){
        var pnodeElm = document.getElementById(this.name+"_"+nodeId+"_node").parentNode;
		//document.getElementById('nse').value=pnodeElm.innerHTML;
		//alert(pnodeElm.innerHTML);
        pnodeElm.removeChild(document.getElementById(this.name+"_"+nodeId+"_node"));
        pnodeElm.removeChild(document.getElementById(this.name+"_"+nodeId+"_div"));
      }


      //父亲节点的重画
      var prevNode = thisNode.prev();
      var nextNode = thisNode.next();
      thisNode.deleteOneChildNode();
      var p_node = this.node_list[thisNode.pid];
	  if(p_node.child_list.length == 0){p_node.setNodeImg("jsdoc.gif");}
      var div = document.getElementById(this.name+"_"+p_node.id+"_div");
      var thisdiv = document.getElementById(this.name+"_"+p_node.id+"_node");
      var tempStr = "";
      tempStr += "<nobr>";
      tempStr += this.DrawLink(p_node.id);
      tempStr += this.DrawWord(p_node.id);
      tempStr += "</nobr>";
      thisdiv.innerHTML = tempStr;
      
	  
      //重画兄弟和本身
      tempStr = "";
      div.style.display = "none";
      if (p_node.child_list.length > 0){		  
        div.style.display = "block";
        if (prevNode != null){
		  this.DrawNodeAgi(prevNode.id);
		}
        if (nextNode != null){
          tempStr = "";
          var nextDiv = document.getElementById(this.name+"_"+nextNode.id+"_node");
          tempStr += "<nobr>";
          tempStr += this.DrawLink(nextNode.id);
          tempStr += this.DrawWord(nextNode.id);
          tempStr += "</nobr>";
          nextDiv.innerHTML = tempStr;
        }


      }
    }
  }
//重画节点及其子节点&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  this.DrawNodeAgi = function(prevNodeId){
      var tempStr = "";
	  var prNode=eval(this.name).getNodeById(prevNodeId);
       if (prNode != null){
          tempStr = "";
          var prevDiv = document.getElementById(this.name+"_"+prNode.id+"_node");
          tempStr += "<nobr>";
          tempStr += this.DrawLink(prNode.id);
          tempStr += this.DrawWord(prNode.id);
          tempStr += "</nobr>";
          prevDiv.innerHTML = tempStr;
        }
		if (prNode.child_list.length > 0){
			for (var i=0; i<prNode.child_list.length; i++){
				this.DrawNodeAgi(prNode.child_list[i]);
			}
		}
  }
  
  //删除根节点
  this.removeRoot = function(){
    if (document.getElementById(this.name+"_div")!= null){
      var pnodeElm = document.getElementById(this.name+"_div").parentNode;
      pnodeElm.removeChild(document.getElementById(this.name+"_div"));
      this.node_list = new Array();
      this.root_list = new Array()
      this.tree_depth = 0;
      this.html_content = "";
      this.selected_node_id = -1;
    }
  }

  //画树
  this.DrawTree = function(in_showType){
    var type = in_showType || false;
    this.html_content = "<div id=\""+this.name+"_div\">";
    
    this.html_content += this.initTree();
    for (var i=0; i<this.root_list.length; i++){
        this.html_content += this.DrawNode(this.root_list[i]);
    }
    this.html_content += "</div>";
    if (type){
      if (this.father != "" && document.getElementById(this.father)!=null){
      	var fatObj = document.getElementById(this.father);
       	fatObj.innerHTML = this.html_content;
      }
      else{
 	     document.writeln(this.html_content);
      }
      this.setTreeNodeID("-1");
    }
    return this.html_content;
  }

  //画节点
  this.DrawNode = function(id){
    var tempStr = "";
    var node = this.node_list[id];
    var display = "none";
    if (node.isOpen){
      display = "block";
    }
    //Draw this node
    tempStr += "<div class=\"tree_node\" id=\""+(this.name+"_"+id+"_node")+"\"><nobr>";
    tempStr += this.DrawLink(id);
    tempStr += this.DrawWord(id);
    tempStr += "</nobr></div>";
    //Draw children
    tempStr += "<div id=\""+(this.name+"_"+id+"_div")+"\" style=\"display:"+display+"\">";
    if (node.child_list.length > 0){
      for (var i=0; i<node.child_list.length; i++){
          tempStr += this.DrawNode(node.child_list[i]);
      }
    }
    tempStr += "</div>";
    return tempStr;
  }

  //画线
  this.DrawLink = function(id){
    var tempStr = "";
    var node = this.node_list[id];
    var oi = "Lplus.gif";
    var of = nseer_img_close;
    var mclick = "";

    if (!this.show_add_img){
    	this.show_line = false;
    }
    //递归画上一层的图片
    if (node.pid >= 0){
      tempStr += this.DrawParentLine(node.pid);
    }

    //设置有孩子节点的图片设置;
    if (node.child_list.length > 0){
      if (node.isOpen){
        of = nseer_img_open;
        oi = "minus.gif";
        if (node.openImg != null && node.openImg != ""){
          of = node.openImg;
        }
      }
      else{
        of = nseer_img_close;
        oi = "plus.gif";
        if (node.closeImg != null && node.closeImg != ""){
          of = node.closeImg;
        }
      }
      if (node.pid < 0){//root
        if (this.root_list[this.root_list.length-1] != id){
          oi = ("T"+oi);
        }
        else{
          oi = ("L"+oi);
        }
      }
      else{
        if (this.node_list[node.pid].child_list[this.node_list[node.pid].child_list.length-1] != id){
          oi = ("T"+oi);
        }
        else{
          oi = ("L"+oi);
        }
      }
    }
    else{
    	//设置无孩子节点的图片
      if (node.pid >= 0){
        if (this.show_line){
          if (this.node_list[node.pid].child_list[this.node_list[node.pid].child_list.length-1] != id){
			oi = node.nodeImg==nseer_img_close?"Tplus.gif":"T.gif";
          }
          else{
            oi = node.nodeImg==nseer_img_close?"Lplus.gif":"L.gif";
          }
        }
	    	else{
					oi = "empty.gif";
		    }
      }
      else {
      	if (this.show_line){
	        if (this.root_list[this.root_list.length-1] == id){
	        	oi = node.nodeImg==nseer_img_close?"Lplus.gif":"L.gif";
	        }
	        else if (this.root_list[0] == id){
	        	oi = "P.gif";
	        }
	        else{
	        	oi = node.nodeImg==nseer_img_close?"Tplus.gif":"T.gif";
	        }
	      }
	    	else{
					oi = "empty.gif";
		    }
      }
      of = "jsdoc.gif";
      if (node.nodeImg != null && node.nodeImg != ""){//**********************************************
        of = node.nodeImg;
      }
    }
    //画+-图片
    if (this.show_add_img){
      tempStr += "<img class=\"node_img\" style=\"cursor:hand;\" onclick=\""+this.name+".openNode("+id+")\" id=\""+this.name+"_"+id+"_o\" align=\"absmiddle\" alt=\"\" src=\""+this.image_path+oi+"\" border=\"0\"/>";
    }
    //画节点图片
	if (this.show_node_img){
	    tempStr += "<img align=\"absmiddle\" style=\"cursor:hand;\" id=\""+this.name+"_"+id+"_f\" alt=\"\" onclick=\""+this.name+".openNode("+id+")\" src=\""+this.image_path+of+"\" border=\"0\"/>";
	}
    return tempStr;
  }

  //画父节点的线
  this.DrawParentLine = function(id){
    var tempStr = "";
    var node = this.node_list[id];
    //Draw pid
    if (node.pid >= 0){
      tempStr += this.DrawParentLine(node.pid);
    }
    if (!this.show_line){
      tempStr += "<img align=\"absmiddle\" alt=\"\" src=\""+this.image_path+"empty.gif\" border=\"0\"/>";
    }
    else{
      if (node.pid < 0){
        if (this.root_list[this.root_list.length-1] != id){
          tempStr += "<img align=\"absmiddle\" alt=\"\" src=\""+this.image_path+"I.gif\" border=\"0\"/>";
        }
        else{
          tempStr += "<img align=\"absmiddle\" alt=\"\" src=\""+this.image_path+"empty.gif\" border=\"0\"/>";
        }
      }
      else{
        if (this.node_list[node.pid].child_list[this.node_list[node.pid].child_list.length-1] != id){
          tempStr += "<img align=\"absmiddle\" alt=\"\" src=\""+this.image_path+"I.gif\" border=\"0\"/>";
        }
        else{
          tempStr += "<img align=\"absmiddle\" alt=\"\" src=\""+this.image_path+"empty.gif\" bswebrder=\"0\"/>";
        }
      }
    }
    return tempStr;
  }


 
  //输出文字
  this.DrawWord = function(id){
    var node = this.node_list[id];
    var tclass = "tree_a";
    if (node.id == this.selected_node_id){
    	tclass = "tree_node_onfocus";
    }

	
    var tempStr = "&nbsp;<a id=\""+(this.name+"_"+id)+"\"  href=\"javascript:void(0)\" class=\""+tclass+"\" onfocus=\"this.blur();\" ";
    //tempStr += "onmousedown=\"aaa()\" ";
    tempStr += "ondblclick=\"doubleClick(event);\" onmousedown=\""+this.name+".showRightMenu("+id+",event,'"
	+this.image_path+"')\" ondrag=\"return false\" onmouseover=\""+this.name+".over("+id+")\" onmouseup=\"href_up(\'"+node.name+"\')\" " ;
   
	if(node.showStr.indexOf('.jsp')!=-1){
	tempStr += ">"+node.showStr+"</a>&nbsp;<span style=\"color:blue;text-decoration:underline\" onclick=\"open_source('"+node.nickName+"')\">打开</span>";//节点的HTML代码.
    }else{
	tempStr += ">"+node.showStr+"</a>";//节点的HTML代码.

	
	}
	
	
	return tempStr;
  }

  /*****树的绘制方法结束*****/

  /*****设置树节点状态方法开始*****/
  //设置当前激活的节点
  this.changeClickID = function(id){
    if (!(this.selected_node_id < 0 || this.selected_node_id == id)){
      var str = document.getElementById(this.name+"_"+this.selected_node_id);
        str.className = "tree_node_onblur";
    }
    if (id >= 0 && id < this.node_list.length){
      var str = document.getElementById(this.name+"_"+id);
      str.className = "tree_node_onfocus";
    }
    this.selected_node_id = id;
  }

  //节点收起时，判断是否存在激活状态的孩子节点
  this.getChgFlg = function(id){
    var node = this.node_list[id];
    for (var i=0; i<node.child_list.length; i++){
      var cnode_id = node.child_list[i];
      if (this.getChgFlg(cnode_id)){
        return true;
      }
      else if (this.selected_node_id == cnode_id){
        return true;
      }
    }
    return false;
  }
  /*****设置树节点状态方法结束*****/


this.over=function (id){
var node = this.node_list[id];
if(nseer_over_tag==1&&node.nodeImg!='jsdoc.gif'){
this.changeClickID(id);
nseer_up_tag=1;
if(node!=null){
var id8=node.name.substring(2);
nseer_del_tag=id8;
}
}
//this.setTreeNodeID(id);
}

this.down=function(id,imgPath){
var node = this.node_list[id];
if(node!=null){
var id8=node.name.substring(2);
nseer_del_tag=id8;
}
isdown = true;
img_tag=node.nodeImg;
div1=document.getElementById('nseerDiv');
div1.innerHTML="<img src="+imgPath+node.nodeImg+" align=\"absMiddle\">&nbsp;"+node.showStr;
nseer_char=node.showStr;
div1.style.position='absolute';
div1.style.background='yellow';
div1.style.padding='2px 5px 2px 5px';
div1.style.border='solid 1px #000000';
div1.className='tree_node_onblur';

//document.body.onmousedown=down;
document.body.onmousemove = move1;
} 


  /*****树的附加动作开始*****/
  this.showRightMenu = function(id,evt,imgPath){
	  if (evt.preventDefault) {
		evt.preventDefault();
}

    this.changeClickID(id);
    this.setTreeNodeID(id);
	this.down(id,imgPath);
     /* var node = this.node_list[id];
	  try{
		var right_menu_div = document.getElementById("rightMenu");
		if(evt.button==2){
			//获取当前鼠标右键按下后的位置，据此定义菜单显示的位置 
            var right_edge = document.body.clientWidth-evt.clientX;
			var bottom_edge = document.body.clientHeight-evt.clientY;
			//如果从鼠标位置到窗口右边的空间小于菜单的宽度，就定位菜单的左坐标（Left）为当前鼠标位置向左一个菜单宽度 
            if (right_edge <right_menu_div.style.width){
				right_menu_div.style.left = document.body.scrollLeft+evt.clientX-right_menu_div.style.width;
			}
			else{//否则，就定位菜单的左坐标为当前鼠标位置 
                right_menu_div.style.left = document.body.scrollLeft + evt.clientX;
			}
			//如果从鼠标位置到窗口下边的空间小于菜单的高度，就定位菜单的上坐标（Top）为当前鼠标位置向上一个菜单高度
			if (bottom_edge <right_menu_div.style.height){
				right_menu_div.style.top = document.body.scrollTop+evt.clientY-right_menu_div.style.height;
			}
			else{//否则，就定位菜单的上坐标为当前鼠标位置
			    right_menu_div.style.top = document.body.scrollTop + evt.clientY;
			}			
			right_menu_div.style.display="block";
		}
	}catch(e){alert(e);}*/
	
  }

  //初始化树
  this.initTree = function(){
    var tempStr = "";
    if (document.getElementById(this.name+"_myTreeNodeID") == null){
      tempStr += "<input type=\"hidden\" id=\""+this.name+"_myTreeNodeID\" name=\""+this.name+"_myTreeNodeID\" value=\"\">";
      tempStr += "<input type=\"hidden\" name=\"thisTreeName\" value=\"\">";
    }
    return tempStr;
  }

  //设置指定节点的选中状态
  this.setNodeActiveById = function (inId){
    if (inId == null){
      alert("请输入一个数字！");
      return;
    }
    if (inId >= 0 && inId < this.node_list.length){
      var node = this.node_list[inId];
      this.openParentNode(node.pid);
      this.changeClickID(inId);
      this.setTreeNodeID(inId);
      return this.node_list[inId];
    }
    return null;
  }

  //根据节点显示的内容模糊查询
  this.searcNodesByText = function (inText){
    if (inText == null || inText == ""){
      alert("请输入要匹配的字符串！");
      return ;
    }
    var resNodes = new Array();
    for (var i=0; i<this.node_list.length; i++){
      if (this.node_list[i].showStr.Trim().indexOf(inText) >= 0){
        resNodes.length++;
        resNodes[resNodes.length-1] = this.node_list[i];
      }
    }
    if (resNodes.length <= 0){
      alert("没有找到匹配的节点！");
    }
    return resNodes;
  }


  //根据节点关键字检索节点
  this.getNodeByName = function (inName){//UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU
    for (var i=0; i<this.node_list.length; i++){
      if (this.node_list[i].getName() == inName){
        return this.node_list[i];
      }
    }
    return null;
  }

 //根据节点索引检索节点
  this.getNodeById = function (inId){
    if (inId >= 0 && inId < this.node_list.length){
      return this.node_list[inId];
    }
    return null;
  }

  this.getSelectNode = function (){
    if (this.getTreeNodeID() >= 0 && this.getTreeNodeID() < this.node_list.length){
      return this.node_list[this.getTreeNodeID()];
    }
    else{
      //alert("没有选中的节点！");
      return null;
    }
  }

  this.getTreeNodeID = function (){
    return document.getElementById(this.name+"_myTreeNodeID").value;
  }
    //设置当前选中树节点
  this.setTreeNodeID = function (in_id){
    document.getElementById(this.name+"_myTreeNodeID").value = in_id;
	if(document.getElementById("thisTreeName")!=null){
		document.getElementById("thisTreeName").value = this.name;
	}
  }
}

function BSNode(id, pid, deepID, treeName, name, showStr, isOpen, nickName, cashTag, stockTag,de_tag){

  this.id=id;//节点索引。
  this.pid=pid;//父节点索引,为-1表示是根。
  this.deepID=deepID;//节点深度。
  this.showStr=showStr||"Node_"+this.id;//节点显示的文字内容
  this.treeName=treeName||"MyTree";//树对象实例名。
  this.name=name?name:"Node";//节点名。
  this.child_list = new Array();
  this.isOpen = isOpen||false;
  this.openImg = nseer_img_open;
  this.closeImg = nseer_img_close;
  if(id==0){
  this.openImg = "myComputer.gif";
  this.closeImg = "myComputer.gif";}
  var jsdoc=nseer_img_tag==1?"driver.gif":"jsdoc.gif";	
  this.nodeImg = de_tag=="1"?nseer_img_close:jsdoc;
  this.nickName = nickName;
  this.cashTag = cashTag||"";
  this.stockTag = stockTag||"";

  /*****get/set方法开始*****/
  this.getId = function (){
    return this.id;
  }
  this.setId = function (inId){
    this.id = inId;
  }

  this.getName = function (){
    return this.name;
  }
  this.setName = function (inName){
    this.name = inName;
  }
this.getNodeImg = function (){
    return this.nodeImg;
  }
  this.setNodeImg = function (nodeImg){
    this.nodeImg = nodeImg;
  }

 

	//更新节点显示的文字//UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU
  this.setShowStr = function (inStr){
    this.showStr = inStr;
    if (document.getElementById(this.treeName+"_"+this.id)!= null){
      document.getElementById(this.treeName+"_"+this.id).innerHTML = this.showStr;
    }
  }
  this.getShowStr = function (){
    return this.showStr;
  }

  this.getNickName = function (){
    return this.nickName;
  }
  this.setNickName = function (inNickName){
    this.nickName = inNickName;
  }

  this.getCashTag = function (){
    return this.cashTag;
  }
  this.setCashTag = function (inCashTag){
    this.cashTag= inCashTag;
  }

  this.getStockTag = function (){
    return this.stockTag;
  }
  this.setStockTag = function (inStockTag){
    this.stockTag = inStockTag;
  }

  /*****get/set方法结束*****/

  /*****节点操作方法开始*****/
  this.addChildItem = function(id){
    this.child_list.length++;
    this.child_list[this.child_list.length - 1] = id;
  }



  //添加子节点UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU
  this.addNode = function(name, showStr,isOpen,nickName,cashTag, stockTag,de_tag){
    var tempTree = eval(this.treeName);
    return tempTree.addNode(this.id, (this.deepID+1), name, showStr,isOpen,nickName,cashTag, stockTag,de_tag);
  }
  this.deleteOneChildNode = function(){
    var tempTree = eval(this.treeName);
    var p=-1;
    if (this.pid < 0){
      //单个根节点（暂不提供）
    }
    else{
      var p_node = tempTree.node_list[this.pid];
      for (var i=0; i<p_node.child_list.length; i++){
        //得到孩子位置
        if (p_node.child_list[i] == this.id){
          p = i;
        }
        if (p >= 0 && i <= p_node.child_list.length-2){
          p_node.child_list[i] = p_node.child_list[i+1];
        }
      }
      if (p >= 0){
        p_node.child_list.length--;
      }
    }
  }

  //删除本节点
  this.remove = function(){//UUUUUUUUUUUUUUUUUUUUUU
    var tempTree = eval(this.treeName);
    tempTree.removeNode(this.id);
  }

  //激活该节点//UUUUUUUUUUUUUUUUUUUUUUUUUUU
  this.setNodeActive = function (){
	  
    var tempTree = eval(this.treeName);
    tempTree.setNodeActiveById(this.id);
  }

 

  //删除本节点的所有孩子节点UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUu
  this.removeAllChildren = function(){
    var tempTree = eval(this.treeName);
    var t_length = this.child_list.length;
    for (var i=0; i<t_length; i++){
      tempTree.removeNode(this.child_list[0]);
    }
    this.setNodeActive();
  }
   //得节点父节点下孩子的名称
 this.parentNodeHtml = function(){
    var tempTree = eval(this.treeName);
    var t_length = this.child_list.length;
	var href_array=new Array();
	if(this.child_list[0]!=undefined){
	for(var i=0;i<t_length;i++){
	var thisNode = tempTree.node_list[this.child_list[i]];
     href_array.push(thisNode.showStr);
	}
	}
	return href_array;	  
  }

  /*****节点操作方法开始*****/

  /*****亲属节点开始*****/
  //得到上一个兄弟
  this.prev = function (){
    var tempTree = eval(this.treeName);
    var p_node = tempTree.node_list[this.pid];
    for (var i=0; i<p_node.child_list.length; i++){
      if (p_node.child_list[i] == this.id && i>0){
          return tempTree.node_list[p_node.child_list[i-1]];
      }
    }
    return null;
  }

  //得到下一个兄弟
  this.next = function (){
    var tempTree = eval(this.treeName);
    var p_node = tempTree.node_list[this.pid];
    for (var i=0; i<p_node.child_list.length; i++){
      if (p_node.child_list[i] == this.id && i<p_node.child_list.length-1){
          return tempTree.node_list[p_node.child_list[i+1]];
      }
    }
    return null;
  }

  //根据节点显示的内容模糊查询子节点//UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU
  this.searcNodesByText = function (inText){
    if (inText == null || inText == ""){
      alert("请输入要匹配的字符串！");
      return ;
    }
    var tempTree = eval(this.treeName);
    var resNodes = new Array();
    this.searchChildrenNodeByText(resNodes, inText);
    if (resNodes.length <= 0){
      alert("没有找到匹配的节点！");
    }
    return resNodes;
  }

  //查找匹配的孩子节点(私有)UUUUUUUUUUUUUUUUUUUUUUUUUUU
  this.searchChildrenNodeByText = function(resNodes, inText){
    var tempTree = eval(this.treeName);
    for (var i=0; i<this.child_list.length; i++){
      var thisNode = tempTree.node_list[this.child_list[i]];
      if (thisNode.showStr.Trim().indexOf(inText) >= 0){
        resNodes.length++;
        resNodes[resNodes.length-1] = thisNode;
      }
      //查找孩子的孩子
      if (thisNode.child_list.length > 0){
        thisNode.searchChildrenNodeByText(resNodes, inText);
      }
    }
  }
}
if (window.attachEvent) window.attachEvent("onload",function(){
var nseerDiv=document.createElement('div');
nseerDiv.id='nseerDiv';
nseerDiv.style.display='none';
document.body.appendChild(nseerDiv);
},false);
if (window.addEventListener)window.addEventListener("load",function(){//监听一个事件，绑定很多个方法
var nseerDiv=document.createElement('div');
nseerDiv.id='nseerDiv';
nseerDiv.style.display='none';
document.body.appendChild(nseerDiv);
},false);

function move1(evt) { //执行移动
if (isdown){
nseer_over_tag=1;
evt=evt||event;
var endx = evt.clientX+document.body.scrollLeft; //层的位置
var endy = evt.clientY+document.body.scrollTop; 
//div1.innerHTML=endx;
div1.style.left = endx+10+'px'; 
div1.style.top = endy+2+'px';
div1.style.display='block';
} 
document.body.onmouseup = up;
} 

function up() {
nseer_over_tag=0;//标志位归0
isdown = false; 
div1.style.display='none';
} 

function href_up(node_name) {
nseer_over_tag=0;
isdown = false; 
div1.style.display='none';
//if(nseer_up_tag==1){alert('TTTTTTT');}
var node1=Nseer_tree.getSelectNode();//得节点对象
if(node1!=null){//删除原有节点
var id=node1.name.substring(2);
if(nseer_del_tag!=id){
var node=Nseer_tree.getNodeByName(node_name);
var tag=true;
var nseer_repeat_tag=0;
//alert(node.parentNodeHtml());
for(var j=0;j<node.parentNodeHtml().length;j++){
if(node.parentNodeHtml()[j]==node1.showStr){

var answer=window.confirm('文件夹已存在,你要覆盖吗?');//判断文件夹是否存在
        if (answer) {
nseer_repeat_tag=1;
tag=true;
		  }else {
tag=false;
		  }
	}
}
var s=node1.nickName.lastIndexOf('%5c');//代表"\"可能有对照表
if(tag){
var nodeImgTag=node1.nodeImg=='close.gif'?'1':'0';
node1.removeAllChildren();//删除子节点.
node1.remove();//删除本身
var short_path=node1.nickName.substring(s,node1.nickName.length);
//alert(short_path+'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
//alert(node.nickName+'WWWWWWWWWWWWWWWWWWWWWWWWWWWWWW');
if(nseer_repeat_tag!=1){//加载节点
//alert(node.name+(j+1));
node.addNode(node.name+(j+1)+'01','<font color=red>'+node1.showStr+'</font>',false,node.nickName+short_path,'','',nodeImgTag);
}

DWREngine.setAsync(true);
window.openDialog('filemove','#80FF80');
FileMove.copy(node1.nickName,node.nickName,{callback:function (){neatDialog.close();
}});//copy文件
DWREngine.setAsync(true);
}
var tag=img_tag=='close.gif'?'1':'0';
}
}
}





function doubleClick(evt){//双击事件
	var dbnode=Nseer_tree.getSelectNode();
	if(document.getElementById('dblselected')!=null&&dbnode.nodeImg=="jsdoc.gif"){
		writerf();
	}else{
		
		if(dbnode.child_list.length!=0){
			Nseer_tree.openNode(dbnode.id);
		}else{//执行双击打开

			initTreeNode(dbnode.name.substring(2),dbnode.nickName);
			
		}
	}
	
}
function open_source(msg){
document.getElementById('nseer_open_source').style.display='block';
document.getElementById('nseer_open_source').innerHTML="<iframe frameborder=\"0\" name=\"frm\" src=\"../../javascript/online_editplus/edit.jsp?file_path="+msg+"\" width=\"100%\" height=\"100%\" scrolling=\"no\" />"

}