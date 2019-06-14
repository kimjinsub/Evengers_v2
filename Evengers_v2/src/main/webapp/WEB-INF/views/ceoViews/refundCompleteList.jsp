<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="eList2" style="width: 90px; float: left;">
		<table border="1">
			<tr align="center">
				<td width="90">상품이름</td>
			</tr>
		</table>
		<table>
			<c:forEach var="event" items="${eList2}">
				<tr align="center">
					<td width="90" height="50px">${event.e_name }</td>
				</tr>
			</c:forEach>
		</table>
	</div>

	<div id="epList2" style="width: 500px; float: left;">
		<table border="1">
			<tr align="center">
				<td width="100">구매자</td>
				<td width="100">구매금액(원)</td>
				<td width="150">구매일</td>
				<td width="150">실행일</td>
			</tr>
		</table>
		<table>

			<c:forEach var="eventpay" items="${epList2}">
				<fmt:formatDate var="payday" value="${eventpay.ep_payday }"
					pattern="yyyy-MM-dd" />
				<fmt:formatDate var="dday" value="${eventpay.ep_dday }"
					pattern="yyyy-MM-dd" />
				<tr align="center">
					<td  width="100" height="50px">${eventpay.m_id }</td>
					<td width="100" height="50px">${eventpay.ep_total }
					<input type="hidden" value="${eventpay.ep_total }"id="${eventpay.ep_code }"/>
					</td>
					<td width="150" height="50px">${payday }</td>
					<td width="150" height="50px">${dday }
					<input type="hidden"class="dday"value="${dday}"name="${eventpay.ep_code }">
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>

	<div id="erList" style="width: 650px; float: left;">
		<table border="1">
			<tr align="center">
				<td width="150">환불요청일자</td>
				<td width="100">몇일전</td>
				<td width="150">위약금(%)</td>
				<td width="150">환불금액(원)</td>
				<td width="100">환불 상태</td>
			</tr>
		</table>
		<table>
			<c:forEach var="eventrefund" items="${erList}">
				<fmt:formatDate var="refunddate"
					value="${eventrefund.er_refunddate}" pattern="yyyy-MM-dd" />
					<tr align="center">
					<td width="150" height="50px">${refunddate}
					
					<textarea id="${eventrefund.ep_code}" name="${refunddate}" class="textarea"></textarea></td>
					<td width="100"><textarea name="${eventrefund.ep_code}" style="resize: none;" rows="1" cols="5"readonly="readonly"></textarea></td>
					<td width="150" height="50px"><input class="er_panalty"
						type="number" min="0" max="100" value="${eventrefund.er_penalty}" id="${eventrefund.ep_code}" readonly>
					</td>
						
					<td width="150" height="50px"><input class="er_total" type="number" name="${eventrefund.ep_code}"readonly
					style="width:150px;"></td>
					<c:if test="${eventrefund.er_penalty == 100}">
					<td width="100" height="50px"><input class="er_result1" type="text" value="환불 거부됨"readonly="readonly" style="width:100px;"></td>
					</c:if>
					<c:if test="${eventrefund.er_penalty !=100}">
					<td width="100" height="50px"><input class="er_result2" type="text" value="환불 완료됨"readonly="readonly" style="width:100px;"></td>
					</c:if>
				</tr>
			</c:forEach>
		</table>
	</div>

 
</body>
<script >
	$('.textarea').hide();
	$(document).ready(function() {

		$('.er_panalty').each(function() {
			var ep_code = $(this).attr("id");
			var ep_panalty = $(this).val();
			console.log("ep_code" + ep_code);
			console.log("ep_panalty" + ep_panalty);
			var total = $('input[id="' + ep_code + '"]').val();
			console.log("total: " + total);
			$.ajax({
				url : "er_total",
				data : {
					ep_panalty : ep_panalty,
					total : total
				},
				dataType : "text",
				success : function(result) {
					console.log(result);
					$('input[name="' + ep_code + '"]').val(result);
				},
				error : function(error) {
					console.log(error);
				}
			})
		})

		$('.dday').each(function() {
			var ep_code = $(this).attr("name");
			var ep_dday = $(this).val();
			console.log("ep_code" + ep_code);
			console.log("ep_dday" + ep_dday);
			var er_rday = $('textarea[id="' + ep_code + '"]').attr("name");
			console.log("er_rday: " + er_rday);
			 $.ajax({
				url : "er_days",
				data : {
					ep_dday: ep_dday,
					er_rday : er_rday
				},
				dataType : "text",
				success : function(result) {
					console.log(result);
					$('textarea[name="' + ep_code + '"]').val(result);
				},
				error : function(error) {
					console.log(error);
				}
			}) 
		})
	})
</script>
</html>