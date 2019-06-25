<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#q_delete{
cursor: pointer;
}
#pageDown {
	text-align: right;
	float: right;
	position: fixed;
	margin-left: 710px;
	font-size: x-large;
	cursor: pointer;
}
h3{
text-align: center;
}
</style>
</head>
<body>
<div id="q_delete" onclick="qDelete('${question.q_code}')">삭제</div>
<div id="pageDown"  onclick="reset()">X</div>
	<h3>문의 내용</h3>
<div id="listBody">
	<table class='table table-striped'>
		<tr height="40">
			<td bgcolor="black" style="color: white" align="center">글번호</td>
			<td colspan="5">${question.q_code}</td>
		</tr>
		<tr height="40">
			<td bgcolor="black" style="color: white" align="center">문의자</td>
			<td width="200">${question.m_id}</td>
			<td bgcolor="black" style="color: white" align="center">문의날짜</td>
			<td width="200">${question.q_date}</td>
		</tr>
		<tr height="40">
			<td bgcolor="black" style="color: white" align="center">제목</td>
			<td colspan="5">${question.q_title}</td>
		</tr>
		<tr height="230">
			<td bgcolor="black" style="color: white" align="center">내용</td>
			<td colspan="5">${question.q_contents}</td>
		</tr>
		<tr>
			<tr>
			<td bgcolor="black" style="color:white;">첨부파일</td>
			<td width="200"><c:set var="file" value="${qfList}" /> 
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
				<td><textarea rows="2" cols="70" name="qr_contents"
						id="qr_contents"></textarea></td>
				<td><input type="button"  value="댓글입력"
					onclick="replyInsert('${question.q_code}')"
					style="width: 85px; height: 50px"></td>
			</tr>
		</table>
	</form>
	<table>
		<tr bgcolor="black" align="center" height="30">
			<td width="120" style="color:white;">댓글작성자</td>
			<td width="210" style="color:white;">내용</td>
			<td width="210" style="color:white;">댓글작성날짜</td>
		</tr>
	</table>
	<table id="qrTable">
		<!-- Ajax결과 여기에 쓰기 -->
		<c:forEach items="${qrList}" var="reply">
			<tr height="25" align="center">
				<td width="120">${reply.m_id}</td>
				<td width="210">${reply.qr_contents}</td>
				<td width="210">${reply.qr_date}</td>
			</tr>
		</c:forEach>
	</table>
	</div>
	

</body>
<script>
function reset() {
	if ($layerWindows.hasClass('open')) {
		$layerWindows.removeClass('open');
	}
}
function replyInsert(q_code){
	  $.ajax({
		type:'post', //json으로 넘길 때 반드시 post로 해야함!
		url:'replyInsert', 
		data:{q_code:q_code,qr_contents:$('#qr_contents').val()}, //넘길 데이터
		dataType:'json',
		success:function(data){
			swal({
	            title: "Good!",
	             text: "댓글을 등록하였습니다",
	             icon: "success",
	  });
			var input = document.getElementById("qr_contents");
			input.value = null;
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
			swal({
	            title: "Sorry!",
	             text: "댓글 등록을 실패하였습니다",
	             icon: "warning",
	  });
		}
	}); //ajax End  
}
function qDelete(q_code){
	$.ajax({
		data:{q_code:q_code},
		url:"questionDelete",
		dataType:'text',
		success:function(text){
			console.log(text);
			swal({
	            title: "Good!",
	             text: "삭제를 성공하였습니다",
	             icon: "success",
	  });
	             location.href="javascript:Ajax_forward('questionList')";
		},
		error:function(error){
			swal({
	            title: "Sorry!",
	             text: "삭제를 실패하였습니다",
	             icon: "warning",
	  });
			location.href="javascript:Ajax_forward('questionList')";
	}
	})
}
</script>
</html>