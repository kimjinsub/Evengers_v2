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
.myButton {
	-moz-box-shadow:inset 0px 1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px 1px 3px 0px #91b8b3;
	box-shadow:inset 0px 1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	-moz-border-radius:5px;
	-webkit-border-radius:5px;
	border-radius:5px;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	padding:11px 23px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButton:active {
	position:relative;
	top:1px;
}

#totalPrice {
	display: none;
}
a.button2 {
	-webkit-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-moz-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-ms-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-o-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	display: block;
	text-decoration: none;
	border-radius: 4px;
}

a.button2 {
	color: rgba(30, 22, 54, 0.6);
	box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px inset;
}

a.button2:hover {
	color: rgba(255, 255, 255, 0.85);
	box-shadow: rgba(30, 22, 54, 0.7) 0 0px 0px 40px inset;
}
#eMain{
}
#ebInfoZone.show {
	display: block;
	position: relative;
}
#ebInfoZone {
	position: absolute;
	top: 30%;
	left: 20%;
	width: 800px;
	height: 600px;
	margin: -150px 0 0 -194px;
	padding: 28px 28px 0 28px;
	border: 2px solid #555;
	background: #fff;
	font-size: 12px;
	z-index: 200;
	color: #767676;
	line-height: normal;
	white-space: normal;
	overflow: scroll;
	position: fixed;
	font-size: 24px;
	
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

#articleView_layer2 {
	display: none;
	position: fixed;
	top: 0;
	left: 31%;
	width: 100%;
	height: 100%;
	z-index: 2000;
	
}

#articleView_layer2.open {
	display: block;
	color: red
}

#articleView_layer2 #bg_layer2 {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: #000;
	opacity: .5;
	filter: alpha(opacity = 50);
	z-index: 100
}



#articleView_layer {
	display: none;
	position: fixed;
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%
}

#articleView_layer.open {
	display: block;
	color: red
}

#articleView_layer #bg_layer {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: #000;
	opacity: .5;
	filter: alpha(opacity = 50);
	z-index: 100
}

#contents_layer {
	position: absolute;
	top: 30%;
	right:20%;
	width: 750px;
	height: 600px;
	margin: -150px 0 0 -194px;
	padding: 28px 28px 0 28px;
	border: 2px solid #555;
	background: #fff;
	font-size: 12px;
	z-index: 200;
	color: #767676;
	line-height: normal;
	white-space: normal;
	overflow: scroll;
	position: fixed;
}
#rPagination {
margin: auto; height:50px; text-align: center;
}
#ePagination {
margin: auto; height:50px; text-align: center; position: absolute;
}
#rPagination div{
	width: 50px; height: 30px; display: inline-block;
	font-size: 30px;
	text-align: center; margin: auto;;
	margin-bottom: 50px;
}
#ePagination div{
	width: 50px; height: 30px; display: inline-block;
	font-size: 30px;
	text-align: center; margin: auto;;
	margin-bottom: 50px;
}
#brief{
	
	background-color: white;
	width: 300px;
	height: auto;
	word-break:break-all; word-wrap:break-word;
	border: 1px solid black;
	position: fixed;
	z-index: 1;
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
				<hr>
				<h1 class="my-4">카테고리</h1>
				<div class="list-group" id="category">
				</div>
			</div>
			<div class="col-lg-9">
			<div id="brief"></div>
			<hr>
			<div id="eMain">
				<div class="card mt-4">
					<!-- 썸네일 사진 -->
					<img class="card-img-top img-fluid"
						src="upload/thumbnail/${eb.e_sysfilename}"/>
					<div class="card-body">
						<h3 class="card-title">상품명: ${eb.e_name}</h3>
					</div>
					<table  style="text-align: center;" class="table table-bordered table-hover">
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
							<td><div id="datepicker"></div><span id="dateMsg"></span></td>
							<!-- 2019-12-31T12:59 형식으로 받아짐-->
						</tr>
						<tr>
							<td>별점 평균	<div id="starAverage">${starAverage}/5</div></td>
							<td>
								<button class="myButton"onclick="evtBuy()">구매하기</button>
								<button class="myButton"id="choice" onclick="choice()">찜하기</button>
								<button class="myButton"id="choiceDelete" onclick="choiceDelete()">찜삭제하기</button>
								<button class="myButton" onclick="javascript:memberChat('${eb.c_id}')">실시간상담요청</button>
							</td>
						</tr>
						
					</table>
					<div id="articleView_layer2">
					<div id="bg_layer2"></div>	
					<div class="container-fluid" id="ebInfoZone"></div>
					</div>
				</div>
				<div class="card card-outline-secondary my-4">
					<div class="card-header">
						<h3 class="card-title">- 상세정보</h3>
					</div>
					<div class="card-body">
						<div><c:forEach var="ei" items="${eiList}">
							<img src="upload/eventImage/${ei.ei_sysfilename}" / width="100%"
								height="auto">
						</c:forEach></div>
						<div style="">${eb.e_contents}</div>


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
									<td><input class="myButton"type="button" value="댓글전송" onclick="review()"
										style="width: 100px; height: 50px"></td>
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
			<div align="center" id="ePagination"> </div>
		  </div>
		</div>
	</div>
