<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
var url="ws://localhost/evengers_v2/webSocket?ceo_id=ceo"
var webSocket = new WebSocket(url);
var content = document.getElementById("monitor");
webSocket.onopen=function(){
	console.log("info : connection opened.");
	content.value+="웹소켓 연결...\n";
}
webSocket.onmessage=function(event){
	console.log(event.data+'\n');
	content.value+=event.data+"\n";
}
webSocket.onclose=function(event){
	console.log("info : connection closed.");
	content.value+="웹소켓 끊김...\n";
	//setTimeout(function(){connect();}, 1000);//retry connection!!
}
webSocket.onerror=function(error){
	console.log("error : ",error);
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