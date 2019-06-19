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
	background-color: #F6CED8;
}


#detail.open {
	display: block;
}

#header {
	text-align: center;
	font-size: xx-large;
}

.question{
display:block;
width:200px;
height:100px;
margin:15px;
background-color:gray;
position: relative; 
}
.question1{
float:left;
display:inline-block;
width:200px;
height:100px;
margin:15px;
background-color:gray;
position: relative; 
}

#QLT {
	margin-left: 300px;
}

table {
	margin-left: 130px;
	text-align: center;
}
#paging{
float:left;
  width:200px;
  height:50px;
  margin-top:380px;
  margin-left:270px;

}
#list{
  position: fixed;
}
</style>
</head>
<body>
	<div id="header">1:1 문의내역</div>
	<div class="question" id="serviceCenter"
		onclick="location.href='serviceCenter';">문의 하기</div>
	<div class="question1" id="questionList"
		onclick="location.href='questionList';">문의 내역</div>
	<div id="list"></div>
	<div id="paging"></div>
	<div id="detail"></div>
</body>
<script>
	$(document).ready(function() {
		getQuestionList(1,10);
	});
	function getQuestionList(pageNum,listCount) {
				$.ajax({
					url : "getQuestionList",
					data:{pageNum:pageNum,listCount:listCount},
					dataType : 'json',
					success : function(result) {
						console.log(result.qList);
						var qList = result['qList'];
						var paging =result['paging'];
						var str = "<table id='QLT' border='1'><th>문의자 ID</th><th>문의 제목</th><th>문의날짜</th>";

						for ( var i in qList) {
							str += "<tr><td>" + qList[i].m_id + "</td><td>"
									+ "<a href='#' onclick=getDetailQ('"
									+ qList[i].q_code + "')>"
									+ qList[i].q_title + "</a></td><td>"
									+ qList[i].q_date + "</td></tr>"

						}
						str += "</table>"
						$("#list").html(str);
                        $("#paging").html(paging);
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