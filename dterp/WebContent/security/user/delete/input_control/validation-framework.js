/*
 * JavaScript Validation Framework
 *
 * Author: Michael Chen(mechiland) on 2004/03
 * This software is on the http://www.cosoft.org.cn/projects/jsvalidation
 * for update, bugfix, etc, you can goto the homepage and submit your request 
 * and question.
 * Apache License 2.0
 * You should use this software under the terms.
 *
 * Please, please keep above words. At least ,please make a note that such as 
 * "This software developed by Michael Chen(http://www.jzchen.net)" .
 * $Id: validation-framework.js,v 1.1 2008/05/24 07:10:31 nseer Exp $
 */

/** Config Section, Config these fields to make this framework work. **/

// If there is only one config file in your system, use this property. otherwise, use
//     ValidationFramework.init("configfile")     
// instead.
var ValidationRoot = "input_control/";

// the field style when validation fails. it aim to provide more beautiful UI and more good
// experience to the end-user. 
// NOTE: this will be buggy. Please report the error to me.
var ValidationFailCssStyle = "";//border:2px solid #FFCC88;

//Validation function. The entry point of the framework.
function doValidate(formRef) {
	try {
		var formId = formRef;
		if (typeof (formRef) == "string") {
			formId = formRef;
		} else if (typeof (formRef) == "object") {
			formId = formRef.getAttribute("id");
		}

		var form = FormFactory.getFormFromId(formId);
		if (form != null) {
			return ValidationFramework.validateForm(form);
		} else {
			return false;
		}
	} catch (e) {
		ValidationFramework.exception(e.name+":" +e.description);
		return false;
	}
	
}
/**===================================================================**/
/*
 * JSValidation Framework Code Started 
 * 
 * Please do not modify the code unless you are very familiar with JavaScript.
 * The best way to solve problem is report the problem to our project page.
 * url: http://cosoft.org.cn/projects/jsvalidation
 */
// The Xml document. To process cross-browser. Thanks Eric.
function XmlDocument() {}
XmlDocument.create = function () {
	if (document.implementation && document.implementation.createDocument) {
		return document.implementation.createDocument("", "", null);
	} 
}

function ValidationFramework() {}
ValidationFramework._validationCache = null;
ValidationFramework._currentForm = null;
ValidationFramework._userLanguage="auto";
/**
 * Validate a form.
 * NOTE: the form is Framework virture form, not the HTML Form. 
 * Html Form can be transform to Virture form by 
 *     FormFactory.getFormFromId(htmlFormId);
 * See the doc for more information.
 * @param form the virtual form.
 */
ValidationFramework.validateForm = function(fform) {
	ValidationFramework._currentForm = fform;
	var failFields = [];
	var id = fform.getId();
	var showError = fform.getShowError();
	var showType = fform.getShowType();

	var br = null;
	if (showError != "alert") {
		br = "<br />";
	} else {
		br = "\n";
	}
	var errorStrArray = [];
	var ret = false;
	var formObj = document.getElementById(id);
	var fields = fform.getFields();
	var rightnum = 0;
	for (var i = 0; i < fields.length; i++) {
		var retVal = ValidationFramework.validateField(fields[i]);
		var fo=formObj[fields[i].getName()];
		
		if (typeof (fo) !='undefined' && 
			fo != null &&
			typeof(fo.type) != "undefined") {
			//fo.style.cssText = "";//检验出错不要改变网页形式
		}

		if (retVal != "OK") {
			errorStrArray[errorStrArray.length] = retVal;
			//failFields[failFields.length] = formObj[fields[i].getName()];//检验出错不要改变网页形式
		} else {
			rightnum ++;
		}
	}

	if (rightnum == fields.length) {
		ret = true;
	}

	if (errorStrArray.length > 0) {
		if (showError == "alert") {
			if (showType == "first") {
				alert(errorStrArray[0]);
			} else {
				alert(errorStrArray.join(br));
			}
			
		} else {
			var errObj = document.getElementById(showError);
			if (showType == "first") {
				errObj.innerHTML = errorStrArray[0];
			} else {
				errObj.innerHTML = errorStrArray.join(br);
			}
			
		}
		
		if (typeof (failFields[0]) !='undefined' && 
			failFields[0] != null &&
			typeof(failFields[0].type) != "undefined") {
			failFields[0].focus();
		}

		for (var i = 0; i < failFields.length; i++) {

			var o = failFields[i];
			if ( typeof (o) !='undefined' && 
				 o != null && typeof(o.type) != "undefined") {
				o.style.cssText = ValidationFailCssStyle;
			}	
		}
	}

	return ret;
}

