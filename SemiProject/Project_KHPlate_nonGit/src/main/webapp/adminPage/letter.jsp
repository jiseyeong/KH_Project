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
<title>letter</title>

<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>

<!-- Icons font CSS-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">


<!-- Main CSS-->
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
body, h2, blockquote, p, pre, dl, dd, figure, hr {
	margin: 0;
	padding: 0;
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
.p-t-130 {
	padding-top: 130px;
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


/* ==========================================================================
   #BUTTON
   ========================================================================== */
.btn {
	line-height: 40px;
	display: inline-block;
	text-align: center;
	margin-left: 365px;
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

/* ==========================================================================
   #FORM
   ========================================================================== */
input {
	outline: none;
	margin: 0;
	border: none;
	-webkit-box-shadow: none;
	-moz-box-shadow: none;
	box-shadow: none;
	width: 100%;
	font-size: 15px;
	font-family: 'Nanum Gothic', sans-serif;
}

/* input group 1 */
/* end input group 1 */
.input-group {
	position: relative;
	margin-bottom: 30px;
	border-bottom: 1px solid #e5e5e5;
}

.input--style-2 {
	padding: 9px 0;
	color: #666;
	font-size: 16px;
	font-weight: 500;
}

.input--style-2::-webkit-input-placeholder {
	/* WebKit, Blink, Edge */
	color: #808080;
}

.input--style-2:-moz-placeholder {
	/* Mozilla Firefox 4 to 18 */
	color: #808080;
	opacity: 1;
}

.input--style-2::-moz-placeholder {
	/* Mozilla Firefox 19+ */
	color: #808080;
	opacity: 1;
}

.input--style-2:-ms-input-placeholder {
	/* Internet Explorer 10-11 */
	color: #808080;
}

.input--style-2:-ms-input-placeholder {
	/* Microsoft Edge */
	color: #808080;
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

.card-2 .card-body {
	display: table-cell;
	padding: 70px 80px;
	padding-bottom: 88px;
}

@media ( max-width : 767px) {
	.card-2 {
		display: block;
	}
	.card-2 .card-body {
		display: block;
		padding: 60px 50px;
	}
}
</style>
<body>
<body>
	<div class="page-wrapper bg-red p-t-130 p-b-100 font-robo">
		<div class="wrapper wrapper--w960">
			<div class="card card-2">
				<div class="card-body">
					<h2 class="title">이용약관</h2>

					<div class="input-group">

						<textarea rows="" cols="" readonly
							style="width: 800px; height: 233px; font-size: 15px; font-family:'Nanum Gothic', sans-serif;">이 편지는 영국에서 최초로 시작되어 일년에 한바퀴를 돌면서 받는 사람에게 행운을 주었고 지금은 당신에게로 옮겨진 이 편지는 4일 안에 당신 곁을 떠나야 합니다. 이 편지를 포함해서 7통을 행운이 필요한 사람에게 보내 주셔야 합니다. 복사를 해도 좋습니다. 혹 미신이라 하실지 모르지만 사실입니다.

​

영국에서 HGXWCH이라는 사람은 1930년에 이 편지를 받았습니다. 그는 비서에게 복사해서 보내라고 했습니다. 며칠 뒤에 복권이 당첨되어 20억을 받았습니다. 어떤 이는 이 편지를 받았으나 96시간 이내 자신의 손에서 떠나야 한다는 사실을 잊었습니다. 그는 곧 사직되었습니다. 나중에야 이 사실을 알고 7통의 편지를 보냈는데 다시 좋은 직장을 얻었습니다. 미국의 케네디 대통령은 이 편지를 받았지만 그냥 버렸습니다. 결국 9일 후 그는 암살당했습니다. 기억해 주세요. 이 편지를 보내면 7년의 행운이 있을 것이고 그렇지 않으면 3년의 불행이 있을 것입니다. 그리고 이 편지를 버리거나 낙서를 해서는 절대로 안됩니다. 7통입니다. 이 편지를 받은 사람은 행운이 깃들 것입니다. 힘들겠지만 좋은게 좋다고 생각하세요. 7년의 행운을 빌면서...</textarea>
					</div>
					
					<div class="p-t-10">
						<button class="btn btn--radius btn--green" type="button" id="closebtn">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script>
	$("#closebtn").on("click",function(){
		window.close();
	});
    </script>


</body>
</html>



