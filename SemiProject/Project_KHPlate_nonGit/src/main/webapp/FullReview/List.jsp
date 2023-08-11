<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="canonical"
	href="https://getbootstrap.com/docs/5.2/examples/album/">
<link href="/FullReview/bootstrap.min.css" rel="stylesheet">

<!-- FontAwesome 추가 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

.b-example-divider {
	height: 3rem;
	background-color: rgba(0, 0, 0, .1);
	border: solid rgba(0, 0, 0, .15);
	border-width: 1px 0;
	box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em
		rgba(0, 0, 0, .15);
}

.b-example-vr {
	flex-shrink: 0;
	width: 1.5rem;
	height: 100vh;
}

.bi {
	vertical-align: -.125em;
	fill: currentColor;
}

.nav-scroller {
	position: relative;
	z-index: 2;
	height: 2.75rem;
	overflow-y: hidden;
}

.nav-scroller .nav {
	display: flex;
	flex-wrap: nowrap;
	padding-bottom: 1rem;
	margin-top: -1px;
	overflow-x: auto;
	text-align: center;
	white-space: nowrap;
	-webkit-overflow-scrolling: touch;
}

.card {
	max-width:350px;
	padding:10px;
	margin-bottom: 30px;
/* 	position 추가(즐겨찾기 버튼 고정용) */
	position : relative;
}
.card:hover{
	cursor:pointer;
} 

.btnBox2 {
	height: 100px;
	padding-left: 90%;
}

.writeBtn {
	width: 60px;
	height: 60px;
	margin-top: 5px;
	filter: invert(15%) sepia(100%) saturate(4963%) hue-rotate(18deg) brightness(102%) contrast(112%);
}

.writeBtn:hover {
	cursor: pointer;
}

/* 네비게이터 영역 */
.navigator {
	border: 1px solid black;
	height: 60px;
	width: 100%;
	text-align: center;
	margin: 20px auto 0 auto;
	padding: 10px 0px 10px;
	background-color: rgba(255, 255, 255, 0.9);
	position: fixed;
	bottom: 0;
	left: 0;
	border-top: 1px solid #fff;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	justify-content: center
}

.navigator_list {
	list-style-type: none;
	padding-right: 50px;
	margin: 0px;
	display: flex;
	justify-content: right;
	align-items: center;
}

.navigator_list_item {
	width: 30px;
	height: 30px;
	float: left;
	margin-left: 5px;
	margin-right: 5px;
}