/**
 * Validation the field
 * @param filed the field you want to validate.
 */
ValidationFramework.validateField = function(field) {
	var depends = field.getDepends();
	var retStr = "OK";
	for (var i = 0; i < depends.length; i++) {
		if (!ValidationFramework.validateDepend(field, depends[i])) {
			retStr = ValidationFramework.getErrorString(field, depends[i]);
			return retStr; //Break;
		}
	}
	return retStr;
}

/**
 * Validate the field depend.
 * This function dispatch the various depends into ValidateMethodFactory.validateXXX
 */
ValidationFramework.validateDepend = function(field, depend) {
	if (depend.getName() == "required") {
		return ValidateMethodFactory.validateRequired(field, depend.getParams());
	} else if (depend.getName() == "integer") {
		return ValidateMethodFactory.validateInteger(field, depend.getParams());
	} else if (depend.getName() == "double") {
		return ValidateMethodFactory.validateDouble(field, depend.getParams());
	} else if (depend.getName() == "commonChar") {
		return ValidateMethodFactory.validateCommonChar(field, depend.getParams());
	} else if (depend.getName() == "chineseChar") {
		return ValidateMethodFactory.validateChineseChar(field, depend.getParams());
	} else if (depend.getName() == "minLength") {
		return ValidateMethodFactory.validateMinLength(field, depend.getParams());
	} else if (depend.getName() == "maxLength") {
		return ValidateMethodFactory.validateMaxLength(field, depend.getParams());
	} else if (depend.getName() == "email") {
		return ValidateMethodFactory.validateEmail(field, depend.getParams());
	} else if (depend.getName() == "date") {
		return ValidateMethodFactory.validateDate(field, depend.getParams());
	} else if (depend.getName() == "time") {
		return ValidateMethodFactory.validateTime(field, depend.getParams());
	} else if (depend.getName() == "mask") {
		return ValidateMethodFactory.validateMask(field, depend.getParams());
	} else if (depend.getName() == "integerRange") {
		return ValidateMethodFactory.validateIntegerRange(field, depend.getParams());
	} else if (depend.getName() == "doubleRange") {
		return ValidateMethodFactory.validateDoubleRange(field, depend.getParams());
	} else if (depend.getName() == "equalsField") {
		return ValidateMethodFactory.validateEqualsField(field, depend.getParams());
	} else if (depend.getName() == "common") {
		return ValidateMethodFactory.validateCommon(field, depend.getParams());
	}else if (depend.getName() == "decimal") {
		return ValidateMethodFactory.validateDecimal(field, depend.getParams());
	}else {
		ValidationFramework.exception("还未实现该依赖： " + depend.getName());
		return false;
	}
}


