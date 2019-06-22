<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style >
input.option-add {
    background-image:url("img/plus.png") ;
    width: 25px;
    height: 25px;
}
.button_base {
	margin: 0;
	border: 0;
	font-size: 18px;
	width: 180px;
	height: 40px;
	text-align: center;
	box-sizing: border-box;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	-webkit-user-select: none;
	cursor: default;
}

.button_base:hover {
	cursor: pointer;
} 

/* ### ### ### 01 */
.b01_simple_rollover {
	color: #000000;
	border: #000000 solid 1px;
	padding: 10px;
	background-color: #ffffff;
}

.b01_simple_rollover:hover {
	color: #ffffff;
	background-color: #000000;
}
</style>
</head>
<body>
   
   <table border="1" width="700" align="center">
		<tr>
			<td colspan="3" align="center"><h4>이벤트 상품 등록</h4></td>
		</tr>
		<tr>
			<td>상품명</td>
			<td><div id="e_nameDiv1"><input type="text"  id="e_name1" value="${event.e_name}" readonly></div>
				<div id="e_nameDiv2"><input type="text"  id="e_name2" ></div>
			</td>
			<td><button class='button_base b01_simple_rollover'onclick="e_nameModify()">상품명 수정</button></td>
		</tr>
		<tr>
			<td>가격</td>
			<td><div id="e_priceDiv1"><input type="number"  id="e_price1" value="${event.e_price}" readonly></div>
				<div id="e_priceDiv2"><input type="number"  id="e_price2" ></div>
			</td>
			<td><button class='button_base b01_simple_rollover'onclick="e_priceModify()">가격 수정</button></td>
		</tr>
		<tr>
			<td>이벤트 카테고리</td>
			<td><div id="selectZone1">${event. e_category}</div>
			<div id="selectZone2"></div>
			</td>
			<td><button class='button_base b01_simple_rollover'onclick="e_categoryModify()">카테고리 수정</button></td>
		</tr>	
		<tr>
			<td>옵션</td>
			<td><div id="option1">${evtOption}</div>
				<div id="option2">
					<div id="add"><input type="text" class="option_name" placeholder="내용">
					<input type="number" class="option_price" placeholder="가격"></div>
					<input type="button" onclick='addOption()' class="option-add" 
					id="e_option">
				</div>
			</td>
			<td><button class='button_base b01_simple_rollover'onclick="e_optionModify()">옵션 수정</button></td>
		</tr>
		
		<tr>
			<td>예약가능일</td>
			<td><div id="e_reserveDateDiv1"><input type="number" id="e_reservedate1" value="${event.e_reservedate}" readonly></div>
				<div id="e_reserveDateDiv2"><input type="number" id="e_reservedate2" ></div>
			</td>
			<td><button class='button_base b01_simple_rollover'onclick="e_reserveDateModify()">예약가능일 수정</button></td>
		</tr>		
		<tr>
			<td>환불가능일</td>
			<td><div id="e_refundDateDiv1"><input type="number" id="e_refunddate1" value="${event.e_refunddate}" readonly></div>
				<div id="e_refundDateDiv2"><input type="number" id="e_refunddate2" ></div>
			</td>
			<td><button class='button_base b01_simple_rollover'onclick="e_refundDateModify()">환불가능일 수정</button></td>
		</tr>	
		<tr>
			<td>썸네일사진</td>
			<td><div id="e_sysFileNameDiv1"><img src="upload/thumbnail/${event.e_sysfilename}" / width="100"
				height="100"></div>
				<div id="e_sysFileNameDiv2">
					<input type="file" name="e_orifilename" id="e_orifilename"
					onchange="fileChk(this)"/>
					<input type="hidden" id="fileCheck" value="0" name="fileCheck"/>
				</div>
			</td>
			<td><button class='button_base b01_simple_rollover'onclick="e_sysFileNameModify()">썸네일사진 수정</button></td>
		</tr>
		<tr>
			<td>이벤트 첨부 사진</td>
			<td><div id="ei_sysFileNameDiv1"><img src="upload/eventImage/${ei_sysFileName}" / width="100"
				height="100"></div>
				<div id="ei_sysFileNameDiv2">
					<input type="file" name="ei_files" id="ei_files" 
						onchange="fileChk(this)" multiple/>
				</div>
			</td>
			<td><button class='button_base b01_simple_rollover'onclick="ei_sysFileNameModify()">첨부 사진 수정</button></td>
		</tr>
		<tr>
			<td>글 내용</td>
			<td><div id="e_contentsDiv1"><textarea name="e_contents" id="e_contents1" rows="20" readonly>${event.e_contents}</textarea></div>
				<div id="e_contentsDiv2"><textarea name="e_contents" id="e_contents2" rows="20"></textarea></div>
			</td>
			<td><button class='button_base b01_simple_rollover'onclick="e_contentsModify()">글내용 수정</button></td>
		</tr>	
		<tr><td colspan="3"style="text-align: center;"><button class='button_base b01_simple_rollover'onclick="myEvtModifyBtn()"> 이벤트 수정</button></td></tr>
		</table>
		
		
