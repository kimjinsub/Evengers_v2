<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
#inputSalary.open{
	visibility: visible;
}
.form-control{
	width:30%;
}
#h2{
	font-family: 'Nanum Gothic', sans-serif;
}

</style>
<title>Insert title here</title>
</head>
<body>
<div id="wrap" align="center">
	<h2 id="h2">급여관리</h2>
	<div class="md-form">
  <label for="inputMDEx">Choose your date</label>
  <input type="month" id="choicedate" name="choicedate" class="form-control">
	</div><br>
	<div id="salaryList"></div>
	<div id="success"></div>
</div>
</body>
<script>
 $(document).ready(function(){
	selectSalary();
})
document.getElementById('choicedate').value= new Date().toISOString().slice(0, 7);
$("input[type=month]").change(function(){
	selectSalary();
})
function selectSalary(){
	/* 선택한 날짜 */
	var date = $("input[type=month]").val();
	date = new Date(date);
	console.log("date="+date);
	 $.ajax({
		url:"selectSalary",
		data:{date:date},
		dataType:"html",
		success:function(result){
			$("#salaryList").html(result);
			console.log(result);
		},
		error:function(error){
			console.log(error);
		}
	})
} 
function inputSalary(){
	$('#inputbtn').addClass("open");
	
	var date = $("input[type=month]").val();
	date = new Date(date);
	console.log("date="+date);
	
	$.ajax({
		url:"inputSalary",
		data:{date:date},
		dataType:"html",
		success:function(result){
			swal({
				title : "Success!",
				text : "급여를 입력하였습니다.",
				icon : "success",
			});
			selectSalary();
		},
		error:function(error){
			console.log(error);
		}
	})
}
</script>
</html>