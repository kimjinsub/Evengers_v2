<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
 <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
<meta charset="UTF-8">
<style>
.deleteCategory{
	border: 1px solid black;
	cursor: pointer;
	size: 3px;
}
#categorySetting{
	margin: auto; display:inline-block; 
	width: 40%; height: 40%;
	position:absolute;
	overflow: auto; text-align:center;
    top:50%; left:50%;
    transform: translate(-50%, -50%);
}
body{
	font-family: "Nanum Gothic", sans-serif; font-size: 23px;
}
#categorySetting,#categorySetting *,.font{
	font-family: "Nanum Gothic", sans-serif; font-size: 23px;
}
	
</style>
</head>
<body>
<jsp:include page="../header.jsp"/>
<div id="categorySetting">
	<h2 style="text-decoration: underline; margin-bottom: 5%;">카테고리 설정</h2>
	<div class="fontSetting" id="categories"></div>
	<input type="text" id="inserted"/><button class="addBtn glyphicon" id="addCategory"><p class="font">카테고리 추가</p></button>
	<!-- <div id="selectZone"></div> -->
</div>
<div id="datepicker" style="border:1px solid black; width:300px; height:300px;
position:fixed;top:70%;left:70%;"></div>

</body>
<script>
function test(){
	var yyyy=$("#datepicker #yyyy").val();
	console.log("yyyy:",yyyy);
	var MM=$("#datepicker #MM").val();
	console.log("MM:",MM);
	var dd=$("#datepicker #dd").val();
	console.log("dd:",dd);
	var hh=$("#datepicker #hh").val();
	console.log("hh:",hh);
	var mm=$("#datepicker #mm").val();
	console.log("mm:",mm);
}
function datePicker(){
	var date = new Date();
	$.ajax({
		url:"datePicker",
		data:{date:date,type:"yyyyMMddhhmm"},
		dataType:"text",
		success:function(result){
			$("#datepicker").html(result);
			$("#datepicker").append("<button onclick='test()'>확인하기</button>");
		},
		error:function(error){
			console.log(error);
		}
	})
}
$(document).ready(function(){
	getCategoryList();
	datePicker();
	//selectCategory();
});
function getCategoryList(){
	$.ajax({
		url:"getCategoryList",
		dataType:"json",
		success:function(result){
			var str="";
			for(var i in result){
				str+="<div>"+result[i].ec_name
					+"<button class='deleteCategory'"
					+" onclick='deleteCategory(\""+result[i].ec_name+"\")'>삭제</button></div>";
			}
			$("#categories").html(str);
		},
		error:function(error){
			console.log(error);
		}
	})
};
$("#addCategory").click(function(){
	var ec_name=$("#inserted").val();
	$.ajax({
		url:"addCategory",
		data:{ec_name:ec_name},
		dataType:"text",
		success:function(result){
			getCategoryList();
			$("#inserted").val("");
			//selectCategory();
		},
		error:function(error){
			console.log(error);
		}
	})
});
function deleteCategory(ec_name){
	$.ajax({
		url:"deleteCategory",
		data:{ec_name:ec_name},
		dataType:"text",
		success:function(result){
			getCategoryList();
			//selectCategory();
		},
		error:function(error){
			console.log(error);
		}
	})
};
/* function selectCategory(){
	$.ajax({
		url:"selectCategory",
		dataType:"json",
		success:function(result){
			var str="";
			str+="<select name='ec_name'><option selected='selected'>선택하세요</option>";
			for(var i in result){
				str+="<option value='"+result[i].ec_name+"'>"+result[i].ec_name+"</option>";
			}
			str+="</select>";
			$("#selectZone").html(str);
		},
		error:function(error){
			console.log(error);
		}
	})
}; */
</script>
</html>