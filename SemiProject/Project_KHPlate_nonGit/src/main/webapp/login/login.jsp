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
<title>Login Form</title>

<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/typicons/2.1.2/typicons.min.css">

<!-- 네이버 로그인 -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>

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
   margin-top: 55px;;
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

a {
   font-family: 'Nanum Gothic', sans-serif;
   color: black;
   font-size: 13px;
   text-decoration: none;
}

a:hover {
   text-decoration: underline;
}

label input[type="checkbox"] {
   display: none; /* hide the default checkbox */
}

/* style the artificial checkbox */
/* label span {
   height: 13px;
   width: 13px;
   border: 2px solid #464d64;
   border-radius: 2px;
   display: inline-block;
   position: relative;
   cursor: pointer;
   float: left;
   left: 7.5%;
} */
.btn {
   font-family: 'Nanum Gothic', sans-serif;
   border: 0;
   border-radius: 100px;
   width: 340px;
   height: 49px;
   font-size: 16px;
   position: absolute;
   left: 8%;
   transition: 0.3s;
   cursor: pointer;
   line-height:49px;
   text-align:center;
}

#signupBtn:hover {
   background: #4dae3c;
}

#signupBtn {
   top: 62%;
   background: #57b846;
   color: #ffffff;
}

#kakaoBtn {
   top: 72%;
   background: #ffe812;
   background-size: 320px 50px;
   background-position: top;
   background-position: 10px;
   display:flex;
   align-items:center;
   justify-content:center;
}

#naverIdLogin_loginButton {
	top: 82%;
	background: #57b846;
	background-size: 300px 80px;
	background-position: 33px;
    font-family: 'Nanum Gothic', sans-serif;
	border: 0;
	border-radius: 100px;
	width: 340px;
	height: 49px;
	font-size: 16px;
	color: white;
	position: absolute;
	left: 8%;
	transition: 0.3s;
	cursor: pointer;
	display:flex;
	align-items:center;
	justify-content:center;
}
#kakaoBtn>div{
	position:relative;
	right:20px;
}
#naverIdLogin_loginButton>div{
	position:relative;
	right:20px;
}
.kakaoImage{
	display:flex;
	justify-content:start;
	position:relative;
	right:80px;
}
.naverImage{
	display:flex;
	justify-content:start;
	position:relative;
	right:80px;
}
.rmb {
   position: absolute;
   margin-left: -24%;
   margin-top: 0px;
   color: #a1a4ad;
   font-size: 13px;
}

.forgetidpw {
   position: absolute;
   text-align: center;
   top: 93%;
   left: 20%;
}

.dnthave {
   position: absolute;
   text-align: center;
   top: 93%;
   left: 60%;
}

[type=checkbox]:checked+span:before /*style its checked state  */ {
   font-family: 'Nanum Gothic', sans-serif;
   font-size: 16px;
   content: "\f00c";
   position: absolute;
   top: -4px;
   color: #ED1C16;
   left: -1px;
   width: 13px;
}

.typcn {
   position: absolute;
   left: 339px;
   top: 282px;
   color: #c8b6b6;
   font-size: 22px;
   cursor: pointer;
}

.typcn.active {
   color: #b7c2b5;
}

.error {
   background: #ff3333;
   text-align: center;
   width: 337px;
   height: 20px;
   padding: 2px;
   border: 0;
   border-radius: 5px;
   margin: 10px auto 10px;
   position: absolute;
   top: 23%;
   left: 7.2%;
   color: white;
   display: none;
}

/* #naverIdLogin { */
/*    width: 215px; */
/*    height: 55px; */
/*    background-color: rgb(3, 199, 90); */
/*    font-size: 18px; */
/* } */

.eyes {
   cursor: pointer;
   margin-left: 330px;
   margin-top: -70px;
   position: absolute;
}

.input-wrap {
   font-size: 13px;
}

#checkId {
   margin-left: -226px;
}


/* #naverIdLogin { */
/*    background-color: #ED1C1600; */
/* } */

