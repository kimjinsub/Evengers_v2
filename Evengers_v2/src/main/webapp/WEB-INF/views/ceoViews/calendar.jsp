<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link type="text/css" rel="stylesheet" 
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>캘린더 폼</title>
<style>
#calendar_table td{width: 200px; height: 100px;}
#calendar_table th{width: 200px; height: 50px;background-color: #96a9aa;text-align: center;}
#scheduleToday{
	border: 2px solid black; position: fixed;
	top:50%; left: 20%;
	width: 60%; height: 40%; text-align: center;
	display: none; background-color: white;
}
#scheduleToday.show{display: inline;}
#schedule_table td{width: 200px; height: 100px;}
#schedule_table th{width: 200px; height: 50px;background-color: #96a9aa;text-align: center;}
</style>
</head>
<body>
${calendar}
<div id="scheduleToday"></div>
</body>
<script>
function Ajax_showScheduleToday(esList,calDate){
	console.log("esList",esList);//json형식의 json_esList로 넘겼지만 jsp가 배열로 받음
	console.log("calDate",calDate);
	var json_esList=JSON.stringify(esList);//다시 json형식으로 바꾼 후 ajax에 넘김
	console.log("json_esList",json_esList);
	$.ajax({
		url:"showScheduleToday",
		data:{json_esList:json_esList,calDate:calDate},
		dataType:"html",
		success:function(result){
			$("#scheduleToday").html(result);
			$("#scheduleToday").addClass("show");
		},
		error:function(error){
			console.log(error);
		}
	})
}
function hideScheduleToday(){
	$("#scheduleToday").removeClass("show");
}
</script>
</html>