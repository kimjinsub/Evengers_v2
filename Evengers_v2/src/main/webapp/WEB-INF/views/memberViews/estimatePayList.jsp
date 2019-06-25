<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style>
#estPayList{
margin-right: 200px;
}
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
}

#detail.open {
	display: block;
}

#estPayList {
margin-left: 165px;
}
#paging{
position: relative; 
}
#refundState{
color:red;
}
</style>
<body>
  <h3 align="center"> 견적 결제 구매 내역</h3>
	<div id="estPayList"></div>
	<div id="paging" align="center"></div>
	<div id="detail"></div>

</body>
<script>
	$(document).ready(function() {
		getEstPayList(1,5);
	});
	function getEstPayList(pageNum,listCount) {
		      $.ajax({
					url : 'getEstPayList',
					data:{pageNum:pageNum,listCount:listCount},
					dataType : 'json',
					success : function(data) {
						console.log(data);
						console.log(data.statemsg)
						var estpList = data['estpList'];
						var reqList = data['reqList'];
						var paging = data['paging'];
						var statemsg = data['statemsg'];
						var str = "<table id='et' class='table table-striped' align='center'><th scope='row'><b>구매코드</b></th><th scope='row'><b>상품제목</b></th><th scope='row'><b>총가격</b></th><th scope='row'><b>판매자아이디</b></th><th scope='row'><b>구매날짜</b></th><th scope='row'><b>상태</b></th>";
						for ( var i in estpList) {
							str += "<tr><td>" + estpList[i].estp_code + "</td><td>"
									+ "<a href='#' onclick=getDetailEstp('"
									+ estpList[i].estp_code + "')>"
									+ reqList[i].req_title + "</a></td><td>"
									+ estpList[i].estp_total + '원 '+"</td><td>"
									+ estpList[i].c_id+"</td><td>"
									+ estpList[i].estp_payday+"</td><td id='refundState'>"
									+ statemsg[i]+"</td></tr>"

						}
						str += "</table>"
						$("#estPayList").html(str);
						$("#paging").html(paging);
					},
					error : function(error) {

					}
				})
				console.log($("#refundState").val());
	} 

	function getDetailEstp(estp_code) {
		$("#detail").addClass("open");
		//$("#detail").click('#goCart',function(){
		//(라이트박스), MODAL BOX : 떠있는동안 모든 제어권을 통제하는 박스, 모달리스
		//$('#detail').css('top', $(window).scrollTop() + -100 + 'px');
		$('#detail').show();
		$.ajax({
			url : 'showEstpDetail', //'ajaxDetail?p_code='+pCode (쿼리스트링)
			type : 'get',
			data : {
				estp_code : estp_code
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
	$layerWindows.find('#detail-shadow').on('mousedown', function(event) {
		console.log(event);
		$layerWindows.removeClass('open');
	});
	$(document).keydown(function(event) {
		console.log(event);
		if (event.keyCode != 27)
			return;
		if ($layerWindows.hasClass('open')) { //open이라는 클래스를 가지고 있는지 hasClass로 따짐.
			$layerWindows.removeClass('open');
		}
	}); 
</script>
</html>
