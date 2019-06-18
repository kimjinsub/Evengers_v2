<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/all.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"/></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#chatWindow{
	display: none;
	position: fixed; bottom: 30%; right: 10%;
	border: 1px solid black;
	width: 30%; height: 50%; background-color: white;
}
#chatWindow.show{display:block;}
</style>
</head>
<body>
<jsp:include page="header.jsp"/>
<div id="chatWindow"></div>
</body>
<script>
Ajax_chat();
function Ajax_chat(){
	console.log("실행중...");
	$.ajax({
		url:"chat",
		dataType:"html",
		success:function(page){
			$("#chatWindow").html(page);
			$("#chatWindow").addClass("show");
		},
		error:function(error){
			console.log("ceoChatError:",error);
		}
	})
}
function closeChat(){
	$("#chatWindow").removeClass("show");
	$("#chatWindow").html("");
}
</script>
</html>