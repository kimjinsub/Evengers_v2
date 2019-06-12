<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>

	

	#articleView_layer {
   position:fixed;
   top: 30px;
   left: 35%;
   width: 750px;
   height: 650px;
   padding: 2px;
   margin-top:-30px;
   margin-left: -150px;
   float:left;
   border: dashed;
 	  z-index: 101;
   	display: none;
	   overflow: auto;
  	 overflow: scroll;
   	background-color: #F6CED8;
	}

	#articleView_layer.open {
		display: block;
		
	}



</style>

</head>
<body>
	<h1 align ="center">의뢰신청서</h1>
	<form name="evtReqFrm" action="/" method="post" 
			enctype="multipart/form-data" onsubmit="return confirm()">
		<table border="1" align="center">
			<tr>
				<td>제목</td>
				<td><input type="text" name="req_title" id="req_title" placeholder="제목"></td>	
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
				<td><select name="req_hopearea" id="req_hopearea">
						<option selected="selected">선택하세요</option>
						<option value="서울">서울</option>
						<option value="인천">인천</option>
						<option value="대전">대전</option>
						<option value="대구">대구</option>
						<option value="부산">부산</option>
						<option value="광주">광주</option>
						<option value="울산">울산</option>
						<option value="경기">경기</option>
						<option value="강원">강원</option>
						<option value="충남">충남</option>
						<option value="충북">충북</option>
						<option value="전남">전남</option>
						<option value="전북">전북</option>
						<option value="경남">경남</option>
						<option value="경북">경북</option>
						<option value="제주">제주</option>
				</select></td>
			</tr>
			
			<tr>
				<td>상세주소</td>
				<td><input type="text" name="req_hopeaddr" id="req_hopeaddr" placeholder="직접입력"></td>
			</tr>
			
			<tr>
				<td>의뢰 날짜 및 시간</td>
				<td><input type="datetime-local" name="req_hopedate" id="req_hopedate"></td>
			</tr>
			
			
			<tr>
				<td>글내용</td>
				<td><textarea name="req_contents" id="req_contents" rows="20"></textarea></td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" onclick="formData()" value="의뢰신청하기">
				<input type="button" onclick="location.href='./'" value="홈으로">
				<input type="reset" id="rs" value="다시작성"></td>
			</tr>
		</table>
	</form>
	
	<div id="articleView_layer"></div>
	
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
          str+="<select name='e_category' id='e_category'><option selected='selected'>선택하세요</option>";
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
 
 function confirm(){
	 true;
 }
 function formData(){
	 	$('#articleView_layer').addClass('open');
		confirm();
		var $obj=$("#reqi_orifilename");
		//var $obj2=$("#ei_files");
		var formData=new FormData();
		
		formData.append("req_title",$("#req_title").val());
		formData.append("req_contents",$("#req_contents").val());
		formData.append("e_category",$("#e_category").val());
		formData.append("req_hopedate",$("#req_hopedate").val());
		formData.append("req_hopearea",$("#req_hopearea").val());
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
		
		console.log($("#reqi_orifilename").val());
		/* var files2=$obj2[0].files;//배열로 파일정보를 반환
		for(var i=0;i<files2.length;i++){
			formData.append("ei_files",files2[i]);
		} */
		
		$.ajax({
			type:"post",
			url:"evtReqInsert",
			data:formData,
			processData:false,
			contentType:false,
			dataType:'html',
			success:function(data){
				alert("의뢰 신청 성공");
				console.log(data);
				$('#articleView_layer').html(data);
				//var str="";
				//str+="<table><tr><td>"+data.+"</td></tr></table>"
			},
			error:function(error){
				alert("등록 실패");
				console.log(error)
			} 
		})
	}
 


 //esc키로  해제
/*  $(document).keydown(function(event){
 	console.log(event);
 	if(event.keyCode!=27) return;
 	if($layerWindows.hasClass('open')){ //open이라는 클래스를 가지고 있는지 hasClass로 따짐.
 		$layerWindows.removeClass('open');
 	}
 }); */
</script>
</html>