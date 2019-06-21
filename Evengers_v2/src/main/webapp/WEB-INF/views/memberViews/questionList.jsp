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



#QLT {
	margin-left: 300px;
}

table {
	float:left;
}
#list{
text-align: left;
margin-right: 250px;
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
#paging{
   position:relative;
   margin-top:200px;
   padding-left: 250px;
   margin-left: 350px;
   display: inline-block;
   float: left;
}

table.type08 thead th {
    padding: 10px;
    font-weight: bold;
    border-top: 1px solid #ccc;
    border-right: 1px solid #ccc;
    border-bottom: 2px solid #c00;
    background: #dcdcd1;
}
table.type08 tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    background: #ececec;
}
table.type08 td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
}
</style>
</head>
<body>
	<div id="header">1:1 문의내역</div>
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
						var str = "<table class='type08' align='left' id='QLT' border='1'><th scope='row'>문의자 ID</th><th scope='row'>문의 제목</th><th scope='row'>문의날짜</th>";

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