<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#ceoInfoPwCheck {
	width: 500px;
	height: 300px;
	border: 1px solid black;
	font-size: 27px;
	background-color: white;
	border-radius: 20px;
	margin: 0 auto;
	text-align: center;
}
#cTable {
	margin: auto;
	text-align: center;
}

#ceoModifyList {
	width: 60%;
	height: 550px;
	font-size: 24px;
	background-color: white;
	border-radius: 20px;
	border: 1px solid black;
	margin: 0 auto;
	text-align: center;
}
#pwCheckBtn {
	background: #1AAB8A;
	color: #fff;
	border: none;
	position: relative;
	height: 60px;
	font-size: 1.6em;
	padding: 0 2em;
	cursor: pointer;
	transition: 800ms ease all;
	outline: none;
}

#pwCheckBtn:hover {
	background: #fff;
	color: #1AAB8A;
}

#pwCheckBtn:before, #pwCheckBtn:after {
	content: '';
	position: absolute;
	top: 0;
	right: 0;
	height: 2px;
	width: 0;
	background: #1AAB8A;
	transition: 400ms ease all;
}

#pwCheckBtn:after {
	right: inherit;
	top: inherit;
	left: 0;
	bottom: 0;
}

#pwCheckBtn:hover:before, #pwCheckBtn:hover:after {
	width: 100%;
	transition: 800ms ease all;
}

.button_base {
	margin: 0;
	border: 0;
	font-size: 18px;
	width: 180px;
	height: 40px;
	text-align: center;
	box-sizing: border-box;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	-webkit-user-select: none;
	cursor: default;
}

.button_base:hover {
	cursor: pointer;
}

/* ### ### ### 01 */
.b01_simple_rollover {
	color: #000000;
	border: #000000 solid 1px;
	padding: 10px;
	background-color: #ffffff;
}

.b01_simple_rollover:hover {
	color: #ffffff;
	background-color: #000000;
}
</style>
</head>
<body>
<div id="ceoModifyInfo">

	<div id="ceoInfoPwCheck">
			<br><br>비밀번호를 입력해주세요.<br>
		<input type="password" id="pwCheck" name="pwCheck">
		<button id="pwCheckBtn"onclick="ceoModifyMainSee()">입력</button>
	</div>
	<div id="ceoModifyMain"></div>
