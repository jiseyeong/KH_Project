<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
	<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css">
	<link rel="stylesheet"
	href="https://unicons.iconscout.com/release/v2.1.9/css/unicons.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
<title>비밀번호 재발급</title>
</head>

<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');


body{
  font-family:'Nanum Gothic', sans-serif;
  font-weight: 300;
  font-size: 15px;
  line-height: 1.7;
  color: #000000;
  background-color: #ED1C16;
  overflow-x: hidden;
}
a {
  cursor: pointer;
  transition: all 200ms linear;
}
a:hover {
  text-decoration: none;
}
.link {
  color: #c4c3ca;
}
.link:hover {
  color: #ffeba7;
}
p {
  font-weight: 500;
  font-size: 14px;
  line-height: 1.7;
}
h4 {
  font-weight: 600;
}

.section{
  position: relative;
  width: 100%;
  display: block;
}
.full-height{
  min-height: 100vh;
}

.card-3d-wrap {
  position: relative;
  width: 440px;
  max-width: 100%;
  height: 400px;
  perspective: 800px;
  margin-top: 60px;
}
.card-3d-wrapper {
  width: 100%;
  height: 100%;
  position:absolute;    
  top: 0;
  left: 0;  
  transition: all 600ms ease-out; 
}
.card {
  width: 100%;
  height: 100%;
  background-color: #ffffff;
  background-position: bottom center;
  background-repeat: no-repeat;
  background-size: 300%;
  position: absolute;
  border-radius: 6px;
  left: 0;
  top: 0;
  -webkit-backface-visibility: hidden;
  -moz-backface-visibility: hidden;
  -o-backface-visibility: hidden;
  backface-visibility: hidden;
}

.center-wrap{
  position: absolute;
  width: 100%;
  padding: 0 35px;
  top: 50%;
  left: 0;
  transform: translate3d(0, -50%, 35px) perspective(100px);
  z-index: 20;
  display: block;
}


.form-group{ 
  position: relative;
  display: block;
   margin: 5px;
    padding: 2px;
}
.form-style {
  padding: 13px 20px;
  padding-left: 55px;
  height: 48px;
  width: 100%;
  font-weight: 500;
  border-radius: 4px;
  font-size: 14px;
  line-height: 22px;
  letter-spacing: 0.5px;
  outline: none;
  color: #c4c3ca;
  background-color: #f2f2f2;
  border: none;
  -webkit-transition: all 200ms linear;
  transition: all 200ms linear;
  box-shadow: 0 4px 8px 0 rgba(21,21,21,.2);
}
.form-style:focus,
.form-style:active {
  border: none;
  outline: none;
  box-shadow: 0 4px 8px 0 rgba(21,21,21,.2);
}

.form-group input:-ms-input-placeholder  {
  color: #c4c3ca;
  opacity: 0.7;
  -webkit-transition: all 200ms linear;
    transition: all 200ms linear;
}
.form-group input::-moz-placeholder  {
  color: #c4c3ca;
  opacity: 0.7;
  -webkit-transition: all 200ms linear;
    transition: all 200ms linear;
}
.form-group input:-moz-placeholder  {
  color: #c4c3ca;
  opacity: 0.7;
  -webkit-transition: all 200ms linear;
    transition: all 200ms linear;
}
.form-group input::-webkit-input-placeholder  {
  color: #c4c3ca;
  opacity: 0.7;
  -webkit-transition: all 200ms linear;
    transition: all 200ms linear;
}
.form-group input:focus:-ms-input-placeholder  {
  opacity: 0;
  -webkit-transition: all 200ms linear;
    transition: all 200ms linear;
}
.form-group input:focus::-moz-placeholder  {
  opacity: 0;
  -webkit-transition: all 200ms linear;
    transition: all 200ms linear;
}
.form-group input:focus:-moz-placeholder  {
  opacity: 0;
  -webkit-transition: all 200ms linear;
    transition: all 200ms linear;
}
.form-group input:focus::-webkit-input-placeholder  {
  opacity: 0;
  -webkit-transition: all 200ms linear;
    transition: all 200ms linear;
}

