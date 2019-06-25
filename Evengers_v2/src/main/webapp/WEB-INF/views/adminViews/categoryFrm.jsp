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
	font-family: "Nanum Gothic", sans-serif; font-size: 30px;
}
#categories{
	font-family: "Nanum Gothic", sans-serif; font-size: 20px;
	text-align: center; vertical-align: middle;
}
input[type=text]{
  width: 30%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  font-family: "Nanum Gothic", sans-serif; font-size: 20px;
}
#addCategory{
	padding:15px 15px;
}
</style>
</head>
<body>
<jsp:include page="../header.jsp"/>
<div id="categorySetting">
	<h2 style="margin-bottom: 5%;">카테고리 설정</h2>
	<table class="table table-condensed" id="categories"></table>
	<input type="text" class="" id="inserted"/>
	<button class="btn btn-success" id="addCategory">카테고리 추가</button>
</div>
</body>
<script>
$(document).ready(function(){
	getCategoryList();
});
function getCategoryList(){
	$.ajax({
		url:"getCategoryList",
		dataType:"json",
		success:function(result){
			var str="";
			for(var i in result){
				str+="<tr>"
					+"	<td>"+result[i].ec_name+"</td>"
					+"	<td>"
					+"		<button class='deleteCategory btn btn-danger' "
					+"		onclick='deleteCategory(\""+result[i].ec_name+"\")'>삭제</button>"
					+"	</td>";
					+"</tr>";
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