</div>
</body>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>

	$("#ceoModifyMain").hide();

	
	
	function ceoModifyMainSee() {
		var pwCheck = $('#pwCheck').val();
		$.ajax({
			url : "ceoModifyMainSee",
			data : {
				pwCheck : pwCheck
			},
			dataType : "text",
			success : function(data) {
				console.log(data);
				if (data == "비밀번호가 맞았습니다.") {
					$('#ceoInfoPwCheck').hide();
					$('#ceoModifyMain').show();
					swal({
			            title: "Success!",
			             text:  data,
			             icon: "success",
					  });
				} else {
					$("#ceoModifyMain").hide();
					$('#mInfoPwCheck').value = "";
					swal({
			            title: "Warning!",
			             text:  data,
			             icon: "warning",
					  });
				}
			},
			error : function(error) {
				console.log(error);
			}
		});

				$.ajax({
					url : "ceoModifyList",
					dataType : "json",
					success : function(result) {

					var str = "";
					console.log(result);
					str += "<div id='ceoModifyList'><br>"
					str += "<table id='cTable'>"
					str += "<tr><td>아이디</td> <td><input type='text' name='ceo_id'value='"+result[0]['c_id'] +"' readonly></td></tr>"
					
					str += "<tr><td>사업가 등록 번호</td> <td> <input type='text' name='ceo_rn'value='"
							+ result[0]['c_rn']+ "' readonly></td></tr>"
					
					str += "<tr><td>비밀번호</td>"
					str += "<td><div id='d_ceo_pw1'><input type='password' id='ceo_pw1' name='ceo_pw1' value='*******' readonly></div>"
					str += "<div id='d_ceo_pw2'><input type='password' id='ceo_pw2' name='ceo_pw2'></div></td>"
					str += "<td> <button class='button_base b01_simple_rollover'onclick='ceo_pwchk()'>수정</button></td></tr>"

					str += "<tr><td>회사명</td>"
					str += "<td><div id='d_ceo_name1'><input type='text' id='ceo_name1' name='ceo_name1' value='"+result[0]['c_name'] +"' readonly></div>"
					str += "<div id='d_ceo_name2'><input type='text' id='ceo_name2' name='ceo_name2'></div></td>"
					str += "<td> <button class='button_base b01_simple_rollover'onclick='ceo_namechk()'>수정</button></td></tr>"
					
					
					str += "<tr><td>회사전화번호</td>"
					str += "<td><div id='d_ceo_tel1'><input type='text' id='ceo_tel1' name='ceo_tel1' value='"+result[0]['c_tel'] +"' readonly></div>"
					str += "<div id='d_ceo_tel2'><input type='text' id='ceo_tel2' name='ceo_tel2'></div></td>"
					str += "<td> <button class='button_base b01_simple_rollover'onclick='ceo_telchk()'>수정</button></td></tr>"
					
					str += "<tr><td>이메일</td>"
					str += "<td><div id='d_ceo_email1'><input type='text' id='ceo_email1' name='ceo_email1' value='"+result[0]['c_email'] +"' readonly></div>"
					str += "<div id='d_ceo_email2'><input type='text' id='ceo_email2' name='ceo_email2'></div></td>"
					str += "<td> <button class='button_base b01_simple_rollover'onclick='ceo_emailchk()'>수정</button></td></tr>"

					str += "</table>"
					str += "<button class='button_base b01_simple_rollover'onclick='ceoModifyInfo()'>저장하기</button> <button class='button_base b01_simple_rollover'onclick='ceoDelete()'>탈퇴하기</button>"
					str += "</div>"
					str += "<input type='text' id='ceo_pw3' name='ceo_pw3' value='"+result[0]['c_pw'] +"' readonly></div>"
					$("#ceoModifyMain").html(str);
					$("#d_ceo_pw2").hide();
					$("#d_ceo_name2").hide();
					$("#d_ceo_tel2").hide();
					$("#d_ceo_email2").hide();
					$("#ceo_pw3").hide();
				},
				error : function(error) {
				console.log(error);
			}
		});
	}
	function ceo_pwchk(){
	if($("#ceo_pw_chk").click){
		$("#d_ceo_pw2").show();
		$("#d_ceo_pw1").hide();
		}
	}
	function ceo_namechk(){
		if($("#ceo_name_chk").click){
			$("#d_ceo_name2").show();
			$("#d_ceo_name1").hide();
			}
		}
	
	function ceo_telchk(){
		if($("#ceo_tel_chk").click){
			$("#d_ceo_tel2").show();
			$("#d_ceo_tel1").hide();
			}
		}
	function ceo_emailchk(){
		if($("#ceo_email_chk").click){
			$("#d_ceo_email2").show();
			$("#d_ceo_email1").hide();
			}
		}
	
	function ceoModifyInfo(){
		
		if($("#ceo_pw2").val()==""){
			var pw =$("#ceo_pw3").val();
		}else{
			pw =$("#ceo_pw2").val();
		}
		
		if($("#ceo_name2").val()==""){
			var name =$("#ceo_name1").val();
		}else{
			name =$("#ceo_name2").val();
		}
		
		if($("#ceo_tel2").val()==""){
			var tel =$("#ceo_tel1").val();
		}else{
			tel =$("#ceo_tel2").val();
		}
		
		if($("#ceo_email2").val()==""){
			var email =$("#ceo_email1").val();
		}else{
			email =$("#ceo_email2").val();
		}
		
		$.ajax({
			url : "ceoModifyInfo",
			data : {pw:pw,name:name,tel:tel,email:email},
			dataType : "text",
			success : function(data) {
				if(data=="변경 완료"){
					swal({
						title: "Success!",
						text:  data,
						icon: "success",
					})
					. then (function () { 
						window.location.href = "./ceoMyPage" ;
					});
				}else{
					swal({
			            title: "Warning!",
			             text:  data,
			             icon: "warning",
					  });
				}
			},
			error : function(error) {
				console.log(error);
			}
		});
	}	
	function ceoDelete(){
		$.ajax({
			url : "ceoDelete",
			dataType : "text",
			success : function(data) {
				swal({
					title: "Success!",
					text:  data,
					icon: "success",
				})
				. then (function () { 
					window.location.href = "./";
				});
				console.log(data);
			},
			error : function(error) {
				console.log(error);
			}
		});
	}
	
</script>
</html>