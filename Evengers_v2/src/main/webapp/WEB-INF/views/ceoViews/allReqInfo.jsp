
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
</head>
<body>
	<div id="pageDown"  onclick="reset()">X</div>
	<a href="myReqDelete?req_code=${request.req_code}">삭제</a>
	<h3>요청 내용 상세보기</h3>
	<table border='1' class='table table-striped'>
		<tr height="40">
			<td  align="center">요청코드</td>
			<td colspan="5">${request.req_code}</td>
		</tr>
		<tr height="40">
			<td  align="center">작성자</td>
			<td width="200">${request.m_id}</td>
			<td  align="center">희망날짜</td>
			<td width="200">${request.req_hopedate}</td>
		</tr>
		<tr height="40">
			<td  align="center">희망지역</td>
			<td width="200">${request.req_hopearea}</td>
			<td  align="center">상세주소</td>
			<td width="200">${request.req_hopeaddr}</td>
		</tr>
		<tr height="40">
			<td  align="center">제목</td>
			<td colspan="5">${request.req_title}</td>
		</tr>
		<tr height="230">
			<td  align="center">내용</td>
			<td colspan="5">${request.req_contents}</td>
		</tr>
		<tr>
		<tr>
			<th>첨부파일</th>
			<td><c:set var="file" value="${rfList}" /> <c:if
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
	  <a href="estPageFrm?req_code=${request.req_code}">견적작성</a>

</body>

<script>
function reset() {
	if ($layerWindows.hasClass('open')) {
		$layerWindows.removeClass('open');
	}
}

</script>
</html>