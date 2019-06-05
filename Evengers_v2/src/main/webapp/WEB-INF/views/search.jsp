<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.all {
	width: 100%;
	border: 1px solid #000000;
	position: relative;
}

.searchimage {
	width: 100%;
}

.searchtext {
	padding: 10px 10px;
	text-align: center;
	position: absolute;
	top: 40%;
	left: 10%;
}
input[type=text] { 
border:dotted 2px red ;
}
.butn {
  background: #d93447;
  background-image: -webkit-linear-gradient(top, #d93447, #b82b3b);
  background-image: -moz-linear-gradient(top, #d93447, #b82b3b);
  background-image: -ms-linear-gradient(top, #d93447, #b82b3b);
  background-image: -o-linear-gradient(top, #d93447, #b82b3b);
  background-image: linear-gradient(to bottom, #d93447, #b82b3b);
  -webkit-border-radius: 29;
  -moz-border-radius: 29;
  border-radius: 29px;
  font-family: Courier New;
  color: #452e45;
  font-size: 23px;
  padding: 14px 20px 10px 20px;
  text-decoration: none;
}

.butn:hover {
  background: #60a3cc;
  background-image: -webkit-linear-gradient(top, #60a3cc, #3498db);
  background-image: -moz-linear-gradient(top, #60a3cc, #3498db);
  background-image: -ms-linear-gradient(top, #60a3cc, #3498db);
  background-image: -o-linear-gradient(top, #60a3cc, #3498db);
  background-image: linear-gradient(to bottom, #60a3cc, #3498db);
  text-decoration: none;
}
</style>
</head>
<body>
	<div class="all">
		<div class="searchimage">
			<img src="img/event.jpg" width="100%" height="350">
		</div>
		<div class="searchtext">
		<form action="searchevt" method="get">
			<input type="text" placeholder="관심 있는 이벤트를 검색해보세요 !"
			style="text-align:center; width:630px; height:50px;font-size:40px;">
			<input type="button" class="butn" value="검색" >
			</form>
		</div>
	</div>
</body>
</html>