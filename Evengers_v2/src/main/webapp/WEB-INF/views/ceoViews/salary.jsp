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
#msg{
	color : red;
}
#salary{
	/* table-layout :auto; */
	width: 40%;
	font-size: 13px;
	font-family: 'Nanum Gothic', sans-serif;
}
</style>
</head>
<body>
	<div id="msg">${msg}</div>
	<div id="salary">${makeHtml_salary}</div>
	${makeHtml_input}
</body>
</html>