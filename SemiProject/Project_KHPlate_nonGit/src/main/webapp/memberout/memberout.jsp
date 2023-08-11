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
<title>Member Out</title>

<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/typicons/2.1.2/typicons.min.css">
</head>



<style>
	
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');


body, html {
	font-family: 'Nanum Gothic', sans-serif;
	background-color: #ED1C16;
	padding: 0;
	margin: 0;
}

#particles-js {
	position: absolute;
	width: 100%;
	height: 100%;
}

.container {
	font-family: 'Nanum Gothic', sans-serif;
	margin: 0;
	top: 50px;
	left: 50%;
	position: absolute;
	text-align: center;
	transform: translateX(-50%);
	background-color: white;
	border-radius: 9px;
	border-top: 10px solid #57b846;
	border-bottom: 10px solid #57b846;
	width: 400px;
	height: 550px;
}

.box h4 {
	font-family: 'Nanum Gothic', sans-serif;
	color: #ED1C16;
	font-size: 25px;
	margin-top: 90px;;
	font-weight: bolder;
}

.box h5 {
	font-family: 'Nanum Gothic', sans-serif;
	font-size: 15px;
	color: #a1a4ad;
	letter-spacing: 1.5px;
	margin-top: -15px;
	margin-bottom: 60px;
		font-weight: bolder;
}

.box input[type="text"], .box input[type="password"] {
	display: block;
	margin: 20px auto;
	background: #f2f2f2;
	border: 0;
	border-radius: 5px;
	padding: 14px 10px;
	width: 320px;
	outline: none;
	color: #000000;
	-webkit-transition: all .2s ease-out;
	-moz-transition: all .2s ease-out;
	-ms-transition: all .2s ease-out;
	-o-transition: all .2s ease-out;
	transition: all .2s ease-out;
}

::-webkit-input-placeholder {
	color: #565f79;
}

.box input[type="text"]:focus, .box input[type="password"]:focus {
	border: 1px solid #79A6FE;
}

.btn {
    font-family: 'Nanum Gothic', sans-serif;
    background: #57b846;
	color: #dfdeee;
	border: 0;
	border-radius: 100px;
	width: 340px;
	height: 49px;
	font-size: 16px;
	left: 8%;
	transition: 0.3s;
	cursor: pointer;
}

.btn:hover {
	background: #4dae3c;
}

#memberout{
  top: 62%;
    margin-top: 10px;
  margin-bottom: 10px;
  animation-name: noexit;
  animation-duration: 4s;
  animation-iteration-count: infinite;
}

@keyframes noexit {
  0%   {opacity: 0%; left:0px; top:0px;}
  25%  {opacity: 50%; left:0px; top:0px;}
  50%  {opacity: 100%; left:0px; top:0px;}
  75%  {opacity: 50%; left:0px; top:0px;}
  100% {opacity: 0%; left:0px; top:0px;}
}

#cancel {
    top: 72%;
}

</style>

<body id="particles-js">
<div class="animated bounceInDown">
	<div class="container">
		<span class="error animated tada" id="msg"></span>
		<div class="box">
			<h4>정말 탈퇴하실 건가요?</h4>
	        <h5>내일은 뭐 먹게...</h5>
			<div class="input password">
              	<input type="text" value="${sessionScope.loginID}" id="inputId" name="userId" placeholder="ID" autocomplete="off">
				<input type="password" name="userPw" id="inputPw" placeholder="PW" autocomplete="off" class="form-input">
			</div>
			<input type="button" value="탈퇴하기" class="btn" id="memberout">
			<input type="button" value="취소하기" class="btn" id="cancel">
		</div>
	</div>
</div>

<script>
	$("#memberout").on("click",function(){
		let inputID = $("#inputId").val();
		let inputPw = $("#inputPw").val();
		
		if(inputID==""){
			alert("ID를 입력해주세요.");
			return;
		}else if(inputPw==""){
			alert("비밀번호를 입력해주세요.");
			return;
		}
		
		$.ajax({
			url:"/memberout.members",
			type:"post",
			data:{
				userId:inputID,
				userPw:inputPw
			}
		
		}).done(function(resp){
			if(resp == "1") {
				alert("아이디가 잘못 되었습니다.");
				location.reload();
			}else if(resp == "2"){
				alert("비밀번호가 잘못 되었습니다.");
				location.reload();
			}else if(resp == "3"){
				alert("회원탈퇴가 완료되었습니다.");
				location.href = "/page/main.jsp";
			}
			return;
		});
	})
	
	$("#cancel").on("click",function(){
		history.back();
	})
	</script>
</body>
</html>



	



	