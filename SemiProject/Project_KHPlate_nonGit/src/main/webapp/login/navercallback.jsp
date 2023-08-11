<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>네이버 로그인</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
  </head>
  
  <body>
  	           <div id="naverIdLogin" style="display:none;">
	           		<a id="naverIdLogin_loginButton" href="#null">
	           			<img src="https://static.nid.naver.com/oauth/big_g.PNG" width=320>
	           		</a>
	           </div>
  <script>
	const naverLogin = new naver.LoginWithNaverId(
	        {
	            clientId: "Mm9YQgxstdSEuf5xt0jg",
	            callbackUrl: "http://khplate.duckdns.org:8090/login/navercallback.jsp",
	            loginButton: {color: "green", type: 2, height: 40},
	            isPopup: false,
	    	    callbackHandle: true
	        }
	    );
	    naverLogin.init();
	 
	    $(function(){
	    	naverLogin.getLoginStatus(function (status) {
	            if (status) {
	            	$.ajax({
	        			url : "/loginByNaver.members",
	        			type : "post",
	        			data : {
	        				naverid : naverLogin.user.id
	        			}
	        		}).done(function(resp) {
	        			if (resp == "1") {
	        				alert("첫 회원은 회원가입 절차가 필요합니다.");
	        				let id = naverLogin.user.id;
	        				naverLogout();
	        				opener.location.href="/joinform/joinformWithLoginAPI.jsp?naverid="+id;
	        				self.close();
	        			} else if(resp == "2"){
	        				alert("이메일 인증이 되지 않았습니다.");
	         				naverLogout();
	        				opener.location.reload();
	        				self.close();
	        			} else {
	        				alert("로그인 되었습니다.");
	        				opener.location.href = "/page/main.jsp";
	        				self.close();
	        			}
	        		})
	        		console.log(naverLogin.user.id);
	            } else {
	                console.log("callback 처리에 실패하였습니다.");
	                document.getElementById("naverIdLogin_loginButton").click();
	            }
	        });
	    });
	    
	    function naverLogout() {
	        naverLogin.logout();
	      	location.replace("/login/login.jsp");
	    }
  </script>
  </body>
</html>
