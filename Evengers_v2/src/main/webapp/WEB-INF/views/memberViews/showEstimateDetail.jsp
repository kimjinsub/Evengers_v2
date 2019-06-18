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
<body>
<h3>문의 내용</h3>
	<table border='1'>
		<tr height="40">
			<td bgcolor="blue" align="center">견적 상품명</td>
			<td colspan="5">${req.req_title}</td>
		</tr>
		<tr height="40">
			<td bgcolor="blue" align="center">문의자</td>
			<td width="200">${req.m_id}님</td>
			<td bgcolor="blue" align="center">견적자</td>
			<td width="200">${estp.c_id}님</td>
		</tr>
		<tr height="40">
			<td bgcolor="blue" align="center">총가격</td>
			<td width="200">${estp.estp_total}원</td>
			<td bgcolor="blue" align="center">결제날짜</td>
			<td width="200">${estp.estp_payday}</td>
		</tr>
		<tr height="40">
			<td bgcolor="blue" align="center">환불가능일</td>
			<td width="200">${refundable}까지</td>
			<td bgcolor="blue" align="center">상태</td>
			<td width="200">${refundstate}</td>
		</tr>
		<tr height="200">
			<td bgcolor="blue" align="center">내용</td>
			<td colspan="5">${estp.estp_contents}</td>
		</tr>
			<tr>
			<th>첨부파일</th>
			<td><c:set var="file" value= "${estpi}" /> 
				<c:if test="${empty file}">
				첨부된 파일이 없습니다.
			</c:if> 
			<c:if test="${!empty file}">
						<a href="download3?oriFileName=${file.estpi_orifilename}
										&sysFileName=${file.estpi_sysfilename}">
							${file.estpi_orifilename}
						</a>
			</c:if>
			</td>
		</tr>
	</table>
 <a  href="estpRefundRequest?estp_code=${estp.estp_code}" id="refundButton">환불하기</a>
  <div id="msg">${msg}</div>
</body>
<script>

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

</script>
</html>