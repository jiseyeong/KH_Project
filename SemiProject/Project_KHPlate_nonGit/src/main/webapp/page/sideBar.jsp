<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SideBar</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	rel="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css"
	rel="stylesheet">
<!-- <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script> -->

	<!-- <script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
	crossorigin="anonymous"></script> -->

<style>
@import
	url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap')
	;

* {
	font-family: 'Nanum Gothic', sans-serif;
}

.sideBar {
	text-align: center;
}

.wrap {
	perspective: 500px;
	display: flex;
	justify-content: center;
	align-items: center;
}

#mapbtn {
background-color: #ffffff;
border: none;
font-family: 'Nanum Gothic', sans-serif;
font-weight: 600;
margin-bottom: 10px;
padding: 5px;
}

#mapBtn {
	margin-bottom: 10px;
	filter: invert(31%) sepia(100%) saturate(6890%) hue-rotate(355deg)
	brightness(95%) contrast(95%);
	border: none;
	width: 65%;
	height: 40px;
	cursor: pointer;
	padding: 0;
	transform: rotateY(45deg);
	animation: rotateAnimation 2s linear infinite;
}

@keyframes rotateAnimation {
	from {transform: rotateY(45deg);}
	to {transform: rotateY(225deg);}
}

.ulTag {
	list-style: none;
	margin: 0px;
	padding: 0px;
	width: 200px;
	width: 100%;
}

.firstLi, .listLi {
	height: 50px;
	width: 100%;
	font-size: 15px;
	text-align: center;
	margin: 0px;
	padding: 0px;
	line-height: 50px;
	/*     a태그에 의한 색 변경 추가 */
	color: black;
}

.listLi:hover {
	cursor: pointer;
	color: #Ed1c16;
}

.ulTag {
	margin-bottom: 50px;
	padding-left: 70px;
	padding-right: 70px;
	font-weight: 600;
}

.firstLi {
   border-bottom: 1px solid silver;
   font-weight: bolder;
   font-size:18px;
   overflow:hidden;
}

/* a태그의 밑줄 속성 제거 */
a:link {
	text-decoration: none;
}
</style>


</head>
<body>
	<div
		class="col-12 col-md-12 col-lg-12 col-xl-2 themed-grid-col sideBar">
				<div class="wrap">
				<button id="mapbtn">
				<svg
					xmlns="http://www.w3.org/2000/svg" width="16" height="16"
					fill="currentColor" id="mapBtn" viewBox="0 0 16 16">
        <path d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10zm0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6z" />
      </svg>
     <br> 내 주변 맛집은?</button>
      </div>
		
		<ul class="ulTag">
			<!--<a href="/searchStoreBySearchBox.store?searchedBy=mapSearch&approachBy=sidebar"><li class="firstLi">내 근처 맛집 검색</li></a>-->
			<li class="firstLi">Menu</li>

			<!--   카테고리 접근을 위한 a태그 추가 -->
			<a href="/searchStoreBySearchBox.store?searchedBy=mainSearch"><li class="listLi">전체</li></a>
			<a
				href="/searchStoreBySearchBox.store?searchedBy=mainSearch&food_category=한식&approachBy=sidebar"><li class="listLi">한식</li></a>
			<a
				href="/searchStoreBySearchBox.store?searchedBy=mainSearch&food_category=양식&approachBy=sidebar"><li class="listLi">양식</li></a>
			<a
				href="/searchStoreBySearchBox.store?searchedBy=mainSearch&food_category=중식&approachBy=sidebar"><li class="listLi">중식</li></a>
			<a
				href="/searchStoreBySearchBox.store?searchedBy=mainSearch&food_category=일식&approachBy=sidebar"><li class="listLi">일식</li></a>
			<a
				href="/searchStoreBySearchBox.store?searchedBy=mainSearch&food_category=아시안&approachBy=sidebar"><li class="listLi">아시안</li></a>
			<a
				href="/searchStoreBySearchBox.store?searchedBy=mainSearch&food_category=패스트푸드&approachBy=sidebar"><li class="listLi">패스트푸드</li></a>
			<a
				href="/searchStoreBySearchBox.store?searchedBy=mainSearch&food_category=디저트/음료&approachBy=sidebar"><li class="listLi">디저트/음료</li></a>
			<a
				href="/searchStoreBySearchBox.store?searchedBy=mainSearch&food_category=기타&approachBy=sidebar"><li class="listLi">기타</li></a>
		</ul>
		<ul class="ulTag">
			<li class="firstLi">Community</li>
			<!--<li>잡담 게시판</li>-->
			<a href="/select.fullreview"><li class="listLi">리뷰 게시판</li></a>
		</ul>
		<ul class="ulTag">
			<li class="firstLi">Customer Service</li>
			<a href="/list.consult"><li class="listLi">1:1 문의</li></a>
			<a href="/view.faq"><li class="listLi">FAQ 리스트</li></a>
		</ul>
	</div>
	<script>
   $("#mapbtn").on("click",function(){
		location.href = "/searchStoreBySearchBox.store?searchedBy=mapSearch&approachBy=sidebar";
	})
   </script>
</body>
</html>