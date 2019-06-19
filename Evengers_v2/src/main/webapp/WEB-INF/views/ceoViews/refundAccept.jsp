<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<body>
	<h3>환불 수락 페이지</h3>
	<div id="estimateRefund"></div>
</body>
<script>
$(document).ready(function() {
	getRefundAcceptList();
});
function getRefundAcceptList(){
	$.ajax({
		url:'RefundAcceptList',
		dataType:'json',
		success:function(data){
			console.log(data);
			var estpList=data['estpList'];
			var reqList=data['reqList'];
			var estrList=data['estrList'];
			var str = "<table id='et' border='1'><th>상품제목</th><th>구매자아이디</th><th>총가격</th><th>판매자아이디</th><th>구매날짜</th><th>환불 요청한 날짜</th><th>위약금</th><th>버튼</th>";
               console.log(estrList);
               console.log(estpList);
               console.log(reqList);
			for ( var i=0;i<estpList.length;i++) {
				str += "<tr><td>"
						+ reqList[i].req_title + "</td><td>"
						+ reqList[i].m_id+"</td><td>"
						+ estpList[i].estp_total + '원 '+"</td><td>"
						+ estpList[i].c_id+"</td><td>"
						+ estpList[i].estp_payday+"</td><td>"
						+ estrList[i].estr_refunddate+"</td><td>"
						+"<input type='number' id='estr_penalty' name='estr_penalty'></td><td>"
						+"<input type='submit' onclick=insertPenalty()></td></tr>"
						+"<input type='hidden' name='estp_code' id='estp_code' value='"+estpList[i].estp_code+"'>"
			}
			str += "</table>"
			$("#estimateRefund").html(str);
			// $("#paging").html(paging);
		},
		error:function(error){
			
		}
	});
}
function insertPenalty(){
	
	var estp_code=$("#estp_code").val();
	var estr_penalty=$("#estr_penalty").val();
	$.ajax({
		url:'insertPenalty',
		data:{estp_code:estp_code,estr_penalty:estr_penalty},
		dataType:'json',
		success:function(data){
			alert("환불이 완료 되었습니다.")
			var estpList=data['estpList'];
			var reqList=data['reqList'];
			var estrList=data['estrList'];
			var str = "<table id='et' border='1'><th>상품제목</th><th>구매자아이디</th><th>총가격</th><th>판매자아이디</th><th>구매날짜</th><th>환불 요청한 날짜</th><th>위약금</th><th>버튼</th>";

			for ( var i in estpList) {
				str += "<tr><td>"
						+ reqList[i].req_title + "</td><td>"
						+ reqList[i].m_id+"</td><td>"
						+ estpList[i].estp_total + '원 '+"</td><td>"
						+ estpList[i].c_id+"</td><td>"
						+ estpList[i].estp_payday+"</td><td>"
						+ estrList[i].estr_refunddate+"</td><td><input type='number' id='estr_penalty' name='estr_penalty'></td><td><input type='submit' value='환불' onclick=insertPenalty()></td></tr>"
						+"<input type='hidden' name='estp_code' id='estp_code' value='"+estpList[i].estp_code+"'>"
			}
			str += "</table>"
			$("#estimateRefund").html(str);
			location.href = "javascript:Ajax_forward('estrRefundCompleteList')";
		},error:function(error){
			alert("환불이 실패하였습니다.")
		}
	})
}
</script>
</html>