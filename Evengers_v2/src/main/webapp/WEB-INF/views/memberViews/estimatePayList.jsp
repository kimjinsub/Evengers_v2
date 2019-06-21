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
table.type02 {
    border-collapse: separate;
    border-spacing: 0;
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    border-left: 1px solid #ccc;
}
table.type02 th {
    width: 80px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    border-top: 1px solid #fff;
    border-left: 1px solid #fff;
    background: #eee;
}
table.type02 td {
    width: 200px;
    padding: 10px;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
}
#detail {
	position: fixed;
	top: 30px;
	left: 35%;
	width: 750px;
	height: 650px;
	padding: 2px;
	margin-top: -30px;
	margin-left: -150px;
	float: left;
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

#estPayList {
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
						var str = "<table id='et' class='type02' border='1' align='center'><th scope='row'>구매코드</th><th scope='row'>상품제목</th><th scope='row'>총가격</th><th scope='row'>판매자아이디</th><th scope='row'>구매날짜</th><th scope='row'>상태</th>";
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
