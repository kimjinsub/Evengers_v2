<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#addFrm {
	visibility: hidden;
	vertical-align: middle;
	margin: auto;
}

#addFrm.shown {
	visibility: visible;
}

#removeFrm {
	cursor: pointer;
}
.card{
	margin:auto;
	width:90%;
}
</style>
</head>
<body>
	<div class="card">
		<div class="card-body px-lg-5 pt-0">
			<div class="card-header info-color white-text text-center py-4">
				<h4 class="title">
					<i class="fas fa-pencil-alt"></i> Contact form
				</h4>
			</div>
			<form name="perform" method="post" enctype="multipart/form-data" style="color: #757575;">
			<div class="input-group">
			<div class="input-group-prepend">
      			<span class="input-group-text" id="inputGroupFileAddon01">Upload</span>
      			</div>
			<input type="file" id="emp_orifilename" name="emp_orifilename" onchange="fileChk(this)" class="form-control"> 
			</div>
  				<!-- <div class="input-group">
      			<div class="input-group-prepend">
      			<span class="input-group-text" id="inputGroupFileAddon01">Upload</span>
      			</div>
    			<div class="custom-file">
      			<input type="file" id="emp_orifilename"  onchange="fileChk(this)" name="emp_orifilename" class="custom-file-input" >
				<input type="hidden" id="fileCheck" value="0" name="fileCheck"/>
    			</div>
     			</div> -->

				<div class="md-form mt-3">
					이름:<input type="text" name="emp_name" id="emp_name"
						placeholder="이름을 입력하세요" class="form-control">
				</div>
				<div class="md-form mt-3">
					주민등록번호:<input type="text" name="emp_rrn" id="emp_rrn"
						placeholder="xxxxxx-xxxxxxx" class="form-control">
				</div>
				<div id="selectPosition"></div>
				<div class="md-form mt-3">
					입사일자:<input type="date" id="emp_enterdate" name="emp_enterdate"
						class="form-control">
				</div>
				<div class="md-form mt-3">
					전화번호:<input type="number" name="emp_tel" id="emp_tel"
						placeholder="전화번호 10~11자리" class="form-control">
				</div>
				<div class="md-form mt-3">
					<i class="fas fa-envelope prefix"></i> 이메일:<input type="text"
						name="emp_email1" id="emp_email1" class="form-control"> <select
						name="emp_email2" id="emp_email2" class='custom-select'>
						<option value="@naver.com">@naver.com</option>
						<option value="@yahoo.co.kr">@yahoo.co.kr</option>
					</select>
				</div>
				<div id="selectDept"></div>
				<div class="md-form mt-3">
					은행:<select name="emp_bank" id="emp_bank" class='custom-select'>
						<option value="선택하세요">선택하세요</option>
						<option value="신한은행">신한은행</option>
						<option value="농협">농협</option>
						<option value="국민은행">국민은행</option>
						<option value="카카오뱅크">카카오뱅크</option>
						<option value="하나은행">하나은행</option>
					</select>
				</div>
				<div class="md-form mt-3">
					계좌번호:<input type="number" name="emp_acnumber" id="emp_acnumber"
						placeholder="계좌번호(20자리)" class="form-control">
				</div>
				<div class="md-form mt-3">
					<input type="button" onclick="execDaumPostCode()" value="우편번호 찾기"
						class="btn btn-outline-primary btn-rounded waves-effect" /><br>
					<input type="text" id="postcode" placeholder="우편번호"
						class="form-control"> <input type="text" id="address"
						placeholder="주소" class="form-control"> <input type="text"
						id="detailAddress" placeholder="상세주소" class="form-control">
					<input type="text" id="extraAddress" placeholder="참고항목"
						class="form-control">
				</div>
				<div class="md-form mt-3">
					<input type="button" onclick="javascript:formData();"
						class="btn btn-outline-primary btn-rounded waves-effect"
						value="저장"> <input type="reset" id="rs" value="초기화"
						class="btn btn-outline-primary btn-rounded waves-effect">
					<input type="button" onclick="location.href='./'" value="홈으로"
						class="btn btn-outline-primary btn-rounded waves-effect">
				</div>
			</form>

		</div>

	</div>