// hold the current config file
var _validationConfigFile = "";
ValidationFramework.getDocumentElement = function() {
	if (ValidationFramework._validationCache != null) {
		return ValidationFramework._validationCache;
	}

	var file = "";
	if (_validationConfigFile != "") {
		file = _validationConfigFile;
	} else {
		file = ValidationRoot + "validation-config.xml";
	}
/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
if (window.ActiveXObject) {


var http_request = false;
 function send_request() {
  http_request = false;
  if(window.XMLHttpRequest) { 
   http_request = new XMLHttpRequest();
   
  }
  else if (window.ActiveXObject) { 
   try {
    http_request = new ActiveXObject("Msxml2.XMLHTTP");
   } catch (e) {
    try {
     http_request = new ActiveXObject("Microsoft.XMLHTTP");
    } catch (e) {}
   }
  }
  
  http_request.onreadystatechange = processRequest;
  http_request.open("GET", file, false);
  http_request.send(null);
 }

var root;
var boot;
function processRequest() {
if (http_request.readyState == 4) { 
if (http_request.status == 200) { 
var returnObj = http_request.responseXML;
var xmlobj = http_request.responseXML;
root = xmlobj.documentElement; 
boot =returnObj.documentElement;
}
} 
}
    
send_request();
if (root== null) {
ValidationFramework._validationCache =boot;
}else{
ValidationFramework._validationCache = root;
}
}else{
   var xmlDoc = XmlDocument.create();
	xmlDoc.async = false; 
	xmlDoc.load(file);
	if (xmlDoc.documentElement == null) {
		ValidationFramework.exception("配置文件读取错误，请检查。");
		return null;
	}
	ValidationFramework._validationCache = xmlDoc.documentElement;
	
	}

/*
 * JavaScript Validation Framework
 *
 * Author: Michael Chen(mechiland) on 2004/03
 * This software is on the http://www.cosoft.org.cn/projects/jsvalidation
 * for update, bugfix, etc, you can goto the homepage and submit your request 
 * and question.
 * Apache License 2.0
 * You should use this software under the terms.
 *
 * Please, please keep above words. At least ,please make a note that such as 
 * "This software developed by Michael Chen(http://www.jzchen.net)" .
 * $Id: validation-framework.js,v 1.1 2008/05/24 07:10:31 nseer Exp $
 */	
	
	var lang=ValidationFramework._validationCache.getAttribute("lang");
	ValidationFramework._userLanguage = (lang==null) ? "auto" : lang;
	return ValidationFramework._validationCache;
}

ValidationFramework.init = function(configFile) {
	_validationConfigFile = configFile;
	ValidationFramework.getDocumentElement();
}

ValidationFramework.getAllForms = function() {
	var vforms = [];
	var root = ValidationFramework.getDocumentElement();
	if (root != null) {
		var fs = root.childNodes;
		for (var i = 0;i < fs.length ;i++ )	{
			vforms[i] = new ValidationForm(fs.item(i));
		}
	}
	return vforms;
}
ValidationFramework.getErrorString = function(field, depend) {
	var stringResource = null;
	var lang = ValidationFramework._userLanguage.toLowerCase();
	//if lang == auto, get the user's browser language.
	if (lang == "auto") {
		// different browser has the different method the get the 
		// user's language. so this is a stupid way to detect the 
		// most common browser IE and Mozilla.
		if (typeof navigator.userLanguage == 'undefined')
			lang = navigator.language.toLowerCase();
		else
			lang = navigator.userLanguage.toLowerCase();
	}
	// get the language
	if (typeof ValidationErrorString[lang] != 'object') {
		stringResource = ValidationErrorString['zh-cn'];
	} else {
		stringResource = ValidationErrorString[lang];
	}
	var dep = depend.getName().toLowerCase();
	var retStr = stringResource[dep];
	//If the specified depend not defined, use the default error string.
	if (typeof retStr != 'string') {
		retStr = stringResource["default"];
		retStr = retStr.replace("{0}", field.getDisplayName());
		return retStr;
	}
	retStr = retStr.replace("{0}", field.getDisplayName());
	if (dep == "minlength" || dep == "maxlength" || dep == "date" ) {
		retStr = retStr.replace("{1}", depend.getParams()[0]);
	} else if ( dep == "equalsfield") {
		var eqField = field.getForm().findField(depend.getParams()[0]);
		if (eqField == null) {
			ValidationFramework.exception("找不到名称为[" + depend.getParams()[0]+"]的域，请检查xml配置文件。");
			retStr = "<<配置错误>>";
		} else {
			retStr = retStr.replace("{1}", field.getForm().findField(depend.getParams()[0]).getDisplayName());
		}
	} else if (dep == "integerrange" || dep == "doublerange") {
		retStr = retStr.replace("{1}", depend.getParams()[0]);
		retStr = retStr.replace("{2}", depend.getParams()[1]);
	}

	return retStr;
}

