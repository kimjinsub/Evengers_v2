<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
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
#positionPartWrap {
	margin: auto;
	display: inline-block;
	/* width: 80%; height: 80%; */
	position: absolute;
	overflow: auto;
	text-align: center;
	top: 40%;
	left: 65%;
	transform: translate(0%, 0%);
}

#deptPartWrap {
	margin: auto;
	display: inline-block;
	/* width: 80%; height: 80%; */
	position: absolute;
	overflow: auto;
	text-align: center;
	top: 40%;
	left: 35%;
	transform: translate(0%, 0%);
}

#addPositionFrm {
	visibility: hidden;
	margin: auto;
	display: inline-block;
	/* width: 80%; height: 80%; */
	position: absolute;
	overflow: auto;
	text-align: center;
	top: 14%;
	left: 65%;
	transform: translate(0%, 0%);
}

#addPositionFrm.shown {
	visibility: visible;
}

#removePositionFrm {
	cursor: pointer;
}

#addDeptFrm {
	visibility: hidden;
	margin: auto;
	display: inline-block;
	/* width: 80%; height: 80%; */
	position: absolute;
	overflow: auto;
	text-align: center;
	top: 20%;
	left: 35%;
	transform: translate(0%, 0%);
}

#addDeptFrm.shown {
	visibility: visible;
}

#removeDeptFrm {
	cursor: pointer;
}
#h2{
	margin-top:2%;
	font-family: 'Nanum Gothic', sans-serif;
}
</style>
<title>manageDeptPosition</title>
</head>
<body>
		<h2 id="h2" align="center">부서 및 직책 관리</h2>
	<!-- <div id="positionPartWrap"> -->
	<div class="row wow fadeIn" style="visibility: visible; animation-name: fadeIn;">
		<div class="card" id="positionPartWrap">
			<div class="card-body">
				<table  id="positionPart" class="table table-bordered">
					<thead class="blue-grey lighten-4">
					</thead>
				</table>
				<button onclick="showAddPositionFrm()" class="btn btn-outline-primary btn-rounded waves-effect">직책추가</button>
			</div>
			</div>
		<div class="card" id="addPositionFrm">
			<div class="card-body">
				<table border="1" class="table table-bordered">
					<thead class="blue-grey lighten-4">
						<tr>
							<td><label for="inputMDEx">직책명:</label></td>
							<td><input type="text" placeholder="10자 이내" class="form-control"/></td>
						</tr>
						<tr>
							<td><label for="inputMDEx">기본급:</label></td>
							<td><input type="number" placeholder="100억원 이내" class="form-control" /></td>
						</tr>
					</thead>
				</table>
				<button onclick="addPosition()" class="btn btn-outline-primary btn-rounded waves-effect">완료</button>
				<!-- <div id="removePositionFrm" onclick="hideAddPositionFrm()"  >닫기</div> -->
				<button id="removePositionFrm" onclick="hideAddPositionFrm()" class="btn btn-outline-primary btn-rounded waves-effect">닫기</button>
			</div>
		</div>
	
	<!-- <div id="deptPartWrap">	 -->
		<div class="card" id="deptPartWrap">
			<div class="card-body">
				<table  id="deptPart" class="table table-bordered"> 
					<thead class="blue-grey lighten-4">
					</thead>
				</table>
				<button onclick='showAddDeptFrm()' class="btn btn-outline-primary btn-rounded waves-effect">부서추가 </button>
			</div>
		</div>
		<div class="card" id="addDeptFrm">
			<div class="card-body">
				<table border="1" class="table table-bordered">
					<thead class="blue-grey lighten-4">
						<tr>
							<td>부서명</td>
							<td><input type="text" placeholder="20자 이내" /></td>
						</tr>
					</thead>
				</table>
				<button onclick="addDept()" class="btn btn-outline-primary btn-rounded waves-effect">완료</button>
				<!-- <div id="removeDeptFrm" onclick="hideAddDeptFrm()">닫기</div> -->
				<button id="removeDeptFrm" onclick="hideAddDeptFrm()" class="btn btn-outline-primary btn-rounded waves-effect">닫기</button>
			</div>
		</div>
		</div>
