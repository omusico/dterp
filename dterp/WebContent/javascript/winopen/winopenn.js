
var vheight = window.screen.height-400
var vwidth =  window.screen.width-700
function winopen(file){	
	file=encodeURI(file);
window.open(file,"","height="+vheight+",width="+vwidth+",top =0,left=0,toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=yes");
}