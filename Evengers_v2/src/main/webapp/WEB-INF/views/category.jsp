<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.category, .category *{
	display: inline-block;
	color: gray;
	font-weight: bold;
	text-align: center;
	font-size: xx-large;
	margin-right: 30px;
	cursor: pointer;
}

.category.hovered_category {
	background-color: #DDDDDD;
}
</style>
</head>
<body>

	<div class="category" onclick="location.href='evengers';">Evengers</div>

	<div class="category" id="categorySpace"></div>
	
	<div class="category" onclick="location.href='serviceCenter';">고객센터</div>

</body>
<script>
	 $(document).ready(function(){
	 getCategoryList();
	 });
	 function getCategoryList(){
	 $.ajax({
	 url:"getCategoryList",
	 dataType:"json",
	 success:function(result){
	 console.log(result);
	 var str="";
	 for(var i in result){
	 str+="<div id='"+result[i].ec_name+"'onclick=\"evt_getEvtList('"+result[i].ec_name+"')\">"+result[i].ec_name+"</div>"
	 }
	 console.log(str);
	 $("#categorySpace").html(str);
	 },
	   error:function(error){
	     console.log(error);
	  }
	})
	};

/* 	$("[class=category]").each(function() {
		$(this).hover(function() {
			$(this).toggleClass("hovered_category");
		});
	}); */
</script>
</html>