ValidationFramework.getWebFormFieldObj = function(field) {
	var obj = null;
	if (ValidationFramework._currentForm != null) {
		var formObj = document.getElementById(ValidationFramework._currentForm.getId());
		obj = formObj[field.getName()];
		if (typeof(obj) == 'undefined') {
			obj = null;
		}
	}
	if (obj == null) {
	}
	return obj;
}

ValidationFramework.exception = function(str) {
	var ex = "JavaScript Validation Framework 运行时错误:\n\n";
	ex += str;
	ex += "\n\n\n任何运行错误都会导致该域验证失败。";
	alert(ex);
}
ValidationFramework.getIntegerValue = function(val) {
	var intvalue = parseInt(val);
	if (isNaN(intvalue)) {
		ValidationFramework.exception("期待一个整型参数。");
	}
	return intvalue;
}
ValidationFramework.getFloatValue = function(val) {
	var floatvalue = parseFloat(val);
	if (isNaN(floatvalue)) {
		ValidationFramework.exception("期待一个浮点型参数。");
	}
	return floatvalue;
}
/**
 * FormFactory
 * Build virture form from Html Form.
 */
function FormFactory() {}
FormFactory.getFormFromDOM = function(dom) {
	var form = new ValidationForm();
	form.setId(dom.getAttribute("id"));
	form.setShowError(dom.getAttribute("show-error"));
	form.setOnFail(dom.getAttribute("onfail"));
	form.setShowType(dom.getAttribute("show-type"));

	if (dom.hasChildNodes()) {
		var f = dom.childNodes;
		for (var i = 0; i < f.length; i++) {
			if (f.item(i) == null||typeof(f.item(i).tagName) == 'undefined' || f.item(i).tagName != 'field') {
				continue;
			}
			var field = FieldFactory.getFieldFromDOM(f.item(i));
			if (field != null) {
				form.addField(field);
			}
		}
	}
	return form;
}
/// Get the Form from ID
FormFactory.getFormFromId = function(id) {
	var root = ValidationFramework.getDocumentElement();
	if ( root == null || (!root.hasChildNodes()) ) return null;
	var vforms = root.childNodes;
	for (var i = 0; i < vforms.length; i++) {
		var f = vforms.item(i);
		if (typeof(f.tagName) != 'undefined' && f.tagName == 'form' && f.getAttribute("id") == id) {
			return FormFactory.getFormFromDOM(f);
		}
	}
	return null;
}

/**
 * A validation form object.
 */
function ValidationForm() {
	this._fields = [];
	this._id = null;
	this._showError = null;
	this._onFail = null;
	this._showType = null;

	this.getFields = function() { return this._fields; }
	this.setFields = function(p0) { this._fields = p0; }

	this.getId = function() { return this._id; }
	this.setId = function(p0) { this._id = p0; }

	this.getShowError = function() { return this._showError; }
	this.setShowError = function(p0) { this._showError = p0; }

	this.getShowType = function() { return this._showType; }
	this.setShowType = function(p0) { this._showType = p0; }

	this.getOnFail = function() { return this._onFail; }
	this.setOnFail = function(p0) { this._onFail = p0; }
	
	// find field by it's name
	this.findField = function(p0) {
		for (var i = 0; i < this._fields.length; i++) {
			if (this._fields[i].getName() == p0) {
				return this._fields[i];
			}
		}
		return null;
	}
	
	this.addField = function(p0) {
		this._fields[this._fields.length] = p0;
		p0.setForm(this);
	}
}

/**
 * A form filed. virtual.
 */
