<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#perform{
	margin-top: 4%;
	width: 100%;
	font-size: 15px;
}
#h2{
	margin-top: 2%;
	font-family: 'Nanum Gothic', sans-serif;
}
</style>
</head>
<body>
	<h2 id="h2" align="center">사원목록</h2>
	<div id="perform">${makeHtml_getPerformList}</div>
</body>
<script>
	
</script>
</html>