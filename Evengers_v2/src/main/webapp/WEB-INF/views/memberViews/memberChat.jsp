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
input[type=text],textarea{
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  font-family: "Nanum Gothic", sans-serif; font-size: 15px;
}
h1{
	font-family: "Nanum Gothic", sans-serif; font-size: 18px;
	text-align: center;
}
h2{
	font-family: "Nanum Gothic", sans-serif; font-size: 18px;
}
input[type=button]{
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 15px 15px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  font-family: "Nanum Gothic", sans-serif;
}
#connected{display:none;}
#connected.show{display:inline;}
</style>
<title>구매자 상담페이지</title>
</head>
<body>
<h1>${sender}님의 1:1상담 페이지</h1>
<hr>
<h2>Evenger's ID:${receiver}</h2>
<textarea id="monitor" rows="20" disabled="disabled"></textarea><br/>
<input id="msg" type="text" placeholder="메세지를 입력하세요"/><br/>
<div id="connected">
	<input type="button" value="전송" onclick="sendMsg()"/>
</div>
<input type="button" value="접속끊기" onclick="memberDisConnMsg()"/>
</body>
<script>
var sock = new SockJS("webSocket")
var content = document.getElementById("monitor");
var doubleChat="";
sock.onopen=function(){
	console.log("info : connection opened.");
	content.value+=("${receiver}님과의 채팅입니다(＊,.☆)\n");
	connMsg();
}
sock.onmessage=function(event){
	var box=JSON.parse(event.data);
	if(box.doubleChat=="y"){
		alert("진행중인 상담이 있습니다. 이전 상담을 종료해주세요.")
		content.value+=(box.connFailMsg+"\n");
		doubleChat="y";
	}else{
	}
	if(box.connMsg!=null){
		if(!$("#connected").hasClass("show")){
			$("#connected").addClass("show");
		}
		content.value+=(box.connMsg+"\n");	
	}
	if(box.connMsgFail1!=null){
		content.value+=(box.connMsgFail1+"\n");	
	}
	if(box.connMsgFail2!=null){
		content.value+=(box.connMsgFail2+"\n");	
	}
	if(box.msg!=null){
		if(box.receiver=="${sender}"){
			if(!$("#connected").hasClass("show")){
				$("#connected").addClass("show");
			}
			content.value+=box.msg+"\n";
		}
	}
	if(box.memberDisConnMsg!=null){
		if(box.receiver=="${sender}"){
			if($("#connected").hasClass("show")){
				$("#connected").removeClass("show");
			}
			content.value+=box.memberDisConnMsg+"\n";
			//disConn();
		}
	}
	if(box.ceoDisConnMsg!=null){
		if(box.receiver=="${sender}"){
			if($("#connected").hasClass("show")){
				$("#connected").removeClass("show");
			}
			content.value+=box.ceoDisConnMsg+"\n";
			//disConn();
		}
	}
	if(box.finishChat!=null){
		if(box.receiver=="${sender}"){
			if($("#connected").hasClass("show")){
				$("#connected").removeClass("show");
			}
			content.value+=box.finishChat+"\n";
			//disConn();
		}
	}
}
sock.onclose=function(event){
	console.log("info : connection closed.");
	content.value+="채팅 종료...\n";
}
sock.onerror=function(error){
	console.log("error : ",error);
}
function connMsg(){
	var obj={};
	obj.sender="${sender}";
	obj.receiver="${receiver}";
	obj.connMsg="${sender}"+"님과의 상담입니다."
	sock.send(JSON.stringify(obj));
}
function sendMsg(){
	var obj={};
	obj.sender="${m_id}";
	obj.receiver="${receiver}";
	obj.msg=$("#msg").val();
	content.value+="나> "+obj.msg+"\n";
	sock.send(JSON.stringify(obj));
	$("#msg").val("");
}
function memberDisConnMsg(){
	var obj={};
	obj.sender="${sender}";
	obj.receiver="${receiver}";
	obj.memberDisConnMsg="${sender}"+"님이 퇴장했습니다(*n*)"
	sock.send(JSON.stringify(obj));
}
/* function disConn(){
	sock.close();
} */
</script>
</html>
