<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta charset="UTF-8">


<title>Insert title here</title>
<style>

#pageDown {
	text-align: right;
	float: right;
	position: fixed;
	margin-left: 710px;
	font-size: x-large;
	cursor: pointer;
}

</style>
</head>
<body>
	<a href="myReqDelete?req_code=${request.req_code}">삭제</a>
	<h3>요청 내용 상세보기</h3>
	<table class='table table-striped'>
		<tr height="40">
			<td  bgcolor="black" style="color: white" align="center">요청코드</td>
			<td style="color:black" colspan="5">${request.req_code}</td>
		</tr>
		<tr height="40">
			<td  bgcolor="black" style="color: white" align="center">작성자</td>
			<td style="color:black" width="200">${request.m_id}</td>
			<td  bgcolor="black" style="color: white"align="center">희망날짜</td>
			<td style="color:black" width="200">${request.req_hopedate}</td>
		</tr>
		<tr height="40">
			<td  bgcolor="black" style="color: white" align="center">희망지역</td>
			<td style="color:black" width="200">${request.req_hopearea}</td>
			<td  bgcolor="black" style="color: white"align="center">상세주소</td>
			<td style="color:black" width="200">${request.req_hopeaddr}</td>
		</tr>
		<tr height="40">
			<td  bgcolor="black" style="color: white"align="center">제목</td>
			<td style="color:black" colspan="5">${request.req_title}</td>
		</tr>
		<tr height="230">
			<td  bgcolor="black" style="color: white"align="center">내용</td>
			<td style="color:black" colspan="5">${request.req_contents}</td> 
		</tr>
		<tr>
		<tr>
			<td  bgcolor="black" style="color: white">첨부파일</td>
			<td style="color:black" ><c:set var="file" value="${rfList}" /> <c:if
					test="${empty file}">
				첨부된 파일이 없습니다.
			</c:if> <c:if test="${!empty file}">
					<c:forEach var="file" items="${rfList}">
						<a
							href="download1?oriFileName=${file.reqi_orifilename}
										&sysFileName=${file.reqi_sysfilename}">
							${file.reqi_orifilename} </a>
					</c:forEach>
				</c:if></td>
		</tr> 
	</table>

</body>
<script>
function reset() {
	if ($layerWindows.hasClass('open')) {
		$layerWindows.removeClass('open');
	}
}

</script>
</html>