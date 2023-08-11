<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가게 정보 등록</title>
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
<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=714989160c4bbb672f636a880c6c8328&libraries=services"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/37.0.1/classic/ckeditor.js"></script>

<style>
 @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap'); /*나눔고딕 import*/
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
 #map {
    width:100%;
    height: 40vw;
} 
.title{
   font-weight:bold;
   font-size:25px;
   color:#57b846;
   margin-bottom:20px;
}
.ck-editor__editable_inline {
    min-height: 550px;
}
.input-group{
	margin-bottom:10px;
}
.input-group>span{
	font-size:14px;
}
.input-group>input{
	font-size:14px;
}
.input-group>select{
	font-size:14px;
}
#btn_image_add{
	font-size:12px;
	width:85px;
	height:30px;
	border-radius: 3px;
	border:none;
	background-color:#57b846;
	color:white;
	margin-bottom:10px;
	box-shadow:1px 1px 5px 1px rgb(231, 231, 231);
}
#btn_image_add:hover{
	opacity:80%;
}
#submitBtn{
   font-size:17px;
   width:80px;
   height:35px;
   border-radius: 3px;
   border:none;
   background-color:#57b846;
   color:white;
   margin-top:30px;
   font-weight:500;
   box-shadow:1px 1px 5px 1px rgb(231, 231, 231);
}
#submitBtn:hover{
   opacity:80%;
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
            <form id="addForm" action="/register.store" method="post"  enctype="multipart/form-data">
               <div class="row contents">
               <div class="col-12 col-lg-10 title" style="margin-left:auto; margin-right:auto;">가게 정보 등록
               <hr style="border-style:dotted; color:black;" >
               </div>
                  <div class="col-12 col-lg-4" style="margin-left:auto;">
                     <div class="row">
                        <div class="col-12 content">
                           <div id="map"></div>
                           <div class="mapInfo">
                              <input type="text" name="mapLat" style="display:none;" readonly>
                              <input type="text" name="mapLng" style="display:none;" readonly>
                              <div class="row">
                                 <div class="col-12">
                                    <div class="input-group" style="margin-top:10px;">
                                       <span class="input-group-text">거리(M)</span>
                                       <input type="text" name="mapDistance" class="form-control" readonly>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="col-12 col-lg-6" style="margin-right:auto;">
                     <div class="row">
                        <div class="col-12">
                              <div class="row" style="padding-left:20px; padding-right:20px;">
                                 <div class="col-12">
                                    <div class="input-group">
                                       <span class="input-group-text">가게 이름</span>
                                       <input type="text" class="form-control" name="storeName" placeholder="가게 이름을 입력해주세요">
                                    </div>
                                 </div>
                                 <div class="col-12">
                                    <div class="input-group">
                                       <span class="input-group-text">가게 주소</span>
                                       <input type="text" class="form-control" name="storeAddress" placeholder="가게 주소를 입력해주세요">
                                    </div>
                                 </div>
                                 <div class="col-12">
                                    <div class="input-group">
                                       <span class="input-group-text">가게 카테고리</span>
                                       <select type="text" class="form-select" name="storeCategory">
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
                                 </div>
                                 <div class="col-12">
                                    <div class="input-group">
                                       <span class="input-group-text">1인당 가격범위</span>
                                       <select type="text" class="form-select" name="storePriceRange">
                                          <option>5000이하</option>
                                          <option>5000~10000</option>
                                          <option>10000~15000</option>
                                          <option>15000~20000</option>
                                          <option>20000이상</option>
                                       </select>
                                    </div>
                                 </div>
							
							<div>
                  			<div class="col-12">
                     			<button type="button" id="btn_image_add" class="btn-outline-secondary">이미지 등록</button>
                  				</div>
                  				<div class="col-12">
                        		<!-- 여기에 name이 image0, image1 식의 name으로 file input 추가됨. 보내기 직전 name 태그 붙이기 시작. -->
                        		<div id="img_field"></div>
			                     <!-- <input type="text" name="imgLength" style="display: none;"> -->
                  				</div>
                                 <div class="col-12">
                                    <textarea id="editor" name="storeIntroduction"></textarea>
                                 </div>
                                 <div class="col-12" style="text-align:center;">
                                 	 <button id="submitBtn" class="btn-secondary" type="submit">완료</button>
                                 </div>
                              </div>
                              </div>
                        </div>
                     </div>
                  </div>
               </div>
            </form>

            <script>
               //에디터 관리
               ClassicEditor
                  .create(document.querySelector("#editor"),{
                            toolbar:['heading', '|', 'bold', 'italic', 'bulletedList', 'numberedList','insertTable', 'blockQuote', 'undo', 'redo', ]
                        })
                  .then(function (editor) {
                     const toolbarElement = editor.ui.view.toolbar.element;
                  })
                  .catch(error => { console.error(error) });


                //지도 관리
                let isMapAdded = false;
                let mapContainer = document.getElementById("map");
                let options = {
                    center: new kakao.maps.LatLng(37.567944388923316, 126.98295041529863),
                    level: 3
                };
                let map = new kakao.maps.Map(mapContainer, options);
                let marker = null;
             	// 주소-좌표 변환 객체를 생성합니다
                let geocoder = new kakao.maps.services.Geocoder();
                kakao.maps.event.addListener(map, "click", function (e) {
                   if(marker != null){
                      marker.setMap(null);
                   }
                    if(!isMapAdded){
                        isMapAdded=true;
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

                    let dLat = (37.567944388923316 - lat) * (Math.PI/180);
                    let dLng = (126.98295041529863 - lng) * (Math.PI/180);
                    let a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(37.567944388923316 * (Math.PI/180)) * Math.cos(lat * (Math.PI/180)) * Math.sin(dLng/2) * Math.sin(dLng/2);
                    let c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
                    let d = 6371 * c;
                    $("input[name=mapDistance]").val(Math.round(d * 1000));
                    
                    searchDetailAddrFromCoords(e.latLng, function(result, status){
                    	if(status == kakao.maps.services.Status.OK){
                    		//도로명 주소 있으면 도로명, 없으면 지번 주소 
                    		let detailAddr = !!result[0].road_address ? result[0].road_address.address_name : result[0].address.address_name;
                    		
                    		$("input[name='storeAddress']").val(detailAddr);
                    	}
                    });
                });
                
                function searchDetailAddrFromCoords(coords, callback) {
                    // 좌표로 법정동 상세 주소 정보를 요청합니다
                    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
                }


                //이미지 관리
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

                $("#addForm").submit(function (e) {
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

                    if(!isMapAdded){
                        alert("마커를 설정해주셔야 합니다.");
                        return false;
                    }
                    
                    if(!($("input[name='storeName']").val())){
                    	alert("가게 이름을 입력해주셔야 합니다.");
                    	return false;
                    }else if(!($("input[name='storeAddress']").val())){
                    	alert("가게 주소를 입력해주셔야 합니다.");
                    	return false;
                    }else if(!($("#editor").val())){
                    	alert("가게 설명을 입력해주셔야 합니다.");
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