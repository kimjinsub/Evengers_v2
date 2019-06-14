<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style>
.payList{
	border: 1px solid black;
	display: block;
	width: 70%; height: 350px;
	overflow: auto; margin: auto;
}
</style>
</head>
<body>
${makeHtml_memberPayList}
</body>
<script >

$(document).ready(function() {
	$('.rBtnChk_epCode').each(function() {
		var ep_code = $(this).attr("name");
		console.log("ep_code" + ep_code);
		 $.ajax({
			url : "rBtnChk",
			data : {
				ep_code: ep_code
			},
			dataType : "text",
			success : function(result) {
				console.log(result);
				//alert("체크");
				if(result=="등록 안됨"){
					$('.showBtn').show();
				}
				else if(result=="환불중"){
					$('.showBtn').hide();
					$('div[id="' + ep_code + '"]').hide();
					$('.ing').show();
				}else if(result=="환불거부"){
					$('.showBtn').hide();
					$('div[id="' + ep_code + '"]').hide();
					$('.no').show();
				}else{//환불 완료
					$('.showBtn').hide();
					$('div[id="' + ep_code + '"]').hide();
					$('.yes').show();
				}
			},
			error : function(error) {
				console.log(error);
			}
		}) 
	})
})  
	$('.ep_code').each(function() {
		var ep_code = $(this).attr("name");
		$(this).click(function() {
			console.log("ep" + ep_code);

			$.ajax({
				url : "refundEvt",
				data : {
					ep_code : ep_code,
				},
				dataType : "text",
				success : function(result) {
					console.log(result);
					alert(result);
					location.href = "./memberMyPage";
				},
				error : function(error) {
					console.log(error);
				}
			})
		})
	})
$('.ing').hide();
$('.no').hide();
$('.yes').hide();
</script>
</html>