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
strong{
   position:relative;
   top:80%;
}
img {
    width: 300px;
    height: 300px;
    position:relative;
    margin:auto;
    top:30%; bottom:0; left:10%; right:0;
}

.payList {
   background-color: white;
   border: 1px solid black;
   display: block;
   width: 65%;
   height: 450px;
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
   top:25%; bottom:0; left:10%; right:0;
}
.ep_code {
  background: none;
  border: 2px solid;
  border-bottom-width: 4px;
  font: inherit;
  letter-spacing: inherit;
  margin: 1em;
  padding: 1em 2em;
  text-transform: inherit;
  transition: color 1s;
   $color: #eea163;
  color: $color;
  
  &:hover {
    animation: zigzag 1s linear infinite;
    background: linear-gradient(135deg, rgba($color,0.25) 0.25em, transparent 0.25em) -0.5em 0
              , linear-gradient(225deg, rgba($color,0.25) 0.25em, transparent 0.25em) -0.5em 0
              , linear-gradient(315deg, rgba($color,0.25) 0.25em, transparent 0.25em) 0 0
              , linear-gradient(45deg, rgba($color,0.25) 0.25em, transparent 0.25em) 0 0;
    background-size: 0.75em 0.75em;
    color: adjust-hue($color,180);
  }
}
@keyframes halftone {
  100% {
    background-size: 2.375em 2.375em, 0.1em 0.1em;
  }
}

.btnCss{
position: relative;
left: 30%;
}
</style>
</head>
<body>
<h1>결제 내역</h1>
${makeHtml_memberPayList}
</body>
<script>

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
	               //$('.showBtn').hide();
	               //$('div[id="' + ep_code + '"]').hide();
	               $('button[name="' + ep_code + '"]').html("<strong style='color:green '>"+result+" ...</strong>");
	               $('button[name="' + ep_code + '"]').attr("disabled",true);
	            } 
	            if(result==="환불거부"){
	               //$('.showBtn').hide();
	               //$('div[id="' + ep_code + '"]').hide();
	               $('button[name="' + ep_code + '"]').html("<strong style='color:red '>"+result+"</strong><br>");
	               $('button[name="' + ep_code + '"]').attr("disabled",true);
	            }
	            if(result==="환불완료"){//환불 완료
	               //$('.showBtn').hide();
	               //$('div[id="' + ep_code + '"]').hide();
	               $('button[name="' + ep_code + '"]').html("<strong style='color:blue '>"+result+"</strong>");
	               $('button[name="' + ep_code + '"]').attr("disabled",true);
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
	               swal({
	                     title: "Success!",
	                      text:  "환불 요청 성공",
	                      icon: "success",
	                 });
	               location.href = "javascript:Ajax_forward('payList')";
	               
	            },
	            error : function(error) {
	               console.log(error);
	            }
	         })
	      })
	   })

	</script>

	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	</html>