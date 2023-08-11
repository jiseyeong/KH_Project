<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<title>Register Form</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
</head>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');
	
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


body, h2, blockquote, p, pre, dl, dd, figure, hr, fieldset, legend {
	margin: 0;
	padding: 0;
}

table {
	border-collapse: collapse;
	border-spacing: 0;
}

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
.p-t-10 {
	padding-top: 10px;
}

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

.wrapper--w960 {
	max-width: 960px;
}

.wrapper--w680 {
	max-width: 680px;
}

/* ==========================================================================
   #BUTTON
   ========================================================================== */
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
.input-group {
	position: relative;
	margin-bottom: 30px;
	border-bottom: 1px solid #e5e5e5;
}

.inner-group {
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
   #SELECT2
   ========================================================================== */
.select--no-search .select2-search {
	display: none !important;
}

.rs-select2 .select2-container {
	width: 100% !important;
	outline: none;
}

.rs-select2 .select2-container .select2-selection--single {
	outline: none;
	border: none;
	height: 35px;
}

.rs-select2 .select2-container .select2-selection--single .select2-selection__rendered
	{
	line-height: 36px;
	padding-left: 0;
	color: #808080;
	font-size: 15px;
	font-family: 'Nanum Gothic', sans-serif;
	font-weight: 500;
}

.rs-select2 .select2-container .select2-selection--single .select2-selection__arrow
	{
	height: 35px;
	right: 4px;
	display: -webkit-box;
	display: -webkit-flex;
	display: -moz-box;
	display: -ms-flexbox;
	display: flex;
	-webkit-box-pack: center;
	-webkit-justify-content: center;
	-moz-box-pack: center;
	-ms-flex-pack: center;
	justify-content: center;
	-webkit-box-align: center;
	-webkit-align-items: center;
	-moz-box-align: center;
	-ms-flex-align: center;
	align-items: center;
}

.rs-select2 .select2-container .select2-selection--single .select2-selection__arrow b
	{
	display: none;
}

.rs-select2 .select2-container .select2-selection--single .select2-selection__arrow:after
	{
	font-family: 'Nanum Gothic', sans-serif;
	content: '\f2f9';
	font-size: 15px;
	color: #ccc;
	-webkit-transition: all 0.4s ease;
	-o-transition: all 0.4s ease;
	-moz-transition: all 0.4s ease;
	transition: all 0.4s ease;
}

.rs-select2 .select2-container.select2-container--open .select2-selection--single .select2-selection__arrow::after
	{
	-webkit-transform: rotate(-180deg);
	-moz-transform: rotate(-180deg);
	-ms-transform: rotate(-180deg);
	-o-transform: rotate(-180deg);
	transform: rotate(-180deg);
}

.select2-container--open .select2-dropdown--below {
	border: none;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
	-webkit-box-shadow: 0px 8px 20px 0px rgba(0, 0, 0, 0.15);
	-moz-box-shadow: 0px 8px 20px 0px rgba(0, 0, 0, 0.15);
	box-shadow: 0px 8px 20px 0px rgba(0, 0, 0, 0.15);
	border: 1px solid #e0e0e0;
	margin-top: 5px;
	overflow: hidden;
}
/* ------------------------------------------------------- */
/* IE */
#class::-ms-expand {
	display: none;
}

#class {
	-o-appearance: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
}

#class {
	font-family: 'Nanum Gothic', sans-serif;
	font-size: 16px;
	width: 150px;
	height: 35px;
	left: 25%;
	top: 5px;
	color: #666;
	background:
		url('https://freepikpsd.com/media/2019/10/down-arrow-icon-png-7-Transparent-Images.png')
		calc(100% - 5px) center no-repeat;
	background-size: 20px;
	padding: 5px 30px 0px 15px;
	border-radius: 25px;
	border: 0px solid #ffffff;
	outline: 0 none;
}

#class option {
	font-family: 'Nanum Gothic', sans-serif;
	background: #57b846;
	color: #fff;
	padding: 3px 0;
}

#class option:hover {
	background: #4dae3c;
}
/* ==========================================================================
   #TITLE
   ========================================================================== */
