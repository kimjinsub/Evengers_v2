<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
내정보
<table border="1">
<tr><td colspan="2">프로필</td></tr>
<tr><td>이름 :</td><td>${mb.m_id}</td></tr>
<tr><td>생년월일 :</td><td>${m_rrn}</td></tr>
<tr><td>지역:</td><td>${mb.m_area}</td></tr>
</table>
<br>
<hr>
<br>
<table border="1">
<tr><td colspan="2">연락처 정보</td></tr>
<tr><td>이메일 :</td><td>${mb.m_email}</td></tr>
<tr><td>휴대전화 :</td><td>${mb.m_tel}</td></tr>
</table>
</body>
</html>