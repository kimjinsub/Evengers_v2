<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/sockjs.min.js"></script>
<meta charset="UTF-8">
<style>
</style>
<title>waiting Room</title>
</head>
<body>
<h1>판매자 대기실 페이지</h1>
<h2>신청자ID명단</h2>
<table border="1" id="waitingRoom">
	<tr><th>MEMBER ID</th></tr>
</table>
<button onclick='disConn()'>상담종료</button>
</body>
<script>
var sock = new SockJS("webSocket")
var content = document.getElementById("monitor");
sock.onopen=function(){
	console.log("info : connection opened.");
}
var receiver="";
var hasNewReq="";
sock.onmessage=function(event){
	console.log("info : onmessage run.");
	var box=JSON.parse(event.data);
	console.log("box.",box);
	receiver=box.sender;
	hasNewReq=box.hasNewReq;
	if(hasNewReq=="yes"){
		getWaitingRoom();
	}
}
sock.onclose=function(event){
	console.log("info : connection closed.");
}
sock.onerror=function(error){
	console.log("error : ",error);
}
function disConn(){
	sock.close();
}
function getWaitingRoom(){
	$.ajax({
		url:"getWaitingRoom",
		dataType:"text",
		success:function(result){
			console.log("getWR Result:",result);
			$("#waitingRoom").html(result);
		},
		error:function(error){
			console.log(error);
		}
	})
}
function openChatWindow(m_id){
	console.log("OCW m_id:",m_id);
	window.open("chat?receiver="+m_id,"_blank","width=400,height=700;");
}
</script>
</html>
