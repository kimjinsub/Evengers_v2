<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style >

#articleView_layer {
	display: none;
	position: fixed;
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%
}

#articleView_layer.open {
	display: block;
	color: red
}

#articleView_layer #bg_layer {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: #000;
	opacity: .5;
	filter: alpha(opacity = 50);
	z-index: 100
}

#contents_layer {
	position: absolute;
	top: 20%;
	left: 30%;
	width: 800px;
	height: 800px;
	margin: -150px 0 0 -194px;
	padding: 28px 28px 0 28px;
	border: 2px solid #555;
	background: #fff;
	font-size: 12px;
	z-index: 200;
	color: #767676;
	line-height: normal;
	white-space: normal;
	overflow: scroll;
	font-size: 18px;
	
}
.eList{
	float: left;
	margin: 50px;
	border-style: double;
	text-align: center;
	border-top: 30px;
	background-color: white;
	
	
}
.e_code,.evtDel_code {
  width: 140px;
  height: 45px;
  font-family: 'Roboto', sans-serif;
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 2.5px;
  font-weight: 500;
  color: #000;
  background-color: #fff;
  border: none;
  border-radius: 45px;
  box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease 0s;
  cursor: pointer;
  outline: none;
  border: 1px solid #555;
  }

.e_code:hover,.evtDel_code:hover
 {
  background-color: #2EE59D;
  box-shadow: 0px 15px 20px rgba(46, 229, 157, 0.4);
  color: #fff;
  transform: translateY(-7px);
}
.td{
	width: 130px;
}
.td2{
	height: auto;
	word-break:break-all; word-wrap:break-word;
	width: 350px;
}
</style>
</head>
<body>
<h1>내 상품 관리</h1>
	<c:forEach var="event" items="${eList}">
		<div class="eList">
			<table border="1">
				<tr>
					<td class="td">상품 이름</td> <td class="td2">${event.e_name}</td>
				</tr>
				<tr>
					<td class="td"> 상품 가격</td> <td class="td2">${event.e_price}</td>
				</tr>
				<tr>
					<td class="td">상품 카테고리</td><td class="td2"> ${event.e_category}</td>
				</tr>
				<tr>
					<td class="td">상품 예약가능일</td><td class="td2"> ${event.e_reservedate}</td>
				</tr>
				<tr>
					<td class="td">상품 환불가능일</td><td class="td2"> ${event.e_refunddate}</td>
				</tr>
				<tr>
					<td class="td">상품 설명</td><td class="td2">${event.e_contents}</td>
				</tr>
				<tr>
					<td class="td">상품 사진</td><td class="td2"> <img src="upload/thumbnail/${event.e_sysfilename}" / width="250"
				height="250"></td>
				</tr>
				</table>
				<br>
				<button class="e_code" name="${event.e_code}">수정</button>
				<button class="evtDel_code" name="${event.e_code}">삭제</button>
		</div>
	</c:forEach>
	
<div id="articleView_layer">
	<div id="bg_layer"></div>		
	<div id="contents_layer"></div>		
</div>
</body>

<script>
$('.e_code').each(function(){
	 var e_code =$(this).attr("name");
		$(this).click(function(){
		console.log(e_code);
		$('#articleView_layer').addClass('open');
		$.ajax({
			type:'get',
			url:'myEvtModify',
			data:{e_code:e_code}, 
			dataType:'html', 
			success:function(data){
				$('#contents_layer').html(data);
			},error:function(error){
				console.log(error);
			}
		})
	})
})
$('.evtDel_code').each(function(){
	 var e_code =$(this).attr("name");
		$(this).click(function(){
		console.log(e_code);
		$.ajax({
			type:'get',
			url:'myEvtDelete',
			data:{e_code:e_code}, 
			dataType:'text', 
			success:function(data){
				swal({
					title: "Success!",
					text:  data,
					icon: "success",
				})
				. then (function () { 
					window.location.href = "javascript:Ajax_forward('myEvtManagement')";
				});
			},error:function(error){
				console.log(error);
			}
		})
	})
})
var $layerWindow =$('#articleView_layer');
$layerWindow.find('#bg_layer').on('mousedown',function(event){
	console.log(event);
	$layerWindow.removeClass('open');
});

$(document).keydown(function(event) {
	if(event.keyCode!=27){			
		return;
	}
	if($layerWindow.hasClass('open')){
		$layerWindow.removeClass('open');
	}
});
</script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</html>