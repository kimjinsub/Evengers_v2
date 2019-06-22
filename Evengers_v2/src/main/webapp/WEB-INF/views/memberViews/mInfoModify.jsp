<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#mInfoPwCheck {
	width: 500px;
	height: 300px;
	border: 1px solid black;
	font-size: 27px;
	background-color: white;
	border-radius: 20px;
	margin: 0 auto;
	text-align: center;
}

#mModifyList {
	width: 60%;
	height: 550px;
	font-size: 24px;
	background-color: white;
	border-radius: 20px;
	border: 1px solid black;
	margin: 0 auto;
	text-align: center;
}

#mTable {
	margin: auto;
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
<div id="modifyMemInfo">

	<div id="mInfoPwCheck">
			<br><br>비밀번호를 입력해주세요.<br>
		<input type="password" id="pwCheck" name="pwCheck">
		<button id="pwCheckBtn" onclick="mModifyMainSee()">보내기</button>
	</div>
	<div id="mModifyMain"></div>
</div>
</body>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>

	$("#mModifyMain").hide();

	
	
	function mModifyMainSee() {
		var pwCheck = $('#pwCheck').val();
		$.ajax({
			url : "mModifyMainSee",
			data : {
				pwCheck : pwCheck
			},
			dataType : "text",
			success : function(data) {
				console.log(data);
				if (data == "비밀번호가 맞았습니다.") {
					swal({
			            title: "Success!",
			             text:  data,
			             icon: "success",
					  });
					$('#mInfoPwCheck').hide();
					$('#mModifyMain').show();
				} else {
					swal({
			            title: "Warning!",
			             text:  data,
			             icon: "warning",
					  });
					$("#mModifyMain").hide();
					$('#mInfoPwCheck').value = "";
				}
			},
			error : function(error) {
				console.log(error);
			}
		});

				$.ajax({
					url : "mModifyList",
					dataType : "json",
					success : function(result) {

					var str = "";
					console.log(result);
					
					str += "<div id='mModifyList'><br>"
					str += "<table id='mTable'>"
					str += "<tr><td>아이디 : </td> <td><input type='text' name='m_id'value='"+result[0]['m_id'] +"' readonly></td></tr>"
					str += "<tr><td>주민번호 : </td>  <td><input type='text' name='m_rrn'value='"
							+ result[0]['m_rrn'].substring(0, 6)
							+ "-*******' readonly></td></tr>"
					
					str += "<tr><td>비밀번호 : </td>"
					str += "<td><div id='d_m_pw1'><input type='password' id='m_pw1' name='m_pw1' value='*******' readonly></div>"
					str += "<div id='d_m_pw2'><input type='password' id='m_pw2' name='m_pw2'></div></td>"
					str += "<td> <button class='button_base b01_simple_rollover' onclick='m_pwchk()'>비밀번호 수정</button></td></tr>"
					/* str += "<td>" +result[0]['m_pw'] + "</td></tr>" */

					str += "<tr><td>이름 : </td>"
					str += "<td><div id='d_m_name1'><input type='text' id='m_name1' name='m_name1' value='"+result[0]['m_name'] +"' readonly></div>"
					str += "<div id='d_m_name2'><input type='text' id='m_name2' name='m_name2'></div></td>"
					str += "<td> <button class='button_base b01_simple_rollover'onclick='m_namechk()'>이름 수정</button></td></tr>"
					
					
					str += "<tr><td>전화번호 : </td>"
					str += "<td><div id='d_m_tel1'><input type='text' id='m_tel1' name='m_tel1' value='"+result[0]['m_tel'] +"' readonly></div>"
					str += "<div id='d_m_tel2'><input type='text' id='m_tel2' name='m_tel2'></div></td>"
					str += "<td> <button class='button_base b01_simple_rollover'onclick='m_telchk()'>전화번호 수정</button></td></tr>"
					
					str += "<tr><td>이메일 : </td>"
					str += "<td><div id='d_m_email1'><input type='text' id='m_email1' name='m_email1' value='"+result[0]['m_email'] +"' readonly></div>"
					str += "<div id='d_m_email2'><input type='text' id='m_email2' name='m_email2'></div></td>"
					str += "<td> <button class='button_base b01_simple_rollover'onclick='m_emailchk()'>이메일 수정</button></td></tr>"

					str += "<tr><td>지역 : </td>"
					str += "<td><div id='d_m_area1'><input type='text' id='m_area1' name='m_area1' value='"+result[0]['m_area'] +"' readonly></div>"
					str += "<div id='d_m_area2'><input type='text' id='m_area2' name='m_area2'></div></td>"
					str += "<td> <button class='button_base b01_simple_rollover'onclick='m_areachk()'>지역 수정</button></td></tr>"
	
					str += "</table><hr><br>"
					str += "<button class='button_base b01_simple_rollover'onclick='modifyMemInfo()'>저장하기</button><button class='button_base b01_simple_rollover'onclick='memberDelete()'>탈퇴하기</button>"

					str += "</div>"
					str += "<input type='text' id='m_pw3' name='m_pw3' value='"+result[0]['m_pw'] +"' readonly></div>"
					$("#mModifyMain").html(str);
					$("#d_m_pw2").hide();
					$("#d_m_name2").hide();
					$("#d_m_tel2").hide();
					$("#d_m_email2").hide();
					$("#d_m_area2").hide();
					$("#m_pw3").hide();
				},
				error : function(error) {
				console.log(error);
			}
		});
	}
	function m_pwchk(){
	if($("#m_pw_chk").click){
		$("#d_m_pw2").show();
		$("#d_m_pw1").hide();
		}
	}
	function m_namechk(){
		if($("#m_name_chk").click){
			$("#d_m_name2").show();
			$("#d_m_name1").hide();
			}
		}
	
	function m_telchk(){
		if($("#m_tel_chk").click){
			$("#d_m_tel2").show();
			$("#d_m_tel1").hide();
			}
		}
	function m_emailchk(){
		if($("#m_email_chk").click){
			$("#d_m_email2").show();
			$("#d_m_email1").hide();
			}
		}
	function m_areachk(){
		if($("#m_area_chk").click){
			$("#d_m_area2").show();
			$("#d_m_area1").hide();
			}
		}
	
	
	
	function modifyMemInfo(){
		
		if($("#m_pw2").val()==""){
			var pw =$("#m_pw3").val();
		}else{
			pw =$("#m_pw2").val();
		}
		
		if($("#m_name2").val()==""){
			var name =$("#m_name1").val();
		}else{
			name =$("#m_name2").val();
		}
		
		if($("#m_tel2").val()==""){
			var tel =$("#m_tel1").val();
		}else{
			tel =$("#m_tel2").val();
		}
		
		if($("#m_email2").val()==""){
			var email =$("#m_email1").val();
		}else{
			email =$("#m_email2").val();
		}
		
		if($("#m_area2").val()==""){
			var area =$("#m_area1").val();
		}else{
			area =$("#m_area2").val();
		}
		$.ajax({
			url : "modifyMemInfo",
			data : {pw:pw,name:name,tel:tel,email:email,area:area},
			dataType : "text",
			success : function(data) {
				if(data=="변경 완료"){
					swal({
						title: "Success!",
						text:  data,
						icon: "success",
					})
					. then (function () { 
						window.location.href = "./memberMyPage" ;
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
	function memberDelete(){
		$.ajax({
			url : "memberDelete",
			dataType : "text",
			success : function(data) {
				console.log(data)
						swal({
						title: "Success!",
						text:  data,
						icon: "success",
					})
					. then (function () { 
						window.location.href = "./";
					});
			},
			error : function(error) {
				console.log(error);
			}
		});
		
		
	}
</script>
</html>