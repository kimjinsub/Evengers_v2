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
#dayWrap,#deptWrap{display: inline-block;}
#dayWrap *{display: inline-block;}
#year{background: white;}
#past,#future{cursor: pointer;}
#calendar_table td{width: 200px; height: 100px;}
#calendar_table th{width: 200px; height: 50px;background-color: #96a9aa;text-align: center;}
</style>
</head>
<body>
<div id="Wrap">
<div id="dayWrap">
	${year} 
	${month}
</div>
<div id="deptWrap"></div>
<div id="calendar">${calendar}</div>
</div>
</body>
<script>
$(document).ready(function(){
	getDeptList();
})
function getDeptList(){
	$.ajax({
		url:"getDeptList",
		dataType:"json",
		success:function(result){
			console.log(result);
			var str="<select>";
			for(var i in result){
				str+="<option value='"+result[i].dept_code+"'>"+result[i].dept_name+"</option>"
			}
			str+="</select>"
			$("#deptWrap").html(str);
		},
		error:function(error){
			console.log(error);
		}
	})
};
$("#past").click(function(){
	var y=$("#year").val();
	var year=Number(y)-Number(1);
	$("#year").val(year);
	showCalendar();
})
$("#future").click(function(){
	var y=$("#year").val();
	var year=Number(y)+Number(1);
	$("#year").val(year);
	showCalendar();
})
$("#month").change(function(){
	showCalendar();
})
function showCalendar(){
	var year=$("#year").val();
	console.log("year=",year);
	var month=$("#month").val();
	var str_date=year+"-"+month;
	var date=new Date(str_date);
	$.ajax({
		url:"calendar",
		data:{date:date},
		dataType:"html",
		success:function(page){
			$("#Wrap").html(page);
		},
		error:function(error){
			console.log(error);
		}
	})
}
</script>
</html>