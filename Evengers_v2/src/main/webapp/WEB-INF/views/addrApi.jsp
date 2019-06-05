<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
</style>
</head>
<body>
<h2> 주소찾기 api </h2>
<input id="addr" type="text" disabled="disabled"/><button onclick="postApi()">주소찾기</button><br/>
<input id="detailAddr" type="text" placeholder="상세주소를 입력하세요"/>
</body>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function postApi(){
    new daum.Postcode({
        oncomplete: function(data) {
            $("#addr").val(data.address);
        }
    }).open();
}
</script>
</html>