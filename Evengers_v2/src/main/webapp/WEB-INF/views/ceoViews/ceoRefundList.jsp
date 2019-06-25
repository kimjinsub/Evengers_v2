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
    text-align: left;
    line-height: 1.5;
}

table.type08 thead th {
    padding: 10px;
    font-weight: bold;
    background: #dcdcd1;
}
table.type08 tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    background: #ececec;
}
table.type08 td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
}
#span{
	float: right;
	color:red;
	text-align: center;
}

.refundBtn {
	-moz-box-shadow: 0px 0px 0px 2px #9fb4f2;
	-webkit-box-shadow: 0px 0px 0px 2px #9fb4f2;
	box-shadow: 0px 0px 0px 2px #9fb4f2;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #7892c2), color-stop(1, #476e9e));
	background:-moz-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-webkit-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-o-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-ms-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:linear-gradient(to bottom, #7892c2 5%, #476e9e 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#7892c2', endColorstr='#476e9e',GradientType=0);
	background-color:#7892c2;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:19px;
	padding:8px 30px;
	text-decoration:none;
	text-shadow:0px 1px 0px #283966;
}
.refundBtn:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #476e9e), color-stop(1, #7892c2));
	background:-moz-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-webkit-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-o-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:-ms-linear-gradient(top, #476e9e 5%, #7892c2 100%);
	background:linear-gradient(to bottom, #476e9e 5%, #7892c2 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#476e9e', endColorstr='#7892c2',GradientType=0);
	background-color:#476e9e;
}
.refundBtn:active {
	position:relative;
	top:1px;
}
.table table-striped{
   display:table-cell;
   vertical-align:middle;
}
</style>
</head>
<body>
<h1>환불 요청 페이지</h1>
<div >
	<div id="eList2" style="width:10%; float: left;">
		<table  class='table table-striped' style="width: 100%;">
			<thead>
			<tr align="center">
				<th>상품이름</th>
			</tr>
			</thead>
		 <tbody>
			<c:forEach var="event" items="${eList2}">
				<tr align="center"height="60px">
					<td height="70px">${event.e_name }</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>

	<div id="epList2" style="width: 35%; float: left;">
		<table  class='table table-striped' style="width: 100%;">
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
					<td  height="70px">${eventpay.m_id }</td>
					<td  height="70px">${eventpay.ep_total }원
					<input type="hidden" value="${eventpay.ep_total }"id="${eventpay.ep_code }"/>
					</td>
					<td height="70px">${payday }</td>
					<td height="70px">${dday }
					<input type="hidden"class="dday"value="${dday}"name="${eventpay.ep_code }"></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>


	<div id="erList" style="width: 55%; float: right;">
		<table  class='table table-striped' style="width: 100%;">
			<thead>
				<tr align="center" >
					<th >환불요청일자</th>
					<th >몇일전</th>
					<th>위약금(%)</th>
					<th >환불금액(원)</th>
					<th >버튼</th>
				</tr>
			</thead>
		 <tbody>
			<c:forEach var="eventrefund" items="${erList}">
				<fmt:formatDate var="refunddate"
					value="${eventrefund.er_refunddate}" pattern="yyyy-MM-dd" />
					<tr align="center" height="60px">
					<td  height="70px">${refunddate}<textarea
							id="${eventrefund.ep_code}" name="${refunddate}" class="textarea"></textarea></td>
					<td ><div id="${eventrefund.ep_code}"></div></td>
					<td  height="70px"><input class="er_panalty"
						type="number" min="0" max="100" value="0"
						id="${eventrefund.ep_code}"></td>

					<td  height="70px"><input class="er_total"
						type="number" name="${eventrefund.ep_code}" readonly></td>
					<td  height="70px"><button class="refundBtn"
							name="${eventrefund.ep_code}">완료</button></td>
				</tr>
				<textarea class="hiddenclass" name="${eventrefund.ep_code}"></textarea>
			</c:forEach>
			</tbody>
		</table>
	</div>
</div>
</body>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script >
$('.hiddenclass').hide();
$('.textarea').hide();
$(document).ready(function() {
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
				$('div[id="' + ep_code + '"]').text(result);
			},
			error : function(error) {
				console.log(error);
			}
		}) 
	})
})
$('.er_panalty').each(function() {
	$(this).change(function() {
		var ep_code=$(this).attr("id");
		var ep_panalty=$(this).val();
		ep_panalty=(Math.floor(ep_panalty));//소수점으로 입력하면 소수점 버림
		console.log("ep_code"+ep_code);
		if(ep_panalty>100){
			ep_panalty=100;
			swal({
	            title: "Warning!",
	             text:  "100이하로 해주세요.",
	             icon: "warning",
			  });
		}
		if(ep_panalty<0){
			ep_panalty=0;
			swal({
	            title: "Warning!",
	             text:  "0이상으로 해주세요.",
	             icon: "warning",
			  });
		}
		console.log("ep_panalty"+ep_panalty);
		var total=$('input[id="'+ep_code+'"]').val();
		console.log("total: "+total);
		 $.ajax({
			url:"er_total",
			data:{ep_panalty:ep_panalty,total:total},
			dataType : "text",
			success:function(result){
				console.log(result);
				$('input[name="'+ep_code+'"]').val(result);
				$('textarea[name="'+ep_code+'"]').val(ep_panalty);
			},
			error:function(error){
				console.log(error);
			}
		}) 
	})
})

$('.refundBtn').each(function() {
	$(this).click(function() {
		var ep_code = $(this).attr("name");
		var ep_penalty = $('textarea[name="'+ep_code+'"]').val();
		console.log(ep_code);
		 $.ajax({
				url:"ceoRefundBtn",
				data:{ep_code:ep_code,ep_penalty:ep_penalty},
				dataType : "text",
				success:function(result){
					console.log(result);
					swal({
			            title: "Success!",
			             text:  result,
			             icon: "success",
					  });
					location.href = "javascript:Ajax_forward('refundCompleteList')";
				},
				error:function(error){
					console.log(error);
				}
			})  
	})
})
</script>
</html>