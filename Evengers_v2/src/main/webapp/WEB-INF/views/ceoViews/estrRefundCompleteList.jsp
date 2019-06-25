<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<style>
.state{
color:red;
}
</style>
<body>
<h3>환불 완료 리스트</h3>
	<div id="estimateRefundList"></div>
	<div id="paging"></div>
</body>
<script>
$(document).ready(function() {
	RefundCompleteList(1,5);
});
function RefundCompleteList(pageNum,listCount){
	$.ajax({
		url:'estrRefundComplete',
		dataType:'json',
		data:{pageNum:pageNum,listCount:listCount},
		success:function(data){
			console.log(data);
			var estpList=data['estpList'];
			var reqList=data['reqList'];
			var estrList=data['estrList'];
			var paging=data['paging'];
			var str = "<table class='table table-striped' id='et' ><th scope='cols'>상품제목</th><th scope='cols'>구매자아이디</th><th scope='cols'>총가격</th><th scope='cols'>판매자아이디</th><th scope='cols'>구매날짜</th><th>환불 요청한 날짜</th><th scope='cols'>위약금</th><th scope='cols'>환불금액</th><th scope='cols'>환불상태</th>";

			for ( var i in estpList) {
				var penaltyPrice=estpList[i].estp_total*estrList[i].estr_penalty/100;
				var refundPrice=estpList[i].estp_total-penaltyPrice;
				str += "<tr><td>"
						+ reqList[i].req_title + "</td><td>"
						+ reqList[i].m_id+"</td><td>"
						+ estpList[i].estp_total + '원 '+"</td><td>"
						+ estpList[i].c_id+"</td><td>"
						+ estpList[i].estp_payday+"</td><td>"
						+ estrList[i].estr_refunddate+"</td><td>"
						+ penaltyPrice+"원</td><td>"
						+ refundPrice+"원</td><td><div class='state'>"
						+ estrList[i].estr_state+"</div></td><tr>"
						+"<input type='hidden' name='estp_code' id='estp_code' value='"+estpList[i].estp_code+"'>"
						
			}
			str += "</table>"
			$("#estimateRefundList").html(str);
			$(".state").html("환불완료");
			 $("#paging").html(paging);
		},
		error:function(error){
			
		}
	});
}
</script>

</html>