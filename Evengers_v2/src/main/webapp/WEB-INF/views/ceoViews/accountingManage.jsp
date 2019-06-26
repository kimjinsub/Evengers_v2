<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<style>
input[type="month"]::-webkit-calendar-picker-indicator,
input[type="month"]::-webkit-inner-spin-button {
    display: none;
    appearance: none;
}
#input {
	color: green;
}

#noinput {
	color: red;
}
#allshow{
	position:relative;
	display: none;
}
#getCal{
	width: 30%;
	/* float: left; */
}
#calTable{
	width: 40%;
	float: inherit;
}
#allshow.open {
	display: block;
}
.form-control{
	width:30%;
}
.custom-select{
	width:30%;
}
#h2{
	font-family: 'Nanum Gothic', sans-serif;
}
#choicedate{
	font-family: 'Nanum Gothic', sans-serif;
}
.card{
	margin-top : 2%;
}


</style>
</head>
<body id="wrap">
<div class="card" align="center">
<div class="card-body px-lg-5 pt-0" >
		<h2 id="h2">일일 정산</h2>
		<form name="accountingManage" action="accountingManage" method="post"
			onsubmit="return check()" >
			<div class="md-form mt-3">
			<i class="fas fa-barcode"></i>&nbsp<label for="inputMDEx">Choose your date</label>
			<input type="date" id="cal_receiptdate"  name="cal_receiptdate" class="form-control">
			<span id="dateMsg"></span>
			</div>
			<div class="md-form mt-3">
					<i class="far fa-file-alt"></i>&nbsp<label for="inputMDEx">카테고리</label><br>
					<select name="cal_category" id="cal_category" name="cal_category" class='custom-select'>
							<option value="선택하세요">선택하세요</option>
							<option value="기름값">기름값</option>
							<option value="식대">식대</option>
							<option value="재료값">재료값</option>
							<option value="기타">기타</option>
					</select>
				</div>
				<div class="md-form mt-3">
					<i class="fas fa-comments"></i>&nbsp내용<input type="text" id="cal_contents" name="cal_contents" class="form-control">
				</div>
				<div class="md-form mt-3">
					<i class="fas fa-dollar-sign"></i>&nbsp금액<input type="number" id="cal_price" name="cal_price" class="form-control">
				</div>
				<div class="md-form mt-3">
					<input type="button" onclick="calculate()" value="확인" class="btn btn-outline-primary btn-rounded waves-effect">
				    <input type="reset"	value="취소" class="btn btn-outline-primary btn-rounded waves-effect">
				</div>
		</form>
		</div>
</div>
<div class="card" align="center">
<div class="card-body px-lg-5 pt-0">
		<div id="monthCalculate">
		<div id="wrap">
		<h2 id="h2">한달 정산</h2>
		  <i class="fas fa-barcode"></i>&nbsp<label for="inputMDEx">Choose your date</label>
			<input type="month" id="choicedate" name="choicedate" class="form-control">
			<button onclick="allShowCal()" class="btn btn-outline-primary btn-rounded waves-effect">상세보기</button>
			<div id="calList"></div>
			<div id="allshow">${allShowCal}</div>
		</div>
		</div>
</div>
</div>
</body>
<script type="text/javascript">
/* 현재 달 기본 값 입력 */
document.getElementById('choicedate').value= new Date().toISOString().slice(0, 7);

$(document).ready(function(){
	getCalList();
}) 
$("input[type=month]").change(function() {
	getCalList();
	
})
function getCalList() {
	var choicedate = $("input[type=month]").val();
	
	choicedate = new Date(choicedate);
		$.ajax({
			url : "getCalList",
			data : {choicedate : choicedate},
			dataType : "html",
			success : function(result) {
				$("#calList").html(result);
			},
			error : function(error) {
				console.log(error);
		}
	})
}//end getCalList
function allShowCal(){
	$("#allshow").addClass("open");
	$('#allshow').show();
	$('#allshow-shadow').show();
	
	var choicedate = $("input[type=month]").val();
	choicedate = new Date(choicedate);
		$.ajax({
			url:"allShowCal",
			data:{choicedate:choicedate},
			dataType:"html",
			success:function(result){
				console.log(result);
				$("#allshow").html(result);
			},
			error:function(error){
				console.log(error);
			}
	})
} //end allshowcal
var $layerWindows = $('#allshow');
$layerWindows.find('#allshow-shadow').on('mousedown',function(event){
	console.log("event="+event);
	$layerWindows.removeClass('open');
});
function reset(){
	if($layerWindows.hasClass('open')){
		$layerWindows.removeClass('open');
	}
}
function calculate() {
	var receiptdate = $("#cal_receiptdate").val();
	var cal_category = $("#cal_category").val();
	var cal_contents = $("#cal_contents").val();
	var cal_price = $("#cal_price").val();
	var cal_receiptdate = new Date(receiptdate);
	cal_price = new Number(cal_price);
	console.log("category=" + cal_category);
	console.log("contents=" + cal_contents);
	console.log("price=" + cal_price);
	console.log($("#cal_receiptdate").val());
	$.ajax({
		url : "calInsert",
		data : {
			cal_receiptdate : cal_receiptdate,
			cal_category : cal_category,
			cal_contents : cal_contents,
			cal_price : cal_price
		},
		dataType : "html",
		success : function(data) {
			swal({
				title : "Success!",
				text : "정산 입력 성공하였습니다!",
				icon : "success",
			});
			getCalList();
			$('form input[type!=button] form input[type!=reset]').val('');
			$('form select').val('');
			$('form input[type=text]').val('');
			$('form input[type=number]').val('');
			$('form input[type=date]').val('');
			
			/* allShowCal(); */
			/* $("#wrap").html(data); */
		},
		error : function(error) {
			check();
			console.log(error)
		}
	})
}
$("input[type=date]").change(function() {
	validation();
	getCalList();
})
function check() {
		var frm = document.accountingManage;
		var length = frm.length - 1;
		for (var i = 0; i < length; i++) {
			if (frm[i].value == "" || frm[i].value == null) {
				swal({
					title : "No!",
					text : "정보를 입력하세요!",
					icon : "warning",
				});
				frm[i].focus();
				return false; //실패
			}
		}
			return true;
		}
function validation() {
	getCalList();
	var day = $("input[type=date]").val();
	console.log("day=" + day);
	$.ajax({
		url : "validation",
		data : {day : day},
		dataType : "text",
		success : function(result) {
			console.log(result);
			$("#dateMsg").html(result);
		},
		error : function(error) {
			console.log(error);
		}
	})
}
</script>
</html>