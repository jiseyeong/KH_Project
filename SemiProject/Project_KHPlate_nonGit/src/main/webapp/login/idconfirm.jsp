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
<title>ID Confirm</title>

<link
	rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script
	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"
	charset="utf-8"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/typicons/2.1.2/typicons.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
</head>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap')
	;

/* ==========================================================================
   #FONT
   ========================================================================== */
.font-robo {
	font-family: 'Nanum Gothic', sans-serif;
}

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


html {
	font-family: 'Nanum Gothic', sans-serif;
	background-color: #ED1C16;
	padding: 0;
	margin: 0;
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


h1 {
	font-family: 'Nanum Gothic', sans-serif;
	margin-top: 30px;
}

h2 {
	font-family: 'Nanum Gothic', sans-serif;
	margin-top: 30px;
}

#close {
	width: 100px;
	height: 40px;
	background-color: #57b846;
	border:  #57b846;
	border-radius: 3px;
	cursor: pointer;
	color: white;
	font-size: 14px;
	box-shadow:1px 1px 5px 1px rgb(231, 231, 231);
	position: absolute;
	margin-left: -42px;
	margin-top: 42px;
}

#member {
	font-family: 'Nanum Gothic', sans-serif;
	font-size: 25px;
}

#memberimg {
	width: 40%;
	height: 40%;
}

#bi-person-fill-exclamation {
	position: absolute;
	margin-left: 120px;
	margin-top: 60px;
display: flex;
justify-content: center;
align-items: center;
}
/* 배경 색상 추가 */
body {
	margin:0;
	padding:0;
	background-color: #ED1C16;
}

</style>

<body id="particles-js">
	<div class="animated bounceInDown">
		<div class="container">

			<div id="memberimg">
				<svg xmlns="http://www.w3.org/2000/svg" width="150" height="150" fill="currentColor" id="bi-person-fill-exclamation" viewBox="0 0 16 16">
  <path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm-9 8c0 1 1 1 1 1h5.256A4.493 4.493 0 0 1 8 12.5a4.49 4.49 0 0 1 1.544-3.393C9.077 9.038 8.564 9 8 9c-5 0-6 3-6 4Z"/>
  <path d="M16 12.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Zm-3.5-2a.5.5 0 0 0-.5.5v1.5a.5.5 0 0 0 1 0V11a.5.5 0 0 0-.5-.5Zm0 4a.5.5 0 1 0 0-1 .5.5 0 0 0 0 1Z"/>
</svg>
			</div>
			<c:choose>
				<c:when test="${userid!=null}">
					<h2 id="member">귀하의 아이디는</h2> 
					<h1>${userid}</h1>
					<h2>입니다</h2>
				</c:when>
				<c:otherwise>
					<h2>&nbsp</h2>
					<h2 id=nomember>존재하는 아이디가 없습니다</h2>
					<h2>&nbsp</h2>
				</c:otherwise>
			</c:choose>
			<div>
			<button type="button" id=close>닫기</button>
			</div>
		</div>
	</div>

	<script>
		$("#close").on("click", function() {
			window.close();
			//팝업은 child window, 팝업을 띄운 창은 parent window 
			// 팝업에서 parent window를 호출하기 위해선 opener
			opener.document.getElementById("id").value = "";
		})
	</script>
</body>

</html>


