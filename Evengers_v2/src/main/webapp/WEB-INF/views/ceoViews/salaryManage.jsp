<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style>
#inputSalary.open{
	visibility: visible;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<div><input type="month" id="choicedate" name="choicedate"></div>
	<div id="salaryList"></div>
	<div id="success"></div>
</body>
<script>
/* $(document).ready(function(){
	selectSalary();
})  */
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
			alert("급여 입력 성공");
			selectSalary();
		},
		error:function(error){
			console.log(error);
		}
	})
	
}
</script>
</html>