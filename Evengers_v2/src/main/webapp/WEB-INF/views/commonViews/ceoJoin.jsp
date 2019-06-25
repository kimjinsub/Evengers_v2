<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- jquery.serializeObject는 폼안의 모든데이터를 js객체화한다. -->

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


</head>
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
<body id="all">
<section class="form-elegant">
  <div class="row">
    <div class="col-md-9 col-lg-7 col-xl-5">
      <div class="card">
        <div class="card-body mx-4">
        <form name="ceoJoin" action="ceoInsert" method="post" onsubmit="return check()">
         <div class="text-center">
          <h3 class="title">
           Company Sign up
           </h3>
          </div>
          
		 <div class="md-form">
          <label for="m_name" class="active">Company Name</label>
          <input type="text" name="c_name" placeholder="회사명" class="form-control">
        </div>
        
		 <div class="md-form">
          <label for="m_id" class="active">Business Number</label>
          <input type="text" id = "c_rn" name="c_rn" maxlength="14" placeholder="사업자번호(최대14자)" class="form-control">
		  <input type="button" id="btn2" value= "인증" class="btn btn-outline-primary btn-rounded waves-effect">
        </div>

          <div class="md-form">
            <label for="m_pw">ID</label>
            <input type="text" id = "c_id" name="c_id" maxlength="20" placeholder="아이디(최대20자)" class="form-control">
            <input type="button" id="btn1" value= "중복확인" class="btn btn-outline-primary btn-rounded waves-effect">
          </div>
          
          <div class="md-form">
            <label for="m_tel">Password</label>
            <input type="password" name="c_pw" placeholder="비밀번호" class="form-control">
          </div>
          
          <div class="md-form">
            <label for="m_rrn">Company PhoneNumber</label>
            <input type="text" name="c_tel" maxlength="13" placeholder="회사전화번호(최대13자)" class="form-control">
          </div>
          
          <div class="md-form">
          <label for="m_email" class="active">Your email</label>
          <input type="text" id="c_email" name="c_email" placeholder="이메일주소" class="form-control">
          <select id="c_email1" name="c_email1" class="form-control">
						<option selected="selected">선택하세요</option>
						<option value="@naver.com">@naver.com</option>
						<option value="@yahoo.co.kr">@yahoo.co.kr</option>
						<option value="@gmail.com">@gmail.com</option>
		  </select>
          </div>
			
		  <div><span id="ChkMsg"></span></div>
			
		  <div class="md-form" >
          <label for="m_area" class="active">Area</label>
		   <select name=m_area id="m_area" class="form-control">
						<option value="서울">서울</option>
						<option value="인천">인천</option>
		  </select>
          </div>
			
          <div class="text-center mb-3">
			<input type="submit" value="회원가입" id="submit" disabled="disabled"  class="btn btn-outline-primary btn-rounded waves-effect"> 
			<input type="reset" value="다시작성"  class="btn btn-outline-primary btn-rounded waves-effect"> 
			<input type="button" onclick="location.href='./'" value="홈으로"  class="btn btn-outline-primary btn-rounded waves-effect"> 
          </div>
          
          <!--Footer-->
        <div class="modal-footer mx-5 pt-3 mb-1">
          <p class="font-small grey-text d-flex justify-content-end">Already a company? <a href="./loginFrm" class="blue-text ml-1">
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
		   console.log($('#c_id').val());
		   $.ajax({
		      url:'ceoDoubleChk',
		      type:'post',   
		      data:{c_id : $('#c_id').val()},
		      dataType:'html',
		      success:(function(data){
		    	  	if (data > 0) {
		    	  		swal({
							title : "No!",
							text : "아이디가 존재합니다!",
							icon : "warning",
						});
						$("#submit").attr("disabled", "disabled");
					} else if(data<0) {
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
	
	$('#btn2').click(function(){
		   console.log($('#c_rn').val());
		   $.ajax({
		      url:'ceoCheckNumber',
		      type:'post',   
		      data:{c_rn : $('#c_rn').val()},
		      dataType:'html',
		      success:(function(data){
		    	  if (data > 0) {
		    		  swal({
							title : "No!",
							text : "이미 등록된 사업자 번호입니다!",
							icon : "warning",
						});
						$("#submit").attr("disabled", "disabled");
					} else if(data<0) {
						swal({
							title : "Yes!",
							text : "가입이 가능합니다!",
							icon : "success",
						});
						$("#submit").removeAttr("disabled");
					} else {
						swal({
							title : "No!",
							text : "사업자번호를 입력하세요!",
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
		var frm=document.ceoJoin;
		var length=frm.length-1;
		for(var i=0;i<length;i++){
			if(frm[i].value=="" || frm[i].value==null){
				swal({
					title : "No!",
					text : "정보를 모두 입력하세요!",
					icon : "warning",
				});
				frm[i].focus();
				return false; //실패
			}
		}
		return true; //성공: 서버로 전송
		
	}
	
	$(document).ready(function(){
	    $('#c_id').keyup(function(){
	        if ($(this).val().length > $(this).attr('maxlength')) {
	        	swal({
					title : "No!",
					text : "제한길이 초과!",
					icon : "warning",
				});
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