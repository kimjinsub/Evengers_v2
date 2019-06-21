<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>ERP자원관리</title>

  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Page level plugin CSS-->
  <link href="${pageContext.request.contextPath}/admin/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/admin/css/sb-admin.css" rel="stylesheet">

</head>

<body id="page-top">

  <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

    <a class="navbar-brand mr-1" href="./erpIndex">ERP자원관리</a>

    <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
      <i class="fas fa-bars"></i>
    </button>

    <!-- Navbar Search -->
    <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
    </form>

    <!-- Navbar -->
    <ul class="navbar-nav ml-auto ml-md-0">
      <!-- <li class="nav-item">
          <a class="nav-link" href="#">Evengers</a>
      </li> -->
      <li class="nav-item dropdown no-arrow">
        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	사용자메뉴
          <i class="fas fa-user-circle fa-fw"></i>
        </a>
        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
          <a class="dropdown-item" href="./">홈</a>
          <a class="dropdown-item" href="./ceoMyPage">마이페이지</a>
          <a class="dropdown-item" href="./logout">로그아웃</a>
          <!-- <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">로그아웃</a> -->
        </div>
      </li>
    </ul>

  </nav>

	<div id="wrapper">

		<!-- Sidebar -->
		<ul class="sidebar navbar-nav">
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <span>인사관리</span></a>
				<div class="dropdown-menu" aria-labelledby="pagesDropdown">
					<a class="dropdown-item" href="javascript:Ajax_forward('performManage')">사원목록</a>
					<a class="dropdown-item" href="javascript:void(0);" onclick="Ajax_forward('perform')">사원등록</a> 
					<!-- <a class="dropdown-item" href="javascript:Ajax_forward('perform')">사원등록</a>  -->
					<a class="dropdown-item" href="javascript:Ajax_forward('manageDeptPosition')">직책,부서 관리</a>
				</div></li>
			<li class="nav-item">
				<a class="nav-link" href="javascript:Ajax_forward('scheduleManage')"> 
					<span>일정관리</span></a>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <span>회계관리</span></a>
				<div class="dropdown-menu" aria-labelledby="pagesDropdown">
					<a class="dropdown-item" href="javascript:Ajax_forward('salaryManage')">급여관리</a> 
					<a class="dropdown-item" href="javascript:Ajax_forward('accountingManage')">정산</a>
					<a class="dropdown-item" href="javascript:Ajax_forward('showRevenue')">수익보기</a>
				</div>
			</li>
		</ul>
		<div id="main" class="container">
		
		</div>

		
	</div><!-- /#wrapper -->
	<!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">Ã</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.html">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="${pageContext.request.contextPath}/admin/vendor/jquery/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="${pageContext.request.contextPath}/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Page level plugin JavaScript-->
  <%-- <script src="${pageContext.request.contextPath}/admin/vendor/chart.js/Chart.min.js"></script> --%>
  <script src="${pageContext.request.contextPath}/admin/vendor/datatables/jquery.dataTables.js"></script>
  <script src="${pageContext.request.contextPath}/admin/vendor/datatables/dataTables.bootstrap4.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="${pageContext.request.contextPath}/admin/js/sb-admin.min.js"></script>

  <!-- Demo scripts for this page-->
  <script src="${pageContext.request.contextPath}/admin/js/demo/datatables-demo.js"></script>
  <%-- <script src="${pageContext.request.contextPath}/admin/js/demo/chart-area-demo.js"></script> --%>

</body>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<script>
$(document).ready(function(){
	Ajax_forward('performManage')
})
function Ajax_forward(url){
	$.ajax({
		url:url,
		dataType:"html",
		success:function(page){
			$("#main").html(page);
		},
		error:function(error){
			console.log(error);
		}
	})
}
function execDaumPostCode(){
	new daum.Postcode({
        oncomplete: function(data) {
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
            if(data.userSelectedType === 'R'){
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                document.getElementById("extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
} //end api
</script>
</html>
