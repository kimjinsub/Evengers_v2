<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#mInfoPwCheck {
	border: 1px solid black;
}

#mModifyList {
	border: 1px solid red;
}
</style>
</head>
<body>
사업가 정보 수정
<div id="ceoModifyInfo">

	<div id="ceoInfoPwCheck">
			비밀번호를 입력해주세요.<br>
		<input type="password" id="pwCheck" name="pwCheck">
		<button onclick="ceoModifyMainSee()">보내기</button>
	</div>
	<div id="ceoModifyMain"></div>
</div>
</body>
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
				alert(data);
				if (data == "비밀번호가 맞았습니다.") {
					$('#ceoInfoPwCheck').hide();
					$('#ceoModifyMain').show();
				} else {
					$("#ceoModifyMain").hide();
					$('#mInfoPwCheck').value = "";
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
					str += "아이디: <input type='text' name='ceo_id'value='"+result[0]['c_id'] +"' readonly><br>"
					
					str += "사업가 등록 번호: <input type='text' name='ceo_rn'value='"
							+ result[0]['c_rn']+ "' readonly>"

					str += "<table>"
					
					str += "<tr><td>비밀번호</td>"
					str += "<td><div id='d_ceo_pw1'><input type='text' id='ceo_pw1' name='ceo_pw1' value='*******' readonly></div>"
					str += "<div id='d_ceo_pw2'><input type='text' id='ceo_pw2' name='ceo_pw2'></div></td>"
					str += "<td> <button onclick='ceo_pwchk()'>비밀번호 수정</button></td></tr>"

					str += "<tr><td>회사명</td>"
					str += "<td><div id='d_ceo_name1'><input type='text' id='ceo_name1' name='ceo_name1' value='"+result[0]['c_name'] +"' readonly></div>"
					str += "<div id='d_ceo_name2'><input type='text' id='ceo_name2' name='ceo_name2'></div></td>"
					str += "<td> <button onclick='ceo_namechk()'>회사명 수정</button></td></tr>"
					
					
					str += "<tr><td>회사전화번호</td>"
					str += "<td><div id='d_ceo_tel1'><input type='text' id='ceo_tel1' name='ceo_tel1' value='"+result[0]['c_tel'] +"' readonly></div>"
					str += "<div id='d_ceo_tel2'><input type='text' id='ceo_tel2' name='ceo_tel2'></div></td>"
					str += "<td> <button onclick='ceo_telchk()'>회사전화번호 수정</button></td></tr>"
					
					str += "<tr><td>이메일</td>"
					str += "<td><div id='d_ceo_email1'><input type='text' id='ceo_email1' name='ceo_email1' value='"+result[0]['c_email'] +"' readonly></div>"
					str += "<div id='d_ceo_email2'><input type='text' id='ceo_email2' name='ceo_email2'></div></td>"
					str += "<td> <button onclick='ceo_emailchk()'>이메일 수정</button></td></tr>"

					str += "</table>"
					str += "<button onclick='ceoModifyInfo()'>저장하기</button> <button onclick='location=\"./\"'>탈퇴하기</button>"
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
			dataType : "html",
			success : function(data) {
				location.href = "./ceoMyPage";
			},
			error : function(error) {
				console.log(error);
			}
		});
	}	
	
</script>
</html>