function ValidationField() {
	this._name = null;
	this._depends = [];
	this._displayName = null;
	this._onFail = null;
	this._form = null;

	this.getName = function() { return this._name; }
	this.setName = function(p0) { this._name = p0; }

	this.getDepends = function() { return this._depends; }
	this.setDepends = function(p0) { this._depends = p0; }

	this.getDisplayName = function() { return this._displayName; }
	this.setDisplayName = function(p0) { this._displayName = p0; }

	this.getOnFail = function() { return this._onFail; }
	this.setOnFail = function(p0) { this._onFail = p0; }
	
	this.getForm = function() { return this._form; }
	this.setForm = function(p0) { this._form = p0; }

	this.addDepend = function(p0) {
		this._depends[this._depends.length] = p0;
	}
}

///Factory methods for create Field
function FieldFactory() {}
FieldFactory.getFieldFromDOM = function(dom) {
	var field = new ValidationField();
	field.setName(dom.getAttribute("name"));
	field.setDisplayName(dom.getAttribute("display-name"));
	field.setOnFail(dom.getAttribute("onfail"));
	if (dom.hasChildNodes()) {
		var depends = dom.childNodes;
		for (var i = 0; i < depends.length; i++) {
			var item = depends.item(i);
			if (typeof(item.tagName) == 'undefined' || item.tagName != 'depend') {
				continue;
			}
			var dp = new ValidationDepend();
			dp.setName(item.getAttribute("name"));
			dp.addParam(item.getAttribute("param0"));
			dp.addParam(item.getAttribute("param1"));
			dp.addParam(item.getAttribute("param2"));
			dp.addParam(item.getAttribute("param3"));
			dp.addParam(item.getAttribute("param4"));
			field.addDepend(dp);
		}
	}
	return field;
}


function FormFieldUtils() {}

FormFieldUtils.findField = function(formName, fieldName) {
	
	var formArr = ValidationFramework.getAllForms();
	var theForm = null;
	for (var i = 0; i < formArr.length; i++) {
		if (formArr[i].getName() == formName) {
			theForm = formArr[i];
		}
	}

	if (theForm != null) {
		return theForm.findField(fieldName);
	} else {
		return null;
	}
}

/**
 * A validaton depend.
 */
function ValidationDepend() {
	this._name = null;
	this._params = [];

	this.getName = function() { return this._name; }
	this.setName = function(p0) { this._name = p0; }

	this.getParams = function() { return this._params; }
	this.setParams = function(p0) { this.params = p0; }

	this.addParam = function(p0) {
		this._params[this._params.length] = p0;
	}
}

function ValidateMethodFactory() {}
ValidateMethodFactory._methods = [];
ValidateMethodFactory.validateRequired = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);	
	if (obj == null) return true;
	if (typeof(obj.type) == "undefined") {
		var tmp = 0;
		for (var i = 0; i < obj.length; i++) {
			if (obj[i].checked) {
				return true;
			}
		}
		return false;
	}

	if (obj.type == "checkbox" || obj.type == "radio") {
		return (obj.checked);
	} else {
		return !(obj.value == "");
	}
}

ValidateMethodFactory.validateInteger = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	if (obj.value == "") return true;
	var exp = new RegExp("^-?\\d+$");
	return exp.test(obj.value);
}

