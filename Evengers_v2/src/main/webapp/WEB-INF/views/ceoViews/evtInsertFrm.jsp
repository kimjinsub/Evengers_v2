<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 상품 등록</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<style type="text/css">
input.option-add {
	background-image: url("img/plus.png");
	width: 25px;
	height: 25px;
}

#evtTable {
	margin-top: 100px;
}
</style>
</head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/all.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js" /></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<body>
	<jsp:include page="../header.jsp" />
	<form name="evtInsertFrm" action="/" method="post"
		enctype="multipart/form-data" onsubmit="return confirm()">
		<table border="1" width="400" align="center" id="evtTable">
			<tr>
				<td colspan="2" align="center">이벤트 상품 등록</td>
			</tr>
			<tr>
				<td>상품명</td>
				<td><input type="text" name="상품명" id="e_name"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="number" name="가격" id="e_price"></td>
			</tr>
			<tr>
				<td>이벤트 카테고리</td>
				<td><div id="selectZone"></div></td>
			</tr>
			<tr>
				<td>옵션</td>
				<td><div id="add">
						<input type="text" class="option_name" placeholder="내용" name="옵션">
						<input type="number" class="option_price" placeholder="가격">
					</div> <input type="button" onclick='addOption()' class="option-add"
					id="e_option"></td>
			</tr>

			<tr>
				<td>예약가능일</td>
				<td><input type="number" name="예약가능일" id="e_reservedate"></td>
			</tr>
			<tr>
				<td>환불가능일</td>
				<td><input type="number" name="환불가능일" id="e_refunddate"></td>
			</tr>
			<tr>
				<td>썸네일사진</td>
				<td>
					<input type="file" name="썸네일 사진" id="e_orifilename"
				onchange="fileChk(this)"/>
				<input type="hidden" id="fileCheck" value="0" name="fileCheck"/>
				</td>
			</tr>
			<tr>
				<td>이벤트 첨부 사진</td>
				<td><input type="file" name="이벤트 첨부 사진" id="ei_files"
					onchange="fileChk(this)" multiple /></td>
			</tr>
			<tr>
				<td>글 내용</td>
				<td><textarea name="글 내용" id="e_contents" rows="20"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="button"
					onclick="formData()" value="이벤트등록하기"> <input type="button"
					onclick="location.href='./'" value="홈으로"> <input
					type="reset" id="rs" value="다시작성"></td>
			</tr>
		</table>
	</form>

</body>
<script>
	$(document).ready(function() {
		selectCategory();
	});

	$('#rs').on('click', function() {
		console.log("empty file");
		$("#fileCheck").val(0);
	});
	function fileChk(elem) { //파일태그가 넘어오는지 확인.
		console.dir(elem);
		if (elem.value == "") {
			console.log("empty file");
			$("#fileCheck").val(0); //파일첨부x
		} else {
			console.log("not empty");
			$("#fileCheck").val(1); //파일첨부o
		}

	} //End fileChk
	var i = 1;
	function addOption() {
		var str = "";
		str += "<div><input type='text' class='option_name' placeholder='내용'>"
				+ "<input type='number' class='option_price' placeholder='가격'></div>";
		$('#add').append(str);
	};
	function confirm() { //옵션 보내기
		var str = "";
		var num = "";
		$(".option_name").each(function() {
			str += $(this).val() + ",";
		})
		$(".option_price").each(function() {
			num += $(this).val() + ",";
		})
		$("#add")
				.append(
						'<input type="hidden" name="eo_name" id="eo_name"/>'
								+ '<input type="hidden" name="eo_price" id="eo_price"/>');
		$("input[name=eo_name]").val(str);
		$("input[name=eo_price]").val(num);
		console.log("eo_name", $("input[name=eo_name]").val());
		console.log("eo_price", $("input[name=eo_price]").val());
		if ($("input[name=eo_name]").val() == null
				|| $("input[name=eo_price]").val() == null) {
			return false;
		}

		return true;
	}
	function selectCategory() {
		$.ajax({
			url : "selectCategory",
			dataType : "json",
			success : function(result) {
				console.log(result);
				var str = "";
				str += "<select name='e_category' id='e_category'>"
						+ "<option selected='selected'>선택하세요</option>";
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
	function fileChk(elem) {
		console.log(elem);
		console.log(elem.value);
		console.dir(elem);
		if (elem.value == "") {
			console.log("empty");
			$("#fileCheck").val(0);//0:파일첨부 안했음 val() : val출력 val(a) val에 a입력
		} else {
			console.log("not empty");
			$("#fileCheck").val(1);//1:파일첨부 했음
		}
	}
	function formData() {
		confirm();
		var $obj = $("#e_orifilename");
		var $obj2 = $("#ei_files");
		var formData = new FormData();
		formData.append("e_name", $("#e_name").val());
		formData.append("e_price", $("#e_price").val());
		formData.append("e_category", $("#e_category").val());
		formData.append("e_reservedate", $("#e_reservedate").val());
		formData.append("e_refunddate", $("#e_refunddate").val());
		formData.append("e_contents", $("#e_contents").val());
		formData.append("fileCheck", $("#fileCheck").val());//0,1
		formData.append("eo_name", $("#eo_name").val());
		formData.append("eo_price", $("#eo_price").val());
		console.log($("#eo_name").val());
		console.log($("#eo_price").val());
		var files = $obj[0].files;//배열로 파일정보를 반환
		for (var i = 0; i < files.length; i++) {
			formData.append("e_orifilename", files[i]);
		}
		var files2 = $obj2[0].files;//배열로 파일정보를 반환
		for (var i = 0; i < files2.length; i++) {
			formData.append("ei_files", files2[i]);
		}

		$.ajax({
			type : "post",
			url : "evtInsert",
			data : formData,
			processData : false,
			//application/x-www-form-urlencoded(쿼리스트리형식) 처리금지,,데이터 안까게하기
			contentType : false,
			//contentType:"application/json" json 쓸때 이렇게 했던거 처럼 multipart의 경우 false로 해야됨
			dataType : "html",//html은 생략가능
			success : function(data) {
				alert("성공");
				console.log(data);
				location.href = "./";
			},
			error : function(error) {
				check();
				console.log(error)
			}
		})
	}
	function check() {
		var frm = document.evtInsertFrm;
		var length = frm.length - 1;
		for (var i = 0; i < length; i++) {
			if (frm[i].value == "" || frm[i].value == null) {
				/* alert("정보를 입력하세요!"); */
				swal({
					/* text:"정보를 입력하세요!", */
					title : "No!",
					text : "정보를 입력하세요!",
					icon : "warning",
				});
				frm[i].focus();
				return false; //실패
			}
		}
		return true; //성공: 서버로 전송
	}
</script>
</html>