.navigator_list_item_btn_layout {
	border: 1px solid rgb(178, 178, 178);
	width: 30px;
	height: 30px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.item {
	font-size: 15px;
	text-decoration: none;
}

.navigator_direction_btn {
	position: relative;
	width: 100%;
	height: 100%;
	right: 0px;
	font-size: 15px;
	background-color: white;
	border: 0px;
	display: flex;
	justify-content: center;
	align-items: center;
}

/* List 내 스크랩 버튼 추가 */
.fullreview_addScrap {
	position: absolute;
	top: 10px;
	right: 12px;
	width: 40px;
	height: 40px;
	border-radius: 1.5rem;
	z-index: 1px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.addScrap_btn {
	width: 70%;
	height: 70%;
	font-size: 20px;
}

.istrue {
	filter: invert(28%) sepia(63%) saturate(6367%) hue-rotate(351deg) brightness(92%) contrast(101%);
}

.isfalse {
	filter: invert(100%) sepia(0%) saturate(2%) hue-rotate(209deg) brightness(110%) contrast(101%);
}

.imgBox{
	width:100%;
	height:350px;
	display:flex;
	justify-content:center;
	align-items:center;
}

.imgBox>img{
	height:100%;
	object-fit:cover;
}

</style>
<meta charset="UTF-8">
<title>List</title>
</head>
<body>

	<div class="album py-0 bg-0">
		<div class="container">

			<div class="btnBox2">
			<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="writeBtn" viewBox="0 0 16 16">
  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
</svg>
			</div>
			<div class="row g-0"
				style="padding-top: 40px; display:flex; justify-content:space-evenly">
				
				<c:choose>
					<c:when test="${FullReviewList!=null}">
						<c:forEach var="reviewList" items="${FullReviewList}" varStatus="status">
						<!--유저 정보를 같이 받고 index로 값을 전달 -->
							<div class="col-12 col-lg-6 card">
								<input type="hidden" value="${reviewList.reviewID}" class="hiddencard" style="display: none;">
								<div class="reviewId" style="display: none;">${reviewList.reviewID}</div>
								
								<div class="imgBox">
								<img src="/FullReview/${photoList.get(status.index).sysName}" class="card-img-top" alt="...">
								</div>
								
								<!-- 즐겨찾기 여부 체크 -->
								<div class="fullreview_addScrap">
									<input type="text" name="addScrap_userno" value="${userno}" id="addScrap_userno" style="display: none;">
									<c:set var="scrapCheck" value="false"/>
									<c:forEach var="scrapList" items="${scrap_list}"
										varStatus="status">
										<c:if test="${scrapList.reviewID == reviewList.reviewID}"> 
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="addScrap_btn istrue" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
</svg>
											<c:set var="scrapCheck" value="true" />
										</c:if>
									</c:forEach>
									<c:if test="${!scrapCheck}"> 
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="addScrap_btn isfalse" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
</svg>
									</c:if>
								</div>
								
								<div class="card-body">
									<div style="width:65%; height:100%; float:left;">
										<div class="title" style="font-size:22px;">${reviewList.title}</div>
										<div class="writer">${reviewList.userID}</div>
<%-- 										<div class="stars">${reviewList.score}</div> --%>
									</div>
<!-- 									별점 아이콘으로 새로 추가 -->
									<div style="width:35%; height:100%; float:left; display:flex; justify-content:center; align-items:center;">
										<c:forEach var='i' begin='1' end='5' step='1'>
											<c:choose>
												<c:when test="${reviewList.score<i}">
													<i class="stars__icon fas fa-star js-clear" style="color: #b2b2b2;"></i>
												</c:when>
												<c:otherwise>
													<i class="stars__icon fas fa-star js-fill" style="color: gold;"></i>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div>표시할 내용 없음</div>
					</c:otherwise>
				</c:choose>
				
			</div>

			<div class="navigator" style="position: relative; width: 100%; border: 0px;">
				<hr>
				<ul class="navigator_list">${FullReviewNavi}</ul>
			</div>
			
			<!-- 현제 페이지 네비게이터 링크 미부여 -->
			<c:choose>
				<c:when test="${param.cpage>1}">
					<script>
						$(".item").each(function(index,item){
							if($(item).children().html()==${param.cpage}){
								$(item).prop("href","#null");
								$(item).children().css("color","#ED1C16");
							}
						})
					</script>
				</c:when>
				<c:otherwise>
					<script>
						$(".item").each(function(index,item){
							if($(item).children().html()==1){
								$(item).prop("href","#null");
								$(item).children().css("color","#ED1C16");
							}
						})
					</script>
				</c:otherwise>
			</c:choose>

		</div>
	</div>

	<script>
		$(".writeBtn").on("click",function(){
			if(${sessionScope.userno!=null}){
				location.href="/towrite.fullreview";
			}else{
				alert("로그인 후 이용가능 합니다.");
			}
		})
		$(".card").on("click",function(){
			location.href="/content.fullreview?reviewid="+$(this).find('.hiddencard').val();
		})
		
		$(function(){
			
			// 즐겨찾기 등록,삭제 버튼
			
			$(".addScrap_btn").each(function (index, item) {
				let loginCheck = $("#addScrap_userno").val();
				
				let addScrapFullReviewCheck;
				
				if($(item).attr("class")=="addScrap_btn istrue"){
					addScrapFullReviewCheck = true;
				}else{
					addScrapFullReviewCheck = false;
				}

				$(this).on("click",function(){
					console.log(loginCheck);
					event.stopPropagation();
					if(loginCheck==""){
						alert("로그인을 먼저 진행해주세요.");
					}
					else {
						let addScrap_btn = $(this);
						
						if(addScrapFullReviewCheck==false){
							$.ajax({
								url:"/addScrapFullReview.fullreview",
								type:"post",
								data:{
									// input type=hidden
									addScrap_reviewID:addScrap_btn.parent().prev().prev().prev().val()
								}
							}).done(function(resp){
								if(resp=="true"){
									addScrapFullReviewCheck = true;
									addScrap_btn.removeClass("isfalse");
									addScrap_btn.addClass("istrue");
								}
							})
							
						}else{
							$.ajax({
								url:"/deleteScrapFullReview.fullreview",
								type:"post",
								data:{
									// input type=hidden
 									addScrap_reviewID:addScrap_btn.parent().prev().prev().prev().val()
								}
							}).done(function(resp){
								if(resp=="true"){
									addScrapFullReviewCheck = false;
									addScrap_btn.removeClass("istrue");
									addScrap_btn.addClass("isfalse");
								}
							})
						}
						
						
					}
				})
			})
		})
		
	</script>
</body>
</html>