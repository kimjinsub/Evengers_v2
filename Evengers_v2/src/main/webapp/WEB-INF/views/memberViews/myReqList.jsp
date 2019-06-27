<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	border:groove;
	 z-index: 101;
	display: none;
	overflow: auto;
	overflow: scroll;
	background-color:buttonhighlight;
	margin-top: 30px;
}


#detail.open {
	display: block;
}
	
table.reqList {
    border-collapse: separate;
    border-spacing: 1px;
    text-align: center;
    line-height: 1.5;
    margin-top: 10px;
}
table.reqList th {
    width: 155px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #444444;
    background: #ce4869 ;
}
#paging{margin: auto; height:50px; text-align: center;}
#paging div{
	width: 50px; height: 30px; display: inline-block;
	font-size: 20px;
	text-align: center; margin: auto;;
	margin-bottom: 50px;
}


</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1 align="center">의뢰요청 목록</h1>
	
	<div align="center">
		제목검색 : <input type="text" id="searchword" name="searchword" onkeyup="searchajax(this.value)"/>
		<input type="button" class="btn btn-outline-primary btn-rounded waves-effect" onclick=location.href= "./" value='홈으로'>
	
	<div id="list"></div>
	<div id="detail"></div>
	<div id="paging" align="center"></div>
	
	</div>
</body>

<script>
function searchajax(keyword){
	$.ajax({
		type:'POST',
		data : {words : keyword},
		url : 'reqSearch',
		dataType:'json',
		success: function(result){
				var rList = result['rList'];
				//var str = "<div id='pageDown' float='right' onclick='reset()'>X</div>"
				var str = "<table class='table table-striped' id='reqList'  align='center'><th scope='cols'>요청코드</th><th scope='cols'>요청제목</th><th>작성자</th><th scope='cols'>희망날짜</th><th scope='cols'>희망지역</th>";
				for ( var i in rList) {
				str += "<tr><td>" + rList[i].req_code + "</td><td>"
							+ "<a href='#' onclick=evtReqInfo('"
							+ rList[i].req_code + "')>"
							+ rList[i].req_title + "</a></td><td>"
							+ rList[i].m_id + "</td><td>"
							+ rList[i].req_hopedate + "</td><td>"
							+ rList[i].req_hopearea + "</td></tr>"
				}
				str += "</table>"
				$("#list").html(str);
		},
		error :function(e) {}
	
	});
}


$(document).ready(function() {
	getReqList(1,5);
});
function getReqList(pageNum,listCount) {	//기본적으로 보이는
		$.ajax({
		url : "myReqList",
		dataType:'json',
		data : {pageNum:pageNum , listCount:listCount},
		success:function(result) {
		var rList = result['rList'];
		var paging =result['paging'];
		//var str = "<div id='pageDown' float='right' onclick='reset()'>X</div>"
		var str = "<table class='table table-striped' id='reqList'  align='center'><th scope='cols'>요청코드</th><th scope='cols'>요청제목</th><th>작성자</th><th scope='cols'>희망날짜</th><th scope='cols'>희망지역</th>";
		for ( var i in rList) {
			str += "<tr><td>" + rList[i].req_code + "</td><td>"
						+ "<a href='#' onclick=evtReqInfo('"
						+ rList[i].req_code + "')>"
						+ rList[i].req_title + "</a></td><td>"
						+ rList[i].m_id + "</td><td>"
						+ rList[i].req_hopedate + "</td><td>"
						+ rList[i].req_hopearea + "</td></tr>"
			}
			str += "</table>"
			$("#list").html(str);
			$("#paging").html(paging);
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

function reset() {
	if ($layerWindows.hasClass('open')) {
		$layerWindows.removeClass('open');
	}
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