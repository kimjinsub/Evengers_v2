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
#detailQ{
	position:fixed;
	top: 30px;
	left: 35%;
	width: 750px;
	height: 650px;
	padding: 2px;
	margin-top:20px;
	margin-left: -150px;
	float:left;
	border:groove;
	 z-index: 101;
	display: none;
	overflow: auto;
	overflow: scroll;
	background-color:buttonhighlight;
}


#detailQ.open {
	display: block;
}

#header {
	text-align: center;
	font-size: xx-large;
	margin-bottom: 60px;
}
#list{
margin-left:100px;
}
table.type08 {
    float:left;
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;
    border-left: 1px solid #ccc;
    margin:  10px;
    padding-left: 100px;
     
}

#paging{margin: auto; height:50px; text-align: center;}
#paging div{
	width: 50px; height: 30px; display: inline-block;
	font-size: 30px;
	text-align: center; margin: auto;;
	margin-bottom: 50px;
}

#header{
margin-top:65px;
}
#member{
 z-index: 100;
}
</style>
</head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/all.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js" /></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<body>
     <div id="member"><jsp:include page="../header.jsp"/></div> 


	<div id="header">1:1 문의내역</div>
	<div id="list"></div>
	<div id="paging"></div>
	<div id="detailQ"></div>
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
						var str = "<table class='table table-striped' id='QLT'><th scope='row'>문의자 ID</th><th scope='row'>문의 제목</th><th scope='row'>문의날짜</th>";

						for ( var i in qList) {
							str += "<tr><td>" + qList[i].m_id + "님</td><td>"
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
		console.log(q_code);
	
		$("#detailQ").addClass("open");
		//$("#detail").click('#goCart',function(){
		//(라이트박스), MODAL BOX : 떠있는동안 모든 제어권을 통제하는 박스, 모달리스
		//$('#detail').css('top', $(window).scrollTop() + -100 + 'px');
		$.ajax({
			url : 'showQuestion', //'ajaxDetail?p_code='+pCode (쿼리스트링)
			type : 'get',
			data : {
				q_Code : q_code
			},
			dataType : 'html',
			success : function(data) {

				$("#detailQ").html(data);
			},
			error : function(error) {
				console.log(error);
			}//END ERROR
		});//AND AJAX
	}//F 
	//esc키로  해제
	var $layerWindows = $('#detailQ'); //jquery 객체는 변수에 $ 붙혀서 가독성 좋게!
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