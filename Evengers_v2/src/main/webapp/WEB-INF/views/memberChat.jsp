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
#connected{display:none;}
#connected.show{display:inline;}
</style>
<title>memberChat</title>
</head>
<body>
<h1>소비자 페이지</h1>
<form>
	판매자ID:${receiver}<br/>
	대화내용:<textarea id="monitor" rows="20"></textarea><br/>
	보낼메세지:<input id="msg" type="text"/><br/>
	<div id="connected">
		<input type="button" value="전송" onclick="sendMsg()"/>
		<input type="button" value="접속끊기" onclick="disConn()"/>
	</div>
</form>
</body>
<script>
var sock = new SockJS("webSocket")
var content = document.getElementById("monitor");
sock.onopen=function(){
	console.log("info : connection opened.");
	content.value+="상대방을 기다리고 있습니다...\n";
	connMsg();
}
sock.onmessage=function(event){
	var box=JSON.parse(event.data);
	if(box.sender=="${receiver}"){
		if(box.sysMsg!=null){
			$("#connected").addClass("show");
			content.value+=box.sysMsg+"\n";
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
console.log("nick","${m_id}");
function sendMsg(){
	var obj={};
	obj.nick="${m_id}";
	obj.receiver="${receiver}";
	obj.msg=$("#msg").val();
	content.value+="나> "+obj.msg+"\n";
	sock.send(JSON.stringify(obj));
	$("#msg").val("");
	obj=null;
}
function connMsg(){
	var obj={};
	obj.nick="${m_id}";
	obj.receiver="${receiver}";
	obj.connMsg="${m_id}"+"님이 입장했습니다"
	sock.send(JSON.stringify(obj));
	obj=null;
}
function disConnMsg(){
	var obj={};
	obj.nick="${m_id}";
	obj.receiver="${receiver}";
	obj.disConn="yes";
	obj.disConnMsg="${m_id}"+"님이 퇴장했습니다"
	sock.send(JSON.stringify(obj));
	obj=null;
}
function disConn(){
	disConnMsg();
	sock.close();
}
</script>
</html>
