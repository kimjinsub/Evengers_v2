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
</style>

</head>
<body>
	<div id="find">
										
		<div class="btn btn-lg btn-primary btn-block btn-login text-uppercase font-weight-bold mb-2" id="idFind" style="width: 40%;float: left;display:inline;position: relative;top:15px;left: 7px">아이디 찾기</div>
		<div class="btn btn-lg btn-primary btn-block btn-login text-uppercase font-weight-bold mb-2" id="pwFind" style="width: 50%;float: right;display:inline;position: relative;top: 7px;right: 10px">비밀번호 찾기</div>
		<div id="find_main"style="display:inline;position: relative;top:25px;">
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