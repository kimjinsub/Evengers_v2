<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<input type="text" id="email" name="email" placeholder="이메일를 입력하세요">
	<button onclick="sendId()">아이디 찾기</button>
	<br>
	<div id="emailInput"></div>

	<div id="hiddenId"></div>
</body>
<script>
	function sendId() {
		var email = $('#email').val();

		$.ajax({
			url : "sendId",
			data : {
				email : email
			},
			dataType : "text",
			success : function(data) {
				console.log(data);
				if (data == '') {
					$('#hiddenId').hide();
					$('#emailInput').text("등록된 이메일이 없거나 이메일을 잘못입력했습니다.");

				} else {
					$('#hiddenId').show();
					$('#emailInput').text("");
					$('#hiddenId').text("당신의 아이디는" + data + "입니다.");
				}

			},
			error : function(error) {
				console.log(error);
			}

		});
	}
</script>
</html>