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
.jumbotron {
    background-image: url("img/main.png");
    background-size: cover;
    background-position: center;
    height: 450px;
    color: #fff;
    padding: 100px 25px;
    margin-bottom: 0em;
    font-family: Montserrat, sans-serif;
}
.input-group{
	margin: auto;
}
.img-thumbnail{
	height: 250px;
	width: 250px;
}
</style>
</head>
<jsp:include page="header.jsp"></jsp:include>
<!-- jumbotron -->
<div class="jumbotron text-center">
  <form>
    <div class="input-group col-lg-4">
      <input type="text" class="form-control" size="50" placeholder="원하는 이벤트를 찾아보세요" required>
      <div class="input-group-btn">
        <button type="button" class="btn btn-danger">검색</button>
      </div>
    </div>
  </form>
</div>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light" style="background-color:#d1d1d1">
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
	getCategories();
});
function getEvtList(ec_name){
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
				str+='<li class="nav-item active" style="font-size:20px;">'
						+'<a class="nav-link" id="'+result[i].ec_name
						+'" onclick="getEvtList(this.id)">'
						+result[i].ec_name+'</a></li>';
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