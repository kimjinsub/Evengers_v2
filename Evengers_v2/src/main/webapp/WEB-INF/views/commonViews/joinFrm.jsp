<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/all.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js" /></script>
<title>Insert title here</title>
<style>
.btn1 {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 27;
  -moz-border-radius: 27;
  border-radius: 27px;
  font-family: Georgia;
  color: #ffffff;
  font-size: 35px;
  padding: 40px 40px 40px 40px;
  text-decoration: none;
  
}
#div{
	margin-top: 100px;
}
<style>
:root { -
	-input-padding-x: 1.5rem; -
	-input-padding-y: 0.75rem;
}

.login, .image {
	min-height: 100vh;
}

.bg-image {
	background-image:
		url("img/img_p4.jpg");
	background-size: cover;
	background-position: center;
}

.login-heading {
	font-weight: 300;
}

.btn-member {
	font-size: 0.9rem;
	letter-spacing: 0.05rem; 
	padding: 0.75rem 1rem;
	border-radius: 2rem; 
}
.btn-ceo {
	font-size: 0.9rem;
	letter-spacing: 0.05rem; 
	padding: 0.75rem 1rem;
	border-radius: 2rem; 
}
.form-label-group {
	position: relative;
	margin-bottom: 1rem;
}

.form-label-group>input, .form-label-group>label {
	padding: var(- -input-padding-y) var(- -input-padding-x);
	height: auto;
	border-radius: 2rem;
}

.form-label-group>label {
	position: absolute;
	top: 0;
	left: 0;
	display: block;
	width: 100%;
	margin-bottom: 0;
	/* Override default `<label>` margin */
	line-height: 1.5;
	color: #495057;
	cursor: text;
	/* Match the input under the label */
	border: 1px solid transparent;
	border-radius: .25rem;
	transition: all .1s ease-in-out;
}


.form-label-group input:not (:placeholder-shown ) {
	padding-top: calc(var(- -input-padding-y)+ var(- -input-padding-y)* (2/3));
	padding-bottom: calc(var(- -input-padding-y)/3);
}

.form-label-group input:not (:placeholder-shown )~label {
	padding-top: calc(var(- -input-padding-y)/3);
	padding-bottom: calc(var(- -input-padding-y)/3);
	font-size: 12px;
	color: #777;
}

/* Fallback for Edge
-------------------------------------------------- */
@
supports (-ms-ime-align: auto ) { .form-label-group >label { display:none;
	
}

.form-label-group input::-ms-input-placeholder {
	color: #777;
}

}

/* Fallback for IE
-------------------------------------------------- */
@media all and (-ms-high-contrast: none) , ( -ms-high-contrast : active)
	{
	.form-label-group>label {
		display: none;
	}
	.form-label-group input:-ms-input-placeholder {
		color: #777;
	}
}
</style>

</head>

<body>
	<div class="container-fluid">
		<div class="row no-gutter">
			<div class="d-none d-md-flex col-md-4 col-lg-6 bg-image"></div>
			<div class="col-md-8 col-lg-6">
				<div class="login d-flex align-items-center py-5">
					<div class="container">
						<div class="row">
							<div class="col-md-9 col-lg-8 mx-auto">
								<h3 class="login-heading mb-4">welcome! Join!</h3>
								<form action="access" method="post">
									<div class="form-label-group">
									 <!-- <label for="inputEmail">ID</label> --> 
									</div>
										<a href="memberJoin"><input type="button" value="일반회원가입" class="btn btn-lg btn-primary btn-block btn-member text-uppercase font-weight-bold mb-2"/></a> 
									<div class="text-center">
										<a href="ceoJoin"><input type="button" value="기업회원가입" class="btn btn-lg btn-primary btn-block btn-ceo text-uppercase font-weight-bold mb-2"/></a>
									</div>
										
									</div>
</div>
</body>
</html>