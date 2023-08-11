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
<link href="vendor/font-awesome-4.7/css/font-awesome.min.css"
	rel="stylesheet" media="all">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
</head>

<style>
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
	font-family: 'Nanum Gothic', sans-serif;
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
	font-family: 'Nanum Gothic', sans-serif;
	text-align: center;
	margin-bottom: 20px;
}


h4 {
    text-align: center;
	font-size: 18px;
	font-weight: 400;
	font-family: 'Nanum Gothic', sans-serif;
	margin-top: 35px;
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

#emailicon {
  position: relative;
  animation-name: send;
  animation-duration: 4s;
}

@keyframes send {
  0%   {color:rgb(0, 0, 0); left:0px; top:0px;}
  50%  {color:#57b846; left:200px; top:0px;}
  100% {color:rgb(0, 0, 0); left:0px; top:0px;}
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

</style>
<body>
<body>
	<div class="page-wrapper bg-red p-t-180 p-b-100">
		<div class="wrapper wrapper--w960">
			<div class="card card-2">
				<div class="card-body">
					<div class="row row-space">
						<div class="col-2">
							<div class="input-group">
								<svg xmlns="http://www.w3.org/2000/svg" width="160" height="160" fill="currentColor" id="emailicon" class="bi bi-envelope-at" viewBox="0 0 16 16">
									<path d="M2 2a2 2 0 0 0-2 2v8.01A2 2 0 0 0 2 14h5.5a.5.5 0 0 0 0-1H2a1 1 0 0 1-.966-.741l5.64-3.471L8 9.583l7-4.2V8.5a.5.5 0 0 0 1 0V4a2 2 0 0 0-2-2H2Zm3.708 6.208L1 11.105V5.383l4.708 2.825ZM1 4.217V4a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v.217l-7 4.2-7-4.2Z"/>
									<path d="M14.247 14.269c1.01 0 1.587-.857 1.587-2.025v-.21C15.834 10.43 14.64 9 12.52 9h-.035C10.42 9 9 10.36 9 12.432v.214C9 14.82 10.438 16 12.358 16h.044c.594 0 1.018-.074 1.237-.175v-.73c-.245.11-.673.18-1.18.18h-.044c-1.334 0-2.571-.788-2.571-2.655v-.157c0-1.657 1.058-2.724 2.64-2.724h.04c1.535 0 2.484 1.05 2.484 2.326v.118c0 .975-.324 1.39-.639 1.39-.232 0-.41-.148-.41-.42v-2.19h-.906v.569h-.03c-.084-.298-.368-.63-.954-.63-.778 0-1.259.555-1.259 1.4v.528c0 .892.49 1.434 1.26 1.434.471 0 .896-.227 1.014-.643h.043c.118.42.617.648 1.12.648Zm-2.453-1.588v-.227c0-.546.227-.791.573-.791.297 0 .572.192.572.708v.367c0 .573-.253.744-.564.744-.354 0-.581-.215-.581-.8Z"/>
								  </svg>
							</div>
						</div>
						<div class="col-2">
							<br>
							<h4 class="title">아래 이메일로 인증 메일을 전송하였습니다.</h4>
					<h4 class="title">이메일 인증 후 로그인 가능합니다.</h4> 
						</div>
					</div>
					<br>
					<br>
					<h1 class="title">${email}</h1>
						<br>
					<button class="button" id="toMain"><span>메인 페이지로 이동 </span></button>
				</div>
			</div>
		</div>
	</div>


	<script>
	$("#toMain").on("click",function () {
			location.href = "/page/main.jsp"});	</script>

</body>
</html>