</body>
<script >

	$(document).ready(function() {
		selectCategory();
	});
	$("#e_nameDiv2").hide();
	$("#e_priceDiv2").hide();
	$("#selectZone2").hide();
	$("#option2").hide();
	$("#e_reserveDateDiv2").hide();
	$("#e_refundDateDiv2").hide();
	$("#e_sysFileNameDiv2").hide();
	$("#ei_sysFileNameDiv2").hide();
	$("#e_contentsDiv2").hide();

	function selectCategory() {
		$.ajax({
			url : "selectCategory",
			dataType : "json",
			success : function(result) {
				console.log(result);
				var str = "";
				str += "<select name='e_category' id='e_category'>"
						+ "<option selected='selected'>선택하세요</option>";
				for ( var i in result) {
					str += "<option value='"+result[i].ec_name+"'>"
							+ result[i].ec_name + "</option>";
				}
				str += "</select>";
				$("#selectZone2").html(str);
			},
			error : function(error) {
				console.log(error);
			}
		})
	};
	function addOption() {
		var str = "";
		str += "<div><input type='text' class='option_name' placeholder='내용'>"
				+ "<input type='number' class='option_price' placeholder='가격'></div>";
		$('#add').append(str);
	};

	function e_nameModify() {
		$("#e_nameDiv1").hide();
		$("#e_nameDiv2").show();
	}

	function e_priceModify() {
		$("#e_priceDiv1").hide();
		$("#e_priceDiv2").show();
	}

	function e_categoryModify() {
		$("#selectZone1").hide();
		$("#selectZone2").show();
	}
	function e_optionModify() {
		$("#option1").hide();
		$("#option2").show();
	}
	function e_reserveDateModify() {
		$("#e_reserveDateDiv1").hide();
		$("#e_reserveDateDiv2").show();
	}
	function e_refundDateModify() {
		$("#e_refundDateDiv1").hide();
		$("#e_refundDateDiv2").show();
	}
	function e_sysFileNameModify() {
		$("#e_sysFileNameDiv1").hide();
		$("#e_sysFileNameDiv2").show();
	}
	function ei_sysFileNameModify() {
		$("#ei_sysFileNameDiv1").hide();
		$("#ei_sysFileNameDiv2").show();
	}
	function e_contentsModify() {
		$("#e_contentsDiv1").hide();
		$("#e_contentsDiv2").show();
	}
	function confirm(){
		 var str="";
		  var num="";
		  $(".option_name").each(function(){
		      str+=$(this).val()+",";
		   })
		   $(".option_price").each(function(){
		      num+=$(this).val()+",";
		   })
		   $("#add").append('<input type="hidden" name="eo_name" id="eo_name"/>'
		         +'<input type="hidden" name="eo_price" id="eo_price"/>');
		   $("input[name=eo_name]").val(str);
		   $("input[name=eo_price]").val(num);
		   console.log("eo_name",$("input[name=eo_name]").val());
		   console.log("eo_price",$("input[name=eo_price]").val());
		   if($("input[name=eo_name]").val()==null || $("input[name=eo_price]").val() == null){
			   return false;
		   }
		   return true;
	} 
	
	function fileChk(elem){
		console.log(elem);
		console.log(elem.value);
		console.dir(elem);
		if(elem.value==""){
			console.log("empty");
			$("#fileCheck").val(0);//0:파일첨부 안했음 val() : val출력 val(a) val에 a입력
		}else{
			console.log("not empty");
			$("#fileCheck").val(1);//1:파일첨부 했음
		}
	}
	
	function myEvtModifyBtn() {
		
		if ($("#e_name2").val() == "") {
			var e_name = "${event.e_name}";
		} else {
			e_name = $("#e_name2").val();
		}
		console.log("상품제목:" + e_name);

		if ($("#e_price2").val() == "") {
			var e_price = "${event.e_price}";
		} else {
			e_price = $("#e_price2").val();
		}
		console.log("상품가격:" + e_price);

		if ($("#e_reservedate2").val() == "") {
			var e_reservedate = "${event.e_reservedate}";
		} else {
			e_reservedate = $("#e_reservedate2").val();
		}
		console.log("예약가능일:" + e_reservedate);

		if ($("#e_refunddate2").val() == "") {
			var e_refunddate = "${event.e_refunddate}";
		} else {
			e_refunddate = $("#e_refunddate2").val();
		}
		console.log("환불가능일:" + e_refunddate);

		if ($("#e_contents2").val() == "") {
			var e_contents = "${event.e_contents}";
		} else {
			e_contents = $("#e_contents2").val();
		}
		console.log("상품설명:" + e_contents);

		if ($("#e_category").val() == "선택하세요") {
			var e_category = "${event. e_category}";
		} else {
			e_category = $("#e_category").val();
		}
		console.log("이벤트 카테고리:" + e_category);
		
		//옵션 가져가자
		confirm();
		var eo_option="${evtOption2}";//수정전 옵션
		console.log("eo_option"+eo_option);	
		
		var e_sysfilename= "${event.e_sysfilename}";
		var ei_sysfilename= "${ei_sysFileName}";
		var $obj=$("#e_orifilename");
		console.log("수정 후 썸네일 사진:" +$obj);
		console.log("수정 전 썸네일 사진:" +e_sysfilename);
		var $obj2=$("#ei_files");
		console.log("수정 후 이벤트 첨부 사진:" + $obj2);
		console.log("수정 전 이벤트 첨부 사진:" +ei_sysfilename);
		var e_code = "${event.e_code}";
		console.log("e_code"+e_code);
		var formData=new FormData();
		formData.append("e_name",e_name);
		formData.append("e_price",e_price);
		formData.append("e_reservedate",e_reservedate);
		formData.append("e_refunddate",e_refunddate);
		formData.append("e_contents",e_contents);
		formData.append("e_category",e_category);
		formData.append("eo_option",eo_option);					
		formData.append("e_sysFileName",e_sysfilename);
		formData.append("ei_sysFileName",ei_sysfilename);
		formData.append("e_code",e_code);
		formData.append("eo_name",$("input[name=eo_name]").val());
		formData.append("eo_price",$("input[name=eo_price]").val());
		console.log($("input[name=eo_name]").val());
		console.log($("input[name=eo_price]").val());
		var files=$obj[0].files;//배열로 파일정보를 반환
		for(var i=0;i<files.length;i++){
			formData.append("e_orifilename",files[i]);
		}
		var files2=$obj2[0].files;//배열로 파일정보를 반환
		for(var i=0;i<files2.length;i++){
			formData.append("ei_files",files2[i]);
		}
		
		$.ajax({
			type:"post",
			url:"myEvtModifyBtn",
			data:formData,
			processData:false,
			contentType:false,
			dataType:"text",
			success:function(data){
				swal({
		            title: "Success!",
		             text:  "수정 완료",
		             icon: "success",
				  });
				console.log(data);
				location.href="javascript:Ajax_forward('myEvtManagement')";
			},
			error:function(error){
				alert(data);
				console.log(error)
			} 
		})
		
	}
	
</script>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</html>