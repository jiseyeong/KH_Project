<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 보기</title>
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
<script src="https://cdn.ckeditor.com/ckeditor5/37.0.1/classic/ckeditor.js"></script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');


/* 헤더 및 sideBar 부분 스타일 - 건들지 말것 */
* {
	box-sizing: border-box;
	padding: 0px;
	font-family: 'Nanum Gothic', sans-serif;
}

/* Header부분의 영향을 주기에 따로 빼두었습니다 */
.accordion *{
 	margin-bottom: 10px;
}

.body {
	margin: auto;
}

.sideList {
	border: 1px solid #57b846;
}

p {
font-weight:bolder; 
font-size:25px; 
color:#57b846;
}

.btn_delete {
width: 100px;
height: 40px;
background-color: #57b846;
border: #57b846;
border-radius: 3px;
cursor: pointer;
color: white;
font-size: 14px;
margin-left: auto;
margin-right: auto;
box-shadow: 1px 1px 5px 1px rgb(231, 231, 231);
}

.search_layout2{
	margin-bottom: 0px;
}

/* 추가 버튼 디자인 */
#toWriteBtn {
	float: right;
	width: 40px;
	height: 40px;
	cursor: pointer;
	border:none;
	filter: invert(65%) sepia(12%) saturate(2086%) hue-rotate(65deg) brightness(93%) contrast(89%);
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
			<p class="nanum-gothic">FAQ 목록</p>
					<hr style="border-style:dotted;">
				<!-- Main 내용 부분 하단부터 수정 요망 -->
				<div class="row">
					<div class="col-12">
						<div class="accordion" id="accordionFAQ">
							<c:choose>
								<c:when test="${fn:length(list) > 0}">
									<c:forEach var="i" begin="0" end="${fn:length(list)-1}" step="1">
										<div class="accordion-item">
											<h2 class="accordion-header" id="heading${i}">
												<button class="accordion-button text-white" style="background-color: #57b846;" type="button"
													data-bs-toggle="collapse" data-bs-target="#collapse${i}"
													aria-expanded="true" aria-controls="collapse${i}">
													${list.get(i).title}</button>
											</h2>
											<div id="collapse${i}" class="accordion-collapse collapse"
												aria-labelledby="heading${i}" data-bs-parent="#accordionFAQ">
												<div class="accordion-body">
													<div class="row align-items-center">
														<div class="col-10">
															<div id="editor${i}">${list.get(i).body}</div>
															<script>
															 	var i = "<c:out value='${i}'></c:out>"
																ClassicEditor
																	.create(document.querySelector("#editor" + i), {
																		toolbar: ['heading', '|', 'bold', 'italic', 'bulletedList', 'numberedList', 'insertTable', 'blockQuote', 'undo', 'redo',]
																	})
																	.then(function (editor) {
																		const toolbarElement = editor.ui.view.toolbar.element;
																		toolbarElement.style.display = 'none';
																		editor.enableReadOnlyMode('');
																	})
																	.catch(error => { console.error(error) });
															</script>
														</div>
														<c:if test="${sessionScope.loginIsAdmin}">
															<div class="col-2">
																<a href="/delete.faq?id=${list.get(i).qaID}">
																	<button type=button class="btn_delete">삭제</button>
																</a>
															</div>
														</c:if>
													</div>
												</div>
											</div>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="accordion-item">
										<h2 class="accordion-header" id="headingOne">
											<button class="accordion-button  text-white" style="background-color: #57b846;" type="button" data-bs-toggle="collapse"
												data-bs-target="#collapseOne" aria-expanded="true"
												aria-controls="collapseOne">FAQ
												#1</button>
										</h2>
										<div id="collapseOne" class="accordion-collapse collapse show"
											aria-labelledby="headingOne" data-bs-parent="#accordionFAQ">
											<div class="accordion-body">
												<div id="editor">등록된 FAQ가 없습니다.</div>
												<script>
													ClassicEditor
														.create(document.querySelector("#editor"), {
															toolbar: ['heading', '|', 'bold', 'italic', 'bulletedList', 'numberedList', 'insertTable', 'blockQuote', 'undo', 'redo',]
														})
														.then(function (editor) {
															const toolbarElement = editor.ui.view.toolbar.element;
															toolbarElement.style.display = 'none';
															editor.enableReadOnlyMode('');
														})
														.catch(error => { console.error(error) });
												</script>
											</div>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="col-12 text-center">
						<c:if test="${navi.needNext}">
							<a href="/view.faq?cpage=${navi.naviList.get(0) - 1}"><</a>
						</c:if>
						<c:forEach var="i" items="${navi.naviList}">
							<a class="item" href="/view.faq?cpage=${i.intValue()}">${i.intValue()}</a>
						</c:forEach>
						<c:if test="${navi.needNext}">
							<a href="/view.faq?cpage=${navi.naviList.get(navi.naviList.length)+1}">></a>
						</c:if>
					</div>
					
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
				</div>

				<c:if test="${loginIsAdmin}">
					<div>
						<a href="/adminPage/FAQRegister.jsp">
							<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" id="toWriteBtn" viewBox="0 0 16 16">
							  	<path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
							</svg>
						</a>
					</div>
				</c:if>

				<!-- body main 수정 여기까지, 하단 건들지 말것. -->
			</div>
		</div>
		<jsp:include page="/page/footer.jsp" flush="false"></jsp:include>
	</div>
</body>
</html>