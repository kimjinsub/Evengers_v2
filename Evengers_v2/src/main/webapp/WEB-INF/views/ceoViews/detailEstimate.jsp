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
h3 {
	text-align: center;
}

table {
	float: left;
}
</style>


<body>
<div id="pageDown"  onclick="reset()">X</div>
	<a href="EstimateDelete?est_code=${estimate.est_code}">삭제</a>
	<h3>상세 견적서</h3>
	<table class='table table-striped'  border='1'>
		<tr height="40">
			<td bgcolor="black" style="color:whtie;" align="center">글번호</td>
			<td colspan="5">${estimate.est_code}</td>
		</tr>
		<tr height="40">
			<td bgcolor="black" style="color:whtie;"align="center">문의자</td>
			<td width="200">${request.m_id}</td>
			<td bgcolor="black" style="color:whtie;" align="center">견적자</td>
			<td width="200">${estimate.c_id}</td>
		</tr>
		<tr height="40">
			<td bgcolor="black" style="color:whtie;" align="center">제목</td>
			<td colspan="5">${request.req_title}</td>
		</tr>
		<tr height="170">
			<td bgcolor="black" style="color:whtie;" align="center">내용</td>
			<td colspan="5">${estimate.est_contents}</td>
		</tr>
		<tr height="40">
			<td bgcolor="black" style="color:whtie;" align="center">승일가능일</td>
			<td width="200">${ok}까지가능
			<td bgcolor="black" style="color:whtie;" align="center">환불가능일</td>
			<td width="200">${refundable}까지가능
		</tr>
		<tr>
		<tr>
			<td bgcolor="black" style="color:whtie;">첨부파일</td>
			<td><c:set var="file" value="${estimateImage}" /> <c:if
					test="${empty file}">
				첨부된 파일이 없습니다.
			</c:if> <c:if test="${!empty file}">
						<a
							href="download2?oriFileName=${file.esti_orifilename}
										&sysFileName=${file.esti_sysfilename}">
							${file.esti_orifilename}</a>
				</c:if></td>
				<td>${msg}</td>
		</tr>
		 
		<tr id="member">
			<td><input type="button" value="승인" 
				onclick="location.href='estPay?est_code=${estimate.est_code}'"></td>
			<td><input type="button" value="거절" 
				onclick="location.href='receivedEstDenial?est_code=${estimate.est_code}'"></td>
			
		</tr>
		<tr>
	</table>
	

</body>
<script>
	$(document).ready(function() {
		msgAlert();
		checkCeo();
	});
	function msgAlert() {
		console.log('${msg}')
		if ('${msg}' == '결제성공') {
			alert("결제성공!");
		} else if ('${msg}' == '결제실패') {
			alert("결제실패!");
		}
	}
	
	function checkCeo(){
		if("${check}"==1){
			$("#member").hide();
		}
	}
	function reset() {
		if ($layerWindows.hasClass('open')) {
			$layerWindows.removeClass('open');
		}
	}

	
	
</script>

</html>