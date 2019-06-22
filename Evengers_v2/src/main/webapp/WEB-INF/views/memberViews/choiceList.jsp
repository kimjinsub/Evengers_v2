<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style >
.choiceList{
border: 1px solid black;
background-color: white;
width: 900px;

}
.snip1535, .e_code {
  background-color: #c47135;
  border: none;
  color: #ffffff;
  cursor: pointer;
  display: inline-block;
  font-family: 'BenchNine', Arial, sans-serif;
  font-size: 1em;
  font-size: 22px;
  line-height: 1em;
  margin: 15px 40px;
  outline: none;
  padding: 12px 40px 10px;
  position: relative;
  text-transform: uppercase;
  font-weight: 700;
}
.snip1535:before,
.snip1535:after ,
.e_code:before,
.e_code:after{
  border-color: transparent;
  -webkit-transition: all 0.25s;
  transition: all 0.25s;
  border-style: solid;
  border-width: 0;
  content: "";
  height: 24px;
  position: absolute;
  width: 24px;
}
.snip1535:before,
.e_code:before {
  border-color: #c47135;
  border-right-width: 2px;
  border-top-width: 2px;
  right: -5px;
  top: -5px;
}
.snip1535:after,
.e_code:after {
  border-bottom-width: 2px;
  border-color: #c47135;
  border-left-width: 2px;
  bottom: -5px;
  left: -5px;
}
.snip1535:hover,
.snip1535.hover,
.e_code:hover,
.e_code.hover {
  background-color: #c47135;
}
.snip1535:hover:before,
.snip1535.hover:before,
.snip1535:hover:after,
.snip1535.hover:after ,
.e_code:hover:before,
.e_code.hover:before,
.e_code:hover:after,
.e_code.hover:after 
{
  height: 100%;
  width: 100%;
}
</style>
</head>
<body>
<h1>찜 목록 보기</h1>
	
	<div>
		<c:forEach var="event" items="${choiceList}">
			<div class="choiceList">
			<table >
			<tr><td rowspan="4"><img src="upload/thumbnail/${event.e_sysfilename}" / width="250"
				height="250"></td><td>상품명 : ${event.e_name}</td><td rowspan="4"width="315px"><button onclick="location='evtInfo?e_code=${event.e_code}'"class="snip1535" >구매하러 가기</button><br><br>
				<button class="e_code" name="${event.e_code}" >찜삭제</button></td></tr>
			<tr><td>카테고리 : ${event.e_category}	 |	기업 아이디 : ${event.c_id}</td></tr>
			<tr><td>상품 가격: ${event.e_price}</td></tr>
			<tr><td style="word-break:break-all; word-wrap:break-word;">상품 내용: ${event.e_contents}</td></tr>
			</table>
			</div>
			<br>
		</c:forEach>
	</div>

</body>
<script >

$('.e_code').each(function(){
	 var e_code =$(this).attr("name");
		$(this).click(function(){
		
		console.log(e_code);
		$.ajax({
			url : "choiceDelete",
			data : {
				e_code : e_code
			},
			dataType : "text",
			success : function(result) {
				console.log(result);
				swal({
		            title: "Success!",
		             text:  result,
		             icon: "success",
				  });
				location.href ="javascript:Ajax_forward('choiceList')";
			},
			error : function(error) {
				console.log(error);
			}
		});
	})
})
$(".hover").mouseleave(
  function() {
    $(this).removeClass("hover");
  }
);
</script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</html>