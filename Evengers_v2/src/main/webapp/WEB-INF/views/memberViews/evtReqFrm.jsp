<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/all.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js" /></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/all.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js" /></script>

<style>

#impossible {
	color: red;
}

#possible {
	color: green;
}
.pageDown {
   width:20px;
   height:20px;
   position: fixed;
   margin-left: 700px;
   cursor: pointer;
}

#hh {
	margin-top: 30px;
}

table.type08 {
	border-collapse: collapse;
	text-align: left;
	line-height: 1.5;
	border-left: 1px solid #ccc;
	margin: 20px 10px;
}

table.type08 thead th {
	font-weight: bold;
	border-top: 1px solid #ccc;
	border-right: 1px solid #ccc;
	border-bottom: 2px solid #c00;
	background: #dcdcd1;
}

table.type08 tbody th {
	width: 5px;
	padding: 10px;
	font-weight: bold;
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
	background: #ececec;
}

table.type08 td {
	width: 250px;
	padding: 10px;
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

#articleView-layer{
	position: fixed;
	top: 30px;
	left: 35%;
	width: 750px;
	height: 200px;
	padding: 2px;
	margin-left: -150px;
	float: left;
	border: dashed;
	z-index: 101;
	display: none;
	overflow: auto;
	overflow: scroll;
	background-color: red;
}

#articleView-layer.open{
	display: block;
}
#h2{
	font-family: 'Nanum Gothic', sans-serif;
}
#wrap{
	font-family: 'Nanum Gothic', sans-serif;
}
</style>

</head>
<body id="wrap">
	<div id="hh">
		<img class="pageDown" src="./img/closer.png"  onclick="reset()">
		<h2 id="hh" align="center"><i class="fas fa-edit"></i>의뢰신청서</h2>
	</div>
<div class="card">
	<div class="card-body px-lg-5 pt-0">
	<form name="evtReqFrm" action="/" method="post" enctype="multipart/form-data" onsubmit="return confirm()">
		<div class="md-form mt-3">
		제목:<input type="text" name="req_title" id="req_title"
		placeholder="제목" class="form-control">
  		</div>
		<div class="md-form mt-3">
		이벤트 카테고리:<div id="selectZone"></div>
  		</div>
  		<br>
  		<div class="input-group">
   			<div class="input-group-prepend">
   			<span class="input-group-text" id="inputGroupFileAddon01">Upload</span>
   			</div>
   			<div class="custom-file">
   			<input type="file" name="reqi_orifilename" id="reqi_orifilename" multiple class="form-control">
    		</div>
  		</div>
		<div class="md-form mt-3">
		희망지역:<select name="req_hopearea" id="req_hopearea" class="form-control">
						<option selected="selected">선택하세요</option>
						<option value="서울">서울</option>
						<option value="인천">인천</option>
						<option value="대전">대전</option>
						<option value="대구">대구</option>
						<option value="부산">부산</option>
						<option value="광주">광주</option>
						<option value="울산">울산</option>
						<option value="경기">경기</option>
						<option value="강원">강원</option>
						<option value="충남">충남</option>
						<option value="충북">충북</option>
						<option value="전남">전남</option>
						<option value="전북">전북</option>
						<option value="경남">경남</option>
						<option value="경북">경북</option>
						<option value="제주">제주</option>
				</select>
  		</div>
  		<div class="md-form mt-3">
		상세주소:<input type="text" id="req_hopeaddr" name="req_hopeaddr" placeholder="직접입력" class="form-control">
  		</div>
  		<div class="md-form mt-3">
		의뢰 날짜 및 시간:<input type="datetime-local" id="req_hopedate" name="req_hopedate" class="form-control">
  		<span id="dateMsg"></span>
  		</div>
  		<div class="md-form mt-3">
		글내용:<textarea rows="15" cols="50" name="req_contents" id="req_contents" class="form-control"></textarea>
  		</div>
		<input type="button" onclick="formData()" value="의뢰신청하기" id="submit" disabled="disabled" class="btn btn-outline-primary btn-rounded waves-effect"> 
		<input type="button" onclick="location.href='./'" value="홈으로" class="btn btn-outline-primary btn-rounded waves-effect"> 
		<input type="reset" id="rs" value="다시작성" class="btn btn-outline-primary btn-rounded waves-effect">
	</form>
	</div>
	</div>
	<div id="articleView-layer"></div>

