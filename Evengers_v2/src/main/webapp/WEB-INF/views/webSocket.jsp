<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta charset="UTF-8">
<title>WebSocket</title>
</head>
<body>
<h1>WebSocket</h1>
<form>
	대화명:<input id="nick" type="text"/><br/>
	대화내용:<textarea id="monitor" rows="20"></textarea><br/>
	보낼메세지:<input id="msg" type="text"/><br/>
	<input type="button" value="전송" onclick="sendMsg()"/>
	<input type="button" value="접속끊기" onclick="disConn()"/>
</form>
</body>
<script>
//URL 접속하기
var url="ws://localhost/evengers_v2/webSocket"
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