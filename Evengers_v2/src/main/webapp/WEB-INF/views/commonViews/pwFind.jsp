<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
<input type="text" id="id" name="id" placeholder="아이디를 입력하세요">

<br>
<input type="text" id="email" name="email" placeholder="이메일을 입력하세요">
<button onclick="sendNumber()">인증번호 발송</button>
<div id="idEmail"></div>

<input type="text"id="matchNum" name="matchNum" placeholder="인증번호">
<button onclick="matchNum()">확인</button>

<div id="pwChange">

<input type="text" id="pwMo1" name="pwMo2" placeholder="비밀번호를 입력하세요"><br>
<input type="text" id="pwMo2" name="pwMo2" placeholder="비밀번호를 확인하세요">
<button onclick="pwChange()">비밀번호 변경</button>

</div>
<div id="com">
</div>
</body>
<script>
$('#pwChange').hide();

function sendNumber(){
	var id=$('#id').val();
	var email=$('#email').val();
	$.ajax({
		url:"sendpw.do",
		data:{id:id,email:email},
		dataType:"text",
		success:function(data){
			console.log(data);
			if(data=="false"){
				$('#idEmail').text("등록된 정보가 없거나 입력을 잘못입력했습니다.");
			}else{
				$('#idEmail').text("인증번호가 발송되었습니다.");
			}
		},
		error : function(error) {
			console.log(error);
		}
	});
}
function matchNum(){
	var matchNum=$('#matchNum').val();
	$.ajax({
		url:"matchNum",
		data:{matchNum:matchNum},
		dataType:"text",
		success:function(data){
			console.log("matchNum"+data);
			$('#pwChange').hide();
		},
		error : function(error) {
			console.log(error);
		}
	});
}
function matchNum(){
	var matchNum=$('#matchNum').val();
	$.ajax({
		url:"matchNum",
		data:{matchNum:matchNum},
		dataType:"text",
		success:function(data){
			console.log("matchNum: "+data);
			if(data=="true"){
				$('#pwChange').show();
			}
		},
		error : function(error) {
			console.log(error);
		}
	});
}
function pwChange(){
	var id=$('#id').val();
	var pwMo1=$('#pwMo1').val();
	var pwMo2=$('#pwMo2').val();
	$.ajax({
		url:"pwChange",
		data:{id:id,pwMo1:pwMo1,pwMo2:pwMo2},
		dataType:"text",
		success:function(data){
			/* $('#com').text(data); */
			alert(data);
			if(pwMo1==pwMo2){
				location.href="./";
			}
			
		},
		error : function(error) {
			console.log(error);
		}
	});
}
</script>
</html>