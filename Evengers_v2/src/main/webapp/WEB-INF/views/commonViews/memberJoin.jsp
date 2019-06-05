<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- jquery.serializeObject는 폼안의 모든데이터를 js객체화한다. -->

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>


</head>
<body>
	<form name="memberJoin" action="memberInsert" method="post" onsubmit="return check()">
		<table>
			<tr>
				<td colspan="3">일반 회원가입 페이지</td>
			</tr>
			<tr>
				<td width="100">이름</td>
				<td><input type="text" name="m_name"></td>
			</tr>
			<tr>
				<td width="100">아이디</td>
				<td><input type="text" id = "m_id" name="m_id"></td>
				<td><input type="button" id="btn1" value= "중복확인"></td>
			</tr>
			<tr>
				<td width="100">비밀번호</td>
				<td><input type="password" name="m_pw"></td>
			</tr>

			<tr>
				<td width="100">휴대폰번호</td>
				<td><input type="text" name="m_tel"></td>
			</tr>
			<tr>
				<td width="100">주민등록번호</td>
				<td><input type="text" name="m_rrn"></td>
			</tr>
			<tr>
				<td width="100">이메일주소</td>
				<td><input type="text" name="m_email"></td>
				<td><select name="m_email1">
						<option value="@naver.com">@naver.com</option>
						<option value="@yahoo.co.kr">@yahoo.co.kr</option>
				</select></td>
			</tr>
			<tr>
				<td width="100">지역</td>
				<td><select name=m_area>
						<option value="서울">서울</option>
						<option value="인천">인천</option>
				</select></td>
			</tr>

			<tr>
				<td colspan="3" align="center">
					<input type="submit" value="회원가입" id="submit" disabled="disabled"> 
					<input type="reset" value="다시작성"> 
					<input type="button" onclick="location.href='./'" value="홈으로">
				</td>
			</tr>
		</table>
	</form>
	<script>
		
	</script>

</body>

<script type="text/javascript">
	$('#btn1').click(function(){
		   console.log($('#m_id').val());
		   $.ajax({
		      url:'memberDoubleChk',
		      type:'post',   
		      data:{m_id : $('#m_id').val()},
		      dataType:'html',
		      success:(function(data){
		    	  if (data > 0) {
						alert("아이디가 존재합니다.");
						$("#submit").attr("disabled", "disabled");
					} else {
						alert("사용가능한 아이디 입니다.");
						$("#submit").removeAttr("disabled");
					}
		         
		      }),
		      error:(function(err){
		         console.log(err);
		      })
		      
		   });//ajax end
		   
		   
		});
	
	function check(){		//회원가입시에 입력하지 않은자료 입력하라는 메시지와 포커스
		var frm=document.memberJoin;
		var length=frm.length-1;
		for(var i=0;i<length;i++){
			if(frm[i].value=="" || frm[i].value==null){
				alert(frm[i].name + "을(를) 입력하세요!");
				frm[i].focus();
				return false; //실패
			}
		}
		return true; //성공: 서버로 전송
		
	}
</script>

</html>