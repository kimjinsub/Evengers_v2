<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#header{
text-align: center;
font-size: xx-large;

}
#qt{
margin-left: 300px;
}
 table.type03 {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    border-left: 3px solid #369;
  margin : 10px 10px;
}
table.type03 th {
    width: 147px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #153d73;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;

}
table.type03 td {
    width: 349px;
    padding: 10px;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
}
</style>
</head>
<body>
  <div id="header">1:1 문의</div>
  <form action="/" name="qFrm" id="qFrm" method="post" enctype="multipart/form-data" onsubmit="return qq()">
  <div id="qt">
  <table class="type03" border="1">
  <tr>
  <th scope="row">제목</th>
  <td><textarea rows="3" cols="30" id="q_title" name="q_title"></textarea></td>
  </tr>
  <tr>
  <th scope="row">내용</th>
  <td><textarea rows="15" cols="30" id="q_contents" name="q_contents"></textarea></td>
  </tr>
  <tr>
  <th scope="row">파일첨부</th> 
  <td><input type="file" class="btn btn-outline-primary btn-rounded waves-effect" name="q_files" id="q_files" multiple>

  </td>
  </tr>
  </table>
  </div><br>
  <input type="button" class="btn btn-outline-primary btn-rounded waves-effect" onclick="formData()" value="문의하기" style="margin-left: 310px;">
 <input type="reset" class="btn btn-outline-primary btn-rounded waves-effect" id="rs" value="취소">
  </form>
  
</body>
<script>
function qq(){
	return true;
}
function formData(){
	qq();
	var $obj=$("#q_files");
	var formData=new FormData();
	formData.append("q_title",$("#q_title").val());
	formData.append("q_contents",$("#q_contents").val());
	formData.append("fileCheck",$("#fileCheck").val());//0,1
	console.log($("#q_title").val());
	var files=$obj[0].files;//배열로 파일정보를 반환
	for(var i=0;i<files.length;i++){
		formData.append("q_files",files[i]);
	}
	
	$.ajax({
		type:"post",
		url:"questionInsert",
		data:formData,
		processData:false,
		//application/x-www-form-urlencoded(쿼리스트리형식) 처리금지,,데이터 안까게하기
		
		contentType:false,
		//contentType:"application/json" json 쓸때 이렇게 했던거 처럼 multipart의 경우 false로 해야됨
		dataType:"html",//html은 생략가능
		success:function(data){
			swal({
	            title: "Good!",
	             text: "문의가 되었습니다",
	             icon: "success",
	  });
			console.log(data);
			location.href="javascript:Ajax_forward('questionList')";
		},
		error:function(error){
			swal({
	            title: "Bad!",
	             text: "문의를 실패했습니다",
	             icon: "warning",
	  });
			console.log(error)
		} 
	})
}
</script>
</html>
