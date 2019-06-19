<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Blog Post - Start Bootstrap Template</title>
<link href="${pageContext.request.contextPath}/shop/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/shop/css/shop-item.css" rel="stylesheet">

<style>
/* #totalPriceZone{background-color: white;} */
#totalPrice {
	display: none;
}

#ebInfoZone {
	display: none;
	border: 1px solid black;
	height: 500px;
	width: 500px;
	margin: auto;
}

#ebInfoZone.show {
	display: block;
	position: relative;
	
}

#impossible {
	color: red;
}

#possible {
	color: green;
}

.star_rating {
	font-size: 0;
	letter-spacing: -4px;
}

.star_rating a {
	font-size: 22px;
	letter-spacing: 0;
	display: inline-block;
	margin-left: 5px;
	color: #ccc;
	text-decoration: none;
}

.star_rating a:first-child {
	margin-left: 0;
}

.star_rating a.on {
	color: #777;
}

#member, #ceo, #admin, #common {
	visibility: hidden;
	font-size: 20px;
}

#member.show, #ceo.show, #admin.show, #common.show {
	visibility: visible;
}

#page-wrapper {
	padding-left: 250px;
}

#sidebar-wrapper {
	position: fixed;
	width: 250px;
	height: 100%;
	margin-left: -250px;
	background: #000;
	overflow-x: hidden;
	overflow-y: auto;
}

#page-content-wrapper {
	width: 100%;
	padding: 20px;
}
</style>
</head>
<body>
<!-- Bootstrap core JavaScript -->
  <script src="${pageContext.request.contextPath}/shop/vendor/jquery/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/shop/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<jsp:include page="../header.jsp"></jsp:include>


	<!-- Page Content -->
	<div class="container">
		<div class="row">
			<div class="col-lg-3"style="float: left;">
				<h1 class="my-4">카테고리</h1>
				<div class="list-group" id="category">
				</div>
			</div>
			<div class="col-lg-9">
			
			<div id="eMain">
				<div class="card mt-4">
					<!-- 썸네일 사진 -->
					<img class="card-img-top img-fluid"
						src="upload/thumbnail/${eb.e_sysfilename}"/>
					<div class="card-body">
						<h3 class="card-title">상품명: ${eb.e_name}</h3>
					</div>
					<table border="1" align="center">
						<tr>
							<td>상품명</td>
							<td>${eb.e_name}</td>
						</tr>
						<tr>
							<td>가격</td>
							<td>${eb.e_price}원</td>
						</tr>
						<tr>
							<td>옵션</td>
							<td><div id="selectZone"></div></td>
						</tr>
						<tr>
							<td>총가격</td>
							<td><div id="totalPriceZone"></div> <input type="hidden"
								id="totalPrice" disabled="disabled"></td>
						</tr>
						<tr>
							<td>이벤트날짜</td>
							<td><input type="datetime-local" /><span id="dateMsg"></span></td>
							<!-- 2019-12-31T12:59 형식으로 받아짐-->
						</tr>
						<tr>
							<td><button onclick="evtBuy()">구매하기</button></td>
							<td>
								<button id="choice" onclick="choice()">찜하기</button>
								<button id="choiceDelete" onclick="choiceDelete()">찜삭제하기</button>
								<button onclick="javascript:memberChat('${eb.c_id}')">실시간상담요청</button>
							</td>
						</tr>
						<tr>
							<td>별점 평균</td>
							<td><div id="starAverage">${starAverage}/5</div></td>
						</tr>
					</table>
					<div class="container-fluid" id="ebInfoZone"></div>
				</div>
				<div class="card card-outline-secondary my-4">
					<div class="card-header">
						<h3 class="card-title">- 상세정보</h3>
					</div>
					<div class="card-body">
						<c:forEach var="ei" items="${eiList}">
							<img src="upload/eventImage/${ei.ei_sysfilename}" / width="250"
								height="250">
						</c:forEach>
						${eb.e_contents}


					</div>
				</div>
				<div class="card card-outline-secondary my-4">
					<div class="card-header">
						<div id="showFrom">
							<table>
								<tr>
									<td>
										<p class="star_rating">
											<a href="#" class="on">★</a> <a href="#">★</a> <a href="#">★</a>
											<a href="#">★</a> <a href="#">★</a>
										</p>
									</td>
									<td><textarea rows="3" cols="50" name="r_contents"
											id="r_contents"></textarea></td>
									<td>
									<td><input type="button" value="댓글전송" onclick="review()"
										style="width: 80px; height: 50px"></td>
								</tr>
							</table>
						</div>
						<div id="hiddenFrom">
							<p class="star_rating">
								<a href="#" class="on2">수정 할 별★</a> <a href="#">★</a> <a
									href="#">★</a> <a href="#">★</a> <a href="#">★</a>
							</p>
						</div>
						<div id="seeShow2"></div>
						<table>
							<tr bgcolor="skyblue" align="center" height="30">
								<td width="100">WRITER</td>
								<td width="200">CONTENTS</td>
								<td width="200">STARS</td>
								<td width="200">DATE</td>
							</tr>
						</table>
					</div>
					<div class="card-body" id="rList">
					</div>
					<div align="center" id="rPagination"> </div>
					
				</div>
			</div>
		  </div>
		</div>
	</div>
