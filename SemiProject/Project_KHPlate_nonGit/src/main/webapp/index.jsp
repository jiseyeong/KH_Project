<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MainPage</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style>
	p{font-size:20px; font-weight:bold;}
</style>
</head>
<body>

   	<a href="/page/main.jsp"><button style="width:200px; height:100px;">메인페이지 접속</button></a><br>
	<hr>
	<p>컨트롤러 적용 완료, 디자인 적용 중</p>
	가게 정보 확인 -> <a href="/store/view.jsp">view.jsp</a><br>
	<hr>
	<p>컨트롤러,디자인 적용 완료</p>
	메인 페이지 -> <a href="/page/main.jsp">main.jsp</a><br>
	헤더 -> <a href="/page/header.jsp">header.jsp</a><br>
	사이드바 -> <a href="/page/sideBar.jsp">sideBar.jsp</a><br>
	footer -> <a href="/page/footer.jsp">footer.jsp</a><br>
	페이지 틀 -> <a href="/page/test.jsp">test.jsp</a><br>
	메인 페이지 -> <a href="/page/main.jsp">main.jsp</a><br>
	<br>
	회원가입 -> <a href="/joinform/joinform.jsp">joinform.jsp</a><br>
	아이디 중복확인 -> <a href="/joinform/isIdExist.jsp">isIdExist.jsp</a><br>
	이메일 인증 요구 페이지 -> <a href="/joinform/needEmailVerify.jsp">needEmailVerify.jsp</a><br>
	회원가입 완료 페이지 -> <a href="/joinform/joinComplete.jsp">joinComplete.jsp</a><br>
	<br>
	로그인 -> <a href="/login/login.jsp">login.jsp</a><br><br>
	아이디/비밀번호 찾기 -> <a href="/memberSearch/idpwsearch.jsp">idpwsearch.jsp</a><br>
	아이디 찾기 조회 결과 -> <a href="/login/idconfirm.jsp">idconfirm.jsp</a><br>
	새 비밀번호 설정 -> <a href="/memberSearch/newpassword.jsp">newpassword.jsp</a><br>
	새로운 패스워드 입력 -> <a href="/login/wrongpw.jsp">wrongpw.jsp</a><br>
	카카오 로그인 -> <a href="/login/kakaologin.html">kakaologin.html</a><br>
	네이버 로그인 -> <a href="/login/naverlogin.jsp">naverlogin</a><br>
	네이버 callback -> <a href="/login/navercallback.jsp">navercallback</a><br>
	회원탈퇴 -> <a href="/memberout/memberout.jsp">memberout.jsp</a><br>
	<br>
	마이페이지 -> <a href="/mypage/myPageVer2.jsp">myPageVer2.jsp</a><br>
	<br>
	내 근처 맛집(지도형 맛집 확인 페이지)-><a href="/allstore_inquiry/allstore_inquiry.jsp">allstore_inquiry.jsp</a><br>
	맛집 검색 결과 -> <a href="/common/main_storeSearchResult.jsp">main_storeSearchResult.jsp</a><br>
	<br>
	블로그 리뷰 글보기 -> <a href="FullReview/FullReviewContent.jsp">FullReviewContent.jsp</a><br>
	블로그 리뷰 리스트 -> <a href="FullReview/FullReviewList.jsp">FullReviewList.jsp</a><br>
	블로그 리뷰 글쓰기 -> <a href="FullReview/writeFullReview.jsp">writeFullReview.jsp</a><br>
	<br>
	문의 작성 -> <a href="/adminPage/consultRegister.jsp">consultRegister.jsp</a><br>
	문의 내역 -> <a href="/adminPage/consultList.jsp">counsultList.jsp</a><br>	
	문의 글 보기 -> <a href="/adminPage/consultView.jsp">consultView.jsp</a><br>
	<br>
	FAQ 리스트 -> <a href="/adminPage/FAQView.jsp">FAQView.jsp</a><br>
	<br>
	(관리자)가게 정보 등록 -> <a href="/store/registerForm.jsp">registerForm.jsp</a><br>
	(관리자)문의 답변 작성 -> <a href="/adminPage/consultReplyRegister.jsp">consultReplyRegister.jsp</a><br>
	(관리자)FAQ 등록 -> <a href="/adminPage/FAQRegister.jsp">FAQRegister.jsp</a><br>
	약관 정보 -> <a href="/adminPage/letter.jsp">letter.jsp</a>
	<hr>
</body>
</html>