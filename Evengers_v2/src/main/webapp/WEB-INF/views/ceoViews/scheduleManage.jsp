<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link type="text/css" rel="stylesheet" 
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<style>
#schedule, #calendar{display: inline-block;}
#insertEsFrm{
	border: 2px solid black;
	width: 300px; height: 300px;
	margin: auto; visibility: hidden;
	position: fixed; top:10%; left: 40%;
	background-color: white;
}
#insertEsFrm.show{
	visibility: visible;
}
#dayWrap,#deptWrap{display: inline-block;}
#dayWrap *{display: inline-block;}
#year{background: white;}
#past,#future{cursor: pointer;}
</style>
<title>일정관리</title>
</head>
<body>
<div id='schedule'>
${makeHtml_EpList}
<div id="insertEsFrm">
<p id="epInfo"></p>
부서 선택:<select id="selectDept"></select>
<button onclick="confirmDept()">선택완료</button>
<button onclick="rejectEvtPay()">이벤트 거절(100%환불)</button>
<p onclick="hideInsertEsFrm()" style="cursor:pointer;color: red;">닫기</p>
</div>
</div>
<div id="Wrap">
<div id="dayWrap">
	${year} 
	${month}
</div>
<div id="deptWrap">
	<select id='dept'></select>
</div>
</div>
<div id="calendar"></div>
</body>
<script>
function hideInsertEsFrm(){
	$("#insertEsFrm").removeClass("show");
}

$(document).ready(function(){
	getDeptList();
	selectDept();
})
var epAllList="${epAllList}";
var ep_codes="${ep_codes}";
var ep_code="";
$(".unassigned").each(function(){
	$(this).click(function(){
		ep_code=$(this).attr("id");
		$("#insertEsFrm").addClass("show");
		$("#epInfo").html($(this)[0].textContent);
	})
})
function rejectEvtPay(){
	console.log("reject:ep_code=",ep_code);
	$.ajax({
		url:"rejectEvtPay",
		data:{ep_code:ep_code},
		dataType:"text",
		success:function(result){
			alert(result);
			location.href="javascript:Ajax_forward('scheduleManage')";
		},
		error:function(error){
			console.log(error);
		}
	})
}
function confirmDept(){
	var dept_code=$("#selectDept").val();
	console.log("dept=",dept_code);
	console.log("ep_code=",ep_code);
	$.ajax({
		url:"insertEvtSchedule",
		data:{dept_code:dept_code,ep_code:ep_code},
		dataType:"text",
		success:function(result){
			console.log(result);
			alert(result);
			$("#insertEsFrm").html("");
			$("#insertEsFrm").removeClass("show");
			location.href="javascript:Ajax_forward('scheduleManage')";
		},
		error:function(error){
			console.log(error);
		}
	})
}
function selectDept(){
	$.ajax({
		url:"selectDept",
		dataType:"json",
		success:function(result){
			var str = "";
			for(var i in result){
				str+="<option value='"+result[i].dept_code+"'>"+result[i].dept_name+"</option>";
			}
			str+="</select>";
			$('#selectDept').html(str);
		},
		error:function(error){
			console.log(error);
		}
	});
}
$("#past").click(function(){
	var y=$("#year").val();
	var year=Number(y)-Number(1);
	$("#year").val(year);
	showCalendar();
})
$("#future").click(function(){
	var y=$("#year").val();
	var year=Number(y)+Number(1);
	$("#year").val(year);
	showCalendar();
})
$("#month").change(function(){
	showCalendar();
})
$("#dept").change(function(){
	showCalendar();
})
function showCalendar(){
	var year=$("#year").val();
	console.log("year=",year);
	var month=$("#month").val();
	console.log("month=",month);
	var str_date=year+"-"+month;
	var date=new Date(str_date);
	var dept=$("#dept").val();
	console.log("dept_code=",dept);
	$.ajax({
		url:"calendar",
		data:{date:date,dept_code:dept},
		dataType:"html",
		success:function(page){
			$("#calendar").html(page);
		},
		error:function(error){
			console.log(error);
		}
	})
}
function getDeptList(){
	$.ajax({
		url:"getDeptList",
		dataType:"json",
		success:function(result){
			console.log(result);
			var str="";
			for(var i in result){
				str+="<option class='deptOption' "
					+"value='"+result[i].dept_code+"'>"+result[i].dept_name+"</option>"
			}
			$("#dept").html(str);
			$("#dept option:first").attr("selected","selected");
			showCalendar();
		},
		error:function(error){
			console.log(error);
		}
	})
};
</script>
</html>