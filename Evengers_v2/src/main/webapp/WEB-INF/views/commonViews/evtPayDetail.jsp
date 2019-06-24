<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/all.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js" /></script>
<style>
#font{
	font-size: 20px
}
.max-small {
    width: auto; height: auto;
    max-width: 300px;
    max-height: 300px;
}
#pageDown {
	position:absolute;
	bottom:50%;
	float: right;
	font-size: x-large;
}
</style>
</head>
<body>
<div id="font">
<div id="payImg">
<img class='max-small'src="upload/thumbnail/${e.e_sysfilename}" >
</div>
<br/>
<div id="pageDown"  onclick="reset()">X</div>
<div>상품명:${e.e_name}</div>
<div>기본가:${e.e_price}원</div>
<div>결제코드:${ep.ep_code}</div>
<div>총결제액:${ep.ep_total}원</div>
<div id="epsList"></div>
<div>결제일:${ep_payday}</div>
<div>이벤트일:${ep_dday}</div>
<div>환불가능일:~${refundAble}까지</div>
<button id="exit">마이페이지 가기</button>
</div>
</body>
<script>
$(document).ready(function(){
	showEpsList();
});
function showEpsList(){
	var str="";
	var eoList=${eoList};
	console.log("eoList=",eoList);
	for(var i in eoList){
		str+="선택한 옵션"+":"+eoList[i]['eo_name']+"/(+"+eoList[i]['eo_price']+"원)<br/>"
	}
	$("#epsList").html(str);
};
$("#exit").click(function() {
	location.href ="memberMyPage";
});
function reset() {
	if ($('#articleView_layer2').hasClass('open')) {
		$('#articleView_layer2').removeClass('open');
	}
}
</script>

</html>