<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style >
.receivedEstListBtn {
	display: inline;
	width: 300px;
	height: 300px;
	border: 1px solid skyblue;
	background-color: #F2CB61;
}
</style>
</head>
<body>

<div id="receivedEstList"class="receivedEstListBtn">받은견적</div>
<div id="myReqList"class="receivedEstListBtn">요청서</div>
<div id="receivedMain"></div>

</body>
<script >
$("#receivedMain").load("receivedEstList");

$('#receivedEstList').click(function(){
	$.ajax({
		url:"receivedEstList",
		dataType:"html",
		success:function(result){
			$("#receivedMain").html(result);
		},
		error:function(result){
			console.log(error);
		}
	})
});
$('#myReqList').click(function(){
	$.ajax({
		url:"myReqList",
		dataType:"html",
		success:function(result){
			$("#receivedMain").html(result);
		},
		error:function(result){
			console.log(error);
		}
	})
});
</script>
</html>