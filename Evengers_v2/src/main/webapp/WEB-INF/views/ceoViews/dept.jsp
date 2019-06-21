<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#wrap{	
	margin: auto; display:inline-block; 
	/* width: 80%; height: 80%; */
	position:absolute;
	overflow: auto; text-align:center;
    top:30%; left:50%;
    transform: translate(0%, 0%);
}
#addFrm{visibility: hidden;vertical-align: middle; margin: auto;}
#addFrm.shown{visibility: visible;}
#removeFrm{cursor: pointer;}
</style>
</head>
<body>
<!-- <div id="wrap">
<table border="1">
	<tr>
	</tr>
</table>
<div id="addFrm">
	<table class='table table-striped' >
		<tr>
			<td>부서명</td><td><input type="text"/></td>
		</tr>
	</table>
</div>
</div> -->
<div class="card">
            <div class="card-body">
              <table class="table table-hover">
                <thead class="blue-grey lighten-4">
                  <tr>
					<td>부서명</td><td><input type="text"/></td>
				  </tr>
                  <!-- <tr>
                    <th>#</th>
                    <th>부서명</th>
                    <th>Ipsum</th>
                    <th>Dolor</th>
                  </tr> -->
                </thead>
              </table>
            </div>
          </div>
	<button onclick="addDept()">완료</button>
	<div id="removeFrm" onclick="hideAddFrm()">닫기</div>
</body>
<script>
$(document).ready(function(){
	getDeptList();
})
function getDeptList(){
	$.ajax({
		url:"getDeptList",
		dataType:"json",
		success:function(result){
			console.log(result);
			var str="<tr><td>부서명</td><td>부서코드</td>"
					+"<td><button onclick='showAddFrm()'>부서추가</button></tr>";
			for(var i in result){
				str+="<tr><td>"+result[i].dept_name+"</td>"
					+"<td>"+result[i].dept_code+"</td>"
					+"<td><button onclick='deleteDept("+result[i].dept_code+")'>삭제</button></td></tr>"
			}
			$("table:first tr:first").html(str);
		},
		error:function(error){
			console.log(error);
		}
	})
};
function addDept(){
	var dept_name=$(":input[type=text]").val();
	if(dept_name=="undefined"){alert("빈칸을채우시오")}
	if(dept_name!=""){
		$.ajax({
			url:"addDept",
			data:{dept_name:dept_name},
			dataType:"text",
			success:function(result){
				console.log(result);
				getDeptList();
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