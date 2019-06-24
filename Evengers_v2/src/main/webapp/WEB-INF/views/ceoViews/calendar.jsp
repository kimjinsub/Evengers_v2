<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link type="text/css" rel="stylesheet" 
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
<meta charset="UTF-8">
<title>캘린더 폼</title>
<style>
.scheduleAtag{
	font-weight: 700; font-family: "Nanum Gothic", sans-serif; font-size: 20px;
	text-align: center; color: black; margin:auto;
	
}
#calendar_table td{width: 200px; height: 100px;background-color: #FAFAFA;}
#calendar_table th{width: 200px; height: 50px;background-color: #96a9aa;text-align: center;}
#scheduleToday{
	position: fixed; /* border: 1em solid black; */
	top:50%; left: 50%;
	transform: translate(-40%, -40%);
	width: 80%; text-align: center;
	display: none; background-color: white;
	margin: auto;
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
function Ajax_showScheduleToday(esList,estsList,calDate){
	console.log("esList",esList);//json형식의 json_esList로 넘겼지만 jsp가 배열로 받음
	console.log("estsList",estsList);//json형식의 json_esList로 넘겼지만 jsp가 배열로 받음
	console.log("calDate",calDate);
	var json_esList=JSON.stringify(esList);//다시 json형식으로 바꾼 후 ajax에 넘김
	var json_estsList=JSON.stringify(estsList);//다시 json형식으로 바꾼 후 ajax에 넘김
	console.log("json_esList",json_esList);
	console.log("json_estsList",json_estsList);
	$.ajax({
		url:"showScheduleToday",
		data:{json_esList:json_esList,json_estsList:json_estsList,calDate:calDate},
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