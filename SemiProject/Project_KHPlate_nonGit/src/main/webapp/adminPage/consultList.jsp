<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1상담 목록</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/octicons/3.3.0/octicons.min.css"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
	crossorigin="anonymous"></script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');/*나눔고딕 폰트 import */
/* 헤더 및 sideBar 부분 스타일 - 건들지 말것 */
* {
	box-sizing: border-box;
	padding: 0px;
	font-family: 'Nanum Gothic', sans-serif;
}
table{
	text-align:center;
	font-size:15px;
}
.body {
	margin: auto;
}

.sideList {
	border: 1px solid black;
}

p {
font-weight:bolder; 
font-size:25px; 
color:#57b846;
}
/* 추가 버튼 디자인 */
#toWriteBtn {
	float: right;
	width: 40px;
	height: 40px;
	cursor: pointer;
	border:none;
	filter: invert(65%) sepia(12%) saturate(2086%) hue-rotate(65deg) brightness(93%) contrast(89%);
}

/* 하단부터 메인부분 스타일 작성 요망 */
</style>
</head>
<body>
	<div class="container-fluid themed-container m-0 g-0">
		<!-- 헤더부분 건들지 말것 -->
		<jsp:include page="/page/header.jsp" flush="false"></jsp:include>
		<!-- body 부분 row div 건들지 말것 -->
		<div class="row g-0 justify-content-center body" style="margin-top:70px;">
			<!-- sideBar부분 건들지 말것 -->
			<jsp:include page="/page/sideBar.jsp" flush="false"></jsp:include>

			<div class="col-12 col-lg-9 g-0 themed-grid-col bodyContents">
				<p class="nanum-gothic">고객의 소리 목록</p>
					<hr style="border-style:dotted;">
				<!-- Main 내용 부분 하단부터 수정 요망 -->
				<table align="center" class="table">
					<tr>
						<td width="10%" style="color:#57b846; font-weight: 600; font-size: 20px;">글 번호</td>
						<td width="40%" style="color:#57b846; font-weight: 600; font-size: 20px;">제목</td>
						<td width="15%" style="color:#57b846; font-weight: 600; font-size: 20px;">질문자</td>
						<td width="10%" style="color:#57b846; font-weight: 600; font-size: 20px;">답변 여부</td>
						<td width="15%" style="color:#57b846; font-weight: 600; font-size: 20px;">업로드 일자</td>
						<td width="10%" style="color:#57b846; font-weight: 600; font-size: 20px;">분류</td>
					</tr>
					<c:if test="${fn:length(list) > 0}">
						<c:forEach var="i" begin="0" end="${fn:length(list)-1}" step="1">
							<tr>
								<td>${list.get(i).consultID}</td>
								<c:choose>
									<c:when test="${list.get(i).userNO == sessionScope.userno || sessionScope.loginIsAdmin}">
										<td><a href="/view.consult?consultID=${list.get(i).consultID}">${list.get(i).title}</a></td>
									</c:when>
									<c:otherwise>
										<td>${list.get(i).title}</td>
									</c:otherwise>
								</c:choose>
								<td>${writerList.get(i)}</td>
								<td>
									<c:choose>
										<c:when test="${list.get(i).reply eq 'Y'}">
											응답
										</c:when>
										<c:otherwise>
											미응답
										</c:otherwise>
									</c:choose>
								</td>
								<td>${list.get(i).writedate}</td>
								<td>${list.get(i).category}</td>
							</tr>
						</c:forEach>
						<tr>
							<td colspan="6">
								<c:if test="${navi.needNext}">
									<a href="/list.consult?cpage=${navi.naviList.get(0) - 1}"><</a>
								</c:if>
								<c:forEach var="i" items="${navi.naviList}">
									<a class='item' href="/list.consult?cpage=${i.intValue()}">${i.intValue()}</a>
								</c:forEach>
								<c:if test="${navi.needNext}">
									<a href="/list.consult?cpage=${navi.naviList.get(navi.naviList.length)+1}">></a>
								</c:if>
							</td>
						</tr>
						<!-- 현제 페이지 네비게이터 링크 미부여 -->
						<c:choose>
							<c:when test="${param.cpage>1}">
								<script>
									$(".item").each(function(index,item){
										if($(item).html()==${param.cpage}){
											$(item).prop("href","#null");
											$(item).css("color","black");
										}
									})
								</script>
							</c:when>
							<c:otherwise>
								<script>
									$(".item").each(function(index,item){
										if($(item).html()==1){
											$(item).prop("href","#null");
											$(item).css("color","black");
										}
									})
								</script>
							</c:otherwise>
						</c:choose>
					</c:if>
				</table>
				
<!-- 				일반 사용자일 경우 글쓰기 버튼 추가 -->
				<c:if test="${!loginIsAdmin}">
					<div>
					<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" id="toWriteBtn" viewBox="0 0 16 16">
  <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
</svg>
	
					</div>
				</c:if>
				<!-- body main 수정 여기까지, 하단 건들지 말것. -->
			</div>
			
		</div>
		<jsp:include page="/page/footer.jsp" flush="false"></jsp:include>
	</div>
	<script>
	
// 		글쓰기 버튼 이벤트
		$("#toWriteBtn").on("click",function(){
			location.href = "/adminPage/consultRegister.jsp";
		})
		
	</script>
</body>
</html>