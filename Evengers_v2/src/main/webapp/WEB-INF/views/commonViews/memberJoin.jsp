<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!-- jquery.serializeObject는 폼안의 모든데이터를 js객체화한다. -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/all.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">	
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js" /></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#impossible {
	color: red;
}
#possible {
	color: green;
}
#all{
	margin-top : 2%;
	margin-left: 35%;
	background: #007bff;
    background: linear-gradient(to right, #0062E6, #33AEFF); 
}
.card{
	margin:auto;
}
</style>

</head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<body id="all">
<section class="form-elegant">
  <div class="row">
    <div class="col-md-9 col-lg-7 col-xl-5">
      <div class="card">
        <div class="card-body mx-4">
		<form name="memberJoin" action="memberInsert" method="post" onsubmit="return check()">
         <div class="text-center">
          <h3 class="title">
           Member Sign up
           </h3>
          </div>
          
		 <div class="md-form">
          <label for="m_name" class="active">Name</label>
          <input type="text" name="m_name" placeholder="이름" id="m_name" class="form-control">
        </div>
        
		 <div class="md-form">
          <label for="m_id" class="active">ID</label>
          <input type="text" id = "m_id" name="m_id" maxlength="20" placeholder="아이디(최대20자)" class="form-control">
          <input type="button" id="btn1" value= "중복확인" class="btn btn-outline-primary btn-rounded waves-effect">
        </div>

          <div class="md-form">
            <label for="m_pw">Password</label>
            <input type="password" name="m_pw" placeholder="비밀번호" class="form-control" id="m_pw">
          </div>
          
          <div class="md-form">
            <label for="m_tel">PhoneNumber</label>
             <input type="text" name="m_tel" id="m_tel" maxlength="13" placeholder="휴대폰번호(최대13자)" class="form-control">
          </div>
          
          <div class="md-form">
            <label for="m_rrn">RRN</label>
            <input type="text" name="m_rrn" id="m_rrn" placeholder="주민번호" class="form-control">
          </div>
          
          <div class="md-form">
          <label for="m_email" class="active">Your email</label>
          <input type="text" id="m_email" name="m_email" placeholder="이메일주소" class="form-control">
          <select id="m_email1" name="m_email1" class="form-control">
						<option selected="selected">선택하세요</option>
						<option value="@naver.com">@naver.com</option>
						<option value="@yahoo.co.kr">@yahoo.co.kr</option>
						<option value="@gmail.com">@gmail.com</option>
		  </select>
          </div>
			
		  <div><span id="ChkMsg"></span></div>
			
		  <div class="md-form" >
          <label for="m_area" class="active">Area</label>
		   <select name="m_area" id="m_area" class="form-control">
						<option value="서울">서울</option>
						<option value="인천">인천</option>
		  </select><br>
          </div>
			
          <div class="text-center mb-3">
			<input type="submit" value="회원가입" id="submit" disabled="disabled"  class="btn btn-outline-primary btn-rounded waves-effect"> 
			<input type="reset" value="다시작성"  class="btn btn-outline-primary btn-rounded waves-effect"> 
			<input type="button" onclick="location.href='./'" value="홈으로"  class="btn btn-outline-primary btn-rounded waves-effect"> 
          </div>
          
          <!--Footer-->
        <div class="modal-footer mx-5 pt-3 mb-1">
          <p class="font-small grey-text d-flex justify-content-end">Already a member? <a href="./loginFrm" class="blue-text ml-1">
              Sign In</a></p>
        </div>
		</form>
        </div>
      </div>
    </div>
  </div>
</section>

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
		    	  		swal({
							title : "No!",
							text : "아이디가 존재합니다!",
							icon : "warning",
						});
						$("#submit").attr("disabled", "disabled");
					}else if(data<0) {
						swal({
							title : "Yes!",
							text : "사용가능한 아이디 입니다!",
							icon : "success",
						});
						$("#submit").removeAttr("disabled");
					}else {
						swal({
							title : "No!",
							text : "아이디를 입력하시오!",
							icon : "warning",
						});
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
				swal({
					title : "No!",
					text :  "정보를 모두 입력하세요!",
					icon : "warning",
				});
				frm[i].focus();
				return false; //실패
			}
		}
		return true; //성공: 서버로 전송
		
	}
	
	
	$(document).ready(function(){
	    $('#m_id').keyup(function(){
	        if ($(this).val().length > $(this).attr('maxlength')) {
	        	swal({
					title : "No!",
					text : "제한길이 초과",
					icon : "warning",
				});
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
