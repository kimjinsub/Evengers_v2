<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
#estTable{
align-content: center;
margin-left: 350px;
}
</style>
</head>
<body>
  
  
  <form action="/" name="estFrm" id="estFrm" method="post" enctype="multipart/form-data" onsubmit="return est()">
  <div id="estTable">
  <table border="1">
  <tr>
  <th>견적제목</th>
  <td><input type="text" id="est_title" name="est_title" value="${request.req_title}"></td>
  </tr>
  <tr>
  <th>견적내용</th>
  <td><textarea rows="15" cols="30" id="est_contents" name="est_contents"></textarea></td>
  </tr>
  <tr>
  <th>파일첨부</th> 
  <td><input type="file" name="est_files" id="est_files" multiple>
  </td></tr>
  <tr>
  <th>총 가격</th>
  <td><input type="number" name="est_total" id="est_total"></td>
  </tr>
  <tr>
  <th>승인 가능일</th>
  <td><input type="number" name="est_okDate" id="est_okDate"></td>
  </tr>
  <tr>
  <th>환불 가능일</th>
  <td><input type="number" name="est_refundDate" id="est_refundDate">
  </td>
  </tr>
  </table>
  </div><br>
  <input type="button" onclick="formData()" value="견적서 보내기" style="margin-left: 310px;">
 <input type="reset" id="rs" value="취소">
  </form>
  
</body>
<script>
$("#est_okDate").change(function() {
	effectiveness();
})
$("#est_refundDate").change(function() {
	refundEffectiveness();
})

function refundEffectiveness() {
	var refundDate = $("#est_refundDate").val();
	if(refundDate<0){
		alert("불가능합니다");
		var input = document.getElementById("est_refundDate");
		input.value = null;
	}
	  $.ajax({
		url :"refundEffectiveness",
		data : {
			refundDate:refundDate,
			req_code:"${req_code}"
		},
		dataType : "text",
		success : function(result) {
			if(result!="가능"){
				alert("불가능합니다");
				var input = document.getElementById("est_refundDate");
				input.value = null;
			}
		},
		error : function(error) {
			console.log(error);
		}
	})
} 

function effectiveness() {
	var okDate = $("#est_okDate").val();
	var refundDate = $("#est_refundDate").val();
	if(okDate<0){
		alert("불가능합니다");
		var input = document.getElementById("est_okDate");
		input.value = null;
	}
	  $.ajax({
		url : "estEffectiveness",
		data : {
			okDate:okDate,
			req_code:"${req_code}"
		},
		dataType : "text",
		success : function(result) {
			$("#msg").html(result);
			if(result!="가능"){
				alert("불가능합니다");
				var input = document.getElementById("est_okDate");
				input.value = null;
			}
		},
		error : function(error) {
			console.log(error);
		}
	})
} 

function est(){
	return true;
}
function formData(){
	est();
	var $obj=$("#est_files");
	var formData=new FormData();
	formData.append("est_title",$("#est_title").val());
	formData.append("est_contents",$("#est_contents").val());
	formData.append("est_total",$("#est_total").val());//0,1
	formData.append("est_okDate",$("#est_okDate").val());//0,1
	formData.append("est_refundDate",$("#est_refundDate").val());//0,1
	formData.append("req_code","${req_code}");
	var files=$obj[0].files;//배열로 파일정보를 반환
	for(var i=0;i<files.length;i++){
		formData.append("est_files",files[i]);
	}
	
	$.ajax({
		type:"post",
		url:"estInsert",
		data:formData,
		processData:false,
		//application/x-www-form-urlencoded(쿼리스트리형식) 처리금지,,데이터 안까게하기
		
		contentType:false,
		//contentType:"application/json" json 쓸때 이렇게 했던거 처럼 multipart의 경우 false로 해야됨
		dataType:"html",//html은 생략가능
		success:function(data){
			alert("견적서 보내기성공");
			console.log(data);
			location.href="./sentEstList";
		},
		error:function(error){
			alert("견적서 보내기 실패");
			console.log(error)
		} 
	});
}
	</script>
</html>