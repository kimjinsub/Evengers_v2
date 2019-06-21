<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta charset="UTF-8">
<style>
/* #wrap{	
	margin: auto; display:inline-block; 
	width: 80%; height: 80%;
	position:absolute;
	overflow: auto; text-align:center;
    top:30%; left:50%;
    transform: translate(0%, 0%);
} */

#positionPartWrap{
	margin: auto; display:inline-block; 
		/* width: 80%; height: 80%; */
		position:absolute;
		overflow: auto; text-align:center;
	    top:30%; left:65%;
	    transform: translate(0%, 0%);
}
#deptPartWrap{
	margin: auto; display:inline-block; 
		/* width: 80%; height: 80%; */
		position:absolute;
		overflow: auto; text-align:center;
	    top:30%; left:35%;
	    transform: translate(0%, 0%);
}
#addPositionFrm{visibility: hidden;vertical-align: middle; margin: auto;}
#addPositionFrm.shown{visibility: visible;}
#removePositionFrm{cursor: pointer;}
#addDeptFrm{visibility: hidden;vertical-align: middle; margin: auto;}
#addDeptFrm.shown{visibility: visible;}
#removeDeptFrm{cursor: pointer;}
</style>
<title>manageDeptPosition</title>
</head>
<body>
<div id="positionPartWrap">
	<table border="1" id="positionPart">
	</table>
	<button onclick="showAddPositionFrm()">직책추가</button>
	<div id="addPositionFrm">
		<table border="1">
			<tr>
				<td>직책명:</td><td><input type="text" placeholder="10자 이내"/></td>
			</tr>	
			<tr>
				<td>기본급:</td><td><input type="number" placeholder="100억원 이내"/></td>
			</tr>
		</table>
		<button onclick="addPosition()">완료</button>
		<div id="removePositionFrm" onclick="hideAddPositionFrm()">닫기</div>
	</div>
</div>	
<div id="deptPartWrap">	
	
	<table border="1" id="deptPart">
	</table>
	<button onclick='showAddDeptFrm()'>부서추가</button>
	<div id="addDeptFrm">
		<table border="1">
			<tr>
				<td>부서명</td><td><input type="text" placeholder="20자 이내"/></td>
			</tr>
		</table>
		<button onclick="addDept()">완료</button>
		<div id="removeDeptFrm" onclick="hideAddDeptFrm()">닫기</div>
	</div>
</div>
</body>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
$(document).ready(function(){
	getDeptList();
	getPositionList();
})
function getDeptList(){
	$.ajax({
		url:"getDeptList",
		dataType:"json",
		success:function(result){
			console.log(result);
			var str="<tr><td>부서명</td><td>부서코드</td></tr>";
					//+"<td><button onclick='showAddDeptFrm()'>부서추가</button></td></tr>";
			for(var i in result){
				str+="<tr><td>"+result[i].dept_name+"</td>"
					+"<td>"+result[i].dept_code+"</td></tr>"
			//		+"<td><button onclick='deleteDept("+result[i].dept_code+")'>삭제</button></td></tr>"
			}
			if(result==""){
				str="<p id='deptSign'>첫 부서를 등록해보세요</p>";
				$("#deptPartWrap").append(str);
				return;
			}
			$("#deptPart").html(str);
			$("p[id=deptSign]").remove();
		},
		error:function(error){
			console.log(error);
		}
	})
};
function addDept(){
	var dept_name=$("#addDeptFrm :input[type=text]").val();
	if(dept_name==""){
		swal({
        	title: "부서명을 입력하세요!",
        	//text: "부서명을 입력하세요!",
        	icon: "warning",
  		});
	}
	if(dept_name.length>20){
		swal({
        	title: "부서명을 20자 이내로 입력하세요!",
        	//text: "부서명을 입력하세요!",
        	icon: "warning",
  		});
		$("#addDeptFrm :input[type=text]").val("");
       	return;
	}
	if(dept_name!=""){
		$.ajax({
			url:"addDept",
			data:{dept_name:dept_name},
			dataType:"text",
			success:function(result){
				swal({
		        	title: "부서등록완료!",
		        	//text: "부서명을 입력하세요!",
		        	icon: "success",
		  		});
				getDeptList();
				$("#addDeptFrm input").each(function(){
					$(this).val("");
				})
			},
			error:function(error){
				console.log(error);
			}
		})
	}
};
function showAddPositionFrm(){
	$("#addPositionFrm").addClass("shown");
};
function hideAddPositionFrm(){
	$("#addPositionFrm").removeClass("shown");
};
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
					+"<td>"+result[i].p_salary+"원</td></tr>"
			}
			if(result==""){
				str="<p id='positionSign'>첫 직책을 등록해보세요</p>";
				$("#positionPartWrap").append(str);
				return;
			}
			$("#positionPart").html(str);
			$("p[id=positionSign]").remove();
		},
		error:function(error){
			console.log(error);
		}
	})
};
function addPosition(){
	var p_name=$("#addPositionFrm :input[type=text]").val();
	var p_salary=$("#addPositionFrm :input[type=number]").val();
	if(p_name==""||p_salary==""){
		swal({
	       	title: "직책명과 기본급을 입력하세요!",
	       	icon: "warning",
		});
	    return;
	}
	if(p_name.length>10){
		swal({
        	title: "10자 이내로 입력하세요!",
        	icon: "warning",
  		});
		$("#addPositionFrm :input[type=text]").val("");
       	return;
	}
	if(p_salary.length>10){
		swal({
        	title: "100억원 이내로 입력하세요!",
        	icon: "warning",
  		});
		$("#addPositionFrm :input[type=number]").val("");
       	return;
	}
	if(p_name!="" && p_salary!=""){
		$.ajax({
			url:"addPosition",
			data:{p_name:p_name,p_salary:p_salary},
			dataType:"text",
			success:function(result){
				console.log(result);
				getPositionList();
				$("#addPositionFrm input").each(function(){
					$(this).val("");
				})
			},
			error:function(error){
				console.log(error);
			}
		})
	}
};
function showAddDeptFrm(){
	$("#addDeptFrm").addClass("shown");
};
function hideAddDeptFrm(){
	$("#addDeptFrm").removeClass("shown");
};
</script>
</html>