.btn{  
  border-radius: 4px;
  height: 44px;
  font-size: 13px;
  font-weight: 600;
  text-transform: uppercase;
  -webkit-transition : all 200ms linear;
  transition: all 200ms linear;
  padding: 0 30px;
  letter-spacing: 1px;
  display: -webkit-inline-flex;
  display: -ms-inline-flexbox;
  display: inline-flex;
  -webkit-align-items: center;
  -moz-align-items: center;
  -ms-align-items: center;
  align-items: center;
  -webkit-justify-content: center;
  -moz-justify-content: center;
  -ms-justify-content: center;
  justify-content: center;
  -ms-flex-pack: center;
  text-align: center;
  border: none;
  background-color: #57b846;
  color: #ffffff;
  box-shadow: 0 8px 24px 0 rgba(255,235,167,.2);
}
.btn:active,
.btn:focus{  
  background-color: #4dae3c;
  color: #ffffff;
  box-shadow: 0 8px 24px 0 rgba(16,39,112,.2);
}
.btn:hover{  
  background-color: #4dae3c;
  color: #ffffff;
  box-shadow: 0 8px 24px 0 rgba(16,39,112,.2);
}

#pwCheck{
	 height:35px;
}

.bi-lock {
	color: #73717f;
	position: absolute;
	margin-left: 20px;
	margin-top: 15px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bi-key {
	color: #73717f;
	position: absolute;
	margin-left: 20px;
	margin-top: 15px;
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>


<body>
	<form id="frm" action="/newpwset.members" method="post">
	  <div class="section">
		<div class="container">
		  <div class="row full-height justify-content-center">
			<div class="col-12 text-center align-self-center py-5">
			  <div class="section pb-5 pt-5 pt-sm-2 text-center">
				<div class="card-3d-wrap mx-auto">
				  <div class="card-3d-wrapper">
					<div class="card">
					  <div class="center-wrap">
						<div class="section text-center">
						  <h4 class="mb-4 pb-3">비밀번호 재발급</h4>
						  <div class="form-group"> 
						  <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi-lock" viewBox="0 0 16 16">
  <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2zM5 8h6a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V9a1 1 0 0 1 1-1z"/>
</svg>
						  	<input type="text" name="userid" style="display:none" value="${userid}" >
							<input type="password" name="pw1" class="form-style" id="pw1" placeholder="새로운 비밀번호 입력" autocomplete="off"> 
						  </div>  
						  <div class="form-group mt-2">
						  <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi-key" viewBox="0 0 16 16">
  <path d="M0 8a4 4 0 0 1 7.465-2H14a.5.5 0 0 1 .354.146l1.5 1.5a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0L13 9.207l-.646.647a.5.5 0 0 1-.708 0L11 9.207l-.646.647a.5.5 0 0 1-.708 0L9 9.207l-.646.647A.5.5 0 0 1 8 10h-.535A4 4 0 0 1 0 8zm4-3a3 3 0 1 0 2.712 4.285A.5.5 0 0 1 7.163 9h.63l.853-.854a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.793-.793-1-1h-6.63a.5.5 0 0 1-.451-.285A3 3 0 0 0 4 5z"/>
  <path d="M4 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
</svg>
							<input type="password" id="pw2" name="pw2" class="form-style" placeholder="비밀번호 재입력" autocomplete="off">
							<div id=pwCheck></div>
						  </div>
						  
						  <input type="submit" value = 제출하기 class="btn" value="제출하기" id="passwordcheck">

							</div>
						  </div>
						</div>
					  </div>
					</div>
				  </div>
				</div>
			  </div>
		  </div>
	  </div>

	
	</form>



	

    <script>


        $("#pw2").on(
            "keyup",
            function () { //비밀번호 일치여부 표시
                if ($("#pw2").val() == $("#pw1").val()) {
                    $("#pwCheck").html("비밀번호가 일치합니다 :)").css("color",
                        "dodgerblue");
                } else {
                    $("#pwCheck").html("비밀번호를 확인하세요 :(").css("color",
                        "red", font - size);
                }
            });


        $("#frm").on(
            "submit",
            function () {
                //입력 형식 제한
				
					
                var regexPW = /^[A-Za-z0-9]{7,13}$/;


                var pw1 = $("#pw1").val();
                var pw2 = $("#pw2").val();


                if (pw2 == "") { //필수항목 입력 여부 체크
                    Swal.fire({
                        icon: "error",
                        title: "Oops...",
                        text: "비밀번호를 입력해주세요."
                    });
                    return false;
                }
                if (pw1 != pw2) { //패스워드 일치 여부 체크
                    Swal.fire({
                        icon: "error",
                        title: "Oops...",
                        text: "패스워드를 다시 확인해주세요"
                    });
                    return false;
                }


                //형식 제한 준수 여부 체크


                if (!regexPW.test(pw1)) {
                    Swal.fire({
                        icon: "error",
                        title: "Password 형식 오류",
                        text: "7-13자의 알파벳 대소문자, 숫자",
                    });
                    return false;
                }
            })
    </script>

</body>

</html>