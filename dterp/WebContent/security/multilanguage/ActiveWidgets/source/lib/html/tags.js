/*****************************************************************

	ActiveWidgets Grid 1.0.2 (GPL).
	Copyright (C) 2003-2005 ActiveWidgets Ltd. All Rights Reserved. 
	http://www.activewidgets.com/

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

*****************************************************************/

Active.HTML.define = function(name, tag, type){
	if (!tag) {tag = name.toLowerCase()}
	Active.HTML[name] = Active.System.HTML.subclass();
	Active.HTML[name].create = function(){};
	Active.HTML[name].prototype.setTag(tag);
};

//	------------------------------------------------------------

Active.HTML.define("DIV");
Active.HTML.define("SPAN");
Active.HTML.define("IMG");
Active.HTML.define("INPUT");
Active.HTML.define("BUTTON");
Active.HTML.define("TEXTAREA");
Active.HTML.define("TABLE");
Active.HTML.define("TR");
Active.HTML.define("TD");
