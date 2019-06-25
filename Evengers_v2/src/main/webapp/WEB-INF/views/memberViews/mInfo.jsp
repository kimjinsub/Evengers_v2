<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table.type09 {
	position:relative;
	left:30%;
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
    width: 130px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #f3f6f7;
    text-align: center;
    font-size: 18px;
}
table.type09 td {
    width: 300px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    font-size: 20px;
}
</style>
</head>
<body>
    
<h1>내정보</h1><br>
<table border="1" class="type09">
<thead><tr><th colspan="2"><h3>-  프로필</h3></th></tr></thead>
<tbody>
<tr><th>이름 </th><td>${mb.m_id}</td></tr>
<tr><th>생년월일 </th><td>${m_rrn}</td></tr>
<tr><th>지역</th><td>${mb.m_area}</td></tr>
</tbody>
</table>
<hr>
<table border="1" class="type09">
<thead><tr><th colspan="2"><h3>-  연락처 정보</h3></th></tr></thead>
<tbody>
<tr><th>이메일 </th><td>${mb.m_email}</td></tr>
<tr><th>휴대전화 </th><td>${mb.m_tel}</td></tr>
</tbody>
</table>
</body>
</html>