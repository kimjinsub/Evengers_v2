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
	content.value+="${receiver}"+"님과의 상담입니다.\n";
	matchingMsg();
}
sock.onmessage=function(event){
	var box=JSON.parse(event.data);
	if(box.sender=="${receiver}"){
		console.log("???outside");
		console.log("box.sender:",box.sender);
		console.log("sender:","${sender}");
		if(box.disConnMsg!=null){
			content.value+=box.disConnMsg+"\n";
			return;
		}
		if(box.connMsg!=null){
			content.value+=box.connMsg+"\n";
			return;
		}
		content.value+=box.msg+"\n";
	}
}
sock.onclose=function(event){
	console.log("info : connection closed.");
	content.value+="웹소켓 끊김...\n";
}
sock.onerror=function(error){
	console.log("error : ",error);
}
console.log("receiver","${receiver}");
console.log("nick","${c_id}");
function sendMsg(){
	var obj={};
	obj.nick="${c_id}";
	obj.receiver="${receiver}";
	obj.msg=$("#msg").val();
	content.value+="나> "+obj.msg+"\n";
	sock.send(JSON.stringify(obj));
	$("#msg").val("");
	obj=null;
}
function matchingMsg(){
	var obj={};
	obj.nick="${c_id}";
	obj.receiver="${receiver}";
	obj.matching="yes";
	obj.sysMsg="${c_id}"+"님이입장하셨습니다.";
	sock.send(JSON.stringify(obj));
	obj=null;
}
function disConn(){
	sock.close();
}
</script>
</html>
