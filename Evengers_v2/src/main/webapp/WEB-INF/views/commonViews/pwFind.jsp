<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.btn btn-lg btn-primary btn-block btn-login text-uppercase font-weight-bold mb-2 {
        margin: 100px 0px;
}
#idEmail{
	color :red;
}
</style>
</head>
<body>
<br>

<input type="text" id="id" name="id" placeholder="아이디를 입력하세요"style: "width:90%; height:50px;" class="form-control">

<input type="text" id="email" name="email" placeholder="이메일을 입력하세요"style: "width:90%; height:50px;" class="form-control"><br>
<button onclick="sendNumber()"class="btn btn-outline-primary btn-rounded waves-effect"style=""width:45%; height:40px;text-align: center; line-height: 20px;">인증번호 발송</button>
<div id="idEmail"></div>
<hr>	
<input type="text"id="matchNum" name="matchNum" placeholder="인증번호" style="width:40%; height:40px;display: inline;"class="form-control">
<button onclick="matchNum()"class="btn btn-outline-primary btn-rounded waves-effect">확인</button>
<div id="pwChange">
<hr>	
<input type="password" id="pwMo1" name="pwMo2" placeholder="비밀번호를 입력하세요"style="width:90%; height:40px;border-radius:25px;"class="form-control">
<input type="password" id="pwMo2" name="pwMo2" placeholder="비밀번호를 확인하세요"style="width:90%; height:40px;border-radius:25px;"class="form-control"><br>
<button onclick="pwChange()"class="btn btn-outline-primary btn-rounded waves-effect"style="width:50%; height:40px;line-height: 20px;">비밀번호 변경</button>

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