</body>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	$(document).ready(function() {
		selectPosition();
		selectDept();
	})
	//우편번호 api
	function execDaumPostCode() {
		new daum.Postcode({
			oncomplete : function(data) {
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}
				if (data.userSelectedType === 'R') {
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					document.getElementById("extraAddress").value = extraAddr;

				} else {
					document.getElementById("extraAddress").value = '';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('postcode').value = data.zonecode;
				document.getElementById("address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("detailAddress").focus();
			}
		}).open();
	} //end api

	function fileChk(elem) {
		console.dir(elem);
		if (elem.value == "") {
			console.log("empty file");
			$("#fileCheck").val(0);
		} else {
			console.log("not empty");
			$("#fileCheck").val(1);
		}
	}
	function selectPosition() {
		$
				.ajax({
					url : "selectPosition",
					dataType : "json",
					success : function(result) {
						var str = "";
						str += "직책 : <select name='p_name' id='p_name' class='custom-select'><option selected='selected'>선택하세요</option>";
						for ( var i in result) {
							str += "<option value='"+result[i].p_name+"'>"
									+ result[i].p_name + "</option>";
						}
						str += "</select>";
						$('#selectPosition').html(str);
					},
					error : function(error) {
						console.log(error);
					}
				});

	}
	function selectDept() {
		$
				.ajax({
					url : "selectDept",
					dataType : "json",
					success : function(result) {
						var str = "";
						str += "부서 :<select name='dept_name' id='dept_name' class='custom-select'><option selected='selected'>선택하세요</option>";
						for ( var i in result) {
							str += "<option value='"+result[i].dept_name+"'>"
									+ result[i].dept_name + "</option>";
						}
						str += "</select>";
						$('#selectDept').html(str);
					},
					error : function(error) {
						console.log(error);
					}
				});
	}
	function formData() {
		var $obj = $("#emp_orifilename");
		var formData = new FormData();
		formData.append("emp_name", $("#emp_name").val());
		formData.append("emp_rrn", $("#emp_rrn").val());
		formData.append("emp_enterdate", $("#emp_enterdate").val());
		formData.append("emp_tel", $("#emp_tel").val());
		formData.append("emp_bank", $("#emp_bank").val());
		formData.append("emp_acnumber", $("#emp_acnumber").val());
		formData.append("p_name", $("#p_name").val());
		formData.append("dept_name", $("#dept_name").val());
		var files = $obj[0].files;
		for (var i = 0; i < files.length; i++) {
			formData.append("emp_orifilename", files[i]);
		}
		console.log($("#emp_orifilename"));
		console.log($("#emp_name").val());
		console.log($("#emp_rrn").val());
		console.log($("#emp_enterdate").val());
		console.log($("#emp_tel").val());
		console.log($("#emp_bank").val());
		console.log($("#emp_acnumber").val());
		console.log($("#p_name").val());
		console.log($("#dept_name").val());

		var str = $("#emp_email1").val();
		str += $("#emp_email2").val();
		console.log(str);
		formData.append("emp_email", str);

		var api = $("#postcode").val() + " ";
		api += $("#address").val() + " ";
		api += $("#detailAddress").val() + " ";
		api += $("#extraAddress").val() + " ";
		console.log(api);
		formData.append("emp_addr", api);

		$.ajax({
			type : "post",
			url : "performInsert",
			data : formData,
			processData : false,
			contentType : false,
			dataType : "html",
			success : function(data) {
				swal({
					title:"Yes!",
					text: "등록 성공",
					icon:"success"
				});
				/* alert("인사카드 등록성공"); */
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
		var frm = document.perform;
		var length = frm.length - 1;
		for (var i = 0; i < length; i++) {
			if (frm[i].value == "" || frm[i].value == null) {
				swal({
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