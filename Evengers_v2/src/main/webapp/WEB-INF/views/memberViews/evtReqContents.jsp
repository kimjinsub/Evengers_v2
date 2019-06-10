<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>의뢰 내역 확인</h1>
	<table border="1" align="center">
		<tr>
			<td>요청코드</td>
			<td>등록자</td>
			<td>카테고리</td>
			<td>제목</td>
			<td>희망날짜</td>
			<td>희망지역</td>
			<td>상세주소</td>
			<td>내용</td>
		</tr>
		
		<tr>
			<td>${requestimage.req_code}</td>
			<td>${request.m_id}</td>
			<td>${request.ec_name}</td>
			<td>${request.req_title}</td>
			<td>${request.req_hopedate}</td>
			<td>${request.req_hopearea}</td>
			<td>${request.req_hopeaddr}</td>
			<td>${request.req_contents}</td>
		</tr>
		
		<tr>
			<input type="button" value="확인" onclick="location.href='./'">
		</tr>
	</table>
</body>
</html>