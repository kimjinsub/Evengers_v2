<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/all.css">
<%-- <link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css"> --%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js" /></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#frm {
	position:fixed;
	top: 30px;
	left: 35%;
	width: 750px;
	height: 650px;
	padding: 2px;
	margin-left: -150px;
	float:left;
	z-index: 101;
	display: none;
	overflow:scroll;
	background-color: white;
}


#detail.open {
	display: block;
}

#detail {
	position:fixed;
	top: 30px;
	left: 35%;
	width: 750px;
	height: 650px;
	padding: 2px;
	margin-left: -150px;
	float:left;
	z-index: 101;
	display: none;
	overflow:scroll;
	background-color: white;
}


#frm.open {
	display: block;
}


#pageDown {
   text-align: right;
   float: right;
   position: fixed;
   margin-left: 710px;
   font-size: x-large;
   cursor: pointer;
}

#member,#ceo,#admin,#common{
	visibility: hidden; font-size: 20px;
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
				<li class="nav-item active"><a class="nav-link" href="./">홈
						<span class="sr-only">(current)</span>
				</a></li>
			 	<li class="nav-item active"><a class="nav-link" href="./introduce">소개</a></li>
				<li class="nav-item active"><a class="nav-link" href="./memberMyPage">마이페이지</a></li>
				<li class="nav-item active"><a class="nav-link" href="#" onclick="evtReqFrm1()">의뢰요청</a></li>
				<li class="nav-item active"><a class="nav-link" href="./logout">로그아웃</a></li>
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
				<li class="nav-item active"><a class="nav-link" href="./">홈
						<span class="sr-only">(current)</span>
				</a></li>
			 	<li class="nav-item active"><a class="nav-link" href="./introduce">소개</a></li>
				<li class="nav-item active"><a class="nav-link" href="./ceoMyPage">마이페이지</a></li>
				<li class="nav-item active"><a class="nav-link" href="./evtInsertFrm">이벤트등록</a></li>
				<li class="nav-item active"><a class="nav-link" href="#" onclick="Ajax_forward('myReqList')">의뢰목록</a></li>
				<li class="nav-item active"><a class="nav-link" href="./erpIndex">ERP자원관리</a></li>
				<!-- <li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="./erpIndex" id="navbarDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> ERP자원관리 </a>
					<div class="dropdown-menu dropdown-menu-right animate slideIn"
						aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">인사관리</a> 
						<a class="dropdown-item" href="#">회계관리</a> 
						<a class="dropdown-item" href="#">일정관리</a>
					</div>
				</li> -->
				<li class="nav-item active"><a class="nav-link" href="javascript:ceoChat()">채팅시작</a></li>
				<li class="nav-item active"><a class="nav-link" href="./logout">로그아웃</a></li>
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
				<li class="nav-item active"><a class="nav-link" href="./">홈
						<span class="sr-only">(current)</span>
				</a></li>
			 	<li class="nav-item active"><a class="nav-link" href="./introduce">소개</a></li>
			 	<li class="nav-item active"><a class="nav-link" href="./categoryFrm">카테고리 관리</a></li>
			 	<li class="nav-item active"><a class="nav-link" href="./allQuestionList">문의 보기</a></li>
				<li class="nav-item active"><a class="nav-link" href="./logout">로그아웃</a></li>
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
				<li class="nav-item active"><a class="nav-link" href="./">홈
						<span class="sr-only">(current)</span>
				</a></li>
			 	<li class="nav-item active"><a class="nav-link" href="./introduce">소개</a></li>
				<li class="nav-item active"><a class="nav-link" href="./loginFrm">로그인</a>
				</li>
				<li class="nav-item active"><a class="nav-link" href="./joinFrm">회원가입</a></li>
			</ul>
		</div>
	</div>
</nav>
<div id="detail"></div>
<div id="frm"></div>
</body>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
function ceoChat(receiver){
	$.ajax({
		url:"checkDoubleChat",
		dataType:"text",
		success:function(result){
			if(result=="no"){
				window.open('chat',"_blank","width=400,height=700;");
			}else{
				swal({
		        	title: result,
		        	icon: "warning",
				});
			}
		},
		error:function(error){
			console.log(error);
		}
	})
}
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

	//getReqList(1,10);



function Ajax_forward(url){
	$("#detail").addClass("open");
	$('#detail').show();
	$('#detail-shadow').show();
	$.ajax({
		url:url,
		dataType:"html",
		success:function(data){
			$("#detail").html(data);
		},
		error:function(error){
			console.log(error);
		}
	})
}

function evtReqFrm1(){
	$("#frm").addClass("open");
	$('#frm').show();
	$.ajax({
		url:'evtReqFrm',
		type : 'get',
	    dataType:'html',
	    success:function(data){
	    	$("#frm").html(data);
	    },
	    error:function(error){
	    	console.log(error);
	    }
	});
}

var $layerWindows = $('#frm'); 
$layerWindows.find('#detail-shadow').on('mousedown',function(event){
console.log(event);
$layerWindows.removeClass('open');
});
$(document).keydown(function(event){
	//console.log(event);
	if(event.keyCode!=27) return;
	if($layerWindows.hasClass('open')){
		$layerWindows.removeClass('open');
	}
});
</script>
</html>