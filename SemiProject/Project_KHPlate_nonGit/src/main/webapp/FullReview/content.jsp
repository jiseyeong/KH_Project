<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script
	src="https://cdn.ckeditor.com/ckeditor5/37.0.1/classic/ckeditor.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 게시판</title>
<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap')
	;

* {
	font-family: 'Nanum Gothic', sans-serif;
}

.text {
	width: 80px;
	margin-left: 10px;
}

.userid {
	margin-left:10px;
	font-weight:bold;
	font-size:14px;
	color:blue;
}
#userid{
	font-size:14px;
	color:blue;
}
.score{
	width: 40px;
	margin-left: 70px;
}

.title {
	width: 100%;
	margin-left:10px;
	font-weight:bold;
	font-size:25px;
	
}
.reviewPtag{
	color:#57b846;
	font-weight:bold;
	font-size:30px;
}
.reviewbody {
	width: 100%;
}


.replyguide {
	border-radius: 10px;
}

#writeBtnSvg {
	width:40px;
	height:40px;
	margin-bottom:10px;
}

input {
	border: none;
	border-radius: 10px;
	background-color: #ffffff00;
}

input:focus {
	outline: none !important;
}

#body{
	border:1px solid silver;
	font-size:13px;	
	padding-left:5px;
}
textarea {
	border: none;
}

.ck-editor__editable_inline {
	min-height: 150px;
	border: 1px solid white;
}

.ck.ck-editor__main>.ck-editor__editable:not(.ck-focused) {
	border: none;
}

.re_List_Container {
	height: 100px;
}

.re_list_updCompBtn{
	width: 100px;
	height: 40px;
	background-color: #57b846;
	border: none;
	border-radius: 3px;
	cursor: pointer;
	color: white;
	font-size: 14px;
	margin-right: 20px;
	box-shadow: 1px 1px 5px 1px rgb(231, 231, 231);
}

.contentsBtn>button {
	width: 100px;
	height: 40px;
	background-color: #57b846;
	border: none;
	border-radius: 3px;
	cursor: pointer;
	color: white;
	font-size: 14px;
	margin-right: 20px;
	box-shadow: 1px 1px 5px 1px rgb(231, 231, 231);
}

.re_List_Container>div>button {
	width: 70px;
	height: 40px;
	background-color: #57b846;
	border: none;
	border-radius: 3px;
	cursor: pointer;
	color: white;
	font-size: 14px;
	margin-right: 20px;
	box-shadow: 1px 1px 5px 1px rgb(231, 231, 231);
}

.imagesBox >button{
	margin: 20px;
	width : 100px;
	height: 40px;
	filter: invert(72%) sepia(39%) saturate(4538%) hue-rotate(66deg)
		brightness(106%) contrast(54%);
	border: none;
	cursor: pointer;
	font-size: 14px;
	margin-bottom: 5px;
}
/* 추가 */
.info_layout{
	display:flex;
	justify-content:left;
	align-items:center;
}