ValidateMethodFactory.validateDouble = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	if (obj.value == "") return true;
        var str = new String(obj.value);
        if (str.indexOf(".")==-1) return false;
	var exp = new RegExp("^-?\\d+\.\\d+$");
	return exp.test(obj.value);
}
ValidateMethodFactory.validateDecimal = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	if (obj.value == "") return true;
	var exp = new RegExp("^[0-9,.+-]*$");
	return exp.test(obj.value);
}
ValidateMethodFactory.validateCommon = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	if (obj.value == "") return true;
	var exp1 = new RegExp("^[\u4E00-\u9FA5\uF900-\uFA2D\u0020\u000D]*$");
	var j=0;
	var n=0;
	for (var i = 0; i < obj.value.length; i++) {
		if(!exp1.test(obj.value.charAt(i))){
			j++;
			if(j>30) n++;
		}else{
			j=0;
		}
	}
	if(n!=0) return false;
	return obj.value;
}
ValidateMethodFactory.validateCommonChar = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	if (obj.value == "") return true;
	var exp = new RegExp("^[A-Za-z0-9_]*$");
	return exp.test(obj.value);
}
ValidateMethodFactory.validateChineseChar = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	if (obj.value == "") return true;
	var exp = new RegExp("^[\u4E00-\u9FA5\uF900-\uFA2D]*$");
	return exp.test(obj.value);
}
ValidateMethodFactory.validateMinLength = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	var v = ValidationFramework.getIntegerValue(params[0]);
	return (obj.value.length >= v);
}
ValidateMethodFactory.validateMaxLength = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	var v = ValidationFramework.getIntegerValue(params[0]);
	return (obj.value.length <= v);
}
ValidateMethodFactory.validateEmail = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	return ValidateMethodFactory.__checkEmail(obj.value);
}
ValidateMethodFactory.validateDate = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	if (obj.value == "") return true;
	
	var value = obj.value;
	var datePattern = params[0];
	var MONTH = "mm";
	var DAY = "dd";
	var YEAR = "yyyy";
	var orderMonth = datePattern.indexOf(MONTH);
    var orderDay = datePattern.indexOf(DAY);
    var orderYear = datePattern.indexOf(YEAR);
	var bValid = true;
	var dateRegexp = null;

	if ((orderDay < orderYear && orderDay > orderMonth)) {
		var iDelim1 = orderMonth + MONTH.length;
        var iDelim2 = orderDay + DAY.length;
        var delim1 = datePattern.substring(iDelim1, iDelim1 + 1);
        var delim2 = datePattern.substring(iDelim2, iDelim2 + 1);
        if (iDelim1 == orderDay && iDelim2 == orderYear) {
			dateRegexp = new RegExp("^(\\d{1,2})(\\d{1,2})(\\d{4})$");
        } else if (iDelim1 == orderDay) {
			dateRegexp = new RegExp("^(\\d{1,2})(\\d{1,2})[" + delim2 + "](\\d{4})$");
        } else if (iDelim2 == orderYear) {
			dateRegexp = new RegExp("^(\\d{1,2})[" + delim1 + "](\\d{1,2})(\\d{4})$");
        } else {
			dateRegexp = new RegExp("^(\\d{1,2})[" + delim1 + "](\\d{1,2})[" + delim2 + "](\\d{4})$");
        }

        var matched = dateRegexp.exec(value);
        if(matched != null) {
			if (!ValidateMethodFactory.__isValidDate(matched[2], matched[1], matched[3])) {
                bValid =  false;
			}
        } else {
            bValid =  false;
        }
    } else if ((orderMonth < orderYear && orderMonth > orderDay)) { 
		var iDelim1 = orderDay + DAY.length;
        var iDelim2 = orderMonth + MONTH.length;
        var delim1 = datePattern.substring(iDelim1, iDelim1 + 1);
        var delim2 = datePattern.substring(iDelim2, iDelim2 + 1);
        if (iDelim1 == orderMonth && iDelim2 == orderYear) {
			dateRegexp = new RegExp("^(\\d{1,2})(\\d{1,2})(\\d{4})$");
        } else if (iDelim1 == orderMonth) {
			dateRegexp = new RegExp("^(\\d{1,2})(\\d{1,2})[" + delim2 + "](\\d{4})$");
        } else if (iDelim2 == orderYear) {
			dateRegexp = new RegExp("^(\\d{1,2})[" + delim1 + "](\\d{1,2})(\\d{4})$");
        } else {
			dateRegexp = new RegExp("^(\\d{1,2})[" + delim1 + "](\\d{1,2})[" + delim2 + "](\\d{4})$");
        }
        var matched = dateRegexp.exec(value);
		if(matched != null) {
			if (!ValidateMethodFactory.__isValidDate(matched[1], matched[2], matched[3])) {
				bValid = false;
            }
        } else {
			bValid = false;
        }
    } else if ((orderMonth > orderYear && orderMonth < orderDay)) {
		var iDelim1 = orderYear + YEAR.length;
        var iDelim2 = orderMonth + MONTH.length;
        var delim1 = datePattern.substring(iDelim1, iDelim1 + 1);

        var delim2 = datePattern.substring(iDelim2, iDelim2 + 1);
        if (iDelim1 == orderMonth && iDelim2 == orderDay) {
			dateRegexp = new RegExp("^(\\d{4})(\\d{1,2})(\\d{1,2})$");
        } else if (iDelim1 == orderMonth) {
			dateRegexp = new RegExp("^(\\d{4})(\\d{1,2})[" + delim2 + "](\\d{1,2})$");
        } else if (iDelim2 == orderDay) {
			dateRegexp = new RegExp("^(\\d{4})[" + delim1 + "](\\d{1,2})(\\d{1,2})$");
        } else {
			dateRegexp = new RegExp("^(\\d{4})[" + delim1 + "](\\d{1,2})[" + delim2 + "](\\d{1,2})$");
        }
		var matched = dateRegexp.exec(value);
        if(matched != null) {
			if (!ValidateMethodFactory.__isValidDate(matched[3], matched[2], matched[1])) {
                bValid =  false;
            }
        } else {
            bValid =  false;
        }
    } else {
        bValid =  false;
    }
	return bValid;
}
ValidateMethodFactory.validateTime = function(field, params) {
	////NOT IMPLEMENT YET SINCE IT'S NOT USEFUL.
	return true;
}
ValidateMethodFactory.validateMask = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return false;
	if (obj.value == "") return true;
	var exp = new RegExp(params[0]);
	//FIXME: this method may be buggy, need more test.
	return exp.test(obj.value);
}
ValidateMethodFactory.validateIntegerRange = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return false;
	if (obj.value == "") return true;
	var p0 = ValidationFramework.getIntegerValue(params[0]);
	var p1 = ValidationFramework.getIntegerValue(params[1]);
	if (ValidateMethodFactory.validateInteger(field)) {
		var v = parseInt(obj.value);
		return (v >= p0 && v <= p1);
	} else {
		return false;
	}
	return true;
}
ValidateMethodFactory.validateDoubleRange = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return false;
	if (obj.value == "") return true;
	var p0 = ValidationFramework.getFloatValue(params[0]);
	var p1 = ValidationFramework.getFloatValue(params[1]);
	if (ValidateMethodFactory.validateInteger(field) || ValidateMethodFactory.validateDouble(field)) {
		var v = parseFloat(obj.value);
		return (v >= p0 && v <= p1);
	} else {
		return false;
	}
	return true;
}
ValidateMethodFactory.validateEqualsField = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return false;
	var formObj = document.getElementById(ValidationFramework._currentForm.getId());
	var eqField = formObj[params[0]];
	if (eqField != null) {
		return (obj.value == eqField.value)
	} else {
		return false;	
	}
}

