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
<style >

.btn {
	position: relative;
	bottom:;
	display: block;
	width: 200px;
	height: 40px;
	border: 1px #3399dd solid;;
	margin: 15px auto;
	background-color: #66aaff;
	text-align: center;
	cursor: pointer;
	color: #333;
	transition: all 0.9s, color 0.3;
}

.btn:hover {
	color: #fff;
}

.hover3:hover {
	box-shadow: 0 80px 0 0 rgba(0, 0, 0, 0.25) inset, 0 -80px 0 0
		rgba(0, 0, 0, 0.25) inset;
}
#eb_Info{
	position: relative;
	left:50%;
	bottom:50%;
	float: left;
	font-size: 28px;
}
</style>
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
			swal({
				title: "Success!",
				text:  "구매 되었습니다.",
				icon: "success",
			});
			$("#ebInfoZone").html(result);
			//$("#ebInfo").html(result);
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
		var e_code="${eb.e_code}";
		$.ajax({
			type:"post",
			url:"rejectBuy",
			data:{eb_code:"${eb.eb_code}"},
			dataType:"html",
			success:function(data){
				swal({
					title: "Success!",
					text:  "취소 성공",
					icon: "success",
				})
				. then (function () { 
					window.location.href = "evtInfo?e_code=" + e_code;
				});
				console.log(data);
			},
			error:function(error){
				swal({
		            title: "Warning!",
		             text:  "취소 실패",
		             icon: "warning",
				  });
				console.log(error);
			}
		})
		
	});
	
</script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</html>