/* #naverIdLogin { */
/*    width: 330px; */
/*    height: 47px;    */
/*    position: relative; */
/*    top: 18px; */
/*    cursor: pointer; */
/*    margin-left: 42px; */
/*    margin-top: 10px; */
/*    font-size: 18px; */
/* } */


/*#kakaobtn2 { */
/*   width: 333px; */
/*   height: 47px; */
/*   position: relative; */
/*   top: 18px; */
/*   cursor: pointer; */
/*   margin-left: 37px; */
/*   margin-top: 57px; */
/*   font-size: 18px; */
/*   opacity: 0; */
}
</style>

<body id="particles-js">
	<div class="animated bounceInDown">
		<div class="container">
			<span class="error animated tada" id="msg"></span>
			<form name="form1" class="box" onsubmit="return false;">
				<h4>KHPLATE</h4>
				<h5>오늘은 뭐 먹지?</h5>
				<div class="input password">
					<input type="text" name="id" id="id" placeholder="ID"
						autocomplete="off"> <i class="typcn typcn-eye" id="eye"></i>
	
					<input type="password" name="password" id="password"
						placeholder="PW" autocomplete="off" class="form-input">
					<div class="box">
	
						<span class="input-wrap"> <input type="checkbox"
							id="checkId" name="checkId"> <label for="checkId"><span></span></label>
							아이디 저장 
						</span>
						<!-- <div id="idsave">아이디 저장</div> -->
					</div>
					<div class="eyes">
						<i class="fa fa-eye fa-lg"></i>
					</div>
				</div>
				<!-- <label> <input type="checkbox"> <span></span> <small
					class="rmb">ID 기억하기</small></label> -->
				<input type="button" value="제출하기" class="btn" id="signupBtn">
				<button type="button" class="btn" id="kakaoBtn" onclick="kakaoLogin();"><a href="javascript:void(0)"></a><img src="/login/카카오로고.png" class="kakaoImage" style="width:15%; height:100%;"><div>카카오 로그인</div></button>
				<button type="button" class="btn" id="naverIdLogin_loginButton"><img src="/login/네이버로고.png" class="naverImage" style="width:15%; height:100%;"><div>네이버 로그인</div></button>
			

			  	<!--  <div id="kakaobtn2" onclick="kakaoLogin();">
	                <a href="javascript:void(0)"></a>
	            </div>
	           
	           <div id="naverIdLogin">
	           		<a id="naverIdLogin_loginButton" href="#null"></a>
	           </div>-->
			</form>
			<a href="#null" class="forgetidpw"> 아이디/비밀번호 찾기</a>
			<a href="/joinform/joinform.jsp" class="dnthave">회원가입하기</a>
		</div>
	<!-- 		<button onclick="kakaoLogout()">카카오 로그아웃</button> -->
	<!--         <button onclick="naverLogout()">네이버 로그아웃</button> -->
	</div>

<script>

