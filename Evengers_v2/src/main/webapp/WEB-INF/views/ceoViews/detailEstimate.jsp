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

.ok {
	background: #1AAB8A;
	color: #fff;
	border: none;
	position: relative;
	height: 60px;
	font-size: 1.6em;
	padding: 0 2em;
	cursor: pointer;
	transition: 800ms ease all;
	outline: none;
}

.ok:hover {
	background: #fff;
	color: #1AAB8A;
}

.ok:before, .ok:after {
	content: '';
	position: absolute;
	top: 0;
	right: 0;
	height: 2px;
	width: 0;
	background: #1AAB8A;
	transition: 400ms ease all;
}

.ok:after {
	right: inherit;
	top: inherit;
	left: 0;
	bottom: 0;
}

.ok:hover:before, .ok:hover:after {
	width: 100%;
	transition: 800ms ease all;
}

.button_base {
	margin: 0;
	border: 0;
	font-size: 18px;
	width: 180px;
	height: 40px;
	text-align: center;
	box-sizing: border-box;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	-webkit-user-select: none;
	cursor: default;
}

.button_base:hover {
	cursor: pointer;
}
#member{
margin-left: 180px;
}

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


</style>


<body>
<div id="pageDown"  onclick="reset()">X</div>
	<a href="EstimateDelete?est_code=${estimate.est_code}">삭제</a>
	<h3>상세 견적서</h3>
	<table class='table table-striped' >
		<tr height="40">
			<td bgcolor="black" style="color:white;" align="center">글번호</td>
			<td style="color:black;"  colspan="5">${estimate.est_code}</td>
		</tr>
		<tr height="40">
			<td bgcolor="black" style="color:white;"align="center">문의자</td>
			<td style="color:black;" width="200">${request.m_id}</td>
			<td bgcolor="black" style="color:white;" align="center">견적자</td>
			<td style="color:black;" width="200">${estimate.c_id}</td>
		</tr>
		<tr height="40">
			<td bgcolor="black" style="color:white;" align="center">제목</td>
			<td style="color:black;" colspan="5">${request.req_title}</td>
		</tr>
		<tr height="170">
			<td bgcolor="black" style="color:white;" align="center">내용</td>
			<td style="color:black;" colspan="5">${estimate.est_contents}</td>
		</tr>
		<tr height="40">
			<td bgcolor="black" style="color:white;" align="center">승일가능일</td>
			<td style="color:black;" width="200">${ok}까지가능
			<td bgcolor="black" style="color:white;" align="center">환불가능일</td>
			<td style="color:black;" width="200">${refundable}까지가능
		</tr>
		<tr>
		<tr>
			<td bgcolor="black" style="color:white;">첨부파일</td>
			<td style="color:black;"><c:set var="file" value="${estimateImage}" /> <c:if
					test="${empty file}">
				첨부된 파일이 없습니다.
			</c:if> <c:if test="${!empty file}">
						<a
							href="download2?oriFileName=${file.esti_orifilename}
										&sysFileName=${file.esti_sysfilename}">
							${file.esti_orifilename}</a>
				</c:if></td>
				<td style="color:black;" >${msg}</td>
		</tr>
		
			
	</table>
	<%-- 
		 <div id="member">
			<button class="ok" value="승인" onclick="estPay(${estimate.est_code})">승인</button>
			<button class="ok" value="거절" onclick="receivedEstDenial(${estimate.est_code})">거절</button>
		</div>
		
		 --%>
		  <div id="member">
			<button class="ok" value="승인" onclick="location.href='estPay?est_code=${estimate.est_code}'">승인</button>
			<button class="ok" value="거절" onclick="location.href='receivedEstDenial?est_code=${estimate.est_code}'">거절</button>
		</div>
		 
	
	

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