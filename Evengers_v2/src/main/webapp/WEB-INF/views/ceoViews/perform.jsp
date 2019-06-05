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
	사진:<img src="img/images.jpg"/><br/>
	성명:<input type="text" placeholder="성명을 입력하세요"><br/>
	주민등록번호:<input type="number" placeholder="앞 6자리"/> - <input type="number" placeholder="뒤 7자리"/><br/>
	직책:<select></select><br/>
	입사일자:<input type="date"/><br/>
	전화번호: <input type="number" placeholder="전화번호 10~11자리"/><br/>
	이메일:<select></select><br/>
	은행:<select></select><br/>
	계좌번호:<input type="number" placeholder="계좌번호"/><br/>
	주소:<input id="addr" type="text" disabled="disabled"/><button onclick="postApi()">주소찾기</button><br/>
	상세주소:<input id="detailAddr" type="text" placeholder="상세주소를 입력하세요"/>
</body>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
$(document).ready(function(){
})
function postApi(){
    new daum.Postcode({
        oncomplete: function(data) {
            $("#addr").val(data.address);
        }
    }).open();
}
</script>
</html>