</body>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
datePicker();
function datePicker(){
	var date = new Date();
	$.ajax({
		url:"datePicker",
		data:{date:date,type:"yyyyMMddhhmm"},
		dataType:"text",
		success:function(result){
			$("#datepicker").html(result);
			effectiveness();
		},
		error:function(error){
			console.log(error);
		}
	})
}
function memberChat(receiver){
	$.ajax({
		url:"checkDoubleChat",
		dataType:"text",
		success:function(result){
			if(result=="no"){
				window.open('chat?receiver='+receiver,"_blank","width=400,height=700;");
			}else{
				swal({
		        	title: result,
		        	icon: "warning",
				});
			}
		},
		error:function(error){
			console.log(error);
		}
	})
}
	$('#brief').hide();
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
	$("#datepicker").change(function() {
		effectiveness();
	})
	function effectiveness() {
		//var dday = $("input[type=datetime-local]").val();
		var yyyy=$("#datepicker #yyyy").val();
		var MM=$("#datepicker #MM").val();
		var dd=$("#datepicker #dd").val();
		var hh=$("#datepicker #hh").val();
		var mm=$("#datepicker #mm").val();
		var dday=(yyyy+"-"+MM+"-"+dd+" "+hh+":"+mm);
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
		//evtBuy.append("eb_dday", $("input[type=datetime-local]").val());
		var yyyy=$("#datepicker #yyyy").val();
		var MM=$("#datepicker #MM").val();
		var dd=$("#datepicker #dd").val();
		var hh=$("#datepicker #hh").val();
		var mm=$("#datepicker #mm").val();
		evtBuy.append("eb_dday", yyyy+"-"+MM+"-"+dd+" "+hh+":"+mm);
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
			swal({
	            title: "Warning!",
	             text:  "구매에 실패하였습니다",
	             icon: "warning",
			  });
		} else {
			$.ajax({
				method : "post",
				url : "getEvtBuyInfo",
				data : {
					eb_code : eb_code
				},
				dataType : "html",
				success : function(result) {
					swal({
			            title: "Success!",
			             text: "구매에 성공하였습니다",
			             icon: "success",
					  });
					$('#articleView_layer2').addClass('open');
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
				if(result=="이미 등록된 리뷰가 있습니다."||result=="구매 회원만 작성 가능합니다."){
					swal({
						title: "Warning!",
						text:  result,
						icon: "warning",
					})
					. then (function () { 
						window.location.href = "evtInfo?e_code=" + e_code;
					});
				}else{
					swal({
						title: "Success!",
						text:  result,
						icon: "success",
					})
					. then (function () { 
						window.location.href = "evtInfo?e_code=" + e_code;
					});
				}
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
		str += "<td><input class='myButton'type='button' value='수정하기'"
		str += "onclick='reviewModifyBtn()'"
		str += "style='width: 100px; height: 50px'></td></tr></table>"
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
				swal({
					title: "Success!",
					text:  result,
					icon: "success",
				})
				. then (function () { 
					window.location.href = "evtInfo?e_code=" + e_code;
				});
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
				swal({
					title: "Success!",
					text:  result,
					icon: "success",
				})
				. then (function () { 
					window.location.href = "evtInfo?e_code=" + e_code;
				});
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

				swal({
					title: "Success!",
					text:  result,
					icon: "success",
				})
				. then (function () { 
					window.location.href = "evtInfo?e_code=" + e_code;
				});

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
				swal({
					title: "Success!",
					text:  result,
					icon: "success",
				})
				. then (function () { 
					window.location.href = "evtInfo?e_code=" + e_code;
				});
			},
			error : function(error) {
				console.log(error);
			}
		})
	}

	function getCategories() {
		$.ajax({
			url : "getCategoryList",
			dataType : "json",
			success : function(result) {
			var str = "";
			for ( var i in result) {
				str += ''
				+ '<a href="#"class="list-group-item" id="'
				+ result[i].ec_name
				+ '" onclick="getEvtList(this.id,1,12)" style="text-decoration: none;">'
				+ result[i].ec_name + '</a>';
				}
				$("#category").html(str);
				},
				error : function(error) {
					console.log(error);
			}
		})
	};
	function getEvtList(category, pageNum, listCount) {
		ec_name = category;
		AjaxEvtList(pageNum, listCount);
	}
	function AjaxEvtList(pageNum, listCount) {
		$
				.ajax({
					url : "getEvtList",
					data : {
						ec_name : ec_name,
						pageNum : pageNum,
						listCount : listCount
					},
					dataType : "json",
					success : function(data) {
						var result = data['evtList'];
						var paging = data['paging'];
						var msg = data['msg'];
						var str = "";
						console.log(result);
						for ( var i in result) {
							str += '<a href="evtInfo?e_code='+ result[i].e_code+'" '
								+ 'style="margin:10px;">'
								+ '<img class="img-fluid img-thumbnail" '
								+ 'onmouseenter="briefInfo(this.id)" '
								+ 'onmouseout="briefInfoOut(this.id)" '
								+ 'id="'+ result[i].e_code+'" '
								+ 'src="upload/thumbnail/'+result[i].e_sysfilename+'" '
								+ 'style=" width: 350px; height: 350px;"/>'
								+ '</a>'
						}

						$("#eMain").html(str);
						$("#ePagination").html(paging);
						if (data['msg'] != null) {
							$("#eMain").html(data['msg']);
						}
					},
					error : function(error) {
						console.log(error);
					}
				})
	};

	function getReply(pageNum, listCount) {
		var e_code = "${eb.e_code}";
		var id = "${id}";
		$
				.ajax({
					url : "getReply",
					data : {
						e_code : e_code,
						listCount : listCount,
						pageNum : pageNum
					},
					dataType : "json",
					success : function(data) {
						var result = data['rList'];
						var paging = data['paging'];
						console.log("result: " + result);
						console.log("paging: " + paging);
						var str = "";
						str += "<table>";
						for ( var i in result) {
							str += "<tr><td align='center' width='100'>"
									+ result[i].m_id + "</td>"
									+ "<td align='center' width='200'>"
									+ result[i].re_contents + "</td>";
							if (result[i].re_stars == 5) {
								str += "<td align='center' width='200'>★★★★★</td>";
							}
							if (result[i].re_stars == 4) {
								str += "<td align='center' width='200'>★★★★</td>";
							}
							if (result[i].re_stars == 3) {
								str += "<td align='center' width='200'>★★★</td>";
							}
							if (result[i].re_stars == 2) {
								str += "<td align='center' width='200'>★★</td>";
							}
							if (result[i].re_stars == 1) {
								str += "<td align='center' width='200'>★</td>";
							}
							str += "<td align='center' width='200'>"
									+ result[i].re_writedate + "</td>";
							if (id == result[i].m_id) {
								str += "<td><button class='myButton'onclick='reviewModify()'>수정</button></td>"
										+ "<td><button class='myButton'onclick='reviewDelete()'>삭제</button></td>"
										+ "<input type='hidden' id='myReviewStar'value='"+result[i].re_stars+"'>"
										+ "<input type='hidden' id='myReviewContents'value='"+result[i].re_contents+"'>";
							}
							str += "</tr>";
						}
						str += "</table>";
						$("#rList").html(str);
						$("#rPagination").html(paging);
					},
					error : function(error) {
						console.log(error);
					}
				})
	}
	function briefInfo(e_code){
		//console.log(e_code);
		$.ajax({
			url:"briefInfo",
			data:{e_code:e_code},
			dataType:"json",
			success:function(data){
				//console.log(data);
				var e=data['event'];
				var c=data['ceo'];
				var reviewCount=data['reviewCount'];
				var starAverage=data['starAverage'];
				//console.log("e",e);
				//console.log("c",c);
				str="";
				str+="<div style='text-align:center;'>"
					+e.e_name+"<br/>"
					+e.e_contents+"<br/>"
					+"가격:"+e.e_price+"원<br/>";
				if(reviewCount!=undefined){
					str+="리뷰 "+reviewCount+"개  "
						+"평점 "+starAverage
				}
					//+"<tr><td>사업자명:"+c.c_name+"</td></tr>"
					//+"<tr><td>신청 가능일:이벤트 당일  "+e.e_reservedate+"일  전까지</td></tr>"
					//+"<tr><td>환불 가능일:이벤트 당일"+e.e_refunddate+"일 전까지</td></tr>"
					+"</div>";
				$('#brief').html(str);  
				$('#brief').show();  
			},error:function(error){
				console.log(error);
			}
		})//ajax
		document.addEventListener("mousemove",function(e){
			$("#brief").css({"top":e.screenY-50,"left":e.screenX-50});
		})
	} 
	 function briefInfoOut(e_code){
		 $('#brief').hide();
	} 
</script>

</html>