<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style>
#table{
	visibility: hidden;
}
#table.shown{
	visibility: visible;	
}
#input {
	color: green;
}

#noinput {
	color: red;
}
</style>
</head>
<body>
	<div id="wrap">
		일일 정산
		<form name="accountingManage" action="accountingManage" method="post"
			onsubmit="return check()">
			<table border="1">
				<tr>
					<td>날짜</td>
					<td><input type="date" id="cal_receiptdate"
						name="cal_receiptdate" name="cal_receiptdate"><span
						id="dateMsg"></span></td>
				</tr>
				<tr>
					<td>카테고리</td>
					<td><select name="cal_category" id="cal_category"
						name="cal_category">
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
					<td colspan="2" align="center"><input type="button"
						onclick="calculate()" value="확인"> <input type="reset"
						value="취소"></td>
				</tr>
			</table>
		</form>
		
		상세보기
	</div>
		<table border="1" id="table">
			<tr>
			</tr>
		</table>
</body>
<script>
	function calculate() {
		var receiptdate = $("#cal_receiptdate").val();
		var cal_category = $("#cal_category").val();
		var cal_contents = $("#cal_contents").val();
		var cal_price = $("#cal_price").val();
		var cal_receiptdate = new Date(receiptdate);
		cal_price = new Number(cal_price);

		console.log("category=" + cal_category);
		console.log("contents=" + cal_contents);
		console.log("price=" + cal_price);
		console.log($("#cal_receiptdate").val());

		$.ajax({
			url : "calInsert",
			data : {
				cal_receiptdate : cal_receiptdate,
				cal_category : cal_category,
				cal_contents : cal_contents,
				cal_price : cal_price
			},
			dataType : "html",
			success : function(data) {
				alert("정산 등록 성공");
				$("#wrap").html(data);
			},
			error : function(error) {
				alert("정산 입력 실패");
				console.log(error)
			}
		})
	}
	$("input[type=date]").change(function() {
		validation();
	})
	function validation() {
		var day = $("input[type=date]").val();
		console.log("day=" + day);
		$.ajax({
			url : "validation",
			data : {
				day : day
			},
			dataType : "text",
			success : function(result) {
				console.log(result);
				$("#dateMsg").html(result);
			},
			error : function(error) {
				console.log(error);
			}
		})
	}
/* 	function getCalList() {
		$.ajax({
			url : "getCalList",
			dataType : "json",
			success : function(result) {
			console.log(result);
			
			var str = "<tr><td>날짜</td><td>카테고리</td><td>내용</td><td>금액</td></tr>";
			for ( var i in result) {
				str += "<tr><td>" + result[i].cal_receiptdate
					+ "</td>" + "<td>" + result[i].cal_category
			    	+ "</td>" + "<td>" + result[i].cal_contents
					+ "</td>" + "<td>" + result[i].cal_price
					+ "</td></tr>";
				}
					$("#table").html(str);
			},
				error : function(error) {
				console.log(error);
		}
	})
} */

</script>
</html>