</body>
<script>
function memberChat(receiver){
	window.open('chat?receiver='+receiver,"_blank","width=400,height=700;");
}
	$('.hideDate').hide();
	$(document).ready(function(){
		getCategories();
		selectOption();
		getTotalPrice();
		getReply(1,2); 
	});
	if ("${choiceChk}" != "") {
		$("#choiceDelete").show();
		$("#choice").hide();
	} else {
		$("#choiceDelete").hide();
		$("#choice").show();
	}
	$("#hiddenFrom").hide();
	$("#seeShow2").hide();
	//1.세션검사로 member만 구매가능하게
	//2.이벤트 날짜...유효성검사ㅋ
	$("input[type=datetime-local]").change(function() {
		effectiveness();
	})
	function effectiveness() {
		var dday = $("input[type=datetime-local]").val();
		console.log("dday=", dday);
		console.log("e_code", "${eb.e_code}");
		$.ajax({
			url : "effectiveness",
			data : {
				dday : dday,
				e_code : "${eb.e_code}"
			},
			dataType : "text",
			success : function(result) {
				$("#dateMsg").html(result);
			},
			error : function(error) {
				console.log(error);
			}
		})
	}
	$("input[type=datetime-local]").change(function() {
		effectiveness();
	})
	function effectiveness() {
		var dday = $("input[type=datetime-local]").val();
		console.log("dday=", dday);
		console.log("e_code", "${eb.e_code}");
		$.ajax({
			url : "effectiveness",
			data : {
				dday : dday,
				e_code : "${eb.e_code}"
			},
			dataType : "text",
			success : function(result) {
				$("#dateMsg").html(result);
			},
			error : function(error) {
				console.log(error);
			}
		})
	}
	function evtBuy() {
		var evtBuy = new FormData;
		evtBuy.append("e_code", "${eb.e_code}");
		evtBuy.append("eb_total", $("#totalPrice").val());
		evtBuy.append("eb_dday", $("input[type=datetime-local]").val());
		if (!jQuery.isEmptyObject(getSelectedOptions())) {
			//옵션을 선택하지 않았다면(배열이 비었으면) true지만 !라서 false,,
			evtBuy.append("eo_code", getSelectedOptions());
		}
		$.ajax({
			method : "post",
			url : "evtBuy",
			data : evtBuy,
			processData : false,
			contentType : false,
			dataType : "text",
			success : function(result) {
				getEvtBuyInfo(result);
			},
			error : function(error) {
				console.log(error);
			}
		})
	};
	function getEvtBuyInfo(eb_code) {
		if (eb_code == "구매실패") {
			alert("구매에 실패하였습니다");
		} else {
			$.ajax({
				method : "post",
				url : "getEvtBuyInfo",
				data : {
					eb_code : eb_code
				},
				dataType : "html",
				success : function(result) {
					alert("구매에 성공하였습니다");
					$("#ebInfoZone").html(result);
					$("#ebInfoZone").addClass("show");
				},
				error : function(error) {
					console.log(error);
				}
			})
		}
	}
	function getSelectedOptions() {
		var selectedOptions = new Array();
		$(".option:checked").each(function() {
			selectedOptions.push($(this).val());
		})
		getTotalPrice(selectedOptions);
		return selectedOptions;
	};

	function getTotalPrice(options) {
		var def = ${eb.e_price};
		var totalPrice;
		$.ajax({
			url : "getTotalPrice",
			data : {
				options : options,
				def : def
			},
			traditional : true,//배열을 넘기기 위한 설정
			dataType : "text",
			success : function(result) {
				$("#totalPriceZone").html(result + "원");
				$("#totalPrice").val(result);
			},
			error : function(error) {
				console.log(error);
			}
		})
	}

	function selectOption() {
		var e_code = "${eb.e_code}";
		$.ajax({
			url : "selectOption",
			data : {
				e_code : e_code
			},
			dataType : "json",
			success : function(result) {
				var str = "";
				for ( var i in result) {
					str += "<input type='checkbox' class='option' " + "value='"
							+ result[i].eo_code
							+ "' onclick='getSelectedOptions()'/>"
							+ result[i].eo_name + "/+" + result[i].eo_price
							+ "원<br/>";
				}
				str += "</select>";
				$("#selectZone").html(str);
			},
			error : function(error) {
				console.log(error);
			}
		})
	};

	$(".star_rating a").click(function() {
		$(this).parent().children("a").removeClass("on");
		$(this).addClass("on").prevAll("a").addClass("on");
		return false;
	});

	$(".star_rating a").click(function() {
		$(this).parent().children("a").removeClass("on2");
		$(this).addClass("on2").prevAll("a").addClass("on2");
		return false;
	});

	function review() {
		var e_code = "${eb.e_code}";
		var star = $(".on").length;
		var r_contents = $('#r_contents').val();
		$.ajax({
			url : "review",
			data : {
				e_code : e_code,
				star : star,
				r_contents : r_contents
			},
			dataType : "text",
			success : function(result) {
				console.log(result);
				alert(result);
				location.href = "evtInfo?e_code=" + e_code;
			},
			error : function(error) {
				console.log(error);
			}
		})

	};
	function reviewModify() {
		$("#showFrom").hide();
		$("#hiddenFrom").show();
		var myReviewStar = $("#myReviewStar").val();
		console.log(myReviewStar);
		var myReviewContents = $("#myReviewContents").val();

		var str = "";

		str += "<table><tr><td><div id='seeShow' onclick='see()' > 수정 전 별"
		if (myReviewStar == 5) {
			str += "<td align='center' width='200'>★★★★★</td>"
		}
		if (myReviewStar == 4) {
			str += "<td align='center' width='200'>★★★★</td>"
		}
		if (myReviewStar == 3) {
			str += "<td align='center' width='200'>★★★</td>"
		}
		if (myReviewStar == 2) {
			str += "<td align='center' width='200'>★★</td>"
		}
		if (myReviewStar == 1) {
			str += "<td align='center' width='200'>★</td>"
		}
		str += "</div></td>"
		str += "<td><textarea rows='3' cols='50' name='r_contents'"
		str+="id='r_contents2'>"
				+ myReviewContents + "</textarea></td><td>"
		str += "<td><input type='button' value='수정하기'"
		str += "onclick='reviewModifyBtn()'"
		str += "style='width: 80px; height: 50px'></td></tr></table>"
		$("#hiddenFrom").append(str);
		function see() {
			$("#seeShow").hide();
			$("#seeShow2").show();
		}
	};

	function reviewModifyBtn() {
		var e_code = "${eb.e_code}";
		var star = $(".on2").length;
		var r_contents = $('#r_contents2').val();
		$.ajax({
			url : "reviewModifyBtn",
			data : {
				e_code : e_code,
				star : star,
				r_contents : r_contents
			},
			dataType : "text",
			success : function(result) {
				console.log(result);
				alert(result);
				location.href = "evtInfo?e_code=" + e_code;
			},
			error : function(error) {
				console.log(error);
			}
		})

	};

	function reviewDelete() {
		var e_code = "${eb.e_code}";
		$.ajax({
			url : "reviewDelete",
			data : {
				e_code : e_code
			},
			dataType : "text",
			success : function(result) {
				console.log(result);
				alert(result);
				location.href = "evtInfo?e_code=" + e_code;
			},
			error : function(error) {
				console.log(error);
			}
		})

	};

	function choice() {
		var e_code = "${eb.e_code}";
		$.ajax({
			url : "choice",
			data : {
				e_code : e_code
			},
			dataType : "text",
			success : function(result) {
				console.log(result);
				alert(result);
				location.href = "evtInfo?e_code=" + e_code;
			},
			error : function(error) {
				console.log(error);
			}
		})
	}
	function choiceDelete() {
		var e_code = "${eb.e_code}";
		$.ajax({
			url : "choiceDelete",
			data : {
				e_code : e_code
			},
			dataType : "text",
			success : function(result) {
				console.log(result);
				alert(result);
				location.href = "evtInfo?e_code=" + e_code;
			},
			error : function(error) {
				console.log(error);
			}
		})
	}
	
	function getCategories(){
		$.ajax({
			url:"getCategoryList",
			dataType:"json",
			success:function(result){
				var str="";
				for(var i in result){
					str+=''
						+'<a class="list-group-item" id="'+result[i].ec_name
						+'" onclick="getEvtList(this.id,1,12)">'
						+result[i].ec_name+'</a>';
				}
				$("#category").html(str);
			},
			error:function(error){
				console.log(error);
			}
		})
	};
	function getEvtList(category,pageNum,listCount){
		ec_name=category;
		AjaxEvtList(pageNum,listCount);
	}
	function AjaxEvtList(pageNum,listCount){
		 $.ajax({
			url:"getEvtList",
			data:{ec_name:ec_name,pageNum:pageNum,listCount:listCount},
			dataType:"json",
			success:function(data){
				var result=data['evtList'];
				var paging=data['paging'];
				var msg=data['msg'];
				var str="";
				console.log(result);
				for(var i in result){
					str+='<div class="col-lg-3 col-md-4 col-6">'
						+'<a href="evtInfo?e_code='+result[i].e_code+'" class="d-block mb-4 h-100">' 
						+'<img class="img-fluid img-thumbnail"'
						+'src="upload/thumbnail/'+result[i].e_sysfilename+'">'
						+'</a></div>'
				}
				$("#eMain").html(str);
				$("#eMain").append(paging);
				if(data['msg']!=null){
					$("#eMain").html(data['msg']);
				}
			},
			error:function(error){
				console.log(error);
			}
		}) 
	};
	 
	 function getReply(pageNum,listCount){
		var e_code= "${eb.e_code}";
		var id= "${id}";
		
		$.ajax({
			url:"getReply",
			data:{e_code:e_code,listCount:listCount,pageNum:pageNum},
			dataType:"json",
			success:function(data){
				var result=data['rList'];
				var paging=data['paging'];
				console.log("result: "+result);
				console.log("paging: "+paging);
				var str="";
				str+="<table>";
				for(var i in result){
					str+="<tr><td align='center' width='100'>"+result[i].m_id+"</td>"
					+"<td align='center' width='200'>"+result[i].re_contents+"</td>";
					if(result[i].re_stars==5){
						str+="<td align='center' width='200'>★★★★★</td>";
					}
					if(result[i].re_stars==4){
						str+="<td align='center' width='200'>★★★★</td>";
					}
					if(result[i].re_stars==3){
						str+="<td align='center' width='200'>★★★</td>";
					}
					if(result[i].re_stars==2){
						str+="<td align='center' width='200'>★★</td>";
					}
					if(result[i].re_stars==1){
						str+="<td align='center' width='200'>★</td>";
					}
					str+="<td align='center' width='200'>"+result[i].re_writedate+"</td>";
					if(id==result[i].m_id){
						str+="<td><button onclick='reviewModify()'>수정</button></td>"
						+"<td><button onclick='reviewDelete()'>삭제</button></td>"
						+"<input type='hidden' id='myReviewStar'value='"+result[i].re_stars+"'>"
						+"<input type='hidden' id='myReviewContents'value='"+result[i].re_contents+"'>";
					} 
					str+="</tr>";
				}
				str+="</table>";
				$("#rList").html(str);
				$("#rPagination").html(paging);
			},error:function(error){
				console.log(error);
			}
		})
	}
</script>

</html>