<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script
	src="https://cdn.ckeditor.com/ckeditor5/37.0.1/classic/ckeditor.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');

* {font-family: 'Nanum Gothic', sans-serif;}



.ck-editor__editable_inline {
	min-height: 400px;
}
.reviewPtag{
	color:#57b846;
	font-weight:bold;
	font-size:30px;
}
.userId{
	font-weight:bold;
}
input {
	border: none;
	border-radius: 10px;
	background-color: #ffffff00;
}

input:focus {
	outline: none !important;
}

textarea {
	border: none;
}

.re_List_Container {
	height: 100px;
}

.reviewBody {
	width: 100%;
	height: 100%;
}

.bodyBox {
	width: 100%;
}

.title {
	width: 600px;
}

.btn-outline-secondary{
	width: 100px;
	height: 40px;
	background-color: #57b846;
	border-radius: 3px;
	cursor: pointer;
	border: none;
	color: white;
	font-size: 14px;
	box-shadow: 1px 1px 5px 1px rgb(231, 231, 231);
}

.submitBtn {
	width: 100px;
	height: 40px;
	background-color: #57b846;
	border-radius: 3px;
	cursor: pointer;
	border: none;
	color: white;
	font-size: 14px;
	box-shadow: 1px 1px 5px 1px rgb(231, 231, 231);
}

/* 별점 시스템 추가 */

::before,
::after {
    box-sizing: inherit;
    text-decoration: none;
    list-style-type: none;
    margin: 0;
    padding: 0;
}

.input_layout1{
	margin-top:18px;
	height:50px;
	display:flex;
	align-items:center;
}

.storeId{
	float:left;
	min-width:15%;
	height:50%;
	margin-right : 40px;
}

.stars {
	padding:0px;
	margin:0px;
	float:left;
	width:140px;
	height:70%;
    display: flex;
    justify-content: space-evenly;
    align-items:center;
}

.stars__icon {
    font-size: 5em;
    color: #b2b2b2; 
    display: inline-block;
    cursor: pointer;
    width:100%;
    height:100%;
}

.js-clear {
    color: #b2b2b2;
}

.js-fill {
    color: gold;
}

@media (max-width: 27em) {
  .stars__icon {
    font-size: 2.5em;
  }
}

.stars__link{
	width:12%;
	height:60%;
	display:flex;
	justify-content:center;
	align-items:center;
}
.stars__link>*{
	width:100%;
	height:100%;
}

</style>
</head>
<body>
	<div class="container">
		<form action="/write.fullreview" method="post" id="addForm"
			enctype="multipart/form-data">
			<p class="reviewPtag">리뷰 쓰기</p>
			<hr style="border-style:dotted; margin-bottom:30px;">
			ID : <input type="text" class="userId" name="userId" value="${sessionScope.userId}" readonly>
			<input type="text" placeholder="제목란" class="title" name="title">
			<hr style="border-style: dotted;">

			 <input type="text"
				class="userNo" name="userNo" value="${sessionScope.userno}"
				style="display: none">


			<div class="input_layout1">
				<select id="storeId" class="storeId" name="storeId">
					<option selected>음식점</option>
					<c:forEach items="${store }" var="i" varStatus="status">
						<option value="${i.storeID }">${i.name }</option>
					</c:forEach>
				</select> 
<!-- 				별점 기능 추가 -->
				<input type="hidden" class="score" name="score">
				<div style="font-size:17px">평점&nbsp&nbsp:&nbsp</div>
				<ul class="stars">
			        <a class="stars__link"><i class="stars__icon fas fa-star"></i></a>
			        <a class="stars__link"><i class="stars__icon fas fa-star"></i></a>
			        <a class="stars__link"><i class="stars__icon fas fa-star"></i></a>
			        <a class="stars__link"><i class="stars__icon fas fa-star"></i></a>
			        <a class="stars__link"><i class="stars__icon fas fa-star"></i></a>
			    </ul>
		    </div>
