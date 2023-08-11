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
<title>Kakao Login</title>

<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.1.0/kakao.min.js"
	integrity="sha384-dpu02ieKC6NUeKFoGMOKz6102CLEWi9+5RQjWSV0ikYSFFd8M3Wp2reIcquJOemx"
	crossorigin="anonymous"></script>
<script>
  Kakao.init('25e12e36964674d52a9931b02d3b7cc1'); // ì¬ì©íë ¤ë ì±ì JavaScript í¤ ìë ¥
</script>
</head>
<body>

//íìë¡ê·¸ì¸
Kakao.Auth.createLoginButton({
  container: '${CONTAINER_ID}',
  scope: 'account_email,gender,birthday',
  success: function(response) {
    console.log(response);
  },
  fail: function(error) {
    console.log(error);
  }
});

	<a id="kakao-login-btn" href="javascript:loginWithKakao()"> 
	<img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="222" alt="ì¹´ì¹´ì¤ ë¡ê·¸ì¸ ë²í¼" />
	</a>
	<p id="token-result"></p>

	<script>
function loginWithKakao() {
    Kakao.Auth.authorize({
      redirectUri: '${http://127.0.0.1:8090/kakao-login}',
      scope: 'account_email,gender,birthday',
      prompts: 'login',
    });
}
 
  //Kakao.Auth.setAccessToken('${ACCESS_TOKEN}');
  displayToken()
  function displayToken() {
    var token = getCookie('authorize-access-token');

    if(token) {
      Kakao.Auth.setAccessToken(token);
      Kakao.Auth.getStatusInfo()
        .then(function(res) {
          if (res.status === 'connected') {
            document.getElementById('token-result').innerText
              = 'login success, token: ' + Kakao.Auth.getAccessToken();
          }
        })
        .catch(function(err) {
          Kakao.Auth.setAccessToken(null);
        });
    }
  }

  function getCookie(name) {
    var parts = document.cookie.split(name + '=');
    if (parts.length === 2) { return parts[1].split(';')[0]; }
  }
  
  Kakao.Auth.logout()
  .then(function(response) {
    console.log(Kakao.Auth.getAccessToken()); // null
  })
  .catch(function(error) {
    console.log('Not logged in.');
  });
</script>
Kakao.API.request({
  url: '/v2/user/me',
  data: {
    property_keys: ['kakao_account.email','kakao_account.gender','kakao_account.birthday']
  },
  success: function(response) {
    console.log(response);
  },
  fail: function(error) {
    console.log(error);
  }
});

Kakao.API.request({
  url: '/v1/user/update_profile',
  data: {
    properties: {
      '${mail}': '${sex}': '${bd}'
    },
  },
  success: function(response) {
    console.log(response);
  },
  fail: function(error) {
    console.log(error);
  }
});
</body>
</html>



