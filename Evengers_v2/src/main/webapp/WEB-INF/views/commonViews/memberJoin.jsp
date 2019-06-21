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
<style>
	#impossible {
		color: red;
	}

	#possible {
		color: green;
	}
</style>
<body>
	<form name="memberJoin" action="memberInsert" method="post" onsubmit="return check()">
		<table border="1">
			<tr>
				<td colspan="3">일반 회원가입 페이지</td>
			</tr>
			<tr>
				<td width="100">이름</td>
				<td><input type="text" name="m_name" placeholder="이름"></td>
			</tr>
			<tr>
				<td width="100">아이디</td>
				<td><input type="text" id = "m_id" name="m_id" maxlength="20" placeholder="아이디(최대20자)"></td>
				<td><input type="button" id="btn1" value= "중복확인"></td>
			</tr>
			<tr>
				<td width="100">비밀번호</td>
				<td><input type="password" name="m_pw" placeholder="비밀번호"></td>
			</tr>

			<tr>
				<td width="100">휴대폰번호</td>
				<td><input type="text" name="m_tel" maxlength="13" placeholder="휴대폰번호(최대13자)"></td>
			</tr>
			<tr>
				<td width="100">주민등록번호</td>
				<td><input type="text" name="m_rrn" placeholder="주민번호"></td>
			</tr>
			<tr>
				<td width="100">이메일주소</td>
				<td><input type="text" id="m_email" name="m_email" placeholder="이메일주소"></td>
				<td><select id="m_email1" name="m_email1">
						<option selected="selected">선택하세요</option>
						<option value="@naver.com">@naver.com</option>
						<option value="@yahoo.co.kr">@yahoo.co.kr</option>
						<option value="@gmail.com">@gmail.com</option>
					</select>
				</td>
				<td><span id="ChkMsg"></span></td>
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
		    	  	console.log(data);
		    	  	if (data > 0) {
						alert("아이디가 존재합니다.");
						$("#submit").attr("disabled", "disabled");
					} else if(data<0) {
						alert("사용가능한 아이디 입니다.");
						$("#submit").removeAttr("disabled");
					}else {
						alert("아이디를 입력하시오.");
						$("#submit").attr("disabled", "disabled");
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
	
	
	$(document).ready(function(){
	    $('#m_id').keyup(function(){
	        if ($(this).val().length > $(this).attr('maxlength')) {
	            alert('제한길이 초과');
	            $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
	        }
	    });
	});
	
	$("#m_email1").change(function() {
		emailChk();
	})
	
	function emailChk() {
		var email = $('#m_email').val();
		var email1 = $('#m_email1').val();
		console.log("m_email : ", email);
		console.log("m_email1 : ", email1);
		$.ajax({
			url : "memberEmailChk",
			data : {email : email,email1 : email1},
			dataType : "text",
			success : function(result) {
				$("#ChkMsg").html(result);
			},
			error : function(error) {
				console.log(error);
			}
		})
	}
</script>

</html>