<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<style>
#detail {
	position: fixed;
	top: 30px;
	left: 35%;
	width: 850px;
	height: 900px;
	padding: 2px;
	margin-left: -150px;
	float:left;
	border: dashed;
	 z-index: 101;
	display: none;
	overflow: auto;
	overflow: scroll;
	background-color: navy;
}

#detail-shadow {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	filter: alpha(opacity = 40);
	-moz-opacity: 0.75;
	-khtml-opacity: 0.75;
	opacity: 0.75;
	z-index: 100;
	display: none;
}

#detail.open {
	display: block;
}

#header {
	text-align: center;
	font-size: xx-large;
}

.question {
	display: block;
	width: 200px;
	height: 150px;
	margin: 15px;
	background-color: gray;
	position: absolute;
}

#QLT {
	margin-left: 300px;
}

table {
	margin-left: 300px;
}
</style>
</head>
<body>
	<div id="header">1:1 문의내역</div>
	<div class="question" id="serviceCenter"
		onclick="location.href='serviceCenter';">문의 하기</div>
	<div class="question" id="questionList"
		onclick="location.href='questionList';">문의 내역</div>
	<div id="list"></div>
	<div id="detail"></div>
	<div id="detail-shadow"></div>
</body>
<script>
	$(document).ready(function() {
		getQuestionList();
	});
	function getQuestionList() {
				$.ajax({
					url : "getQuestionList",
					dataType : 'json',
					success : function(result) {
						console.log(result);
						var str = "<table id='QLT' border='1'><th>문의자 ID</th><th>문의 제목</th><th>문의날짜</th>";

						for ( var i in result) {
							str += "<tr><td>" + result[i].m_id + "</td><td>"
									+ "<a href='#' onclick=getDetailQ('"
									+ result[i].q_code + "')>"
									+ result[i].q_title + "</a></td><td>"
									+ result[i].q_date + "</td></tr>"

						}
						str += "</table>"
						$("#list").html(str);

					},
					error : function(error) {
					}
				});
	}

	function getDetailQ(q_code) {
		$("#detail").addClass("open");
		//$("#detail").click('#goCart',function(){
		//(라이트박스), MODAL BOX : 떠있는동안 모든 제어권을 통제하는 박스, 모달리스
		//$('#detail').css('top', $(window).scrollTop() + -100 + 'px');
		$('#detail').show();
		$('#detail-shadow').show();
		$.ajax({
			url : 'showQuestion', //'ajaxDetail?p_code='+pCode (쿼리스트링)
			type : 'get',
			data : {
				q_Code : q_code
			},
			dataType : 'html',
			success : function(data) {

				$("#detail").html(data);
			},
			error : function(error) {
				console.log(error);
			}//END ERROR
		});//AND AJAX
	}//F 
	//esc키로  해제
	var $layerWindows = $('#detail'); //jquery 객체는 변수에 $ 붙혀서 가독성 좋게!
   $layerWindows.find('#detail-shadow').on('mousedown',function(event){
	console.log(event);
	$layerWindows.removeClass('open');
});
	$(document).keydown(function(event){
		console.log(event);
		if(event.keyCode!=27) return;
		if($layerWindows.hasClass('open')){ //open이라는 클래스를 가지고 있는지 hasClass로 따짐.
			$layerWindows.removeClass('open');
		}
	});
</script>
</html>