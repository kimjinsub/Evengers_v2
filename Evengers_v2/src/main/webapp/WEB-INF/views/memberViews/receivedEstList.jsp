<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
/* #paging{margin: auto; height:50px; text-align: center;}
#paging div{
	width: 50px; height: 30px; display: inline-block;
	font-size: 30px;
	text-align: center; margin: auto;;
	margin-bottom: 50px;
} */

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

#estList{
}
.img{
width:100px;
height:100px;
}
</style>
<body>
	<h2 align="center">받은 견적 내역</h2>
	<div id="estList">
	</div>
	<div id="detail"></div>
	<!-- <div id="paging" align="center"></div> -->

</body>
<script>
$(document).ready(function() {
	getRecivedEstList(1,10);
});
function getRecivedEstList(pageNum,listCount) {
	$.ajax({
		url : 'getRecivedEstList',
		dataType : 'json',
		data : {pageNum : pageNum ,listCount : listCount},
		success : function(data) {
			console.log(data.estiList);
			console.log(data.estList);
			var estList = data['estList'];
			var reqList = data['reqList'];
			var estiList = data['estiList'];
			var paging =data['paging'];
			var str = "<table class='table table-striped' id='et'  align='center'><th>이미지</th><th>견적자 ID</th><th>견적제목</th><th>총가격</th>";

			for ( var i in estList) {
				if(estiList[i]!=null){
				str += "<tr><td><img class='img' src='upload/estimateImage/"+estiList[i].esti_sysfilename+"'/></td><td>"
				}else{
					str +="<tr><td></td><td>"
				}    
					str += estList[i].c_id + "</td><td>"
						+ "<a href='#' onclick=getDetailE('"
						+ estList[i].est_code + "')>"
						+ reqList[i].req_title+"</a></td><td>"
						+ estList[i].est_total+'원 '+ "</td></tr>" 

			}
			str += "</table>"
			$("#estList").html(str);
			$("#paging").html(paging);
           
		},
		error : function(error) {

		}
	})
}
//<td><img class='card-img-top img-fluid src='upload/estimateImage/'"+estiList[i].esti_sysfilename+"''/>
 function getDetailE(est_code){
		$("#detail").addClass("open");
		//$("#detail").click('#goCart',function(){
		//(라이트박스), MODAL BOX : 떠있는동안 모든 제어권을 통제하는 박스, 모달리스
		//$('#detail').css('top', $(window).scrollTop() + -100 + 'px');
		$('#detail').show();
		$.ajax({
			url : 'showEstimate', //'ajaxDetail?p_code='+pCode (쿼리스트링)
			type : 'get',
			data : {
				est_code : est_code
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