</body>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	$(document).ready(function() {
		getDeptList();
		getPositionList();
	})
	function getDeptList() {
		$.ajax({
			url : "getDeptList",
			dataType : "json",
			success : function(result) {
				console.log(result);
				var str = "<tr><td>부서명</td><td>부서코드</td><td>삭제</tr></tr>";
				//+"<td><button onclick='showAddDeptFrm()'>부서추가</button></td></tr>";
				for ( var i in result) {
					str += "<tr>"
						+"		<td>" + result[i].dept_name + "</td>" 
						+"		<td>" + result[i].dept_code + "</td>"
						+"		<td onclick='deleteDept(\""+result[i].dept_code+"\")' "
						+ "style='cursor:pointer; color:red;'> X </td>"
						+"</tr>"
					//		+"<td><button onclick='deleteDept("+result[i].dept_code+")'>삭제</button></td></tr>"
				}
				if (result == "") {
					str = "<p id='deptSign'>첫 부서를 등록해보세요</p>";
					$("#deptPartWrap").append(str);
					return;
				}
				$("#deptPart").html(str);
				$("p[id=deptSign]").remove();
			},
			error : function(error) {
				console.log(error);
			}
		})
	};
	function addDept() {
		var dept_name = $("#addDeptFrm :input[type=text]").val();
		if (dept_name == "") {
			swal({
				title : "부서명을 입력하세요!",
				//text: "부서명을 입력하세요!",
				icon : "warning",
			});
		}
		if (dept_name.length > 20) {
			swal({
				title : "부서명을 20자 이내로 입력하세요!",
				//text: "부서명을 입력하세요!",
				icon : "warning",
			});
			$("#addDeptFrm :input[type=text]").val("");
			return;
		}
		if (dept_name != "") {
			$.ajax({
				url : "addDept",
				data : {
					dept_name : dept_name
				},
				dataType : "text",
				success : function(result) {
					swal({
						title : "부서등록완료!",
						//text: "부서명을 입력하세요!",
						icon : "success",
					});
					getDeptList();
					$("#addDeptFrm input").each(function() {
						$(this).val("");
					})
				},
				error : function(error) {
					console.log(error);
				}
			})
		}
	};
	function showAddPositionFrm() {
		$("#addPositionFrm").addClass("shown");
	};
	function hideAddPositionFrm() {
		$("#addPositionFrm").removeClass("shown");
	};
	function getPositionList() {
		$.ajax({
			url : "getPositionList",
			dataType : "json",
			success : function(result) {
				console.log(result);
				var str = "<tr><td>직책명</td><td>직책코드</td><td>기본급</td><td>삭제</td></tr>";
				for ( var i in result) {
					str += "<tr>" 
						+ "<td>" + result[i].p_name + "</td>" 
						+ "<td>" + result[i].p_code + "</td>" 
						+ "<td>" + result[i].p_salary + "원</td>"
						+ "<td onclick='deletePosition(\""+result[i].p_code+"\")' "
						+ "style='cursor:pointer; color:red;'> X </td>"
						+ "</tr>"
				}
				if (result == "") {
					str = "<p id='positionSign'>첫 직책을 등록해보세요</p>";
					$("#positionPartWrap").append(str);
					return;
				}
				$("#positionPart").html(str);
				$("p[id=positionSign]").remove();
			},
			error : function(error) {
				console.log(error);
			}
		})
	};
	function deletePosition(p_code){
		$.ajax({
			url : "deletePosition",
			data : {
				p_code : p_code,
			},
			dataType : "text",
			success : function(result) {
				if(result=="yes"){
					swal({
						title : "삭제완료!",
						icon : "success",
					})	
				}else{
					swal({
						title : "삭제실패!",
						icon : "warning",
					})
				}
				getPositionList();
			},
			error : function(error) {
				console.log(error);
			}
		})
	}
	function deleteDept(dept_code){
		$.ajax({
			url : "deleteDept",
			data : {
				dept_code : dept_code,
			},
			dataType : "text",
			success : function(result) {
				if(result=="yes"){
					swal({
						title : "삭제완료!",
						icon : "success",
					})	
				}else{
					swal({
						title : "삭제실패!",
						icon : "warning",
					})
				}
				getPositionList();
				getDeptList();
			},
			error : function(error) {
				console.log(error);
			}
		})
	}
	function addPosition() {
		var p_name = $("#addPositionFrm :input[type=text]").val();
		var p_salary = $("#addPositionFrm :input[type=number]").val();
		if (p_name == "" || p_salary == "") {
			swal({
				title : "직책명과 기본급을 입력하세요!",
				icon : "warning",
			});
			return;
		}
		if (p_name.length > 10) {
			swal({
				title : "10자 이내로 입력하세요!",
				icon : "warning",
			});
			$("#addPositionFrm :input[type=text]").val("");
			return;
		}
		if (p_salary.length > 10) {
			swal({
				title : "100억원 이내로 입력하세요!",
				icon : "warning",
			});
			$("#addPositionFrm :input[type=number]").val("");
			return;
		}
		if (p_name != "" && p_salary != "") {
			$.ajax({
				url : "addPosition",
				data : {
					p_name : p_name,
					p_salary : p_salary
				},
				dataType : "text",
				success : function(result) {
					console.log(result);
					getPositionList();
					$("#addPositionFrm input").each(function() {
						$(this).val("");
					})
				},
				error : function(error) {
					console.log(error);
				}
			})
		}
	};
	function showAddDeptFrm() {
		$("#addDeptFrm").addClass("shown");
	};
	function hideAddDeptFrm() {
		$("#addDeptFrm").removeClass("shown");
	};
</script>
</html>