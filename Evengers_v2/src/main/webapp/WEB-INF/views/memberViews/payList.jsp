<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style>
.payList{
	border: 1px solid black;
	display: block;
	width: 70%; height: 350px;
	overflow: auto; margin: auto;
}
</style>
</head>
<body>
${makeHtml_memberPayList}
</body>
</html>