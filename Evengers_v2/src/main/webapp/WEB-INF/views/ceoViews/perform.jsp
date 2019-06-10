<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#wrap{width: 500px; height: 500px; border: black 1px solid; margin: auto;}
#addFrm{visibility: hidden;vertical-align: middle; margin: auto;}
#addFrm.shown{visibility: visible;}
#removeFrm{cursor: pointer;}
</style>
</head>
<body>
<form name="perform" method="post" enctype="multipart/form-data">
	사진:<input type="file" name="emp_orifilename" id="emp_orifilename" onchange="fileChk(this)"><br/>
	성명:<input type="text" name="emp_name" id="emp_name" placeholder="성명을 입력하세요"><br/>
	주민등록번호:<input type="text" name="emp_rrn" id="emp_rrn" placeholder="xxxxxx-xxxxxxx"/><br/>
	직책:<div id="selectPosition"></div><br/>
	입사일자:<input type="date" id ="emp_enterdate" name="emp_enterdate"/><br/>
	전화번호: <input type="number" name="emp_tel" id="emp_tel" placeholder="전화번호 10~11자리"/><br/>
	이메일:<input type="text" name="emp_email1" id="emp_email1"> 
				<select name="emp_email2" id="emp_email2" >
				<option value="@naver.com">@naver.com</option>
				<option value="@yahoo.co.kr">@yahoo.co.kr</option>
				</select><br/>
	부서:<div id="selectDept"></div><br/>
	은행:<select name="emp_bank" id="emp_bank">
			<option value="선택하세요">선택하세요</option> 
			<option value="신한은행">신한은행</option> 
			<option value="농협">농협</option> 
			<option value="국민은행">국민은행</option> 
			<option value="카카오뱅크">카카오뱅크</option> 
			<option value="하나은행">하나은행</option> 
		</select><br/>
	계좌번호:<input type="number" name="emp_acnumber" id="emp_acnumber" placeholder="계좌번호"/><br/>
	
	<input type="text" id="postcode" placeholder="우편번호">
	<input type="button" onclick="postApi()" value="우편번호 찾기"><br>
	<input type="text" id="address" placeholder="주소"><br>
	<input type="text" id="detailAddress" placeholder="상세주소">
	<input type="text" id="extraAddress" placeholder="참고항목">
	<input type="button" onclick="formData()" value="저장">
	<input type="reset" id="rs" value="초기화">
	<input type="button" onclick="location.href='./'" value="홈으로">
</form>
</body>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
$(document).ready(function(){
	selectPosition();
	selectDept();
})
//우편번호 api
function postApi(){
	new daum.Postcode({
        oncomplete: function(data) {
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
            if(data.userSelectedType === 'R'){
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraAddr !== ''){
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
function selectPosition(){
	$.ajax({
		url:"selectPosition",
		dataType:"json",
		success:function(result){
			var str = "";
			str+="<select name='p_name' id='p_name'><option selected='selected'>선택하세요</option>";
			for(var i in result){
				str+="<option value='"+result[i].p_name+"'>"+result[i].p_name+"</option>";
			}
			str+="</select>";
			$('#selectPosition').html(str);
		},
		error:function(error){
			console.log(error);
		}
	});
	
}
function selectDept(){
	$.ajax({
		url:"selectDept",
		dataType:"json",
		success:function(result){
			var str = "";
			str+="<select name='dept_name' id='dept_name'><option selected='selected'>선택하세요</option>";
			for(var i in result){
				str+="<option value='"+result[i].dept_name+"'>"+result[i].dept_name+"</option>";
			}
			str+="</select>";
			$('#selectDept').html(str);
		},
		error:function(error){
			console.log(error);
		}
	});
}
function formData(){
		var $obj = $("#emp_orifilename");
		var formData = new FormData();
		formData.append("emp_name",$("#emp_name").val());
		formData.append("emp_rrn",$("#emp_rrn").val());
		formData.append("emp_enterdate",$("#emp_enterdate").val());
		formData.append("emp_tel",$("#emp_tel").val());
		formData.append("emp_bank",$("#emp_bank").val());
		formData.append("emp_acnumber",$("#emp_acnumber").val());
		formData.append("p_name",$("#p_name").val());
		formData.append("dept_name",$("#dept_name").val());
		var files=$obj[0].files;
		for(var i=0;i<files.length;i++){
			formData.append("emp_orifilename",files[i]);
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
		formData.append("emp_email",str);
		
		var api = $("#postcode").val()+" ";
		api += $("#address").val()+" ";
		api += $("#detailAddress").val()+" ";
		api += $("#extraAddress").val()+" ";
		console.log(api);
		formData.append("emp_addr",api);
		
		
		$.ajax({   
			type:"post",
			url:"performInsert",
			data:formData,
			processData:false,
			contentType:false,
			dataType:"html",
			success:function(data){
				alert("인사카드 등록성공");
				console.log(data);
				location.href="./";
			},
			error:function(error){
				alert("인사카드 등록실패");
				console.log(error)
			}
		})
	}



</script>
</html>