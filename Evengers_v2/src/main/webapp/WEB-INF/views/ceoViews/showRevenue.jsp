<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style>
.table{
	text-align: center;
}
</style>
</head>

<body>
<h2>수익보기</h2>
	<input type="month" id="choiceMonth" name="choiceMonth">
	
	<div id="show"></div>
	
	
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