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
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
<style>
/* #font{
	font-family: "Nanum Gothic", sans-serif; font-size: 20px;
	width:100%;
}
.max-small {
    width: auto; height: auto;
    max-width: 300px;
    max-height: 300px;
}
*/
#pageDown {
	position:absolute;
	top:0%;right:0%;
}
.img-thumbnail{
    width: auto; height: auto;
    max-width: 350px;
    /* max-height: 300px; */
}
#payInfo{
	width:100%;
}
#wrap{
	font-family: "Nanum Gothic", sans-serif; font-size: 20px;
}
</style>
</head>
<body>
<div id="wrap">
<h2 style="font-size: 30px;">결제 완료 내역</h2>
<table class="table table-condensed" id="payInfo">
	<tr>
		<td rowspan="3" width="350">
			<img class='img-thumbnail' src="upload/thumbnail/${e.e_sysfilename}"/>
		</td>
		<td>${e.e_name}(결제일:${ep_payday})</td>
	</tr>
	<tr>
		<td>
		${ep.ep_total}원
		<c:if test="${eoList!=null}">
			<div id="epsList"></div>
		</c:if>
		</td>
	</tr>
	<tr>
		<td>이벤트당일:${ep_dday}<br/>(~${refundAble}까지 환불가능)</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<button class="btn btn-primary" id="exit">마이페이지 가기</button>
		</td>
	</tr>
</table>
<div id="pageDown" onclick="reset()"><img src="img/closer.png" width="30"/> </div>
</div>
</body>
<script>
console.log("eoList:",${eoList});
$(document).ready(function(){
	showEpsList();
});
function showEpsList(){
	var str="";
	var eoList=${eoList};
	console.log("eoList=",eoList);
	for(var i in eoList){
		str+="옵션"+":"+eoList[i]['eo_name']+"/(+"+eoList[i]['eo_price']+"원)<br/>"
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