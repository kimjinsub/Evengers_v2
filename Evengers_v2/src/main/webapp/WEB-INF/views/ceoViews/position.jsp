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
<div id="wrap">
<table border="1">
	<tr>
	</tr>
</table>
<button onclick="showAddFrm()">직책추가</button>
<div id="addFrm">
	<table border="1">
		<tr>
			<td>직책명:</td><td><input type="text"/></td>
		</tr>
		<tr>
			<td>기본급:</td><td><input type="number"/></td>
		</tr>
	</table>
	<button onclick="addPosition()">완료</button>
	<div id="removeFrm" onclick="hideAddFrm()">닫기</div>
</div>
</div>
</body>
<script>
$(document).ready(function(){
	getPositionList();
})
function getPositionList(){
	$.ajax({
		url:"getPositionList",
		dataType:"json",
		success:function(result){
			console.log(result);
			var str="<tr><td>직책명</td><td>직책코드</td><td>기본급</td></tr>";
			for(var i in result){
				str+="<tr><td>"+result[i].p_name+"</td>"
					+"<td>"+result[i].p_code+"</td>"
					+"<td>"+result[i].p_salary+"</td></tr>"
			}
			$("table:first tr:first").html(str);
		},
		error:function(error){
			console.log(error);
		}
	})
};
function addPosition(){
	var p_name=$(":input[type=text]").val();
	var p_salary=$(":input[type=number]").val();
	if(p_name==null||p_salary==null){alert("빈칸을채우시오")}
	if(p_name!=null && p_salary!=null){
		$.ajax({
			url:"addPosition",
			data:{p_name:p_name,p_salary:p_salary},
			dataType:"text",
			success:function(result){
				console.log(result);
				getPositionList();
				$("input").each(function(){
					$(this).val("");
				})
			},
			error:function(error){
				console.log(error);
			}
		})
	}
};
function showAddFrm(){
	$("#addFrm").addClass("shown");
};
function hideAddFrm(){
	$("#addFrm").removeClass("shown");
};
</script>
</html>