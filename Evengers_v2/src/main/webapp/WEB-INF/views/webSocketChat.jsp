<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
</body>
<script>
var url="ws://localhost/evengers_v2/webSocketChat?ceo_id=ceo"
var webSocket = new WebSocket(url);
var content = document.getElementById("monitor");
webSocket.onopen=function(e){
	console.log(e);
	content.value+="웹소켓 연결...\n";
}
webSocket.onclose=function(e){
	console.log(e);
	content.value+="웹소켓 끊김...\n";
}
webSocket.onmessage=function(e){
	console.log(e);
	content.value+=e.data+"\n";
}
function sendMsg(){
	var obj={};
	obj.nick=$("#nick").val();
	obj.msg=$("#msg").val();
	content.value+="나> "+obj.msg+"\n";
	webSocket.send(JSON.stringify(obj));
	$("#msg").val("");
}
function disConn(){
	webSocket.close();
}
</script>
</html>