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
<title>ceoChat</title>
</head>
<body>
<h1>판매자 페이지</h1>
<form>
	구매자ID:${receiver}<br/>
	대화내용:<textarea id="monitor" rows="20"></textarea><br/>
	보낼메세지:<input id="msg" type="text"/><br/>
	<input type="button" value="전송" onclick="sendMsg()"/>
	<input type="button" value="접속끊기" onclick="disConn()"/>
</form>
</body>
<script>
var sock = new SockJS("webSocket")
var content = document.getElementById("monitor");
sock.onopen=function(){
	console.log("info : connection opened.");
	content.value+="웹소켓 연결...상담대기중\n";
}
var receiver="";
sock.onmessage=function(event){
	var box=JSON.parse(event.data);
	receiver=box.sender;
	content.value+=box.msg+"\n";
}
sock.onclose=function(event){
	console.log("info : connection closed.");
	content.value+="웹소켓 끊김...\n";
}
sock.onerror=function(error){
	console.log("error : ",error);
}
console.log("receiver",receiver);
console.log("nick","${c_name}");
function sendMsg(){
	var obj={};
	obj.nick="${c_name}";
	obj.receiver=receiver;
	obj.msg=$("#msg").val();
	content.value+="나> "+obj.msg+"\n";
	sock.send(JSON.stringify(obj));
	$("#msg").val("");
}
function disConn(){
	sock.close();
}
</script>
</html>
