<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<meta charset="UTF-8">
<style>
.deleteCategory{
	border: 1px solid black;
	cursor: pointer;
	size: 3px;
}
</style>
</head>
<body>
<jsp:include page="../header.jsp"/>
<br/>
<br/>
<br/>
	<h2>카테고리 설정</h2>
	<div id="categories"></div>
	
	<input type="text" id="inserted"/><button id="addCategory">카테고리 추가</button>
	<div id="selectZone"></div>
	

</body>
<script>
$(document).ready(function(){
	getCategoryList();
	selectCategory();
});
function getCategoryList(){
	$.ajax({
		url:"getCategoryList",
		dataType:"json",
		success:function(result){
			console.log(result);
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
			console.log(result);
			getCategoryList();
			$("#inserted").val("");
			selectCategory();
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
			console.log(result);
			getCategoryList();
			selectCategory();
		},
		error:function(error){
			console.log(error);
		}
	})
};
function selectCategory(){
	$.ajax({
		url:"selectCategory",
		dataType:"json",
		success:function(result){
			console.log(result);
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
};
</script>
</html>