// 아이디/비밀번호 찾기 링크
	$(".forgetidpw").on("click", function() {
		window.open("/memberSearch/idpwsearch.jsp","","width=480px,height=750px");
		
	})
	
	$("#signup").on("click", function() {
		location.href = "/joinform/joinform.jsp";
	})

   var pw = document.getElementById('password');
   var eye = document.getElementById('eye');

   eye.addEventListener('click', togglePass);

   function togglePass() {

      eye.classList.toggle('active');

      (pw.type == 'password') ? pw.type = 'text' : pw.type = 'password';
   }

   $(function() {
      // 눈표시 클릭 시 패스워드 보이기
      $('.eyes').on(
            'click',
            function() {
               $('.input.password').toggleClass('active');

               if ($('.input.password').hasClass('active') == true) {
                  $(this).find('.fa-eye').attr('class',
                        "fa fa-eye-slash fa-lg").parents('.input')
                        .find('#password').attr('type', "text");
                  // i 클래스                // 텍스트 보이기 i 클래스
               } else {
                  $(this).find('.fa-eye-slash').attr('class',
                        "fa fa-eye fa-lg").parents('.input').find(
                        '#password').attr('type', 'password');
               }
            });
   });
   //
   $(document).ready(function() {
      // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
      var key = getCookie("key");
      $("#id").val(key);

      // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
      if ($("#id").val() != "") {
         $("#checkId").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
      }
   })
   $("#checkId").change(function() { // 체크박스에 변화가 있다면,
      if ($("#checkId").is(":checked")) { // ID 저장하기 체크했을 때,
         setCookie("key", $("#id").val(), 7); // 7일 동안 쿠키 보관
      } else { // ID 저장하기 체크 해제 시,
         deleteCookie("key");
      }
   });

   // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
   $("#id").keyup(function() { // ID 입력 칸에 ID를 입력할 때,
      if ($("#checkId").is(":checked")) { // ID 저장하기를 체크한 상태라면,
         setCookie("key", $("#id").val(), 7); // 7일 동안 쿠키 보관
      }
   });

   // 쿠키 저장하기 
   // setCookie => saveid함수에서 넘겨준 시간이 현재시간과 비교해서 쿠키를 생성하고 지워주는 역할
   function setCookie(cookieName, value, exdays) {
      var exdate = new Date();
      exdate.setDate(exdate.getDate() + exdays);
      var cookieValue = escape(value)
            + ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
      document.cookie = cookieName + "=" + cookieValue;
   }

   // 쿠키 삭제
   function deleteCookie(cookieName) {
      var expireDate = new Date();
      expireDate.setDate(expireDate.getDate() - 1);
      document.cookie = cookieName + "= " + "; expires="
            + expireDate.toGMTString();
   }

	// 쿠키 가져오기
	function getCookie(cookieName) {
		cookieName = cookieName + '=';
		var cookieData = document.cookie;
		var start = cookieData.indexOf(cookieName);
		var cookieValue = '';
		if (start != -1) { // 쿠키가 존재하면
			start += cookieName.length;
			var end = cookieData.indexOf(';', start);
			if (end == -1) // 쿠키 값의 마지막 위치 인덱스 번호 설정 
				end = cookieData.length;
			cookieValue = cookieData.substring(start, end);
		}
		return unescape(cookieValue);
	}

	//kakao
 
	//카카오 로그인
	
	function kakaoLogin() {
		Kakao.init('25e12e36964674d52a9931b02d3b7cc1'); //발급받은 키 중 javascript키를 사용해준다.
		console.log(Kakao.isInitialized()); // sdk초기화여부판단
		
		Kakao.Auth.login({
			success : function(response) {
				Kakao.API.request({
					url : '/v2/user/me',
					success : function(responseKakao) {
		            	$.ajax({
		        			url : "/loginByKakao.members",
		        			type : "post",
		        			data : {
		        				kakaoid : responseKakao.id
		        			}
		        		}).done(function(resp) {
		        			if (resp == "1") {
		        				alert("첫 회원은 회원가입 절차가 필요합니다.");
		        				let id = responseKakao.id;
		        				//kakaoLogout();
		        				location.href="/joinform/joinformWithLoginAPI.jsp?kakaoid="+id;
		        			} else if(resp == "2"){
		        				alert("이메일 인증이 되지 않았습니다.");
// 		        				kakaoLogout();
		        				location.reload();
		        			} else {
		        				console.log(responseKakao.id);
		        				alert("로그인 되었습니다.");
		        				location.href = "/page/main.jsp";
		        			}
		        		})
					},
					fail : function(error) {
						console.log(error)
					},
				})
			},
			fail : function(error) {
				console.log(error)
			},
		})
	}
	
	// 카카오 로그아웃
	function kakaoLogout() {
	    Kakao.Auth.logout()
	      .then(function() {
	        alert('logout ok\naccess token -> ' + Kakao.Auth.getAccessToken());
	        deleteCookie();
	      })
	      .catch(function() {
	        alert('Not logged in');
	      });
    }
	// 카카오 언링크
