<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>Home</title>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/all.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js" /></script>
<style>
.carousel-item {
	height: 65vh;
	min-height: 350px;
	background: no-repeat center center scroll;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}
#member,#ceo,#admin,#common{
	visibility: hidden;
}
#member.show,#ceo.show,#admin.show,#common.show{
	visibility: visible;
}
</style>
</head>
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
				<!-- <li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> Click Me! </a>
					<div class="dropdown-menu dropdown-menu-right animate slideIn"
						aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Action</a> 
						<a class="dropdown-item" href="#">Another action</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Something else here</a>
					</div>
				</li> -->
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
				<li class="nav-item"><a class="nav-link" href="./logout">로그아웃</a></li>
				<!-- <li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> Click Me! </a>
					<div class="dropdown-menu dropdown-menu-right animate slideIn"
						aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Action</a> 
						<a class="dropdown-item" href="#">Another action</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Something else here</a>
					</div>
				</li> -->
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
				<!-- <li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> Click Me! </a>
					<div class="dropdown-menu dropdown-menu-right animate slideIn"
						aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Action</a> 
						<a class="dropdown-item" href="#">Another action</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Something else here</a>
					</div>
				</li> -->
			</ul>
		</div>
	</div>
</nav>

<header>
	<div id="carouselExampleIndicators" class="carousel slide"
		data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="0"
				class="active"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner" role="listbox">
			<!-- Slide One - Set the background image for this slide in the line below -->
			<div class="carousel-item active"
				style="background-image: url('https://source.unsplash.com/RCAhiGJsUUE/1920x1080')">
				<div class="carousel-caption d-none d-md-block">
					<h3 class="display-4">First Slide</h3>
					<p class="lead">This is a description for the first slide.</p>
				</div>
			</div>
			<!-- Slide Two - Set the background image for this slide in the line below -->
			<div class="carousel-item"
				style="background-image: url('https://source.unsplash.com/wfh8dDlNFOk/1920x1080')">
				<div class="carousel-caption d-none d-md-block">
					<h3 class="display-4">Second Slide</h3>
					<p class="lead">This is a description for the second slide.</p>
				</div>
			</div>
			<!-- Slide Three - Set the background image for this slide in the line below -->
			<div class="carousel-item"
				style="background-image: url('https://source.unsplash.com/O7fzqFEfLlo/1920x1080')">
				<div class="carousel-caption d-none d-md-block">
					<h3 class="display-4">Third Slide</h3>
					<p class="lead">This is a description for the third slide.</p>
				</div>
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleIndicators"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
</header>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="container">
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarResponsive" aria-controls="navbarResponsive"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive2">
			<ul class="navbar-nav m-auto">
			</ul>
		</div>
	</div>
</nav>

<!-- Page Content -->
<div class="container">
	<h1 class="font-weight-light text-center text-lg-left mt-4 mb-0"
		id="ec_name"></h1>
		
	<hr class="mt-2 mb-5">
	
	<div class="row text-center text-lg-left" id="evtList">
	</div>
</div>
<div class="col-lg-2 col-md-3 col-6">
</div>
</body>
<script>
$(document).ready(function(){
	//console.log("세션값",${sessionScope.id});//EL로 세션이 안불러와진다...
	console.log("getSessionId:",getSessionId());
	var iam=whoRU(getSessionId());
	if(iam=="member"){
		$("#member").addClass("show");
	}else if(iam=="admin"){
		$("#admin").addClass("show");
	}else if(iam=="ceo"){
		$("#ceo").addClass("show");
	}else{
		$("#common").addClass("show");
	}
	getCategories();
});
function getSessionId(){
	$.ajax({
		url:"getSessionId",
		async:false,
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
function whoRU(id){
	var iam;
	$.ajax({
		url:"whoRU",
		async:false,
		data:{id:id},
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
function getEvtList(ec_name){
	console.log(ec_name);
	$("#ec_name").html(ec_name);
	AjaxEvtList(ec_name);
}
function AjaxEvtList(ec_name){
	$.ajax({
		url:"getEvtList",
		data:{ec_name:ec_name},
		dataType:"json",
		success:function(result){
			var str="";
			for(var i in result){
				str+='<div class="col-lg-3 col-md-4 col-6">'
					+'<a href="evtInfo?e_code='+result[i].e_code+'" class="d-block mb-4 h-100">' 
					+'<img class="img-fluid img-thumbnail"'
					+'src="upload/thumbnail/'+result[i].e_sysfilename+'">'
					+'</a></div>'
			}
			console.log(str);
			$("#evtList").html(str);
		},
		error:function(error){
			console.log(error);
		}
	})
};
function getCategories(){
	$.ajax({
		url:"getCategoryList",
		dataType:"json",
		success:function(result){
			var str="";
			for(var i in result){
				str+='<li class="nav-item">'
						+'<a class="nav-link" id="'+result[i].ec_name
						+'" onclick="getEvtList(this.id)">'
						+result[i].ec_name+'</a></li>';
				console.log(i,result[i]);
			}
			$("#navbarResponsive2 ul").append(str);
			//$("#navbarResponsive2 ul li:first").addClass("active");
			getEvtList(result[0].ec_name);
		},
		error:function(error){
			console.log(error);
		}
	})
};
</script>
</html>