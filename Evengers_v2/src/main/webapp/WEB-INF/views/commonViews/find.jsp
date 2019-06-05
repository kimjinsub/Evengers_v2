<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>find.jsp</title>
<style>
#find {
	border: 2px solid black;
	position: absolute;
	padding: 20px;
	height: 470px;
	width: 425px;
	background-color: #EEEFF1;
	border-radius: 5px;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

.find {
	display: inline;
	width: 300px;
	height: 300px;
	border: 1px solid skyblue;
	background-color: #F2CB61;
}

.find:hover {
	background-color: aqua;
	transition: all linear 1s;
}
</style>

</head>
<body>
	<div id="find">
		<div class="find" id="idFind"name="idFind">아이디 찾기</div>
		<div class="find" id="pwFind"name="pwFind">비밀번호 찾기</div>
		<div id="find_main">
		
		
		</div>
	</div>

</body>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$("#find_main").load("idFind");

	$('#idFind').click(function(){
		$.ajax({
			url:"idFind",
			datatype:"html",
			success:function(result){
				$('#find_main').html(result);
			},error:function(error){
				console.log(error);
			}
		})
	});
	
	$('#pwFind').click(function(){
		$.ajax({
			url:"pwFind",
			datatype:"html",
			success:function(result){
				$('#find_main').html(result);
			},error:function(error){
				console.log(error);
			}
		})
	});

</script>
</html>