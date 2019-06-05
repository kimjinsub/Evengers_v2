<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
사업가 정보
<table border="1">
<tr><td colspan="2">사업가 정보</td></tr>
<tr><td>아이디 :</td><td>${ceo.c_id}</td></tr>
<tr><td>사업자 등록 번호 :</td><td>${ceo.c_rn}</td></tr>
<tr><td>회사명 :</td><td>${ceo.c_name}</td></tr>
</table>
<br>
<hr>
<br>
<table border="1">
<tr><td colspan="2">연락처 정보</td></tr>
<tr><td>회사 전화 번호 :</td><td>${ceo.c_tel}</td></tr>
<tr><td>이메일:</td><td>${ceo.c_email}</td></tr>
</table>
</body>
</html>