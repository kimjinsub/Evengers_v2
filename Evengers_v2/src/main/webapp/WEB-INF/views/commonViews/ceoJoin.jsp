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
	<form name="ceoJoin" action="ceoInsert" method="post" onsubmit="return check()">
		<table>
			<tr>
				<td colspan="3">기업 회원가입 페이지</td>
			</tr>
			
			<tr>
				<td width="100">회사명</td>
				<td><input type="text" name="c_name" placeholder="회사명"></td>
			</tr>
			
			<tr>
				<td width="120">사업자등록번호</td>
				<td><input type="text" id = "c_rn" name="c_rn" maxlength="14" placeholder="사업자번호(최대14자)"></td>
				<td><input type="button" id="btn2" value= "인증"></td>
			</tr>
			<tr>
				<td width="100">아이디</td>
				<td><input type="text" id = "c_id" name="c_id" maxlength="20" placeholder="아이디(최대20자)"></td>
				<td><input type="button" id="btn1" value= "중복확인"></td>
			</tr>
			<tr>
				<td width="100">비밀번호</td>
				<td><input type="password" name="c_pw" placeholder="비밀번호"></td>
			</tr>
			
			<tr>
				<td width="100">회사전화번호</td>
				<td><input type="text" name="c_tel" maxlength="13" placeholder="사업자번호(최대13자)"></td>
			</tr>
			
			<tr>
				<td width="100">이메일주소</td>
				<td><input type="text" id="c_email" name="c_email" placeholder="이메일주소"></td>
				<td><select id="c_email1"name="c_email1">
						<option selected="selected">선택하세요</option>
						<option value="@naver.com">@naver.com</option>
						<option value="@yahoo.co.kr">@yahoo.co.kr</option>
						<option value="@gmail.com">@gmail.com</option>
				</select></td>
				<td><span id="ChkMsg"></span></td>

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
		   console.log($('#c_id').val());
		   $.ajax({
		      url:'ceoDoubleChk',
		      type:'post',   
		      data:{c_id : $('#c_id').val()},
		      dataType:'html',
		      success:(function(data){
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
	
	$('#btn2').click(function(){
		   console.log($('#c_rn').val());
		   $.ajax({
		      url:'ceoCheckNumber',
		      type:'post',   
		      data:{c_rn : $('#c_rn').val()},
		      dataType:'html',
		      success:(function(data){
		    	  if (data > 0) {
						alert("이미 등록된 사업자 번호입니다.");
						$("#submit").attr("disabled", "disabled");
					} else if(data<0) {
						alert("가입 가능합니다.");
						$("#submit").removeAttr("disabled");
					} else {
						alert("사업자번호를 입력하시오.");
						$("#submit").attr("disabled", "disabled");
					}
		      }),
		      error:(function(err){
		         console.log(err);
		      })
		   });//ajax end
		});
	
	function check(){		//회원가입시에 입력하지 않은자료 입력하라는 메시지와 포커스
		var frm=document.ceoJoin;
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
	    $('#c_id').keyup(function(){
	        if ($(this).val().length > $(this).attr('maxlength')) {
	            alert('제한길이 초과');
	            $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
	        }
	    });
	});
	
	$("#c_email1").change(function() {
		emailChk();
	})
	
	function emailChk() {
		var email = $('#c_email').val();
		var email1 = $('#c_email1').val();
		console.log("c_email : ", email);
		console.log("c_email1 : ", email1);
		$.ajax({
			url : "ceoEmailChk",
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