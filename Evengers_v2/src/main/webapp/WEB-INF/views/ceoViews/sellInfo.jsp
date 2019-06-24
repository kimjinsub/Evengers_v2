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
<h1>이벤트 판매 내역</h1>
	<div style="width: 30%; float: left;">
		<table class='table table-striped' border="1">
			<tr align="center">
			<td><strong>결제코드</strong></td>
			<td><strong>회원 아이디</strong></td>
			</tr>
		<c:forEach var="evtpay" items="${epList}">
			<tr align="center">
			<td>${evtpay.ep_code}</td>
			<td>${evtpay.m_id}</td>
			</tr>
		</c:forEach>
		</table>
	</div>
	
	<div style="width: 40%; float: left;">
		<table class='table table-striped' border="1">
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
			<td>${evtpay.ep_total}</td>
			<td>${dday}</td>
			<td>${payday}</td>
			</tr>
		</c:forEach>
		</table>
	</div>
	<div id="">
		<div style="float: left; ">
		<table class='table table-striped' border="1">  
			<tr align="center" >
			<td width="100px"><strong>결제코드</strong> </td>
			</tr>
		<c:forEach var="evtpayselect" items="${epsList}">
			<tr align="center">
			<td width="50px">${evtpayselect.ep_code}</td>
			</tr>
		</c:forEach>
		</table>
		</div>
		<div style="float: left;">
		<table class='table table-striped' border="1" >  
			<tr align="center">
			<td><strong>선택 옵션 이름 </strong></td>
			<td><strong>선택 옵션 가격</strong></td>
			</tr>
		<c:forEach var="evtoption" items="${eoList}">
			<tr align="center">
			<td>${evtoption.eo_name}</td>
			<td>${evtoption.eo_price}</td>
			</tr>
		</c:forEach>
		</table>
		</div>
	</div>
</body>
</html>