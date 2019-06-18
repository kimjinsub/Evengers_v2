<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style>
img {
	width: 300px;
	height: auto;
	position:relative;
    margin:auto;
    top:50%; bottom:0; left:10%; right:0;
}

.payList {
	background-color: white;
	border: 1px solid black;
	display: block;
	width: 65%;
	height: 380px;
	overflow: auto;
	margin: auto;
	border-radius: 10px;
}
.payList2 {
	position: relative;
	height: 200px;
	float: left;
	line-height: 100px;
}

.payList3 {
	float: left;
	position:relative;
    margin:auto;
    top:5%; bottom:0; left:10%; right:0;
}
.ep_code {
	-webkit-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-moz-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-ms-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-o-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	display: block;
	margin: 20px auto;
	max-width: 180px;
	text-decoration: none;
	border-radius: 4px;
	padding: 20px 30px;
}

.ep_code {
	color: rgba(30, 22, 54, 0.6);
	box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px inset;
}

.ep_code:hover {
	color: rgba(255, 255, 255, 0.85);
	box-shadow: rgba(30, 22, 54, 0.7) 0 0px 0px 40px inset;
}
</style>
</head>
<body>
${makeHtml_memberPayList}
</body>
<script >

$(document).ready(function() {
	$('.payList').each(function() {
		var ep_code = $(this).attr("name");
		console.log("ep_code" + ep_code);
		 $.ajax({
			url : "rBtnChk",
			data : {
				ep_code: ep_code
			},
			dataType : "text",
			success : function(result) {
				console.log(ep_code,":",result);
				//alert("체크");
				if(result==="등록 안됨"){
					$('.showBtn').show();
				}
				if(result==="환불중"){
					$('.showBtn').hide();
					$('div[id="' + ep_code + '"]').hide();
					$('div[name="' + ep_code + '"]').append(result);
				} 
				if(result==="환불거부"){
					$('.showBtn').hide();
					$('div[id="' + ep_code + '"]').hide();
					$('div[name="' + ep_code + '"]').append(result);
				}
				if(result==="환불완료"){//환불 완료
					$('.showBtn').hide();
					$('div[id="' + ep_code + '"]').hide();
					$('div[name="' + ep_code + '"]').append(result);
				}
			},
			error : function(error) {
				console.log(error);
			}
		}) 
	})
})  
	$('.ep_code').each(function() {
		var ep_code = $(this).attr("name");
		$(this).click(function() {
			console.log("ep" + ep_code);

			$.ajax({
				url : "refundEvt",
				data : {
					ep_code : ep_code,
				},
				dataType : "text",
				success : function(result) {
					console.log(result);
					alert(result);
					location.href = "javascript:Ajax_forward('payList')";
					
				},
				error : function(error) {
					console.log(error);
				}
			})
		})
	})

</script>
</html>