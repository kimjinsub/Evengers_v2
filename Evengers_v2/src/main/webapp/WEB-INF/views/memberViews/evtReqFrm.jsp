<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<h1 align ="center">의뢰신청서</h1>
	<form name="evtReqFrm" action="/" method="post" 
			enctype="multipart/form-data" onsubmit="return confirm()">
		<table border="1" align="center">
			<tr>
				<td>제목</td>
				<td><input type="text" name="req_title" id="req_title"></td>	
			</tr>
			
			<tr>
				<td>이벤트 카테고리</td>
				<td><div id="selectZone"></div></td>
			</tr>
			
			<tr>
        		<td>사진첨부</td>
         		<td><input type="file" name="reqi_orifilename" id="reqi_orifilename"></td>
      		</tr>
      		
			<tr>
				<td>희망지역</td>
				<td><input type="text" name="req_hopearea" id="req_hopearea"></td>
				<td><button>지역검색</button></td>
			</tr>
			
			<tr>
				<td>상세주소</td>
				<td><input type="text" name="req_hopeaddr" id="req_hopeaddr"></td>
			</tr>
			
			<tr>
				<td>의뢰 날짜 및 시간</td>
				<td><input type="text" name="req_hopedate" id="req_hopedate"></td>
			</tr>
			
			
			<tr>
				<td>글내용</td>
				<td><textarea name="req_contents" id="req_contents" rows="20"></textarea></td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" onclick="formData()" value="의뢰신청하기">
				<input type="button" onclick="location.href='./'" value="홈으로"></td>
			</tr>
		</table>
	</form>

</body>

<script>

$(document).ready(function(){
	   selectCategory();
	});
	
	
function selectCategory(){
    $.ajax({
       url:"selectCategory",
       dataType:"json",
       success:function(result){
          console.log(result);
          var str="";
          str+="<select name='e_category'><option selected='selected'>선택하세요</option>";
          for(var i in result){
             str+="<option value='"+result[i].ec_name+"'>"+result[i].ec_name+"</option>";
          }
          str+="</select>";
          $("#selectZone").html(str);
       },
       error:function(error){
          console.log(error);
       }
    })
 };
 
 function formData(){
		confirm();
		var $obj=$("#reqi_orifilename");
		//var $obj2=$("#ei_files");
		var formData=new FormData();
		
		formData.append("e_category",$("#e_category").val());
		formData.append("req_title",$("#req_title").val());
		formData.append("req_contents",$("#req_contents").val());
		formData.append("req_hopedate",$("#req_hopedate").val());
		formData.append("req_hopearea",$("#req_hopedate").val());
		formData.append("req_hopeaddr",$("#req_hopeaddr").val());
		//formData.append("fileCheck",$("#fileCheck").val());//0,1
		
		console.log($("#req_title").val());
		console.log($("#req_contents").val());
		console.log($("#req_hopedate").val());
		console.log($("#e_category").val());
		
		var files=$obj[0].files;//배열로 파일정보를 반환
		for(var i=0;i<files.length;i++){
			formData.append("reqi_orifilename",files[i]);
		}
		/* var files2=$obj2[0].files;//배열로 파일정보를 반환
		for(var i=0;i<files2.length;i++){
			formData.append("ei_files",files2[i]);
		} */
		
		$.ajax({
			type:"post",
			url:"evtReqInsert",
			data:formData,
			processData:false,
			//application/x-www-form-urlencoded(쿼리스트리형식) 처리금지,,데이터 안까게하기
			
			contentType:false,
			//contentType:"application/json" json 쓸때 이렇게 했던거 처럼 multipart의 경우 false로 해야됨
			dataType:"html",//html은 생략가능
			success:function(data){
				alert("성공");
				console.log(data);
				location.href="./evtReqFrm";
			},
			error:function(error){
				alert("에러");
				console.log(error)
			} 
		})
	}
 
 
</script>
</html>