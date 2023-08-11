<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags-->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">


<!-- Title Page-->
<title>Re</title>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>

<!-- Icons font CSS-->
<link href="vendor/mdi-font/css/material-design-iconic-font.min.css"
	rel="stylesheet" media="all">
<link href="vendor/font-awesome-4.7/css/font-awesome.min.css"
	rel="stylesheet" media="all">

<!-- Vendor CSS-->
<link href="vendor/select2/select2.min.css" rel="stylesheet" media="all">


<!-- Main CSS-->
<link href="css/main.css" rel="stylesheet" media="all">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
</head>

<style>
/* ==========================================================================
   #FONT
   ========================================================================== */
   @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');

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
	font-size: 15px;
}


h1 {
	font-size: 36px;
	font-weight: bold;
	font-weight: 400;
	font-family: 'Nanum Gothic', sans-serif;

}


h4 {
text-align: center;
	font-size: 18px;
	font-weight: 400;
	font-family: 'Nanum Gothic', sans-serif;
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

.p-t-180 {
	padding-top: 180px;
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

.wrapper--w960 {
	max-width: 960px;
}

.wrapper--w680 {
	max-width: 680px;
}

/* ==========================================================================
   #TITLE
   ========================================================================== */
.title {
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


.button {
  display: inline-block;
  border-radius: 4px;
  background-color: #57b846;
  border: none;
  color: #FFFFFF;
  text-align: center;
  font-size: 15px;
  padding: 20px;
  width: 200px;
  transition: all 0.5s;
  cursor: pointer;
  margin: 5px;
  margin-left: 40%;
}

.button span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.5s;
}

.button span:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

.button:hover span {
  padding-right: 25px;
}

.button:hover span:after {
  opacity: 1;
  right: 0;
  background: #4dae3c;
}

#checked {
  position: relative;
  animation-name: checking;
  animation-duration: 3s;
  animation-fill-mode: forwards;
}

@keyframes checking {
  from {color:transparent;}
  to {color:#57b846;}
}

</style>

<body>
	<div class="page-wrapper bg-red p-t-180 p-b-100">
		<div class="wrapper wrapper--w960">
			<div class="card card-2">
				<div class="card-body">
					<div class="row row-space">
						<div class="col-2">
							<div class="input-group">
								<svg xmlns="http://www.w3.org/2000/svg" width="160" height="160" fill="currentColor" class="bi bi-person-check-fill" viewBox="0 0 16 16">
									<path fill-rule="evenodd" id="checked" d="M15.854 5.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 0 1 .708-.708L12.5 7.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
									<path d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
								  </svg>
							</div>
						</div>
						<div class="col-2">
							<br>
							<h1 class="title">${userid}님,<br><br>오늘은 뭐 드실래요?</h1>
						</div>
					</div>
					<br>
					<br>
					<h4 class="title">이메일 인증이 완료되었습니다.</h4>
					<h4 class="title">이제 로그인 후 이용이 가능합니다.</h4>
					
					<button class="button" id="toMain"><span>메인 페이지로 이동 </span></button>

				</div>
			</div>
		</div>
	</div>

	<!-- Jquery JS-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<!-- Vendor JS-->
	<script src="vendor/select2/select2.min.js"></script>
	<script src="vendor/datepicker/moment.min.js"></script>
	<script src="vendor/datepicker/daterangepicker.js"></script>
	<!-- Main JS-->
	<script src="js/global.js"></script>
	<script>
$("#toMain").on("click",function () {
			location.href = "/page/main.jsp"});
		</script>

</body>
</html>



