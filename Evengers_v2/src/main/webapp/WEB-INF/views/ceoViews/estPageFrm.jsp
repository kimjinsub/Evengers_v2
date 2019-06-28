<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<style>
#estTable{
	align-content: center;
	margin-top: 100px;
}
.form-control{
	width:30%;
}
#h2{
	font-family: 'Nanum Gothic', sans-serif;
}
.card{
	margin: auto;
	width:30%;
}
</style>
</head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/all.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js" /></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/all.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js" /></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<body>
  <jsp:include page="../header.jsp"/>
  <div class="card">
		<div class="card-body px-lg-5 pt-0">
  <form action="/" name="estFrm" id="estFrm" method="post" enctype="multipart/form-data" onsubmit="return est()">
  <div id="estTable">
  <h2 align="center" id="h2"><i class="fas fa-edit"></i>견적 작성</h2>
  <div class="md-form mt-3">
		견적제목:<input type="text" name="est_title" id="est_title"
		value="${request.req_title}" class="form-control">
  </div>
  <div class="md-form mt-3">
		견적내용:<textarea rows="15" cols="30" name="est_contents" id="est_contents" class="form-control"></textarea>
  </div>
  <div class="input-group">
   	<div class="input-group-prepend">
   	<span class="input-group-text" id="inputGroupFileAddon01">Upload</span>
   	</div>
   	<div class="custom-file">
   	<input type="file" name="est_files" id="est_files" multiple class="form-control">
    </div>
  </div>
  <div class="md-form mt-3">
		총가격:<input type="number" name="est_total" id="est_total" class="form-control">
  </div>
  <div class="md-form mt-3">
		승인가능일:<input type="number" name="est_okDate" id="est_okDate" class="form-control">
  </div>
  <div class="md-form mt-3">
		환불가능일:<input type="number" name="est_refundDate" id="est_refundDate" class="form-control">
  </div>
  </div><br>
  <div align="center">
  <input type="button" onclick="formData()" value="견적서 보내기" class="btn btn-outline-primary btn-rounded waves-effect">
 <input type="reset" id="rs" value="취소" class="btn btn-outline-primary btn-rounded waves-effect">
 </div>
  </form>
  </div>
  </div>
</body>
<script>
$("#est_okDate").change(function() {
	effectiveness();
})
$("#est_refundDate").change(function() {
	refundEffectiveness();
})

function refundEffectiveness() {
	var refundDate = $("#est_refundDate").val();
	if(refundDate<0){
		alert("불가능합니다");
		var input = document.getElementById("est_refundDate");
		input.value = null;
	}
	  $.ajax({
		url :"refundEffectiveness",
		data : {
			refundDate:refundDate,
			req_code:"${req_code}"
		},
		dataType : "text",
		success : function(result) {
			if(result!="가능"){
				swal({
		            title: "No!",
		             text: "가능한 날짜가 아닙니다!",
		             icon: "warning",
		  });
				var input = document.getElementById("est_refundDate");
				input.value = null;
			}
		},
		error : function(error) {
			console.log(error);
		}
	})
} 

function effectiveness() {
	var okDate = $("#est_okDate").val();
	var refundDate = $("#est_refundDate").val();
	if(okDate<0){
		swal({
            title: "No!",
             text: "가능한 날짜가 아닙니다!",
             icon: "warning",
  });
		var input = document.getElementById("est_okDate");
		input.value = null;
	}
	  $.ajax({
		url : "estEffectiveness",
		data : {
			okDate:okDate,
			req_code:"${req_code}"
		},
		dataType : "text",
		success : function(result) {
			$("#msg").html(result);
			if(result!="가능"){
				swal({
		            title: "No!",
		             text: "가능한 날짜가 아닙니다!",
		             icon: "warning",
		  });
				var input = document.getElementById("est_okDate");
				input.value = null;
			}
		},
		error : function(error) {
			console.log(error);
		}
	})
} 

function est(){
	return true;
}
function formData(){
	est();
	var $obj=$("#est_files");
	var formData=new FormData();
	formData.append("est_title",$("#est_title").val());
	formData.append("est_contents",$("#est_contents").val());
	formData.append("est_total",$("#est_total").val());//0,1
	formData.append("est_okDate",$("#est_okDate").val());//0,1
	formData.append("est_refundDate",$("#est_refundDate").val());//0,1
	formData.append("req_code","${req_code}");
	var files=$obj[0].files;//배열로 파일정보를 반환
	for(var i=0;i<files.length;i++){
		formData.append("est_files",files[i]);
	}
	
	$.ajax({
		type:"post",
		url:"estInsert",
		data:formData,
		processData:false,
		//application/x-www-form-urlencoded(쿼리스트리형식) 처리금지,,데이터 안까게하기
		
		contentType:false,
		//contentType:"application/json" json 쓸때 이렇게 했던거 처럼 multipart의 경우 false로 해야됨
		dataType:"html",//html은 생략가능
		success:function(data){
			console.log(data);
			swal({
	            title: "Good!",
	             text: "견적서 전송 완료!",
	             icon: "success",
	  })
			   . then (function () { 
	               window.location.href = "./";
	            });
		},
		error:function(error){
			swal({
	            title: "Sorry!",
	             text: "견적서 전송 실패!",
	             icon: "warning",
	  });
			console.log(error)
		} 
	});
}
	</script>
</html>