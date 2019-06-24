<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style >
table.type08 {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;
    border-left: 1px solid #ccc;
}

table.type08 thead th {
    padding: 10px;
    font-weight: bold;
    border-top: 1px solid #ccc;
    border-right: 1px solid #ccc;
    border-bottom: 2px solid #c00;
    background: #dcdcd1;
}
table.type08 tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    background: #ececec;
}
table.type08 td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
}
</style>
</head>
<body>
<h1>환불 내역 페이지</h1>
<div>
	<div id="eList2" style="width:10%;; float: left;">
		<table border="1" class='table table-striped' style="width: 100%;">
		<thead>
			<tr align="center">
				<th >상품이름</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="event" items="${eList2}">
				<tr align="center" height="60px">
					<td  height="50px">${event.e_name }</td>
				</tr>
			</c:forEach>
		</tbody>
		</table>
	</div>

	<div id="epList2" style="width: 35%;; float: left;">
		<table border="1" class='table table-striped' style="width: 100%;">
		<thead>
			<tr align="center">
				<th >구매자</th>
				<th >구매금액</th>
				<th >구매일</th>
				<th >실행일</th>
			</tr>
		</thead>
 			<tbody>
			<c:forEach var="eventpay" items="${epList2}">
				<fmt:formatDate var="payday" value="${eventpay.ep_payday }"
					pattern="yyyy-MM-dd" />
				<fmt:formatDate var="dday" value="${eventpay.ep_dday }"
					pattern="yyyy-MM-dd" />
				<tr align="center" height="60px">
					<td   height="50px">${eventpay.m_id }</td>
					<td height="50px">${eventpay.ep_total }
					<input type="hidden" value="${eventpay.ep_total }"id="${eventpay.ep_code }"/>
					</td>
					<td  height="50px">${payday }</td>
					<td  height="50px">${dday }
					<input type="hidden"class="dday"value="${dday}"name="${eventpay.ep_code }">
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>

	<div id="erList" style="width: 55%; float: left;">
		<table border="1" class='table table-striped' style="width: 100%;">
		<thead>
			<tr align="center">
				<th>환불요청일자</th>
				<th >몇일전</th>
				<th >위약금(%)</th>
				<th >환불금액(원)</th>
				<th >환불 상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="eventrefund" items="${erList}">
				<fmt:formatDate var="refunddate"
					value="${eventrefund.er_refunddate}" pattern="yyyy-MM-dd" />
					<tr align="center" height="60px">
					<td  height="50px">${refunddate}
					
					<textarea id="${eventrefund.ep_code}" name="${refunddate}" class="textarea"></textarea></td>
					<td ><textarea name="${eventrefund.ep_code}" style="resize: none;background-color:transparent;border:0 solid black;text-align:right;" rows="1" cols="5"readonly="readonly"></textarea></td>
					<td  height="50px"><input class="er_panalty"
						type="number" min="0" max="100" value="${eventrefund.er_penalty}" id="${eventrefund.ep_code}" style="background-color:transparent;border:0 solid black;text-align:right;" readonly>
					</td>
				
					<td height="50px"><input style="width: 80px;background-color:transparent;border:0 solid black;text-align:right;" class="er_total" type="number" name="${eventrefund.ep_code}"readonly
					></td>
					<c:if test="${eventrefund.er_penalty == 100}">
					<td  height="50px"><input class="er_result1" type="text" value="환불 거부됨"readonly="readonly" style="width:100px;background-color:transparent;border:0 solid black;text-align:right;"></td>
					</c:if>
					<c:if test="${eventrefund.er_penalty !=100}">
					<td  height="50px"><input class="er_result2" type="text" value="환불 완료됨"readonly="readonly" style="width:100px;background-color:transparent;border:0 solid black;text-align:right;"></td>
					</c:if>
				</tr>
			</c:forEach>
		</tbody>
		</table>
	</div>

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