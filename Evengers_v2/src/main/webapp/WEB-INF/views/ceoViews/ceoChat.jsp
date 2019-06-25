<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/sockjs.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
<meta charset="UTF-8">
<style>
#connected{display:none;}
#connected.show{display:inline;}
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
</style>
<title>판매자 상담페이지</title>
</head>
<body>
<h1>${sender}님의 1:1상담 페이지</h1>
<hr>
<h2>상담요청자 ID:<span></span></h2>
<textarea id="monitor" rows="20" disabled="disabled"></textarea><br/>
<input id="msg" type="text" placeholder="메세지를 입력하세요"
	onkeypress="enterKey()"/><br/>
<div id="connected">
	<input type="button" value="전송" onclick="sendMsg()"/>
	<input type="button" value="현재상담종료" onclick="ceoDisConnMsg()"/>
</div>
<input type="button" value="상담  끝내기" onclick="finishChat()"/>
</body>
<script>
function enterKey(){
	if(window.event.keyCode==13){
		sendMsg();
	}
}
var sock = new SockJS("webSocket")
var content = document.getElementById("monitor");
var receiver="";
sock.onopen=function(){
	console.log("info : connection opened.");
	//content.value+="상담접속에 성공하였습니다\n";	
}
sock.onmessage=function(event){
	var box=JSON.parse(event.data);
	if(box.doubleChat=="y"){
		alert("진행중인 상담이 있습니다. 이전 상담을 종료해주세요.")
		content.value+=(box.connFailMsg+"\n");	
	}
	if(box.ceoConnMsg!=null){
		content.value+=(box.ceoConnMsg+"\n");	
	}
	if(box.connMsg!=null){
		receiver=box.sender;
		$("span").html(receiver);
		if(!$("#connected").hasClass("show")){
			$("#connected").addClass("show");
			content.value+=(box.connMsg+"\n");	
		}
	}
	if(box.msg!=null){
		//if(box.sender=="${receiver}"&&box.receiver=="${sender}"){
		if(box.receiver=="${sender}"){
			content.value+=box.msg+"\n";
		}
	}
	if(box.memberDisConnMsg!=null){
		if(box.receiver=="${sender}"){
			if($("#connected").hasClass("show")){
				$("#connected").removeClass("show");
			}
			content.value+=box.memberDisConnMsg+"\n";
			receiver="";
			$("span").html(receiver);
		}
	}
	if(box.ceoDisConnMsg!=null){
		if(box.receiver=="${sender}"){
			if($("#connected").hasClass("show")){
				$("#connected").removeClass("show");
			}
			content.value+=box.ceoDisConnMsg+"\n";
			receiver="";
			$("span").html(receiver);
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
}
sock.onerror=function(error){
	console.log("error : ",error);
}
function sendMsg(){
	var obj={};
	obj.sender="${sender}";
	obj.receiver=receiver;
	obj.msg=$("#msg").val();
	content.value+="나> "+obj.msg+"\n";
	sock.send(JSON.stringify(obj));
	$("#msg").val("");
}
function ceoDisConnMsg(){
	var obj={};
	obj.sender="${sender}";
	obj.receiver=receiver;
	obj.ceoDisConnMsg="${sender}"+"님과의 상담이 종료되었습니다(*n*)"
	sock.send(JSON.stringify(obj));
}
function finishChat(){
	var obj={};
	obj.sender="${sender}";
	obj.receiver=receiver;
	obj.finishChat="${sender}"+"님과의 상담이 종료되었습니다(*n*)"
	sock.send(JSON.stringify(obj));
}
/* function disConn(){
	sock.close();
} */
</script>
</html>
