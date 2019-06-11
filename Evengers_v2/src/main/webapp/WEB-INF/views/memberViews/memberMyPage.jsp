<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin 2 - Dashboard</title>

  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/admin/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Evengers<sup>MEMBER</sup></div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item active">
        <a class="nav-link" href="#">
          <!-- <i class="fas fa-fw fa-tachometer-alt"></i> -->
          <span>마이페이지</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <!-- <div class="sidebar-heading">
        Interface
      </div> -->

     <!-- Nav Item - Charts -->
      <li id="mInfo" class="nav-item">
        <a class="nav-link" href="#">
          <!-- <i class="fas fa-fw fa-chart-area"></i> -->
          <span>개인정보 보기</span></a>
      </li>
     <!-- Nav Item - Charts -->
      <li id="mInfoModify" class="nav-item">
        <a class="nav-link" href="#">
          <!-- <i class="fas fa-fw fa-chart-area"></i> -->
          <span>개인정보 수정</span></a>
      </li>
     <!-- Nav Item - Charts -->
      <li id="payList" class="nav-item">
        <a class="nav-link" href="#">
          <!-- <i class="fas fa-fw fa-chart-area"></i> -->
          <span>구매내역</span></a>
      </li>
      <!-- Nav Item - Pages Collapse Menu -->
      
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <!-- <i class="fas fa-fw fa-cog"></i> -->
          <span>의뢰내역</span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <!-- <h6 class="collapse-header">Custom Components:</h6> -->
            <div id="receivedEstList"><a class="collapse-item" href="#">받은견적</a></div>
            <div id="myReqList"><a class="collapse-item" href="#">요청서</a></div>
          </div>
        </div>
      </li>
      
      <!-- Nav Item - Charts -->
      <li id="choiceList" class="nav-item">
        <a class="nav-link" href="#">
          <!-- <i class="fas fa-fw fa-chart-area"></i> -->
          <span>찜목록보기</span></a>
      </li>
      
      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">

      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- Topbar Search -->
          <!-- <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
            <div class="input-group">
              <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
              <div class="input-group-append">
                <button class="btn btn-primary" type="button">
                  <i class="fas fa-search fa-sm"></i>
                </button>
              </div>
            </div>
          </form> -->

          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">

            <!-- Nav Item - Search Dropdown (Visible Only XS) -->
            <li class="nav-item dropdown no-arrow d-sm-none">
              <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-search fa-fw"></i>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in" aria-labelledby="searchDropdown">
                <form class="form-inline mr-auto w-100 navbar-search">
                  <div class="input-group">
                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                      <button class="btn btn-primary" type="button">
                        <i class="fas fa-search fa-sm"></i>
                      </button>
                    </div>
                  </div>
                </form>
              </div>
            </li>

			<li class="nav-item"><a class="nav-link" href="./"><span class="mr-2 d-none d-lg-inline text-gray-800 ">홈으로가기</span></a></li>
            <div class="topbar-divider d-none d-sm-block"></div>
               <li class="nav-item"><a class="nav-link" href="#"><span class="mr-2 d-none d-lg-inline text-gray-800 ">견적의뢰</span></a></li>
            <div class="topbar-divider d-none d-sm-block"></div>

               <li class="nav-item"><a class="nav-link" href="./logout"><span class="mr-2 d-none d-lg-inline text-gray-800 ">로그아웃</span></a></li>
         
            

            <div class="topbar-divider d-none d-sm-block"></div>

            <!-- Nav Item - User Information -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">Valerie Luna</span>
                <img class="img-profile rounded-circle" src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="#">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                  Profile
                </a>
                <a class="dropdown-item" href="#">
                  <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                  Settings
                </a>
                <a class="dropdown-item" href="#">
                  <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                  Activity Log
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Logout
                </a>
              </div>
            </li>
          </ul>
        </nav>
        <div class="container-fluid">

          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
          </div>
          <div id="mMain">
          
          
          </div>
  <script type="text/javascript" src="${pageContext.request.contextPath}/admin/vendor/jquery/jquery.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script type="text/javascript" src="${pageContext.request.contextPath}/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/sb-admin-2.min.js"></script>

  <!-- Page level plugins -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/admin/vendor/chart.js/Chart.min.js"></script>

  <!-- Page level custom scripts -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/demo/chart-area-demo.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/demo/chart-pie-demo.js"></script>

</body>

</html>	
</body>
<script>
	
	goMenu("mInfo","#mMain");
	
	function goMenu(url,position){
		$.ajax({
			url:url,
			dataType:"html",
			success:function(result){
				$(position).html(result);
			},
			error:function(result){
				console.log(error);
			}
		})
	}
	 $('#receivedEstList').click(function(){
		$.ajax({
			url:"receivedEstList",
			dataType:"html",
			success:function(result){
				$("#mMain").html(result);
			},
			error:function(result){
				console.log(error);
			}
		})
	});
	$('#myReqList').click(function(){
		$.ajax({
			url:"myReqList",
			dataType:"html",
			success:function(result){
				$("#mMain").html(result);
			},
			error:function(result){
				console.log(error);
			}
		})
	});
	$('#mInfo').click(function() {
		$.ajax({
			url : "mInfo",
			dataType : "html",
			success : function(result) {
				$("#mMain").html(result);
			},
			error : function(result) {
				console.log(error);
			}
		})
	});
	$('#mInfoModify').click(function() {
		$.ajax({
			url : "mInfoModify",
			dataType : "html",
			success : function(result) {
				$("#mMain").html(result);
			},
			error : function(result) {
				console.log(error);
			}
		})
	});
	$('#payList').click(function() {
		$.ajax({
			url : "memberPayList",
			dataType : "html",
			success : function(result) {
				$("#mMain").html(result);
			},
			error : function(result) {
				console.log(error);
			}
		})
		
	});
	$('#receivedList').click(function() {
		$.ajax({
			url : "receivedList",
			dataType : "html",
			success : function(result) {
				$("#mMain").html(result);
			},
			error : function(result) {
				console.log(error);
			}
		})
	});
	$('#choiceList').click(function() {
		$.ajax({
			url : "choiceList",
			dataType : "html",
			success : function(result) {
				$("#mMain").html(result);
			},
			error : function(result) {
				console.log(error);
			}
		})
	}); 	
</script>
</html>