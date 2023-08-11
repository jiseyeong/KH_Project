<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
         <!DOCTYPE html>
         <html>

         <head>
            <meta charset="UTF-8">
            <title>가게 정보 확인</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
               rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
               rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/octicons/3.3.0/octicons.min.css"
               integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
               crossorigin="anonymous">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
               integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
               crossorigin="anonymous"></script>
            <script type="text/javascript"
               src="//dapi.kakao.com/v2/maps/sdk.js?appkey=714989160c4bbb672f636a880c6c8328&libraries=services"></script>
            <script src="https://cdn.ckeditor.com/ckeditor5/37.0.1/classic/ckeditor.js"></script>

            <style>
               @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');/*나눔고딕 폰트 import */
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
               .star-ratings {
                  color: #aaa9a9;
                  position: relative;
                  unicode-bidi: bidi-override;
                  width: max-content;
                  -webkit-text-fill-color: transparent;
                  /* Will override color (regardless of order) */
                  -webkit-text-stroke-width: 1.3px;
                  -webkit-text-stroke-color: #2b2a29;
               }

               .star-ratings-fill {
                  color: #fff58c;
                  padding: 0;
                  position: absolute;
                  z-index: 1;
                  display: flex;
                  top: 0;
                  left: 0;
                  overflow: hidden;
                  -webkit-text-fill-color: gold;
               }

               .star-ratings-base {
                  z-index: 0;
                  padding: 0;
               }

               .star a {
                  text-decoration: none;
                  color: gray;
               }

               .star a.on {
                  color: #fff58c;
               }

               .star_other a {
                  text-decoration: none;
                  color: gray;
               }

               .star_other a.on {
                  color: #fff58c;
               }

               .nonactive {
                  display: none;
               }

               .carousel-inner img {
                  margin: auto;
               }
               .carousel-item {
                  height:520px;
                  width:500px;
               }
               .carousel-inner>.carousel-item>img {
                     top: 0;
                     left: 0;
                     width: 100%;
                     height:100%;
                } 

               #map {
                  width: 100%;
                  height: 25vw;
               }
               .form-control{
                  margin-top:5px;
                  width:100%;
               }
               #nameDiv {
                  font-size:40px;
                  font-weight:bold;
                  text-align:center;
                  margin-bottom:20px;
               }
               #categoryDiv{
                  font-size:17px;
                  color:green;
                  font-weight:600;
                  text-align:center;
                  margin-bottom:10px;
               }
               #priceRangeDiv{
                  font-size:15px;
                  font-weight:600;
                  text-align:center;
                  margin-bottom:10px;
               }
               #addressDiv{
                  font-size:15px;
                  font-weight:600;
                  text-align:center;
                  margin-bottom:10px;
               }
               
               .input-group{
                  display:block;
               }
               .input-group>div {
                  text-align:center;
                  margin-bottom:10px;
               }
               .input-group-text{
                  margin-top:5px;
               }
               .form-select {
                  margin-top:5px;
               }
               .input-group>span{
                  font-size:14px;
               }
               .input-group>input{
                  font-size:14px;
               }
               .updateMenuName{
                   border:none;
                   width:100%;
                   height:100%;
                   text-align:center;
                   margin:0 auto;
                   display:block;
                   padding-bottom:5px;
               }
               .updateMenuPrice{
                  border:none;
                  width:80%;
                  height:100%;
                  text-align:center;
                  margin-right:10px;
                  margin-top:0;
                  margin-bottom:0;
                  padding-bottom:5px;  
               }
               .ck-editor__editable_inline {
                   min-height: 150px;
                   border:1px solid white;
               }
               .ck.ck-editor__main>.ck-editor__editable:not(.ck-focused) {
                  border:1px dotted black;
                  margin-bottom:30px;
               }
               .greenBtn{
					font-size:13px;
					width:110px;
					height:35px;
					border-radius:3px;
					border:none;
					background-color:#57b846;
					color:white;
					box-shadow:1px 1px 5px 1px rgb(231, 231, 231);
					margin-right:5px;
               }
               .greenBtn:hover{
               	 background-color: #4dae3c;
               }
               .navi>a{
               	  color:black;
               }
               .navi>a:hover{
               	  color:red;
               	  text-decoration: underline;
               }
               .addFavorite_btn {
					width: 20%;
					height: 20%;
					font-size: 20px;
				}
				.istrue {
					filter: invert(28%) sepia(63%) saturate(6367%) hue-rotate(351deg) brightness(92%) contrast(101%);
					width:25px;
					height:25px;
				}

				.isfalse {
					filter: invert(100%) sepia(0%) saturate(2%) hue-rotate(209deg) brightness(110%) contrast(101%);
					width:25px;
					height:25px;
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
                     <!-- 상점 헤더 이미지 -->
                     <div class="row">
                        <div class="col-12 col-lg-5" id="imageBox" style="margin-left:auto;"> <!--가게 사진 캐러쉘-->
                           <div id="carouselControls" class="carousel slide carousel-fade" data-bs-ride="carousel">
                              <div class="carousel-inner">
                                 <c:choose>
                                    <c:when test="${fn:length(imgList) > 0}">
                                       <c:forEach var="i" begin="0" end="${fn:length(imgList)-1}" step="1">
                                          <c:choose>
                                             <c:when test="${i == 0}">
                                                <div class="carousel-item active">
                                                   <img src="/store/${imgList.get(i).sysName}"
                                                      class="d-block w-100 h-100 object-fit-cover" alt="${imgList.get(i).sysName}"
                                                      style="min-height: 400px;">
                                                </div>
                                             </c:when>
                                             <c:otherwise>
                                                <div class="carousel-item">
                                                   <img src="/store/${imgList.get(i).sysName}"
                                                      class="d-block w-100 h-100 object-fit-cover" alt="${imgList.get(i).sysName}"
                                                      style="min-height: 400px;">
                                                </div>
                                             </c:otherwise>
                                          </c:choose>
                                       </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                       <div class="carousel-item active">
                                          <img src="/store/롤링파스타.png" class="d-block w-100 h-100 object-fit-cover"
                                             alt="롤링파스타.png" style="min-height:400px;">
                                       </div>
                                       <div class="carousel-item">
                                          <img src="/store/오로지라멘.png" class="d-block w-100 h-100 object-fit-cover"
                                             alt="오로지라멘.png" style="min-height:400px;">
                                       </div>
                                    </c:otherwise>
                                 </c:choose>
                              </div>
                              <button class="carousel-control-prev" type="button"
                                 data-bs-target="#carouselControls" data-bs-slide="prev">
                                 <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                 <span class="visually-hidden">Previous</span>
                              </button>
                              <button class="carousel-control-next" type="button"
                                 data-bs-target="#carouselControls" data-bs-slide="next">
                                 <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                 <span class="visually-hidden">Next</span>
                              </button>
                           </div>
                        </div>
                        <div class="col-12 col-lg-5 nonactive" id="imageModify" style="margin-left:auto;">
                           <c:if test="${fn:length(imgList) > 0}">
                           	  <form action="/deletePhoto.store" method="get">
                              <div class="row">
                                 <c:forEach var="i" items="${imgList}">
                                <input type="text" name="imageID" value="${i.imageID}"
                                  style="display: none;" readonly>
                              	<input type="text" name="storeID" value="${dto.storeID}"
                                  style="display: none;" readonly>
                                 	<div class="col-12 col-lg-6"> 
                                      <img src="/store/${i.sysName}"
                                          class="w-100 h-75 object-fit-cover" alt="${i.sysName}" style="margin-bottom:10px; min-height:200px;">
                            		  <div class="h-25" style="text-align:center; margin-bottom:10px;">
                               				<button type="submit" class="greenBtn" style="width:60px;">삭제</button>
                                	  </div>
                              	 
                                  	</div>    
                                </c:forEach>
                              </div>
                              </form>
                           </c:if>
                           <form id="updateForm" action="/update.store" method="get">
                              <input type="text" name="storeID" value="${dto.storeID}" style="display:none;"
                                 readonly> 
                        </div>
                        <div class="col-12 col-lg-3" style="margin-right:auto;"> <!--맵 부분-->
                           <div id="map"></div>
                           <div class="mapInfo">
                              <input type="text" name="mapLat" value="${dto.lat}" style="display:none;"
                                 readonly>
                              <input type="text" name="mapLng" value="${dto.lng}" style="display:none;"
                                 readonly>
                              <div class="row">
                                 <div class="col-12">
                                    <div class="input-group">
                                       <span class="input-group-text">거리(M)</span>
                                       <input type="text" name="mapDistance" class="form-control"
                                          value="${dto.distance}" readonly>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <c:if test="${sessionScope.loginIsAdmin}">
	                        <div class="col-12 col-lg-8 text-end" style="margin-top:30px; margin-left:auto; margin-right:auto; margin-bottom:50px;">
	                           <button type="button" id="btn_image_add" class="greenBtn" style="display:none;">이미지 추가 등록</button>
	                           <button type="button" id="btn_store_update" class="greenBtn">상점 수정</button>
	                           <button type="button" id="btn_store_update_delete" class="nonactive">상점 삭제</button>
	                           <button type="button" id="btn_store_update_confirm" class="nonactive">수정 확정</button>
	                           <button type="button" id="btn_store_update_cancel" class="nonactive">취소</button>
	                        </div>
                        </c:if>
                     </div>
                     <!-- 상점 본문 -->
                     <div class="row">
						<div class="col-12 col-lg-8" style="margin-left:auto; margin-right:auto; margin-bottom:40px;">
                        <!-- 여기에 name이 image0, image1 식의 name으로 file input 추가됨. 보내기 직전 name 태그 붙이기 시작. -->
                        <div id="img_field"></div>
                        <!-- <input type="text" name="imgLength" style="display: none;"> -->
                        </div>
                        <div class="col-12 col-lg-8" style="margin-left:auto; margin-right:auto;">
                          <div id="nameDiv">${dto.name}</div>
                           <div class="input-group">   
                              <span class="input-group-text" style="display:none;">가게 이름</span>
                              <input type="text" class="form-control" name="name" value="${dto.name}"readonly style="display:none;"><!--가게 이름-->
                           </div>
                           <div id="categoryDiv">${dto.category}</div>
                           <div class="input-group">
                              <span class="input-group-text" style="display:none;">가게 카테고리</span>
                              <select name="category" class="form-select" disabled="disabled" style="display:none;"><!--가게 카테고리-->
                                 <option>한식</option>
                                 <option>양식</option>
                                 <option>중식</option>
                                 <option>일식</option>
                                 <option>아시안</option>
                                 <option>디저트/음료</option>
                                 <option>패스트푸드</option>
                                 <option>기타</option>
                              </select>
                           </div>
                           <div id="priceRangeDiv">${dto.priceRange}</div>
                           <div class="input-group">      
                              <span class="input-group-text" style="display:none;">1인당 가격 범위</span>
                              <select name="priceRange" class="form-select" disabled="disabled" style="display:none;"><!--1인당 가격범위-->
                                 <option>5000이하</option>
                                 <option>5000~10000</option>
                                 <option>10000~15000</option>
                                 <option>15000~20000</option>
                                 <option>20000이상</option>
                              </select>
                           </div>
                           <div id="addressDiv">${dto.address}</div>
                           <div class="input-group">
                              <span class="input-group-text" style="display:none;">가게 주소</span>
                              <input type="text" class="form-control" name="address" value="${dto.address}" style="display:none;" readonly><!--가게 주소-->
                           </div>
                           <div class="row" style="margin-top:30px;">
                              <div class="col-2" style="margin-left:auto; padding:0;">
                                 <div class="star-ratings" style="float:left;">
                                    <div class="star-ratings-fill space-x-2 text-lg" style="width:${dto.ratingToPercent()}%;">
                                       <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                                    </div>
                                    <div class="star-ratings-base space-x-2 text-lg">
                                       <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                                    </div>
                                 </div>
                                 <div style="float:left; font-size:17px; font-weight:600; margin-left:10px;">
                                    ${dto.avgScore}
                                 </div>
                              </div>
                           		    <div class="col-1"  style="margin-right:auto; padding:0;">
                                 	<input type="text" id="favoriteUserNo" value="${sessionScope.userno}" style="display:none;">
                                 	<input type="text" id="favoriteStoreID" value="${dto.storeID}" style="display:none;">
                                 	<c:choose>
	                                 	<c:when test="${not empty favorite}">
	                                 		<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="addFavorite_btn istrue" viewBox="0 0 16 16">
  											<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
											</svg>
	                                 	</c:when>
	                                 	<c:otherwise>
	                                 		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="addFavorite_btn isfalse" viewBox="0 0 16 16">
  											<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
											</svg>
	                                 	</c:otherwise>
                                 	</c:choose>
	                             </div>
                           </div>
                           <!-- <input type="text" class="inputs" name="avgScore" value="${dto.avgScore}" style="display: none;"> -->
                           <div class="row" style="margin-top:50px;">
                              <div class="col-12" style="font-weight:bolder; font-size:25px; margin-bottom:10px;">가게 소개</div>
                              <hr style="border-style:dotted;">
                              <div class="col-12">
                                 <textarea id="intro_editor"
                                    name="introduction">${dto.introduction}</textarea>
                              </div>
                           </div>
                           </form>
                           <div class="row">
                              <div class="col-12">
                                 <table class="table" style="text-align:center; color:white; margin-top:20px; vertical-align:middle;">
                                    <tr style="background-color:#57b846;">
                                       <th style="width:50%;">메뉴 이름</th>
                                       <th style="width:50%;">메뉴 가격</th>
                                    </tr>
                                    <form id="menuUpdateForm" action="/modify.storeMenu" method="post">
                                    <input type="text" name="menuLength" value="${menuList.size()}" style="display: none;">
                                    <input type="text" name="storeID" value="${dto.storeID}" style="display: none;">
                                    <c:if test="${fn:length(menuList) > 0}">
                                       <c:forEach var="i" begin="0" end="${fn:length(menuList)-1}" step="1">
                                       <tr>
                                            <input type="text" name="menuID${i}" value="${menuList.get(i).menuID}" style="display:none;" readonly>
                                             <td><input type="text" class="updateMenuName"
                                                   name="updateMenuName${menuList.get(i).menuID}" value="${menuList.get(i).menuName}"
                                                   readonly></td>
                                             <td><input type="text" class="updateMenuPrice"
                                                   name="updateMenuPrice${menuList.get(i).menuID}" value="${menuList.get(i).menuPrice}"
                                                   readonly>
                                             <a href="/delete.storeMenu?menuID=${menuList.get(i).menuID}&storeID=${dto.storeID}">
	                                             <button type="button" class="btn_menu_delete nonactive" style="width:60px;">삭제</button>                                                
                                             </a>
                                             </td>
                                       </tr>
                                       </c:forEach>
                                    </c:if>
                                       <input type="text" name="storeID" value="${dto.storeID}"
                                          style="display: none;" readonly>
                                       <tr id="menu_add" class="nonactive">
                                          <td>
                                             <div class="input-group">
                                                <span class="input-group-text">메뉴이름</span>
                                                <input type="text" class="form-control" name="addedMenuName">
                                             </div>
                                          </td>
                                          <td>
                                             <div class="input-group">
                                                <span class="input-group-text">메뉴가격</span>
                                                <input type="text" class="form-control"
                                                   name="addedMenuPrice">
                                             </div>
                                          </td>
                                       </tr>
                                 </table>
                                 <c:if test="${sessionScope.loginIsAdmin}">
                                 <div class="row">
                                    <div class="col-12 text-end">
                                      <button type="button"
                                                class="greenBtn" id="btn_menu_submit" style="display:none;">적용</button>
                                       <button type="button" id="btn_menu_modify"
                                          class="greenBtn">메뉴 수정</button>
                                       <button type="button" id="btn_menu_modify_cancel"
                                          class="nonactive">수정 모드 취소</button>
                                    </div>
                                 </div>
                                 </c:if>
                                 </form>
                              </div>
                           </div>
                        </div>
                     </div>

                     <!-- 리뷰 -->
                     <div class="row" style="margin-top:70px;">
                        <c:if test="${not empty sessionScope.userno}">
                           <div class="col-12 col-lg-8" style="margin-left:auto; margin-right:auto; font-weight:bold; margin-bottom:5px;">한줄 리뷰 추가<hr></div>
                           <form id="createCommentForm" action="/create.commentReview" method="post">
                              <input type="text" name="storeID" value="${dto.storeID}" style="display:none;">
                              <input type="text" name="userNo" value="${sessionScope.userno}"
                                 style="display: none;">
                              <div class="row">
                                 <div class="col-12 col-lg-8" style="margin-left:auto; margin-right:auto;">
                                    <div class="row align-items-center">
                                       <div class="col-12">
                                          <div class="star" style="margin-bottom:10px;">
                                             <input type="text" name="score" style="display:none;"
                                                id="score">
                                             <a href="#null" value="1">★</a>
                                             <a href="#null" value="2">★</a>
                                             <a href="#null" value="3">★</a>
                                             <a href="#null" value="4">★</a>
                                             <a href="#null" value="5">★</a>
                                          </div>
                                       </div>
                                       <div class="col-11 review_editorDiv" >
                                          <textarea id="review_editor" name="body"></textarea>
                                       </div>
                                       <div class="col-1">
                                          <button class="greenBtn" style="width:65px;">등록</button>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </form>
                           <script>
                              ClassicEditor
                                 .create(document.querySelector("#review_editor"))
                                 .then(function (editor) {
                                    const toolbarElement = editor.ui.view.toolbar.element;
                                    toolbarElement.style.display = 'none';
                                 })
                                 .catch(error => { console.error(error) });
                           </script>
                        </c:if>
                        <c:if test="${fn:length(commentList) > 0}">
                           <div class="col-12 col-lg-8" style="margin-left:auto; margin-right:auto;  font-weight:bold; margin-bottom:10px; margin-top:30px;">한줄 리뷰 목록
                           <hr>
                           </div>
                           <div class="row">
                              
                              <c:forEach var="i" begin="0" end="${fn:length(commentList)-1}" step="1">
                                 <div class="col-12 col-lg-8" style="margin-left:auto; margin-right:auto; font-weight:600;">${userIDList.get(i)}</div>

                                 <div class="col-12 col-lg-8" style="margin-left:auto; margin-right:auto; margin-bottom:10px;">
                                    <div id="readStar${i}" class="star-ratings active" style="float:left;">
                                       <div class="star-ratings-fill space-x-2 text-lg"
                                          style="width: ${commentList.get(i).ratingToPercent()}%;">
                                          <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                                       </div>
                                       <div class="star-ratings-base space-x-2 text-lg">
                                          <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                                       </div>
                                    </div>
                                    <div style="float:left; margin-left:10px; font-weight:600;">
                                       ${commentList.get(i).score}
                                    </div>
                                 </div>

                                 <form id="updateCommentForm${i}" action="/update.commentReview"
                                    method="post">
                                    <input type="text" name="storeID" value="${dto.storeID}"
                                       style="display: none;">
                                    <input type="text" name="reviewID"
                                       value="${commentList.get(i).reviewID}" style="display: none;">

                                    <div id="writeStar${i}" class="col-12 col-lg-8 star nonactive" style="margin-left:auto; margin-right:auto;">
                                       <input type="text" id="score${i}" name="modifyScore"
                                          style="display:none;">
                                       <a href="#null" value="1">★</a>
                                       <a href="#null" value="2">★</a>
                                       <a href="#null" value="3">★</a>
                                       <a href="#null" value="4">★</a>
                                       <a href="#null" value="5">★</a>
                                    </div>
                                    <div class="col-12 col-lg-8" style="margin-left:auto; margin-right:auto;">
                                       <textarea id="review_editor${i}" name="modifyBody">
                                          ${commentList.get(i).body}
                                       </textarea>
                                    </div>
                                 </form>
                                 <c:if test="${commentList.get(i).userNo == sessionScope.userno}">
                                    <div id="replyControl${i}" class="col-12 col-lg-8 text-end" style="margin-left:auto; margin-right:auto; margin-top:10px;">
                                       <button type="button" id="btn_modify${i}"
                                          class="greenBtn">수정</button>
                                       <button type="button" id="btn_delete${i}"
                                          class="nonactive">삭제</button>
                                       <form id="commentDeleteForm${i}" action="/delete.commentReview"
                                          method="get">
                                          <input type="text" name="reviewID"
                                             value="${commentList.get(i).reviewID}"
                                             style="display: none;">
                                          <input type="text" name="storeID" value="${dto.storeID}"
                                             style="display: none;">
                                       </form>
                                    </div>
                                 </c:if>

                                 <script>
                                    var i = "<c:out value='${i}'></c:out>";
                                    var target = "#review_editor" + i;
                                    ClassicEditor
                                       .create(document.querySelector(target))
                                       .then(function (editor) {
                                          const toolbarElement = editor.ui.view.toolbar.element;
                                          toolbarElement.style.display = 'none';
                                          editor.enableReadOnlyMode('');

                                          let btn_modify = "#btn_modify" + i;
                                          let btn_delete = "#btn_delete" + i;
                                          let commentDeleteForm = "#commentDeleteForm" + i;
                                          let readStar = "#readStar" + i;
                                          let btn_confirm = "#btn_confirm" + i;
                                          let btn_confirm_id = "btn_confirm" + i;
                                          let btn_cancel = "#btn_cancel" + i;
                                          let btn_cancel_id = "btn_cancel" + i;

                                          let writeStar = "#writeStar" + i;
                                          let score = "#score" + i;

                                          let replyControl = "#replyControl" + i;
                                          let updateForm = "#updateCommentForm" + i;
                                          let target2 = "#review_editor" + i;

                                          //별점 버튼 이벤트 등록
                                          $(writeStar + " a").click(function () {
                                             $(this).parent().children("a").removeClass("on");
                                             $(this).addClass("on").prevAll("a").addClass("on");
                                             $(score).attr("value", $(this).attr("value"));
                                          });

                                          $(btn_delete).click(function () {
                                             $(commentDeleteForm).submit();
                                          });

                                          $(btn_modify).click(function () {
                                             if (!($(btn_confirm).length > 0)) {
                                                let btn_confirm_body = $("<button>");
                                                let btn_cancel_body = $("<button>");

                                                btn_confirm_body.text("수정완료");
                                                btn_confirm_body.attr("id", btn_confirm_id);
                                                btn_confirm_body.attr("type", "button");
                                                btn_confirm_body.addClass("greenBtn");
                                                btn_confirm_body.click(function () {
                                                  	if(!($(score).val())){
                                            		  alert("수정할 평점을 입력해주세요.");
                                            		  return false;
                                            	  	}else if(!($(target2+"+div .ck-content").text())){
                                            		  alert("수정할 리뷰 본문은 비어있을 수 없습니다.");
                                            		  return false;
                                            	  	}
                                                	$(updateForm).submit();
                                                });

                                                btn_cancel_body.attr("type", "button");
                                                btn_cancel_body.attr("id", btn_cancel_id);
                                                btn_cancel_body.addClass("greenBtn");
                                                btn_cancel_body.text("취소");
                                                btn_cancel_body.click(function () {
                                                   location.reload();
                                                   // $(btn_modify + "," + readStar).removeClass("nonactive");
                                                   // $(btn_modify).addClass("greenBtn");
                                                   // $(btn_delete + "," + btn_confirm + "," + btn_cancel).removeClass("greenBtn");
                                                   // $(btn_confirm + "," + btn_cancel + "," + writeStar + "," + btn_delete).addClass("nonactive");
                                                   // editor.enableReadOnlyMode("");
                                                });

                                                $(replyControl).prepend(btn_confirm_body);
                                                $(replyControl).prepend(btn_cancel_body);
                                             }
                                             if (editor.isReadOnly) {
                                                editor.disableReadOnlyMode("");
                                                $(btn_modify + "," + readStar).addClass("nonactive");
                                                $(btn_modify).removeClass("greenBtn");
                                                $(btn_delete + "," + btn_confirm + "," + btn_cancel).addClass("greenBtn");
                                                $(btn_confirm + "," + btn_cancel + "," + writeStar + "," + btn_delete).removeClass("nonactive");
                                             }
                                          });
                                       })
                                       .catch(error => { console.error(error) });

                                 </script>

                              </c:forEach>
                              <div class="col-12 text-center navi" style="margin-top:10px;">
                                 <c:if test="${navi.needNext}">
                                    <a href="/view.store?storeID=${dto.storeID}&cpage=${navi.naviList.get(0) - 1}"><</a>
                                 </c:if>
                                 <c:forEach var="i" items="${navi.naviList}">
                                    <a href="/view.store?storeID=${dto.storeID}&cpage=${i.intValue()}">${i.intValue()}</a>
                                 </c:forEach>
                                 <c:if test="${navi.needNext}">
                                    <a href="/view.store?storeID=${dto.storeID}&cpage=${navi.naviList.get(navi.naviList.length)+1}">></a>
                                 </c:if>
                              </div>
                           </div>
                        </c:if>
                     </div>

                     <script>
                        //select 카테고리 기본 값 설정
                        let category = "<c:out value='${dto.category}'></c:out>";
                        $("select[name='category']").val(category);
                        let priceRange = "<c:out value='${dto.priceRange}'></c:out>";
                        $("select[name='priceRange']").val(priceRange);

                        //별점 버튼 이벤트 등록
                        $(".star a").click(function () {
                           $(this).parent().children("a").removeClass("on");
                           $(this).addClass("on").prevAll("a").addClass("on");
                           $("input[name='score']").attr("value", $(this).attr("value"));
                        });
                        
                        //폼 섭밋 전 방어 코드들
                        $("#btn_menu_submit").click(function(){
                        	let menuPrice = $("input[name='addedMenuPrice']").val();
                        	let menuName = $("input[name='addedMenuName']").val();
                        	$("input[name='addedMenuName']").val(menuName.trim());
                        	menuName = $("input[name='addedMenuName']").val();
                        	if(!menuPrice && menuName){
                        		alert("추가할 메뉴의 가격도 설정해주셔야 합니다.");
                        		return false;
                        	}else if (isNaN(menuPrice)) {
                               alert("메뉴 가격은 숫자 형식이어야 합니다.");
                               return false;
                            }else if(menuPrice.split(' ').join('').length != menuPrice.length){
                            	alert("메뉴 가격에는 공백이 포함될 수 없습니다.");
                            	return false;
                            }
                            if(!menuName && menuPrice){
                            	alert("추가할 메뉴의 이름도 설정해주셔야 합니다. 또는 빈 문자열만의 이름은 설정하실 수 없습니다.");
                            	return false;
                            }
                            
                            let isReturn = false;
                            $(".updateMenuPrice").each(function(index, item){
                               if(!$(item).val()){
                                  alert("메뉴 가격은 빈 값일 수 없습니다.");
                                  isReturn = true;
                                  return false; //break;
                               }
                               else if(isNaN($(item).val())){
                                  alert("메뉴 가격은 숫자 형식이어야 합니다.");
                                  isReturn = true;
                                  return false; //break;
                               }else if($(item).val().split(' ').join('').length != $(item).val().length){
                            	   alert("메뉴 가격에는 공백이 포함될 수 없습니다.");
                            	   isReturn = true;
                            	   return false; //break;
                               }
                            });
                            if(!isReturn){
 	                           $(".updateMenuName").each(function(index, item){
 	                        	   $(item).val($(item).val().trim());
 	                        	  if(!$(item).val()){
 	                        		  alert("메뉴 이름은 빈 값일 수 없습니다. 또는 공백만으로 구성될 수 없습니다.");
 	                        		  isReturn = true;
 	                        		  return false; //break;
 	                        	  }
 	                           });                        	   
                            }
                            if(isReturn){
                               return false;
                            }
                        	$("#menuUpdateForm").submit();
                        });
                        
                        
                        $("#createCommentForm").submit(function(){
                        	if(!($("input[name='score']").val())){
                        		alert("리뷰 평점을 선택해주세요.");
                        		return false;
                        	}else if(!($("#review_editor").val())){
                        		alert("리뷰 본문을 입력해주세요.");
                        		return false;
                        	}
                        })

                        $("#btn_menu_modify").click(function () {
                           $(".btn_menu_delete").removeClass("nonactive").addClass("greenBtn");
                           $(".btn_menu_update").removeClass("nonactive").addClass("greenBtn");
                           $("#btn_menu_modify_cancel").removeClass("nonactive").addClass("greenBtn");
                           $(this).addClass("nonactive").removeClass("greenBtn");
                           $("#btn_menu_submit").css("display","inline");

                           $("#menu_add").removeClass("nonactive");
                           $(".updateMenuName").attr("readonly",false);
                           $(".updateMenuPrice").attr("readonly",false);
                           
                           $(".updateMenuName").css("border-bottom","1px dotted black");
                           $(".updateMenuPrice").css("border-bottom","1px dotted black");
                        });

                        $("#btn_menu_modify_cancel").click(function () {
                           let storeID = "<c:out value='${dto.storeID}'></c:out>";
                           location.href = "/view.store?storeID=" + storeID;
                        });

                        $("#btn_store_update").click(function () {
                           $("#btn_store_update_confirm").removeClass("nonactive").addClass("greenBtn");
                           $("#btn_store_update_cancel").removeClass("nonactive").addClass("greenBtn");
                           $("#btn_store_update_delete").removeClass("nonactive").addClass("greenBtn");
                           $(this).addClass("nonactive").removeClass("greenBtn");

                           updateOn = true;
                           $("input[name='name']").removeAttr("readonly");
                           $("select[name='category']").removeAttr("disabled");
                           $("select[name='priceRange']").removeAttr("disabled");
                           $("input[name='address']").removeAttr("readonly");
                           
                           $("input[name='name']").css("display","inline");
                           $("select[name='category']").css("display","inline");
                           $("select[name='priceRange']").css("display","inline");
                           $("input[name='address']").css("display","inline");
                           
                           $("#nameDiv").css("display","none");
                           $("#categoryDiv").css("display","none");
                           $("#priceRangeDiv").css("display","none");
                           $("#addressDiv").css("display","none");
                           
                           $(".input-group-text").css("display","inline");
                           $("#btn_image_add").css("display","inline");
                           
                           myEditor.disableReadOnlyMode("");
                           $("#imageBox").addClass("nonactive");
                           $("#imageModify").removeClass("nonactive");
                        });

                        $("#btn_store_update_confirm").click(function () {
                           //$("#updateForm").submit();
                           
                            if(!($("input[name='name']").val())){
                          	   alert("가게 이름 값을 빈 값으로 둘 수 없습니다.");
                          	   return false;
                             }else if(!($("input[name='address']").val())){
                          	   alert("가게 주소 값을 빈 값으로 둘 수 없습니다.");
                          	   return false;
                             }
                           
                           for(let i = 0; i < imgs.length; i++){
                              if (!imgs[i].children("input").val().match(imgForms)) {
                                 alert("이미지 파일만 업로드 가능합니다.");
                                 return;
                              }
                           }

                           let formData = new FormData();
                           formData.append("storeID", "<c:out value='${dto.storeID}'></c:out>");
                           for(let i = 0; i < imgs.length; i++){
                              let fileInput = imgs[i].children("input")[0];
                              let file = fileInput.files[0];
                              formData.append("images"+i, file);
                           }


                           $.ajax({
                              url:"/updatePhoto.store",
                              type:"post",
                              data:formData,
                              processData : false,
                              contentType : false
                           }).done(function(resp){
                              $("#updateForm").submit();
                           });
                        });

                        $("#btn_store_update_delete").click(function(){
                           let storeID = "<c:out value='${dto.storeID}'></c:out>";
                           location.href = "/delete.store?storeID="+storeID;
                        })

                        $("#btn_store_update_cancel").click(function () {
                           let storeID = "<c:out value='${dto.storeID}'></c:out>";
                           location.href = "/view.store?storeID=" + storeID;
                        });
                        
                        let addFavoriteStoreCheck = false;
                        //즐겨찾기 스크립트
                        $(".addFavorite_btn").click(function(){
                        	let storeID= $("#favoriteStoreID").val();
                        	let userNo = $("#favoriteUserNo").val();
                        	addFavoriteStoreCheck = $(this).hasClass("istrue");
                        	if(!userNo){
                        		alert("로그인을 먼저 진행해주세요.");
                        	}else{
                        		let btn = $(this);
                        		if(addFavoriteStoreCheck == false){
                        			$.ajax({
                        				url:"/addFavoriteStore.store",
                        				type:"post",
                        				data:{
                        					addFavorite_storeID : storeID,
                        				},
                        			})
                        			.done(function (resp){
                        				if(resp=="true"){
                        					addFavoriteStoreCheck = true;
                        					btn.removeClass("isfalse");
                        					btn.addClass("istrue");
                        				}
                        			});
                        		}else{
                        			$.ajax({
                        				url:"/deleteFavoriteStore.store",
                        				type:"post",
                        				data:{
                        					addFavorite_storeID : storeID,
                        				},
                        			})
                        			.done(function (resp){
                        				if(resp == "true"){
                        					addFavoriteStoreCheck = false;
                        					btn.removeClass("istrue");
                        					btn.addClass("isfalse");
                        				}
                        			})
                        		}
                        	}
                        });


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
                              btn_cancel.addClass("greenBtn")
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

                        //지도 스크립트
                        let mapContainer = document.getElementById("map");
                        let lat = "<c:out value='${dto.lat}'></c:out>";
                        let lng = "<c:out value='${dto.lng}'></c:out>";
                        let updateOn = false;
                        let options = {
                           //현재는 학원 좌표인데, 가게 중심 좌표 구해서 해봐야 할 것임.
                           //가게 등록할 때, 마커 등록 시 function(e) -> e.latlan
                           //center: new kakao.maps.LatLng(37.567944388923316, 126.98295041529863),
                           center: new kakao.maps.LatLng(lat, lng),
                           level: 3
                        };
                        let map = new kakao.maps.Map(mapContainer, options);
                        
                        let geocoder = new kakao.maps.services.Geocoder();
                        
                        function searchDetailAddrFromCoords(coords, callback) {
                            // 좌표로 법정동 상세 주소 정보를 요청합니다
                            geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
                        }
                        
                        // 학원 마커 이미지 등록
                        var imageSrc = '/allstore_inquiry/khplate_marker.png', // 마커이미지의 주소입니다    
                           imageSize = new kakao.maps.Size(74, 79), // 마커이미지의 크기입니다
                           imageOption = { offset: new kakao.maps.Point(27, 69) }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
                        // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
                        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)

                        // 학원 마커 표시
                        // 지도를 클릭한 위치에 표출할 마커입니다
                        var khacademy = new kakao.maps.Marker({
                           // 지도 중심좌표에 마커를 생성합니다 
                           position: new kakao.maps.LatLng(37.567944388923316, 126.98295041529863),
                           // 마커이미지 설정 
                           image: markerImage
                        });
                        // 지도에 마커를 표시합니다
                        khacademy.setMap(map);

                        marker = new kakao.maps.Marker({
                           //position: new kakao.maps.LatLng(37.567944388923316, 126.98295041529863)
                           position: new kakao.maps.LatLng(lat, lng)
                        });
                        marker.setMap(map);
                        kakao.maps.event.addListener(map, "click", function (e) {
                           if (updateOn) {
                              if (marker != null) {
                                 marker.setMap(null);
                              }
                              let pos = e.latLng;
                              marker = new kakao.maps.Marker({
                                 position: pos
                              });
                              let lat = pos.toString().split(',')[0].split('(')[1],
                                 lng = pos.toString().split(',')[1].split(')')[0];
                              $("input[name=mapLat]").val(lat);
                              $("input[name=mapLng]").val(lng);
                              marker.setMap(map);

                              let dLat = (37.567944388923316 - lat) * (Math.PI / 180);
                              let dLng = (126.98295041529863 - lng) * (Math.PI / 180);
                              let a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(37.567944388923316 * (Math.PI / 180)) * Math.cos(lat * (Math.PI / 180)) * Math.sin(dLng / 2) * Math.sin(dLng / 2);
                              let c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
                              let d = 6371 * c;
                              $("input[name=mapDistance]").val(Math.round(d * 1000));
                              searchDetailAddrFromCoords(e.latLng, function(result, status){
                              	if(status == kakao.maps.services.Status.OK){
                              		//도로명 주소 있으면 도로명, 없으면 지번 주소 
                              		let detailAddr = !!result[0].road_address ? result[0].road_address.address_name : result[0].address.address_name;
                              		
                              		$("input[name='address']").val(detailAddr);
                              	}
                              });
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