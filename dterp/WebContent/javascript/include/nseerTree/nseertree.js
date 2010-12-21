/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function getPath() {
    var str = window.location.pathname;
    var arr = str.split("/");
    if (arr[0] == "") {
        return arr[1];
    } else {
        return arr[0];
    }
};
String.prototype.Trim = function() {
    return this.replace(/(^\s*)|(\s*$)/g, "");
};
function Tree(MyTree) {
    this.name = MyTree || "MyTree";
    this.node_list = new Array();
    this.root_list = new Array();
    this.tree_depth = 0;
    this.html_content = "";
    this.selected_node_id = -1;
    this.image_path = "images/";
    this.show_line = true;
    this.show_add_img = true;
    this.show_node_img = true;
    this.tableName = "";
    this.moduleName = "";
    this.condition = "";
    this.parent = null;
    this.node_num = 1;
    this.setParent = function(parent) {
        this.parent = parent;
    };
    this.setImagesPath = function(img_path) {
        this.image_path = img_path;
    };
    this.setTableName = function(table_name) {
        this.tableName = table_name;
    };
    this.getTableName = function() {
        return this.tableName;
    };
    this.setModuleName = function(module_name) {
        this.moduleName = module_name;
    };
    this.getModuleName = function() {
        return this.moduleName;
    };
    this.setCondition = function(condition) {
        this.condition = condition;
    };
    this.getCondition = function() {
        return this.condition;
    };
    this.addRootNode = function(name, showStr, isOpen, detailsTag, attributeArray) {
        return this.addNode( - 1, 0, name, showStr, isOpen, detailsTag, attributeArray);
    };
    this.addNode = function(pid, deepID, name, showStr, isOpen, detailsTag, attributeArray) {
        var inNode = new BSNode(this.node_list.length, pid, deepID, this.name, name, showStr, isOpen, detailsTag, attributeArray);
        if (pid >= 0) {
            this.node_list[pid].addChildItem(this.node_list.length);
        } else {
            this.root_list.length++;
            this.root_list[this.root_list.length - 1] = this.node_list.length;
        }
        this.node_list.length++;
        this.node_list[this.node_list.length - 1] = inNode;
        this.node_num++;
        if (deepID > this.tree_depth && deepID < ++this.node_num) {
            this.tree_depth = deepID;
        }
        if (document.getElementById(this.name + "_div") != null) {
            var node = this.node_list[inNode.id];
            this.openParentNode(node.pid);
            var p_node = this.node_list[node.pid];
            if (p_node.detailsTag == "0") {
                p_node.setDetailsTag("1");
            }
            var div = document.getElementById(this.name + "_" + p_node.id + "_div");
            tempStr = "";
            if (p_node.child_list.length > 0) {
                var prevNode = node.prev();
                if (prevNode != null) {
                    div.removeChild(document.getElementById(this.name + "_" + prevNode.id + "_node"));
                    div.removeChild(document.getElementById(this.name + "_" + prevNode.id + "_div"));
                    tempStr += this.DrawNode(prevNode.getId());
                }
                tempStr += this.DrawNode(inNode.id);
                div.innerHTML = (div.innerHTML + tempStr);
            }
            this.node_num = 1;
        }
        return inNode;
    };
    this.openParentNode = function(id) {
        if (id >= 0) {
            var node = this.node_list[id];
            var div = document.getElementById(this.name + "_" + id + "_div");
            var thisdiv = document.getElementById(this.name + "_" + node.id + "_node");
            div.style.display = "block";
            node.isOpen = true;
            var tempStr = "";
            tempStr += "<nobr>";
            tempStr += this.DrawLink(node.id);
            tempStr += this.DrawWord(node.id);
            tempStr += "</nobr>";
            thisdiv.innerHTML = tempStr;
            this.openParentNode(node.pid);
        }
    };
    this.openNode = function(id) {
        var node = this.node_list[id];
        var div = document.getElementById(this.name + "_" + id + "_div");
        var str = document.getElementById(this.name + "_" + id);
        var imgo = document.getElementById(this.name + "_" + id + "_o");
        var imgf = document.getElementById(this.name + "_" + id + "_f");
        if (node.isOpen) {
            div.style.display = "none";
            if (imgo != null) {
                imgo.style.backgroundImage = imgo.style.backgroundImage.replace("minus.gif", "plus.gif");
            }
            if (imgf != null) {
                imgf.style.backgroundImage = imgf.style.backgroundImage.replace(node.openImg, node.closeImg);
            }
            node.isOpen = false;
            this.setTreeNodeID(id);
            if (this.getChgFlg(id)) {
                str.focus();
                this.changeClickID(id);
            }
        } else {
            if (node.child_list.length > 0) {
                div.style.display = "block";
                node.isOpen = true;
            }
            if (imgf != null) {
                imgf.style.backgroundImage = imgf.style.backgroundImage.replace(node.closeImg, node.openImg);
            }
            if (imgo != null) {
                imgo.style.backgroundImage = imgo.style.backgroundImage.replace("plus.gif", "minus.gif");
            }
            var mainDiv = document.getElementById(this.name + "_div");
            var pNode = mainDiv.parentNode;
        }
        if (node.detailsTag == "1" && node.child_list.length == 0) {
            initTreeNode(node, this.moduleName, this.tableName);
        }
    };
    this.removeNode = function(nodeId) {
        if (nodeId >= 0 && nodeId < this.node_list.length) {
            this.changeClickID("-1");
            this.setTreeNodeID("-1");
            var thisNode = this.node_list[nodeId];
            if (document.getElementById(this.name + "_" + nodeId + "_node") != null) {
                var pnodeElm = document.getElementById(this.name + "_" + nodeId + "_node").parentNode;
                pnodeElm.removeChild(document.getElementById(this.name + "_" + nodeId + "_node"));
                pnodeElm.removeChild(document.getElementById(this.name + "_" + nodeId + "_div"));
            }
            var prevNode = thisNode.prev();
            var nextNode = thisNode.next();
            thisNode.deleteOneChildNode();
            var p_node = this.node_list[thisNode.pid];
            if (p_node.child_list.length == 0) {
                p_node.setNodeImg("jsdoc.gif");
                p_node.setDetailsTag("0");
            }
            var div = document.getElementById(this.name + "_" + p_node.id + "_div");
            var thisdiv = document.getElementById(this.name + "_" + p_node.id + "_node");
            var tempStr = "";
            tempStr += "<nobr>";
            tempStr += this.DrawLink(p_node.id);
            tempStr += this.DrawWord(p_node.id);
            tempStr += "</nobr>";
            thisdiv.innerHTML = tempStr;
            tempStr = "";
            div.style.display = "none";
            if (p_node.child_list.length > 0) {
                div.style.display = "block";
                if (prevNode != null) {
                    this.DrawNodeAgi(prevNode.id);
                }
                if (nextNode != null) {
                    tempStr = "";
                    var nextDiv = document.getElementById(this.name + "_" + nextNode.id + "_node");
                    tempStr += "<nobr>";
                    tempStr += this.DrawLink(nextNode.id);
                    tempStr += this.DrawWord(nextNode.id);
                    tempStr += "</nobr>";
                    nextDiv.innerHTML = tempStr;
                }
            }
        }
    };
    this.DrawNodeAgi = function(prevNodeId) {
        var tempStr = "";
        var prNode = eval(this.name).getNodeById(prevNodeId);
        if (prNode != null) {
            tempStr = "";
            var prevDiv = document.getElementById(this.name + "_" + prNode.id + "_node");
            tempStr += "<nobr>";
            tempStr += this.DrawLink(prNode.id);
            tempStr += this.DrawWord(prNode.id);
            tempStr += "</nobr>";
            prevDiv.innerHTML = tempStr;
        }
        if (prNode.child_list.length > 0) {
            for (var i = 0; i < prNode.child_list.length; i++) {
                this.DrawNodeAgi(prNode.child_list[i]);
            }
        }
    };
    this.removeRoot = function() {
        if (document.getElementById(this.name + "_div") != null) {
            var pnodeElm = document.getElementById(this.name + "_div").parentNode;
            pnodeElm.removeChild(document.getElementById(this.name + "_div"));
            this.node_list = new Array();
            this.root_list = new Array();
            this.tree_depth = 0;
            this.html_content = "";
            this.selected_node_id = -1;
        }
    };
    this.DrawTree = function(in_showType) {
        var type = in_showType || false;
        this.html_content = "<div id=\"" + this.name + "_div\">";
        this.html_content += this.initTree();
        for (var i = 0; i < this.root_list.length; i++) {
            this.html_content += this.DrawNode(this.root_list[i]);
        }
        this.html_content += "</div>";
        if (type) {
            if (this.parent != "" && document.getElementById(this.parent) != null) {
                var fatObj = document.getElementById(this.parent);
                fatObj.innerHTML = this.html_content;
            } else {
                document.writeln(this.html_content);
            }
            this.setTreeNodeID("-1");
        }
        return this.html_content;
    };
    this.DrawNode = function(id) {
        var tempStr = "";
        var node = this.node_list[id];
        var display = "none";
        if (node.isOpen) {
            display = "block";
        }
        tempStr += "<div class=\"tree_node\" id=\"" + (this.name + "_" + id + "_node") + "\"><nobr>";
        tempStr += this.DrawLink(id);
        tempStr += this.DrawWord(id);
        tempStr += "</nobr></div>";
        tempStr += "<div id=\"" + (this.name + "_" + id + "_div") + "\" style=\"display:" + display + "\">";
        if (node.child_list.length > 0) {
            for (var i = 0; i < node.child_list.length; i++) {
                tempStr += this.DrawNode(node.child_list[i]);
            }
        }
        tempStr += "</div>";
        return tempStr;
    };
    this.DrawLink = function(id) {
        var tempStr = "";
        var node = this.node_list[id];
        var oi = "Lplus.gif";
        var of = "close.gif";
        var mclick = "";
        if (!this.show_add_img) {
            this.show_line = false;
        }
        if (node.pid >= 0) {
            tempStr += this.DrawParentLine(node.pid);
        }
        if (node.child_list.length > 0) {
            if (node.isOpen) {
                of = "open.gif";
                oi = "minus.gif";
                if (node.openImg != null && node.openImg != "") {
                    of = node.openImg;
                }
            } else {
                of = "close.gif";
                oi = "plus.gif";
                if (node.closeImg != null && node.closeImg != "") {
                    of = node.closeImg;
                }
            }
            if (node.pid < 0) {
                if (this.root_list[this.root_list.length - 1] != id) {
                    oi = ("T" + oi);
                } else {
                    oi = ("L" + oi);
                }
            } else {
                if (this.node_list[node.pid].child_list[this.node_list[node.pid].child_list.length - 1] != id) {
                    oi = ("T" + oi);
                } else {
                    oi = ("L" + oi);
                }
            }
        } else {
            if (node.pid >= 0) {
                if (this.show_line) {
                    if (this.node_list[node.pid].child_list[this.node_list[node.pid].child_list.length - 1] != id) {
                        oi = node.nodeImg == "close.gif" ? "Tplus.gif": "T.gif";
                    } else {
                        oi = node.nodeImg == "close.gif" ? "Lplus.gif": "L.gif";
                    }
                } else {
                    oi = "empty.gif";
                }
            } else {
                if (this.show_line) {
                    if (this.root_list[this.root_list.length - 1] == id) {
                        oi = node.nodeImg == "close.gif" ? "Lplus.gif": "L.gif";
                    } else {
                        if (this.root_list[0] == id) {
                            oi = "P.gif";
                        } else {
                            oi = node.nodeImg == "close.gif" ? "Tplus.gif": "T.gif";
                        }
                    }
                } else {
                    oi = "empty.gif";
                }
            }
            of = "jsdoc.gif";
            if (node.nodeImg != null && node.nodeImg != "") {
                of = node.nodeImg;
            }
        }
        if (this.show_add_img) {
            tempStr += "<span class=\"node_img\" style=\"width:16px;height:16px;cursor:hand;background-image:url(" + this.image_path + oi + ");\" onclick=\"" + this.name + ".openNode(" + id + ")\" id=\"" + this.name + "_" + id + "_o\"  alt=\"\" border=\"0\"></span>";
        }
        if (this.show_node_img) {
            tempStr += "<span  style=\"width:16px;height:16px;cursor:hand;background-image:url(" + this.image_path + of + ");\" id=\"" + this.name + "_" + id + "_f\" alt=\"\" onclick=\"" + this.name + ".openNode(" + id + ")\" border=\"0\"></span>";
        }
        return tempStr;
    };
    this.DrawParentLine = function(id) {
        var tempStr = "";
        var node = this.node_list[id];
        if (node.pid >= 0) {
            tempStr += this.DrawParentLine(node.pid);
        }
        if (!this.show_line) {
            tempStr += "<span  style=\"width:16px;height:16px;background-image:url(" + this.image_path + "empty.gif);\" alt=\"\" border=\"0\"></span>";
        } else {
            if (node.pid < 0) {
                if (this.root_list[this.root_list.length - 1] != id) {
                    tempStr += "<span  alt=\"\" style=\"width:16px;height:16px;background-image:url(" + this.image_path + "I.gif);\" border=\"0\"></span>";
                } else {
                    tempStr += "<span  alt=\"\" style=\"width:16px;height:16px;background-image:url(" + this.image_path + "empty.gif);\" border=\"0\"></span>";
                }
            } else {
                if (this.node_list[node.pid].child_list[this.node_list[node.pid].child_list.length - 1] != id) {
                    tempStr += "<span  alt=\"\" style=\"width:16px;height:16px;background-image:url(" + this.image_path + "I.gif);\" border=\"0\"></span>";
                } else {
                    tempStr += "<span  alt=\"\" style=\"width:16px;height:16px;background-image:url(" + this.image_path + "empty.gif);\" bswebrder=\"0\"></span>";
                }
            }
        }
        return tempStr;
    };
    this.DrawWord = function(id) {
        var node = this.node_list[id];
        var tclass = "tree_a";
        if (node.id == this.selected_node_id) {
            tclass = "tree_node_onfocus";
        }
        var tempStr = "&nbsp;<a id=\"" + (this.name + "_" + id) + "\"  href=\"#\" class=\"" + tclass + "\" onfocus=\"this.blur();\" ";
        tempStr += "onmousedown=\"" + this.name + ".showRightMenu(" + id + ",event)\" ";
        tempStr += "ondblclick=\"doubleClick(event," + this.name + ");\" ";
        tempStr += ">" + node.showStr + "</a>";
        return tempStr;
    };
    this.changeClickID = function(id) {
        if (! (this.selected_node_id < 0 || this.selected_node_id == id)) {
            var str = document.getElementById(this.name + "_" + this.selected_node_id);
            str.className = "tree_node_onblur";
        }
        if (id >= 0 && id < this.node_list.length) {
            var str = document.getElementById(this.name + "_" + id);
            str.className = "tree_node_onfocus";
        }
        this.selected_node_id = id;
    };
    this.getChgFlg = function(id) {
        var node = this.node_list[id];
        for (var i = 0; i < node.child_list.length; i++) {
            var cnode_id = node.child_list[i];
            if (this.getChgFlg(cnode_id)) {
                return true;
            } else {
                if (this.selected_node_id == cnode_id) {
                    return true;
                }
            }
        }
        return false;
    };
    this.showRightMenu = function(id, evt) {
        this.changeClickID(id);
        this.setTreeNodeID(id);
    };
    this.initTree = function() {
        var tempStr = "";
        if (document.getElementById(this.name + "_myTreeNodeID") == null) {
            tempStr += "<input type=\"hidden\" id=\"" + this.name + "_myTreeNodeID\" name=\"" + this.name + "_myTreeNodeID\" value=\"\">";
            tempStr += "<input type=\"hidden\" name=\"thisTreeName\" value=\"\">";
        }
        return tempStr;
    };
    this.setNodeActiveById = function(inId) {
        if (inId == null) {
            alert("\u8bf7\u8f93\u5165\u4e00\u4e2a\u6570\u5b57\uff01");
            return;
        }
        if (inId >= 0 && inId < this.node_list.length) {
            var node = this.node_list[inId];
            this.openParentNode(node.pid);
            this.changeClickID(inId);
            this.setTreeNodeID(inId);
            return this.node_list[inId];
        }
        return null;
    };
    this.searcNodesByText = function(inText) {
        if (inText == null || inText == "") {
            alert("\u8bf7\u8f93\u5165\u8981\u5339\u914d\u7684\u5b57\u7b26\u4e32\uff01");
            return;
        }
        var resNodes = new Array();
        for (var i = 0; i < this.node_list.length; i++) {
            if (this.node_list[i].showStr.Trim().indexOf(inText) >= 0) {
                resNodes.length++;
                resNodes[resNodes.length - 1] = this.node_list[i];
            }
        }
        if (resNodes.length <= 0) {
            alert("\u6ca1\u6709\u627e\u5230\u5339\u914d\u7684\u8282\u70b9\uff01");
        }
        return resNodes;
    };
    this.getNodeByName = function(inName) {
        for (var i = 0; i < this.node_list.length; i++) {
            if (this.node_list[i].getName() == inName) {
                return this.node_list[i];
            }
        }
        return null;
    };
    this.getNodeById = function(inId) {
        if (inId >= 0 && inId < this.node_list.length) {
            return this.node_list[inId];
        }
        return null;
    };
    this.getSelectNode = function() {
        if (this.getTreeNodeID() >= 0 && this.getTreeNodeID() < this.node_list.length) {
            return this.node_list[this.getTreeNodeID()];
        } else {
            return null;
        }
    };
    this.getTreeNodeID = function() {
        return document.getElementById(this.name + "_myTreeNodeID").value;
    };
    this.setTreeNodeID = function(in_id) {
        document.getElementById(this.name + "_myTreeNodeID").value = in_id;
        if (document.getElementById("thisTreeName") != null) {
            document.getElementById("thisTreeName").value = this.name;
        }
    };
    this.init = function() {
        var table_obj = serverTree(this.moduleName, this.tableName);
        var field_array = new Array();
        var required_array = new Array();
        var m = 0;
        n = 0;
        var my_condition = this.condition || "";
        for (var i = 0; i < table_obj.column_array.length; i++) {
            if (table_obj.column_array[i].depend == "nodeAttribute") {
                field_array[m] = table_obj.column_array[i].name;
                m++;
            }
            if (table_obj.column_array[i].depend == "required") {
                required_array[n] = table_obj.column_array[i].name;
                n++;
            }
        }
        this.DrawTree(true);
        var id = 0;
        DWREngine.setAsync(false);
        if (this.getNodeByName("No0") != null && this.getNodeByName("No0") != "") {
            NseerTreeDB.getNodeInf(id, this.tableName, required_array, field_array, my_condition, {
                callback: function(msg) {
                    var data = msg;
                    if (data != null && data != "") {
                        var node1 = this.getNodeByName("No" + id);
                        if (node1 != null && node1 != "") {
                            for (var i = 0; i < data.length; i++) {
                                var dbCol = data[i].toString();
                                var nodeInf = dbCol.split("\u2606");
                                var nodeName = nodeInf[0].split("\u25ce")[0];
                                var nodeShowStr = nodeInf[0].split("\u25ce")[1];
                                var myDetailsTag = nodeInf[0].split("\u25ce")[2];
                                var myAttributeArray = nodeInf[1].split("\u25ce");
                                node1.addNode("No" + nodeName, nodeShowStr, false, myDetailsTag, [field_array, myAttributeArray]);
                            }
                        }
                    }
                }
            });
        }
        DWREngine.setAsync(true);
        this.setNodeActiveById(1);
        id = 0;
    };
};
function BSNode(id, pid, deepID, treeName, name, showStr, isOpen, detailsTag, attributeArray) {

    this.id = id;
    this.pid = pid;
    this.deepID = deepID;
    this.showStr = showStr || "Node_" + this.id;
    this.treeName = treeName || "NseerTree1";
    this.name = name ? name: "Node";
    this.child_list = new Array();
    this.isOpen = isOpen || false;
    this.detailsTag = detailsTag || "0";
    this.openImg = "open.gif";
    this.closeImg = "close.gif";
    this.nodeImg = detailsTag == "1" ? "close.gif": "jsdoc.gif";
    this.attributeArray = attributeArray;
    this.getId = function() {
        return this.id;
    };
    this.setId = function(inId) {
        this.id = inId;
    };
    this.getNodeImg = function() {
        return this.nodeImg;
    };
    this.setNodeImg = function(nodeImg) {
        this.nodeImg = nodeImg;
    };
    this.getName = function() {
        return this.name;
    };
    this.setName = function(inName) {
        this.name = inName;
    };
    this.getDetailsTag = function() {
        return this.detailsTag;
    };
    this.setDetailsTag = function(detailsTag) {
        this.detailsTag = detailsTag;
    };
    this.setShowStr = function(inStr) {
        this.showStr = inStr;
        if (document.getElementById(this.treeName + "_" + this.id) != null) {
            document.getElementById(this.treeName + "_" + this.id).innerHTML = this.showStr;
        }
    };
    this.getShowStr = function() {
        return this.showStr;
    };
    this.getAttributeArray = function() {
        return this.attributeArray;
    };
    this.setAttributeArray = function(attributeArray) {
        this.attributeArray = attributeArray;
    };
    this.addChildItem = function(id) {
        this.child_list.length++;
        this.child_list[this.child_list.length - 1] = id;
    };
    this.addNode = function(name, showStr, isOpen, detailsTag, attributeArray) {
        var tempTree = eval(this.treeName);
        return tempTree.addNode(this.id, (this.deepID + 1), name, showStr, isOpen, detailsTag, attributeArray);
    };
    this.deleteOneChildNode = function() {
        var tempTree = eval(this.treeName);
        var p = -1;
        if (this.pid < 0) {} else {
            var p_node = tempTree.node_list[this.pid];
            for (var i = 0; i < p_node.child_list.length; i++) {
                if (p_node.child_list[i] == this.id) {
                    p = i;
                }
                if (p >= 0 && i <= p_node.child_list.length - 2) {
                    p_node.child_list[i] = p_node.child_list[i + 1];
                }
            }
            if (p >= 0) {
                p_node.child_list.length--;
            }
        }
    };
    this.remove = function() {
        var tempTree = eval(this.treeName);
        tempTree.removeNode(this.id);
        if (this.child_list.length == 0) {
            this.setDetailsTag("0");
        }
    };
    this.setNodeActive = function() {
        var tempTree = eval(this.treeName);
        tempTree.setNodeActiveById(this.id);
    };
    this.removeAllChildren = function() {
        var tempTree = eval(this.treeName);
        var t_length = this.child_list.length;
        for (var i = 0; i < t_length; i++) {
            tempTree.removeNode(this.child_list[0]);
        }
        this.setNodeActive();
        this.setDetailsTag("0");
    };
    this.prev = function() {
        var tempTree = eval(this.treeName);
        var p_node = tempTree.node_list[this.pid];
        for (var i = 0; i < p_node.child_list.length; i++) {
            if (p_node.child_list[i] == this.id && i > 0) {
                return tempTree.node_list[p_node.child_list[i - 1]];
            }
        }
        return null;
    };
    this.next = function() {
        var tempTree = eval(this.treeName);
        var p_node = tempTree.node_list[this.pid];
        for (var i = 0; i < p_node.child_list.length; i++) {
            if (p_node.child_list[i] == this.id && i < p_node.child_list.length - 1) {
                return tempTree.node_list[p_node.child_list[i + 1]];
            }
        }
        return null;
    };
    this.searcNodesByText = function(inText) {
        if (inText == null || inText == "") {
            alert("\u8bf7\u8f93\u5165\u8981\u5339\u914d\u7684\u5b57\u7b26\u4e32\uff01");
            return;
        }
        var tempTree = eval(this.treeName);
        var resNodes = new Array();
        this.searchChildrenNodeByText(resNodes, inText);
        if (resNodes.length <= 0) {
            alert("\u6ca1\u6709\u627e\u5230\u5339\u914d\u7684\u8282\u70b9\uff01");
        }
        return resNodes;
    };
    this.searchChildrenNodeByText = function(resNodes, inText) {
        var tempTree = eval(this.treeName);
        for (var i = 0; i < this.child_list.length; i++) {
            var thisNode = tempTree.node_list[this.child_list[i]];
            if (thisNode.showStr.Trim().indexOf(inText) >= 0) {
                resNodes.length++;
                resNodes[resNodes.length - 1] = thisNode;
            }
            if (thisNode.child_list.length > 0) {
                thisNode.searchChildrenNodeByText(resNodes, inText);
            }
        }
    };
};
function initMyTree(nseer_tree) {
    var table_obj = serverTree(nseer_tree.moduleName, nseer_tree.tableName);

    var field_array = new Array();
    var required_array = new Array();
    var m = 0;
    n = 0;
    var my_condition = nseer_tree.condition || "";
    for (var i = 0; i < table_obj.column_array.length; i++) {
        if (table_obj.column_array[i].depend == "nodeAttribute") {
            field_array[m] = table_obj.column_array[i].name;
            m++;
        }
        if (table_obj.column_array[i].depend == "required") {
            required_array[n] = table_obj.column_array[i].name;
            n++;
        }
    }
    nseer_tree.DrawTree(true);
    outWaiting();
    window.setTimeout("eval('" + nseer_tree.name + ".openNode(" + nseer_tree.name + ".getNodeByName(\"No0\").id);')", 500);
};
function initTreeNode(this_node, moduleName, tableName) {
    var table_obj = serverTree(moduleName, tableName);
    var field_array = new Array();
    var required_array = new Array();
    var m = 0;
    n = 0;
    var nseer_tree = eval(this_node.treeName);
    var my_condition = nseer_tree.condition || "";
    for (var i = 0; i < table_obj.column_array.length; i++) {
        if (table_obj.column_array[i].depend == "nodeAttribute") {
            field_array[m] = table_obj.column_array[i].name;
            m++;
        }
        if (table_obj.column_array[i].depend == "required") {
            required_array[n] = table_obj.column_array[i].name;
            n++;
        }
    }
    DWREngine.setAsync(false);

    NseerTreeDB.getNodeInf(this_node.name.substring(2), tableName, required_array, field_array, my_condition, {
        callback: function(msg1) {
            if (msg1 != null && msg1 != "") {
                if (this_node != null && this_node != "") {
                    for (var i = 0; i < msg1.length; i++) {
                        var dbCol1 = msg1[i].toString();
                        var nodeInf1 = dbCol1.split("\u2606");
                        var nodeName1 = nodeInf1[0].split("\u25ce")[0];
                        var nodeShowStr1 = nodeInf1[0].split("\u25ce")[1];
                        var myDetailsTag1 = nodeInf1[0].split("\u25ce")[2];
                        var myAttributeArray1 = nodeInf1[1].split("\u25ce");
                        this_node.addNode("No" + nodeName1, nodeShowStr1, false, myDetailsTag1, [field_array, myAttributeArray1]);
                    }
                }
            } else {}
        }
    });
    DWREngine.setAsync(true);
};
var setGradient = (function() {
    var p_dCanvas = document.createElement("canvas");
    var p_useCanvas = !!(typeof(p_dCanvas.getContext) == "function");
    var p_dCtx = p_useCanvas ? p_dCanvas.getContext("2d") : null;
    var p_isIE =
    /*@cc_on!@*/
    false;
    try {
        p_dCtx.canvas.toDataURL();
    } catch(err) {
        p_useCanvas = false;
    }
    if (p_useCanvas) {
        return function(dEl, sColor1, sColor2, bRepeatY) {
            if (typeof(dEl) == "string") {
                dEl = document.getElementById(dEl);
            }
            if (!dEl) {
                return false;
            }
            var nW = dEl.offsetWidth;
            var nH = dEl.offsetHeight;
            p_dCanvas.width = nW;
            p_dCanvas.height = nH;
            var dGradient;
            var sRepeat;
            if (bRepeatY) {
                dGradient = p_dCtx.createLinearGradient(0, 0, nW, 0);
                sRepeat = "repeat-y";
            } else {
                dGradient = p_dCtx.createLinearGradient(0, 0, 0, nH);
                sRepeat = "repeat-x";
            }
            dGradient.addColorStop(0, sColor1);
            dGradient.addColorStop(1, sColor2);
            p_dCtx.fillStyle = dGradient;
            p_dCtx.fillRect(0, 0, nW, nH);
            var sDataUrl = p_dCtx.canvas.toDataURL("image/png");
            with(dEl.style) {
                backgroundRepeat = sRepeat;
                backgroundImage = "url(" + sDataUrl + ")";
                backgroundColor = sColor2;
            }
        };
    } else {
        if (p_isIE) {
            p_dCanvas = p_useCanvas = p_dCtx = null;
            return function(dEl, sColor1, sColor2, bRepeatY) {
                if (typeof(dEl) == "string") {
                    dEl = document.getElementById(dEl);
                }
                if (!dEl) {
                    return false;
                }
                dEl.style.zoom = 1;
                var sF = dEl.currentStyle.filter;
                dEl.style.filter += " " + ["progid:DXImageTransform.Microsoft.gradient(\tGradientType=", +(!!bRepeatY), ",enabled=true,startColorstr=", sColor1, ", endColorstr=", sColor2, ")"].join("");
            };
        } else {
            p_dCanvas = p_useCanvas = p_dCtx = null;
            return function(dEl, sColor1, sColor2) {
                if (typeof(dEl) == "string") {
                    dEl = document.getElementById(dEl);
                }
                if (!dEl) {
                    return false;
                }
                with(dEl.style) {
                    backgroundColor = sColor2;
                }
            };
        }
    }
})();
function inWaiting() {
    if (document.getElementById("nseerWaitingDiv") != null && document.getElementById("nseerWaitingDiv") != "undefined") {
        return;
    }
    var u = window.location.href.split("://")[1].split("/");
    var url = "";
    for (var i = 0; i < u.length - 3; i++) {
        url += "../";
    }
    var divs = document.getElementsByTagName("div");
    for (var i = 0,
    max = 0; i < divs.length; i++) {
        max = Math.max(max, divs[i].style.zIndex || 0);
    }
    var waite = document.createElement("div");
    waite.id = "nseerWaitingDiv";
    waite.style.cssText = "position:absolute;left:40%;top:111px; width:280px; height:50px;display:block;";
    waite.style.zIndex = max + 10;
    waite.innerHTML = "<div align=center style=\"color:#000000;border:1px solid #ffffff;height:50px;padding:5px 0px 0px 0px\" class=\"example\" id=\"example1\"><img src=\"" + url + "images/include/indicator_medium.gif\">\u8bf7\u7a0d\u5019\uff0c\u6b63\u5728\u52a0\u8f7d\u6570\u636e......</div>";
    document.body.appendChild(waite);
    setGradient("example1", "#BFBBF4", "#ffffff", 1);
};
function outWaiting() {
    var waite = document.getElementById("nseerWaitingDiv");
    if (waite != null && waite != "undefined") {
        document.body.removeChild(waite);
    }
};
var bc_tag;
function showAddBrotherDiv(nseer_tree, css_file, xml_file, url) {
    if (typeof(beforeshowAddBrotherDiv) == "function") {
        if (beforeshowAddBrotherDiv(eval(nseer_tree)) == false) {
            return false;
        }
    }
    var first_xml_file = xml_file.split(",")[0];
    var other_xml_file = xml_file.split(",").length == 1 ? xml_file.split(",")[0] : xml_file.split(",")[1];
    var node = eval(nseer_tree).getSelectNode();
    if (node == null || node.deepID == 0) {
        return false;
    }
    if (node.deepID == 1) {
        readXml(css_file, url + first_xml_file);
    } else {
        readXml(css_file, url + other_xml_file);
    }
    bc_tag = 0;
    DWREngine.setAsync(false);
    multiLangValidate.dwrGetLang("erp", "\u6dfb\u52a0\u540c\u7ea7", {
        callback: function(msg) {
            document.getElementById("current").innerHTML = "<a href=\"javascript:void(0);\"><span align=\"center\">" + msg + "</span></a>";
        }
    });
    DWREngine.setAsync(true);
    aftershowAddBrotherDiv(eval(nseer_tree));
};
function showAddChildDiv(nseer_tree, css_file, xml_file, url) {
    if (typeof(beforeshowAddChildDiv) == "function") {
        if (beforeshowAddChildDiv(eval(nseer_tree)) == false) {
            return false;
        }
    }
    var first_xml_file = xml_file.split(",")[0];
    var other_xml_file = xml_file.split(",").length == 1 ? xml_file.split(",")[0] : xml_file.split(",")[1];
    var node = eval(nseer_tree).getSelectNode();
    if (node == null) {
        return false;
    }
    if (node.deepID == 0) {
        readXml(css_file, url + first_xml_file);
        aftershowAddBrotherDiv(eval(nseer_tree));
    } else {
        readXml(css_file, url + other_xml_file);
        aftershowAddBrotherDiv(eval(nseer_tree));
    }
    bc_tag = 1;
    DWREngine.setAsync(false);
    multiLangValidate.dwrGetLang("erp", "\u6dfb\u52a0\u4e0b\u7ea7", {
        callback: function(msg) {
            document.getElementById("current").innerHTML = "<a href=\"javascript:void(0);\"><span align=\"center\">" + msg + "</span></a>";
        }
    });
    DWREngine.setAsync(true);
};
function showDeleteDiv(nseer_tree, css_file, xml_file, url) {
    var node = eval(nseer_tree).getSelectNode();
    if (node == null || node.deepID == 0) {
        return false;
    }
    readXml(css_file, url + xml_file);
};
function showChangeDiv(nseer_tree, css_file, xml_file, url) {
    beforeChangeDiv(eval(nseer_tree));
    var first_xml_file = xml_file.split(",")[0];
    var other_xml_file = xml_file.split(",").length == 1 ? xml_file.split(",")[0] : xml_file.split(",")[1];
    var node = eval(nseer_tree).getSelectNode();
    if (node == null || node.deepID == 0) {
        return false;
    }
    if (node.deepID == 1) {
        readXml(css_file, url + first_xml_file);
    } else {
        readXml(css_file, url + other_xml_file);
    }
    var table_obj = serverTree(eval(nseer_tree).moduleName, eval(nseer_tree).tableName);
    var field_array = new Array();
    var a = 0;
    for (var i = 0; i < table_obj.column_array.length; i++) {
        var page_id = table_obj.column_array[i].name.toLowerCase();
        var page_obj = document.getElementById(page_id);
        if (page_obj == null || typeof(page_obj) == "undefined") {
            continue;
        }
        field_array[a] = page_id;
        a++;
    }
    var chief_array = [table_obj.column_array[1].name.toLowerCase(), table_obj.column_array[2].name.toLowerCase(), table_obj.column_array[3].name.toLowerCase(), table_obj.column_array[4].name.toLowerCase(), table_obj.column_array[5].name.toLowerCase(), table_obj.column_array[6].name.toLowerCase(), table_obj.column_array[7].name.toLowerCase()];
    DWREngine.setAsync(false);
    NseerTreeDB.getSingleNodeInf(node.name.substring(2), eval(nseer_tree).tableName, field_array, chief_array, {
        callback: function(data_array) {
            for (var i = 0; i < field_array.length; i++) {
                document.getElementById(field_array[i]).value = data_array[i];
                if (field_array[i] == chief_array[4]) {
                    document.getElementById(chief_array[4] + "_hidden").value = data_array[i];
                }
            }
        }
    });
    DWREngine.setAsync(true);
    if (typeof(afterChangeDiv) == "function") {
        if (afterChangeDiv(eval(nseer_tree)) == false) {
            return false;
        }
    }
};
function showQueryDiv(nseer_tree, css_file, xml_file, url) {
    readXml(css_file, url + xml_file);
};
function addTreeNode(nseer_tree) {
    var p = 1;
    if (typeof(beforeAddTreeNode) == "function") {
        if (beforeAddTreeNode(eval(nseer_tree)) == false) {
            return false;
        }
    }
    var node = eval(nseer_tree).getSelectNode();
    if (node.deepID == 0) {
        setParentNodeId("0");
    } else {
        if (bc_tag == 0) {
            if (node.deepID >= _d / 7 + (p++) % p) {
                DWREngine.setAsync(false);
                multiLangValidate.dwrGetLang("erp", "???? ?-????????", {
                    callback: function(msg) {
                        DWREngine.setAsync(true);
                        n_A.divShow(msg);
                        return;
                    }
                });
            }
            setParentNodeId(eval(nseer_tree).node_list[node.pid].name.substring(2));
        } else {
            if (bc_tag == 1) {
                if (node.deepID >= _d / 7) {
                    DWREngine.setAsync(false);
                    multiLangValidate.dwrGetLang("erp", "???? ?-????????", {
                        callback: function(msg) {
                            DWREngine.setAsync(true);
                            n_A.divShow(msg);
                            return;
                        }
                    });
                }
                setParentNodeId(node.name.substring(2));
            }
        }
    }
    if (!doValidate(eval(nseer_tree).moduleName + "/tree-config.xml", eval(nseer_tree).tableName)) {
        return false;
    }
    var data_array = new Array();
    var field_array = new Array();
    var a = 0;
    var table_obj = serverTree(eval(nseer_tree).moduleName, eval(nseer_tree).tableName);
    var file_id = document.getElementById(table_obj.column_array[5].name.toLowerCase()).value;
    var file_name = document.getElementById(table_obj.column_array[6].name.toLowerCase()).value;
    var chief_array = [table_obj.column_array[1].name.toLowerCase(), table_obj.column_array[2].name.toLowerCase(), table_obj.column_array[3].name.toLowerCase(), table_obj.column_array[4].name.toLowerCase(), table_obj.column_array[5].name.toLowerCase(), table_obj.column_array[6].name.toLowerCase(), table_obj.column_array[7].name.toLowerCase()];
    for (var i = 0; i < table_obj.column_array.length; i++) {
        var page_id = table_obj.column_array[i].name.toLowerCase();
        var page_obj = document.getElementById(page_id);
        if (page_obj == null || typeof(page_obj) == "undefined") {
            continue;
        }
        field_array[a] = page_id;
        if (page_obj.type.toLowerCase() == "checkbox") {
            if (page_obj.checked) {
                data_array[a] = "1";
            } else {
                data_array[a] = "0";
            }
        } else {
            data_array[a] = page_obj.value;
        }
        a++;
    }
    var parent_node;
    if (bc_tag == 0) {
        parent_node = eval(nseer_tree).node_list[node.pid];
    } else {
        if (bc_tag == 1) {
            parent_node = node;
        }
    }
    if (parent_node.child_list.length == 0 && parent_node.detailsTag == 1) {
        initTreeNode(parent_node, eval(nseer_tree).moduleName, eval(nseer_tree).tableName);
    }
    doAddNode(eval(nseer_tree).tableName, table_obj, parent_node, file_id, file_name, field_array, data_array, chief_array, table_obj.step_length);
    if (typeof(afterAddTreeNode) == "function") {
        if (afterAddTreeNode(eval(nseer_tree)) == false) {
            return false;
        }
    }
    n_D.closeDiv("remove");
};
function deleteNode(nseer_tree) {
    if (typeof(beforeDeleteNode) == "function") {
        if (beforeDeleteNode(eval(nseer_tree)) == false) {
            return false;
        }
    }
    var table_obj = serverTree(eval(nseer_tree).moduleName, eval(nseer_tree).tableName);
    var chief_array = [table_obj.column_array[1].name.toLowerCase(), table_obj.column_array[2].name.toLowerCase(), table_obj.column_array[3].name.toLowerCase(), table_obj.column_array[4].name.toLowerCase(), table_obj.column_array[5].name.toLowerCase(), table_obj.column_array[6].name.toLowerCase(), table_obj.column_array[7].name.toLowerCase()];
    var node = eval(nseer_tree).getSelectNode();
    if (node != null && node.deepID != 0) {
        var id1 = node.name.substring(2);
        NseerTreeDB.deleteNodeInf(id1, chief_array, eval(nseer_tree).tableName, {
            callback: function(str) {
                if (str == "200") {
                    node.removeAllChildren();
                    node.remove();
                    DWREngine.setAsync(false);
                    multiLangValidate.dwrGetLang("erp", "\u5220\u9664\u6210\u529f", {
                        callback: function(msg) {
                            alert(msg);
                        }
                    });
                    DWREngine.setAsync(true);
                } else {
                    if (str == "100") {
                        DWREngine.setAsync(false);
                        multiLangValidate.dwrGetLang("erp", "\u6b63\u5728\u4f7f\u7528\uff0c\u4e0d\u80fd\u5220\u9664", {
                            callback: function(msg) {
                                alert(msg);
                            }
                        });
                        DWREngine.setAsync(true);
                    }
                }
            }
        });
    }
    if (typeof(afterDeleteNode) == "function") {
        if (afterDeleteNode(eval(nseer_tree)) == false) {
            return false;
        }
    }
    n_D.closeDiv("remove");
};
function changeNode(nseer_tree) {
    beforeChangeNode(eval(nseer_tree));
    var node = eval(nseer_tree).getSelectNode();
    var data_array = new Array();
    var field_array = new Array();
    var a = 0;
    var m = 0;
    var table_obj = serverTree(eval(nseer_tree).moduleName, eval(nseer_tree).tableName);
    var step_length = table_obj.step_length;
    var file_id = document.getElementById(table_obj.column_array[5].name.toLowerCase()).value;
    var file_id_hidden = document.getElementById(table_obj.column_array[5].name.toLowerCase() + "_hidden").value;
    var file_name = document.getElementById(table_obj.column_array[6].name.toLowerCase()).value;
    var chief_array = [table_obj.column_array[1].name.toLowerCase(), table_obj.column_array[2].name.toLowerCase(), table_obj.column_array[3].name.toLowerCase(), table_obj.column_array[4].name.toLowerCase(), table_obj.column_array[5].name.toLowerCase(), table_obj.column_array[6].name.toLowerCase(), table_obj.column_array[7].name.toLowerCase()];
    setParentNodeId(eval(nseer_tree).node_list[node.pid].name.substring(2));
    if (!doValidate(eval(nseer_tree).moduleName + "/tree-config.xml", eval(nseer_tree).tableName, "1")) {
        return false;
    }
    DWREngine.setAsync(false);
    NseerTreeDB.changeNodeInf(eval(nseer_tree).tableName, node.name.substring(2), file_id, file_id_hidden, file_name, chief_array, step_length, {
        callback: function(parent_node_name) {
            for (var i = 0; i < table_obj.column_array.length; i++) {
                if (table_obj.column_array[i].depend == "nodeAttribute") {
                    field_array[m] = table_obj.column_array[i].name;
                    m++;
                }
            }
            m = 0;
            var data_array1 = new Array();
            var field_array1 = new Array();
            for (var i = 0; i < field_array.length; i++) {
                var page_id = field_array[i].toLowerCase();
                var page_obj = document.getElementById(page_id);
                if (page_obj == null || typeof(page_obj) == "undefined") {
                    continue;
                }
                field_array1[m] = page_id;
                if (page_obj.type.toLowerCase() == "checkbox") {
                    if (page_obj.checked) {
                        data_array1[m] = "1";
                    } else {
                        data_array1[m] = "0";
                    }
                } else {
                    data_array1[m] = page_obj.value;
                }
                m++;
            }
            NseerTreeDB.changeNodeAttribute(eval(nseer_tree).tableName, file_id, field_array1, data_array1);
            if (file_id == file_id_hidden || file_id.substring(0, file_id.length - step_length) == file_id_hidden.substring(0, file_id_hidden.length - step_length)) {
                node.setShowStr(file_id + " " + file_name);
            } else {
                var node_name = node.name;
                node.removeAllChildren();
                node.remove();
                var parent_node = eval(nseer_tree).getNodeByName("No" + parent_node_name);
                parent_node.addNode(node_name, file_id + " " + file_name, false, "0", [field_array1, data_array1]);
            }
        }
    });
    DWREngine.setAsync(true);
    afterChangeNode(eval(nseer_tree));
    n_D.closeDiv("remove");
};
function quickSearchNode(nseer_tree) {
    beforeQuickSearchNode(eval(nseer_tree));
    var table_obj = serverTree(eval(nseer_tree).moduleName, eval(nseer_tree).tableName);
    var field_array = new Array();
    var required_array = new Array();
    var m = 0;
    n = 0;
    for (var i = 0; i < table_obj.column_array.length; i++) {
        if (table_obj.column_array[i].depend == "nodeAttribute") {
            field_array[m] = table_obj.column_array[i].name;
            m++;
        }
        if (table_obj.column_array[i].depend == "required") {
            required_array[n] = table_obj.column_array[i].name;
            n++;
        }
    }
    var key_word = document.getElementById("keyword").value;
    if (key_word != null) {
        var rootnode = eval(nseer_tree).getNodeByName("No0");
        rootnode.removeAllChildren();
        rootnode.setShowStr(rootnode.showStr.split("\u641c\u7d22")[0] + " \u641c\u7d22 \"" + key_word + "\"\u7684\u7ed3\u679c");
        if (rootnode != null && rootnode != "") {
            DWREngine.setAsync(false);
            NseerTreeDB.getNodeInfBySearch(key_word, eval(nseer_tree).tableName, required_array, field_array, {
                callback: function(result) {
                    for (var i = 0; i < result.length; i++) {
                        var dbCol = result[i].toString();
                        var nodeInf = dbCol.split("\u2606");
                        var nodeName = nodeInf[0].split("\u25ce")[0];
                        var nodeShowStr = nodeInf[0].split("\u25ce")[1];
                        var myDetailsTag = nodeInf[0].split("\u25ce")[2];
                        var myAttributeArray = nodeInf[1].split("\u25ce");
                        rootnode.addNode("No" + nodeName, nodeShowStr, false, "0", [field_array, myAttributeArray]);
                    }
                }
            });
            DWREngine.setAsync(true);
        }
    }
    var xml_obj = getXmlObj(eval(nseer_tree).moduleName, eval(nseer_tree).tableName);
    var treeDiv_name = xml_obj.getAttribute("div-name");
    if (treeDiv_name == null && treeDiv_name == "") {
        alert("\u8bf7\u914d\u7f6etree\u7684\u6240\u5728\u5c42id\u5230tree-config\u4e2dtable\u7684div-name\u5c5e\u6027\u4e0b");
    } else {
        var treeDiv = document.getElementById(treeDiv_name);
        var myDivs = treeDiv.getElementsByTagName("div");
        var myDiv1;
        for (var i = 0; i < myDivs.length; i++) {
            if (myDivs[i].id == "treeButton") {
                myDiv1 = myDivs[i];
                i = myDivs.length;
            }
        }
        if (myDiv1 != null) {
            var buttons = myDiv1.getElementsByTagName("input");
            var a = 0;
            for (var i = 0; i < buttons.length; i++) {
                if (buttons[i].type == "button" && buttons[i].id == "n_back") {
                    a++;
                }
            }
            if (a == 0) {
                var tbody1 = myDiv1.getElementsByTagName("tbody")[0];
                var tr1 = document.createElement("tr");
                tr1.className = "";
                var td1 = document.createElement("td");
                td1.className = "";
                var input1 = document.createElement("input");
                input1.className = "BUTTON_STYLE1";
                input1.type = "button";
                input1.id = "n_back";
                input1.onclick = function() {
                    window.location.reload();
                };
                DWREngine.setAsync(false);
                multiLangValidate.dwrGetLang("erp", "\u8fd4    \u56de", {
                    callback: function(msg) {
                        input1.value = msg;
                    }
                });
                DWREngine.setAsync(true);
                td1.appendChild(input1);
                tr1.appendChild(td1);
                tbody1.appendChild(tr1);
            }
        }
    }
    afterQuickSearchNode(eval(nseer_tree));
    n_D.closeDiv("remove");
};
function doAddNode(table_name, table_obj, parent_node, file_id, file_name, field_array, data_array, chief_array, step_length) {
    if (parent_node != null) {
        var category_id = table_obj.column_array[1].name;
        var m = 0;
        var field_array0 = new Array();
        for (var i = 0; i < table_obj.column_array.length; i++) {
            if (table_obj.column_array[i].depend == "nodeAttribute") {
                field_array0[m] = table_obj.column_array[i].name;
                m++;
            }
        }
        m = 0;
        var data_array1 = new Array();
        var field_array1 = new Array();
        for (var i = 0; i < field_array0.length; i++) {
            var page_id = field_array0[i].toLowerCase();
            var page_obj = document.getElementById(page_id);
            if (page_obj == null || typeof(page_obj) == "undefined") {
                continue;
            }
            field_array1[m] = page_id;
            if (page_obj.type.toLowerCase() == "checkbox") {
                if (page_obj.checked) {
                    data_array1[m] = "1";
                } else {
                    data_array1[m] = "0";
                }
            } else {
                data_array1[m] = page_obj.value;
            }
            m++;
        }
        DWREngine.setAsync(false);
        NseerTreeDB.getNodeName(table_name, category_id, {
            callback: function(str) {
                var nodeName = "No" + str;
                if (nodeName == "No") {
                    alert("tree-config.xml\u6587\u4ef6\u9519\u8bef\u6216\u6570\u636e\u5e93\u6839\u8282\u70b9\u4e0d\u5b58\u5728");
                    return false;
                }
                if (parent_node.deepID == 0) {
                    NseerTreeDB.insertNodeInf(table_name, str, parseInt(parent_node.name.substring(2)), file_id + " " + file_name, data_array, field_array, chief_array, {
                        callback: function(str) {
                            if (str != "200") {
                                return false;
                            }
                            parent_node.addNode(nodeName, file_id + " " + file_name, false, "0", [field_array1, data_array1]);
                        }
                    });
                } else {
                    if (parent_node.deepID < _d / 7) {
                        NseerTreeDB.getFileId(table_name, chief_array, parseInt(parent_node.name.substring(2)), step_length, {
                            callback: function(fileId) {
                                for (var i = 0; i < field_array.length; i++) {
                                    if (field_array[i] == chief_array[4]) {
                                        data_array[i] = fileId;
                                        i = field_array.length;
                                    }
                                }
                                NseerTreeDB.insertNodeInf(table_name, str, parseInt(parent_node.name.substring(2)), fileId + " " + file_name, data_array, field_array, chief_array, {
                                    callback: function(str) {
                                        if (str != "200") {
                                            return false;
                                        }
                                        parent_node.addNode(nodeName, fileId + " " + file_name, false, "0", [field_array1, data_array1]);
                                        if (document.getElementById("file_id") != null) {
                                            document.getElementById("file_id").value = fileId;
                                        }
                                    }
                                });
                            }
                        });
                    }
                }
            }
        });
        DWREngine.setAsync(true);
    }
};
function doubleClick(evt, nseer_tree) {
    var dbnode = eval(nseer_tree).getSelectNode();
    if (eval(nseer_tree).getNodeByName("No0").showStr.indexOf("\u641c\u7d22") != -1) {} else {
        if (dbnode.child_list.length == 0 && dbnode.detailsTag == 1) {
            initTreeNode(dbnode, eval(nseer_tree).moduleName, eval(nseer_tree).tableName);
        } else {
            if (dbnode.child_list.length != 0) {
                eval(nseer_tree).openNode(dbnode.id);
            } else {
                afterDoubleClick(eval(nseer_tree));
            }
        }
    }
};
function selcetNodeInto(nseer_tree) {
    afterSelectNodeInto(eval(nseer_tree));
};
function getXmlObj(module_name, tableName) {
    var url = module_name + "/";
    if (window.ActiveXObject) {
        var xmlHttp;
        var xml_obj;
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        try {
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                    if (xmlHttp.status == 200 || xmlHttp.status == 0) {
                        var xmlDOM = xmlHttp.responseXML;
                        var treeToot = xmlDOM.documentElement;
                        var tree_root_tagName = treeToot.getElementsByTagName("table");
                        for (var i = 0; i < tree_root_tagName.length; i++) {
                            if (tree_root_tagName[i].getAttribute("name") == tableName) {
                                xml_obj = tree_root_tagName[i];
                            }
                        }
                    }
                }
            };
            xmlHttp.open("GET", url + "tree-config.xml", false);
            xmlHttp.send(null);
        } catch(exception) {
            alert(exception);
        }
    } else {
        var xmlDoc = XmlDocument.create();
        xmlDoc.async = false;
        xmlDoc.load(url + "tree-config.xml");
        if (xmlDoc.documentElement == null) {
            alert("\u914d\u7f6e\u6587\u4ef6\u8bfb\u53d6\u9519\u8bef\uff0c\u8bf7\u68c0\u67e5\u3002");
            return null;
        }
        var treeToot = xmlDoc.documentElement;
        var tree_root_tagName = treeToot.getElementsByTagName("table");
        for (var i = 0; i < tree_root_tagName.length; i++) {
            if (tree_root_tagName[i].getAttribute("name") == tableName) {
                xml_obj = tree_root_tagName[i];
            }
        }
    }
    return xml_obj;
};
function createButton(module_name, tableName, buttonClass) {
    var url = module_name + "/";
    createButtonDiv(getXmlObj(module_name, tableName), url, buttonClass);
};
function createButtonDiv(xml_obj, url, buttonClass) {
    var add_brother_tag = 0;
    add_child_tag = 0;
    delete_tag = 0;
    change_tag = 0;
    search_tag = 0;
    select_tag = 0;
    if (xml_obj.getAttribute("add-brother-node") != null && xml_obj.getAttribute("add-brother-node") != "") {
        add_brother_tag = 1;
    }
    if (xml_obj.getAttribute("add-child-node") != null && xml_obj.getAttribute("add-child-node") != "") {
        add_child_tag = 1;
    }
    if (xml_obj.getAttribute("delete-node") != null && xml_obj.getAttribute("delete-node") != "") {
        delete_tag = 1;
    }
    if (xml_obj.getAttribute("change-node") != null && xml_obj.getAttribute("change-node") != "") {
        change_tag = 1;
    }
    if (xml_obj.getAttribute("search-node") != null && xml_obj.getAttribute("search-node") != "") {
        search_tag = 1;
    }
    if (xml_obj.getAttribute("select-node-into") != null && xml_obj.getAttribute("select-node-into") != "") {
        select_tag = 1;
    }
    if (add_brother_tag == 1 || add_child_tag == 1 || delete_tag == 1 || change_tag == 1 || search_tag == 1 || select_tag == 1) {
        var treeDiv_name = xml_obj.getAttribute("div-name");
        if (treeDiv_name == null && treeDiv_name == "") {
            alert("\u8bf7\u914d\u7f6etree\u7684\u6240\u5728\u5c42id\u5230tree-config\u4e2dtable\u7684div-name\u5c5e\u6027\u4e0b");
            return false;
        }
        var treeDiv = document.getElementById(treeDiv_name);
        var myDiv1 = document.createElement("div");
        myDiv1.id = "treeButton";
        myDiv1.className = buttonClass;
        var table1 = document.createElement("table");
        var tbody1 = document.createElement("tbody");
        if (select_tag == 1) {
            var tr1 = document.createElement("tr");
            tr1.className = "";
            var td1 = document.createElement("td");
            td1.className = "";
            var input1 = document.createElement("input");
            input1.className = "BUTTON_STYLE1";
            input1.type = "button";
            input1.onclick = function() {
                selcetNodeInto(xml_obj.getAttribute("tree-name"));
            };
            DWREngine.setAsync(false);
            multiLangValidate.dwrGetLang("erp", "\u9009    \u5165", {
                callback: function(msg) {
                    input1.value = msg;
                }
            });
            DWREngine.setAsync(true);
            td1.appendChild(input1);
            tr1.appendChild(td1);
            tbody1.appendChild(tr1);
        }
        if (add_brother_tag == 1) {
            var tr1 = document.createElement("tr");
            tr1.className = "";
            var td1 = document.createElement("td");
            td1.className = "";
            var input1 = document.createElement("input");
            input1.className = "BUTTON_STYLE1";
            input1.type = "button";
            input1.onclick = function() {
                showAddBrotherDiv(xml_obj.getAttribute("tree-name"), xml_obj.parentNode.getAttribute("css"), xml_obj.getAttribute("add-brother-node"), url);
            };
            DWREngine.setAsync(false);
            multiLangValidate.dwrGetLang("erp", "\u6dfb\u52a0\u540c\u7ea7", {
                callback: function(msg) {
                    input1.value = msg;
                }
            });
            DWREngine.setAsync(true);
            td1.appendChild(input1);
            tr1.appendChild(td1);
            tbody1.appendChild(tr1);
        }
        if (add_child_tag == 1) {
            var tr1 = document.createElement("tr");
            tr1.className = "";
            var td1 = document.createElement("td");
            td1.className = "";
            var input1 = document.createElement("input");
            input1.className = "BUTTON_STYLE1";
            input1.type = "button";
            input1.onclick = function() {
                showAddChildDiv(xml_obj.getAttribute("tree-name"), xml_obj.parentNode.getAttribute("css"), xml_obj.getAttribute("add-brother-node"), url);
            };
            DWREngine.setAsync(false);
            multiLangValidate.dwrGetLang("erp", "\u6dfb\u52a0\u4e0b\u7ea7", {
                callback: function(msg) {
                    input1.value = msg;
                }
            });
            DWREngine.setAsync(true);
            td1.appendChild(input1);
            tr1.appendChild(td1);
            tbody1.appendChild(tr1);
        }
        if (delete_tag == 1) {
            var tr1 = document.createElement("tr");
            tr1.className = "";
            var td1 = document.createElement("td");
            td1.className = "";
            var input1 = document.createElement("input");
            input1.className = "BUTTON_STYLE1";
            input1.type = "button";
            input1.onclick = function() {
                showDeleteDiv(xml_obj.getAttribute("tree-name"), xml_obj.parentNode.getAttribute("css"), xml_obj.getAttribute("delete-node"), url);
            };
            DWREngine.setAsync(false);
            multiLangValidate.dwrGetLang("erp", "\u5220\u9664\u6240\u9009", {
                callback: function(msg) {
                    input1.value = msg;
                }
            });
            DWREngine.setAsync(true);
            td1.appendChild(input1);
            tr1.appendChild(td1);
            tbody1.appendChild(tr1);
        }
        if (change_tag == 1) {
            var tr1 = document.createElement("tr");
            tr1.className = "";
            var td1 = document.createElement("td");
            td1.className = "";
            var input1 = document.createElement("input");
            input1.className = "BUTTON_STYLE1";
            input1.type = "button";
            input1.onclick = function() {
                showChangeDiv(xml_obj.getAttribute("tree-name"), xml_obj.parentNode.getAttribute("css"), xml_obj.getAttribute("change-node"), url);
            };
            DWREngine.setAsync(false);
            multiLangValidate.dwrGetLang("erp", "\u4fee\u6539\u6240\u9009", {
                callback: function(msg) {
                    input1.value = msg;
                }
            });
            DWREngine.setAsync(true);
            td1.appendChild(input1);
            tr1.appendChild(td1);
            tbody1.appendChild(tr1);
        }
        if (search_tag == 1) {
            var tr1 = document.createElement("tr");
            tr1.className = "";
            var td1 = document.createElement("td");
            td1.className = "";
            var input1 = document.createElement("input");
            input1.className = "BUTTON_STYLE1";
            input1.type = "button";
            input1.onclick = function() {
                showQueryDiv(xml_obj.getAttribute("tree-name"), xml_obj.parentNode.getAttribute("css"), xml_obj.getAttribute("search-node"), url);
            };
            DWREngine.setAsync(false);
            multiLangValidate.dwrGetLang("erp", "\u5feb\u901f\u67e5\u8be2", {
                callback: function(msg) {
                    input1.value = msg;
                }
            });
            DWREngine.setAsync(true);
            td1.appendChild(input1);
            tr1.appendChild(td1);
            tbody1.appendChild(tr1);
        }
        table1.appendChild(tbody1);
        myDiv1.appendChild(table1);
        treeDiv.appendChild(myDiv1);
        var v = 0;
        treeDiv.onscroll = function() {
            if (v == 0) {
                v = myDiv1.offsetTop;
            }
            myDiv1.style.top = v + treeDiv.scrollTop;
        };
    }
};
function XmlDocument() {};
XmlDocument.create = function() {
    if (document.implementation && document.implementation.createDocument) {
        return document.implementation.createDocument("", "", null);
    }
};
function readXml(css, url, cover) {
    cover = cover || "1";
    var nseer_tag_id;
    DWREngine.setAsync(false);
    Multi.readXmlToHtml(url, {
        callback: function(html) {
            var div_id = html.split("\u25ce")[0];
            if (document.getElementById(div_id) != null) {
                document.getElementById(div_id).style.display = "block";
            } else {
                var div1 = document.createElement("div");
                div1.id = html.split("\u25ce")[0];
                div1.innerHTML = html.split("\u25ce")[1];
                nseer_tag_id = div1.id;
                document.body.appendChild(div1);
            }
        }
    });
    DWREngine.setAsync(true);
    if (cover == "1") {
        loadCover(nseer_tag_id);
    }
};
function serverTree(module_name, tableName) {
    var url = module_name + "/";
    var table_obj = new NseerTreeTable();
    if (window.ActiveXObject) {
        var xmlHttp;
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        try {
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                    if (xmlHttp.status == 200 || xmlHttp.status == 0) {
                        var xmlDOM = xmlHttp.responseXML;
                        var treeToot = xmlDOM.documentElement;
                        var tree_root_tagName = treeToot.getElementsByTagName("table");
                        for (var i = 0; i < tree_root_tagName.length; i++) {
                            if (tree_root_tagName[i].getAttribute("name") == tableName) {
                                table_obj.setName(tree_root_tagName[i].getAttribute("name"));
                                table_obj.setDisplayName(tree_root_tagName[i].getAttribute("display-name"));
                                table_obj.setStepLength(parseInt(tree_root_tagName[i].getAttribute("step-length")));
                                var column_tagName = tree_root_tagName[i].getElementsByTagName("field");
                                var column_array = new Array();
                                for (var i = 0; i < column_tagName.length; i++) {
                                    var column_obj = new NseerTreeField();
                                    column_obj.setName(column_tagName[i].getAttribute("name"));
                                    column_obj.setDisplayName(column_tagName[i].getAttribute("display-name"));
                                    if (column_tagName[i].getAttribute("depend") != null) {
                                        column_obj.setDepend(column_tagName[i].getAttribute("depend"));
                                    }
                                    column_array[i] = column_obj;
                                }
                                table_obj.setColumnArray(column_array);
                            }
                        }
                    }
                }
            };
            xmlHttp.open("GET", url + "tree-config.xml", false);
            xmlHttp.send(null);
        } catch(exception) {
            alert(exception);
        }
    } else {
        var xmlDoc = XmlDocument.create();
        xmlDoc.async = false;
        xmlDoc.load(url + "tree-config.xml?" + Math.random());
        if (xmlDoc.documentElement == null) {
            alert("\u914d\u7f6e\u6587\u4ef6\u8bfb\u53d6\u9519\u8bef\uff0c\u8bf7\u68c0\u67e5\u3002");
            return null;
        }
        var treeToot = xmlDoc.documentElement;
        var tree_root_tagName = treeToot.getElementsByTagName("table");
        for (var i = 0; i < tree_root_tagName.length; i++) {
            if (tree_root_tagName[i].getAttribute("name") == tableName) {
                table_obj.setName(tree_root_tagName[i].getAttribute("name"));
                table_obj.setDisplayName(tree_root_tagName[i].getAttribute("display-name"));
                table_obj.setStepLength(parseInt(tree_root_tagName[i].getAttribute("step-length")));
                var column_tagName = tree_root_tagName[i].getElementsByTagName("field");
                var column_array = new Array();
                for (var i = 0; i < column_tagName.length; i++) {
                    var column_obj = new NseerTreeField();
                    column_obj.setName(column_tagName[i].getAttribute("name"));
                    column_obj.setDisplayName(column_tagName[i].getAttribute("display-name"));
                    if (column_tagName[i].getAttribute("depend") != null) {
                        column_obj.setDepend(column_tagName[i].getAttribute("depend"));
                    }
                    column_array[i] = column_obj;
                }
                table_obj.setColumnArray(column_array);
            }
        }
    }
    return table_obj;
};
function NseerTreeTable() {
    this.name = "";
    this.display_name = "";
    this.step_length = 0;
    this.column_array = new Array() || [];
    this.setName = function(name) {
        this.name = name;
    };
    this.getName = function() {
        return this.name;
    };
    this.setDisplayName = function(display_name) {
        this.display_name = display_name;
    };
    this.getDisplayName = function() {
        return this.display_name;
    };
    this.setStepLength = function(step) {
        this.step_length = step;
    };
    this.getStepLength = function() {
        return this.step_length;
    };
    this.setColumnArray = function(column_array) {
        this.column_array = column_array;
    };
    this.getColumnArray = function() {
        return this.column_array;
    };
};
function NseerTreeField() {
    this.name = "";
    this.display_name = "";
    this.depend = "";
    this.setName = function(name) {
        this.name = name;
    };
    this.getName = function() {
        return this.name;
    };
    this.setDisplayName = function(display_name) {
        this.display_name = display_name;
    };
    this.getDisplayName = function() {
        return this.display_name;
    };
    this.setDepend = function(depend) {
        this.depend = depend;
    };
    this.getDepend = function() {
        return this.depend;
    };
}