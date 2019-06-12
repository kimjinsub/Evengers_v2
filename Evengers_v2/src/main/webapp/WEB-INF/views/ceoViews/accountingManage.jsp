<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>
	일일 정산
	<form name="accountingManage" action="/" method="post">
		<table border="1">
			<tr>
				<td>날짜</td>
				<td><input type="date" id="cal_receiptdate"
					name="cal_receiptdate"></td>
			</tr>
			<tr>
				<td>카테고리</td>
				<td><select name="cal_category" id="cal_category">
						<option value="선택하세요">선택하세요</option>
						<option value="기름값">기름값</option>
						<option value="식대">식대</option>
						<option value="재료값">재료값</option>
						<option value="기타">기타</option>
				</select></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><input type="text" id="cal_contents" name="cal_contents"></td>
			</tr>
			<tr>
				<td>금액</td>
				<td><input type="number" id="cal_price" name="cal_price"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="button" value="확인" onclick="calculate()">
											<input type="reset" value="취소"></td>
			</tr>
		</table>
	</form>
</body>
<script>
function calculate(){
	var calb = new Calculate();
	calb.append("cal_receiptdate",$("#cal_receiptdate").val());
	calb.append("cal_category",$("#cal_category").val());
	calb.append("cal_contents",$("#cal_contents").val());
	calb.append("cal_price",$("#cal_price").val());
	
	$.ajax({
		type:"post",
		url:"calInsert",
		data:calb,
		dataType:"html",
		success:function(data){
			alert("정산 입력 성공");
			console.log(data);
			location.href="./";
		},
		error:function(error){
			alert("정산 입력 실패");
			console.log(error)
		}
	})
}

</script>
</html>