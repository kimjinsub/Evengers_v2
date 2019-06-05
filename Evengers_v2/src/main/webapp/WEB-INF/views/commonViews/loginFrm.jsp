<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#login {
	border: 2px solid black;
	position: absolute;
	padding: 20px;
	height: 450px;
	width: 375px;
	background-color: #EEEFF1;
	border-radius: 5px;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

.login {
	top: 2px;
	left: 2px;
	width: 350px;
	color: #999;
	cursor: text;
	height: 35px;
	margin-bottom: 30px;
	margin-top: 10px;
	font-size: 20px;
	border-radius: 5rem;
	letter-spacing: .1rem;
	font-weight: bold;
	padding: 1rem;
	transition: all 0.2s;
}

#findbtn {
	border: 1px solid skyblue;
	background-color: #F2CB61;
	width: 365px;
	height: 50px;
	color: white;
	padding: 5px;
	margin-bottom: 30px;
}

#loginbtn {
	border-radius: 2px;
	border-radius: 10px;
	border: 1px solid skyblue;
	background-color: dimgray;
	width: 150px;
	height: 55px;
	color: white;
	padding: 5px;
	margin-right: 55px;
}

#joinbtn {
	border-radius: 2px;
	border-radius: 10px;
	border: 1px solid skyblue;
	background-color: dimgray;
	width: 150px;
	height: 55px;
	color: white;
	padding: 5px;
}

</style>
</head>
<body>
	<form action="access" method="post">
		<div id="login">
			<input type="text" class="login" id="id" name="id" placeholder="아이디를 입력하시오"><br>
			<input type="password" class="login" id="pw" name="pw" placeholder="비밀번호를 입력하시오"><br>
			<input type="button" id="findbtn" value="아이디/비밀번호 찾기" onclick="location.href='find'"><br><!-- //find.jsp -->
			<input type="submit" id="loginbtn" value="로그인"> 
			<input type="button" id="joinbtn" value="회원가입" onclick="location.href='joinFrm'"><!-- //joinFrm.jsp -->
		</div>
	</form>
</body>
</html>