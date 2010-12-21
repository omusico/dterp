<%@ page language="java" contentType="text/html; charset=windows-31j"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-31j">
<title>Insert title here</title>
</head>
<body>
<table><tr><td> <input type="button" value="打印" onclick="javascript:window.print()" /> </td></tr></table>

<table style="text-align: center" align="center" width="80%">
	<tr><td>
		<img
			src="<%=request.getContextPath()%>/barcode?msg=0123456789&type=code39"
			height="50px" width=200px />
	</td></tr>
	
	<tr><td>
	<img
			src="<%=request.getContextPath()%>/barcode?msg=0123456789&type=code128"
			height="50px" width=200px />
	</td></tr>
	
	<tr><td>
	<img
			src="<%=request.getContextPath()%>/barcode?msg=0123456789&type=codabar"
			height="50px" width=200px />
	</td></tr>
	
	<tr><td>
		<img
			src="<%=request.getContextPath()%>/barcode?msg=01234567890540&type=intl2of5"
			height="50px" width=200px />
	</td></tr>
</table>

</body>
</html>