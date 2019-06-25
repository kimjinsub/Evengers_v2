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
#json_option{
	width: 200px;
	height: auto;
	background-color: white;
	position: fixed;
	left:80%; 
	top:50%;
	border: 5px;
	padding: 20px;
	border: 2px solid #555;
	
}
</style>
</head>
<body>
<h1>이벤트 판매 내역</h1>
	<div style="width: 30%; float: left;">
		<table class='table table-striped' >
			<tr align="center">
			<td><strong>결제코드 및 옵션</strong></td>
			<td><strong>회원 아이디</strong></td>
			</tr>
		<c:forEach var="evtpay" items="${epList}">
			<tr align="center">
			<td><a onclick="epOption(this.id)" href="#"id="${evtpay.ep_code}">${evtpay.ep_code}</a></td>
			<td>${evtpay.m_id}</td>
			</tr>
		</c:forEach>
		</table>
	</div>
	
	<div style="width: 40%; float: left;">
		<table class='table table-striped' >
			<tr align="center">
				<td><strong>총가격</strong></td>
				<td><strong>이벤트 날짜</strong></td>
				<td><strong>결제 날짜</strong></td>
			</tr>
		<c:forEach var="evtpay" items="${epList}">
		<fmt:formatDate var="dday" value="${evtpay.ep_dday}"
					pattern="yyyy-MM-dd" />
		<fmt:formatDate var="payday" value="${evtpay.ep_payday}"
					pattern="yyyy-MM-dd" />
			<tr align="center">
			<td>${evtpay.ep_total} 원</td>
			<td>${dday}</td>
			<td>${payday}</td>
			</tr>
		</c:forEach>
		</table>
	</div>
	<div id="json_option"></div>
</body>
<script >
$("#json_option").hide();
function epOption(ep_code){
	//var ep_code=this.attr("name");
	console.log("ep_code"+ep_code);
	
	$.ajax({
		url : "epOption",
		data : {
			ep_code : ep_code
		},
		dataType : "json",
		success : function(result) {
			console.log(result);
			var str="";
			str+="<div onclick='optionHide()' style='float:right;'>X</div>";
			for ( var i in result) {
				str+="선택 옵션 이름: "+result[i].eo_name
				+" <br> 선택 옵션 가격: "+result[i].eo_price+"<br>";
			}
			console.log(str);
			console.log(Object.keys(result).length);
			if(Object.keys(result).length==0){
				$("#json_option").hide();
				console.log("하이드");
			}else{
				$("#json_option").html(str);
				$("#json_option").show();
			}

		},
		error : function(error) {
			console.log(error);
		}
	})
}
function optionHide(){
	$("#json_option").hide();
}
</script>
</html>