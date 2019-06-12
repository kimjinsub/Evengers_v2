<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매페이지</title>
<style>
</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>
${makeHtml_evtBuyInfo}
</body>
<script>
$(document).ready(function(){
});
$("#payBtn").click(function(){
	var eb_code="${eb.eb_code}";
	$.ajax({
		url:"evtPay",
		data:{eb_code:eb_code},
		dataType:"text",
		success:function(result){
			console.log(result);
			memberEvtPay(result);
		},
		error:function(error){
			console.log(error);
		}
	}) 
});
function memberEvtPay(ep_code){
	$.ajax({
		method: "post",
		url:"memberEvtPay",
		data:{ep_code:ep_code},
		dataType:"html",
		success:function(result){
			$("body").html(result);
		},
		error:function(error){
			console.log(error);
		}
	})
}

$("#rejectBtn").click(function(){
	/* 	var e = "${e}";
		var eb = "${eb}"; 
		var bs = "${bs}"; */
		
		$.ajax({
			type:"post",
			url:"rejectBuy",
			data:{eb_code:"${eb.eb_code}"},
			dataType:"html",
			success:function(data){
				alert("취소 성공")
				console.log(data);
				location.href="./";
			},
			error:function(error){
				alert("취소 실패");
				console.log(error);
			}
		})
		
	});
</script>
</html>