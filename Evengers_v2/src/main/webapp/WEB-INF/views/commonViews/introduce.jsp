<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
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


#frm.open {
	display: block;
}

</style>
<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Evengers - Introduce</title>

  <!-- Font Awesome Icons -->
  <!-- <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css"> -->

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700" rel="stylesheet">
  <link href='https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic' rel='stylesheet' type='text/css'>
  

  <!-- Plugin CSS -->
  <link href="${pageContext.request.contextPath}/ces/magnific-popup.css" rel="stylesheet">

  <!-- Theme CSS - Includes Bootstrap -->
  <link href="${pageContext.request.contextPath}/ces/creative.min.css" rel="stylesheet">
</head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/all.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js" /></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<div id="frm"></div>
<body>
<jsp:include page="../header.jsp"/>
<!-- Navigation -->
<!-- <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container">
		<a class="navbar-brand" href="#">Evengers</a>
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
			 	<li class="nav-item"><a class="nav-link" href="./introduce">소개</a></li>
				<li class="nav-item"><a class="nav-link" href="./loginFrm">로그인</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="./joinFrm">회원가입</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> Click Me! </a> Here's the magic. Add the .animate and .slide-in classes to your .dropdown-menu and you're all set!
					<div class="dropdown-menu dropdown-menu-right animate slideIn"
						aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Action</a> 
						<a class="dropdown-item" href="#">Another action</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Something else here</a>
					</div>
				</li>
			</ul>
		</div>
	</div>
</nav> -->

  <!-- Masthead -->
  <header class="masthead">
    <div class="container h-100">
      <div class="row h-100 align-items-center justify-content-center text-center">
        <div class="col-lg-10 align-self-end">
          <h1 class="text-uppercase text-white font-weight-bold">이벤트, 그 이상의 감동</h1>
          <hr class="divider my-4">
        </div>
        <div class="col-lg-8 align-self-baseline">
          <p class="text-white-75 font-weight-light mb-5">냉혹한 현대사회에 웃음꽃을 피우기 위해 현대인들은 많은 이벤트를  합니다. 하지만 막상 이벤트를 준비하려면 많은 시간과 노력을 필요로 하기 때문에 바쁜 현대사회에서 쉽지가 않습니다. 
따라서 이벤트 대행업체를 이용할 때  보다 쉽게 업체를 고르며 이벤트를 선택할 수 있는 사이트 입니다.
또한 직접 이벤트를 의뢰하며 자신만의 이벤트를 만들 수 있습니다.</p>
          <a class="btn btn-primary btn-xl js-scroll-trigger" href="#about">Find Out More</a>
        </div>
      </div>
    </div>
  </header>

  <!-- About Section -->
  <section class="page-section bg-primary" id="about">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-8 text-center">
          <h2 class="text-white mt-0">딱 ! 맞는 이벤트를 찾아보세요</h2>
          <hr class="divider light my-4">
          <p class="text-white-50 mb-4">필요한 이벤트를 찾는 일에 시간과 에너지를 낭비하지 마세요.딱! 맞는 이벤트를 찾아드립니다.</p>
          <a class="btn btn-light btn-xl js-scroll-trigger" href="./">Get Started!</a>
        </div>
      </div>
    </div>
  </section>

  <!-- Services Section -->
  <section class="page-section" id="services">
    <div class="container">
      <h2 class="text-center mt-0">At Your Service</h2>
      <hr class="divider my-4">
      <div class="row">
        <div class="col-lg-3 col-md-6 text-center">
          <div class="mt-5">
            <i class="fas fa-4x fa-gem text-primary mb-4"></i>
            <h3 class="h4 mb-2">프로포즈/웨딩</h3>
            <p class="text-muted mb-0">Propose/Wedding</p>
          </div>
        </div>
        <div class="col-lg-3 col-md-6 text-center">
          <div class="mt-5">
            <i class="fas fa-4x fa-laptop-code text-primary mb-4"></i>
            <h3 class="h4 mb-2">출장뷔페</h3>
            <p class="text-muted mb-0">Business Buffet</p>
          </div>
        </div>
        <div class="col-lg-3 col-md-6 text-center">
          <div class="mt-5">
            <i class="fas fa-4x fa-globe text-primary mb-4"></i>
            <h3 class="h4 mb-2">행사MC</h3>
            <p class="text-muted mb-0">Event MC</p>
          </div>
        </div>
        <div class="col-lg-3 col-md-6 text-center">
          <div class="mt-5">
            <i class="fas fa-4x fa-heart text-primary mb-4"></i>
            <h3 class="h4 mb-2">파티/행사기획</h3>
            <p class="text-muted mb-0">Party/Event Planning</p>
          </div>
        </div>
      </div>
    </div>
  </section>



  <!-- Call to Action Section -->
  <section class="page-section bg-dark text-white">
    <div class="container text-center">
      <h2 class="mb-4">이벤져스에 가입해보세요!</h2>
      <a class="btn btn-light btn-xl" href="./joinFrm">Download Now!</a>
    </div>
  </section>

  <!-- Contact Section -->
  <section class="page-section" id="contact">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-8 text-center">
          <h2 class="mt-0">이벤트를 만들어 볼 기회!</h2>
          <hr class="divider my-4">
          <p class="text-muted mb-5">직접 원하는 이벤트를 기획하면서 자신만의 이벤트를 만들어 보세요.</p>
          <a class="btn btn-primary btn-xl js-scroll-trigger" href="./evtReqFrm">Create Event!</a>
        </div>
      </div>
      <div class="row">
        <div class="col-lg-4 ml-auto text-center mb-5 mb-lg-0">
          <i class="fas fa-phone fa-3x mb-3 text-muted"></i>
          <div>032-876-3332</div>
        </div>
        <div class="col-lg-4 mr-auto text-center">
          <i class="fas fa-envelope fa-3x mb-3 text-muted"></i>
          <!-- Make sure to change the email address in anchor text AND the link below! -->
          <a class="d-block" href="mailto:contact@yourwebsite.com">icia@naver.com</a>
        </div>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer class="bg-light py-5">
    <div class="container">
      <div class="small text-center text-muted">Copyright &copy; 2019 - Evengers</div>
    </div>
  </footer>

  <!-- Bootstrap core JavaScript -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/ces/jquery.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/ces/bootstrap.bundle.min.js"></script>

  <!-- Plugin JavaScript -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/ces/jquery.easing.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/ces/jquery.magnific-popup.min.js"></script>

  <!-- Custom scripts for this template -->
  <%-- <script type="text/javascript" src="${pageContext.request.contextPath}/ces/js/creative.min.js"></script> --%>

  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
<script>
var $layerWindows = $('#frm'); //jquery 객체는 변수에 $ 붙혀서 가독성 좋게!
$layerWindows.find('#detail-shadow').on('mousedown',function(event){
console.log(event);
$layerWindows.removeClass('open');
});
$(document).keydown(function(event){
	console.log(event);
	if(event.keyCode!=27) return;
	if($layerWindows.hasClass('open')){ //open이라는 클래스를 가지고 있는지 hasClass로 따짐.
		$layerWindows.removeClass('open');
	}
});

</script>
</html>