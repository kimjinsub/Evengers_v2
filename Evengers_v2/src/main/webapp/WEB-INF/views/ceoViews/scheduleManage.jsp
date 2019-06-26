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
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
<style>
table th{background-color: #96a9aa;}
#schedule, #scheduleEst, #calendar{display: inline-block;}
#insertEsFrm,#insertEstsFrm{
	padding: 40px 10px 40px 10px;
	border: 2px solid black;
	width: 300px;/*  height: 300px; */
	visibility: hidden;
	position: fixed; top:50%; left: 50%;
	transform: translate(-50%, -50%);
	background-color: white;
}
#insertEsFrm.show,#insertEstsFrm.show{
	visibility: visible;
}
/* #evtArea,#estArea{ */
#evtArea,#estArea{
	display: inline-block; width: 40%;
	margin: auto; text-align: center;
}
#evt_assign,#evt_noAssign{
	/* display: inline-block; width: 80%; */
}
#est_assign,#est_noAssign{
	/* display: inline-block; width: 80%; */
}
#closer{position:absolute; top:0%; right: 0%;}
#Wrap{margin: auto;}
#selectDept,#selectEstsDept{width:60%; display: inline-block;}
#dayWrap,#deptWrap{margin: auto; display: inline-block;}
#dayWrap *{margin: auto; display: inline-block;}
#year{background: white;}
#past,#future{cursor: pointer;}
#estpInfo,#epInfo{
	font-family: "Nanum Gothic", sans-serif;/*  font-size: 20px; */
}
</style>
<title>일정관리</title>
</head>
<body id="scheduleBody">
<br/><br/>
<div id='evtArea'>
	<div id='schedule'>
	<h2>이벤트결제</h2>
	${evtMsg}
	${makeHtml_EpList}
		<div id="insertEsFrm">
			<p id="epInfo"></p>
			<select class="form-control" id="selectDept"></select>
			<button class="btn btn-success" onclick="confirmDept()">부서결정</button>
			<button class="btn btn-warning" onclick="rejectEvtPay()">이벤트 거절(100%환불)</button>
			<div id="closer" onclick="hideInsertEsFrm()" style="cursor:pointer;color: red;">
				<img src="img/closer.png" width="30"/>
			</div>
		</div>
	</div>
</div>

<div id='estArea'>
	<div id='scheduleEst'>
	<h2>견적결제</h2>
	${estMsg}
	${makeHtml_EstpList}
		<div id="insertEstsFrm">
			<p id="estpInfo"></p>
			<select class="form-control" id="selectEstsDept"></select>
			<button class="btn btn-success" onclick="confirmEstsDept()">부서결정</button>
			<button class="btn btn-warning" onclick="rejectEstPay()">이벤트(견적) 거절(100%환불)</button>
			<div id="closer" onclick="hideInsertEstsFrm()" style="cursor:pointer;color: red;">
				<img src="img/closer.png" width="30"/>
			</div>
		</div>
	</div>
</div>
<hr>
<div id="Wrap">
<div id="dayWrap"></div>
<div id="deptWrap">
	<select id='dept'></select>
</div>
</div>
<div id="calendar"></div>
</body>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
//console.log("estpList","${estpList}");
//console.log("estsList","${estsList}");")
//console.log("epAllList2","${epAllList2}");//연습
function hideInsertEsFrm(){
	$("#insertEsFrm").removeClass("show");
}
function hideInsertEstsFrm(){
	$("#insertEstsFrm").removeClass("show");
}