ValidateMethodFactory.__isValidDate = function(day, month, year) {
	if (month < 1 || month > 12) return false;
	if (day < 1 || day > 31) return false;
	if ((month == 4 || month == 6 || month == 9 || month == 11) &&(day == 31)) 
		return false;
    
	if (month == 2) {
		var leap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		if (day>29 || (day == 29 && !leap)) return false;
    }
    
	return true;
}

/**
 * Reference: Sandeep V. Tamhankar (stamhankar@hotmail.com),
 * http://javascript.internet.com
 */
ValidateMethodFactory.__checkEmail = function(emailStr) {                                                  
   if (emailStr.length == 0) {                                                              
       return true;                                                                          
   }                                                                                         
   var emailPat=/^(.+)@(.+)$/;                                                               
   var specialChars="\\(\\)<>@,;:\\\\\\\"\\.\\[\\]";                                         
   var validChars="\[^\\s" + specialChars + "\]";                                            
   var quotedUser="(\"[^\"]*\")";                                                            
   var ipDomainPat=/^(\d{1,3})[.](\d{1,3})[.](\d{1,3})[.](\d{1,3})$/;                        
   var atom=validChars + '+';                                                                
   var word="(" + atom + "|" + quotedUser + ")";                                             
   var userPat=new RegExp("^" + word + "(\\." + word + ")*$");                               
   var domainPat=new RegExp("^" + atom + "(\\." + atom + ")*$");                             
   var matchArray=emailStr.match(emailPat);                                                  
   if (matchArray == null) {                                                                 
       return false;                                                                         
   }                                                                                         
   var user=matchArray[1];                                                                   
   var domain=matchArray[2];                                                                 
   if (user.match(userPat) == null) {                                                        
       return false;                                                                         
   }                                                                                         
   var IPArray = domain.match(ipDomainPat);                                                  
   if (IPArray != null) {                                                                    
       for (var i = 1; i <= 4; i++) {                                                        
          if (IPArray[i] > 255) {                                                            
             return false;                                                                   
          }                                                                                  
       }                                                                                     
       return true;                                                                          
   }                                                                                         
   var domainArray=domain.match(domainPat);                                                  
   if (domainArray == null) {                                                                
       return false;                                                                         
   }                                                                                         
   var atomPat=new RegExp(atom,"g");                                                         
   var domArr=domain.match(atomPat);                                                         
   var len=domArr.length;                                                                    
   if ((domArr[domArr.length-1].length < 2) ||                                               
       (domArr[domArr.length-1].length > 3)) {                                               
       return false;                                                                         
   }                                                                                         
   if (len < 2) {                                                                            
       return false;                                                                         
   }                                                                                         
   return true;                                                                              
}                                                                                            

