<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 등록</title>
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
/* 헤더 및 sideBar 부분 스타일 - 건들지 말것 */

@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');/* 나눔고딕 import */

* {
	box-sizing: border-box;
	padding: 0px;
	font-family: 'Nanum Gothic', sans-serif;
}

.body {
	margin: auto;
}

.sideList {
	border: 1px solid black;
}

/* 하단부터 메인부분 스타일 작성 요망 */
.inputContent {
	margin-top: 3%;
	font-weight:bolder;
	font-size:25px;
	color:#57b846;
}
.input-group {
	width:100%;
}
.input-group>span{
	margin-top:20px;
	margin-bottom:20px;
	font-size:14px;
}
.input-group>input{
	margin-top:20px;
	margin-bottom:20px;
	font-size:14px;
}
.ck-editor__editable_inline {
    min-height: 400px;
}
#submitBtn {
	width: 100px;
	height: 40px;
	background-color: #57b846;
	border:  #57b846;
	border-radius: 3px;
	cursor: pointer;
	color: white;
	margin-top: 50px;
	font-size: 14px;
  	margin-left: auto; 
	margin-right:auto;
	box-shadow:1px 1px 5px 1px rgb(231, 231, 231);
}
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
				<!-- Main 내용 부분 하단부터 수정 요망 -->
				<form id="registerForm" action="/register.faq" method="get">
					<div class="row">
						<div class="col-12 col-lg-8" style="margin-left:auto; margin-right:auto;">
							<div class="inputContent">FAQ 등록</div>
							<hr style="border-style:dotted;">
								<div class="col-12 col-lg-12">
									<div class="input-group">
										<span class="input-group-text">제목</span>
										<input type="text" class="form-control" name="title" placeholder="제목을 입력해주세요">
										<div class="col-12">
											<textarea name="body" id="editor"></textarea>
										</div>
										<div class="col-12 text-center">
										<button type="submit" id="submitBtn">제출하기</button>
										</div>
									</div>
								</div>
						</div>
					</div>
				</form>

				<script>
					ClassicEditor
						.create(document.querySelector("#editor"), {
							 toolbar: ['heading', '|', 'bold', 'italic', 'bulletedList', 'numberedList', 'insertTable', 'blockQuote', 'undo', 'redo',]
						})
						.catch(error => { console.error(error) });
					
					//방어코드
					$("#registerForm").submit(function(){
						if(!($("input[name='title']").val())){
							alert("제목을 입력해주세요.");
							return false;
						}else if(!($("#editor").val())){
							alert("본문을 입력해주세요.");
							return false;
						}
					});
				</script>

				<!-- body main 수정 여기까지, 하단 건들지 말것. -->
			</div>
		</div>
		<jsp:include page="/page/footer.jsp" flush="false"></jsp:include>
	</div>
</body>
</html>