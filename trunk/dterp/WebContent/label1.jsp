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
<table border="1">
	<tr>
		<td>
		<h1>code39</h1>
		<img
			src="<%=request.getContextPath()%>/barcode?msg=0123456789&type=code39"
			height="50px" width=200px /></td>
		<td>
		<h1>code128</h1>
		<img
			src="<%=request.getContextPath()%>/barcode?msg=0123456789&type=code128"
			height="100px" width=300px /></td>
		<td>
		<h1>Codabar</h1>
		<img
			src="<%=request.getContextPath()%>/barcode?msg=0123456789&type=codabar"
			height="100px" width=300px /></td>
	</tr>
	<tr>
		<td>
		<h1>intl2of5</h1>
		<img
			src="<%=request.getContextPath()%>/barcode?msg=01234567890540&type=intl2of5"
			height="100px" width=300px /></td>
		<td>
		<h1>upc-a</h1>
		<img
			src="<%=request.getContextPath()%>/barcode?msg=012345678912&type=upc-a"
			height="100px" width=300px /></td>
		<td>
		<h1>ean-13</h1>
		<img
			src="<%=request.getContextPath()%>/barcode?msg=200123457893&type=ean-13"
			height="100px" width=300px /></td>
		<td>
		<h1>ean-8</h1>
		<img
			src="<%=request.getContextPath()%>/barcode?msg=20123451&type=ean-8"
			height="100px" width=300px /></td>
	</tr>
	<tr>
		<td>
		<h1>postnet</h1>
		<img
			src="<%=request.getContextPath()%>/barcode?msg=01234567890540&type=postnet"
			height="100px" width=300px /></td>
		<td>
		<h1>royal-mail-cbc</h1>
		<img
			src="<%=request.getContextPath()%>/barcode?msg=012345AS678912&type=royal-mail-cbc"
			height="100px" width=300px /></td>
		<td>
		<h1>pdf417</h1>
		<img
			src="<%=request.getContextPath()%>/barcode?msg=200123457893&type=pdf417"
			height="100px" width=300px /></td>
		<td>
		<h1>datamatrix</h1>
		<img
			src="<%=request.getContextPath()%>/barcode?msg=20123451&type=datamatrix"
			height="100px" width=300px /></td>
			
			
			
	</tr>
</table>

</body>
</html>