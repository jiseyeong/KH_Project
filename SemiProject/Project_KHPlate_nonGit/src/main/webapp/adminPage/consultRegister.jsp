<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 상담 등록</title>
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
/*나눔고딕 폰트 import */
/* 헤더 및 sideBar 부분 스타일 - 건들지 말것 */
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
p{font-weight:bolder; font-size:25px; color:#57b846;}
.row>div>select{font-size:13px;}
.row>div>input{font-size:13px;}
.writeBody>div{
	margin-left:auto;
	margin-right:auto;
}
.ck-editor__editable_inline {
    min-height: 400px;
}
#input_image{width:100%}
#toList {
	width: 100px;
	height: 40px;
	background-color: #57b846;
	border:none;
	border-radius: 3px;
	cursor: pointer;
	color: white;
	font-size: 14px;
	margin-right:20px;
	box-shadow:1px 1px 5px 1px rgb(231, 231, 231);
}

#submitBtn {
	width: 100px;
	height: 40px;
	background-color: #57b846;
	border-radius: 3px;
	cursor: pointer;
	border:none;
	color: white;
	font-size: 14px;
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

			<div class="col-12 col-lg-9 g-0 themed-grid-col bodyContents" style="padding-left:100px; padding-right:100px;">
				<!-- Main 내용 부분 하단부터 수정 요망 -->
				<form id="myForm" action="/register.consult" method="post" enctype="multipart/form-data">
					<div class="row" style="margin-bottom:20px;">
					<div class="col-12 col-lg-8" style="margin-left:auto; margin-right:auto;">
					<p class="nanum-gothic">고객의 소리</p>
					<hr style="border-style:dotted;">
					</div>
					</div>
						<div class="row writeHeader" style="margin-bottom:20px;">	
							<div class="col-12 col-lg-1" style="margin-left:auto;">
								<select class="nanum-gothic form-select" name="category">
									<option>문의</option>
									<option>신고</option>
									<option>건의</option>
								</select>
							</div>
							<div class="col-12 col-lg-7" style="margin-right:auto;">
								
								<input type="text" name="title" class="nanum-gothic form-control" placeholder="제목을 입력해주세요.">
							</div>
							<input type="text" name="writer" id="writer" value="${sessionScope.userno}" style="display: none;">
						</div>
						<div class="row writeBody">
							<div class="col-12 col-lg-8">
								<textarea name="body" id="editor"></textarea>
							</div>
						</div>
					<div class="row file" style="margin-top:20px;">
						<div class="col-12 col-lg-8" style="margin-left:auto; margin-right:auto;">
							<div class="col-12" style="margin-left:auto; margin-right:auto;">
								<img src="#none" alt="#none" id="image" class="object-fit-contain" style="display:none; margin-bottom:20px; margin-left:auto; margin-right:auto; width:500px; height:500px;">
								<input id="input_image" name="img" type="file" accept="image/*" class="nanum-gothic form-control" style="font-size:13px;">
							</div>
							</div>
					</div>
					<div class="row" style="margin-top:80px;">
						<div class="col-12 text-center" style="margin-left:auto; margin-right:auto;">
							<a href="/list.consult">
								<input type="button" name="toList" id="toList" value="목록으로" class="nanum-gothic">
							</a>
							<input type="submit" name="submitBtn" id="submitBtn" value="제출하기" class="nanum-gothic">
						</div>
					</div>
				</form>
				<script>
					ClassicEditor
						.create(document.querySelector("#editor"), {
						 	toolbar: ['heading', '|', 'bold', 'italic', 'bulletedList', 'numberedList', 'insertTable', 'blockQuote', 'undo', 'redo',]
						})
						.catch(error => { console.error(error) });

					$("#myForm").submit(function(){
						let imgForms = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
						if(!($("#writer").val())){
							alert("로그인을 먼저 해주십시오.");
							return false;
						}else if(!$("#input_image").val()){

						}else if (!$("#input_image").val().match(imgForms)) {
							alert("이미지 파일만 업로드 가능합니다.");
							return false;
						}

						if(!($("input[name='title']").val())){
							alert("제목을 입력해주세요.");
							return false;
						}else if(!($("#editor").val())){
							alert("본문을 입력해주세요.");
							return false;
						}
					});
					$("#input_image").change(function(){
						let input = document.getElementById("input_image");
						let fReader = new FileReader();
						fReader.onload = function(e){
							$("#image").css({
								"display":"block",
							})
							$("#image").attr("src", e.target.result);
						}
						if(input.files[0]){
							fReader.readAsDataURL(input.files[0]);
						}else{
							$("#image").css({
								"display":"none",
							})
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