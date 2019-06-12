<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	#detail {
	position:fixed;
	top: 30px;
	left: 35%;
	width: 750px;
	height: 650px;
	padding: 2px;
	margin-top:-30px;
	margin-left: -150px;
	float:left;
	border: dashed;
	 z-index: 101;
	display: none;
	overflow: auto;
	overflow: scroll;
	background-color: #FFFFFF;
	}


	#detail.open {
		display: block;
	}


</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1 align="center">의뢰요청 목록</h1>
	<div id="list"></div>
	<div id="detail"></div>
</body>

<script>
$(document).ready(function() {
	getReqList();
});
function getReqList() {
		$.ajax({
		url : "myReqList",
		dataType:'json',
		success:function(result) {
		var rList = result['rList'];

		var str = "<table id='reqList' border='1' align='center'><th>요청코드</th><th>요청제목</th><th>작성자</th><th>희망날짜</th><th>희망지역</th>";
		for ( var i in rList) {
			str += "<tr><td>" + rList[i].req_code + "</td><td>"
						+ "<a href='#' onclick=evtReqInfo('"
						+ rList[i].req_code + "')>"
						+ rList[i].req_title + "</a></td><td>"
						+ rList[i].m_id + "</td><td>"
						+ rList[i].req_hopedate + "</td><td>"
						+ rList[i].req_hopearea + "</td></tr>"
			}
			str += "<input type='button' onclick=location.href='./' value='홈으로'></table>"
			$("#list").html(str);
			},
		error : function(error) {
		}
	});
}

function evtReqInfo(req_code) {
	$("#detail").addClass("open");
	$('#detail').show();
	$('#detail-shadow').show();
	$.ajax({
		url : 'evtReqInfo', 
		type : 'get',
		data : {req_code : req_code},
		dataType : 'html',
		success : function(data) {
			$("#detail").html(data);
		},
		error : function(error) {
			console.log(error);
		}
	});
}


var $layerWindows = $('#detail'); 
$layerWindows.find('#detail-shadow').on('mousedown',function(event){
console.log(event);
$layerWindows.removeClass('open');
});
$(document).keydown(function(event){
	console.log(event);
	if(event.keyCode!=27) return;
	if($layerWindows.hasClass('open')){
		$layerWindows.removeClass('open');
	}
});
</script>
</html>