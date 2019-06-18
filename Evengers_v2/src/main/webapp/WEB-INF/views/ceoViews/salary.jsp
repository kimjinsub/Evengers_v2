<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#msg{
	color : red;
}
</style>
</head>
<body>
	<div id="msg">${msg}</div>
	${makeHtml_salary}
	${makeHtml_input}
</body>
</html>