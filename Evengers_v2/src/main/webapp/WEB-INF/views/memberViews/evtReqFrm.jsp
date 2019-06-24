<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
#pageDown {
	text-align: right;
	float: right;
	position: fixed;
	margin-left: 710px;
	font-size: x-large;
	cursor: pointer;
}

#hh {
	margin-top: 30px;
}

table.type08 {
	border-collapse: collapse;
	text-align: left;
	line-height: 1.5;
	border-left: 1px solid #ccc;
	margin: 20px 10px;
}

table.type08 thead th {
	font-weight: bold;
	border-top: 1px solid #ccc;
	border-right: 1px solid #ccc;
	border-bottom: 2px solid #c00;
	background: #dcdcd1;
}

table.type08 tbody th {
	width: 5px;
	padding: 10px;
	font-weight: bold;
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
	background: #ececec;
}

table.type08 td {
	width: 250px;
	padding: 10px;
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

#articleView-layer{
	position: fixed;
	top: 30px;
	left: 35%;
	width: 750px;
	height: 200px;
	padding: 2px;
	margin-left: -150px;
	float: left;
	border: dashed;
	z-index: 101;
	display: none;
	overflow: auto;
	overflow: scroll;
	background-color: red;
}

#articleView-layer.open{
	display: block;
}
</style>

</head>
<body>
	<div id="hh">
		<div id="pageDown"  onclick="reset()">X</div>
		<h1 id="hh" align="center">의뢰신청서</h1>
	</div>
	<form name="evtReqFrm" action="/" method="post"
		enctype="multipart/form-data" onsubmit="return confirm()">
		<table border="1" align="center" class="type08">
			<tr>
				<td scope="row">제목</td>
				<td><input type="text" name="req_title" id="req_title"
					placeholder="제목"></td>
			</tr>

			<tr>
				<td scope="row">이벤트 카테고리</td>
				<td><div id="selectZone"></div></td>
			</tr>

			<tr>
				<td scope="row">사진첨부</td>
				<td><input type="file" name="reqi_orifilename"
					id="reqi_orifilename"></td>
			</tr>

			<tr>
				<td scope="row">희망지역</td>
				<td><select name="req_hopearea" id="req_hopearea">
						<option selected="selected">선택하세요</option>
						<option value="서울">서울</option>
						<option value="인천">인천</option>
						<option value="대전">대전</option>
						<option value="대구">대구</option>
						<option value="부산">부산</option>
						<option value="광주">광주</option>
						<option value="울산">울산</option>
						<option value="경기">경기</option>
						<option value="강원">강원</option>
						<option value="충남">충남</option>
						<option value="충북">충북</option>
						<option value="전남">전남</option>
						<option value="전북">전북</option>
						<option value="경남">경남</option>
						<option value="경북">경북</option>
						<option value="제주">제주</option>
				</select></td>
			</tr>

			<tr>
				<td scope="row">상세주소</td>
				<td><input type="text" name="req_hopeaddr" id="req_hopeaddr"
					placeholder="직접입력"></td>
			</tr>

			<tr>
				<td scope="row">의뢰 날짜 및 시간</td>
				<td scope="row"><input type="datetime-local"
					name="req_hopedate" id="req_hopedate"></td>
			</tr>


			<tr>
				<td scope="row">글내용</td>
				<td id="1"><textarea name="req_contents" id="req_contents"
						rows="15" cols="50"></textarea></td>
			</tr>
		</table>
		<input type="button" onclick="formData()" value="의뢰신청하기"> <input
			type="button" onclick="location.href='./'" value="홈으로"> <input
			type="reset" id="rs" value="다시작성">
	</form>

	<div id="articleView-layer"></div>

</body>

<script>
	//document.getElementById('req_hopedate').value= new Date().toISOString().slice(0, -1);

	function reset() {
		if ($layerWindows.hasClass('open')) {
			$layerWindows.removeClass('open');
		}
	}

	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth() + 1; //January is 0!
	var yyyy = today.getFullYear();
	if (dd < 10) {
		dd = '0' + dd
	}
	if (mm < 10) {
		mm = '0' + mm
	}

	today = yyyy + '-' + mm + '-' + dd;
	document.getElementById('req_hopedate').setAttribute("max", today);

	$(document).ready(function() {
		selectCategory();
	});

	function selectCategory() {
		$
				.ajax({
					url : "selectCategory",
					dataType : "json",
					success : function(result) {
						console.log(result);
						var str = "";
						str += "<select name='e_category' id='e_category'><option selected='selected'>선택하세요</option>";
						for ( var i in result) {
							str += "<option value='"+result[i].ec_name+"'>"
									+ result[i].ec_name + "</option>";
						}
						str += "</select>";
						$("#selectZone").html(str);
					},
					error : function(error) {
						console.log(error);
					}
				})
	};

	function confirm() {
		true;
	}
	function formData() {
		$('#frm').removeClass("open");
		$('#articleView-layer').addClass("open");
		$('#articleView-layer').show();
		confirm();
		var $obj = $("#reqi_orifilename");
		//var $obj2=$("#ei_files");
		var formData = new FormData();

		formData.append("req_title", $("#req_title").val());
		formData.append("req_contents", $("#req_contents").val());
		formData.append("e_category", $("#e_category").val());
		formData.append("req_hopedate", $("#req_hopedate").val());
		formData.append("req_hopearea", $("#req_hopearea").val());
		formData.append("req_hopeaddr", $("#req_hopeaddr").val());
		//formData.append("fileCheck",$("#fileCheck").val());//0,1

		console.log($("#req_title").val());
		console.log($("#req_contents").val());
		console.log($("#req_hopedate").val());
		console.log($("#e_category").val());

		var files = $obj[0].files;//배열로 파일정보를 반환
		for (var i = 0; i < files.length; i++) {
			formData.append("reqi_orifilename", files[i]);
		}

		console.log($("#reqi_orifilename").val());
		/* var files2=$obj2[0].files;//배열로 파일정보를 반환
		for(var i=0;i<files2.length;i++){
			formData.append("ei_files",files2[i]);
		} */

		$.ajax({
			type : "post",
			url : "evtReqInsert",
			data : formData,
			processData : false,
			contentType : false,
			dataType : 'html',
			success : function(data) {
				swal({
		            title: "Good!",
		             text: "의뢰 신청 성공!",
		             icon: "success",
		  });
				console.log(data);
				$('#articleView-layer').html(data);
				//var str="";
				//str+="<table><tr><td>"+data.+"</td></tr></table>"
			},
			error : function(error) {
				swal({
		            title: "Sorry!",
		             text: "의뢰 신청 실패!",
		             icon: "warning",
		  });
				console.log(error)
			}
		})
	}
</script>
</html>