.title {
	text-transform: uppercase;
	font-weight: 700;
	margin-bottom: 45px;
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
	padding: 80px 70px;
	
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

#enter {
	font-family: 'Nanum Gothic', sans-serif;
	display: inline-block;
	border-radius: 4px;
	background-color: #57b846;
	border: none;
	color: #FFFFFF;
	text-align: center;
	font-size: 14px;
	transition: all 0.5s;
	cursor: pointer;
	line-height: 40px;
	padding: 0 25px;
	margin-left: 220px;
	letter-spacing: 1px;
	box-shadow: inset 0 0 0 0 #ED1C16;
	-webkit-transition: ease-out 0.4s;
	-moz-transition: ease-out 0.4s;
	transition: ease-out 0.4s;
}

#enter span {
	cursor: pointer;
	display: inline-block;
	position: relative;
	transition: 0.5s;
}

#enter span:after {
	content: '\0028' '\0020' '\02d8' '\0075' '\02D8' '\0020' '\0029';
	position: absolute;
	opacity: 0;
	top: 0;
	right: -40px;
	transition: 0.5s;
}

#enter:hover {
	padding-right: 30px;
	background: #4dae3c;
	box-shadow: inset 400px 0 0 0 #ED1C16;
}

#enter:hover span {
	padding-right: 20px;
	background: #ED1C16;
}

