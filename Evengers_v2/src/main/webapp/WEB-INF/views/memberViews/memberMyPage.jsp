<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
<style>
#user{
margin-right: 15px;
margin-top: 30px;
color:#8A0829;
font-size: medium;

}
</style>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - Dashboard</title>

<link
	href="${pageContext.request.contextPath}/admin/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/admin/css/sb-admin-2.min.css"
	rel="stylesheet">

</head>

<body id="page-top">

	<div id="wrapper">
		<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"id="accordionSidebar">
			<a class="sidebar-brand d-flex align-items-center justify-content-center"href="#">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-laugh-wink"></i>
				</div>
				<div class="sidebar-brand-text mx-3">
					Evengers<sup>MEMBER</sup>
				</div>
			</a>

			<hr class="sidebar-divider my-0">

			<li class="nav-item active"><a class="nav-link" href="#"> <span>마이페이지</span></a>
			</li>

			<hr class="sidebar-divider">

			<li id="mInfo" class="nav-item" onclick="Ajax_forward('mInfo')">
				<a class="nav-link" href="#"> <span>개인정보 보기</span></a>
			</li>
			<li id="mInfoModify" class="nav-item"
				onclick="Ajax_forward('mInfoModify')"><a class="nav-link"
				href="#"> <span>개인정보 수정</span></a></li>

			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseTwo3"
				aria-expanded="true" aria-controls="collapseTwo"> <span>구매내역</span>
			</a>
				<div id="collapseTwo3" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<div id="evtpayList">
							<a class="collapse-item" href="#"
								onclick="Ajax_forward('payList')">이벤트결제내역</a>
						</div>
						<div id="estpayList">
							<a class="collapse-item" href="#"
								onclick="Ajax_forward('estimatePayList')">견적결제내역</a>
						</div>
					</div>
				</div></li>

		<li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo1" aria-expanded="true" aria-controls="collapseTwo">
          <!-- <i class="fas fa-fw fa-cog"></i> -->
          <span>의뢰내역</span>
        </a>
        <div id="collapseTwo1" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <!-- <h6 class="collapse-header">Custom Components:</h6> -->
            <div id="receivedEstList"><a class="collapse-item" href="#"onclick="Ajax_forward('receivedEstList')">받은견적</a></div>
            <div id="myReqList"><a class="collapse-item" href="#"onclick="Ajax_forward('myReqList')">요청서</a></div>
          </div>
        </div>
      </li>
				 <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo2" aria-expanded="true" aria-controls="collapseTwo">
          <!-- <i class="fas fa-fw fa-cog"></i> -->
          <span>문의하기</span>
        </a>
        <div id="collapseTwo2" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <!-- <h6 class="collapse-header">Custom Components:</h6> -->
            <div id="serviceCenter"><a class="collapse-item" href="#"onclick="Ajax_forward('serviceCenter')">문의하기</a></div>
            <div id="questionList"><a class="collapse-item" href="#"onclick="Ajax_forward('questionList')">문의내역</a></div>
          </div>
        </div>
      </li>
      
			<li id="choiceList" class="nav-item"
				onclick="Ajax_forward('choiceList')"><a class="nav-link"
				href="#"> <span>찜목록보기</span></a></li>

			<hr class="sidebar-divider d-none d-md-block">

			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<div id="content-wrapper" class="d-flex flex-column">

			<div id="content">

				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>

					<ul class="navbar-nav ml-auto">

						<li class="nav-item dropdown no-arrow d-sm-none"><a
							class="nav-link dropdown-toggle" href="#" id="searchDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
						</a>
							<div
								class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
								aria-labelledby="searchDropdown">
								<form class="form-inline mr-auto w-100 navbar-search">
									<div class="input-group">
										<input type="text"
											class="form-control bg-light border-0 small"
											placeholder="Search for..." aria-label="Search"
											aria-describedby="basic-addon2">
										<div class="input-group-append">
											<button class="btn btn-primary" type="button">
												<i class="fas fa-search fa-sm"></i>
											</button>
										</div>
									</div>
								</form>
							</div></li> <li class="nav-item"><a class="nav-link" href="#"><span
                        class="mr-2 d-none d-lg-inline text-gray-800 "></span></a></li>
						<div class="topbar-divider d-none d-sm-block"></div>
						<li class="nav-item"><a class="nav-link" href="./"><span
								class="mr-2 d-none d-lg-inline text-gray-800 ">홈으로가기</span></a></li>
						<div class="topbar-divider d-none d-sm-block"></div>

						<li class="nav-item"><a class="nav-link" href="./logout"><span
								class="mr-2 d-none d-lg-inline text-gray-800 ">로그아웃</span></a></li>


						<div class="topbar-divider d-none d-sm-block"></div>

					</ul>
				</nav>
				<div class="container-fluid">

					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800"></h1>
					</div>
					<div id="mMain"></div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/admin/vendor/jquery/jquery.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/admin/vendor/jquery-easing/jquery.easing.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/admin/js/sb-admin-2.min.js"></script>
</body>
<script>
	goMenu("mInfo", "#mMain");

	function goMenu(url, position) {
		$.ajax({
			url : url,
			dataType : "html",
			success : function(result) {
				$(position).html(result);
			},
			error : function(error) {
				console.log(error);
			}
		})
	}
	function Ajax_forward(url) {
		$.ajax({
			url : url,
			dataType : "html",
			success : function(page) {
				$("#mMain").html(page);
			},
			error : function(error) {
				console.log(error);
			}
		})
	}
</script>
</html>