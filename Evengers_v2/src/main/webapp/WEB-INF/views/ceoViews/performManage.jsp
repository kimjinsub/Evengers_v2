<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#perform{
	margin-top: 4%;
	width: 100%;
	font-size: 13px;
}
#h2{
	margin-top: 2%;
	font-family: 'Nanum Gothic', sans-serif;
}
#performChange{
	position: fixed;
	display : none;
	top:50%;
	left:50%;
    transform: translate(-50%, -50%);
    padding:50px;
	background-color: white;
	font-family: 'Nanum Gothic', sans-serif;
	z-index: 101;
}
#performChange.show{
	display: inline-block;
}
#bg-shadow{
	display:none;
	position: fixed; 
	top:0%; left:0%;
	width: 100%; height: 100%;
	z-index: 100; background-color: gray;
	opacity: 0.6;
}
#bg-shadow.show{
	display:inline;
}
#closer{position:absolute; top:0%; right: 0%; cursor:pointer;}
</style>
</head>
<body>
	<h2 id="h2" align="center">사원목록</h2>
	<div id="perform">${makeHtml_getPerformList}</div>
	
	<div id="performChange">
		<div id="selectPosition"></div>
		<div id="selectDept"></div>
		<input type="hidden" id="hiddenEmp_code">
		<div><button onclick="change()" class='btn btn-outline-primary btn-rounded waves-effect'>변경</button></div>
		<img id="closer" src="img/closer.png" width="30" onclick="close()"/>
	</div>
	<div id="bg-shadow"></div>
</body>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
$("#closer").click(function(){
	$("#bg-shadow").removeClass("show");
	$("#performChange").removeClass("show");
});
function selectPosition() {
	$
			.ajax({
				url : "selectPosition",
				dataType : "json",
				success : function(result) {
					var str = "";
					str += "직책 : <select name='p_name' id='p_name' class='custom-select'>";
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
					str += "부서 :<select name='dept_name' id='dept_name' class='custom-select'>";
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
function change(){
	var emp_code = $("#hiddenEmp_code").val(); //emp_code
	console.log("ee="+emp_code);
	var p_name = $("#p_name").val();
	var dept_name = $("#dept_name").val();
	
	$.ajax({
		url:"performUpdate",
		data:{p_name:p_name,dept_name:dept_name,emp_code:emp_code},
		dataType:"html",
		success:function(str){
			if(str=="수정되었습니다."){
				swal({
					title:"Yes",
					text:"업데이트 성공",
					icon:"success"
				})
				. then (function () { 
					$("#bg-shadow").removeClass("show");
					window.location.href = "./erpIndex";
				});
			}else{
				swal({
					title:"No",
					text:"업데이트 실패",
					icon:"warning"
				})
				. then (function () { 
					$("#bg-shadow").removeClass("show");
					window.location.href = "./erpIndex";
				});
			}
		},error : function(error){
			console.log(error);
		}
	})
}
$('.emp_code').each(function(){
	$(this).click(function(){
		selectDept();
		selectPosition();
		var emp_code = $(this).attr("name");
		$("#performChange").addClass("show");
		$("#hiddenEmp_code").val(emp_code);
		$("#bg-shadow").addClass("show");
	});
});		
	/* $(this).click(function(){
		console.log(emp_code);
		$('#articleView_layer').addClass('open');
		$.ajax({
				type:'get',
				url:'myPerModify',
				data:{emp_code:emp_code},
				dataType:'html',
				success:function(data){
					$('#contents_layer').html(data);
				},error:function(error){
					console.log(error);
				}
			})
			$('.e_code').click(function(e){
			$('#contents_layer').css({"top":e.screenY+200,"left":e.screenX});
			})
		})
	}) */
	
//창 닫기
/* var $layerWindow =$('#articleView_layer');
$layerWindow.find('#bg_layer').on('mousedown',function(event){
	console.log(event);
	$layerWindow.removeClass('open');
});

$(document).keydown(function(event) {
	if(event.keyCode!=27){			
		return;
	}
	if($layerWindow.hasClass('open')){
		$layerWindow.removeClass('open');
	}
}); */
</script>
</html>