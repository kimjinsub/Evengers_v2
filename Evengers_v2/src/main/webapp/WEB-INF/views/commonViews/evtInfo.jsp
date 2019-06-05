<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- <script src="js/jquery.serializeObject.js"></script> -->

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/all.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js" /></script>


</head>
<body>
	<table border="1" align="center">
		<tr>
			<td>상품명</td>
			<td>${eb.e_name}</td>
		</tr>
		<tr>
			<td>가격</td>
			<td>${eb.e_price}</td>
		</tr>
		<tr>
			<td>옵션</td>
			<td><div id="selectZone"></div></td>
		</tr>
	</table>
	<!-- 댓글 전송  -->
	<form name="rFrm" id="rFrm">
		<table>
			<tr>
				<td><textarea rows="3" cols="50" name="r_contents"
						id="r_contents"></textarea></td>
				<td>
				<td><input type="button" value="댓글전송"
					onclick="replyInsert(${eb.e_code})"
					style="width: 70px; height: 50px"></td>
			</tr>
		</table>
	</form>
	<!-- 결과 값 불러오기 -->
	<table>
		<tr bgcolor="skyblue" align="center" height="30">
			<td width="100">WRITER</td>
			<td width="200">CONTENTS</td>
			<td width="200">STARS</td>
			<td width="200">DATE</td>
		</tr>
	</table>
	<table id="rTable">
		<!-- Ajax결과 여기에 쓰기 -->
		<c:forEach items="${rList}" var="reply">
			<tr height="25" align="center">
				<td width="100">${reply.r_mid}</td>
				<td width="200">${reply.r_contents}</td>
				<td width="200">${reply.r_date}</td>
			</tr>
		</c:forEach>
	</table>
	
	
</body>
<script>
$(document).ready(function(){
	console.log("aaa");
	selectOption();
});
function selectOption(){
	var e_code = "${eb.e_code}";
	console.log(e_code);
	
	$.ajax({
		url:"selectOption",
		data:{e_code:e_code},
		dataType:"json",
		success:function(result){
			console.log(result);
			var str="";
			str+="<select name='eo_name'><option selected='selected'>선택하세요</option>";
			for(var i in result){
				str+="<option value='"+result[i].eo_name+"'>"+result[i].eo_name+"</option>";
			}
			str+="</select>";
			$("#selectZone").html(str);
		},
		error:function(error){
			console.log(error);
		}
	})
}; 
</script>

</html>