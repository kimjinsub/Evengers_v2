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
/* #totalPriceZone{background-color: white;} */
#totalPrice{display: none;}
#ebInfoZone{
	visibility: hidden; border: 1px solid black;
	height: 500px; width: 500px; margin: auto;
	
}
#ebInfoZone.show{visibility: visible;}
</style>
</head>
<body>
<img src="upload/thumbnail/${eb.e_sysfilename}"/ width="250" height="250">
	<table border="1" align="center">
		<tr>
			<td>상품명</td>
			<td>${eb.e_name}</td>
		</tr>
		<tr>
			<td>가격</td>
			<td>${eb.e_price}원</td>
		</tr>
		<tr>
			<td>옵션</td>
			<td><div id="selectZone"></div></td>
		</tr>
		<tr>
			<td>총가격</td>
			<td><div id="totalPriceZone"></div>
			<input type="hidden" id="totalPrice" disabled="disabled"></td>
		</tr>
		<tr>
			<td>이벤트날짜</td>
			<td><input type="datetime-local"/></td>
			<!-- 2019-12-31T12:59 형식으로 받아짐-->
		</tr>
		<tr>
			<td colspan="2"><button onclick="evtBuy()">구매하기</button></td>
		</tr>
	</table>
	<div class="container-fluid" id="ebInfoZone"></div>
</body>
<script>
$(document).ready(function(){
	selectOption();
	getTotalPrice();
});
//1.세션검사로 member만 구매가능하게
//2.이벤트 날짜...유효성검사ㅋ
function evtBuy(){
	var evtBuy = new FormData;
	evtBuy.append("e_code","${eb.e_code}");
	evtBuy.append("eb_total",$("#totalPrice").val());
	evtBuy.append("eb_dday",$("input[type=datetime-local]").val());
	if(getSelectedOptions()!=[]){
		console.log("hihihi");
		evtBuy.append("eo_code",getSelectedOptions());
	}
	$.ajax({
		method:"post",
		url:"evtBuy",
		data:evtBuy,
		processData:false,
		contentType:false,
		dataType:"text",
		success: function(result){
			console.log(result);
			getEvtBuyInfo(result);
		},
		error: function(error){
			console.log(error);
		}
	})
	
};
function getEvtBuyInfo(eb_code){
	$.ajax({
		method: "post",
		url:"getEvtBuyInfo",
		data:{eb_code:eb_code},
		dataType:"html",
		success: function(result){
			$("#ebInfoZone").html(result);
			$("#ebInfoZone").addClass("show");
		},
		error: function(error){
			console.log(error);
		}
	})
}
function getSelectedOptions(){
	var selectedOptions=new Array();
	$(".option:checked").each(function(){
		selectedOptions.push($(this).val());
		console.log("18u6923i4190");
	})
	console.log(selectedOptions);
	getTotalPrice(selectedOptions);
	return selectedOptions;
};

function getTotalPrice(options){
	var def=${eb.e_price};
	var totalPrice;
	$.ajax({
		url:"getTotalPrice",
		data:{options:options,def:def},
		traditional:true,//배열을 넘기기 위한 설정
		dataType:"text",
		success:function(result){
			$("#totalPriceZone").html(result+"원");
			$("#totalPrice").val(result);
		},
		error:function(error){
			console.log(error);
		}
	})
}

function selectOption(){
	var e_code = "${eb.e_code}";
	$.ajax({
		url:"selectOption",
		data:{e_code:e_code},
		dataType:"json",
		success:function(result){
			var str="";
			for(var i in result){
				str+="<input type='checkbox' class='option' "
					+"value='"+result[i].eo_code+"' onclick='getSelectedOptions()'/>"
					+result[i].eo_name+"/+"+result[i].eo_price+"원<br/>";
			}
			str+="</select>";
			$("#selectZone").html(str);
		},
		error:function(error){
			console.log(error);
		}
	})
}; 
</script>

</html>