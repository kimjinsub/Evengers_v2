<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#member,#ceo,#admin,#common{
	visibility: hidden;
}
#member.show,#ceo.show,#admin.show,#common.show{
	visibility: visible;
}
</style>
</head>
<body>
	<!-- Navigation -->
<nav id="member" class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container">
		<a class="navbar-brand" href="./">Evengers</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarResponsive" aria-controls="navbarResponsive"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active"><a class="nav-link" href="#">홈
						<span class="sr-only">(current)</span>
				</a></li>
			 	<li class="nav-item"><a class="nav-link" href="#">소개</a></li>
				<li class="nav-item"><a class="nav-link" href="#">마이페이지</a></li>
				<li class="nav-item"><a class="nav-link" href="#">의뢰요청</a></li>
				<li class="nav-item"><a class="nav-link" href="./logout">로그아웃</a></li>
			</ul>
		</div>
	</div>
</nav>
<nav id="ceo" class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container">
		<a class="navbar-brand" href="./">Evengers</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarResponsive" aria-controls="navbarResponsive"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active"><a class="nav-link" href="#">홈
						<span class="sr-only">(current)</span>
				</a></li>
			 	<li class="nav-item"><a class="nav-link" href="#">소개</a></li>
				<li class="nav-item"><a class="nav-link" href="#">마이페이지</a></li>
				<li class="nav-item"><a class="nav-link" href="./evtInsertFrm">이벤트등록</a></li>
				<li class="nav-item"><a class="nav-link" href="#">의뢰목록</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> ERP자원관리 </a> <!-- Here's the magic. Add the .animate and .slide-in classes to your .dropdown-menu and you're all set! -->
					<div class="dropdown-menu dropdown-menu-right animate slideIn"
						aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">인사관리</a> 
						<a class="dropdown-item" href="#">회계관리</a> 
						<a class="dropdown-item" href="#">일정관리</a>
						<!-- <div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Something else here</a> -->
					</div>
				</li>
				<li class="nav-item"><a class="nav-link" href="./logout">로그아웃</a></li>
			</ul>
		</div>
	</div>
</nav>
<nav id="admin" class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container">
		<a class="navbar-brand" href="./">Evengers</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarResponsive" aria-controls="navbarResponsive"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active"><a class="nav-link" href="#">홈
						<span class="sr-only">(current)</span>
				</a></li>
			 	<li class="nav-item"><a class="nav-link" href="#">소개</a></li>
			 	<li class="nav-item"><a class="nav-link" href="./categoryFrm">카테고리 관리</a></li>
				<li class="nav-item"><a class="nav-link" href="./logout">로그아웃</a></li>
			</ul>
		</div>
	</div>
</nav>
<nav id="common" class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container">
		<a class="navbar-brand" href="./">Evengers</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarResponsive" aria-controls="navbarResponsive"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active"><a class="nav-link" href="#">홈
						<span class="sr-only">(current)</span>
				</a></li>
			 	<li class="nav-item"><a class="nav-link" href="#">소개</a></li>
				<li class="nav-item"><a class="nav-link" href="./loginFrm">로그인</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="./joinFrm">회원가입</a></li>
			</ul>
		</div>
	</div>
</nav>

</body>
<script>
$(document).ready(function(){
	console.log("getSessionId:",getSessionId());
	var iam=getSessionId();
	if(iam=="member"){
		$("#member").addClass("show");
	}else if(iam=="admin"){
		$("#admin").addClass("show");
	}else if(iam=="ceo"){
		$("#ceo").addClass("show");
	}else{
		$("#common").addClass("show");
	}
});
function getSessionId(){
	$.ajax({
		url:"getSessionId",
		async:false,//deprecated...
		dataType:"text",
		success:function(result){
			iam=result;
		},
		error:function(error){
			console.log(error);
		}
	})
	return iam;
}
</script>
</html>