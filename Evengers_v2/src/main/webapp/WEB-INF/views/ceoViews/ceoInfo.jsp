<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table.type09 {
	background-color:white;	
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;
	border-radius: 2em}
table.type09 thead th {
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #369;
    border-bottom: 3px solid #036;
}
table.type09 tbody th {
    width: 200px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #f3f6f7;
    text-align: center;
    font-size: 20px;
}
table.type09 td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    font-size: 20px;
}
</style>
</head>
<body>
<h1>사업가 정보</h1><br>
<table border="1" class="type09">
<thead><tr><th colspan="2"><h3>사업가 정보</h3></th></tr></thead>
<tbody>
<tr><th>아이디 :</th><td>${ceo.c_id}</td></tr>
<tr><th>사업자 등록 번호 :</th><td>${ceo.c_rn}</td></tr>
<tr><th>회사명 :</th><td>${ceo.c_name}</td></tr>
</tbody>
</table>
<br>
<hr>
<br>
<table border="1" class="type09">
<thead><tr><th colspan="2"><h3>연락처 정보</h3></th></tr></thead>
<tbody>
<tr><th>회사 전화 번호 :</th><td>${ceo.c_tel}</td></tr>
<tr><th>이메일:</th><td>${ceo.c_email}</td></tr>
</tbody>
</table>
</body>
</html>