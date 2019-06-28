<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<html>
<head>
<title>Home</title>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/all.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js" /></script>
<style>
.jumbotron {
    background-image: url("img/main.png");
    background-size: cover;
    background-position: center;
    height: 450px;
    color: #fff;
    padding: 100px 25px;
    margin-bottom: 0em;
    font-family: Montserrat, sans-serif;
}
#btnSearch{
	height: 39px;
}
.input-group{
	margin: auto;
}
.img-thumbnail{
	height: 250px;
	width: 250px;
}
#pagination{margin: auto; height:50px; text-align: center;}
#pagination div{
	width: 50px; height: 30px; display: inline-block;
	font-size: 30px;
	text-align: center; margin: auto;;
	margin-bottom: 50px;
}
#brief{
	background-color: white;
	width: 300px;
	border: 1px solid black;
	position: fixed;
	height: auto;
	word-break:break-all; word-wrap:break-word;
}
</style>
</head>
<jsp:include page="header.jsp"></jsp:include>
<!-- jumbotron -->
 <div class="jumbotron text-center">
    <div class="input-group col-lg-4">
      <input type="text" class="form-control" size="50" onkeyup="enterkey();" placeholder="원하는 이벤트를 찾아보세요" name="evtSearch" id="evtSearch"required>
      <div class="input-group-btn">
        <button type="button" class="btn btn-danger" name="btnSearch" id="btnSearch" onclick="searchEvt()" ><i class="fas fa-search" aria-hidden="true"></i></button>
      </div>
    </div>
</div>




<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light" style="background-color:#d1d1d1">
	<div class="container">
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarResponsive" aria-controls="navbarResponsive"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive2">
			<ul class="navbar-nav m-auto">
			</ul>
		</div>
	</div>
</nav>
<!-- Page Content -->
<div class="container">
	<h1 class="font-weight-light text-center text-lg-left mt-4 mb-0"
		id="title"></h1>
		
	<hr class="mt-2 mb-5">
	
	<div class="row text-center text-lg-left" id="evtList">
	</div>
	<div class="row text-center text-lg-left" id="evtList2">
	</div> 
</div>
<div class="col-lg-2 col-md-3 col-6">
</div>
<div id="brief"></div>
<div id="pagination"></div>

</body>
<script>
$('#brief').hide();
$('#evtList2').hide();
$(document).ready(function(){
	getCategories();
	
});
function enterkey() {
    if (window.event.keyCode == 13) {

    	searchEvt();
    }
}


function searchEvt(){
	var evtSearch=$('#evtSearch').val();
	$.ajax({
		url:"searchEvt",
		data:{evtSearch:evtSearch},
		dataType:"json",
		success:function(data){
			var result=data['evtList'];
			var paging=data['paging'];
			var msg=data['msg'];
			var str="";
			$('#evtList2').show();
			$('#evtList').hide();
			$("#title").html(evtSearch+"의 검색 결과");
			for(var i in result){
				str+='<div class="col-lg-3 col-md-4 col-6" onmouseenter="briefInfo(this.id)"onmouseout="briefInfoOut(this.id)" id="'+result[i].e_code+'">'
					+'<a href="evtInfo?e_code='+result[i].e_code+'" class="d-block mb-4 h-100">' 
					+'<img class="img-fluid img-thumbnail" '
					+'src="upload/thumbnail/'+result[i].e_sysfilename+'">'
					+'</a></div>'
			}
			$("#evtList2").html(str);
			$("#pagination").html(paging);
			if(data['msg']!=null){
				$("#evtList2").html(data['msg']);
			}
		},
		error:function(error){
			console.log(error);
		}
	})
}
function getEvtList(category,pageNum,listCount){
	$("#title").html(category);
	ec_name=category;
	AjaxEvtList(pageNum,listCount);
}
function AjaxEvtList(pageNum,listCount){
	console.log("ec_name:",ec_name);
	console.log("pageNum:",pageNum);
	console.log("listCount:",listCount);
	$.ajax({
		url:"getEvtList",
		data:{ec_name:ec_name,pageNum:pageNum,listCount:listCount},
		dataType:"json",
		success:function(data){
			var result=data['evtList'];
			var paging=data['paging'];
			var msg=data['msg'];
			var str="";
			$('#evtList').show();
			$('#evtList2').hide();
			for(var i in result){
				str+='<div class="col-lg-3 col-md-4 col-6" '
					+'onmouseenter="briefInfo(this.id)"' 
					+'onmouseout="briefInfoOut(this.id)" id="'+result[i].e_code+'">'
					+'<a href="evtInfo?e_code='+result[i].e_code+'" class="d-block mb-4 h-100">' 
					+'<img class="img-fluid img-thumbnail"'
					+'src="upload/thumbnail/'+result[i].e_sysfilename+'">'
					+'</a></div>'
			}
			$("#evtList").html(str);
			$("#pagination").html(paging);
			if(data['msg']!=null){
				$("#evtList").html(data['msg']);
			}
		},
		error:function(error){
			console.log(error);
		}	
	})
};

function getCategories(){
	$.ajax({
		url:"getCategoryList",
		dataType:"json",
		success:function(result){
			var str="";
			for(var i in result){
				str+='<li class="nav-item active" style="font-size:20px;">'
						+'<a class="nav-link" id="'+result[i].ec_name
						+'" onclick="getEvtList(this.id,1,8)" '
						+'style="cursor:pointer;">'
						+result[i].ec_name+'</a></li>';
			}
			$("#navbarResponsive2 ul").append(str);
			//$("#navbarResponsive2 ul li:first").addClass("active");
			getEvtList(result[0].ec_name,1,8);
		},
		error:function(error){
			console.log(error);
		}
	})
};
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