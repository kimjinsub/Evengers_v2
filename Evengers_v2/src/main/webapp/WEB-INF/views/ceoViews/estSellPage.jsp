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
	<h1 align="center">기업 견적 판매 내역</h1>
	<div id="list"></div>
		<div id="paging" align="center"></div>
	
</body>

<script>
$(document).ready(function() {
	getEstpList(1,10);
});
function getEstpList(pageNum,listCount) {
		$.ajax({
		url : "estSell",
		dataType:'json',
		data : {pageNum : pageNum ,listCount : listCount},
		success:function(result) {
		var esList = result['esList'];
		var paging = result['paging'];
		var imgList = result['imgList'];
		var str = "<table class='table table-striped'id='esList' align='center'>";
		for ( var i in esList) {
			str += "<tr><td>" + "견적 결제 코드 : " + esList[i].estp_code + "<br>"
					+ "총가격 : " + esList[i].estp_total + "<br>"
					+ "결제일 : " + esList[i].estp_payday + "<br>"
					+ "환불 가능일 : " + esList[i].estp_refunddate + "<br>"
					+ "내용 : " + esList[i].estp_contents + "<br></td></tr>"
					//+ "사진 : <img src='upload/estimateImage/" + imgList[i].estpi_sysfilename + "'><br></td></tr>"
					
					}
			str += "<input type='button' onclick=location.href='./' value='홈으로' class='btn btn-outline-primary btn-rounded waves-effect'></table>"
			$("#list").html(str);
			$("#paging").html(paging);
			
			},
		error : function(error) {
		}
	});
}


</script>
</html>