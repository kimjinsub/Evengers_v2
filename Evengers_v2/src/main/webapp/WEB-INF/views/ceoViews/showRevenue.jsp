<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<style>
.table{
	text-align: center;
}
#h2{
	margin-top: 2%;
	font-family: 'Nanum Gothic', sans-serif;
}
.form-control{
	width:30%;
}
</style>
</head>

<body>
<div id="wrap" align="center">
<h2 id="h2" align="center">수익보기</h2>
	<div class="md-form">
	<label for="inputMDEx">Choose your date</label>
	<input type="month" id="choiceMonth" name="choiceMonth" class="form-control">
	</div><br>
	<div id="show"></div>
	</div>
	
</body>
<script>
/* 현재 달 기본 값 입력 */
document.getElementById('choiceMonth').value= new Date().toISOString().slice(0, 7);

$(document).ready(function(){
	showRevenue();
}) 
$("input[type=month]").change(function() {
	showRevenue();	
})

function showRevenue(){
	var choicedate = $("input[type=month]").val();
	
	choicedate = new Date(choicedate);
	$.ajax({
		url:"revenueList",
		data:{choicedate:choicedate},
		dateType:"html",
		success:function(result){
			$("#show").html(result);
			console.log(result);
		},
		error:function(error){
			console.log(error);
		}
	})
}
</script>
</html>