<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags-->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0 shrink-to-fit=no">


<!-- Title Page-->
<title>ID 중복검사</title>


<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
</head>
<style>

/* ==========================================================================
	   #FONT
	   ========================================================================== */
@import
	url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap')
	;

/* ==========================================================================
	   #GRID
	   ========================================================================== */
.row {
	display: -webkit-box;
	display: -webkit-flex;
	display: -moz-box;
	display: -ms-flexbox;
	display: flex;
	-webkit-flex-wrap: wrap;
	-ms-flex-wrap: wrap;
	flex-wrap: wrap;
}

.row-space {
	-webkit-box-pack: justify;
	-webkit-justify-content: space-between;
	-moz-box-pack: justify;
	-ms-flex-pack: justify;
	justify-content: space-between;
}

.col-2 {
	width: -webkit-calc(( 100% - 60px)/2);
	width: -moz-calc(( 100% - 60px)/2);
	width: calc(( 100% - 60px)/2);
}

@media ( max-width : 767px) {
	.col-2 {
		width: 100%;
	}
}

/* ==========================================================================
	   #BOX-SIZING
	   ========================================================================== */
/**
	 * More sensible default box-sizing:
	 * css-tricks.com/inheriting-box-sizing-probably-slightly-better-best-practice
	 */
html {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

* {
	padding: 0;
	margin: 0;
}

*, *:before, *:after {
	-webkit-box-sizing: inherit;
	-moz-box-sizing: inherit;
	box-sizing: inherit;
}

/* ==========================================================================
	   #RESET
	   ========================================================================== */
/**
	 * A very simple reset that sits on top of Normalize.css.
	 */
body, h1, h2, h3, h4, h5, h6, blockquote, p, pre, dl, dd, ol, ul, figure,
	hr, fieldset, legend {
	margin: 0;
	padding: 0;
}

/**
	 * Remove trailing margins from nested lists.
	 */
li>ol, li>ul {
	margin-bottom: 0;
}

/**
	 * Remove default table spacing.
	 */
table {
	border-collapse: collapse;
	border-spacing: 0;
}

/**
	 * 1. Reset Chrome and Firefox behaviour which sets a `min-width: min-content;`
	 *    on fieldsets.
	 */
fieldset {
	min-width: 0;
	/* [1] */
	border: 0;
}

button {
	outline: none;
	background: none;
	border: none;
}

/* ==========================================================================
	   #PAGE WRAPPER
	   ========================================================================== */
.page-wrapper {
	min-height: 100vh;
}

body {
	font-family: 'Nanum Gothic', sans-serif;
	font-weight: 400;
	font-size: 15px;
}

h2 {
	font-family: 'Nanum Gothic', sans-serif;
	font-size: 30px;
	font-weight: bolder;
	text-align: center;
}

#result1 {
	font-family: 'Nanum Gothic', sans-serif;
	font-size: 15px;
	font-weight: 800;
	color: red;
	text-align: center;
}

#result2 {
	font-family: 'Nanum Gothic', sans-serif;
	font-size: 15px;
	font-weight: 800;
	color: dodgerblue;
	text-align: center;
}

/* ==========================================================================
	   #BACKGROUND
	   ========================================================================== */
.bg-red {
	background: #ED1C16;
}

/* ==========================================================================
	   #SPACING
	   ========================================================================== */
.p-t-150 {
	padding-top: 150px;
}

.p-b-100 {
	padding-bottom: 100px;
}

/* ==========================================================================
	   #WRAPPER
	   ========================================================================== */
.wrapper {
	margin: 0 auto;
}

.wrapper--w400 {
	max-width: 400px;
}

.wrapper--w680 {
	max-width: 680px;
}

/* ==========================================================================
	   #TITLE
	   ========================================================================== */
.title {
	text-transform: uppercase;
	font-weight: 700;
	margin-bottom: 35px;
}

/* ==========================================================================
	   #CARD
	   ========================================================================== */
.card {
	overflow: hidden;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
	background: #fff;
}

.card-2 {
	-webkit-box-shadow: 0px 8px 20px 0px rgba(0, 0, 0, 0.15);
	-moz-box-shadow: 0px 8px 20px 0px rgba(0, 0, 0, 0.15);
	box-shadow: 0px 8px 20px 0px rgba(0, 0, 0, 0.15);
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
	width: 100%;
	display: table;
}

.card-2 .card-heading {
	background:
		url("https://cdn.crowdpic.net/detail-thumb/thumb_d_D6F554AC3A121A60B724FA4A303AA273.jpg")
		top left/cover no-repeat;
	width: 29%;
	display: table-cell;
}

.card-2 .card-body {
	display: table-cell;
	padding: 70px 80px;
	padding-bottom: 88px;
}

@media ( max-width : 767px) {
	.card-2 {
		display: block;
	}
	.card-2 .card-heading {
		width: 100%;
		display: block;
		padding-top: 300px;
		background-position: left center;
	}
	
	  .card-2 .card-body {
		display: block;
		padding: 60px 50px;
	}
}

.btn {
	line-height: 40px;
	display: inline-block;
	padding: 0 25px;
	cursor: pointer;
	color: #fff;
	font-family: 'Nanum Gothic', sans-serif;
	-webkit-transition: all 0.4s ease;
	-o-transition: all 0.4s ease;
	-moz-transition: all 0.4s ease;
	transition: all 0.4s ease;
	font-size: 14px;
	font-weight: 700;
	text-align: center;
}

.btn--radius {
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
}

.btn--green {
	background: #57b846;
}

.btn--green:hover {
	background: #4dae3c;
}

/* 추가한 div 레이아웃 속성들 */
.card_layout {
	display: flex;
	justify-content: center;
	align-items: center;
}

.btn_layout1 {
margin-top: 10px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.btn_layout2 {
margin-top: 10px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}
</style>


<body>
	<div class="page-wrapper bg-red p-t-150 p-b-100">
		<div class="wrapper wrapper--w400">
			<div class="card card-2 card_layout">
				<div class="card-body">
					<span class="error animated tada" id="msg"></span>
					<form name="form1" class="box" onsubmit="return checkStuff()">
						<h2>중복검사 결과</h2>
						<br>
						<br>

						<c:choose>
							<c:when test="${result==true}">
								<div id="result1">이미 사용중인 ID입니다.</div>
								<br>

								<!-- 			버튼 레이아웃 추가 -->
								<div class="btn_layout1">
									<button class="btn btn--radius btn--green" id="close"
										style="text-align: center">닫기</button>
								</div>
								<script>
									$("#close").on("click",function(){
										window.close();
										//팝업은 child window, 팝업을 띄운 창은 parent window 
										// 팝업에서 parent window를 호출하기 위해선 opener
										opener.document.getElementById("id").value="";
									})
								</script>
							</c:when>

							<c:otherwise>

								<div id="result2">사용가능한 ID입니다.</div>
								<br>
								<div id="result2">이 아이디를 사용하시겠습니까?</div>
								<br>

								<!-- 			버튼 레이아웃 추가 -->
								<div class="btn_layout2">
									<button class="btn btn--radius btn--green" type="button"
										id="use">사용</button>
									<button class="btn btn--radius btn--green" type="button"
										id="cancel">취소</button>
								</div>
								<script>
									$("#use").on("click",function(){
										opener.idValidFlag= true; //회원가입에 id 중복여부 확인 체크
										//이외 버튼 클릭시에는 false로 가입거부
										window.close();
									});
									$("#cancel").on("click",function(){
										opener.document.getElementById("id").value="";
										window.close();
									});
								</script>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>

</body>
</html>


