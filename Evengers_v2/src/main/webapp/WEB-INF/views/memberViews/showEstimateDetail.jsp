<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
#pageDown {
	text-align: right;
	float: right;
	position: fixed;
	margin-left: 710px;
	font-size: x-large;
	cursor: pointer;
}
#msg{
color:red;
font-size: x-large;
visibility: hidden;
}
#msg.show{
visibility: visible;
}
#refundButton{
visibility: hidden;
}

#refundButton.show{
visibility: visible;
}

</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<body>
<div id="pageDown"  onclick="reset()">X</div>
<h3>견적 결제 상세 내용</h3>
	<table class='table table-striped' border= '1'>
		<tr height="40">
			<td bgcolor='black' style="color:white;" align="center">견적 상품명</td>
			<td style="color:black;" colspan="5">${req.req_title}</td>
		</tr>
		<tr height="40">
			<td bgcolor='black' style="color:white;" align="center">문의자</td>
			<td style="color:black;" width="200">${req.m_id}님</td>
			<td bgcolor='black' style="color:white;" align="center">견적자</td>
			<td style="color:black;" width="200">${estp.c_id}님</td>
		</tr>
		<tr height="40">
			<td bgcolor='black' style="color:white;" align="center">총가격</td>
			<td style="color:black;" width="200">${estp.estp_total}원</td>
			<td  bgcolor='black' style="color:white;" align="center">결제날짜</td>
			<td style="color:black;" width="200">${payday}</td>
		</tr>
		<tr height="40">
			<td  bgcolor='black' style="color:white;" align="center">환불가능일</td>
			<td style="color:black;" width="200">${refundable}까지</td>
			<td   bgcolor='black' style="color:white;" align="center">상태</td>
			<td style="color:black;" width="200">${refundstate}</td>
		</tr>
		<tr height="200">
			<td  bgcolor='black' style="color:white;"  align="center">내용</td>
			<td style="color:black;" colspan="5">${estp.estp_contents}</td>
		</tr>
			<tr>
			<td bgcolor='black' style="color:white;" align='center'>첨부파일</td>
			<td style="color:black;" ><c:set var="file" value= "${estpi}" /> 
				<c:if test="${empty file}">
				첨부된 파일이 없습니다.
			</c:if> 
			<c:if test="${!empty file}">
						<a href="download2?oriFileName=${file.estpi_orifilename}
										&sysFileName=${file.estpi_sysfilename}">
							${file.estpi_orifilename}
						</a>
			</c:if>
			</td>
		</tr>
	</table>
 <button id="refundButton">환불하기</button>
  <div id="msg">${msg}</div>
</body>
<script>
$("#refundButton").click(function(){
	var estp_code="${estp.estp_code}";
	$.ajax({
		url:"estpRefundRequest",
		data:{estp_code:estp_code},
		dataType:"html",
		success:function(page){
			swal({
	            title: "Good!",
	             text: "환불 신청이되었습니다!",
	             icon: "success",
	  });

			location.href = "javascript:Ajax_forward('estimatePayList')";
		},
		error:function(error){
			swal({
	            title: "Sorry!",
	             text: "환불신청을 실패하였습니다!",
	             icon: "warning",
	  });
		}
	})
})
$(document).ready(function() {
	msgView();
});
function msgView(){
	console.log('${msg}')
	if('${msg}'=='환불 불가능'){
		$("#refundButton").removeClass("show");
		$("#msg").addClass("show");
	}else{
		$("#refundButton").addClass("show");
		$("#msg").addClass("show");
	}
	if('${refundstate}'=='환불중'){
		$("#refundButton").removeClass("show");
		$("#msg").removeClass("show");
	}else if('${refundstate}'=='환불완료'){
		$("#refundButton").removeClass("show");
		$("#msg").removeClass("show");
	}
}
function reset() {
	if ($layerWindows.hasClass('open')) {
		$layerWindows.removeClass('open');
	}
}

</script>
</html>