<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	#detail {
	position:fixed;
	top: 30px;
	left: 35%;
	width: 750px;
	height: 650px;
	padding: 2px;
	margin-top:-30px;
	margin-left: -150px;
	float:left;
	border: dashed;
	 z-index: 101;
	display: none;
	overflow: auto;
	overflow: scroll;
	background-color: #FFFFFF;
	}


	#detail.open {
		display: block;
	}


</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1 align="center">기업 판매 목록</h1>
	<div id="list"></div>
	
</body>

<script>
$(document).ready(function() {
	getReqList();
});
function getReqList() {
		$.ajax({
		url : "estSell",
		dataType:'json',
		success:function(result) {
		var esList = result['esList'];

		var str = "<table id='esList' border='1' align='center'>";
		for ( var i in esList) {
			str += "<tr>" + "견적 결제 코드 : " + esList[i].estp_code + "<br>"
					+ "총가격 : " + esList[i].estp_total + "<br>"
					+ "결제일 : " + esList[i].estp_payday + "<br>"
					+ "환불 가능일 : " + esList[i].estp_refunddate + "<br></tr></table>"
			}
			str += "<input type='button' onclick=location.href='./' value='홈으로'>"
			$("#list").html(str);
			},
		error : function(error) {
		}
	});
}


</script>
</html>