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
h3{
text-align: center;
}
table{
float:left;
}
</style>
</head>
<body>
<a href="questionDelete?q_code=${question.q_code}">삭제</a>
	<h3>문의 내용</h3>
	<table border='1'>
		<tr height="40">
			<td bgcolor="blue" align="center">글번호</td>
			<td colspan="5">${question.q_code}</td>
		</tr>
		<tr height="40">
			<td bgcolor="blue" align="center">문의자</td>
			<td width="200">${question.m_id}</td>
			<td bgcolor="blue" align="center">문의날짜</td>
			<td width="200">${question.q_date}</td>
		</tr>
		<tr height="40">
			<td bgcolor="blue" align="center">제목</td>
			<td colspan="5">${question.q_title}</td>
		</tr>
		<tr height="230">
			<td bgcolor="blue" align="center">내용</td>
			<td colspan="5">${question.q_contents}</td>
		</tr>
		<tr>
			<tr>
			<th>첨부파일</th>
			<td><c:set var="file" value="${qfList}" /> 
				<c:if test="${empty file}">
				첨부된 파일이 없습니다.
			</c:if> 
			<c:if test="${!empty file}">
				<c:forEach var="file" items="${qfList}">
						<a href="download?oriFileName=${file.q_orifilename}
										&sysFileName=${file.q_sysfilename}">
							${file.q_orifilename}
						</a>
				</c:forEach>
			</c:if>
			</td>
		</tr>
	</table>
	<form name="rFrm" id="rFrm">
		<table>
			<tr>
				<td><textarea rows="3" cols="70" name="qr_contents"
						id="qr_contents"></textarea></td>
				<td><input type="button" value="댓글입력"
					onclick="replyInsert('${question.q_code}')"
					style="width: 70px; height: 50px"></td>
			</tr>
		</table>
	</form>
	<table>
		<tr bgcolor="#F2F5A9" align="center" height="30">
			<td width="100">댓글작성자</td>
			<td width="200">내용</td>
			<td width="200">댓글작성날짜</td>
		</tr>
	</table>
	<table id="qrTable">
		<!-- Ajax결과 여기에 쓰기 -->
		<c:forEach items="${qrList}" var="reply">
			<tr height="25" align="center">
				<td width="100">${reply.m_id}</td>
				<td width="200">${reply.qr_contents}</td>
				<td width="200">${reply.qr_date}</td>
			</tr>
		</c:forEach>
	</table>
	

</body>
<script>
function replyInsert(q_code){
	  $.ajax({
		type:'post', //json으로 넘길 때 반드시 post로 해야함!
		url:'replyInsert', 
		data:{q_code:q_code,qr_contents:$('#qr_contents').val()}, //넘길 데이터
		dataType:'json',
		success:function(data){
            console.log(data);
			var str="";
			for(var i in data){
				str+='<tr height="25" align="center">'
					+'<td width="100">'+data[i]['m_id']+'</td>'
					+'<td width="200">'+data[i]['qr_contents']+'</td>'
					+'<td width="200">'+data[i]['qr_date']+'</td></tr>';
			}
			$('#qrTable').html(str);
		},
		error:function(error){
		}
	}); //ajax End  
	
}
</script>
</html>