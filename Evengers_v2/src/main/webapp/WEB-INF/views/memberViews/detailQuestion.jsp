<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
h3{
text-align: center;
}
table{
float:left;
}
</style>
</head>
<body>
	<!--  <a href="questionDelete?q_code=${question.q_code}">삭제</a> -->
	<h3>Question & reply</h3>
	<table>
		<tr height="40">
			<td bgcolor="blue" align="center">NUM</td>
			<td colspan="5">${question.q_code}</td>
		</tr>
		<tr height="40">
			<td bgcolor="blue" align="center">WRITER</td>
			<td width="200">${question.m_id}</td>
			<td bgcolor="blue" align="center">DATE</td>
			<td width="200">${question.q_date}</td>
		</tr>
		<tr height="40">
			<td bgcolor="blue" align="center">TITLE</td>
			<td colspan="5">${question.q_title}</td>
		</tr>
		<tr height="230">
			<td bgcolor="blue" align="center">CONTENTS</td>
			<td colspan="5">${question.q_contents}</td>
		</tr>
		<tr>
			<tr>
			<th>첨부파일</th>
			<td><c:set var="file" value="${bfList}" /> 
				<c:if test="${empty file}">
				첨부된 파일이 없습니다.
			</c:if> 
			<c:if test="${!empty file}">
				<c:forEach var="file" items="${bfList}">
						<a href="download?oriFileName=${file.bf_oriName}
										&sysFileName=${file.bf_sysName}">
							${file.bf_oriName}
						</a>
				</c:forEach>
			</c:if>
			</td>
		</tr>
	</table>
	

</body>
</html>