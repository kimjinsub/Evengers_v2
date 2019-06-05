<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
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
	<h2>카테고리 설정</h2>
	<div id="categories"></div>
	
	<input type="text" id="inserted"/><button id="addCategory">카테고리 추가</button>
	<div id="selectZone"></div>
	
	<form action="carryOption" method="post" enctype="multipart/form-data">
		<div id="options">
			<input class="option_name" type="text" placeholder="옵션명"/>
			<input class="option_price" type="number" placeholder="가격"/><br/>
		</div>
		<input type="button" onclick="addOption()" value="옵션추가"/><br>
		<input type="button" onclick="confirm()" value="옵션완료"/><br>
		<button>보내기</button>
	</form>
</body>
<script>
function addOption(){
	$("#options").append('<input class="option_name" type="text" placeholder="옵션명"/>'
			+'<input class="option_price" type="number" placeholder="가격"/><br/>');
}
function confirm(){
	var str="";
	var num="";
	$(".option_name").each(function(){
		str+=$(this).val()+",";
	})
	$(".option_price").each(function(){
		num+=$(this).val()+",";
	})
	console.log(str);
	console.log(num);
	$("#options").append('<input type="hidden" name="eo_name"/>'
			+'<input type="hidden" name="eo_price"/>');
	$("input[name=eo_name]").val(str);
	$("input[name=eo_price]").val(num);
	console.log($("input[name=eo_name]").val());
	console.log($("input[name=eo_price]").val());
}

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