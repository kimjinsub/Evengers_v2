<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style >
.choiceList{
border: 1px solid red;
}
</style>
</head>
<body>
찜목록
	
	<div id="">
		<c:forEach var="event" items="${choiceList}">
			<div class="choiceList">
			<table>
			<tr><td rowspan="4"><img src="upload/thumbnail/${event.e_sysfilename}" / width="250"
				height="250"></td><td>상품명 : ${event.e_name}</td><td rowspan="4"><button onclick="location='evtInfo?e_code=${event.e_code}'">구매하러 가기</button><br><br>
				<button class="e_code" name="${event.e_code}" >찜삭제</button></td></tr>
			<tr><td>카테고리 : ${event.e_category}	 |	기업 아이디 : ${event.c_id}</td></tr>
			<tr><td>상품 가격: ${event.e_price}</td></tr>
			<tr><td>상품 내용: ${event.e_contents}</td></tr>
			</table>
			</div>
			<br>
		</c:forEach>
	</div>

</body>
<script >

$('.e_code').each(function(){
	 var e_code =$(this).attr("name");
		$(this).click(function(){
		
		console.log(e_code);
		$.ajax({
			url : "choiceDelete",
			data : {
				e_code : e_code
			},
			dataType : "text",
			success : function(result) {
				console.log(result);
				alert(result);
				location.href = "memberMyPage";
			},
			error : function(error) {
				console.log(error);
			}
		});
	})
})
</script>
</html>