$(document).ready(function(){
	selectDept();
	if("${msg}"==""){//null로 하면 인식이안됨
		getDeptList();
	}
	datePicker();
})
var epAllList="${epAllList}";
var ep_codes="${ep_codes}";
var ep_code="";
var estp_code="";
$(".unassigned").each(function(){
	$(this).click(function(){
		ep_code=$(this).attr("id");
		$("#insertEsFrm").addClass("show");
		$("#epInfo").html($(this)[0].textContent);
	})
})
$(".unassignedEstp").each(function(){
	$(this).click(function(){
		estp_code=$(this).attr("id");
		$("#insertEstsFrm").addClass("show");
		$("#estpInfo").html($(this)[0].textContent);
	})
})
function rejectEvtPay(){
	console.log("reject:ep_code=",ep_code);
	$.ajax({
		url:"rejectEvtPay",
		data:{ep_code:ep_code},
		dataType:"text",
		success:function(result){
			if(result=="환불되었습니다"){
				swal({
					title : result,
					icon : "success",
				});
			}else{
				swal({
					title : result,
					icon : "warning",
				});
			}
			location.href="javascript:Ajax_forward('scheduleManage')";
		},
		error:function(error){
			console.log(error);
		}
	})
}
function rejectEstPay(){
	console.log("reject:estp_code=",estp_code);
	$.ajax({
		url:"rejectEstPay",
		data:{estp_code:estp_code},
		dataType:"text",
		success:function(result){
			if(result=="환불되었습니다"){
				swal({
					title : result,
					icon : "success",
				});
			}else{
				swal({
					title : result,
					icon : "warning",
				});
			}
			location.href="javascript:Ajax_forward('scheduleManage')";
		},
		error:function(error){
			console.log(error);
		}
	})
}
function confirmDept(){
	var dept_code=$("#selectDept").val();
	console.log("dept_code",dept_code);
	if(dept_code==null||dept_code==""||dept_code==undefined){
		swal({
			title : "부서코드를 선택해주세요",
			icon : "warning",
		});
		return;
	}
	$.ajax({
		url:"insertEvtSchedule",
		data:{dept_code:dept_code,ep_code:ep_code},
		dataType:"text",
		success:function(result){
			if(result=="등록되었습니다"){
				swal({
					title : result,
					icon : "success",
				});
			}else{
				swal({
					title : result,
					icon : "warning",
				});
			}
			$("#insertEsFrm").html("");
			$("#insertEsFrm").removeClass("show");
			location.href="javascript:Ajax_forward('scheduleManage')";
		},
		error:function(error){
			console.log(error);
		}
	})
}
function confirmEstsDept(){
	var dept_code=$("#selectEstsDept").val();
	if(dept_code==null||dept_code==""||dept_code==undefined){
		swal({
			title : "부서코드를 선택해주세요",
			icon : "warning",
		});
		return;
	}
	$.ajax({
		url:"insertEstSchedule",
		data:{dept_code:dept_code,estp_code:estp_code},
		dataType:"text",
		success:function(result){
			if(result=="등록되었습니다"){
				swal({
					title : result,
					icon : "success",
				});
			}else{
				swal({
					title : result,
					icon : "warning",
				});
			}
			$("#insertEstsFrm").html("");
			$("#insertEstsFrm").removeClass("show");
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
			$('#selectEstsDept').html(str);
		},
		error:function(error){
			console.log(error);
		}
	});
}
$("#dept,#month,#dayWrap").change(function(){
	showCalendar();
})
function showCalendar(){
	var year=$("#dayWrap #yyyy").val();
	console.log("year=",year);
	var month=$("#dayWrap #MM").val();
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
function test(){
	var yyyy=$("#datepicker #yyyy").val();
	console.log("yyyy:",yyyy);
	var MM=$("#datepicker #MM").val();
	console.log("MM:",MM);
	var dd=$("#datepicker #dd").val();
	console.log("dd:",dd);
	var hh=$("#datepicker #hh").val();
	console.log("hh:",hh);
	var mm=$("#datepicker #mm").val();
	console.log("mm:",mm);
}
function datePicker(){
	var date = new Date();
	$.ajax({
		url:"datePicker",
		data:{date:date,type:"yyyyMM"},
		dataType:"text",
		success:function(result){
			$("#dayWrap").html(result);
		},
		error:function(error){
			console.log(error);
		}
	})
}
</script>
</html>