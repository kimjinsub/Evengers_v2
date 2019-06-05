<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

.nl{
	font-size: x-large;
	font-style: oblique;
	display: inline-block;
	float: right;
	margin: 40px;
	display: none;
}
.ml{
font-size: x-large;
	font-style: oblique;
	display: inline-block;
	float: right;
	margin:40px;
	display: none;
}
.cl{
font-size: x-large;
	font-style: oblique;
	display: inline-block;
	float: right;
	margin:20px;
	display: none;
}

</style>
</head>
<body>
	<a href="./"><img src="img/logo.png"></a>
	   
		 <div class="nl" id="menujoin">
			<a href="joinFrm"
				style="text-decoration: none; color: gray; font-weight: bold;">회원가입
			</a>
		</div>
		<div class="nl" id="menulogin">
			<a href="loginFrm"
				style="text-decoration: none; color: gray; font-weight: bold;">로그인</a>
		</div> 
	
 
 <div class="ml" id="mypage">
 <a href="#" style="text-decoration:none;color:gray; font-weight:bold;">마이페이지 </a>
 </div>
 <div class="ml" id="mypage">
 <a href="#" style="text-decoration:none;color:gray; font-weight:bold;">견적의뢰 </a>
 </div>
 <div class="ml" id="mypage">
 <a href="#" style="text-decoration:none;color:gray; font-weight:bold;">로그아웃 </a>
 </div> 
 
 

 <div class="cl" id="evtinsert">
 <a href="evtInsertFrm" style="text-decoration:none;color:gray; font-weight:bold;">이벤트 등록 </a>
 </div>
 <div class="cl"  id="erp">
 <a href="#" style="text-decoration:none;color:gray; font-weight:bold;">erp자원관리</a>
 </div>
 <div class="cl"  id="mypage">
 <a href="myPage" style="text-decoration:none;color:gray; font-weight:bold;">마이 페이지 </a>
 </div>
 <div class="cl"  id="requestList">
 <a href="estList" style="text-decoration:none;color:gray; font-weight:bold;">의뢰목록</a>
 </div>
 <div class="cl"  id="logout">
 <a href="logout" style="text-decoration:none;color:gray; font-weight:bold;">로그아웃</a>
 </div>
 
</body>
<script>

  var code="AAA";
   session_test(code);
   function session_test(code){
	   $.ajax({
		  url:'sessionTest',
		  data:{testcode:code},
		  dataType:"text",
		  success:function(result){
				console.log(result);
				if(result=="일반회원"){
					 $(".ml").hide();
					 $(".nl").hide();
					 $(".cl").show();
				}else if(result=="기업회원"){
					 $(".cl").show();
					 $(".ml").hide();
					 $(".nl").hide();
				}else{
					 $(".nl").show();
			         $(".cl").hide();
					 $(".ml").hide();
				}
			},
			error:function(error){
			}
		});
	}
</script>
</html>