// 	function kakaoLogout(){
// 		Kakao.API.request({
// 		  url: '/v1/user/unlink',
// 		})
// 	  .then(function(response) {
// 	    console.log(response);
// 	  })
// 	  .catch(function(error) {
// 	    console.log(error);
// 	  });
// 	}

	// 네이버 로그인
	// const naverLogin = new naver.LoginWithNaverId(
   //      {
   //          clientId: "Mm9YQgxstdSEuf5xt0jg",
   //          callbackUrl: "http://localhost/login/login.jsp",
   //          loginButton: {color: "green", type: 2, height: 40},
   //          isPopup: false,
   //  	    callbackHandle: true
   //      }
   //  );
   //  naverLogin.init();
	
	//네이버 로그인

   $("#naverIdLogin_loginButton").click(function(){
      window.open("/login/navercallback.jsp", "네이버 로그인", "top=10, left=10, width=500, height=600, status=no, menubar=no, toolbar=no");
   });

	// const naverLogin = new naver.LoginWithNaverId(
   //      {
   //          clientId: "Mm9YQgxstdSEuf5xt0jg",
   //          callbackUrl: "http://localhost/login/login.jsp",
   //          loginButton: {color: "green", type: 2, height: 40},
   //          isPopup: false,
   //  	    callbackHandle: true
   //      }
   //  );
   //  naverLogin.init();
    
    //$("#naverIdLogin_loginButton").click(function(event){
   //  $("#naverIdLogin_loginButton").on("click", function(event){
   //  	naverLogin.getLoginStatus(function (status) {
   //          if (status) {
   //          	$.ajax({
   //      			url : "/loginByNaver.members",
   //      			type : "post",
   //      			async : true,
   //      			data : {
   //      				naverid : naverLogin.user.id
   //      			}
   //      		}).done(function(resp) {
   //      			if (resp == "1") {
   //      				alert("첫 회원은 회원가입 절차가 필요합니다.");
   //      				let id = naverLogin.user.id;
   //      				naverLogout();
   //      				location.href="/joinform/joinformWithLoginAPI.jsp?naverid="+id;
   //      			} else if(resp == "2"){
   //      				alert("이메일 인증이 되지 않았습니다.");
   //       				naverLogout();
   //      				location.reload();
   //      			} else {
   //      				alert("로그인 되었습니다.");
   //      				location.href = "/page/main.jsp";
   //      			}
   //      		})
   //      		console.log(naverLogin.user.id);
   //          } else {
   //              console.log("callback 처리에 실패하였습니다.");
   //          }
   //      });
   //  });
    
   //  function naverLogout() {
   //      naverLogin.logout();
   //    	location.replace("/login/login.jsp");
   //  }
	
	// Form Validation

   $("#signupBtn").on("click",function(){
      var id = document.form1.id;
      var password = document.form1.password;
      var msg = document.getElementById('msg');

      if (id.value == "") {
         msg.style.display = 'block';
         msg.innerHTML = "Please enter your id";
         id.focus();
         return false;
      } else {
         msg.innerHTML = "";
      }

      if (password.value == "") {
         msg.style.display = 'block';
         msg.innerHTML = "Please enter your password";
         password.focus();
         return false;
      } else {
         msg.innerHTML = "";
      }
      
      var re = /^[a-z0-9_]{7,13}$/;
      
      if (!re.test(id.value)) {
         msg.style.display = 'block';
         msg.innerHTML = "Please enter a valid id";
         id.focus();
         return false;
      } else {
         msg.innerHTML = "";
      }

		// 정규식 검사에 해당되지 않으면 로그인
		msg.style.display="none";
		$.ajax({
			url : "/login.members",
			type : "post",
			data : {
				id : $("#id").val(),
				password : $("#password").val()
			}
		}).done(function(resp) {
			if (resp == "1") {
				alert("ID가 잘못 되었습니다.");
			} else if(resp == "2"){
				alert("비밀번호가 잘못 되었습니다.");
			} else if(resp == "3"){
				alert("이메일 인증이 되지 않았습니다.");
			} else {
				alert("로그인 되었습니다.");
				location.href = "/page/main.jsp";
			}
		})
	});
</script>
</body>
</html>