.info_layout>input{
	font-weight:bold;
}
/* 별점 시스템 */
::before,
::after {
    box-sizing: inherit;
    text-decoration: none;
    list-style-type: none;
    margin: 0;
    padding: 0;
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

.score_stars{
	float:right;
	margin-left:14px;
	width:14%;
	height:50%;
	display:flex;
	justify-content:left;
	align-items:center;
}
.stars__link{
	width:15%;
	height:100%;
	display:flex;
	justify-content:center;
	align-items:center;
}
.stars__link *{
	width:100%;
	height:100%;
}

.stars__icon {
    font-size: 5em;
    cursor: pointer;
    width:100%;
    height:100%;
}
.re_list_writer{
   font-weight:bold;
   font-size:14px;
   color:blue;
   
}
</style>

</head>
<body>
	<div class="container">

		<!-- 본문란 -->
		<form action="/update.fullreview" class="frm" method="post"
			id="addForm" enctype="multipart/form-data">
			<p class="reviewPtag">리뷰 게시판</p>
			<hr style="border-style:dotted; margin-bottom:50px;">
			<input type="text" class="title" name="title" value="${contents.title }" style="margin-bottom:10px;" readonly>
			<input type="text" class="userid" value="${writerName }" readonly>
			<hr style="border-style: dotted;">
			<div class="info_layout">
				<input type="text" class="text" value="가게 이름 : " readonly> 
				<input type="text" class="storename" name="storename" value="${storeName }"readonly> 
				<select id="storeId" class="storeId"name="storeId" style="display: none">
					<option selected>음식점</option>
					<c:forEach items="${store }" var="i" varStatus="status">
						<option value="${i.storeID }">${i.name }</option>
					</c:forEach>
				</select> 
				<input type="text" class="text score" value="평점 : " readonly> 
				<div class="score_stars">
					<c:forEach var='i' begin='1' end='5' step='1'>
						<c:choose>
							<c:when test="${contents.score<i}">
								<a class="stars__link"><i class="stars__icon fas fa-star js-clear" style="width:90%; height:90%;"></i></a>
							</c:when>
							<c:otherwise>
								<a class="stars__link"><i class="stars__icon fas fa-star js-fill" style="width:90%; height:90%;"></i></a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
				<input type="hidden" id="score" name="score" value="${contents.score}" readonly> 
				<input type="text" class="reviewid" name="reviewid" value="${contents.reviewID }" style="display: none">
			</div>
			<hr style="border-style: dotted;">

			<div class="imagesBox">
				<c:forEach var="i" items="${imgList }">
					<img src="/FullReview/${i.sysName}" alt="/FullReview/${i.oriName}"
						id="image" class="w-50 object-fit-contain"
						style="max-height: 500px;">
				</c:forEach>
			</div>

			<div class="bodyBox">
				<textarea class="reviewbody" name="reviewbody" id="intro_editor"
					readonly>${contents.reviewBody }</textarea>
			</div>

			<div class="col-12 col-lg-8"
				style="margin-left: auto; margin-right: auto; margin-bottom: 40px;">
				<!-- 여기에 name이 image0, image1 식의 name으로 file input 추가됨. 보내기 직전 name 태그 붙이기 시작. -->
				<div id="img_field"></div>
				<!-- <input type="text" name="imgLength" style="display: none;"> -->
			</div>


			<br>
			<div class="contentsBtn text-end">
				<c:choose>
					<c:when test="${sessionScope.userno eq contents.userNO || sessionScope.loginIsAdmin}">
						<button class="modiBtn" type="button">수정하기</button>
						<button type="button" id="btn_image_add"
							class="btn btn-outline-secondary"
							style="display: none; width: 140px;">이미지 추가 등록</button>
						<button class="submitBtn" type="submit" style="display: none;">수정완료</button>
						<button class="delBtn" type="button"
							reviewId="${contents.reviewID}">삭제하기</button>
						<button class="toListBtn" type="button">목록으로</button>
					</c:when>
					<c:otherwise>
						<button class="toListBtn" type="button">목록으로</button>
					</c:otherwise>
				</c:choose>
			</div>
		</form>

		<!-- 댓글 작성란 -->
		
		<c:if test="${not empty sessionScope.userno}">
		<form action="write.fullreviewreply" method="post" id="writeReplyForm">
			<div class="replyguide">
				<input type="text" id="userid" name="userid"
					value="${sessionScope.userId}" readonly
					style="height: 40px; margin-left: 10px; font-weight: bold;">
				<input type="text" class="userno" name="userno"
					value="${sessionScope.userno}" style="display: none;"> <input
					type="text" class="reviewid" name="reviewid"
					value="${contents.reviewID }" style="display: none;"> <br>
				<input type="text" id="body" name="body" placeholder="작성할 댓글 입력"
					style="height: 40px; width: 95%; margin-left: 5px; margin-right:5px;">
				<input type="submit" id="re_write_btn" style="display:none;" />
                <label for="re_write_btn">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                    fill="currentColor" type="submit" id="writeBtnSvg"
                    viewBox="0 0 16 16">
  <path
                        d="M16 8A8 8 0 1 0 0 8a8 8 0 0 0 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z" />
</svg>
</label>
			</div>
		</form>
		</c:if>
		

		<hr 1px>

		<!-- 댓글목록란 -->
		<c:if test="${replyList!=null}">
			<c:forEach var="i" items="${replyList}">
			
				<form action="/update.fullreviewreply" method="post">
					<br>
					<div class="re_List_Container" style="margin-left:10px;">
						<input type="text" class="re_list_writer" value="${i.userid }"
							style="height: 50%;" readonly>
						<div class="text-end">
						<input type="text" value="${i.body }" class="re_list_body"
							name="re_list_body" style="width: 100%; height: 50%; margin-bottom:20px;" readonly>
							<c:choose>
							<c:when test="${sessionScope.userId eq i.userid}">
								<button class="re_list_updbtn" type="button">수정</button>
								<button class="re_list_delbtn" type="button" commentid="${i.commentid }" reviewid="${contents.reviewID }">삭제</button>
								<input type="submit" value="수정완료" class="re_list_updCompBtn"
									style="display: none">

								<input type="text" class="reviewid" id="reviewid"
									name="reviewid" value="${contents.reviewID }"
									style="display: none">
								<input type="text" class="commentid" id="commentid"
									name="commentid" value="${i.commentid }" style="display: none">

								<hr>
								
							</c:when>
						</c:choose>
						</div>
					</div>
				</form>
				<br>
			</c:forEach>
		</c:if>

	</div>

	<script>
	
	let category = "<c:out value='${contents.storeID}'></c:out>";
    $("select[name='storeId']").val(category);
	
	
	
	
	var myEditor = null;
	//에디터 스크립트
	ClassicEditor
		.create(document.querySelector("#intro_editor"), {
			toolbar: ['heading', '|', 'bold', 'italic', 'bulletedList', 'numberedList', 'insertTable', 'blockQuote', 'undo', 'redo',]
		})
		.then(function (editor) {
			const toolbarElement = editor.ui.view.toolbar.element;
			myEditor = editor;
			editor.on('change:isReadOnly', (evt, propertyName, isReadOnly) => {
				if (isReadOnly) {
					toolbarElement.style.display = 'none';
				} else {
					toolbarElement.style.display = 'flex';
				}
			});
			editor.enableReadOnlyMode('');
		})
		.catch(error => { console.error(error) });

		
	
		$(".toListBtn").on("click", function() {
			location.href = "/select.fullreview";
		})

		
// 		별점 수정
		let starmodify = false;
		
		
		$(".modiBtn").on("click", function() {
			$(".modiBtn").css("display", "none");
			$(".delBtn").css("display", "none");
			$(".toListBtn").css("display", "none");
			$(".submitBtn").css("display", "inline-block");
			$(".btn-outline-secondary").css("display", "inline-block");
			$(".storename").css("display", "none");
			$(".storeId").css("display", "inline-block");
			$(".title").removeAttr("readonly");
			$(".storeId").removeAttr("readonly");
			$(".score").removeAttr("readonly");
			$(".reviewbody").removeAttr("readonly");
			myEditor.disableReadOnlyMode("");
			starModify();
		})

		$(".re_list_updbtn").on("click", function() {
			$(this).css("display", "none");
			$(this).next().css("display", "none");
			$(this).next().next().css("display", "inline-block");
			$(this).prev().removeAttr("readonly");
		})

		$(".re_list_delbtn").on(
				"click",
				function() {
					if (confirm("댓글을 정말로 삭제하시겠습니까?")) {
						location.href = "/delete.fullreviewreply?reviewid="
								+ $(this).attr("reviewid") + "&commentid="
								+ $(this).attr("commentid");
					} else {
						return false;
					}
				})

		$(".delBtn").on("click",function() {
			if (confirm("게시글을 정말로 삭제하시겠습니까?")) {
				location.href = "/delete.fullreview?reviewid="
						+ $(this).attr("reviewid") +"&storeid="+$("#storeId option:selected").val();
			} else {
				return false;
			}
		})
				
		//이미지 추가 등록 스크립트
        let imgs = [];
        let alreadyImgsLength = "<c:out value='${fn:length(imgList)}'></c:out>"
        let maxlength = 4 - alreadyImgsLength;
        let imgForms = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
        $("#btn_image_add").click(function () {
           if (imgs.length < maxlength) {
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
        
        $("#addForm").submit(function (e) {
        	
    		if ($(".title").val()==""){
    			console.log($(".title").val());
    			alert("제목을 입력해 주세요.");
    			return false;
    		}else if ($(".storeId option:selected").val()=="음식점"){
    			alert("음식점을 지정해주세요.");
    			return false;
    		}else if ($("#score").val()==""){
    			alert("별점을 입력해 주세요.");
    			return false;
    		}else if ($("#intro_editor").val()==""){
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
        })
        
        function starModify() {
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
    		        $("#score").val(prevSibs.length);
    		    });
    		});
        }
        
        // 답글 폼 submit 시
        $("#writeReplyForm").on("submit",function(){
        	if($("#body").val()==""){
        		alert("내용을 입력해주세요.");
        		return false;
        	}
        })
	</script>
</body>
</html>