#enter:hover span:after {
	opacity: 1;
	right: 0;
	background: #ED1C16;
}
</style>
<body>
<body>
	<div class="page-wrapper bg-red p-t-150 p-b-100">
		<div class="wrapper wrapper--w960">
			<div class="card card-2">
				<div class="card-heading"></div>
				<div class="card-body">
					<h2 class="title">KH PLATE에 오신 것을 환영합니다!</h2>
					<form class="frm" action="/join.members" method="POST">
						
						
						<div class="row row-space">
							<div class="col-2">
								<div class="input-group">
									<input class="input--style-2" type="text" placeholder="이름"
										id="name" name="name">
								</div>
							</div>
							<div class="col-2">
								<div class="input-group">
									<div class="rs-select2 js-select-simple select--no-search">
										<select id="class" name="classes" class="input--style-2">
											<option disabled="disabled" selected="selected">반</option>
											<option value="A">A 클래스</option>
											<option value="B">B 클래스</option>
											<option value="C">C 클래스</option>
											<option value="D">D 클래스</option>
											<option value="E">E 클래스</option>
											<option value="F">F 클래스</option>
										</select>
										<div class="select-dropdown"></div>
									</div>
								</div>
							</div>
						</div>


						<div class="row row-space">
							<div class="col-2">
								<div class="input-group">
									<input class="input--style-2" type="text" placeholder="아이디"
										id="id" name="id">
								</div>
							</div>
							<div class="col-2">
								<button class="btn btn--radius btn--green" type="button"
									id="idCheck">중복체크</button>
							</div>
						</div>




						<div class="row row-space">
							<div class="col-2">
								<div class="input-group">
									<input class="input--style-2" type="password"
										placeholder="비밀번호" id="pw1" name="pw">
								</div>
								<div class="input-group">
									<input class="input--style-2" type="password"
										placeholder="비밀번호 확인" id="pw2">
								</div>
							</div>


							<div class="col-2">
								<div class="inner-groups">
									<div class="alert alert-danger">
              
                <p>ID:7-13자 알파벳 소문자, 숫자
                <br>PW: 7-13자 알파벳 대소문자, 숫자</p> 
            </div>
								
								
									<div class="inner-groups">
										<div id="pwCheck"></div>
									</div>
								</div>
							</div>
						</div>


						<div class="inner-group">
							<input class="input--style-2" type="text" placeholder="이메일"
								id="email" name="email">
						</div>


						<!-- 						인증코드 발송 부분 주석처리 -->

						<!-- 						<div class="row row-space"> -->
						<!-- 							<div class="col-2"> -->
						<!-- 								<div class="input-group"> -->
						<!-- 									<input class="input--style-2" type="text" placeholder="인증코드" -->
						<!-- 										id="reg_code" name="reg_code"> -->
						<!-- 								</div> -->
						<!-- 							</div> -->
						<!-- 							<div class="col-2"> -->
						<!-- 								<button class="btn btn--radius btn--green" type="button" -->
						<!-- 									id="reg_send">코드발송</button> -->
						<!-- 							</div> -->
						<!-- 						</div> -->



						<div class="p-t-10">
							<button class="btn btn--radius btn--green" type="submit"
								id="enter">
								<span>냠냠</span>
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script>
            var idValidFlag = false;
    
            $("#idCheck").on(
                "click",
                function () {
                    window.open("/IdCheck.members?id="+$("#id").val(),"","width=450px, height=630px");
                });
            
            $("#id").on("change", function () {
                idValidFlag = false;
            })
    
            $("#pw2,#pw1").on(
                "keyup",
                function () { //비밀번호 일치여부 표시
                    if ($("#pw2").val() == $("#pw1").val()) {
                        $("#pwCheck").html("비밀번호가 일치합니다 <i class='bi bi-emoji-smile'></i>").css({"color":"dodgerblue"})
                    } else {
                        $("#pwCheck").html("비밀번호가 일치하지 않습니다 <i class='bi bi-emoji-frown'></i>").css({"color":"red"})
                    }
                });
    
          
    
            $(".frm").on(
                "submit",
                function () {
                    //입력 형식 제한
                    var regexID = /^[a-z0-9_]{7,13}$/;
                    var regexPW = /^[A-Za-z0-9]{7,13}$/;
                    var regexName = /^[가-힣]+$/;
                    var regexPhone = /^010[0-9]{8}$/;
                    var regexEmail = /^(?=.{1,30}$)[^@\s]+@[^@\s]+\.[^@\s]+$/;
    
                    var name = $("#name").val();
                    var id = $("#id").val();
                    var pw1 = $("#pw1").val();
                    var pw2 = $("#pw2").val();
                    var email = $("#email").val();
    
                    if (id == "" || pw1 == "" || pw2 == "" || name == ""|| email == "") { //필수항목 입력 여부 체크
                        Swal.fire({
                            icon: "error",
                            title: "Oops...",
                            text: "필수 항목을 모두 입력해주세요."
                        });
                        return false;
                    }
                    
                    //형식 제한 준수 여부 체크
                    if (!regexID.test(id)) {
                        Swal.fire({
                            icon: "error",
                            title: "ID 형식 오류",
                            text: "7-13자의 알파벳 소문자, 숫자 형태로 입력해주세요",
                        });
                        return false;
                    }
                    
                    // ID 중복체크 확인 코드
                    if (idValidFlag==false){
                    	Swal.fire({
                            icon: "error",
                            title: "ID 중복 검사 미실시",
                            text: "ID 중복 검사를 실시해주세요."
                        });
                        return false;
                    }
                    
                    if (!regexPW.test(pw1)) {
                        Swal.fire({
                            icon: "error",
                            title: "Password 형식 오류",
                            text: "7-13자의 알파벳 대소문자,숫자 형태로 입력해주세요",
                        });
                        return false;
                    }
                    
                    // 패스워드 형식 확인 여부
                    if (pw1 != pw2) {
                    	 Swal.fire({
                             icon: "error",
                             title: "Password 불일치",
                             text: "패스워드를 다시 확인해주세요.",
                         });
						return false;
					}
                    
                    // 이름 형식 확인 여부
                    if (!regexName.test(name)) {
                        Swal.fire({
                            icon: "error",
                            title: "NAME 형식 오류",
                            text: "한글만 입력 가능합니다.",
                        });
                        return false;
                    }
                    
                	 // 이메일 형식 확인 여부
                    if (!regexEmail.test(email)) {
                        Swal.fire({
                            icon: "error",
                            title: "EMAIL 형식 오류",
                            text: "ID@address 형식으로 입력해주세요.",
                        });
                        return false;
                    }else{
                    	return true;
                    }
                });
        </script>
</body>
</html>
