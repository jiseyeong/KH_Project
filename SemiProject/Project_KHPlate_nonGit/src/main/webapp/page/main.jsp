<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
   rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
   rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/octicons/3.3.0/octicons.min.css"
   integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
   crossorigin="anonymous">
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
   integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
   crossorigin="anonymous"></script>

<style>

    @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');
	.nanum-gothic{ font-family: 'Nanum Gothic', sans-serif;} /*나눔고딕 폰트 import*/
/* 헤더 및 sideBar 부분 스타일 - 건들지 말것 */
* {
   box-sizing: border-box;
   padding: 0px;
}
.body {

   margin:auto;
   margin-top:40x;
}
/* 하단부터 메인부분 스타일 작성 요망 */
.contents {
   padding: 0px; 
}

.contents1>div {
   height: 100%;
}

.contents2>div {
   height: 100%;
}
.carousel-inner{
	height:500px;
}
.carousel-inner>.item>img{
    width: 100%;
    height: 100%;
}
/* 추가 */
.sideListUl{padding:0px}
.sideListUl>li{text-align:left; width:60%; margin:auto; font-weight:600;}

/* 리스트 폰트 추가 */
.sideListUl>a>li{text-align:center; width:60%; margin:auto; font-weight:600;}
.firstLi>input {
	height:30px;
	width:30px;
	line-height:30px;
	border:none;
	background-color:white;
	float:right;
	position: relative;
	top:10px;
}
.firstLi>input:hover{
	color:#ED1C16;
}

.contents2>div>div {
	background-color:rgb(253, 253, 253);
	border-radius:20px;
	box-shadow:1px 1px 5px 1px silver;
	margin-right:70px;
}
.contents2>div>div:first-of-type{
	margin-left:15px;
}
.imageDiv{
	width:90%;
	height:60%;
	margin:auto;
	margin-top:25px;
}
.imageDiv>img{
	width:100%;
	height:100%;
	cursor:pointer;
	object-fit:cover;
}
.imageDiv>img:hover{
	opacity:80%;
}
.textDiv{
	text-align:center;
	font-size:15px;
	font-weight:600;
	width:90%;
	margin:auto;
	margin-top:20px;
}

/* 추가 */
.imageDiv *{
	width:100%;
	height:100%;
	cursor:pointer;
}
.imageDiv img:hover{
	opacity:80%;
}


/* 추가 스타일 */
.contents1{
	display:flex;
	justify-content:center;
}
#printToStoreList{
	display:flex;
	justify-content:space-evenly;
}

.cardBox{
	max-width:200px;
}

</style>



</head>
<body>
   <div class="container-fluid themed-container m-0 g-0">
      <!-- 헤더부분 건들지 말것 -->
      <jsp:include page="header.jsp" flush="false"></jsp:include>


      <!-- body 부분 row div 건들지 말것 -->
      <div class="row g-0 justify-content-center body" style="margin-top:70px;">
      <!-- sideBar부분 건들지 말것 -->
         <jsp:include page="sideBar.jsp" flush="false"></jsp:include>

         <div class="col-12 col-lg-9 g-0 themed-grid-col bodyContents">
            <!-- Main 내용 부분 하단부터 수정 요망 -->
			
			<c:if test="${naverLogout}">
	      		<script>
		      		const naverLogin = new naver.LoginWithNaverId(
		   		        {
		   		            clientId: "Mm9YQgxstdSEuf5xt0jg",
		   		            callbackUrl: "http://localhost/login/login.jsp",
		   		            loginButton: {color: "green", type: 2, height: 40},
		   		            isPopup: false,
		   		    	    callbackHandle: true
		   		        }
		   		    );
		   		    naverLogin.init();
		   			naverLogin.logout();
		      		console.log("네이버 로그아웃 완료");
	      		</script>
      		</c:if>
      		
      		<c:if test="${kakaoLogout}">
	      		<script>
		      		function kakaoLogout() {
		      		    Kakao.Auth.logout()
		      		      .then(function() {
		      		        alert('logout ok\naccess token -> ' + Kakao.Auth.getAccessToken());
		      		        deleteCookie();
		      		      })
		      		      .catch(function() {
		      		        alert('Not logged in');
		      		      });
		      	    }
		      		console.log("카카오 로그아웃 완료");
	      		</script>
      		</c:if>
      	
            <div class="col-12 themed-grid-col contents">
               <div class="col-12 col-lg-12 themed-grid-col row contents1">
               