////Language Definitions
var ValidationErrorString = new Object();
////Simplified Chinese(zh-ch)
ValidationErrorString["zh-cn"] = new Object();
ValidationErrorString["zh-cn"]["default"]="域{0}校验失败。";
ValidationErrorString["zh-cn"]["required"]="{0}不能为空。";
ValidationErrorString["zh-cn"]["integer"]="{0}必须是一个整数。";
ValidationErrorString["zh-cn"]["double"]="{0}必须是一个浮点数（带小数点）。";
ValidationErrorString["zh-cn"]["commonchar"] = "{0}必须是普通英文字符：字母，数字和下划线。";
ValidationErrorString["zh-cn"]["chinesechar"] = "{0}必须是中文字符。";
ValidationErrorString["zh-cn"]["minlength"]="{0}长度不能小于{1}个字符。";
ValidationErrorString["zh-cn"]["maxlength"]="{0}长度不能大于{1}个字符。" ;
ValidationErrorString["zh-cn"]["invalid"]="{0}无效。";                                                             
ValidationErrorString["zh-cn"]["date"]="{0}不是一个有效日期，期待格式：{1}。";
ValidationErrorString["zh-cn"]["integerrange"]="{0}必须在整数{1}和{2}之间。";
ValidationErrorString["zh-cn"]["doublerange"]="{0}必须在浮点数{1}和{2}之间。";
ValidationErrorString["zh-cn"]["pid"]="{0}不是一个有效身份证号。";
ValidationErrorString["zh-cn"]["email"]="{0}不是一个有效的Email。";
ValidationErrorString["zh-cn"]["equalsfield"]="{0}必须和{1}一致。";
ValidationErrorString["zh-cn"]["decimal"]="{0}必须为数字。";
ValidationErrorString["zh-cn"]["common"]="{0}含有非法字符或字符串超长（汉字除外），请用空格间隔。";

////English(en-us)


// preload the validation file.
//ValidationFramework.getDocumentElement();