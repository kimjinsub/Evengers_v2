<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"%>
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
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<style>
body {
  background: #007bff;
  background: linear-gradient(to right, #0062E6, #33AEFF);
}
#find {
	position: absolute;
	padding: 20px;
	height: 550px;
	width: 425px;
	background-color: white;
	border-radius:2em;
    -moz-border-radius: 0.5em;
    -webkit-border-radius: 0.5em;
      padding: 1rem;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
#h5{
	font-family: 'Nanum Gothic', sans-serif;
	color : white;
}
#img{
	width:40px;
	height: 40px;
}
</style>

</head>
<body>

	<h5 class="card-header info-color white-text text-center py-4" id="h5">
        <img id="img" src="img/padlock.png">&nbsp<strong>ID & PW FIND</strong>
    </h5>

   <div id="find">
										
		<div class="btn btn-outline-primary btn-rounded waves-effect" id="idFind" >아이디 찾기</div>
		<div class="btn btn-outline-primary btn-rounded waves-effect" id="pwFind" >비밀번호 찾기</div><br>
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