<!--                캐러셀 크기 조정 / 확인 바람 -->
                  <div class="col-12 col-lg-8 themed-grid-col carousel">
                     <div id="carouselIndicators" class="carousel slide"
                        data-bs-ride="true">
                        <div class="carousel-indicators">
                           <button type="button" data-bs-target="#carouselIndicators"
                              data-bs-slide-to="0" class="active" aria-current="true"
                              aria-label="Slide 1"></button>
                           <button type="button" data-bs-target="#carouselIndicators"
                              data-bs-slide-to="1" aria-label="Slide 2"></button>
                           <button type="button" data-bs-target="#carouselIndicators"
                              data-bs-slide-to="2" aria-label="Slide 3"></button>
                        </div>
                        <div class="carousel-inner">
                           <div class="carousel-item active">
                              <img
                                 src="/page/carouselimage1.jpg"
                                 class="d-block w-100" alt="...">
                           </div>
                           <div class="carousel-item">
                              <img
                                 src="/page/carouselimage2.jpg"
                                 class="d-block w-100" alt="...">
                           </div>
                           <div class="carousel-item">
                              <img
                                 src="/page/carouselimage3.jpg"
                                 class="d-block w-100" alt="...">
                           </div>
                        </div>
                        <button class="carousel-control-prev" type="button"
                           data-bs-target="#carouselIndicators" data-bs-slide="prev">
                           <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                           <span class="visually-hidden"><</span>
                        </button>
                        <button class="carousel-control-next" type="button"
                           data-bs-target="#carouselIndicators" data-bs-slide="next">
                           <span class="carousel-control-next-icon" aria-hidden="true"></span>
                           <span class="visually-hidden">></span>
                        </button>
                     </div>
                  </div>


<!-- 					리뷰 사이즈 3으로 조정 -> 캐러셀을 중앙쪽으로 붙이기 위함 -->
                  <div class="col-12 col-lg-4 themed-grid-col sideList">
                  	<ul class="nanum-gothic sideListUl" id="mainList">
                  		<li class="firstLi listLi" id="mainList">최근 작성된 Review<input type="button" value="+" id="reviewBtn"></li>
                  		
                  		
                  		
                  	</ul>
                  </div>
               </div>
               <div class="col-12 col-lg-12 themed-grid-col row contents2" style="margin-top:50px;">
                  <div class="row " id="printToStoreList">
<!--                      <div class="col-12 col-lg-3 themed-grid-col"> -->
<!--                      	<div class="imageDiv"><img src="/page/롤링파스타.png"></div> -->
<!-- 						<div class="nanum-gothic textDiv">롤링파스타 종로점</div> -->
<!--                      </div> -->
<!--                      <div class="col-12 col-lg-3 themed-grid-col"> -->
<!-- 						<div class="imageDiv"><img src="/page/오로지라멘.png"></div> -->
<!-- 						<div class="nanum-gothic textDiv">오로지라멘</div> -->
<!--                      </div> -->
<!--                      <div class="col-12 col-lg-3 themed-grid-col"> -->
<!-- 						<div class="imageDiv"><img src="/page/자담치킨.png"></div> -->
<!-- 						<div class="nanum-gothic textDiv">자담치킨</div> -->
<!--                      </div> -->
                  </div>
               </div>
            </div>
            
      <!-- body main 수정 여기까지, 하단 건들지 말것. -->
         </div>
      </div>
   
   <jsp:include page="footer.jsp" flush="false"></jsp:include>
   </div>

<script>
	$(function(){
		$.ajax({
			url: "/mainList.fullreview",
			type:"post",
			dataType:"json"
		}).done(function(resp){
			for(let i=0; i<resp.length; i++){
				let li = $("<li class='listLi' style='list-style:none;'>");
				let aa = $("<a href='/content.fullreview?reviewid="+resp[i].reviewID+"'>");
				$("#mainList").append(aa)
				aa.append(li);
				li.append(resp[i].title);
			}
		})
		
		$.ajax({
			url: "/mainSet.store",
			type:"post"
		}).done(function(resp){
			console.log(resp);
			let print = $("#printToStoreList");
			print.append(resp);
		})
	})
	
		$("#reviewBtn").on("click",function(){
			location.href = "/select.fullreview";
			
		})
</script>


</body>
</html>