<!-- 			<input type="text" placeholder="별점" class="score" name="score"> -->
			<div class="void">
				<br>
			</div>
			<div class="storeId" name="storeId"></div>
			<div class="bodyBox">
				<textarea class="reviewBody" name="reviewBody" id="editor"></textarea>
			</div>
			<br>
			

			<div class="col-12 text-center" style="margin-top:30px; margin-bottom:15px;">
				<button type="button" id="btn_image_add" class="btn-outline-secondary" style="margin-right:10px;">이미지 등록</button>
				<button class="submitBtn" type="submit">작성완료</button>
			</div>
			<div class="col-5" style="margin-left:auto; margin-right:auto;">
				<!-- 여기에 name이 image0, image1 식의 name으로 file input 추가됨. 보내기 직전 name 태그 붙이기 시작. -->
				<div id="img_field"></div>
				<!-- <input type="text" name="imgLength" style="display: none;"> -->
			</div>
		</form>
	</div>
	<script>
	ClassicEditor
	.create(document.querySelector("#editor"), {
		 toolbar: ['heading', '|', 'bold', 'italic', 'bulletedList', 'numberedList', 'insertTable', 'blockQuote', 'undo', 'redo',]
	});
// 	.catch(error => { console.error(error) });
	
	$("#addForm").submit(function(){
		let imgForms = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
		
		if ($(".userId").val()==null){
			alert("로그인 후 작성 가능합니다.");
			return false;
		}else if ($(".title").val()==""){
			console.log($(".title").val());
			alert("제목을 입력해 주세요.");
			return false;
		}else if ($(".storeId option:selected").val()=="음식점"){
			alert("음식점을 지정해주세요.");
			return false;
		}else if ($(".score").val()==""){
			alert("별점을 입력해 주세요.");
			return false;
		}else if ($("#editor").val()==""){
			alert("내용을 입력해 주세요.");
			return false;
		}
		
		// $("input[name=imgLength]").val(imgs.length);
        for (let i = 0; i < imgs.length; i++) {
            // if (imgs[i].children("input").val() == "" || imgs[i].children("input").val() == null) {
            //     alert("이미지 첨부 파일을 빈 상태로 두실 수 없습니다.")
            //     return false;
            //} else
            if (!imgs[i].children("input").val().match(imgForms)) {
                alert("이미지 파일만 업로드 가능합니다.");
                return false;
            }
            imgs[i].children("input").attr("name", "image" + i);
        }
	});
	
	$("#input_image").change(function(){
		let input = document.getElementById("input_image");
		let fReader = new FileReader();
		fReader.onload = function(e){
			$("#image").attr("src", e.target.result);
		}
		fReader.readAsDataURL(input.files[0]);
		$("#image").css("display","block");
	});
	
	let imgs = [];
    let imgs_length = 4;
    let imgForms = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
    $("#btn_image_add").click(function () {
        if (imgs.length < imgs_length) {
            let div = $("<div>"),
                fileInput = $("<input type='file' accept='image/*'>"),
                btn_cancel = $("<button>");
            div.addClass("input-group");
            fileInput.addClass("form-control");
            btn_cancel.addClass("btn");
            btn_cancel.addClass("btn-outline-secondary")
            btn_cancel.append("x");
            div.append(fileInput, btn_cancel);
            $("#img_field").append(div);
            imgs.push(div);

            btn_cancel.click(function () {
                imgs.splice(imgs.indexOf(div), 1);
                div.remove();
            });
        }
    });
    
    
    // 별점 시스템 추가
	
	let stars = document.querySelectorAll('.stars__link');
	
	var getNextSiblings = function (elem) {
	    var siblings = [];
	    var sibling = elem;
	    for ( ; sibling; sibling = sibling.nextElementSibling ) 
	          siblings.push( sibling );
	    return siblings;
	}
	
	var getPrevSiblings = function (elem) {
	    var siblings = [];
	    var sibling = elem;
	    for ( ; sibling; sibling = sibling.previousElementSibling ) 
	          siblings.push( sibling );
	    return siblings;
	}
	
	stars.forEach((el, idx) => {
	    el.addEventListener('click', (e) => { 
	        let nextSibs = getNextSiblings(el);
	        nextSibs.forEach((sib) => {
	            sib.children[0].classList.add('js-clear');
	            sib.children[0].classList.remove('js-fill');
	        });
	        let prevSibs = getPrevSiblings(el);
	        prevSibs.forEach((sib) => {
	            sib.children[0].classList.add('js-fill');
	        });
	        console.log(prevSibs.length);
	        $(".score").val(prevSibs.length);
	    });
	});

	</script>
</body>
</html>