</body>

<script>
	$("input[type=datetime-local]").change(function() {
		dateChk();
	})
	function dateChk() {
		var date = $("input[type=datetime-local]").val();
		console.log("date="+ date);
		$.ajax({
			url : "dateChk",
			data : {date : date	},
			dataType : "text",
			success : function(result) {
			if(result == "<p id='possible'>가능한 날짜입니다</p>"){	//
				$("#dateMsg").html(result);
				$("#submit").removeAttr("disabled");
			}else {
				$("#dateMsg").html(result);
				$("#submit").attr("disabled", "disabled");
			}
			},
			error : function(error) {
			console.log(error);
			}
		})
	}
	function reset() {
		if ($layerWindows.hasClass('open')) {
			$layerWindows.removeClass('open');
		}
	}


	/* document.getElementById('req_hopedate').min= new Date().toISOString().slice(0, -1); */
	
	$(document).ready(function() {
		selectCategory();
	});

	function selectCategory() {
		$
				.ajax({
					url : "selectCategory",
					dataType : "json",
					success : function(result) {
						console.log(result);
						var str = "";
						str += "<select name='e_category' id='e_category'><option selected='selected'>선택하세요</option>";
						for ( var i in result) {
							str += "<option value='"+result[i].ec_name+"'>"
									+ result[i].ec_name + "</option>";
						}
						str += "</select>";
						$("#selectZone").html(str);
					},
					error : function(error) {
						console.log(error);
					}
				})
	};

	function confirm() {
		true;
	}
	function formData() {
		$('#frm').removeClass("open");
		$('#articleView-layer').addClass("open");
		$('#articleView-layer').show();
		confirm();
		var $obj = $("#reqi_orifilename");
		//var $obj2=$("#ei_files");
		var formData = new FormData();

		formData.append("req_title", $("#req_title").val());
		formData.append("req_contents", $("#req_contents").val());
		formData.append("e_category", $("#e_category").val());
		formData.append("req_hopedate", $("#req_hopedate").val());
		formData.append("req_hopearea", $("#req_hopearea").val());
		formData.append("req_hopeaddr", $("#req_hopeaddr").val());
		//formData.append("fileCheck",$("#fileCheck").val());//0,1

		console.log($("#req_title").val());
		console.log($("#req_contents").val());
		console.log($("#req_hopedate").val());
		console.log($("#e_category").val());

		var files = $obj[0].files;//배열로 파일정보를 반환
		for (var i = 0; i < files.length; i++) {
			formData.append("reqi_orifilename", files[i]);
		}

		console.log($("#reqi_orifilename").val());
		/* var files2=$obj2[0].files;//배열로 파일정보를 반환
		for(var i=0;i<files2.length;i++){
			formData.append("ei_files",files2[i]);
		} */

		$.ajax({
			type : "post",
			url : "evtReqInsert",
			data : formData,
			processData : false,
			contentType : false,
			dataType : 'html',
			success : function(data) {
				swal({
		            title: "Good!",
		             text: "의뢰 신청 성공!",
		             icon: "success",
		  });
				console.log(data);
				$('#articleView-layer').html(data);
				//var str="";
				//str+="<table><tr><td>"+data.+"</td></tr></table>"
			},
			error : function(error) {
				swal({
		            title: "Sorry!",
		             text: "의뢰 신청 실패!",
		             icon: "warning",
		  });
				console.log(error)
			}
		})
	}
</script>
</html>