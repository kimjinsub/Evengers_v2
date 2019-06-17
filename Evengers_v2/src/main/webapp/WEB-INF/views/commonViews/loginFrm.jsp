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

.btn-login {
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
								<h3 class="login-heading mb-4">Welcome Evengers!</h3>
								<form action="access" method="post">
									<div class="form-label-group">
									 <!-- <label for="inputEmail">ID</label> --> 
										<input type="text" id="inputEmail" class="form-control"
											name="id" placeholder="아이디를 입력하시오" required autofocus>
										
									</div>

									<div class="form-label-group">
									<!-- <label for="inputPassword">PW</label> -->
										<input type="password" id="inputPassword" class="form-control"
											name="pw" placeholder="비밀번호를 입력하시오" required> 
										
									</div>

									<button
										class="btn btn-lg btn-primary btn-block btn-login text-uppercase font-weight-bold mb-2"
										type="submit">로그인</button>
									<div class="text-center">
										<a class="small" href="joinFrm">회원가입</a>
									</div>
									<div class="text-center">
										<a class="small" href="find">아이디/비밀번호 찾기</a>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>